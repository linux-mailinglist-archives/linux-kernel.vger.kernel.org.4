Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CB362BC92
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiKPLwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiKPLvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:51:38 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878F6450B1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:40:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a14so29478706wru.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bagD2wG/tEqVv+fwLrRFVQIXkhW+1dP8Dy7b0v4+yP4=;
        b=GSfXcovFxxmq48049VENKozMm1XRH1dXYc7qwWXEuYEGDBJSF9XXUWCXlYUn5sSC/M
         cVKvCpE9qm5KzpRvWGLraOSzS9YOyqTgJWM5EtYfwlGYpWT+T95RcXO0K5Jjy1tqfpAl
         PY7A3UibDLIKCVoBQnOQjXdLY6kfaR36HVJ+jTShPbfqZDGIinCP29MIgXV0Nbhf17Sa
         kkkxQWXtgyPkZ3WMaB6vWLfM5I12Ule9IMWOt1cM37OwtWnMVFpaXJi8ZWkiCRQpYeqR
         sXVwNgI4n2ryknTfprg9KxRmWepN6JvuvkbN/nPhkfX7Tp14H9/kX5sFEMQjorJBHK+n
         evbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bagD2wG/tEqVv+fwLrRFVQIXkhW+1dP8Dy7b0v4+yP4=;
        b=GeFHYka4eeiq0aPgNoGOg0l7nOWBaOciXPW87071KZjMffvCDKnT+gFtb2FOK2o3Rm
         5MZoX/PdybyGCReh6diUNrSJPkLNIRxW6uEn8B9tIEEXZ2wBfjlQxf2NkSkhUl/w2WCv
         bLA82HLWVZe00JrebYq87bMElyLrA+7L9pZ8rlj7ux/ApQyb6QP45lv9U/osZ+UYOmkN
         IVksZ5SrlNGF3AaTOW+tyQogbdiLqdgmT/vnQyGGaOw+IXAN8/g7w313wmItqxSJwtzI
         8OvFIMh52YQDZoTY5UzZyAdPx0wGlr/dLtcJlh13JLU/2cNcJ3pQ/D+U21VFakh2a9q+
         rtLQ==
X-Gm-Message-State: ANoB5pmTw3B2WQWigbDtNkzFmMLPSyIahWxrAU0GbaehIkFsfTYAkg7e
        rb/47cQ6BeecTcrp5Tdc+xLnzg==
X-Google-Smtp-Source: AA0mqf65x4qGluoqkqzEYj3Q+Z79ZsL6+koYZV0rIJ4jPW57+SBXB4lwo0hgXIIu12b7C1W2mTmcAg==
X-Received: by 2002:a5d:4107:0:b0:22e:3e28:f8db with SMTP id l7-20020a5d4107000000b0022e3e28f8dbmr13864751wrp.380.1668598811092;
        Wed, 16 Nov 2022 03:40:11 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id s3-20020adfecc3000000b0022e653f5abbsm14853105wro.69.2022.11.16.03.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:40:10 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] iommu: arm-smmu-impl: Add SM8550 qcom iommu implementation
Date:   Wed, 16 Nov 2022 13:40:01 +0200
Message-Id: <20221116114001.2669003-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116114001.2669003-1-abel.vesa@linaro.org>
References: <20221116114001.2669003-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM8550 qcom iommu implementation to the table of
qcom_smmu_impl_of_match table which brings in iommu support for
SM8550 SoC

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index b2708de25ea3..3a029f26642d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -439,6 +439,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm8250-smmu-500" },
 	{ .compatible = "qcom,sm8350-smmu-500" },
 	{ .compatible = "qcom,sm8450-smmu-500" },
+	{ .compatible = "qcom,sm8550-smmu-500" },
 	{ }
 };
 
-- 
2.34.1

