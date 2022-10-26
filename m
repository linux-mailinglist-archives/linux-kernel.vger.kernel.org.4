Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C71760D8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiJZBmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiJZBmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:42:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A91DDA31;
        Tue, 25 Oct 2022 18:42:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bp11so23424428wrb.9;
        Tue, 25 Oct 2022 18:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1/Z+bzCI9wjYKSK20rnTwDEGDaX79Rtyi9JzBJPbm0=;
        b=mAHlfJ9Guh2YsP1komhXJAkwwQmdr7O1L3+uDTme/wyogeFHW9Js1IuCBzYeZ+80y3
         9eeklVyYaknONCB1JHlK7w+t+tbQisp0coMTJRUD4g4MhAH4DDp8oFLUh3W1HpPgtmSB
         CNzZNf45haMvswfvWH58TItRXEhSTwNcwhctr80tc6W4tvVbyFCPnJ6oD2rvwC4e2MQg
         8iN397FY/c1ZcHkxn5QQvKgEDIyiCulSxGiTnjG2tzfoSOF48/83YsuUrtUaNSAmVODd
         HvVDBMUzVcViuL0xVbLUZGevbn+zTG+mSt2ty7iJo7sEviA86OwPc1tKbYx5praa2ePI
         nVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1/Z+bzCI9wjYKSK20rnTwDEGDaX79Rtyi9JzBJPbm0=;
        b=sIMbDLrKxi95ei/mlzPp66J1+vRy+Sec2zL1jSGwJlVtmHdkWu6uQC5clqa+OVDV/R
         Tw1Um5r3Xhyk4U/BqWUwb4j/QE21KdCI4B1ckPNfQzY4KefztzwuXEBQjv7lEPkeNf8Y
         sL1AQ7pegeOUu0xsvCd4RSMwecz24JfLCBRvFdQSEMv9XZtXidVwtXhPWMG07Mxxas1W
         eoBrWkHPndR5UtbgvUCo6UYEO7I3yFLYLEQBNMqNGA8kCjZRXa2gSHyd49TB7m9NgmWA
         6x9V78GCcgjY0whu50Cjbr0orukj+XSPqDoFrB7A0hR+v/3K1pLp01UrUA7skeEeBbQq
         R2pg==
X-Gm-Message-State: ACrzQf1agZEqBoqLfxfxlwRgpoSuEf9oamn7ibV98aPBpdTGngg9vSU/
        eEEEcdzmS+F296L3jqAR8ozXsmOdT4FuMolS
X-Google-Smtp-Source: AMsMyM4KM8+DoBKREl6JDpQMRv0uaqwGTNvjAJq0TeZE+Bfhr4NRr9VssmKk7aIu7B345f7JkocVzQ==
X-Received: by 2002:a05:6000:15c8:b0:236:812d:d3e5 with SMTP id y8-20020a05600015c800b00236812dd3e5mr3878070wry.303.1666748560438;
        Tue, 25 Oct 2022 18:42:40 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:1d2a:d2a2:361e:a475])
        by smtp.gmail.com with ESMTPSA id x12-20020adff0cc000000b00236733f0f98sm3688956wro.107.2022.10.25.18.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 18:42:39 -0700 (PDT)
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
Subject: [PATCH v2 2/2] clk: renesas: r9a07g044: Add CRU_SYSCLK and CRU_VCLK to no PM list
Date:   Wed, 26 Oct 2022 02:42:27 +0100
Message-Id: <20221026014227.162121-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026014227.162121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221026014227.162121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

CRU_SYSCLK and CRU_VCLK clocks need to be turned ON/OFF in particular
sequence for the CRU block hence add these clocks to
r9a07g044_no_pm_mod_clks[] array.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Dropped usage of DEF_NO_PM() macro
* Added CRU_SYSCLK and CRU_VCLK to no PM list
* Updated commit message

RFC->v1
* No change
---
 drivers/clk/renesas/r9a07g044-cpg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index f5550fccb029..f923b7b3cfca 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -412,6 +412,11 @@ static const unsigned int r9a07g044_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A07G044_DMAC_ACLK,
 };
 
+static const unsigned int r9a07g044_no_pm_mod_clks[] __initconst = {
+	MOD_CLK_BASE + R9A07G044_CRU_SYSCLK,
+	MOD_CLK_BASE + R9A07G044_CRU_VCLK,
+};
+
 #ifdef CONFIG_CLK_R9A07G044
 const struct rzg2l_cpg_info r9a07g044_cpg_info = {
 	/* Core Clocks */
@@ -429,6 +434,10 @@ const struct rzg2l_cpg_info r9a07g044_cpg_info = {
 	.num_mod_clks = ARRAY_SIZE(mod_clks.common),
 	.num_hw_mod_clks = R9A07G044_TSU_PCLK + 1,
 
+	/* No PM Module Clocks */
+	.no_pm_mod_clks = r9a07g044_no_pm_mod_clks,
+	.num_no_pm_mod_clks = ARRAY_SIZE(r9a07g044_no_pm_mod_clks),
+
 	/* Resets */
 	.resets = r9a07g044_resets,
 	.num_resets = R9A07G044_TSU_PRESETN + 1, /* Last reset ID + 1 */
@@ -454,6 +463,10 @@ const struct rzg2l_cpg_info r9a07g054_cpg_info = {
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

