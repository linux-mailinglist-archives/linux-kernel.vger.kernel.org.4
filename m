Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB4160E965
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbiJZTpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiJZTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:44:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228C4122755;
        Wed, 26 Oct 2022 12:43:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso2382373wma.1;
        Wed, 26 Oct 2022 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGJrn1iV918qT9icSbWslaEq4iQ5MQF0+KuFL8SD6t0=;
        b=aSRXm7jjodvkIZM9W6xhX0/gt7SF1AXEejbEn22oKoTkAd4YKvJAdbQPPbbssgQxRh
         soTeFxML4/fdESdB4RneLROvcQITwypXYpR+HAWHhDmH7RHeEFRmpMTYVGJk6Ucg1bwj
         YwmpzwS8ThZKTgqhW8y9eK269D0kxcRduTzkTrxSk2qOzzirCKPblL6yY/P3oHwBMZjm
         lu8DPtSFPvoQa/dnlO4g3N7nPTbMOhB46NG1VLayLl/TGqKBgGMjJR5xJSAn0oyVdSxn
         7yoiwr7ijdtSPZTx/TUoNff2evwB25lmitNroZE7Wdz/x7HP/ck+twk8vBJ0AapiTdWO
         u1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGJrn1iV918qT9icSbWslaEq4iQ5MQF0+KuFL8SD6t0=;
        b=qGyqOKVKyaSMwilNn92jm7yCS6hgflZIuvZmRgxsEnz/zrgB24EuZRr8kEbdxcbSL1
         +GvNoua/n+2ds5IHhdAgxPopRojGcat9Ai0dfn2hud8X7W7IxCyCuAs+4GePhj8heljs
         EnL0md5ScQlvF/GOafMAALq0iJLlFHmfN2bNTp0S7VjDblkfaozDm0+Cxe1/Jvu2HKPl
         ittueXPei+pYJGyTgnRbEiL+BMwmj/zeRaFwqm7feiqR3ELmQpHrP/81qRs1OSOzxF/n
         8Qjo7QofMRXHVvSIW340wFlPSMXyoIDgHhx4xtLTjZYPWOa2sb34BOEX98Ds1pQ4bhP2
         bVxw==
X-Gm-Message-State: ACrzQf1+PaeIcGBkdoi59Z1IadRPS7xA++TSfUUk/50mtl3IJ+11wo3s
        bOgvBm+YB6C0xNCglgs4mAc=
X-Google-Smtp-Source: AMsMyM5Kksr+I9/+dF9FewzPNElRhv+QRyIZq4QcwIBXk12zPU++SR7Xl/bHeG+cDwwr/Rmh3cM4uw==
X-Received: by 2002:a05:600c:4691:b0:3c6:f154:fdc6 with SMTP id p17-20020a05600c469100b003c6f154fdc6mr3585705wmo.195.1666813433801;
        Wed, 26 Oct 2022 12:43:53 -0700 (PDT)
Received: from localhost (188.28.0.84.threembb.co.uk. [188.28.0.84])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b003c6c1686b10sm3212824wmq.7.2022.10.26.12.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:43:53 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] clk: ingenic: Make PLL clock enable_bit and stable_bit optional
Date:   Wed, 26 Oct 2022 20:43:41 +0100
Message-Id: <20221026194345.243007-3-aidanmacdonald.0x0@gmail.com>
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

When the enable bit is undefined, the clock is assumed to be always
on and enable/disable is a no-op. When the stable bit is undefined,
the PLL stable check is a no-op.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/clk/ingenic/cgu.c | 14 +++++++++++++-
 drivers/clk/ingenic/cgu.h | 10 ++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 3481129114b1..aea01b6b2764 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -189,6 +189,9 @@ static inline int ingenic_pll_check_stable(struct ingenic_cgu *cgu,
 {
 	u32 ctl;
 
+	if (pll_info->stable_bit < 0)
+		return 0;
+
 	return readl_poll_timeout(cgu->base + pll_info->reg, ctl,
 				  ctl & BIT(pll_info->stable_bit),
 				  0, 100 * USEC_PER_MSEC);
@@ -230,7 +233,7 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	writel(ctl, cgu->base + pll_info->reg);
 
 	/* If the PLL is enabled, verify that it's stable */
-	if (ctl & BIT(pll_info->enable_bit))
+	if (pll_info->enable_bit >= 0 && (ctl & BIT(pll_info->enable_bit)))
 		ret = ingenic_pll_check_stable(cgu, pll_info);
 
 	spin_unlock_irqrestore(&cgu->lock, flags);
@@ -248,6 +251,9 @@ static int ingenic_pll_enable(struct clk_hw *hw)
 	int ret;
 	u32 ctl;
 
+	if (pll_info->enable_bit < 0)
+		return 0;
+
 	spin_lock_irqsave(&cgu->lock, flags);
 	if (pll_info->bypass_bit >= 0) {
 		ctl = readl(cgu->base + pll_info->bypass_reg);
@@ -278,6 +284,9 @@ static void ingenic_pll_disable(struct clk_hw *hw)
 	unsigned long flags;
 	u32 ctl;
 
+	if (pll_info->enable_bit < 0)
+		return;
+
 	spin_lock_irqsave(&cgu->lock, flags);
 	ctl = readl(cgu->base + pll_info->reg);
 
@@ -295,6 +304,9 @@ static int ingenic_pll_is_enabled(struct clk_hw *hw)
 	const struct ingenic_cgu_pll_info *pll_info = &clk_info->pll;
 	u32 ctl;
 
+	if (pll_info->enable_bit < 0)
+		return true;
+
 	ctl = readl(cgu->base + pll_info->reg);
 
 	return !!(ctl & BIT(pll_info->enable_bit));
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index 567142b584bb..a5e44ca7f969 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -42,8 +42,10 @@
  * @bypass_reg: the offset of the bypass control register within the CGU
  * @bypass_bit: the index of the bypass bit in the PLL control register, or
  *              -1 if there is no bypass bit
- * @enable_bit: the index of the enable bit in the PLL control register
- * @stable_bit: the index of the stable bit in the PLL control register
+ * @enable_bit: the index of the enable bit in the PLL control register, or
+ *		-1 if there is no enable bit (ie, the PLL is always on)
+ * @stable_bit: the index of the stable bit in the PLL control register, or
+ *		-1 if there is no stable bit
  */
 struct ingenic_cgu_pll_info {
 	unsigned reg;
@@ -54,8 +56,8 @@ struct ingenic_cgu_pll_info {
 	u8 od_shift, od_bits, od_max;
 	unsigned bypass_reg;
 	s8 bypass_bit;
-	u8 enable_bit;
-	u8 stable_bit;
+	s8 enable_bit;
+	s8 stable_bit;
 	void (*calc_m_n_od)(const struct ingenic_cgu_pll_info *pll_info,
 			    unsigned long rate, unsigned long parent_rate,
 			    unsigned int *m, unsigned int *n, unsigned int *od);
-- 
2.38.1

