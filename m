Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97516389F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiKYMgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiKYMgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:36:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5914B9BD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:46 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id x5so6584273wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/+izB6qlYb6bRq2XQ4xWOaK3HaQF+2lrKRrNqk2qGA=;
        b=WdkkM6Raa2y5wKVJnAb2QuYjYxFIVyIoTSXPixv2QH2pBE1MsILzeZvVymmcyjWEFB
         LrZO4ouNUCnQ4c2SeTO+WMDzfOW9mhyTFT7IeLxoHTvHg5ji6Fjc7ZGTDPg7eyclDwkl
         vqwuKKpZuGC4gn3WyX9BJdZ6gq556Ax3q55HzVny5lRzx7PJyFt/76UgH1HhPjnLd/9Y
         uHK5LqYEZwN7DpyAe68R2hkotTGvcB+DJnGJBv7P8Q8Xfiio2j69iDPgnmc6fg3fPs+l
         rQJV4/7uzJb+M1IE1w0mAaV99o73+EwHQMCaEB4DkPIzizQEkjzPMReBGGZ9K8eBX+NS
         hs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/+izB6qlYb6bRq2XQ4xWOaK3HaQF+2lrKRrNqk2qGA=;
        b=Adfz/vwePtmglX6kp+xEVj/pI6vu1XByfTjTFCGqDJ1lvrRJHqb5QHY6nUhGOz13p2
         Kqf7pfYrOhsaS22yT3px0JRhAxW8ZO46al3Z6njxj4Cm/Drr0byJjnEymO51l1/Ntcu8
         Kh35vFU67q6UDToi809lFLihqeALHbYS3dNS8B7e13clEfBQuS+8dClibW+Pce3RenGH
         3rkUm4xEC10mSa9BvYOOfcnk8fibk2gWTx7RGh8phmLH4IMC6ZnWfxXpjsyq/I+n140i
         h5a7I6y5Joh5KC5U+086xzgjlAqSe5u12ngcrY4hv0TQL56Mnnh9d0HC5UmkKTZv2+Yy
         SoQQ==
X-Gm-Message-State: ANoB5plqpWRhsUL6/p2Yb1mfT/eljTOHi8zld2d9wb6YtOfuUF06/LmM
        mayNYzoCwR2biQJDFMYmFhoTIQ==
X-Google-Smtp-Source: AA0mqf43iH2mEg7O9lv/d3pAnLcJHfWRmPPVAGflWp9REiyt6YZ2arB7njdS/RqA/YsQoxJ20UxZeQ==
X-Received: by 2002:a5d:570e:0:b0:241:f2e2:57ce with SMTP id a14-20020a5d570e000000b00241f2e257cemr7235575wrv.308.1669379805111;
        Fri, 25 Nov 2022 04:36:45 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6d4f000000b002366dd0e030sm3574111wri.68.2022.11.25.04.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:36:44 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v4 03/18] dt-bindings: msm: dsi-controller-main: Rename qcom,dsi-ctrl-6g-qcm2290 to qcom,qcm2290-dsi-ctrl
Date:   Fri, 25 Nov 2022 12:36:23 +0000
Message-Id: <20221125123638.823261-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
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

We will add in a number of compat strings to dsi-controller-main.yaml in
the format "qcom,socname-dsi-ctrl" convert the currently unused
qcom,dsi-ctrl-6g-qcm2290 to qcom,qcm2290-dsi-ctrl.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index cf782c5f5bdb0..67d08dc338925 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -16,7 +16,7 @@ properties:
   compatible:
     enum:
       - qcom,mdss-dsi-ctrl
-      - qcom,dsi-ctrl-6g-qcm2290
+      - qcom,qcm2290-dsi-ctrl
 
   reg:
     maxItems: 1
-- 
2.38.1

