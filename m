Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A593560942B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJWO5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiJWO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:57:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF2D5C9EE;
        Sun, 23 Oct 2022 07:57:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v1so11871522wrt.11;
        Sun, 23 Oct 2022 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qe13r2WOQcom5qgxJ09BQZ2VmoEe3B9Ta0b6mH3uDkQ=;
        b=TsA5DcJq4IUwRM/afzHqd9b6CTH+1ao0fVsQFlRzv+l/J/adyJKXiVZtnYFXkd7qfa
         P3oB5o8wA8aRW5K4NDWK+NFUHOB/Qv7gd0BMB4QsQ3oBXZhina9D+3gce4PPDUfS1ehY
         E6MB7SYpjVrDyiTWGbWtD3XVf8KA5EXpnyMllFpZjluCOzLla1/IZ5evlrAaYMmKkwVC
         BpjhA2aOrcTbrnJfLUBe0wzEFYBt5AQsPXIHeRreiI+Oax70fsgDhj2XwVYZEp3DR8FP
         NnX0Yu+9iUCxRYAy4QFe/6nPUjU8OFvmYdp9PXNLU/aCIGqSjcmRRHjH63BqcQ+BBiJv
         N9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qe13r2WOQcom5qgxJ09BQZ2VmoEe3B9Ta0b6mH3uDkQ=;
        b=c0eG8gda3AuTOeaydXo+P5nevNHQOLgv7m2H0ec386ukQ1Ur1MUg7MqxEtPaMmK2sQ
         +H/dQ7eyVL1nzkc6bKllntq2Eu7YiPlNFsnJqG0LOzyJu2e1oNv6UVTVAjLQt+h0lrNm
         SezRUTEnSwPdIzLETV09wtfkbfwnkvgOcuLq0C3f7zsr05zDGUzpEG4B3qV5ij3jGSQh
         PXFXd/lbEs5dncXZjUd4Q+SGJZYQ1Ni5GJUIAtNLqj3sinWqkmZiikFyFL3kZm6q4flK
         6uxn2NUavAEU9f17Mj0tTNt0LlqTJ1FncQg0kxhRjihNaGrwl0CJkcCnMgKf0HLKpd6K
         I4+w==
X-Gm-Message-State: ACrzQf2n1JDVSxfYHh/l8+Y5aRaiRjXYvZVELwxBMUWJJpYja0Ex1BWg
        Lx6ouwAh1pQ3ctwqaK8efc8=
X-Google-Smtp-Source: AMsMyM5fLNjtV14hiLS7/dRcxK6MJIIlj7Xowjtnhwvct0o/Fu8svQ84q4nxtok7BHGy15oum2pRBQ==
X-Received: by 2002:a5d:5346:0:b0:235:6c05:6272 with SMTP id t6-20020a5d5346000000b002356c056272mr12833554wrv.332.1666537024962;
        Sun, 23 Oct 2022 07:57:04 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d4d8d000000b0023660f6cecfsm3747605wru.80.2022.10.23.07.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:57:04 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] clk: ingenic: Make PLL clock enable_bit and stable_bit optional
Date:   Sun, 23 Oct 2022 15:56:50 +0100
Message-Id: <20221023145653.177234-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221023145653.177234-1-aidanmacdonald.0x0@gmail.com>
References: <20221023145653.177234-1-aidanmacdonald.0x0@gmail.com>
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
index 7dc2e2567d53..bbb55e8d8b55 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -190,6 +190,9 @@ static inline int ingenic_pll_check_stable(struct ingenic_cgu *cgu,
 {
 	u32 ctl;
 
+	if (pll_info->stable_bit < 0)
+		return 0;
+
 	return readl_poll_timeout(cgu->base + pll_info->reg, ctl,
 				  ctl & BIT(pll_info->stable_bit),
 				  0, 100 * USEC_PER_MSEC);
@@ -231,7 +234,7 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	writel(ctl, cgu->base + pll_info->reg);
 
 	/* If the PLL is enabled, verify that it's stable */
-	if (ctl & BIT(pll_info->enable_bit))
+	if (pll_info->enable_bit >= 0 && (ctl & BIT(pll_info->enable_bit)))
 		ret = ingenic_pll_check_stable(cgu, pll_info);
 
 	spin_unlock_irqrestore(&cgu->lock, flags);
@@ -249,6 +252,9 @@ static int ingenic_pll_enable(struct clk_hw *hw)
 	int ret;
 	u32 ctl;
 
+	if (pll_info->enable_bit < 0)
+		return 0;
+
 	spin_lock_irqsave(&cgu->lock, flags);
 	if (pll_info->bypass_bit >= 0) {
 		ctl = readl(cgu->base + pll_info->bypass_reg);
@@ -279,6 +285,9 @@ static void ingenic_pll_disable(struct clk_hw *hw)
 	unsigned long flags;
 	u32 ctl;
 
+	if (pll_info->enable_bit < 0)
+		return;
+
 	spin_lock_irqsave(&cgu->lock, flags);
 	ctl = readl(cgu->base + pll_info->reg);
 
@@ -296,6 +305,9 @@ static int ingenic_pll_is_enabled(struct clk_hw *hw)
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

