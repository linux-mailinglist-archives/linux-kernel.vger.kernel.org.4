Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D33B69DC03
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjBUIdm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Feb 2023 03:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjBUIdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:33:40 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22F483DF;
        Tue, 21 Feb 2023 00:33:32 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 92A9124E208;
        Tue, 21 Feb 2023 16:33:31 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 16:33:31 +0800
Received: from localhost.localdomain (183.27.98.67) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 16:33:30 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 02/11] reset: starfive: jh7110: Add StarFive System-Top-Group reset support
Date:   Tue, 21 Feb 2023 16:33:14 +0800
Message-ID: <20230221083323.302471-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.67]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add auxiliary_device_id to support StarFive JH7110 System-Top-Group resets
of which the auxiliary device name is "clk_starfive_jh71x0.reset-stg".

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 drivers/reset/starfive/reset-starfive-jh7110.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
index 83577d1b7fc6..94ebb363c6bc 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -40,6 +40,12 @@ static const struct reset_info jh7110_aon_info = {
 	.status_offset = 0x3C,
 };
 
+static const struct reset_info jh7110_stg_info = {
+	.nr_resets = JH7110_STGRST_END,
+	.assert_offset = 0x74,
+	.status_offset = 0x78,
+};
+
 static const struct auxiliary_device_id jh7110_reset_ids[] = {
 	{
 		.name = "clk_starfive_jh71x0.reset-sys",
@@ -49,6 +55,10 @@ static const struct auxiliary_device_id jh7110_reset_ids[] = {
 		.name = "clk_starfive_jh71x0.reset-aon",
 		.driver_data = (kernel_ulong_t)&jh7110_aon_info,
 	},
+	{
+		.name = "clk_starfive_jh71x0.reset-stg",
+		.driver_data = (kernel_ulong_t)&jh7110_stg_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(auxiliary, jh7110_reset_ids);
-- 
2.25.1

