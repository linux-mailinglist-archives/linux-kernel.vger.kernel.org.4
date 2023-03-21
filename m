Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1596C2819
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCUC0z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 22:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCUC0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:26:52 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D6C28D31;
        Mon, 20 Mar 2023 19:26:50 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9A8D624E211;
        Tue, 21 Mar 2023 10:26:49 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Mar
 2023 10:26:49 +0800
Received: from ubuntu.localdomain (183.27.97.64) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Mar
 2023 10:26:48 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/2] hwmon: Add StarFive JH71X0 temperature sensor
Date:   Tue, 21 Mar 2023 10:26:42 +0800
Message-ID: <20230321022644.107027-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.64]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a driver for the temperature sensor on the JH7100 and JH7110,
RISC-V SoCs by StarFive Technology Co. Ltd.. The JH7100 is used on the
BeagleV Starlight board and StarFive VisionFive board. The JH7110 is
used on the StarFive VisionFive 2 board.

v6:
* Replace SOC_STARFIVE with ARCH_STARFIVE.

v5:
* Drop the "interrupts" property in dt-bindings.
* Reword the commit message of patch 2.
* Use continuous mode instead of single mode and drop the interrupt
  related code used in the single mode.
* Add the missing "default:" statements in the driver.
* Change the device name to "sfctemp" which avoids a warning when startup.

v4:
* Change the node name from "tmon" to "temperature-sensor" in dt-binding
  example, which is more generic.
* Add support for StarFive JH7110 SoC besides JH7100.
* Add clock and reset support in the dt-bindings and driver.
* Add the missing headers in patch 2.
* Use devm_platform_ioremap_resource() to remap instead of
  platform_get_resource() and devm_ioremap_resource().
* Use dev_err_probe() instead of dev_err().
* Add Signed-off-by tag for Hal Feng. Add Co-developed-by tag for
  Samin Guo in patch 2.

v3:
* Handle timeouts from wait_for_completion_interruptible_timeout
  properly.

v2:
* Fix checkpatch.pl --strict warnings
  - Add myself to MAINTAINERS
  - Fix multiline comments
  - Use proper case and whitespace for #defines
  - Add comment to sfctemp::lock mutex.
* Remaining comments by Guenter Roeck
  - Add Documentation/hwmon/sfctemp.rst
  - Use devm_add_action() and devm_hwmon_device_register_with_info()
    instead of a driver .remove function.
  - Don't do test conversion at probe time.
  - #include <linux/io.h>
  - Remove unused #defines
  - Use int return variable in sfctemp_convert().
* Add Samin's Signed-off-by to patch 2/2

---
History:
v5: https://lore.kernel.org/all/20230227134125.120638-1-hal.feng@starfivetech.com/
v4: https://lore.kernel.org/all/20230207072314.62040-1-hal.feng@starfivetech.com/
v3: https://lore.kernel.org/all/20210726171802.1052716-1-kernel@esmil.dk/
v2: https://lore.kernel.org/all/20210624162108.832518-1-esmil@mailme.dk/
v1: https://lore.kernel.org/all/20210616181545.496149-1-kernel@esmil.dk/

Emil Renner Berthing (2):
  dt-bindings: hwmon: Add starfive,jh71x0-temp
  hwmon: (sfctemp) Add StarFive JH71x0 temperature sensor

 .../bindings/hwmon/starfive,jh71x0-temp.yaml  |  70 ++++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/sfctemp.rst               |  33 ++
 MAINTAINERS                                   |   8 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sfctemp.c                       | 331 ++++++++++++++++++
 7 files changed, 454 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
 create mode 100644 Documentation/hwmon/sfctemp.rst
 create mode 100644 drivers/hwmon/sfctemp.c


base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
-- 
2.38.1

