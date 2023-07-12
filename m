Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2453A75049C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjGLKed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjGLKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:34:25 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2961BD5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:34:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e6541c98so6149807b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158057; x=1691750057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVAw7udukL38zwKtT4457ZqK6it2VdBXoqf1V9p3kc4=;
        b=isqILRp2HC9Ls4OVrM79cWWkM+2AF8/YyITwGQzkfdXJw2wS0o+KcnwFKgqBvuxVHc
         gYvHjMAHw9JCmG50CSuwjv+Rq6MLi27bYXEAoqR2s3DEO9nphmtEogNIHYv4Xf/i3gGG
         FqRMK5p3XcWzFQ6CPXFWPAmOe3Kqrg7eEy/MJ+FMq/fUN6z8JY4YTdeNEaCytQyJ4DdY
         cgw1O+4mRHi7+JioR375dYmR166DXGrgZfu/E7ow84rYwxFBPdzXNiuXz3coYLhctzbm
         zhiIm2ddU3gvLe5a8MbpLA4TecSMAoLkjhysgEQTb79wDzPRhdF8dXgLye0AeXIqd33F
         vGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158057; x=1691750057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVAw7udukL38zwKtT4457ZqK6it2VdBXoqf1V9p3kc4=;
        b=iQpQpIXEVUAsB6PImtpMu7MxBDL2WrdF9wNZUOHfc2wP9Y598raYpyM4fcx0b49j2L
         f3V/xjxZ03P+pCcZ2GZOijKugX7D/CPTCHA7xywuMshTILDHokoPbtifspCORty7WZug
         81St8YkX3uBkTDkFHn/DxnQLfWZUpWeuntXj3z92+5OG4+xCSSBKd+qUXpYcuU/GFkGN
         f4sI+hlIa3NEmlgbxUFi9QOu7jLxW1/9xtYEEAdqpaqi0fwHA7eJXliIg6lG8NCFdCws
         EhlKNY88T9xZoQzyGFde4m3raPUoaO3TAh5Ll7SJfo8B3cDa4h6DaiYRmyPKALbtnBBc
         d5Qg==
X-Gm-Message-State: ABy/qLYHmBB+/B2wBzIAqcEr5cuX2BJrl1Yo6tV75xJ6lRnORQaCjj4/
        xrTWpvhWM3tPHyCMQn3sULje
X-Google-Smtp-Source: APBJJlFUWC255F6eLnf2C5UDQZ693UFhrIoIQkUc7luQxR8UfSsm7MLjxZeaNBUtDTEUU/rCVNd7Hw==
X-Received: by 2002:a05:6a00:2307:b0:67e:18c6:d2c6 with SMTP id h7-20020a056a00230700b0067e18c6d2c6mr24028175pfh.5.1689158056990;
        Wed, 12 Jul 2023 03:34:16 -0700 (PDT)
Received: from localhost.localdomain ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b00666b3706be6sm3247860pfk.107.2023.07.12.03.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:34:16 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/14] OPP: Introduce dev_pm_opp_get_freq_indexed() API
Date:   Wed, 12 Jul 2023 16:02:03 +0530
Message-Id: <20230712103213.101770-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of devices with multiple clocks, drivers need to specify the
frequency index for the OPP framework to get the specific frequency within
the required OPP. So let's introduce the dev_pm_opp_get_freq_indexed() API
accepting the frequency index as an argument.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/opp/core.c     | 22 ++++++++++++++++++++++
 include/linux/pm_opp.h |  8 ++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a6d0b6b18e0e..66dc0d0cfaed 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -197,6 +197,28 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
+/**
+ * dev_pm_opp_get_freq_indexed() - Gets the frequency corresponding to an
+ *				   available opp with specified index
+ * @opp: opp for which frequency has to be returned for
+ * @index: index of the frequency within the required opp
+ *
+ * Return: frequency in hertz corresponding to the opp with specified index,
+ * else return 0
+ */
+unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
+{
+	struct opp_table *opp_table = opp->opp_table;
+
+	if (IS_ERR_OR_NULL(opp) || index >= opp_table->clk_count) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	return opp->rates[index];
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq_indexed);
+
 /**
  * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
  * @opp:	opp for which level value has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 991f54da79b5..97eb6159fb93 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -105,6 +105,8 @@ unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
+unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index);
+
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
 
 unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
@@ -211,6 +213,12 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp,
+						      u32 index)
+{
+	return 0;
+}
+
 static inline unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 {
 	return 0;
-- 
2.25.1

