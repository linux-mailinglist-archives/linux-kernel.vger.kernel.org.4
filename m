Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B83622115
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKIA5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiKIA4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:56:42 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA5464A1C;
        Tue,  8 Nov 2022 16:56:41 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a14so23549467wru.5;
        Tue, 08 Nov 2022 16:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVPpA4RQ1p5rJwkA8HPIAk7M05A9PwrvQZVEWuO/aN8=;
        b=LpBTxYKGGEkY4KPUVSgUl3YGPHhh6K2hrA0NYFqjeo3rzBX08iF6yoAVHqh9RaULR+
         C0FUFFfxTyRj92YxXPqkOTHdMWj4npoRmz7DRsWqwDXHwIwzfU03DtZoma9+GUBX2dBo
         nbucMiSk9eDcvGyBeMsjHm/tO315kVdV+ycvNMZZ4a+IEI5BeMj75xtkP3mrKKbR5vsQ
         B3fLY1klTMNCMBy1ByzcB5DcgIE4Fbi96ULGBhvbQ0qevgJn7Xl91cVzHWYbIucVMCbl
         Ga/D6W6yS7aZYsDrTNOQgvysbA+AaZ/xzeYCHpP6oUgmBnnh9emKfB7MAJih9aI2nAQ4
         ouTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVPpA4RQ1p5rJwkA8HPIAk7M05A9PwrvQZVEWuO/aN8=;
        b=0gADtuPPVlzUnfp/0XSuIZxwKWwic5JbA+wbGrHAkLS114tUDBcR1xfOBJYn9cJtLY
         WWarOtnDmfG9ekwjYQwkJdLatKCivtRrwyIAc1sjXJjEctjbfZWTrQPOlJz/vfSmrE2d
         52hew3qcI8XAnrlUaFP+de4Zl3fiXcEVX5qla7QMVxLrg9r7t/VrHyXa1cz2rk/kk5Gj
         g/xnDjVO8VJkNsewnDaGfaRHyYsUu1RyexW8C4IgGA4T44iY4SFoB0ZI+3TC0PIUa1t8
         9dVuUSGh9xstt2OKdDd27nl2FCQO6Ixencj3DMV2mBtYeOVmz9o4aw412jfAQh0hObBy
         9lew==
X-Gm-Message-State: ACrzQf2TLqAhswe9Wa87HJiTS/69rIHXYGfnLF3NMC3jo3hDX1udDxoe
        zUaiFpqLsGDjGxHstMtzRo8=
X-Google-Smtp-Source: AMsMyM6xJdMvO29Lnwp70VAea376C+BQwWParPutGWTDFol758rPA5aqVLbTZaR625aCkQ1kAG7pJQ==
X-Received: by 2002:a5d:4644:0:b0:236:cb94:4c6c with SMTP id j4-20020a5d4644000000b00236cb944c6cmr32553798wrs.544.1667955399563;
        Tue, 08 Nov 2022 16:56:39 -0800 (PST)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id z14-20020adff74e000000b0022cdb687bf9sm14130285wrp.0.2022.11.08.16.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:56:39 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 4/5] clk: qcom: krait-cc: convert to devm_clk_hw_register
Date:   Wed,  9 Nov 2022 01:56:30 +0100
Message-Id: <20221109005631.3189-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221109005631.3189-1-ansuelsmth@gmail.com>
References: <20221109005631.3189-1-ansuelsmth@gmail.com>
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

clk_register is now deprecated. Convert the driver to devm_clk_hw_register.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 17bf39076830..63322cb38aa8 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -79,8 +79,7 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 		.flags = CLK_SET_RATE_PARENT,
 	};
 	const char *p_names[1];
-	struct clk *clk;
-	int cpu;
+	int cpu, ret;
 
 	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
 	if (!div)
@@ -103,8 +102,8 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 		return -ENOMEM;
 	}
 
-	clk = devm_clk_register(dev, &div->hw);
-	if (IS_ERR(clk))
+	ret = devm_clk_hw_register(dev, &div->hw);
+	if (ret)
 		goto err;
 
 	/* clk-krait ignore any rate change if mux is not flagged as enabled */
@@ -118,7 +117,7 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 	kfree(p_names[0]);
 	kfree(init.name);
 
-	return PTR_ERR_OR_ZERO(clk);
+	return ret;
 }
 
 static int
@@ -137,7 +136,6 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 		.ops = &krait_mux_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
-	struct clk *clk;
 
 	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -166,14 +164,16 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 	if (unique_aux) {
 		sec_mux_list[0] = kasprintf(GFP_KERNEL, "acpu%s_aux", s);
 		if (!sec_mux_list[0]) {
-			clk = ERR_PTR(-ENOMEM);
+			ret = -ENOMEM;
 			goto err_aux;
 		}
 	}
 
-	clk = devm_clk_register(dev, &mux->hw);
+	ret = devm_clk_hw_register(dev, &mux->hw);
+	if (ret)
+		goto unique_aux;
 
-	ret = krait_notifier_register(dev, clk, mux);
+	ret = krait_notifier_register(dev, mux->hw.clk, mux);
 	if (ret)
 		goto unique_aux;
 
@@ -189,7 +189,7 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 		kfree(sec_mux_list[0]);
 err_aux:
 	kfree(init.name);
-	return PTR_ERR_OR_ZERO(clk);
+	return ret;
 }
 
 static struct clk *
@@ -241,11 +241,18 @@ krait_add_pri_mux(struct device *dev, int id, const char *s,
 		goto err_p2;
 	}
 
-	clk = devm_clk_register(dev, &mux->hw);
+	ret = devm_clk_hw_register(dev, &mux->hw);
+	if (ret) {
+		clk = ERR_PTR(ret);
+		goto err_p3;
+	}
+
+	clk = mux->hw.clk;
 
 	ret = krait_notifier_register(dev, clk, mux);
 	if (ret)
-		goto err_p3;
+		clk = ERR_PTR(ret);
+
 err_p3:
 	kfree(p_names[2]);
 err_p2:
-- 
2.37.2

