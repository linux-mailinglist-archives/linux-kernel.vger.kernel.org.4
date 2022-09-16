Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639B75BAD51
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIPMVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiIPMVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:21:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FB6B02B3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id cc5so25917342wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nkTuaGu3hYTNBzssyTX0STgOBEgKa3hpusGOiBls+Jw=;
        b=dfpSGv7c0w+/AeMWepKTUB/UqmO0Pv8kr3frR9U7tQjsfLQm7RtnBT6Q8H8hRdz+yL
         73ybpO+XSS24C0bs33riFYSsDnlGAtzR9a4qrJrHxOucLb1OhTsZmetYDN/DojNpd7hv
         lK50xswIV4uzsaN32c4DtK8dQ7H/vmkDaG5SgvtThPqgbD0041VSwJLULhURFGBBaLnh
         VnfCrur7BYxdjAxUsonSGLMooGLR5IIuWZsoPOasldLYQ+llF/TBAf9XZXeHWrEH3CiI
         jjo/5LuCAyIxuRR2z637Gw+ReGm0RkhGraCOS0wCFcd4F9QMCg28be5Ju+k/R/Z62p3s
         Vh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nkTuaGu3hYTNBzssyTX0STgOBEgKa3hpusGOiBls+Jw=;
        b=BZl6c0/svPtVduR310hSkvzGCu35bUQ0aSenXisP6tMc3py2RZ1UL13G47oThsCnh5
         VwwmOaL2l2nrI4QSASWx6FmQ5xZnlOARDlC+4kDalBjuo/7+Ks0Jg3dT12g9jkuScfx3
         rvEQ9F8HZp+hQFbdt1xiiOizRqxkTOrJveMs6FjtybcgZWSCbLMr6UeeAU1nWfdAES5J
         dkSKpiUi9tGLIFPDJw+sWnKQF3tVMTZ4AULrETpm6BdhW/puYKcSETsE/1olJ4E53xmv
         EUIxp1R5ZXX+h32ufDRqHt/fQ2tFj6fJTudRB5shRgyLSKiAvEl7ki/Tv2ErGVus962I
         wbcg==
X-Gm-Message-State: ACrzQf2KBjQ8HN3QUvvkSz3xPVCosXSN2wQvKJHVff392/OJN6Zh1cs0
        Fs85eCKcVUcec+z7dk3+9J8MGA==
X-Google-Smtp-Source: AMsMyM5RYTKuLk3ILeiHeTji0E/FQiw1SqFZu6rgQZuaIQevtdNnD47I3CRy7XhADaplEKvLl0z9uQ==
X-Received: by 2002:a5d:4b84:0:b0:228:7e07:115e with SMTP id b4-20020a5d4b84000000b002287e07115emr2706683wrt.168.1663330877285;
        Fri, 16 Sep 2022 05:21:17 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b0022add371ed2sm1540015wri.55.2022.09.16.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:21:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/13] dt-bindings: nvmem: Add SoC compatible for sm6115
Date:   Fri, 16 Sep 2022 13:20:56 +0100
Message-Id: <20220916122100.170016-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
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

From: Iskren Chernev <iskren.chernev@gmail.com>

Document SoC compatible for sm6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index b4163086a5be..2eab2f46cb65 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,sc7280-qfprom
           - qcom,sdm630-qfprom
           - qcom,sdm845-qfprom
+          - qcom,sm6115-qfprom
       - const: qcom,qfprom
 
   reg:
-- 
2.25.1

