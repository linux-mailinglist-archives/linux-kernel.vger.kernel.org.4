Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D4B653833
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiLUV10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUV1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:27:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C8F24081;
        Wed, 21 Dec 2022 13:27:22 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h7so16226162wrs.6;
        Wed, 21 Dec 2022 13:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zmmT5hUEnO3YazAV+S9BqS9lPQTzWcusR7HN4o+fWk=;
        b=Wd5DoTpz0Fo5tZAlJQhUqNUno8iKGOVHsHfJHuvKc+SYB4XsH2sPDlKhiBweug0Kvx
         z+xs66VZA8FLuxDmEqxg0j1TBLu1kWjyFINRtp7Jg6LKRPricB42JiG03/Cx1jJo0f06
         p+CgGH64g738kMUP7izzPmeZi77kiQw/HX+TsVv/APBF8JyW+Cwu0D7u+SPnUgh8MsAi
         AqeRGvRhcRyUbt9HWTzXAYihIzSMJUXyfpF6/SDH8cEuPhPRjkYTn29J5qbIYkZekdvm
         4XgHf87egoQBI0iZBu1E2ShdicriOa3gB6PAMb4A0lTt4RhYEtGNgzG9D1QybX6FXjx/
         J4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zmmT5hUEnO3YazAV+S9BqS9lPQTzWcusR7HN4o+fWk=;
        b=egAIgD1u6w9qsaOgRnAtsXL7xUw7lJ5kMKmH/AKMfs17F/f1oCGbNp5FZIFRm6ovWS
         bNnjlwFXrzjqaGnUYVDS9lvqoFCLcglgrMcLx7kGNMVhRbUm3gLWm2FMD4+77MS097y2
         w7zhUGQ97DjQ/KucAf/6Qm+dw8LKn2C2GkOJbXI1RbhvV9/QbKQ5H9Pecp/GhTX2Xgxc
         C4uqcmmy0DAuOYrFlA17+akvXj27s3z13fCF/6oFuEd6UaAd9dMZ7lLeBppgcqz97pJQ
         5GJ8+nYjuC6F+KoNsf2VniFLuNIlAJVECtkY1V1nipnCKbiNyNn6Re/2P4y2o4+2/CKZ
         b/zg==
X-Gm-Message-State: AFqh2kq1jjcGjS+D5AysXxHTk0qVtMu5cHS/F7IDTF1uGnMMZ8mmv1tO
        tX+PkZfB1aDv7itboMxF0vpXa9PylT6JZQ==
X-Google-Smtp-Source: AMrXdXvYzrwIHgsVAWninWjMasl/s+mUYdtgmo6Fhy1U6+5Q0POGtpHfJ+gZBf7VEtZj/uBNCXMZ4g==
X-Received: by 2002:a5d:4d50:0:b0:242:7fdb:923b with SMTP id a16-20020a5d4d50000000b002427fdb923bmr1927864wru.59.1671658040405;
        Wed, 21 Dec 2022 13:27:20 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1595:a48c:95a8:15e0])
        by smtp.gmail.com with ESMTPSA id bo28-20020a056000069c00b002415dd45320sm16524761wrb.112.2022.12.21.13.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 13:27:19 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] clk: renesas: r9a07g044: Add clock and reset entries for CRU
Date:   Wed, 21 Dec 2022 21:27:03 +0000
Message-Id: <20221221212703.348278-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add CRU clock and reset entries to CPG driver.

