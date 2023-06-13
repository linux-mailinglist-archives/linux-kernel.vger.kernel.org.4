Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6784872DBBE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbjFMH5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbjFMH4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:56:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1129A1730
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8d1eb535eso1239365e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686642971; x=1689234971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gE1qhAhlgSaB66o5SMOQH1/DZyGEHuOAUxg0SjDKmKE=;
        b=IBihxhzUl+Wzlchdtbk/YX8/Djkg0SN8vTA61tlXgM43NTan5vdWM6rBOwPMt/86qr
         pnDGFxAV/kijfhJlM8KUt5CWCHTMle5MmF0ooS84AFO0Sp0wJJxScC1fAGDnJ0GSNYWH
         7alpdgJAFpWL3YFd0qT/2Rwby9bKp0v4XaGbTHHKL18wIbpTROMmzH2jQJlKksamTdxs
         ULaKP+G7VMjsanFLfSy0c9j+RrXcjhnVxByi3a8WO3DJWks00HwZkCp7/HI971NRlYNY
         Boj03bvk9MgFFrVuCW7ZMWj3C2up4KEjHF8JoxmqanfgHNEpq8OwsOv8mu4xqr0UmxKY
         cKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642971; x=1689234971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE1qhAhlgSaB66o5SMOQH1/DZyGEHuOAUxg0SjDKmKE=;
        b=YM7GBkqLTLc3iG/HHoWQGLzegEGu6G/ymjXtBB5yWs+uoJIjq0r+C2A8iYBijUOFAx
         pyGCkKDvfZAZJLWMIM+csu52qsYOlj4F6tgXhUAG/N7y+vKdtH192KTWS8NPq5KZnhZl
         N68SQrbVJBvSx5J5vLWHl3ekZaALjRKpvqmNxW7MjB+irM2Z37+4WzP2h9NYturPB8c4
         1FY8mryCeuWjjbbo457okk1eEqRFS/R9CvHpV+mAIV2qeUu2kIWczEaEhOqDOx+4jizO
         D3bFm1Jt2y5/MMj70UECJi4hvfEJfBRvuGrl3PLPKz2XEm9P1zdbOchXTIc7t0X81pt3
         SyBQ==
X-Gm-Message-State: AC+VfDwzHyaeR8XGbHSIVALMKgbJ5YRPhnLjg1mZVfi9CnCGX28E69nz
        LrWNqJdK7PEvDqmONTk/6QpdXQ==
X-Google-Smtp-Source: ACHHUZ7Gn/4aab+Kq0c/9gdPR/foXj9XfXRTTnFMDYIfkT5nKf+V5NU4fE7anxvyUP+L93ob0wQS0w==
X-Received: by 2002:a05:600c:2254:b0:3f7:e535:ff3b with SMTP id a20-20020a05600c225400b003f7e535ff3bmr7122722wmm.3.1686642971579;
        Tue, 13 Jun 2023 00:56:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c0b5400b003f4266965fbsm13662316wmr.5.2023.06.13.00.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:56:11 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 13 Jun 2023 09:55:58 +0200
Subject: [PATCH v3 5/8] qcom: pmic_glink: enable altmode for SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v3-5-22c9973012b6@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=z0GFmf8RXrtifMxHJ2/MNRFqa/pTMGwvA09+Qr9ms/o=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiCESNcYESvXERsdPg9XIGioD3rijvTdXZKoiGAew
 lVvp3OKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIghEgAKCRB33NvayMhJ0ZgcEA
 CTa1du9PRCxCbB1LO6DDJ073peCkSaz6UzEJMCw+CFgOZ1s4C3+pLtKhliSYm9WBmsoMj3K2u/bZbh
 pQCS6Xx3Tgz+E1g2AM+YKGhp82O8yOkncNXRbM7s1foHhz8gi86rFIOUuPKN+rQ8xTFy7igqnBHsbQ
 BC9FeGabDpheDdrnijtAtZq867PiB1Hb47xvV5TFRKh6UI/fcs9wdq+cvIj4x8vG5ELekmgBStECKN
 m9q7nelf2kRQRf09vfjt7r8gVUvdkvx6/fMyWDNK847FXLSPSz6rBSqg4kW5xrow19zwtfxPBms/2d
 kACED7cIgEY73UsU3ihn6lII19j3w+ZhYzbDKpMr3jEQBkSRNtRY63z2HTZSQJzaLzQV40QRjDqEAw
 LqVJadDz4/5WAjPYZaZWPnR6iy0wO+NeUROKgk7dIjTRhfb1hjghsXfxq7m3BlnnKP/CuNUuIfRmc4
 qmtCp8UEPNCWNyk9atckQGD0aTybqQ6JFZJN5p8qlHXSHhAM+5IryDNmrEsF3LRHSmPNN533oZm5Hu
 m6rPydIyIkR4h0C4tt0bJq9BFERQ0UMNCYdS3DHZZuO6qbwZqqmkRjf8j73hqiDeJ9452gMeXqtZ41
 1vm0W55iHRvTX7eDTdei0dE6yv46sQpTVwUi1OZdyyEUosEleicIPrFh764Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Altmode is also supported for SM8550, allow it.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/soc/qcom/pmic_glink.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index c87056769ebd..8af06bdc6f5a 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -342,13 +342,9 @@ static const unsigned long pmic_glink_sm8450_client_mask = BIT(PMIC_GLINK_CLIENT
 							   BIT(PMIC_GLINK_CLIENT_ALTMODE) |
 							   BIT(PMIC_GLINK_CLIENT_UCSI);
 
-/* Do not handle altmode for now on those platforms */
-static const unsigned long pmic_glink_sm8550_client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
-							   BIT(PMIC_GLINK_CLIENT_UCSI);
-
 static const struct of_device_id pmic_glink_of_match[] = {
 	{ .compatible = "qcom,sm8450-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
-	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8550_client_mask },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = &pmic_glink_sm8450_client_mask },
 	{ .compatible = "qcom,pmic-glink" },
 	{}
 };

-- 
2.34.1

