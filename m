Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA54724050
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbjFFK6O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Jun 2023 06:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbjFFK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:57:16 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5868E5D;
        Tue,  6 Jun 2023 03:57:00 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id DCC6B80B6;
        Tue,  6 Jun 2023 18:56:57 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Jun
 2023 18:56:58 +0800
Received: from localhost.localdomain (183.27.98.75) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 6 Jun
 2023 18:56:56 +0800
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
Subject: [PATCH v4 0/3] Add JH7110 cpufreq support
Date:   Tue, 6 Jun 2023 18:56:53 +0800
Message-ID: <20230606105656.124355-1-mason.huo@starfivetech.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.75]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
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

---
This patchset is based on v6.4-rc4 with these patches applied:
[1] ("regulator: Add X-Powers AXP15060/AXP313a PMIC support")
    https://lore.kernel.org/lkml/20230524000012.15028-1-andre.przywara@arm.com/

Changes since v3:
- Fix the dtb_check issues for axp15060 pmic dts configuration.

Changes since v2:
- Fix the new blank line at EOF issue in dtsi.

Changes since v1:
- Fix dts node naming issues.
- Move clock properties of cpu node from <board>.dtsi to <soc>.dtsi.
- Follow the alphabetical order to place the cpufreq dt allowlist.

Mason Huo (3):
  riscv: dts: starfive: Enable axp15060 pmic for cpufreq
  cpufreq: dt-platdev: Add JH7110 SOC to the allowlist
  riscv: dts: starfive: Add cpu scaling for JH7110 SoC

 .../jh7110-starfive-visionfive-2.dtsi         | 33 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 33 +++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |  2 ++
 3 files changed, 68 insertions(+)

-- 
2.39.2

