Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545A365C610
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbjACSYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjACSYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:24:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A6113D3C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672770164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GMkaQo/BI/bmgnSRQkk7Z0Q9S5jZOIoAqxp/1ITyx/U=;
        b=jBs51Dg0aOKDFryA6mqFNVLd9wxj2SZptoikwvoT8nc7KbjHmB8x/ZqR8sbB/kht45G50p
        OMBd9oXk19Y+wjcGDyfZMjd8zXa4MX+wIamHgv9Vo96sO//9O8q3n4Hu/G8sHrOCtAY30n
        LgeCUVTz10vrCly619snAL9ETq/M9yQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-3kFyX6kkNImHFPO_PuiLuA-1; Tue, 03 Jan 2023 13:22:42 -0500
X-MC-Unique: 3kFyX6kkNImHFPO_PuiLuA-1
Received: by mail-qv1-f69.google.com with SMTP id nh4-20020a056214390400b004e36a91ecffso16520195qvb.19
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:22:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMkaQo/BI/bmgnSRQkk7Z0Q9S5jZOIoAqxp/1ITyx/U=;
        b=1f/fA7O8gs/2nr3Yl58j4fbriJQ1GmModQMXL8aEQyn8Vovd2Ja+nxh4lSh7+iPGzx
         uNoxK/GnZw1FJmbnz/QtweGA8vCq3nYK0aKomlz0PbSwf6a/GyfqkZXFXoPPvv5PTEZe
         T8kd52OsAjpn5mLi8dlue6eXvdR4CtSNApLkrvkYj5YXnfuZ69mTUQFVOB7KgvGPBuQu
         sJz+gCdQ1CqDfEeGthobhGqAtR8zm6LSXIyZzXID6Jjk44EcYqLzixiysYOlCNk8EW4o
         KWoFWH9MRx5jZ0dZ6fqlnAo2GsDaYd011q3fzs1sRKMaEDIIno6ll7IvaHPq9znwA0P6
         O66Q==
X-Gm-Message-State: AFqh2kqfBYmsOwNt0HedHWTRxaz2xYejfx6JCmfWtRpf7U26YPYrGL5S
        7WU9vLLTYCJ5ctCilyDTsDYqd0J245NZkgqFJYnb9K3sXvaGTwP692I3yQtPyF5cFoJaNtVoyCx
        GBpY7pn3BoIMv9IiJTWD+Z+sZ
X-Received: by 2002:ad4:5503:0:b0:531:8d5d:5005 with SMTP id pz3-20020ad45503000000b005318d5d5005mr37006747qvb.24.1672770162335;
        Tue, 03 Jan 2023 10:22:42 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs6+sDNrbiuY5zMeIFOHkcu7VABU+uITEeUiDuFJ9B3n17tUX+zdFjgZj3PpnRhvmqwgPd0ZA==
X-Received: by 2002:ad4:5503:0:b0:531:8d5d:5005 with SMTP id pz3-20020ad45503000000b005318d5d5005mr37006733qvb.24.1672770162108;
        Tue, 03 Jan 2023 10:22:42 -0800 (PST)
Received: from x1.. (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t13-20020a05620a450d00b006fba0a389a4sm22819675qkp.88.2023.01.03.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:22:41 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.co
Subject: [PATCH v4 01/10] dt-bindings: qcom,*-geni: move #{address,size}-cells on i2c/spi nodes
Date:   Tue,  3 Jan 2023 13:22:20 -0500
Message-Id: <20230103182229.37169-2-bmasney@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103182229.37169-1-bmasney@redhat.com>
References: <20230103182229.37169-1-bmasney@redhat.com>
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

Move the #address-cells and #size-cells properties on the existing
i2c/spi example nodes below the reg property so that all of the
address-related properties are grouped together.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Link: https://lore.kernel.org/lkml/Y6Wnh+tXPhF6aC1b@hovoldconsulting.com/
---
New patch introduced in v4

 .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml       | 4 ++--
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml        | 4 ++--
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.yaml       | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
index f5f7dc8f325c..594bf810a4aa 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
@@ -127,13 +127,13 @@ examples:
     i2c@88000 {
         compatible = "qcom,geni-i2c";
         reg = <0x00880000 0x4000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
         clock-names = "se";
         clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
         pinctrl-names = "default";
         pinctrl-0 = <&qup_i2c0_default>;
         interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
-        #address-cells = <1>;
-        #size-cells = <0>;
         interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
                         <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>,
                         <&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
index ab4df0205285..d6128fb7d361 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
@@ -137,14 +137,14 @@ examples:
             i2c0: i2c@a94000 {
                 compatible = "qcom,geni-i2c";
                 reg = <0 0xa94000 0 0x4000>;
+                #address-cells = <1>;
+                #size-cells = <0>;
                 interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
                 clock-names = "se";
                 clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
                 pinctrl-names = "default", "sleep";
                 pinctrl-0 = <&qup_1_i2c_5_active>;
                 pinctrl-1 = <&qup_1_i2c_5_sleep>;
-                #address-cells = <1>;
-                #size-cells = <0>;
             };
 
             uart0: serial@a88000 {
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index 2e20ca313ec1..efa7f52941f8 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -85,13 +85,13 @@ examples:
     spi@880000 {
         compatible = "qcom,geni-spi";
         reg = <0x00880000 0x4000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
         clock-names = "se";
         clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
         pinctrl-names = "default";
         pinctrl-0 = <&qup_spi0_default>;
         interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
-        #address-cells = <1>;
-        #size-cells = <0>;
         power-domains = <&rpmhpd SC7180_CX>;
         operating-points-v2 = <&qup_opp_table>;
         interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
@@ -105,6 +105,8 @@ examples:
     spi@884000 {
         compatible = "qcom,geni-spi";
         reg = <0x00884000 0x4000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
         clock-names = "se";
         clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
         dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
@@ -113,6 +115,4 @@ examples:
         pinctrl-names = "default";
         pinctrl-0 = <&qup_spi1_default>;
         interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
-        #address-cells = <1>;
-        #size-cells = <0>;
     };
-- 
2.39.0

