Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD06060941E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiJWO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJWO5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:57:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348185C9C4;
        Sun, 23 Oct 2022 07:57:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k8so3200143wrh.1;
        Sun, 23 Oct 2022 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kj/OpguZjPKDUwIYpyWbwh1pY+n7iF9L6lxKcI6mhC0=;
        b=Q1Pvk3yc4qV0TxhrAP7miQlUWAmmJr6qwWmuFLZZsjy0F7nXkhy53QgtCdBeLcHZ5L
         IEkWt2Yhr3oQxdmcMJkMFOBkWP3j/A466/R6bLH/YmCiTY9pQc/2DTRigUbBNJ2tmIjv
         3f/GwtSmf11x2SRBMTZtr+cXGOXzT4UvylbPPnvuKViBwJWuj3+XK8YmYPXBE2jJxTyn
         NxQBCoa6UerAiwd6mzLC2SPABFmXiovSHPSUwNrV8hLRfxb2vUszm10qI8lriTFNZJKe
         Wuv4qdi0oz0xNg4tfjX23VHmqEvtFvQ2b2Uk1ACJAhrnxs+trPH6JV0O8cacBXi8YPdD
         MhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kj/OpguZjPKDUwIYpyWbwh1pY+n7iF9L6lxKcI6mhC0=;
        b=MhgLf82HpqTewAH+IxSnKa2h57UWIoKn1iXC+nr2OPlOab0f8Zb1UYgsQqgUyGFmkQ
         moRDdLqzrmN6QKu2Dkyt4s2BknruLw+4oyWPKQqr/E9kXSaseYJ928n0tjZlLAQpCNam
         KjzRhDVG2EAgDNyB390SK0h2IVO8g4owLBa0cEcT6jbne7aIwHM4PS1sK8xF5nm/Cr6G
         IHva7btG5Aa0ntMeti42M3JuJiMwcgp36WirS18J41ydzFldxTQWwpB5WXz7ULjJKBQ5
         hvs2NldyHePgf84I2LPzw1K1iYEhIAbQB4LsRLT89DE82H1hG56aIfxhaYz5TKFopfi3
         tDVw==
X-Gm-Message-State: ACrzQf0rgrBac8UykYrgQDzgF450YL9LEV8M2hsQbXs+P1v8k3rtJbIk
        clRIRPfN0ECQ1SgDBcP4N+s=
X-Google-Smtp-Source: AMsMyM5ETqp1Bj57TU+4kYjUpQ3ScJ33WvuY7orTycMG9obvu4YGnUHkIJuyoi4RJwOUdCKeCFfOcw==
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr18224004wrr.2.1666537023782;
        Sun, 23 Oct 2022 07:57:03 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id bg37-20020a05600c3ca500b003c706e177c1sm1758817wmb.14.2022.10.23.07.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:57:03 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] clk: ingenic: Make PLL clock "od" field optional
Date:   Sun, 23 Oct 2022 15:56:49 +0100
Message-Id: <20221023145653.177234-2-aidanmacdonald.0x0@gmail.com>
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

Add support for defining PLL clocks with od_bits = 0, meaning that
OD is fixed to 1 and there is no OD field in the register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/clk/ingenic/cgu.c | 28 +++++++++++++++++++---------
 drivers/clk/ingenic/cgu.h |  3 ++-
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 861c50d6cb24..7dc2e2567d53 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
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
@@ -108,12 +111,17 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 			return parent_rate;
 	}
 
-	for (od = 0; od < pll_info->od_max; od++) {
-		if (pll_info->od_encoding[od] == od_enc)
-			break;
+	if (pll_info->od_bits > 0) {
+		for (od = 0; od < pll_info->od_max; od++) {
+			if (pll_info->od_encoding[od] == od_enc)
+				break;
+		}
+		BUG_ON(od == pll_info->od_max);
+		od++;
+	} else {
+		/* OD is fixed to 1 if no OD field is present. */
+		od = 1;
 	}
-	BUG_ON(od == pll_info->od_max);
-	od++;
 
 	return div_u64((u64)parent_rate * m * pll_info->rate_multiplier,
 		n * od);
@@ -215,8 +223,10 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
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

