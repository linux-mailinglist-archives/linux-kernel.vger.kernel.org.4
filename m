Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621BD707DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjERKNK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 May 2023 06:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjERKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:12:44 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA8D1BD3;
        Thu, 18 May 2023 03:12:43 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id CB02924E257;
        Thu, 18 May 2023 18:12:41 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 18 May
 2023 18:12:41 +0800
Received: from localhost.localdomain (113.72.146.100) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 18 May
 2023 18:12:40 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v6 08/11] reset: starfive: jh7110: Add StarFive STG/ISP/VOUT resets support
Date:   Thu, 18 May 2023 18:12:31 +0800
Message-ID: <20230518101234.143748-9-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518101234.143748-1-xingyu.wu@starfivetech.com>
References: <20230518101234.143748-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.100]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
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

Add new struct members and auxiliary_device_id of resets to support
System-Top-Group, Image-Signal-Process and Video-Output on the StarFive
JH7110 SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../reset/starfive/reset-starfive-jh7110.c    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
index 2d26ae95c8cc..29a43f0f2ad6 100644
--- a/drivers/reset/starfive/reset-starfive-jh7110.c
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -31,6 +31,24 @@ static const struct jh7110_reset_info jh7110_aon_info = {
 	.status_offset = 0x3C,
 };
 
+static const struct jh7110_reset_info jh7110_stg_info = {
+	.nr_resets = JH7110_STGRST_END,
+	.assert_offset = 0x74,
+	.status_offset = 0x78,
+};
+
+static const struct jh7110_reset_info jh7110_isp_info = {
+	.nr_resets = JH7110_ISPRST_END,
+	.assert_offset = 0x38,
+	.status_offset = 0x3C,
+};
+
+static const struct jh7110_reset_info jh7110_vout_info = {
+	.nr_resets = JH7110_VOUTRST_END,
+	.assert_offset = 0x48,
+	.status_offset = 0x4C,
+};
+
 static int jh7110_reset_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
@@ -58,6 +76,18 @@ static const struct auxiliary_device_id jh7110_reset_ids[] = {
 		.name = "clk_starfive_jh7110_sys.rst-aon",
 		.driver_data = (kernel_ulong_t)&jh7110_aon_info,
 	},
+	{
+		.name = "clk_starfive_jh7110_sys.rst-stg",
+		.driver_data = (kernel_ulong_t)&jh7110_stg_info,
+	},
+	{
+		.name = "clk_starfive_jh7110_sys.rst-isp",
+		.driver_data = (kernel_ulong_t)&jh7110_isp_info,
+	},
+	{
+		.name = "clk_starfive_jh7110_sys.rst-vo",
+		.driver_data = (kernel_ulong_t)&jh7110_vout_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(auxiliary, jh7110_reset_ids);
-- 
2.25.1

