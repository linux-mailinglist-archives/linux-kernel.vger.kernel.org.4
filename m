Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CE36C1413
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjCTNzQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjCTNyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:54:53 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48632F979;
        Mon, 20 Mar 2023 06:54:38 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3CBBA24E06F;
        Mon, 20 Mar 2023 21:54:35 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 21:54:35 +0800
Received: from localhost.localdomain (183.27.97.64) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 21:54:34 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
Subject: [PATCH v2 0/3] Add timer driver for StarFive JH7110 RISC-V SoC
Date:   Mon, 20 Mar 2023 21:54:30 +0800
Message-ID: <20230320135433.144832-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.64]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serises are to add timer driver for the StarFive JH7110
RISC-V SoC. The first patch adds documentation to describe device
tree bindings. The subsequent patch adds timer driver and support
JH7110 SoC. The last patch adds device node about timer to JH7110
dts.

This timer has four free-running 32 bit counters in StarFive JH7110
SoC. And each channel(counter) triggers an interrupt when timeout.
They support one-shot mode and continuous-run mode.

The last patch should be applied after the patchset [1]:
[1] https://lore.kernel.org/all/20230311090733.56918-1-hal.feng@starfivetech.com/

Changes since v1:
- Added description about timer and modified properties' description
  in dt-bindings.
- Dropped the 'interrupt-names' and 'clock-frequency' in dt-bindings.
- Renamed the functions and added 'starfive_'
- Modified that the driver probe by platform bus.

v1 https://lore.kernel.org/all/20221223094801.181315-1-xingyu.wu@starfivetech.com/

Xingyu Wu (3):
  dt-bindings: timer: Add timer for StarFive JH7110 SoC
  clocksource: Add StarFive timer driver
  riscv: dts: jh7110: starfive: Add timer node

 .../bindings/timer/starfive,jh7110-timer.yaml |  95 +++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  20 +
 drivers/clocksource/Kconfig                   |  12 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-starfive.c          | 390 ++++++++++++++++++
 drivers/clocksource/timer-starfive.h          |  96 +++++
 7 files changed, 621 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
 create mode 100644 drivers/clocksource/timer-starfive.c
 create mode 100644 drivers/clocksource/timer-starfive.h


base-commit: 8ca09d5fa3549d142c2080a72a4c70ce389163cd
prerequisite-patch-id: ebaead89601acf604e83224f4df8d57a7f4331b8
prerequisite-patch-id: 609d5d7c55b0b8e2967966673dab8f62a6fceab9
prerequisite-patch-id: ac150a8c622e858e088df8121093d448df49c245
prerequisite-patch-id: a4255724d4698f1238663443024de56de38d717b
prerequisite-patch-id: 89f049f951e5acf75aab92541992f816fd0acc0d
prerequisite-patch-id: dfb8d5a1fb262127d7a8e1ef3e97f455aaa19509
prerequisite-patch-id: 11b0f5746bbfbf8aa5c5746dcd7b0dce62e7f922
prerequisite-patch-id: 315303931e4b6499de7127a88113763f86e97e16
prerequisite-patch-id: 40cb8212ddb024c20593f73d8b87d9894877e172
prerequisite-patch-id: a1673a9e9f19d6fab5a51abb721e54e36636f067
prerequisite-patch-id: 189a0f41ba4eecd4f3f35c503baac8aed8ccd7de
prerequisite-patch-id: 1117ecaa40a353c667b71802ab34ecf9568d8bb2
prerequisite-patch-id: 25923a0c77e92631ed3cd8a163d789daad35f0f8
prerequisite-patch-id: 6a6f6215f09932e68fdfd294df2e813ec9d2481f
prerequisite-patch-id: 2cc95b47cad25fd9b875d27f4e8e3d84eb70274b
prerequisite-patch-id: 258ea5f9b8bf41b6981345dcc81795f25865d38f
prerequisite-patch-id: 8b6f2c9660c0ac0ee4e73e4c21aca8e6b75e81b9
prerequisite-patch-id: dbb0c0151b8bdf093e6ce79fd2fe3f60791a6e0b
prerequisite-patch-id: e7773c977a7b37692e9792b21cc4f17fa58f9215
prerequisite-patch-id: d57e95d31686772abc4c4d5aa1cadc344dc293cd
prerequisite-patch-id: 0a0ac5a8a90655b415f6b62e324f3db083cdaaee
-- 
2.25.1

