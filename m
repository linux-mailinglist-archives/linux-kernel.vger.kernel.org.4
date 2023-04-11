Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749406DE552
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjDKUGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDKUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10B949FC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681243482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxbCAB/8HzlpJB8LqCEaUSfegFqXseWfZCk3ZTKeLVg=;
        b=be+5NOIyUVtRL8YYmVymQpIFOYdQIgA4hJRklmKr3dH1uYr2tzAVkldOeFs0pT759y8r95
        +RwTcSOL3fVKld8a+RYqqinSD4jMDSPKoM/Pl685DBE5r6bE7TISK0mAnWhGqkmLbOVLhd
        2Jsy46loWT6BWJ6q80yNNwbLYMQG7iY=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-40NmhSuBPIGkx_Vz_3tqoQ-1; Tue, 11 Apr 2023 16:04:40 -0400
X-MC-Unique: 40NmhSuBPIGkx_Vz_3tqoQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1840d4e9758so6701368fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681243477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxbCAB/8HzlpJB8LqCEaUSfegFqXseWfZCk3ZTKeLVg=;
        b=6CCj48EbrNVeLqPSArRPaN34YdNKCks96WgsOLGrODi7AJK5I2NqEXhcz5oVolDtLV
         KajIby0akPasnKlR304+HkT85P2uKpqT0rT3Gi4tioCp7xU/U+8hQY3e0+vYGdjuWwbE
         xE4pT/9Ngoc7vSwvzTaL1YLvE4EAgG63Wt2KjuqgDMHFWfHzyCywbKgzH7om9zGtFby2
         UK5K1avAbAiyHzUqDAIk+9gx5ks2FOHDzbQL0Nz8LXPNujE2Fp8vbCO+5DZZyd0ZMd7H
         tULl32latY4l//zaFoRLRATGIuDDsrvkeh0qjzH+M1hjPKkvM/8s6UzmI3XlLIdw5+g0
         35Sg==
X-Gm-Message-State: AAQBX9eK3idyHcRt7Apj8/FQp/cxnb2cr41aZ4ss5fPLxE10owO+A1AP
        MO6U7RUMJ7Fh+4yYyaghIHo6PNEF9ed1BC8U2HFo6DGs8DOSutElw0PkNKuzMccn/YIE/A2KS9k
        o1Ik6bo2iBjhqgVXCj5MB+02PoX3fsBTfJuBi7o9pO7thjY9FaLOsWpX3lyfI2zVTa+m2neBr5w
        JupiQe9si/maU=
X-Received: by 2002:a05:6808:4ca:b0:384:1e0c:fbbf with SMTP id a10-20020a05680804ca00b003841e0cfbbfmr1731028oie.40.1681243477553;
        Tue, 11 Apr 2023 13:04:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350bi3pa6TdrWMyJhhKoNUuP9LYHu6k08zIXOEEGyiC+/nSaxJEVgCmNNNshInHIbaG9sgMjbfQ==
X-Received: by 2002:a05:6808:4ca:b0:384:1e0c:fbbf with SMTP id a10-20020a05680804ca00b003841e0cfbbfmr1730980oie.40.1681243477101;
        Tue, 11 Apr 2023 13:04:37 -0700 (PDT)
Received: from halaney-x13s.attlocal.net (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id e20-20020a056808149400b00387764759a3sm5868545oiw.24.2023.04.11.13.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 13:04:36 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v4 02/12] dt-bindings: net: snps,dwmac: Add Qualcomm Ethernet ETHQOS compatibles
Date:   Tue, 11 Apr 2023 15:03:59 -0500
Message-Id: <20230411200409.455355-3-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411200409.455355-1-ahalaney@redhat.com>
References: <20230411200409.455355-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Add Qualcomm Ethernet ETHQOS compatible checks
in snps,dwmac YAML binding document.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

Changes since v1/v2/v3:
    * None

 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5a4737e969a3..1e7982704114 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -65,6 +65,8 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - qcom,qcs404-ethqos
+        - qcom,sm8150-ethqos
         - renesas,r9a06g032-gmac
         - renesas,rzn1-gmac
         - rockchip,px30-gmac
@@ -625,6 +627,8 @@ allOf:
               - ingenic,x1600-mac
               - ingenic,x1830-mac
               - ingenic,x2000-mac
+              - qcom,qcs404-ethqos
+              - qcom,sm8150-ethqos
               - snps,dwmac-4.00
               - snps,dwmac-4.10a
               - snps,dwmac-4.20a
-- 
2.39.2

