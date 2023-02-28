Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091576A5D88
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjB1QtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjB1Qs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:48:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDC919F2C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:48:26 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so10223923pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r06My2aq8Dmvi2FXH5CuaRQfq/pWOq5I+mThml6kdDc=;
        b=mj566OPk7ImfN/AU68UwLwS5qA/crpftIJk2+zaV8GZTqW8IFG//ePMocyMW9k8GnS
         XfLU8xG6R2UAhEX6/L6N1ykaHb2sYKFYIF/e5BnXnaU+YTcJ8Qazzcx6MIvvbcbAYD6G
         xR3mSPoN8H1kKpOqTlZOhkyPw1KXMSH+Hwwsp9iKwwHgeXb1wX7HIUuCY6dCuQWYHUUU
         tv7fvJelkiCfhP35GeDxuacaUIaaiQDkNe3i1MvaOgjpwc1VwHHTeDaK3Ckcjq1BCdOn
         cWuVaLdJUXsvRaT8AWqlKKUkF60U102BruutjXO0rMDs2fUJ6M0QA0XioDi30hBuGdsM
         N9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r06My2aq8Dmvi2FXH5CuaRQfq/pWOq5I+mThml6kdDc=;
        b=MhfUV9CtGoU9Sy3yDMChpU3tinTRFpX5Y8LxIAozoB3t/ymXZ3cCpuep97TqGV/IbL
         Z7wdz1+YSq0yeOHAbohfRa3Vhtw7wQg3qKVm/NbU7wU838Y8AbSug5738WbME8lNMQ8L
         xncQhSFDcR7GD3SzlYJ/x1Ev/rqJIEt3w2zixtZ9aVRpMNMrovBbMwG+RgeFLyD1pkcR
         2ymu9qef/8/HWulo6I6TLIgWq72pb1Tk0Q9YGIy/YI4ifuOq8viv7q9s1WpPgEST6lxG
         RxJ+kNqhJgZ0BAXAZNka/SoSWzdeoI1rYPqcIeVXNfOD8/7HikPls77e1upC110LI3EE
         L6RA==
X-Gm-Message-State: AO0yUKVG77CQ+asCI4+2/qIA56gPUDP1PuR90e+Z7m2M0p67z2+EAQrn
        jNlOFKUmijOVvcSvWDH4Hx43pqNLRgVE1KI=
X-Google-Smtp-Source: AK7set+Pws7ZZnufTrodK1tqCfOTEcN/eJcxq+ShHNx2ZK3FaD/TEbOUdzjnYHB+jasHxMxBOqIBvA==
X-Received: by 2002:a05:6a20:a021:b0:cc:32a8:323f with SMTP id p33-20020a056a20a02100b000cc32a8323fmr4660667pzj.38.1677602906022;
        Tue, 28 Feb 2023 08:48:26 -0800 (PST)
Received: from localhost.localdomain ([103.197.115.185])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00476dc914262sm5908792pgp.1.2023.02.28.08.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:48:25 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/16] arm64: dts: qcom: ipq8074: Fix the PCI I/O port range
Date:   Tue, 28 Feb 2023 22:17:41 +0530
Message-Id: <20230228164752.55682-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
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

For 64KiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x10000. Hence, fix the bogus PCI addresses
(0x10200000, 0x20200000) specified in the ranges property for I/O region.

While at it, let's use the missing 0x prefix for the addresses and align
them in a single line.

Fixes: 33057e1672fe ("ARM: dts: ipq8074: Add pcie nodes")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 62d05d740646..e8dad3ff4fcc 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -780,10 +780,8 @@ pcie1: pci@10000000 {
 			phys = <&pcie_phy1>;
 			phy-names = "pciephy";
 
-			ranges = <0x81000000 0 0x10200000 0x10200000
-				  0 0x10000>,   /* downstream I/O */
-				 <0x82000000 0 0x10220000 0x10220000
-				  0 0xfde0000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x10200000 0x0 0x10000>,   /* I/O */
+				 <0x82000000 0x0 0x10220000 0x10220000 0x0 0xfde0000>; /* MEM */
 
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -844,10 +842,8 @@ pcie0: pci@20000000 {
 			phys = <&pcie_phy0>;
 			phy-names = "pciephy";
 
-			ranges = <0x81000000 0 0x20200000 0x20200000
-				  0 0x10000>, /* downstream I/O */
-				 <0x82000000 0 0x20220000 0x20220000
-				  0 0xfde0000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x20200000 0x0 0x10000>,   /* I/O */
+				 <0x82000000 0x0 0x20220000 0x20220000 0x0 0xfde0000>; /* MEM */
 
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
-- 
2.25.1

