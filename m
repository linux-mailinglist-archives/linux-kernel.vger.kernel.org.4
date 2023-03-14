Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6765C6B9939
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjCNP3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjCNP25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:28:57 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9021172036
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:28:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id g18so16449392ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678807730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WABs2uqkSr8euv93L/sU63WnoiH4PZRdu/LdvY8ve98=;
        b=e4HxELOY7IfiLDgpEbVVOCpGxJQiGn7MmAADHLeIQ9dSonULA0bldiz8CgMI2737lY
         rOYV31erKzdYtlM7ceiSmc4zGlTZSeSSeyEkywbYCAfh92/Oxa7gr0GGEXdLxtwTNR2V
         ai9M1XsFH/RFvDU6O1udDwUKU5YAnpsfNSyFV0bvD/OrN0ZHX7R9UpaN/uTE7lkFnlXh
         9fJTy5GbjRFmoTRlViDpEun63yit9z8jUaQX2/CJnYEbnaw3RySP5xBWpzFUpAPX0hI7
         8Vp0HsbB95wYBXPFG+N/BlrhRc/mdCCI/fdDT98qBSu10uo7fpWu4/XOcLnq36C3O/zu
         oGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678807730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WABs2uqkSr8euv93L/sU63WnoiH4PZRdu/LdvY8ve98=;
        b=Ktek1pcnVdKw+3Gc2CX8kPkQJ9XoKF3L7BOj48c/BNr4eG3vX+KnblAauWFoli7xKO
         dPQOO3QR0m8P0ikfZyBh6mHXaj1oD67MiVGvEa10LX+AJjbDUKQ/228zIx/4bqBXMCQU
         5LYnAAsX3Eno9wfvpLgk0h58vXZYyFtVdChVFcHokS1f3H4FHcDdwRziwEn+E4beGDvy
         wApF9aubcLap9fSYwY3VHRbMiWl8dWV3VaIv7N+EaYflP0bZtvr0ptzvP9ZqxrI8hVkH
         lvV46K2r72C94EG0o0Rbb3Ji44P9EMAnfMcIcMBIPDeWSWVMGNK3rvvFEcJNIxZ8mgH7
         LWSA==
X-Gm-Message-State: AO0yUKX32GSensWfeNOQ9w71vKzMrj1pEiu6ZlNliKfG+VR9LaA449W1
        0eEieih03UumHJf7+M7VQcmhkA==
X-Google-Smtp-Source: AK7set9p0iUmEJFj1wIHWX+7ggS+PnzEj2OdhTv2x6pIfkB92M1XoFxzoYiBOSMe86wKID/Dj0pPdA==
X-Received: by 2002:a2e:9911:0:b0:295:a50b:3693 with SMTP id v17-20020a2e9911000000b00295a50b3693mr10743151lji.44.1678807729879;
        Tue, 14 Mar 2023 08:28:49 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id 27-20020a2e165b000000b002986a977bf2sm491529ljw.90.2023.03.14.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:28:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 16:28:38 +0100
Subject: [PATCH v4 07/14] drm/msm/adreno: Disable has_cached_coherent in
 GMU wrapper configurations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-topic-gmuwrapper-v4-7-e987eb79d03f@linaro.org>
References: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678807716; l=1374;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BrQq/uUq7axESPCyxyyfFuley6Eq3n1FbD/qjV9Gfd4=;
 b=I4rxN89h6z/5WvdM1z4Z8cq5KsNXVn/10Wqx0Zr2wNmgPlC7+VHm5VhNifsczU7WOBF58BWKvqWC
 uCkX0n4MCwgu+b3mjjVKTvTab+06TYtgi6LYzZfedym+c58dba/a
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A610 and A619_holi don't support the feature. Disable it to make the GPU stop
crashing after almost each and every submission - the received data on
the GPU end was simply incomplete in garbled, resulting in almost nothing
being executed properly. Extend the disablement to adreno_has_gmu_wrapper,
as none of the GMU wrapper Adrenos that don't support yet seem to feature it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index f35392c034f7..6513c6094865 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -540,7 +540,6 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 		config.rev.minor, config.rev.patchid);
 
 	priv->is_a2xx = config.rev.core == 2;
-	priv->has_cached_coherent = config.rev.core >= 6;
 
 	gpu = info->init(drm);
 	if (IS_ERR(gpu)) {
@@ -552,6 +551,10 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
+	if (config.rev.core >= 6)
+		if (!adreno_has_gmu_wrapper(to_adreno_gpu(gpu)))
+			priv->has_cached_coherent = true;
+
 	return 0;
 }
 

-- 
2.39.2

