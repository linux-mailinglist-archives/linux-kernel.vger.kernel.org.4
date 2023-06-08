Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CC37274C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjFHCQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFHCQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:16:28 -0400
Received: from mail.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B471984;
        Wed,  7 Jun 2023 19:16:25 -0700 (PDT)
Received: from BillyTsai-pc.aspeed.com (192.168.1.221) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Jun
 2023 10:16:21 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <billy_tsai@aspeedtech.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patrick@stwcx.xyz>
Subject: [v6 0/4] Support pwm/tach driver for aspeed ast26xx
Date:   Thu, 8 Jun 2023 10:18:35 +0800
Message-ID: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
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

Changes since v5:
- pwm/tach:
  - Remove the utilization of common resources from the parent node.
  - Change the concept to 16 PWM/TACH controllers, each with one channel,
  instead of 1 PWM/TACH controller with 16 channels.
- dt-binding:
  - Eliminate the usage of simple-mfd.

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

Billy Tsai (4):
  dt-bindings: pwm: Add ASPEED PWM Control documentation
  dt-bindings: hwmon: Add ASPEED TACH Control documentation
  pwm: Add Aspeed ast2600 PWM support
  hwmon: Add Aspeed ast2600 TACH support

 .../bindings/hwmon/aspeed,ast2600-tach.yaml   |  32 ++
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      |  38 +++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/tach-aspeed-ast2600.rst   |  25 ++
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/tach-aspeed-ast2600.c           | 305 +++++++++++++++++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-aspeed-ast2600.c              | 309 ++++++++++++++++++
 10 files changed, 732 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
 create mode 100644 Documentation/hwmon/tach-aspeed-ast2600.rst
 create mode 100644 drivers/hwmon/tach-aspeed-ast2600.c
 create mode 100644 drivers/pwm/pwm-aspeed-ast2600.c

-- 
2.25.1

