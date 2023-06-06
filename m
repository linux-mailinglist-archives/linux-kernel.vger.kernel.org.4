Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECC47242E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbjFFMpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbjFFMpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:45:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDEC1704
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:44:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso2398118e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055463; x=1688647463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uw6zfBHO0opEqODFwIHcb35ENxPJxB7I1/UM0FjZOR4=;
        b=XjD/DjeZ/zriufMZNJkno4oajcS2wFCxueANYtfQge+aQ4zJ6RTqg/5Dk9YqPm3dzC
         yohb/+gOvxKAmFhwQbC12W1bhZzDndCnS9QrJqu025jgOBEbjf/4Y56yUaKtm8XBQ0vh
         zsLazWcGSvFwzd5FE7/eCZh4LkiJku0pB7/HpJ9rWrccgiQ9XWBkG9HCLxoX3+GRN8jC
         46jGJ/s+yYObblgQUD5CadL8ubHP2aImZLNP2oUqHY87VHfB1tKX6lkBsB8wv4SAMABi
         ew77HJsQx0Ak2TWgjl6sV8eK01tAqVXBdYT1b9qybp6HQyTtYCx60uKYLltSDOiZE3cU
         Xj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055463; x=1688647463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw6zfBHO0opEqODFwIHcb35ENxPJxB7I1/UM0FjZOR4=;
        b=H/gqflq20wMlJsgnp5emOKXuDfASqAFGTiUTMpZNe/YC0OEdPHWIhATkP4dPLQIL+m
         OsiutiuCPsp6eEUvC8S1kb/mV4mM8bVnOp4XvzK2zbxNeP828OOPiURf/HA6K4l+h4W+
         6Wz9q/dMPxMeUeSqc4xU86FC+/sKS3GHz7HdTLjoHCNttsedbaGjYiwKIqVBN8XS4xGJ
         4apQtJItbbNqyibXBxRmuRQl6pqAgrRoEb8cJIxS2QO0qzAVUGJPxYOdrsDcrRcpBs3G
         tqSBVWqzzr2TIoN+UVOpAnEt3QcUiTxUNdjV7b8TzH+IijXMuHjBCC/LdV8Ou15ar+0N
         qEbg==
X-Gm-Message-State: AC+VfDzvSFQ5xRMJQ+P9A3iTnE0EwRirxSQ77GYIeShekgJdu81WWz31
        bgepRKUwavOM7k1fs3N+fIM7mw==
X-Google-Smtp-Source: ACHHUZ4JPdXVw4ik2GSg//oq+bn2TOmcvhfR+0lRQTmoDO7EADSvXTuoiqFFBHki+vQujl0wbMfFYw==
X-Received: by 2002:ac2:5314:0:b0:4f6:278b:713e with SMTP id c20-20020ac25314000000b004f6278b713emr793308lfh.42.1686055463610;
        Tue, 06 Jun 2023 05:44:23 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1830823ljk.94.2023.06.06.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:44:23 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 06 Jun 2023 14:44:01 +0200
Subject: [PATCH v6 10/12] iommu/arm-smmu-qcom: Sort the compatible list
 alphabetically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v6-10-dee6a882571b@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686055444; l=1026;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Rc5Y2oI69X8xvGgWy74AqbUqZBcFJifSW/Zzw/OwQv0=;
 b=hKN4Zx/iFcuu7jgYtNyXm0RjgfAMa4iciB6rumy4y0uHYWEzi1kXRnJRbmxp0K/sRyxp0Md5f
 h/s1XX72W3ODTC4C3mimNm9lfOBhDT8PC2XGICQRnRP6A8xuQ1loAWs
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It got broken at some point, fix it up.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index c71afda79d64..3800ab478216 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -251,10 +251,10 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280-mss-pil" },
 	{ .compatible = "qcom,sc8180x-mdss" },
 	{ .compatible = "qcom,sc8280xp-mdss" },
-	{ .compatible = "qcom,sm8150-mdss" },
-	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm8150-mdss" },
+	{ .compatible = "qcom,sm8250-mdss" },
 	{ }
 };
 

-- 
2.40.1

