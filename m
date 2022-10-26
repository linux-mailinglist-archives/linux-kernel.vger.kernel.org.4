Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7988C60E966
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiJZTpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbiJZToh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:44:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134FB1217E7;
        Wed, 26 Oct 2022 12:43:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y16so17741662wrt.12;
        Wed, 26 Oct 2022 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20uxWCRsvxDQKcFPgK2zgFTA1dEWAdkZ4yr2nsg4cVM=;
        b=YUeEywwSsDDC6VKwfhGJmdXAAkKNE9LeiHly+HMRUKJAVljKOXdhd7nqIbqyrNQTTI
         ZiF/V3W4Qw+gZXk7Gu1o3qK1w7/chrfcaWCgrtmA5E6C3Gwxq307tvC45ZOkb2VyrAuG
         +YTxSnA5xW6fCYA66HRGBtmRXq4jxlVa5yCn9p0hnKU6SfhedBWjYjr6+oAaLMWtA0QU
         R3775UnYGGf+h5kxKpTtUn8yAiEapUE9yeIY8siSl8F+6pJrGeDdWzcdGXdeTeOHxBUP
         7YXB9FgvYVqIQRwJY+mKRMZFgLqcNbUn8veS0Z+KHThvhgl4SxVOnt6HMPRwFQpaDDSi
         6zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20uxWCRsvxDQKcFPgK2zgFTA1dEWAdkZ4yr2nsg4cVM=;
        b=RcKAA7QPI0MHqBwRoLPMGYPfUVlU/8SXSmYq1IPNPM9AyrV4dpcvHOxOnQC8rPSy3B
         1cO5fayvLpeL8+GHiiPaafi8HmCvcVYnog+Bmt5KRfdOcYCx6NwmgrsCy5LCqj6wHjGt
         w5l9VEZq2kWOpzTdnggzMzdO1EQ5SdDref4ebGE5iXxgsy/d6w1F+gXWKNJIkRYcNgQD
         vIx6A5tOXLEukbEW0fHsP2cuO+9XpxpB+Z2fGw8YdtA4ntB4E1FsOv4M0l7ftXKp/HIT
         P1AbbG09U5ZIWtU7NqkcA0rME9CXHVwt/JoNP1Kz32TRwd385G5acycHAPfmcJW6gyHC
         nogQ==
X-Gm-Message-State: ACrzQf1PsETkjL6KaDjBMK45Nz/sYewcObXMLgMyV0RlnT8pDrQ82/mh
        QXXm/t6NWXVVXycMxjqSenk=
X-Google-Smtp-Source: AMsMyM496gCxIh6eI5KAlS/uP6kp5NbvrMlSV5dFAm9PFNSIwEAOZcwNoqYvWagoLOXDK55AFB5cvQ==
X-Received: by 2002:a5d:6e8e:0:b0:21d:ea5:710f with SMTP id k14-20020a5d6e8e000000b0021d0ea5710fmr30102020wrz.48.1666813435011;
        Wed, 26 Oct 2022 12:43:55 -0700 (PDT)
Received: from localhost (188.28.0.84.threembb.co.uk. [188.28.0.84])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b00228cd9f6349sm5756508wrv.106.2022.10.26.12.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:43:54 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] clk: ingenic: Add .set_rate_hook() for PLL clocks
Date:   Wed, 26 Oct 2022 20:43:42 +0100
Message-Id: <20221026194345.243007-4-aidanmacdonald.0x0@gmail.com>
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

The set rate hook is called immediately after updating the clock
register but before the spinlock is released. This allows another
register to be updated alongside the main one, which is needed to
handle the I2S divider on some SoCs.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/clk/ingenic/cgu.c | 3 +++
 drivers/clk/ingenic/cgu.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index aea01b6b2764..b6a4d4236c16 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -232,6 +232,9 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 
 	writel(ctl, cgu->base + pll_info->reg);
 
+	if (pll_info->set_rate_hook)
+		pll_info->set_rate_hook(pll_info, rate, parent_rate);
+
 	/* If the PLL is enabled, verify that it's stable */
 	if (pll_info->enable_bit >= 0 && (ctl & BIT(pll_info->enable_bit)))
 		ret = ingenic_pll_check_stable(cgu, pll_info);
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index a5e44ca7f969..99da9bd86e63 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -46,6 +46,8 @@
  *		-1 if there is no enable bit (ie, the PLL is always on)
  * @stable_bit: the index of the stable bit in the PLL control register, or
  *		-1 if there is no stable bit
+ * @set_rate_hook: hook called immediately after updating the CGU register,
+ *		   before releasing the spinlock
  */
 struct ingenic_cgu_pll_info {
 	unsigned reg;
@@ -61,6 +63,8 @@ struct ingenic_cgu_pll_info {
 	void (*calc_m_n_od)(const struct ingenic_cgu_pll_info *pll_info,
 			    unsigned long rate, unsigned long parent_rate,
 			    unsigned int *m, unsigned int *n, unsigned int *od);
+	void (*set_rate_hook)(const struct ingenic_cgu_pll_info *pll_info,
+			      unsigned long rate, unsigned long parent_rate);
 };
 
 /**
-- 
2.38.1

