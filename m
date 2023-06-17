Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3217341CE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbjFQPD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjFQPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:03:22 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2278910C0;
        Sat, 17 Jun 2023 08:03:20 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77e2ed26037so12408939f.0;
        Sat, 17 Jun 2023 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687014199; x=1689606199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPKa6UEi+0nARotVDmRtVIJACJBDdNpI7KC0bMf/rmE=;
        b=WXFDHqWAuwhgDQdi8HJrdHNwogFYXhR9ZirthfjZxqkt4q7BB7KPCw2uhFYNlzfxvD
         /yCH4B8dTpXXdu7op4sV8y2lKhaHccrS0O1+LrgpVSuGBu5ApOdcWWSprbx6AiDmEhnj
         ++tXrn3OzAIkUUrONObavE5RNF5VKDVoBuK5fViZowcP/utYuYwWSW1GswOAm7vkC9vv
         8FAkTmh2zoSC0fQCpD8cy9VLD23sa+1LjazmglGmiSFDymnBrAtXmaHXbgHUk5vGGTuw
         lxR1HxvW8vaxtr0zhxTnYnaC5vzhEW/ZQn1YCfun0zphbmntoPxZLW43FqGS8Fclq1/+
         UVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687014199; x=1689606199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPKa6UEi+0nARotVDmRtVIJACJBDdNpI7KC0bMf/rmE=;
        b=fawyBTf4BGHtinAP3iukjKqCjGaASlhQ5FGVkhwgfcoxnj9LMWRmrVBB3hgZR7YTiq
         1L65csZveqt7V9UXR5ouU/8+rCtiX51g8SxJCNgBKrZQegPt1DhaO7UUB+8W+1r6D+om
         mdRP3RfdZWGnrW6GOY9oj75bbesldzDW9LnOFj1hQQdZ8OJ3uBV9JfGO4efUQuudGc4V
         PBWRXRHZ+okR9AZYBL/GuL77G7LN4qjLvijx+g2HWwUMHJjh+zOHNku5tKgNK+I+1YmK
         6VTDnzmZtE+9MYuxFkQtSEBiaRpJ8hKky+wbWJumaaOXdpxk3ticrixLLQv+QqnBUM/J
         r6Ig==
X-Gm-Message-State: AC+VfDy96AJVXgE4HCk44KFRqTpbxmsNfuOyrp2qc4BfghslUY1N4D1T
        Mg48BrhSqGO6F6wY+P7cZRwLJwvTSMwAaA==
X-Google-Smtp-Source: ACHHUZ4s4q1vubd+EHeVD0YyuaLalywYvk2iAigqmfuxwQ3i9pzjI+PQKJO82PBM7DgeJjbJMecyvg==
X-Received: by 2002:a05:6602:2013:b0:77a:e728:f087 with SMTP id y19-20020a056602201300b0077ae728f087mr2083876iod.21.1687014198914;
        Sat, 17 Jun 2023 08:03:18 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:2228:4762:4365:80b2])
        by smtp.gmail.com with ESMTPSA id q3-20020a6b7103000000b0077e24ace3edsm623679iog.52.2023.06.17.08.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 08:03:18 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] clk: renesas: r8a774e1: Add 3dge and ZG support
Date:   Sat, 17 Jun 2023 10:03:02 -0500
Message-Id: <20230617150302.38477-4-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230617150302.38477-1-aford173@gmail.com>
References: <20230617150302.38477-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 3dge and ZG clocks are necessary to support the 3D graphics.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/renesas/r8a774b1-cpg-mssr.c b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
index ab087b02ef90..33d4e5ff9ff6 100644
--- a/drivers/clk/renesas/r8a774b1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
@@ -73,6 +73,7 @@ static const struct cpg_core_clk r8a774b1_core_clks[] __initconst = {
 
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",         R8A774B1_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
+	DEF_GEN3_Z("zg",        R8A774B1_CLK_ZG,    CLK_TYPE_GEN3_ZG, CLK_PLL4, 4, 24),
 	DEF_FIXED("ztr",        R8A774B1_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A774B1_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A774B1_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
@@ -120,6 +121,7 @@ static const struct cpg_core_clk r8a774b1_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a774b1_mod_clks[] __initconst = {
+	DEF_MOD("3dge",			 112,	R8A774B1_CLK_ZG),
 	DEF_MOD("tmu4",			 121,	R8A774B1_CLK_S0D6),
 	DEF_MOD("tmu3",			 122,	R8A774B1_CLK_S3D2),
 	DEF_MOD("tmu2",			 123,	R8A774B1_CLK_S3D2),
-- 
2.39.2

