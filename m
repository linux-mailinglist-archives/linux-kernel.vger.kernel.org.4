Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248BB723E9F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbjFFJ6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjFFJ61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:58:27 -0400
X-Greylist: delayed 623 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 02:58:16 PDT
Received: from mail.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D1C10D2;
        Tue,  6 Jun 2023 02:58:15 -0700 (PDT)
Received: from BillyTsai-pc.aspeed.com (192.168.1.221) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Jun
 2023 17:43:41 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <billy_tsai@aspeedtech.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patrick@stwcx.xyz>
Subject: [v5 0/5] Support pwm/tach driver for aspeed ast26xx
Date:   Tue, 6 Jun 2023 17:45:30 +0800
Message-ID: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.1.221]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the old design that the register setting of the TACH should based
on the configure of the PWM. In ast26xx, the dependency between pwm and
tach controller is eliminated and becomes a separate hardware block. One
is used to provide pwm output and another is used to monitor the frequency
of the input. Therefore, this patch serials implements them by writing the
two driver "pwm-aspeed-ast2600.c" and "tach-aspeed-ast2600.c". The former
is following the pwm subsystem which can apply the existed driver to
controller the fan(pwm-fan.c), beeper(pwm-beeper.c) and so on. The latter
is following the sysfs interface of hwmon to creat the node for fan
monitor.

Changes since v4:
- pwm:
  - Fix the return type of get_status function.
- tach:
  - read clk source once and re-use it
  - Remove the constants variables
  - Allocate tach_channel as array
  - Use dev->parent
- dt-binding:
  - Fix the order of the patches
  - Add example and description for tach child node
  - Remove pwm extension property

Changes since v3:
- pwm:
  - Remove unnecessary include header
  - Fix warning Prefer "GPL" over "GPL v2"
- tach:
  - Remove the paremeter min_rpm and max_rpm and return the tach value 
  directly without any polling or delay.
  - Fix warning Prefer "GPL" over "GPL v2"
- dt-binding:
  - Replace underscore in node names with dashes
  - Split per subsystem

Changes since v2:
- pwm:
  - Use devm_* api to simplify the error cleanup
  - Fix the multi-line alignment problem
- tach:
  - Add tach-aspeed-ast2600 to index.rst
  - Fix the multi-line alignment problem
  - Remove the tach enable/disable when read the rpm
  - Fix some coding format issue

Changes since v1:
- tach:
  - Add the document tach-aspeed-ast2600.rst
  - Use devm_* api to simplify the error cleanup.
  - Change hwmon register api to devm_hwmon_device_register_with_info

Billy Tsai (5):
  dt-bindings: pwm: Add bindings for aspeed pwm controller
  dt-bindings: hwmon: Add bindings for aspeed tach controller
  dt-bindings: mfd: Add aspeed pwm-tach binding
  pwm: Add Aspeed ast2600 PWM support
  hwmon: Add Aspeed ast2600 TACH support

 .../bindings/hwmon/aspeed,ast2600-tach.yaml   |  40 ++
 .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml |  76 ++++
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      |  32 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/tach-aspeed-ast2600.rst   |  25 ++
 drivers/hwmon/Kconfig                         |   9 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/tach-aspeed-ast2600.c           | 367 ++++++++++++++++++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-aspeed-ast2600.c              | 319 +++++++++++++++
 11 files changed, 881 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
 create mode 100644 Documentation/hwmon/tach-aspeed-ast2600.rst
 create mode 100644 drivers/hwmon/tach-aspeed-ast2600.c
 create mode 100644 drivers/pwm/pwm-aspeed-ast2600.c

-- 
2.25.1

