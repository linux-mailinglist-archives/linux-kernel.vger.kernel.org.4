Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8923E742E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjF2UgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjF2Uf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:35:56 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E25330E6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:35:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6adef5c22so16857341fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688070953; x=1690662953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfbq0gETnI1sgMFmbHrdDFl/8/rFlwdeWeNPy1LZMAk=;
        b=a7dYpfNxH+XUVa4XGpS3GsvyrwIEBIW55hdtr/VmWRbkn+FIC/0VhaVwWwHGFaVgwN
         a5Nqi4M7RBPSaqHz+/fT0wUmknkqY4jOLB/WHoAwJTYCf2jAVVvtD/V1D/hsHGEbqanl
         GruiEE4GttHXAAqW8DQ802405xABkYeI0zARbpwO9ghKMV5jML4Mp4q8WODFFx5c6FZW
         czzG2M03Ywpg5veqZ4PWZNzrfKuZVdEdkG7YHwa/8EFO8Q8d8dmPVX1X5wb4wCVkWAb5
         EGKnH9lK6HdRs+MhNXAI/ln7IGUJ9XOWtIfZMvZBMWeujfLn6qpeVvWPUdBaeJq5NIqq
         WwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688070953; x=1690662953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfbq0gETnI1sgMFmbHrdDFl/8/rFlwdeWeNPy1LZMAk=;
        b=L+/Tvl6r43LvdxTRQQNATiERwQoPqpGmBIms0ZukZmhEc08txNTwrh3c/XhThFg0Ro
         b+EpbQ3oXV+fj6QTC99cBh7iFSxBIaIdSntTMmKukFsZgNf7UiCrNZM8xIhLeUhaEYFj
         1Lm/lBHHAXJ6gImSTaQ6Epc+Q2z5e2VBUcABCvN2SLKZpPaJfik3xFCQQIW15sbM6ko5
         SG0U5h7dg/KB3ITudIj3zKSWgcIfppleQce3u3/me9BCmeipsENXI7Ji2ZRPoFcL91pJ
         pF+4s4qj//PQOSQ4hhKXI3MCG9nXj2PBuFLqK+9udc3aKWJbXodXD1eNNWh6MHNWPMtf
         UZlw==
X-Gm-Message-State: ABy/qLZa8iHUa36CSskOBWCwusANxCC+PAIAY2QBzsU4gBuU14gcypBL
        k+nJ79P/Vmnhg+2KP/GRyWro8w==
X-Google-Smtp-Source: APBJJlFUZie/wDbUGCqj1rQfb7EBc7Dxk0MI3rh3FLZMblGsln3y0dPaFWFjpSULpMFd5WEvlRe5rA==
X-Received: by 2002:a2e:91c5:0:b0:2b5:85a9:7e9b with SMTP id u5-20020a2e91c5000000b002b585a97e9bmr726666ljg.33.1688070953445;
        Thu, 29 Jun 2023 13:35:53 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id k3-20020a2e2403000000b002b6b849c894sm1136008ljk.111.2023.06.29.13.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:35:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 29 Jun 2023 22:35:43 +0200
Subject: [PATCH v2 3/4] dt-bindings: display/msm: dsi-controller-main:
 Allow refgen-supply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-refgen-v2-3-6136487c78c5@linaro.org>
References: <20230628-topic-refgen-v2-0-6136487c78c5@linaro.org>
In-Reply-To: <20230628-topic-refgen-v2-0-6136487c78c5@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688070946; l=960;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=UEARP/nzfff11sHWpuDiJ7VAKYi5TYY87h31tjxPZWc=;
 b=Zh4ieYGR01IajQXIpIis5nYeiG9d7gZkzbUVO4D1/MFHUp3xc+Lx9LuDvOacrEd4x58ruCcwR
 gYJutyIQEjFC3I7az0ZY2z0YRr22ByWu35pqVDreVgChHohR4DfbjAY
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI host needs REFGEN to be enabled (if it's present on a given platform).
Allow consuming it.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 01848bdd5873..76270992305a 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -166,6 +166,10 @@ properties:
     description:
       Phandle to vdd regulator device node
 
+  refgen-supply:
+    description:
+      Phandle to REFGEN regulator device node
+
   vcca-supply:
     description:
       Phandle to vdd regulator device node

-- 
2.41.0

