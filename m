Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377ED6B8C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCNIHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCNIHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:07:08 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0CA984FB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:06:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so5185749pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9I5drFJ/rMd/JOlFD+7l7aDkUVR5wTwBOoMNeSTYK2g=;
        b=gxpv2TEWg8Y7W3WUjM9DrjNO999BKPLuVBhRigTJvZhAEz2a89xOZ0Xqzf7o2utPf4
         1s5JEzbzo2ojCl7xq2aLvcWf1UvoMnJxi/V352UMAP/zO/I+Fz0yWF3q+YRtfKXaR7jk
         wBps3OZK0ApuO1eysrO95nq0L2134LQtyT/Dz3+tDae8TgAeea2TXL/3xnPe8NovrrdI
         OIrxUHQ2zhRnMu2l6AUahm7LFjh/MmFOtolvcxlYzEiiZC44/omf3GemnZD4xTDkOGKI
         aEpOE+dIt4z/6/o4Z1UQNzRDP7S/vIMfkVKWGTCAst/e7iDzCMSycgPo8x8qYWB+8EjM
         cZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9I5drFJ/rMd/JOlFD+7l7aDkUVR5wTwBOoMNeSTYK2g=;
        b=ENXKL50JMWPMK9WE43OhlpeD0/IHjIvRn4YM7V434FRfYiwKAXGBKYL8N6nxecOjuN
         NJJfUxZDTl6KrFCTa9VVUFX99HQ+gnrSrl1ZgyxpzGb094OJUTZXyyrtGb7D8eKCvdJW
         JTa5Kx3xDzcu3dWLVKjmJXoyPVuEI1185twLrx2YQIS8ae4I7p/THZD7orwQdN7vdaUW
         lWy7BrGjaevpLeRC6ekagK0VBD2HZ/ZS0JzpuR8/GCtv0l0aBYYxzAYsbllRsa6w3hO3
         kp+XT8WNw/4n99rZM6fRgLWfdAyP/Jf2Npe59E1RrDThrCk1+6bKOC8wxMtRsyxKDUfw
         UTcw==
X-Gm-Message-State: AO0yUKURz7+6ep0RsB0sBmcTyGMRWqSZzEMqkGUHuTyajX6gPfw5BPqS
        aeGwugZLr1IzQBkZiWFZ768L
X-Google-Smtp-Source: AK7set/5deypqim9/Muj/nKoPFZ0hTR3MaxuNgHdFfFiu9LJlMOb2O+A9xX/Avw5ufiFHodRzbhE+Q==
X-Received: by 2002:a17:902:bf4c:b0:19f:2444:409f with SMTP id u12-20020a170902bf4c00b0019f2444409fmr9364264pls.20.1678781175428;
        Tue, 14 Mar 2023 01:06:15 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001994a0f3380sm1078022plg.265.2023.03.14.01.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:06:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        quic_ppareek@quicinc.com, luca.weiss@fairphone.com,
        ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v8 14/14] soc: qcom: llcc: Do not create EDAC platform device on SDM845
Date:   Tue, 14 Mar 2023 13:34:43 +0530
Message-Id: <20230314080443.64635-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
References: <20230314080443.64635-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platforms based on SDM845 SoC locks the access to EDAC registers in the
bootloader. So probing the EDAC driver will result in a crash. Hence,
disable the creation of EDAC platform device on all SDM845 devices.

The issue has been observed on Lenovo Yoga C630 and DB845c.

While at it, also sort the members of `struct qcom_llcc_config` to avoid
any holes in-between.

Cc: <stable@vger.kernel.org> # 5.10
Reported-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/soc/qcom/llcc-qcom.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 7b7c5a38bac6..a5140f19f200 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -120,10 +120,11 @@ struct llcc_slice_config {
 
 struct qcom_llcc_config {
 	const struct llcc_slice_config *sct_data;
-	int size;
-	bool need_llcc_cfg;
 	const u32 *reg_offset;
 	const struct llcc_edac_reg_offset *edac_reg_offset;
+	int size;
+	bool need_llcc_cfg;
+	bool no_edac;
 };
 
 enum llcc_reg_offset {
@@ -452,6 +453,7 @@ static const struct qcom_llcc_config sdm845_cfg = {
 	.need_llcc_cfg	= false,
 	.reg_offset	= llcc_v1_reg_offset,
 	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+	.no_edac	= true,
 };
 
 static const struct qcom_llcc_config sm6350_cfg = {
@@ -1012,11 +1014,19 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 
 	drv_data->ecc_irq = platform_get_irq_optional(pdev, 0);
 
-	llcc_edac = platform_device_register_data(&pdev->dev,
-					"qcom_llcc_edac", -1, drv_data,
-					sizeof(*drv_data));
-	if (IS_ERR(llcc_edac))
-		dev_err(dev, "Failed to register llcc edac driver\n");
+	/*
+	 * On some platforms, the access to EDAC registers will be locked by
+	 * the bootloader. So probing the EDAC driver will result in a crash.
+	 * Hence, disable the creation of EDAC platform device for the
+	 * problematic platforms.
+	 */
+	if (!cfg->no_edac) {
+		llcc_edac = platform_device_register_data(&pdev->dev,
+						"qcom_llcc_edac", -1, drv_data,
+						sizeof(*drv_data));
+		if (IS_ERR(llcc_edac))
+			dev_err(dev, "Failed to register llcc edac driver\n");
+	}
 
 	return 0;
 err:
-- 
2.25.1

