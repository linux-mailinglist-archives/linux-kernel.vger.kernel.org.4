Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56760609426
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiJWO5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJWO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:57:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781F75D0C2;
        Sun, 23 Oct 2022 07:57:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k8so3200229wrh.1;
        Sun, 23 Oct 2022 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Megb+EEQ+42EwfPZKfmRdUWZPZjTpyMy4vvWz7+p9e0=;
        b=oItMR1ONDqqX6HzyaBT/Azz2BaW1CA6mIhZhtTK0SZ+LRng8mlK5cgeBsExzuODo2p
         543JHHhUZCEDttvrHHQga0rFTLsDudRpsuEerG6QRvLRfQKoOG3Cyffb90hrWx5QCWEh
         qnumNnm1EeVvzRmhEVlmnC8IQqgI72+gZntPT3zTBfCM4mDM97jALJa685OXbN7FM30U
         bXR3I3sy2nPv8AR2ZuHoLVFjGXTuHymYho2IHZJZ+7VMAGOgGNq2DerDjScqZeofoZmj
         EO5tMnUkbzNEGqVJo/GYo4Spnp0v2TCq+ykbISkX6K6gfH3KYpvbaVeW+gdQCdG7kxQP
         YgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Megb+EEQ+42EwfPZKfmRdUWZPZjTpyMy4vvWz7+p9e0=;
        b=nRSMuTV8syTaPmpVrnOhzKpw6aZ/PDtGbFkWOZ3wk2vHce8hCy8EigQfr+qXleQUq6
         KBJEhsgGZnjUrG6PIwIDRWqRPtVa3wgvyM8Bk0aykDjKn7QyG9MYhcJaITxO/AmlwFpU
         Q7emr/Ht2iSLXbwqpuT2wX15S4sL6FXqkzSc3CQfL7jw7UxYMEESMWUzDn+z/gx/T0IE
         efVVgTSCybi0lb7cMVDzL8PAtaQaTqNNpRKlFF+UMwg3dLRiVWFjxWwX8so4k6+y84Bf
         9aC30YDF6pFU1TNLKGDwPFnSUr4ajfjZmEVCjibPDIFHY1cV6p6MBC7xaxB/XxtRMTcP
         5/XQ==
X-Gm-Message-State: ACrzQf1XaSxZV3k1X5/qsQVJ2K3wBIrWkxdEVmsuONFCN4e6ExSTm+D1
        6YZjXBQHZ49Dom3QPX/IBGw=
X-Google-Smtp-Source: AMsMyM49YMU+pzIsy1dJTIjfUkij3brTI0jAuo/dc/ZSG8VT1W0eUdb5MCYxz3ll/SWHhA0zQqKK+w==
X-Received: by 2002:adf:f68a:0:b0:236:6e9b:dc91 with SMTP id v10-20020adff68a000000b002366e9bdc91mr1303344wrp.207.1666537026122;
        Sun, 23 Oct 2022 07:57:06 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d52c6000000b00228dbf15072sm23603166wrv.62.2022.10.23.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:57:05 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] clk: ingenic: Add .set_rate_hook() for PLL clocks
Date:   Sun, 23 Oct 2022 15:56:51 +0100
Message-Id: <20221023145653.177234-4-aidanmacdonald.0x0@gmail.com>
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
index bbb55e8d8b55..574d5fe10fdf 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -233,6 +233,9 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
 
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

