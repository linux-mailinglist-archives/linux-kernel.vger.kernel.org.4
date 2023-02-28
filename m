Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B26A5DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjB1Qu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjB1QuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:50:24 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE4234F77
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:49:08 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p6so10243046plf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eNassO9Vnm8zgaO1p6R8ZkRqE+XYfqCv7XBdpZWD1Y=;
        b=LCv6//91hcHhzEyZAsytIU78+WAzK+RKLx+VZQAOnBh1cqUyRSNrcDspccX2RyUGFk
         2/9Yn+GfyJPheITtQKnJxTT6g2t4Ifb9dE+w+uUZtYFAUP2Ffk4x8vSvdiRss+1HrdtX
         9AMC6VANMxSSuOea51f2eTGiKmX1Ki+rPdJHdqkSrfNAyygf6/99JM2hJfIj+ATXqc2P
         H/zdtaIJZ34z/6jXBO++hbaz+b/g/GZy5pLS7foyn5EXjv+TOMNF3q1uTMju0cyjtCo+
         kYmRtO1ZlCa1GqA4SyFNciCNVj78n7RjqecctcCvnh1B1LytkyKBvvkXgWThufOi9cPV
         F/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eNassO9Vnm8zgaO1p6R8ZkRqE+XYfqCv7XBdpZWD1Y=;
        b=mxuc0nwlXqf67U1zNj6Ur9GL85CjlA0GMfDbU/jl8t36Guwa8pd0q78cpFigRtBvtd
         R3JFy3OGuWnhDZiTN3AhH0ROlwgvge8jAQOVqRCjr3gyozYarhR2ZcD2At8QLrfmC4/e
         xX/6Pzoy7sx/IYxsd3fR4GEUMFf7XBKFiPiq6lr0e/r+BI18X1oMmuJMfxKfsl18KXp5
         eIIrvdxlyED5WtiNIZ85YU4BAW3zQmUuaQOBohnzqiMtRMV+FivJNJ9Kbo81HW2rfY00
         R5/oe27oFmZutlf0B2aTWXzdtLPGEAr6ZVBC4UYwI1O0Qo7p6HXy/eEj8S7FFmou0TtH
         5Cow==
X-Gm-Message-State: AO0yUKWpym7/9wna2ytkn++HL0QSfvlQIEd5pxJ/pZY/CytDTTU0CKrK
        b+WVegAEniFJ/pnGQebtDTm6
X-Google-Smtp-Source: AK7set9KfUERT3EJgDtWDZi4ewKw09o+m9bxhqSAPTR+TI4pOeNWXbB26QjwfD0A8OGvaEIR9PLrdA==
X-Received: by 2002:a05:6a20:a11f:b0:cc:32a8:323d with SMTP id q31-20020a056a20a11f00b000cc32a8323dmr10165721pzk.28.1677602943395;
        Tue, 28 Feb 2023 08:49:03 -0800 (PST)
Received: from localhost.localdomain ([103.197.115.185])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00476dc914262sm5908792pgp.1.2023.02.28.08.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:49:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 16/16] ARM: dts: qcom: ipq8064: Fix the PCI I/O port range
Date:   Tue, 28 Feb 2023 22:17:52 +0530
Message-Id: <20230228164752.55682-17-manivannan.sadhasivam@linaro.org>
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

For 64KiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x10000. Hence, fix the bogus PCI addresses
(0x0fe00000, 0x31e00000, 0x35e00000) specified in the ranges property for
I/O region.

While at it, let's use the missing 0x prefix for the addresses.

Fixes: 93241840b664 ("ARM: dts: qcom: Add pcie nodes for ipq8064")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 52d77e105957..59fc18c448c4 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1081,8 +1081,8 @@ pcie0: pci@1b500000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00010000   /* downstream I/O */
-				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x0fe00000 0x0 0x00010000   /* I/O */
+				  0x82000000 0x0 0x08000000 0x08000000 0x0 0x07e00000>; /* MEM */
 
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -1132,8 +1132,8 @@ pcie1: pci@1b700000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00010000   /* downstream I/O */
-				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x31e00000 0x0 0x00010000   /* I/O */
+				  0x82000000 0x0 0x2e000000 0x2e000000 0x0 0x03e00000>; /* MEM */
 
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -1183,8 +1183,8 @@ pcie2: pci@1b900000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00010000   /* downstream I/O */
-				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x35e00000 0x0 0x00010000   /* I/O */
+				  0x82000000 0x0 0x32000000 0x32000000 0x0 0x03e00000>; /* MEM */
 
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
-- 
2.25.1

