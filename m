Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8486647E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbjAJR6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbjAJR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:57:27 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594C93FCA9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:56:16 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id cf42so19721619lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70+cgySnZx/IxLftVBZg9a4OwJlDn+hSO9JJJxczBrw=;
        b=hKSN6h/M9LaTrRuvPb9kLi9FVhBuoIrhAeewUkwOP0SVgpuQ84VybxgNjOEXfYpvq9
         7+e/aZxP0kDiW/0Sz6mefNhFdbRhkA6gDcFzCHE9dX4yKdPw7omraX2dRY0vdc5HxrYO
         RtkUrCuWYMcKthoNghWzYnZnm1lJNfoFPAHkWf6WnmA2eW5Zj+bFeHcYzOSkSx+Ub/Kj
         a4gT9RPu5tX/muet10IY4ktaaW18LNAyBL/lZ3WP/yL8u+CLPhNJPL2/p86gVQ9Lb+eD
         /2pyrSwOqmrWnsH01tyA2GtmjDYhO0mks/FZ68DDPa3XO3LPwdlZ5EH2t+46LVQCSWVU
         Iu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70+cgySnZx/IxLftVBZg9a4OwJlDn+hSO9JJJxczBrw=;
        b=R9B5RPFKL+vd5rc3cGiCFnvLJmc224aEVEsJiFGNDreQQh9TKFwUS300SJf7imr+hF
         PDS5rY4sHanzEPJJ8dnBLzUcTNS/gD7XYawt/DpAMPUrLPUQgcWjaiqLktfzhmkNDqCL
         b3xOS7RBH3Y9fo2vzlYLluv6hOfsrPcUbcIWQx64k1HONTO3Dx9Ox4uhairU1x70EOIO
         HV/msS64UJnAJI6e8uS76QM7xoD7rvcYn4Eu67c3k1GctqKLp8Gyz5k9a1p4kan2XdhS
         Tfg+1CU2crWRb6gM0xQ90UMQ22EyK7GU+Wnw3gUW3BY8gZR5jFi4cG99GpL0sG/v+qV2
         +GQA==
X-Gm-Message-State: AFqh2kphrjLLAianXVpsSkz+CyybUWmHhMWIHnuFXxhy/989k9LswlCA
        D4p1fo/x9UCJfNeBdd3AxwjB1g==
X-Google-Smtp-Source: AMrXdXsNDQqsLrHoq4XAHOK7Y4VORAtyBaufb00Q5tJGNrYOdr4dypgDyuw+KHyDPaQXuDYmlbCvhg==
X-Received: by 2002:a05:6512:3ca0:b0:4b5:b7c3:8053 with SMTP id h32-20020a0565123ca000b004b5b7c38053mr22426700lfv.42.1673373374777;
        Tue, 10 Jan 2023 09:56:14 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x9-20020a0565123f8900b004a1e104b269sm2275056lfa.34.2023.01.10.09.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 09:56:14 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        angelogioacchino.delregno@collabora.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Niklas Cassel <nks@flawful.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/5] dt-bindings: opp: v2-qcom-level: Let qcom,opp-fuse-level be a 2-long array
Date:   Tue, 10 Jan 2023 18:56:02 +0100
Message-Id: <20230110175605.1240188-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110175605.1240188-1-konrad.dybcio@linaro.org>
References: <20230110175605.1240188-1-konrad.dybcio@linaro.org>
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

In some instances (particularly with CPRh) we might want to specifiy
more than one qcom,opp-fuse-level, as the same OPP subnodes may be
used by different "CPR threads". We need to make sure that
n = num_threads entries is legal and so far nobody seems to use more
than two, so let's allow that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
index b9ce2e099ce9..a30ef93213c0 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -30,7 +30,9 @@ patternProperties:
           this OPP node. Sometimes several corners/levels shares a certain fuse
           corner/level. A fuse corner/level contains e.g. ref uV, min uV,
           and max uV.
-        $ref: /schemas/types.yaml#/definitions/uint32
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 1
+        maxItems: 2
 
     required:
       - opp-level
-- 
2.39.0

