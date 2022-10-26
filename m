Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A3E60E964
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiJZTpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiJZTo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:44:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E811702B;
        Wed, 26 Oct 2022 12:43:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so2457415wmb.2;
        Wed, 26 Oct 2022 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3wzvnP281wsIY8W0hDmhg1Q7a/VEKLP9u/BDdUNrjY=;
        b=NVWODTQo1MuSH/3YcKKl35yfcQ4wT6QhkgkloNMsK28VL5opem6b7V1Sji0nlnPNIE
         jvpUT+MnqIARPp47U9m7/6/Lu6I7bP508kdTsaKTQL1vzfqPZdzOLtMTAMJelPn59+bi
         uRi8keC05PeFdSpTs74oeP5Nocck+HxEmyeDBoVTd3uXwazQ1ijom5hbD1JFqHx1xOEj
         L2JwVKicPIt0LIEwmWwmQUCjtbtPpBMWEsIeS+ynMjgCZj8f5cg5B69ppk4zayQdqAZ6
         fb7UjV/DVazK9+Vb0Rrdi8ENuliIhoT6k2pRnN++vXf48IJGDfwXDBGREGPOl4Wgt+7o
         UKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3wzvnP281wsIY8W0hDmhg1Q7a/VEKLP9u/BDdUNrjY=;
        b=0xs5cEtaQQxdQRaaETvu7DsKacBdOnNldJ+lKIFe/tf2jNndBDZtmyEzcQO8lEWWZ1
         XrK+i9s4kkc5pqIPrAWdiIgQMivALkgEoIJBmgXdmz5wA/QU70UrYPCAU6iuNj2YKIL9
         FFvER+o1/MI4O7ER029jk91arh2rOs7Rfzy5Wog+btgRtEyWK8b5kxM2ab8FJfZMtR3v
         0bQ3ceFiIrgDt4yq5uFymc++8BDRqDFXvo4zl95b4M0L8DmGHym/knL3N7eBxwnbrr4W
         ovOCljJRFvu6Q1oVUqPclk4Q4H56xHgrPom7IZbq6I+ypW7eqUvmmqmv3CEBeFWybu1E
         FKxw==
X-Gm-Message-State: ACrzQf3yG13hJQYyQ+eZSYmGrouZgkaIxWo7BXUI3PGiFQrkm7w25W8j
        5MP6BDwEDsUkyL0OhkbrTBAnHm4rkqjMpQ==
X-Google-Smtp-Source: AMsMyM7iYXUOM8A3se5v4cooz/3un5CF/IPnAgDwxU3EDvmiDm51Hv9QHdF0pkzIA9Y5hneWFBuRQA==
X-Received: by 2002:a05:600c:4e45:b0:3cf:3e69:9351 with SMTP id e5-20020a05600c4e4500b003cf3e699351mr3660796wmq.2.1666813432452;
        Wed, 26 Oct 2022 12:43:52 -0700 (PDT)
Received: from localhost (188.28.0.84.threembb.co.uk. [188.28.0.84])
        by smtp.gmail.com with ESMTPSA id a11-20020adfe5cb000000b0023655e51c33sm6070660wrn.4.2022.10.26.12.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:43:52 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] clk: ingenic: Make PLL clock "od" field optional
Date:   Wed, 26 Oct 2022 20:43:40 +0100
Message-Id: <20221026194345.243007-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com>
References: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for defining PLL clocks with od_bits = 0, meaning that
OD is fixed to 1 and there is no OD field in the register. In this
case od_max must also be 0, which is enforced with BUG_ON().

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
v1 -> v2: Simplify od lookup in ingenic_pll_recalc_rate() and
          enforce od_max == 0 when od_bits is zero.

 drivers/clk/ingenic/cgu.c | 21 +++++++++++++++------
 drivers/clk/ingenic/cgu.h |  3 ++-
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 861c50d6cb24..3481129114b1 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -83,7 +83,7 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
 	const struct ingenic_cgu_pll_info *pll_info;
-	unsigned m, n, od_enc, od;
+	unsigned m, n, od, od_enc = 0;
 	bool bypass;
 	u32 ctl;
 
@@ -96,8 +96,11 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	m += pll_info->m_offset;
 	n = (ctl >> pll_info->n_shift) & GENMASK(pll_info->n_bits - 1, 0);
 	n += pll_info->n_offset;
-	od_enc = ctl >> pll_info->od_shift;
-	od_enc &= GENMASK(pll_info->od_bits - 1, 0);
+
+	if (pll_info->od_bits > 0) {
+		od_enc = ctl >> pll_info->od_shift;
+		od_enc &= GENMASK(pll_info->od_bits - 1, 0);
+	}
 
 	if (pll_info->bypass_bit >= 0) {
 		ctl = readl(cgu->base + pll_info->bypass_reg);
@@ -112,7 +115,11 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 		if (pll_info->od_encoding[od] == od_enc)
 			break;
 	}
-	BUG_ON(od == pll_info->od_max);
+	/* if od_max = 0, od_bits should be 0 and od is fixed to 1. */
+	if (pll_info->od_max == 0)
+		BUG_ON(pll_info->od_bits != 0);
+	else
+		BUG_ON(od == pll_info->od_max);
 	od++;
 
 	return div_u64((u64)parent_rate * m * pll_info->rate_multiplier,
@@ -215,8 +222,10 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	ctl &= ~(GENMASK(pll_info->n_bits - 1, 0) << pll_info->n_shift);
 	ctl |= (n - pll_info->n_offset) << pll_info->n_shift;
 
-	ctl &= ~(GENMASK(pll_info->od_bits - 1, 0) << pll_info->od_shift);
-	ctl |= pll_info->od_encoding[od - 1] << pll_info->od_shift;
+	if (pll_info->od_bits > 0) {
+		ctl &= ~(GENMASK(pll_info->od_bits - 1, 0) << pll_info->od_shift);
+		ctl |= pll_info->od_encoding[od - 1] << pll_info->od_shift;
+	}
 
 	writel(ctl, cgu->base + pll_info->reg);
 
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index 147b7df0d657..567142b584bb 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -33,7 +33,8 @@
  * @od_shift: the number of bits to shift the post-VCO divider value by (ie.
  *            the index of the lowest bit of the post-VCO divider value in
  *            the PLL's control register)
- * @od_bits: the size of the post-VCO divider field in bits
+ * @od_bits: the size of the post-VCO divider field in bits, or 0 if no
+ *	     OD field exists (then the OD is fixed to 1)
  * @od_max: the maximum post-VCO divider value
  * @od_encoding: a pointer to an array mapping post-VCO divider values to
  *               their encoded values in the PLL control register, or -1 for
-- 
2.38.1

