Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBFF6EA241
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 05:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjDUDPO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Apr 2023 23:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjDUDOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:14:47 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CB0E53;
        Thu, 20 Apr 2023 20:14:35 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4D38824E1B7;
        Fri, 21 Apr 2023 11:14:33 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Apr
 2023 11:14:33 +0800
Received: from localhost.localdomain (113.72.144.253) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Apr
 2023 11:14:32 +0800
From:   Mason Huo <mason.huo@starfivetech.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Shengyu Qu <wiagn233@outlook.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: [PATCH v3 0/3] Add JH7110 cpufreq support
Date:   Fri, 21 Apr 2023 11:14:28 +0800
Message-ID: <20230421031431.23010-1-mason.huo@starfivetech.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The StarFive JH7110 SoC has four RISC-V cores,
and it supports up to 4 cpu frequency loads.

This patchset adds the compatible strings into the allowlist
for supporting the generic cpufreq driver on JH7110 SoC.
Also, it enables the axp15060 pmic for the cpu power source.

The series has been tested on the VisionFive 2 boards which
are equipped with JH7110 SoC and axp15060 pmic.


This patchset is based on v6.3-rc4 with these patches applied:
[1] ("Basic clock, reset & device tree support for StarFive JH7110 RISC-V SoC")
    https://lore.kernel.org/all/20230401111934.130844-1-hal.feng@starfivetech.com/
[2] ("Add X-Powers AXP15060 PMIC support")
    https://lore.kernel.org/all/TY3P286MB2611A814E580C96DC6F187B798969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM/

Changes since v2:
- Fix the new blank line at EOF issue in dtsi.

Changes since v1:
- Fix dts node naming issues.
- Move clock properties of cpu node from <board>.dtsi to <soc>.dtsi.
- Follow the alphabetical order to place the cpufreq dt allowlist.

---
v1: https://lore.kernel.org/all/20230411083257.16155-1-mason.huo@starfivetech.com/
v2: https://lore.kernel.org/lkml/20230417063942.3141-1-mason.huo@starfivetech.com/

Mason Huo (3):
  riscv: dts: starfive: Enable axp15060 pmic for cpufreq
  cpufreq: dt-platdev: Add JH7110 SOC to the allowlist
  riscv: dts: starfive: Add cpu scaling for JH7110 SoC

 .../jh7110-starfive-visionfive-2.dtsi         | 30 +++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 33 +++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |  2 ++
 3 files changed, 65 insertions(+)

base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
-- 
2.39.2

