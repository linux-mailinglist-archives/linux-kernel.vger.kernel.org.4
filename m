Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF18732395
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbjFOXXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbjFOXWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:22:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BC130FC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f762b3227dso256753e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686871308; x=1689463308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+svBDf4CLgOAipv+j0r6qWFrZWv28OUfTzAcDFjW8k=;
        b=GCHOdnkoYXEvs/0jT/JPEJ88fwlvgz9KRcr4tdd1kVEoRdap5/XoymnOMrVgKYqg0u
         qtgkwIV+8jgAeRsJ96GdMoqzjhufEGhX+iz2zQYykJuxurBiJreSCezAnbSqIXFy2Zok
         QERYixcwm6AqzZPtv3VXY8bkQTgFQBEFQ+euYXRdArxUUoIoUCS1HhCvCF2is2Y3uqDd
         3M3aSuie9CCXNOYaBSPUR/xJiWgDCpUwot/U7PAEs07FHHyBnuSaceKng+gOXCBPW7Aj
         v1RPpRa6oPIKlo6oXNkkTPbOaJf3dfADfbNbutC57q5M2cz/W0qHjaatksJ4EtRhQ9uY
         zAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871308; x=1689463308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+svBDf4CLgOAipv+j0r6qWFrZWv28OUfTzAcDFjW8k=;
        b=POUk0Zo5WYoS0XJ4bGPXwgeS8V+hIXnRipgw2xaRKuB8zxo6UrrAiqjEcD7bpV0kmb
         YUOp3LAVEqu5B8VEIvEK5DiXJZl63kGeX/qV5TV1FF9NVsYeVr4PH+y1LBKoBtZjR4D1
         tCKi6kKkPt4jgAWhtbYkkpFqBbFiWmgerFi0rJkcxgsJHlmX7UTI5G9dEluYgxmKI5WY
         I0Y74xdqhlgCPXVb2lO883BpNc1o/vL19nfu9pEphX9gANCW7cOVGILZaTGJZ9f26kj+
         hfbUrn5Pvs85BQnDRkEIFd2lt74pMyHx4Jmze4hlA5pCHgGzxXJnYOOwu7xhDx73AZmR
         jehg==
X-Gm-Message-State: AC+VfDzk6VD8TUJwDZayzI67uWWAYGWVcj6ib6rIdgxKThJoPHa3s19y
        ouaufC+4+BwX5IPWAUGxPlsNDw==
X-Google-Smtp-Source: ACHHUZ5M8+Y1tEEhAxhunZ5k31fQ0kTL8g5RSZ1OpELl8hso07LURPszaXvFfhbNwT0tuON+1GdjNQ==
X-Received: by 2002:a05:6512:398a:b0:4f4:e509:ef56 with SMTP id j10-20020a056512398a00b004f4e509ef56mr1852623lfu.25.1686871308495;
        Thu, 15 Jun 2023 16:21:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id u25-20020a056512041900b004f24ee39661sm2744852lfk.137.2023.06.15.16.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:21:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 16 Jun 2023 01:21:01 +0200
Subject: [PATCH v9 20/20] drm/msm/a6xx: Add A610 speedbin support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v9-20-890d8f470c8b@linaro.org>
References: <20230223-topic-gmuwrapper-v9-0-890d8f470c8b@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v9-0-890d8f470c8b@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686871277; l=1908;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QopxU5AaMC+j/o5cTOrG8wzEEwTggnAJi8IemaS+5vw=;
 b=NYNylG8pigD3OTBd3OI53qX8ugm96hvBv8g6mwWgFpPpKI2cLy28RrZAm4FAkNYNvy9fmXUEY
 hEPbQ2EAryQCVzo06LJNPngbVcuJId2kFj0Bwt1/Dxnfm7lLvCfe6/I
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A610 is implemented on at least three SoCs: SM6115 (bengal), SM6125
(trinket) and SM6225 (khaje). Trinket does not support speed binning
(only a single SKU exists) and we don't yet support khaje upstream.
Hence, add a fuse mapping table for bengal to allow for per-chip
frequency limiting.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index ff9a8d342c77..b3ada1e7b598 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2204,6 +2204,30 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return progress;
 }
 
+static u32 a610_get_speed_bin(u32 fuse)
+{
+	/*
+	 * There are (at least) three SoCs implementing A610: SM6125 (trinket),
+	 * SM6115 (bengal) and SM6225 (khaje). Trinket does not have speedbinning,
+	 * as only a single SKU exists and we don't support khaje upstream yet.
+	 * Hence, this matching table is only valid for bengal and can be easily
+	 * expanded if need be.
+	 */
+
+	if (fuse == 0)
+		return 0;
+	else if (fuse == 206)
+		return 1;
+	else if (fuse == 200)
+		return 2;
+	else if (fuse == 157)
+		return 3;
+	else if (fuse == 127)
+		return 4;
+
+	return UINT_MAX;
+}
+
 static u32 a618_get_speed_bin(u32 fuse)
 {
 	if (fuse == 0)
@@ -2301,6 +2325,9 @@ static u32 fuse_to_supp_hw(struct device *dev, struct adreno_gpu *adreno_gpu, u3
 {
 	u32 val = UINT_MAX;
 
+	if (adreno_is_a610(adreno_gpu))
+		val = a610_get_speed_bin(fuse);
+
 	if (adreno_is_a618(adreno_gpu))
 		val = a618_get_speed_bin(fuse);
 

-- 
2.41.0

