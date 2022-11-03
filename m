Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD8C618A07
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiKCU4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiKCUz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:55:56 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C4C20F66
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=ZIsxFHujLlY59v
        14nd1/go7NFo8ITL4grttW9boU+P0=; b=rvYUVJHhBvBABJeLNcU2iXlOnR7lLF
        j3WYwhgX/hOOkVWmKBq6gizIoU4CZAb9KfrL5vNMZSJCsGoMzFcwyGdz26iZCY89
        oWKkV21MYYBxFdR8nANc+N5hbryLytuWiRG3CMu/0oeoW2WufFMM/+tByF+etrCX
        qqyymmEqelzLg=
Received: (qmail 2787695 invoked from network); 3 Nov 2022 21:55:51 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2022 21:55:51 +0100
X-UD-Smtp-Session: l3s3148p1@eJq5LpfsvOUujns0
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] clk: renesas: r8a779g0: Add TMU and SASYNCRT clocks
Date:   Thu,  3 Nov 2022 21:55:42 +0100
Message-Id: <20221103205546.24836-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221103205546.24836-1-wsa+renesas@sang-engineering.com>
References: <20221103205546.24836-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index 5cc0dc9149bc..7f0b4f75ff4d 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -130,6 +130,7 @@ static const struct cpg_core_clk r8a779g0_core_clks[] __initconst = {
 	DEF_FIXED("s0d4_hsc",	R8A779G0_CLK_S0D4_HSC,	CLK_S0_HSC,	4, 1),
 	DEF_FIXED("cl16m_hsc",	R8A779G0_CLK_CL16M_HSC,	CLK_S0_HSC,	48, 1),
 	DEF_FIXED("s0d2_cc",	R8A779G0_CLK_S0D2_CC,	CLK_S0,		2, 1),
+	DEF_FIXED("sasyncrt",	R8A779G0_CLK_SASYNCRT,	CLK_PLL5_DIV4,	48, 1),
 	DEF_FIXED("sasyncperd1",R8A779G0_CLK_SASYNCPERD1, CLK_SASYNCPER,1, 1),
 	DEF_FIXED("sasyncperd2",R8A779G0_CLK_SASYNCPERD2, CLK_SASYNCPER,2, 1),
 	DEF_FIXED("sasyncperd4",R8A779G0_CLK_SASYNCPERD4, CLK_SASYNCPER,4, 1),
@@ -185,6 +186,11 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("sdhi",		706,	R8A779G0_CLK_SD0),
 	DEF_MOD("sydm0",	709,	R8A779G0_CLK_S0D6_PER),
 	DEF_MOD("sydm1",	710,	R8A779G0_CLK_S0D6_PER),
+	DEF_MOD("tmu0",		713,	R8A779G0_CLK_SASYNCRT),
+	DEF_MOD("tmu1",		714,	R8A779G0_CLK_SASYNCPERD2),
+	DEF_MOD("tmu2",		715,	R8A779G0_CLK_SASYNCPERD2),
+	DEF_MOD("tmu3",		716,	R8A779G0_CLK_SASYNCPERD2),
+	DEF_MOD("tmu4",		717,	R8A779G0_CLK_SASYNCPERD2),
 	DEF_MOD("tpu0",		718,	R8A779G0_CLK_SASYNCPERD4),
 	DEF_MOD("wdt1:wdt0",	907,	R8A779G0_CLK_R),
 	DEF_MOD("pfc0",		915,	R8A779G0_CLK_CL16M),
-- 
2.35.1

