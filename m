Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D363A6DE55A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDKUG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjDKUGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F255241
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681243488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06OBUIWkgRNV7Fvg7Z0iX+fADdcC3n0Oeepo2lUID2M=;
        b=ig4idc8Yzzp56eDaWVE9Ga9gztA8+pMk47cmZav45tRSDVAW7x1B5aT9b5tqpykEqGLfYx
        jH/QxsxLi83G5ZDXFD4FrAOOebvJdAN3uStw/adLzLy7cqtEw49rsLLARILogDsLnTNZre
        vIUvs6TPXbpRY7gQtADHfKtJSc5x6Uo=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-8Ug3jOe1NGSV0kEMTbyM5A-1; Tue, 11 Apr 2023 16:04:47 -0400
X-MC-Unique: 8Ug3jOe1NGSV0kEMTbyM5A-1
Received: by mail-oo1-f72.google.com with SMTP id o202-20020a4a2cd3000000b0053b7aa939c3so3036067ooo.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681243487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06OBUIWkgRNV7Fvg7Z0iX+fADdcC3n0Oeepo2lUID2M=;
        b=aBEWE/1BEVuhsnhS+auvsE6eWf05Avr/zHkGPhnUQO9GjFOHdaLDmhQHqPobqNSbU9
         41EdOZr5SFjPabhqMoGooFwEqpuGNplLTK7xHyPFa3nHsiPFD1m9Ahme5RfbH23NPPS7
         pCxecZtoQp+3v9kbKcJdqrbotnnKZ3fUV4xftGxfwvL1PSdRPTQxeyIp7IfjvHyfNeFd
         hfcj+EAavRCUv9ip1IPcp9r1WBCcwYkjwBrhtYFKrLaCBum/H5JKL6dz+K+SMS8he0b3
         SQotyfPw8hyDd+RYL1h1aLrFevegnZ723zSUnd+7bwqO+cUj4++RJWcbC8/Qe/kxBsOG
         QCGA==
X-Gm-Message-State: AAQBX9f20fQpyqFF7vbjlMGl8NXYAYWag3IIOhlle9LPmh5BtzTcnnr2
        NncLwC3cLrVxIwvXo+H2Sqn5fOF2jWFx8OCDJa4ihyrBWHGanKuIL46WX52RO6GaywLqNfBEw0n
        6+qDXsJl7bAMD4EgYID5svgR9rTMLB+UBQadvmVIRDKTR7g+l/wIlY1/81j7pjkJn2FSCpL+6WP
        YOheUWfZiag9w=
X-Received: by 2002:aca:1916:0:b0:38b:effa:7d78 with SMTP id l22-20020aca1916000000b0038beffa7d78mr29058oii.13.1681243486880;
        Tue, 11 Apr 2023 13:04:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZD+96wPOgzlRfj4I6lXSesK7kOUy3JXAhugHSrPi7TfwOOp0WqSjbXkCy45QjGZSt9EBsTrw==
X-Received: by 2002:aca:1916:0:b0:38b:effa:7d78 with SMTP id l22-20020aca1916000000b0038beffa7d78mr29012oii.13.1681243486533;
        Tue, 11 Apr 2023 13:04:46 -0700 (PDT)
Received: from halaney-x13s.attlocal.net (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id e20-20020a056808149400b00387764759a3sm5868545oiw.24.2023.04.11.13.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:04:46 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, mturquette@baylibre.com,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        richardcochran@gmail.com, linux@armlinux.org.uk, veekhee@apple.com,
        tee.min.tan@linux.intel.com, mohammad.athari.ismail@intel.com,
        jonathanh@nvidia.com, ruppala@nvidia.com, bmasney@redhat.com,
        andrey.konovalov@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ncai@quicinc.com,
        jsuraj@qti.qualcomm.com, hisunil@quicinc.com, echanude@redhat.com,
        Andrew Halaney <ahalaney@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v4 04/12] dt-bindings: net: qcom,ethqos: Add Qualcomm sc8280xp compatibles
Date:   Tue, 11 Apr 2023 15:04:01 -0500
Message-Id: <20230411200409.455355-5-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411200409.455355-1-ahalaney@redhat.com>
References: <20230411200409.455355-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc8280xp has a new version of the ETHQOS hardware in it, EMAC v3.
Add a compatible for this.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v3:
    * Add Acked-by (Krzysztof)

Changes since v2:
    * *Really* alphabetical sorting (sorry Krzysztof!)

Changes since v1:
    * Alphabetical sorting (Krzysztof)

 Documentation/devicetree/bindings/net/qcom,ethqos.yaml | 1 +
 Documentation/devicetree/bindings/net/snps,dwmac.yaml  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
index 88234a2010b1..60a38044fb19 100644
--- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - qcom,qcs404-ethqos
+      - qcom,sc8280xp-ethqos
       - qcom,sm8150-ethqos
 
   reg:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 1e7982704114..da311c1f2c88 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -66,6 +66,7 @@ properties:
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
         - qcom,qcs404-ethqos
+        - qcom,sc8280xp-ethqos
         - qcom,sm8150-ethqos
         - renesas,r9a06g032-gmac
         - renesas,rzn1-gmac
@@ -574,6 +575,7 @@ allOf:
               - ingenic,x1600-mac
               - ingenic,x1830-mac
               - ingenic,x2000-mac
+              - qcom,sc8280xp-ethqos
               - snps,dwmac-3.50a
               - snps,dwmac-4.10a
               - snps,dwmac-4.20a
@@ -628,6 +630,7 @@ allOf:
               - ingenic,x1830-mac
               - ingenic,x2000-mac
               - qcom,qcs404-ethqos
+              - qcom,sc8280xp-ethqos
               - qcom,sm8150-ethqos
               - snps,dwmac-4.00
               - snps,dwmac-4.10a
-- 
2.39.2

