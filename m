Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF366AC577
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjCFPfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCFPeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:34:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5E32A981
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:33:51 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so9142247pjg.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 07:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvJuD70O+H+sPQNrNpV5HwBBDKIiVR9W0oL4sqQ+c8g=;
        b=hgfdfPgxkzcoWcZ/R+cq9xjZ3F6NPOCBDoWdMpYZLOFAF1F9eqXSUFis9etAEsA3P6
         cqSXs+FE5vKO0+/xzpXvA/wRUetLvClJrh5V+Tl4rErDmC2KNHRM9vkKxOrbo8AwOEr4
         8lVLoF9Z52QSqqL223eR/O+B/ejROiWY20j6lvtnqOyuakBrwe5jsaajtIx2zOLz3Xml
         hSF2JFuNbrU2CY2Ov9qYh9elL48M5cw/I8KT6xKqfYCIPulaWBpxUNrikv7NF2tSQpHw
         DMBbL5HPbURUYsUwQ4jAlq09YtLArS6G42UOQ6WcbbHdZ1U/01up84YfHWZSMjEG1Lg4
         Urbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvJuD70O+H+sPQNrNpV5HwBBDKIiVR9W0oL4sqQ+c8g=;
        b=aoz+hkpQq4+VEaQhfijRI2Vlm6KlEFe0/i7lXEqCEf4GTrKfHluEjVuNaROQbFB0R5
         l9kIRbuCtIyhiyr1aO9YT8Qf3PeQuh6lLzzRSN/PR7LDZmJ4U+w+6HxJIpqaqmy9wALS
         IZHkpHHd+pU7ph7aicnK9MoJ0FO4Dyqpe9VLkuwHXpsX/nHYTH/7xA5xor3LAAnTnXHQ
         4ti5gQ26g7pd0z7+gQ2pqrxJOEXz7jYm7iVpfumvMxkdncT/jbDX42xFbJhtxy35KUv2
         94SIt8nmGIHjiMyE+hx5OUzUXmEjW6c2mMWz9/UZsHY2Lxd6pUIyy7T3iTdgjNtqDaiR
         RIVQ==
X-Gm-Message-State: AO0yUKVnhiCeAWjZgC1GrYm4m8zTrMHsiNBW7Gq2tUY9Wej/rmXDd3Vh
        xrwDpF6nettTIEJZxqPQJzp+
X-Google-Smtp-Source: AK7set8n1ClaD9Wh3bK6TU1KDVp/KEv/S2xbAzslWozdEkohVawwinrk2XH41iXV+jORtEOXWDPvJQ==
X-Received: by 2002:a17:902:d4c5:b0:199:30a6:376c with SMTP id o5-20020a170902d4c500b0019930a6376cmr12206287plg.68.1678116827601;
        Mon, 06 Mar 2023 07:33:47 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:47 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 16/19] arm64: dts: qcom: sdm845: Add "mhi" region to the PCIe nodes
Date:   Mon,  6 Mar 2023 21:02:19 +0530
Message-Id: <20230306153222.157667-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
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

The "mhi" region contains the debug registers that could be used to monitor
the PCIe link transitions.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 479859bd8ab3..0104e77dd8d5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2280,10 +2280,11 @@ opp-4 {
 		pcie0: pci@1c00000 {
 			compatible = "qcom,pcie-sdm845";
 			reg = <0 0x01c00000 0 0x2000>,
+			      <0 0x01c07000 0 0x1000>,
 			      <0 0x60000000 0 0xf1d>,
 			      <0 0x60000f20 0 0xa8>,
 			      <0 0x60100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "config";
+			reg-names = "parf", "mhi", "dbi", "elbi", "config";
 			device_type = "pci";
 			linux,pci-domain = <0>;
 			bus-range = <0x00 0xff>;
@@ -2385,10 +2386,11 @@ pcie0_lane: phy@1c06200 {
 		pcie1: pci@1c08000 {
 			compatible = "qcom,pcie-sdm845";
 			reg = <0 0x01c08000 0 0x2000>,
+			      <0 0x01c0c000 0 0x1000>,
 			      <0 0x40000000 0 0xf1d>,
 			      <0 0x40000f20 0 0xa8>,
 			      <0 0x40100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "config";
+			reg-names = "parf", "mhi", "dbi", "elbi", "config";
 			device_type = "pci";
 			linux,pci-domain = <1>;
 			bus-range = <0x00 0xff>;
-- 
2.25.1

