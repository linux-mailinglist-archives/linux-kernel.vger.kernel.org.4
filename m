Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB6B6A5D84
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjB1QtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjB1Qsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:48:54 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B41C19F14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:48:23 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id a2so640898plm.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nw2kwwdY04mwrOWVYrVzs4I0LPxS7ZuXOh7KWbCAYF4=;
        b=HYm7C2CBsxRoKbhO9gur1eRYPy184yM8vTZPGuYYzRv9PF3O8SYlkVcn/A7XQO2eyS
         LiUz7M2vNJmIOPrPjMmU3i9E7lh3n2hpr/jf9LCxHvtl7kroWar56dFBVgS7zohxStus
         LLZMOZvo7eOh/HGl6kqwJbU2J+tYm2w8S7VB2oTT3LjUPeKLSakpgCAjtFc3z7Tb+Dmr
         D7J8XUEt/o2pLKR9ZMAyhS58YOC6mKlF9gc49TiXOCgi/7lUsoW/dTlH5FUDOiT5Y8N1
         A88PhR+RFAF4F8zw3Kf/VObuFdrBX8ZkDVkDW+Q/slRceBPAtqB2tYmCSQzY1WW61vh9
         aK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nw2kwwdY04mwrOWVYrVzs4I0LPxS7ZuXOh7KWbCAYF4=;
        b=cbrN9PARWZk/VFo9/MTGjt/5QweCeDW7Xj4Hq4bD1jmWA3mVQTzPgFSG+R9TenfJjZ
         Y6q6QVQMvS1DjDfiUetOereMdu+pbNBj4HujJoNOaJMSqZKjtInY/6APOeMdV9pdVjvP
         hy31haYRf7UBtMk61il2t8PAg6yEGgWB3c890SZVYuOhfrmBwTAQfC901EdM63LfK47W
         v2eyl0ykmU+N0lnlr8zXUFdVjUpNA38MCwaHR31RL3t715NZBvFEgNWhXwauEfiynhEh
         f9wvaYFVhxzKSIPBdIPQqoYArU0TcsLFViTfkm3HvBjB71RNxH0YMJB8asGc5IhEpzEI
         6NLg==
X-Gm-Message-State: AO0yUKU5Mqxbxsixu9UX8JqNbUrQEkWgWQ4yNC7lw+0kS77NbG3v5W8q
        cwB8XmI0ojnH+OJsmXdVR5dQ
X-Google-Smtp-Source: AK7set/gFnIrOWvw1kqm2mbi9pBSv+ggoNXU3AiSDgZXEBW0EtLOn/hQou9GYrbFNBBohJKOJRiqYA==
X-Received: by 2002:a17:902:fb8d:b0:19d:397b:eb4 with SMTP id lg13-20020a170902fb8d00b0019d397b0eb4mr2613738plb.48.1677602902784;
        Tue, 28 Feb 2023 08:48:22 -0800 (PST)
Received: from localhost.localdomain ([103.197.115.185])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00476dc914262sm5908792pgp.1.2023.02.28.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:48:22 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/16] arm64: dts: qcom: sm8550: Fix the PCI I/O port range
Date:   Tue, 28 Feb 2023 22:17:40 +0530
Message-Id: <20230228164752.55682-5-manivannan.sadhasivam@linaro.org>
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
(0x60200000, 0x40200000) specified in the ranges property for I/O region.

While at it, let's use the missing 0x prefix for the addresses.

Fixes: 7d1158c984d3 ("arm64: dts: qcom: sm8550: Add PCIe PHYs and controllers nodes")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index ff4d342c0725..f8d7b4dde878 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1653,8 +1653,8 @@ pcie0: pci@1c00000 {
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
 			bus-range = <0x00 0xff>;
 
 			dma-coherent;
@@ -1752,8 +1752,8 @@ pcie1: pci@1c08000 {
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 			bus-range = <0x00 0xff>;
 
 			dma-coherent;
-- 
2.25.1

