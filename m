Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DF16B356B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 05:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCJEMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 23:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjCJEKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:10:49 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C6102B73
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 20:09:44 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso8536430pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 20:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678421379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4buO9u/YEJ2XslOs7PK/sn8ZofMZxzKI+5s+2aMPGs=;
        b=Yhgo+KzhV0XGUvfnd/Fy/ekOzTIPp2EImzqeI1nddn4PntdIRUwETkoIDUdfennjHu
         zb+B8aPivUyLWAZCbQkWh3FjcJOWOlzcAr/1VAD3R1q/IaE9qg6l55hlw3/bhNd5/gPt
         DQKMt4pSb8K57TkbduoD0O4YwRXFwL4HvqlO3vNQ/00Dbvbpa737iBf+uRsYQnPQ9Lis
         JtNDDpSiqu9kuG+W7EVSHdhrI32yDUK6AaO5LAbkuOrQtqcpSWgYGuGGGS1xYQW8baBS
         WgoyxYlCC4ei3OkBhF2qvc4L2MISmdkkc41xu10m8PeDznWt+PI9bqgpLrjg0qhGF9dt
         +mTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4buO9u/YEJ2XslOs7PK/sn8ZofMZxzKI+5s+2aMPGs=;
        b=KzcgycKJfGNzpA6knpw1hSF1B0U7Dx571/uvElQcqLXJjMfmgNY5f7qt4LJ2ZGO28T
         F9PL6kh2q6hegVK5kpJ+2tEh8oPlrVkxIMnPrtPoMnzCB5wSh7nRsJMhb19I5FtM/CwH
         og4C+4dBFdNFZopi5/r/3pxY2OSLcJZKuUsmHhlJNp+rXIZUtc6lzdcHlHIY7qpX97ax
         72ZC6NgYp/7E3UxuE+hQYSg5qWHnLK26ofqWkCOfQn1WuYTBz3UiHDdBkEOvAFWhcGSL
         T1viyHFKNWsQkL9HIcZvahVH/pKJIF91A1GSZZnz7xGizyVmjV8TEpwdzRaP3QSMt6K/
         eXyw==
X-Gm-Message-State: AO0yUKWaE9T5Hj2CopOC5V6xtZ+mPEzDIFH3dwQ2NmRkryJDLK5Wx4Qa
        Mds8zI3zTyJNN7SeeHKtWAlJ
X-Google-Smtp-Source: AK7set8XPsi2pTRWczTgVjT+PyUJNrk5YHH9LrAUQNY7AnVISCVJc5lz6lc+kHNkMEvhXGY8AipBsQ==
X-Received: by 2002:a05:6a20:6712:b0:cb:ec3d:4783 with SMTP id q18-20020a056a20671200b000cbec3d4783mr21448427pzh.21.1678421379004;
        Thu, 09 Mar 2023 20:09:39 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.67])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b0058d92d6e4ddsm361846pfn.5.2023.03.09.20.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:09:38 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 16/19] arm64: dts: qcom: sm8250: Add "mhi" region to the PCIe nodes
Date:   Fri, 10 Mar 2023 09:38:13 +0530
Message-Id: <20230310040816.22094-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
References: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "mhi" region contains the debug registers that could be used to monitor
the PCIe link transitions.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 2f0e460acccd..81383e20d3d9 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1824,8 +1824,9 @@ pcie0: pci@1c00000 {
 			      <0 0x60000000 0 0xf1d>,
 			      <0 0x60000f20 0 0xa8>,
 			      <0 0x60001000 0 0x1000>,
-			      <0 0x60100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			      <0 0x60100000 0 0x100000>,
+			      <0 0x01c03000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			device_type = "pci";
 			linux,pci-domain = <0>;
 			bus-range = <0x00 0xff>;
@@ -1933,8 +1934,9 @@ pcie1: pci@1c08000 {
 			      <0 0x40000000 0 0xf1d>,
 			      <0 0x40000f20 0 0xa8>,
 			      <0 0x40001000 0 0x1000>,
-			      <0 0x40100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			      <0 0x40100000 0 0x100000>,
+			      <0 0x01c0b000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			device_type = "pci";
 			linux,pci-domain = <1>;
 			bus-range = <0x00 0xff>;
@@ -2041,8 +2043,9 @@ pcie2: pci@1c10000 {
 			      <0 0x64000000 0 0xf1d>,
 			      <0 0x64000f20 0 0xa8>,
 			      <0 0x64001000 0 0x1000>,
-			      <0 0x64100000 0 0x100000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "config";
+			      <0 0x64100000 0 0x100000>,
+			      <0 0x01c13000 0 0x1000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
 			device_type = "pci";
 			linux,pci-domain = <2>;
 			bus-range = <0x00 0xff>;
-- 
2.25.1