CRU_SYSCLK and CRU_VCLK clocks need to be turned ON/OFF in particular
sequence for the CRU block hence add these clocks to
r9a07g044_no_pm_mod_clks[] array and pass it as part of CPG data for
both RZ/G2L and RZ/V2L SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index f5550fccb029..c597414a94d8 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -182,7 +182,7 @@ static const struct {
 };
 
 static const struct {
-	struct rzg2l_mod_clk common[75];
+	struct rzg2l_mod_clk common[79];
 #ifdef CONFIG_CLK_R9A07G054
 	struct rzg2l_mod_clk drp[0];
 #endif
@@ -250,6 +250,14 @@ static const struct {
 					0x558, 1),
 		DEF_MOD("gpu_ace_clk",	R9A07G044_GPU_ACE_CLK, R9A07G044_CLK_P1,
 					0x558, 2),
+		DEF_MOD("cru_sysclk",   R9A07G044_CRU_SYSCLK, CLK_M2_DIV2,
+					0x564, 0),
+		DEF_MOD("cru_vclk",     R9A07G044_CRU_VCLK, R9A07G044_CLK_M2,
+					0x564, 1),
+		DEF_MOD("cru_pclk",     R9A07G044_CRU_PCLK, R9A07G044_CLK_ZT,
+					0x564, 2),
+		DEF_MOD("cru_aclk",     R9A07G044_CRU_ACLK, R9A07G044_CLK_M0,
+					0x564, 3),
 		DEF_MOD("dsi_pll_clk",	R9A07G044_MIPI_DSI_PLLCLK, R9A07G044_CLK_M1,
 					0x568, 0),
 		DEF_MOD("dsi_sys_clk",	R9A07G044_MIPI_DSI_SYSCLK, CLK_M2_DIV2,
@@ -368,6 +376,9 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_GPU_RESETN, 0x858, 0),
 	DEF_RST(R9A07G044_GPU_AXI_RESETN, 0x858, 1),
 	DEF_RST(R9A07G044_GPU_ACE_RESETN, 0x858, 2),
+	DEF_RST(R9A07G044_CRU_CMN_RSTB, 0x864, 0),
+	DEF_RST(R9A07G044_CRU_PRESETN, 0x864, 1),
+	DEF_RST(R9A07G044_CRU_ARESETN, 0x864, 2),
 	DEF_RST(R9A07G044_MIPI_DSI_CMN_RSTB, 0x868, 0),
 	DEF_RST(R9A07G044_MIPI_DSI_ARESET_N, 0x868, 1),
 	DEF_RST(R9A07G044_MIPI_DSI_PRESET_N, 0x868, 2),
@@ -412,6 +423,11 @@ static const unsigned int r9a07g044_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A07G044_DMAC_ACLK,
 };
 
+static const unsigned int r9a07g044_no_pm_mod_clks[] = {
+	MOD_CLK_BASE + R9A07G044_CRU_SYSCLK,
+	MOD_CLK_BASE + R9A07G044_CRU_VCLK,
+};
+
 #ifdef CONFIG_CLK_R9A07G044
 const struct rzg2l_cpg_info r9a07g044_cpg_info = {
 	/* Core Clocks */
@@ -429,6 +445,10 @@ const struct rzg2l_cpg_info r9a07g044_cpg_info = {
 	.num_mod_clks = ARRAY_SIZE(mod_clks.common),
 	.num_hw_mod_clks = R9A07G044_TSU_PCLK + 1,
 
+	/* No PM Module Clocks */
+	.no_pm_mod_clks = r9a07g044_no_pm_mod_clks,
+	.num_no_pm_mod_clks = ARRAY_SIZE(r9a07g044_no_pm_mod_clks),
+
 	/* Resets */
 	.resets = r9a07g044_resets,
 	.num_resets = R9A07G044_TSU_PRESETN + 1, /* Last reset ID + 1 */
@@ -454,6 +474,10 @@ const struct rzg2l_cpg_info r9a07g054_cpg_info = {
 	.num_mod_clks = ARRAY_SIZE(mod_clks.common) + ARRAY_SIZE(mod_clks.drp),
 	.num_hw_mod_clks = R9A07G054_STPAI_ACLK_DRP + 1,
 
+	/* No PM Module Clocks */
+	.no_pm_mod_clks = r9a07g044_no_pm_mod_clks,
+	.num_no_pm_mod_clks = ARRAY_SIZE(r9a07g044_no_pm_mod_clks),
+
 	/* Resets */
 	.resets = r9a07g044_resets,
 	.num_resets = R9A07G054_STPAI_ARESETN + 1, /* Last reset ID + 1 */
-- 
2.25.1

