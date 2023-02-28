Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0F96A5D96
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjB1QtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjB1QtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:49:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F4B1D910
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:48:33 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso2006863pjv.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSam4VbhOsjeJo0NIo+Ag2QMw9mjy0Qu1lNaBB69VmM=;
        b=VlrDwcjfd6OGvzbjaXfRrW1QV8ufKg3mXTJwI2T1knFugZkp1hUoL+TZRA+1/2zCEz
         HXvaewIWLV0Bd6elGrgIl+spdqmxDjnmJmeCMnvt4qwT5xnWkAZWXRcYDueTV3UqR15L
         viihSguOyTg2+I94EvjD2sqPugp9sLhQ7663jSCTcEw/VQxC9xxfG1hH2KiA6CYgg3ED
         yHMzU68r6MM0CKGnYHyimkUru1e6pcGQtT65K6n3whukZQYao5ICW83SKCHvQzK+ioOj
         UTE1CZc6E3F0FlJ7gihMwvesdoNc+11GVGQSrR1r60YSGwmLfQg/RmN5H8PvnJEbKSN4
         +41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSam4VbhOsjeJo0NIo+Ag2QMw9mjy0Qu1lNaBB69VmM=;
        b=VO9PuXMrwwBtTFBOKhOov2QkYd/EFDa8kSOvOMWRHq/xYIfuH06rEdiT4lGuQFUoPo
         XoxtHoJx+aHWQZunWM5hsb+9/TK+nHSy9FCPw1CkFJneuTSj/Q54poDKk+FtnfElUs6S
         nGFN6UVuS3honyqpXRxwadlI+twaZ+NplouHG3ltLOYNRV6GmA3L3sAHrE6cj1l9eZF2
         f1Mio2WK5zV3uj7/9gqNSo2nzcWmGgDQYCq5BE8jni7SgKblHG0FbaSJP93vdk6o9Raj
         bG0Fm5Vbhs6JjibpZtmgmmxE4MAtjJzFNEzIGhqlLwZ8xOizBLDBCrXisX1AxMFpVoK6
         B2xQ==
X-Gm-Message-State: AO0yUKVnZCiH4IYCBQ9PniEY7PdxfwN+HOOwKxqz/b1scpAtUWXQGsg3
        f/IUYJSulNFplL4nWzqlFYeS
X-Google-Smtp-Source: AK7set+Z617HWx2PfAxLlytKtd90pYSM/Lvh31pLOIbMolGWNaR/bZoJapngHaECyUsZK0WI4b6h6A==
X-Received: by 2002:a17:90b:4ad1:b0:234:1a60:a6b0 with SMTP id mh17-20020a17090b4ad100b002341a60a6b0mr4094464pjb.34.1677602912457;
        Tue, 28 Feb 2023 08:48:32 -0800 (PST)
Received: from localhost.localdomain ([103.197.115.185])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00476dc914262sm5908792pgp.1.2023.02.28.08.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:48:32 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/16] arm64: dts: qcom: msm8996: Fix the PCI I/O port range
Date:   Tue, 28 Feb 2023 22:17:43 +0530
Message-Id: <20230228164752.55682-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
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

For 1MiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x100000. Hence, fix the bogus PCI addresses
(0x0c200000, 0x0d200000, 0x0e200000) specified in the ranges property for
I/O region.

While at it, let's also align the entries.

Fixes: ed965ef89227 ("arm64: dts: qcom: msm8996: add support to pcie")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 905678e7175d..66af9526c98b 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1851,8 +1851,8 @@ pcie0: pcie@600000 {
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0c200000 0x0c200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
+				ranges = <0x01000000 0x0 0x00000000 0x0c200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
 
 				device_type = "pci";
 
@@ -1905,8 +1905,8 @@ pcie1: pcie@608000 {
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0d200000 0x0d200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
+				ranges = <0x01000000 0x0 0x00000000 0x0d200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
 
 				device_type = "pci";
 
@@ -1956,8 +1956,8 @@ pcie2: pcie@610000 {
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0e200000 0x0e200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
+				ranges = <0x01000000 0x0 0x00000000 0x0e200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
 
 				device_type = "pci";
 
-- 
2.25.1

