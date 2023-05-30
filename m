Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A5715CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjE3LVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjE3LVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:21:04 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36A8114;
        Tue, 30 May 2023 04:21:02 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77487fcb522so120287939f.2;
        Tue, 30 May 2023 04:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685445662; x=1688037662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TKOVEGYHxWU1Tm4Om2FNng9wfK8qi7L3C4EYFqaB2Vo=;
        b=ruJ+IgmgaxQKj1pFMEOfoVBkLMWGbox8DDd1SeHiVjY5Pek9v7/rtEvrleVSjmP/ED
         /XnCx3Uaa5sLI6dyxItIGW+aS6CemTOIyxynjqJDYp1ZIRoxk+a4zWLooWBOwaoDUSDJ
         fcaK7RxxdbN83lAgK8rsay8+5b4Bpfq610J3Jppk9l87ssGgSmTnANIlXStO2+K1dWEJ
         FsE/qWR/FkgVnePqIwv2J+nzBG5fcc853ZkJLsBXOUNPbTpKp1s//FmswpDpmdGG9/Ef
         q2DASnrNNxBfXDCLnh7Ajms798mGPHSIUELdlgBFrzqUNS5j3E3C862V0vmkZGxEGDRf
         rT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445662; x=1688037662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKOVEGYHxWU1Tm4Om2FNng9wfK8qi7L3C4EYFqaB2Vo=;
        b=VQSc+JGqzOh4k2YFMEf+cT8AQJqQqpa5onbzJXODH14cbBEan9ZVOwe9ObT7GlR1aw
         qZBQVdwi0Wh+4srXe2/F8LqcQLvhSpsJ3i8MRXYbn9ngmN7DISjHmDFEHzjJTNpQ18bc
         zhOxA3/3rO53Leho1iN8AcyAocdzKRTZXQ++Y56dGE6Muo3cDU0kyBE276Zzw8q2+yt9
         drOXgd36Anby7+v6BpgviAQmlvCTpmtT19suzoEJ6NymhRlM5GXJ8Y5ecScTIxp0GcuA
         J2qGvTwq3RyBlQsVcTXoegeD8+59CMxDgL4I7B75sR/UmgazbZ5VnJ2INoJgSLlP1x8z
         9R3w==
X-Gm-Message-State: AC+VfDx2zdJ6CL2409ESnJH48F6RZxPIFCSIrJnG3ybzIfs11dwczRnS
        bI4DLxN0Cbj7FcbMwTY+jCRNOQ6tnkg=
X-Google-Smtp-Source: ACHHUZ7W0qid6AdPyodyq/TeyV+NlOb+jn7jEYueEwTbtsu8yqV2BotTe962efGWUmqO4tQHst5jFQ==
X-Received: by 2002:a6b:6402:0:b0:776:f992:78cf with SMTP id t2-20020a6b6402000000b00776f99278cfmr1246448iog.12.1685445661517;
        Tue, 30 May 2023 04:21:01 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:a5e7:c9e9:bb20:39c1])
        by smtp.gmail.com with ESMTPSA id co17-20020a0566383e1100b003c4e02148e5sm634363jab.53.2023.05.30.04.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 04:21:01 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     biju.das.jz@bp.renesas.com, marek.vasut+renesas@gmail.com,
        cstevens@beaconembedded.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [RFC 1/3] clk: renesas: rcar-gen3: Add support for ZG clock
Date:   Tue, 30 May 2023 06:20:47 -0500
Message-Id: <20230530112050.5635-1-aford173@gmail.com>
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
for clocking the graphics.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index b3ef62fa612e..7abfbf77a497 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -301,6 +301,39 @@ static struct clk * __init cpg_z_clk_register(const char *name,
 	return clk;
 }
 
+static struct clk * __init cpg_zg_clk_register(const char *name,
+					       const char *parent_name,
+					       void __iomem *reg,
+					       unsigned int div,
+					       unsigned int offset)
+{
+	struct clk_init_data init;
+	struct cpg_z_clk *zclk;
+	struct clk *clk;
+
+	zclk = kzalloc(sizeof(*zclk), GFP_KERNEL);
+	if (!zclk)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &cpg_z_clk_ops;
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	zclk->reg = reg + CPG_FRQCRB;
+	zclk->kick_reg = reg + CPG_FRQCRB;
+	zclk->hw.init = &init;
+	zclk->mask = GENMASK(offset + 4, offset);
+	zclk->fixed_div = div; /* PLLVCO x 1/div1 x 3DGE divider x 1/div2 */
+
+	clk = clk_register(NULL, &zclk->hw);
+	if (IS_ERR(clk))
+		kfree(zclk);
+
+	return clk;
+}
+
 static const struct clk_div_table cpg_rpcsrc_div_table[] = {
 	{ 2, 5 }, { 3, 6 }, { 0, 0 },
 };
@@ -502,6 +535,9 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 	case CLK_TYPE_GEN3_RPCD2:
 		return cpg_rpcd2_clk_register(core->name, base + CPG_RPCCKCR,
 					      __clk_get_name(parent));
+	case CLK_TYPE_GEN3_ZG:
+		return cpg_zg_clk_register(core->name, __clk_get_name(parent),
+					   base, core->div, core->offset);
 
 	default:
 		return ERR_PTR(-EINVAL);
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

