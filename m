Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE76930D9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 13:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBKM1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 07:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBKM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 07:27:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0E320D07
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 04:27:02 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ml19so22033701ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 04:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHheap62xUTlR5nYAk+Jh1vpzTppzTaMXhpOmRALAYI=;
        b=JZMN+4hSY640k6Kja8OEBIuj0yWLh5OZ1zOwcmtNaNn0KoXB0JLEBY9/Kwc7/GqgiF
         m1ajvu/oQv9m83TfWB2xAJ8XRJTq+b6iDh92VLLtaqcKXEgguqz5BlupzibNuRLjbcEZ
         YosZ6bhGT2WfNj9cLqEZYVGDKk6FCjMzxWI8i7R9/l1Ca1x6IO0mHBtfBX3RsHJYsM8S
         2c6Ila8w+ZbK+3pe/IWZq+aV7lSBHAtsUPDn0UyIMVgYYsrJxKo/ACJivXEmt6GFzTPE
         +/a3l/WMkp5C33z0vtu06C6DtXfbAfgSxPEtrhA6DgE16cTUUhbxNMYbAKNdcmu6+Wh6
         pbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHheap62xUTlR5nYAk+Jh1vpzTppzTaMXhpOmRALAYI=;
        b=SNmkrd2fW+FLa+qxiJ3kvNiYFunbpj9+Flw01tXqt6x5mWTLCq2aJ3X26K2Kpz8n4e
         +SaNf5uexn2sAgj6R8VHYZbVlgQa5WfsZb6T1tTKDGenmjT3Ylcr8+COH7anoztKyP87
         2tMKmvURrE4vtjiQ3VYRoDBfoewR7Wz/RbRYzhOTFNLfPJj0hZ15WVnM1Df0IP8q49QA
         fYkwr0/zK/NBa7LCvwK1XHxe5pUvXdP7xxaYV87RE+kqVIyie7RlLj4hURSdNmyqlwob
         Za5Y9sNL4p8mYHBbRYdtMHIBWOb+I8cA0sjLysjESQq0wDVQPW8eCf7j9mJijr4kZRqn
         Kzzw==
X-Gm-Message-State: AO0yUKVnawuzk/5yje2SkjY96U83k8pWR+OZmtCxiqYhGsUVzUR2R1Pv
        aqwep69X+/ttg0h63aKLNuwQpg==
X-Google-Smtp-Source: AK7set8ZFbIY5TBzWXOS1C1MfTjkBrsnU/cixmxrIKXASrqcqd0fgrjzx9nXG8WSbxwhzFSQIByu3Q==
X-Received: by 2002:a17:907:6e17:b0:8af:2af5:1191 with SMTP id sd23-20020a1709076e1700b008af2af51191mr12961239ejc.18.1676118421369;
        Sat, 11 Feb 2023 04:27:01 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id mv9-20020a170907838900b0087bd2ebe474sm3767941ejc.208.2023.02.11.04.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 04:27:01 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] dt-bindings: display/msm: dsi-controller-main: Add SM6350
Date:   Sat, 11 Feb 2023 13:26:47 +0100
Message-Id: <20230211122656.1479141-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
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

Add the DSI host found on SM6350.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index f195530ae964..2f946bb9fe24 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -26,6 +26,7 @@ properties:
               - qcom,sdm660-dsi-ctrl
               - qcom,sdm845-dsi-ctrl
               - qcom,sm6115-dsi-ctrl
+              - qcom,sm6350-dsi-ctrl
               - qcom,sm8150-dsi-ctrl
               - qcom,sm8250-dsi-ctrl
               - qcom,sm8350-dsi-ctrl
@@ -286,6 +287,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-dsi-ctrl
+              - qcom,sm6350-dsi-ctrl
     then:
       properties:
         clocks:
-- 
2.39.1

