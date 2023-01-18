Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE0F671A10
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjARLJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjARLIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:08:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2A495769
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:15:50 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1107000wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djuiJl7bx5DRHNGTITj28NZCN8UBHbOpoHymK5Xy668=;
        b=mZq+wCBjWMn4ys2DKQ0xXZVF8e3MLqZsuhe6LIZqmNvtZVqNdlnFOXwye+qFyKabNR
         0eNJ3k+q/L1cobWT0KiCY692QLHmm6GDt9Z0VLiBMFrljI1gGieMZjlQ2Q/HVagCCMlt
         lsa4GP/fwmnoRl14bppiNU4yXZpm7G+ohNT/iQfrW54D0N/zAiYv1lE7GtwM80lK93+u
         WuXszjFi6zHUt+QsLbBmef9gdJJthddTMAwawOeawoHBpXl4J/YfTuJWaHIFKNxFNSuG
         iZue6hpChPgsvVbaRxTB+uS/8JSOK+T4LJH3g3TgU2jb1KvdUHOhA5KDdYOTmheGfMLw
         QQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djuiJl7bx5DRHNGTITj28NZCN8UBHbOpoHymK5Xy668=;
        b=NKMXirdv/x5BigX54MYN2vyX3Y/uhj4msUgqjraAWe5o3v3MsdyEqht5gSHJzIf3Ay
         l8eL1V1MAJg7ri7eEQgU6bvZpTOQ4uHpnuyR7zvxe0jRRlTdScNAISqKchExtnbnqk7w
         awmbo34LuwSKwz6Npytw3ebF0jXQYcvI02fAJljkCy5kBnBOfSfGIvYMbM6a8mO+lx51
         JSPu5PwqJh4pdWwbnlzr5FoZF3CZ7tdKyh5rgerVbwlPFJYDviIYh6iLtTVB4poNGNeU
         EhXCjfyEpgzlfm4FUamsOvrUJBPb9TtVXL19XmuX6J2UzLq3UL30JsX44XivD17P6Eru
         G7Jw==
X-Gm-Message-State: AFqh2kp9JIDUssxDfV97OQwQCgwHbXCBWMs434HcAJNdcGIXKgzYB5nJ
        TyzDo7pzuCUd5XKeDAp796ttLw==
X-Google-Smtp-Source: AMrXdXuSuwUkqc5Qgfm+fecSkhvRSa+4v0bwmM8Aw/gpqS1HjI0hteb1WBpPIkYpvlfGlqcbh3aNVg==
X-Received: by 2002:a05:600c:1713:b0:3da:fd90:19dd with SMTP id c19-20020a05600c171300b003dafd9019ddmr6139660wmn.26.1674036948962;
        Wed, 18 Jan 2023 02:15:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w10-20020a05600c474a00b003db00747fdesm1529838wmo.15.2023.01.18.02.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 02:15:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: qcom: sdm845: add remark about unneeded compatibles
Date:   Wed, 18 Jan 2023 11:15:42 +0100
Message-Id: <20230118101542.96705-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118101542.96705-1-krzysztof.kozlowski@linaro.org>
References: <20230118101542.96705-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all devices are the same or compatible, there is no single need to
keep growing of_device_id list with new entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Patches are independent and backwards compatible. DTS fixup will be sent
separately.
---
 sound/soc/qcom/sdm845.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index d8d35563af00..02612af714a8 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -588,6 +588,7 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 
 static const struct of_device_id sdm845_snd_device_id[]  = {
 	{ .compatible = "qcom,sdm845-sndcard" },
+	/* Do not grow the list for compatible devices */
 	{ .compatible = "qcom,db845c-sndcard" },
 	{ .compatible = "lenovo,yoga-c630-sndcard" },
 	{},
-- 
2.34.1

