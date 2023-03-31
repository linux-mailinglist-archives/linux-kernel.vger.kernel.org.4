Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7846D262A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCaQsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjCaQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:47:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C691732
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:45:38 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q16so29666978lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680281137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aC9vcgB4zQ+sZKRkrSflhEld19cf9czc3eWEZjB6u4=;
        b=aJi3v7Lo50cPQ7a47bC9Gq33KWNWI3NSqnrEIyU6xyoYWhyOCWrW4XACQho4sPRu6a
         uZgm/e2TEFsSM63xW1hjMsYo7BNgDEUdDUfoDJXJ9fpY7FLRQAo5bDFPDNxOXnYxDXP/
         fRxk6vG6Ph92RVwYlcDPHoJjhZmGhDv77VmtccAKgo4JfvIgBFR0rjwofpCjZioqWbIA
         PdCrW9r2dncb+7Bhx5StSWaitDHkPAll/uwgV/A7PvkLa2eoMNVx7i9Afm63zvC2XaOq
         pNJApOC0TbLZKeReWL85OyzlQfEpVQrJZh56geWRB95P9dCgrRP/3La158CI8yr/LPpr
         DS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680281137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aC9vcgB4zQ+sZKRkrSflhEld19cf9czc3eWEZjB6u4=;
        b=tcANMSKwGzoc+XpxvDGQozvkmeWflvmj/RUx4HS25Ujcz+ddlosQ2MoaCaKqivdODD
         I+rrOKWistW53h6VSLxm9gzrBxBUZEUlYTqfhbJW7FbtIkJ5Zc6rf/jWVd88ds8wHhiw
         jAkEHTudRVpFGVe2dhvpGbvFYv2qC+viBCSx3a5/6+/cXy1nsx3x0faazDOR3rG/dd4f
         OIEzGm9YQ13gk8A6+jtkovhHy37ixU7ls7HFe99BmgRkuuVC1v1g27N0nJToBGAlkCuU
         JD3hnv+WJg9KdI2giU1n4DjrIVeToYvUt+17x13TOmTeQ029VkAcaUEQ7evQ8iaa4Vhn
         LhJw==
X-Gm-Message-State: AAQBX9cfUeTZmhThiS1N2hexOQvuGP0+QgzYtlZTyS7p9+xQUlcAtkhM
        Sh7ffJbRYNkbUvkIVzWA6UFwpw==
X-Google-Smtp-Source: AKy350YA6FD7eDeRN/9/jo/VJ4UZULMRWphtY3gDX6/+wMnIIP6e19kwZCq8H+LNMAd05BlqDWZ2OA==
X-Received: by 2002:ac2:446f:0:b0:4dd:a61c:8f74 with SMTP id y15-20020ac2446f000000b004dda61c8f74mr8958859lfl.51.1680281136994;
        Fri, 31 Mar 2023 09:45:36 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u26-20020ac2519a000000b004e8483bff82sm439872lfi.271.2023.03.31.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:45:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Patrick Lai <quic_plai@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/7] dt-bindings: soundwire: qcom: add Qualcomm Soundwire v2.0.0
Date:   Fri, 31 Mar 2023 18:45:25 +0200
Message-Id: <20230331164530.227302-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230331164530.227302-1-krzysztof.kozlowski@linaro.org>
References: <20230331164530.227302-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for Qualcomm Soundwire v2.0.0 controller, which comes
with several differences against v1.7.0 in register layout.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
index e2acfd09fb22..adf28fd6134a 100644
--- a/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
+++ b/Documentation/devicetree/bindings/soundwire/qcom,soundwire.yaml
@@ -21,6 +21,7 @@ properties:
       - qcom,soundwire-v1.5.1
       - qcom,soundwire-v1.6.0
       - qcom,soundwire-v1.7.0
+      - qcom,soundwire-v2.0.0
 
   reg:
     maxItems: 1
-- 
2.34.1

