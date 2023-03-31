Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85956D2A38
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCaVrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjCaVrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD1722931
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680299186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DldK2I/IPaSgIsH620iyq/+h6bSvEy3k1WBvR82ldeo=;
        b=bsRgsRLWPfSxHFE2IprNvucrkie2F91JLDVloL9F/Lp/KnfBW94zKJO/f+DaEKggwaW2Jz
        1eevQf4OlsuoPSVS6+eb9MjO92XjXw6YgZQARZC66Thn7h4zXHW2jgOMloBQTTW+ND6gh6
        GAEM/9Zwi5uoIRkgyatg00OFTEv/1kQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-Ou0ODo2ENWCIe0oFnAgOIw-1; Fri, 31 Mar 2023 17:46:24 -0400
X-MC-Unique: Ou0ODo2ENWCIe0oFnAgOIw-1
Received: by mail-oi1-f199.google.com with SMTP id bl28-20020a056808309c00b00387498386a8so5725026oib.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 14:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680299184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DldK2I/IPaSgIsH620iyq/+h6bSvEy3k1WBvR82ldeo=;
        b=iUjKn6sGJ1dzVJmD99LGMvRVgjPv+PPB96Aoz4p27DoMpt7k6yEx8qIswuZdxD3bAw
         PxvaI1HDVp0A2ayi6L+/OXEjo7OlfhvMWDnG/koq+nutlgWuXZWN1l4aB/wG3yhi8xd/
         ZFGaxqqTS9Clogng87rO4ztyCpqEkbQGv4H9yqq0Uzyp/UeiX1rHG6g9unUbeJgbUDgt
         jYGqsSX7z5uFX+CE5SnXPpBm2Tc6tRsgcn0tceLblscojrrniMat6jin/jEmWhe6Fjzf
         b7TYSGenZtyYSVB8UDpzcghy0sx1BgNUR0UNjHpdh7lOZyCNTFED4d2iMGKPBUN7a6G2
         tzIQ==
X-Gm-Message-State: AO0yUKWpdbMy8Gt1q2X35kicbslRLuQ8Pjy8klKS9FGH3WqkqQBgZgwb
        czzMTkBF0LCh3vGbxnLlA4ceOTD2yfomU6I4X3HYg2oP3rme0/BPYqLyZ2jr7x/iMavBeaCOvha
        yCFDjQcuzS2dZAJejhZKDF0uUmFy1hXIyrcMabS6ESU6Z05BWcSvSFh5Tu8cCe3L1RMxdju8jfw
        huqK5couyaX8o=
X-Received: by 2002:a4a:498a:0:b0:525:129c:6165 with SMTP id z132-20020a4a498a000000b00525129c6165mr14258302ooa.6.1680299183842;
        Fri, 31 Mar 2023 14:46:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set+27vkGs1bWdUnyWKF+VnjPQB0+2s07heID2AGWKfhkeapB9Pm6gnRicXouOLV40Cd+zuAqbA==
X-Received: by 2002:a4a:498a:0:b0:525:129c:6165 with SMTP id z132-20020a4a498a000000b00525129c6165mr14258259ooa.6.1680299183586;
        Fri, 31 Mar 2023 14:46:23 -0700 (PDT)
Received: from halaney-x13s.attlocal.net (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id x80-20020a4a4153000000b0053d9be4be68sm1328531ooa.19.2023.03.31.14.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:46:23 -0700 (PDT)
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
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v3 04/12] dt-bindings: net: qcom,ethqos: Add Qualcomm sc8280xp compatibles
Date:   Fri, 31 Mar 2023 16:45:41 -0500
Message-Id: <20230331214549.756660-5-ahalaney@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331214549.756660-1-ahalaney@redhat.com>
References: <20230331214549.756660-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc8280xp has a new version of the ETHQOS hardware in it, EMAC v3.
Add a compatible for this.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

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

