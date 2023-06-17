Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBC87341C5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjFQPDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQPDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:03:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637FF10C0;
        Sat, 17 Jun 2023 08:03:15 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77807e43b7cso76908339f.1;
        Sat, 17 Jun 2023 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687014194; x=1689606194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iaDvkdYLQBtU/nADrwFwUGWyyN8uC5RTkbYxexq0IeI=;
        b=fR1N25DL0u6zn3KOdbj+1ntoMUmc5NpTNMD3NvIMCMTV+vxQJtENhBvXTK26Yr85YO
         QufWc0djtwWXgdGxbfxBgBHE6jdI1DWP9QanT46IoCfvUEyl0XM9OuCAHVGCQUFKL2L3
         e0rfwUdlNfrX8Dx2332UwJVJSM2b3hOSmmqcOVF980mCSn1/nAMkdrTSFpwev236YahW
         d9Ysj1z8rQXi9/4tucroCz28a9Y1dykmTcj84kkHdFL0qQgqz6htDhDKRQJn5/+CGjRP
         ss6xcu6axQcky6L1B9BHkQLldhV6qrkLMJohgexgs677XN71qTe8v1fPsApn00Pm+GwH
         Z7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687014194; x=1689606194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaDvkdYLQBtU/nADrwFwUGWyyN8uC5RTkbYxexq0IeI=;
        b=OaiGiFlntpYNNytAABlo8H7kpBG6SOXVUMyPRCT3MZHtYUaaQ3Z2JWBjuv5pqoUDCP
         D6qe5+D2tfDFfzPJObMPXP5LPWmxpvSbSkEqpiIQyWz/pxxpO/XkpIoMTfQ73J/ozT1O
         fukcjTjr/CE/uMfv4Ft4PGGgNN3uH3uGaghH1X3bWdMoqNozP8K6hPnSdEUuiTV3WrCm
         ZHDa3wUC2o4Ivy5IzWzVrj5QK++iHO+U+cRiv7gjTodv2IO2FdbFJ/YANZA9UuBJkK2V
         qv1Uq4GU3wP68Xri+ud3Moe66pfTUuehBBKGgprgqDgT3Q13SUnvbzRG1lt0nlvVZR2c
         DSHg==
X-Gm-Message-State: AC+VfDzy7qNq3w1u4FlmZIF8D1RqmvVrX5dAZ3i0Ijryb/3yWarFhKN8
        iUhYqpvANz1WoLGa7Nd1HsCT29ZlSXKmtg==
X-Google-Smtp-Source: ACHHUZ6DPe1105ctDF487mWMBeMRSPob9WGtneZTUuEJx8lRtpwU+sAFrq6bvLYvjlnG10uokSEcHA==
X-Received: by 2002:a5e:da09:0:b0:774:8d99:184c with SMTP id x9-20020a5eda09000000b007748d99184cmr3337001ioj.11.1687014194261;
        Sat, 17 Jun 2023 08:03:14 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:2228:4762:4365:80b2])
        by smtp.gmail.com with ESMTPSA id q3-20020a6b7103000000b0077e24ace3edsm623679iog.52.2023.06.17.08.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 08:03:13 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] clk: renesas: rcar-gen3: Add support for ZG clock
Date:   Sat, 17 Jun 2023 10:02:59 -0500
Message-Id: <20230617150302.38477-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A clock used for the 3D graphics appears to be common
among multiple SoC's, so add a generic gen3 clock
for clocking the graphics.  This is similar to the
cpg_z_clk, with a different frequency control register
and different flags.  Instead of duplicating the code,
make cpg_z_clk_register into a helper function and
call the help function with the FCR and flags as
a parameter.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index b3ef62fa612e..d0129a650941 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -264,11 +264,13 @@ static const struct clk_ops cpg_z_clk_ops = {
 	.set_rate = cpg_z_clk_set_rate,
 };
 
-static struct clk * __init cpg_z_clk_register(const char *name,
+static struct clk * __init __cpg_z_clk_register(const char *name,
 					      const char *parent_name,
 					      void __iomem *reg,
 					      unsigned int div,
-					      unsigned int offset)
+					      unsigned int offset,
+					      unsigned int fcr,
+					      unsigned int flags)
 {
 	struct clk_init_data init = {};
 	struct cpg_z_clk *zclk;
@@ -280,11 +282,11 @@ static struct clk * __init cpg_z_clk_register(const char *name,
 
 	init.name = name;
 	init.ops = &cpg_z_clk_ops;
-	init.flags = CLK_SET_RATE_PARENT;
+	init.flags = flags;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
-	zclk->reg = reg + CPG_FRQCRC;
+	zclk->reg = reg + fcr;
 	zclk->kick_reg = reg + CPG_FRQCRB;
 	zclk->hw.init = &init;
 	zclk->mask = GENMASK(offset + 4, offset);
@@ -301,6 +303,27 @@ static struct clk * __init cpg_z_clk_register(const char *name,
 	return clk;
 }
 
+static struct clk * __init cpg_z_clk_register(const char *name,
+					      const char *parent_name,
+					      void __iomem *reg,
+					      unsigned int div,
+					      unsigned int offset)
+{
+	return __cpg_z_clk_register(name, parent_name, reg, div, offset,
+				    CPG_FRQCRC, CLK_SET_RATE_PARENT);
+}
+
+static struct clk * __init cpg_zg_clk_register(const char *name,
+					       const char *parent_name,
+					       void __iomem *reg,
+					       unsigned int div,
+					       unsigned int offset)
+{
+	return __cpg_z_clk_register(name, parent_name, reg, div, offset,
+				    CPG_FRQCRB, 0);
+
+}
+
 static const struct clk_div_table cpg_rpcsrc_div_table[] = {
 	{ 2, 5 }, { 3, 6 }, { 0, 0 },
 };
@@ -438,6 +461,10 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 		return cpg_z_clk_register(core->name, __clk_get_name(parent),
 					  base, core->div, core->offset);
 
+	case CLK_TYPE_GEN3_ZG:
+		return cpg_zg_clk_register(core->name, __clk_get_name(parent),
+					   base, core->div, core->offset);
+
 	case CLK_TYPE_GEN3_OSC:
 		/*
 		 * Clock combining OSC EXTAL predivider and a fixed divider
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index 9028bf4295ce..bfdc649bdf12 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -22,6 +22,7 @@ enum rcar_gen3_clk_types {
 	CLK_TYPE_GEN3_R,
 	CLK_TYPE_GEN3_MDSEL,	/* Select parent/divider using mode pin */
 	CLK_TYPE_GEN3_Z,
+	CLK_TYPE_GEN3_ZG,
 	CLK_TYPE_GEN3_OSC,	/* OSC EXTAL predivider and fixed divider */
 	CLK_TYPE_GEN3_RCKSEL,	/* Select parent/divider using RCKCR.CKSEL */
 	CLK_TYPE_GEN3_RPCSRC,
-- 
2.39.2

