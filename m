Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FDF6129A4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJ3Jnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJ3JnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:43:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C007CE39;
        Sun, 30 Oct 2022 02:43:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l32so5609205wms.2;
        Sun, 30 Oct 2022 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/VLR/q0mJpm1g0Mv+FaKiNU++ksU9JCwtcy+gU033k=;
        b=kz4BtlExlvZie5t39yqkV7DvNLu31S3E9vbQEZv+uNOaMKpiL2NugTxhtRkjmiGeM3
         OuYEV2diE//sUBC3GBZfdoqqK78he3cFaVvmre4Ix30d6hS6pA+lEuuL1d9JdtnjqehU
         T2AiKY3akNxn24eTwzG5ZUPux2VDa0ys5+BFI0lIa3FIbtTDBhHYdg5HRCEC1ZAy3SKx
         Z2O092dnZVg9V0SFPb1iNSeBFnkVDoIGRFSIhk4CCB7wASYlw4UX4ekjiMlxHwGAx5LJ
         0XD/iqoA0duiD7fPbmgv8mwM4F1RElzKm5V+/4YFxQRQX8sQ6k7eZfCEgReRKz1uRmeX
         /k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/VLR/q0mJpm1g0Mv+FaKiNU++ksU9JCwtcy+gU033k=;
        b=ZonCooIg1WIsdstkh4cYkk4Yeo45voUc6SxRQTtPG5P7AyaC37STaD+P0//5BLqaCJ
         aFlq9jNpkEOBQHYv5Ue0Dv7Lm4iNjWn1hTemyT5X7SEtocZAbHRd9U17DD9oPFCHAPe9
         J+HSqNWRWyizUc6aEHoTYMKdHs+ukJ1LQeXDS8JUBZAIvMA12o9/bDxjg4aNb3Q0TgKb
         wqdVqCmui6uZFyFCJyjyy4sLmcGrTjclPIPidGcLbuZ8H/c8Jmnw5ufclSzA0eUJ3gJb
         Y8GCbntgD3cZdJ6L/hHFpslhMcIxFRn9oAkDBINXCuRfeQMuXGiaAJrpSfV9i+kgfqFW
         ZU6g==
X-Gm-Message-State: ACrzQf0DuR3vHzbIs3dWLob4c4Kfd16+ooa5K/2vh1yI4dQ0NFzHBcVk
        SrP/msTKUAyQuoT5wtWgfaI=
X-Google-Smtp-Source: AMsMyM5WjDIC4d7iLHlIggwJ4nnImN8lrJOG27Gx0B7OH+u8AcgoXXAis/9grLtUtsFZpfKiKvhTHg==
X-Received: by 2002:a05:600c:4252:b0:3cf:678a:d189 with SMTP id r18-20020a05600c425200b003cf678ad189mr3572561wmm.51.1667122998733;
        Sun, 30 Oct 2022 02:43:18 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id a17-20020a05600c349100b003b47ff307e1sm3925965wmq.31.2022.10.30.02.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 02:43:17 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Emma Anholt <emma@anholt.net>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/8] iommu/arm-smmu-qcom: Add SM6115 support
Date:   Sun, 30 Oct 2022 11:42:55 +0200
Message-Id: <20221030094258.486428-6-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030094258.486428-1-iskren.chernev@gmail.com>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
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

From: Adam Skladowski <a39.skl@gmail.com>

Add the Qualcomm SM6115 platform to the list of compatible,
this target uses MMU500 for both APSS and GPU.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index b2708de25ea3..526fec79b4fe 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -432,6 +432,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc8280xp-smmu-500" },
 	{ .compatible = "qcom,sdm630-smmu-v2" },
 	{ .compatible = "qcom,sdm845-smmu-500" },
+	{ .compatible = "qcom,sm6115-smmu-500" },
 	{ .compatible = "qcom,sm6125-smmu-500" },
 	{ .compatible = "qcom,sm6350-smmu-500" },
 	{ .compatible = "qcom,sm6375-smmu-500" },
-- 
2.38.1

