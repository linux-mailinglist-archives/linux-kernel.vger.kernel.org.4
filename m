Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92A56FB2DA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjEHO3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbjEHO33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:29:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D9E4C34
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:29:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64359d9c531so3371268b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683556149; x=1686148149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1nY2tFDgGEcA5BPTW/qPM4ksEcua9dIFA1MwwOUg+w=;
        b=Y4KeKeEH2HyNjQj1MvzsAagGgVRUdpfCpDFHN+2mKM/yIL5V4lC3/r8BWTBVPv8mr8
         crG2m3zs5hnPIFNLt92hug/24EbFLZl8MHqF6s0UAd9n57VO1wIMukU5t9t3dDPg2PRO
         sO9zoJNKGTBkOC3klDG6HaL02odtnyoCMZY6HzIpeP2+t3qrT/fC9nsHjjuQ7NCuBZj+
         aq2dtuWODDaoxaCpgUoNZGGP1z628C7yRSBp+4ZUOT0oExNHPCeb8h1cRwyar7P0p+2V
         wseYx1vo0wkd9RoXyot8Efac9RcekQ3hmC2u3e4HorVZQmu9AI0obr74p9qEtJZc0r2+
         fkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556149; x=1686148149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1nY2tFDgGEcA5BPTW/qPM4ksEcua9dIFA1MwwOUg+w=;
        b=cXUGDhWyKS/TJGusTMWNpN3Gq5ltXzxSyScvFJFhi/mLFioh1564csrdz/fmn4OxHo
         o86jvi7Z1lzrwWhFs0BvDo2Dap80bkhLUTINdOm32pfBMD1x+Fnf+l90cmSzmIO4+bye
         P6kFxErv2XikPiFQ/zsAgDbN7lCy47m+KCHfu3YWEG8nn1SVmc0CzAD5H8xSEwDOCohj
         RR4rkpdMP7YMZaOq8kGPfMN3zCp6tBqfAqh3cKnu/mx9aEwrUNhX5ss9Dp0FCETBHro2
         fFTjhEneD1KoLguYm9VS6Q7ipxW1weChxEYUdtupGaTYco5gEVkidjUMnHtb/iPnyCi0
         PxDg==
X-Gm-Message-State: AC+VfDwv/bLTKWpjPGiORY9CFCi23WkXakBcSTavnJK2phNUQ9oZ+/aD
        NVxy0Vi98D4X08mowcXkrG/Pfg==
X-Google-Smtp-Source: ACHHUZ7gDrZ3JRghPX//cMrvwquC37PoOqjAFZxHaVQQxUAxuCDyhmWrefaoupApJJIMGX/LlXhLUA==
X-Received: by 2002:a05:6a00:1503:b0:643:96e:666b with SMTP id q3-20020a056a00150300b00643096e666bmr13783594pfu.34.1683556149506;
        Mon, 08 May 2023 07:29:09 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.206])
        by smtp.gmail.com with ESMTPSA id k3-20020aa790c3000000b0063d46ec5777sm6082pfk.158.2023.05.08.07.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:29:09 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 02/11] of/irq: Set FWNODE_FLAG_BEST_EFFORT for the interrupt controller DT nodes
Date:   Mon,  8 May 2023 19:58:33 +0530
Message-Id: <20230508142842.854564-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508142842.854564-1-apatel@ventanamicro.com>
References: <20230508142842.854564-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V APLIC interrupt controller driver is a regular platform
driver so we need to ensure that it is probed as soon as possible.
To achieve this, we mark the interrupt controller device nodes with
FWNODE_FLAG_BEST_EFFORT (just like console DT node).

Fixes: 8f486cab263c ("driver core: fw_devlink: Allow firmware to mark devices as best effort")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/of/irq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 174900072c18..94e1d9245cff 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -535,6 +535,16 @@ void __init of_irq_init(const struct of_device_id *matches)
 	INIT_LIST_HEAD(&intc_desc_list);
 	INIT_LIST_HEAD(&intc_parent_list);
 
+	/*
+	 * We need interrupt controller platform drivers to work as soon
+	 * as possible so mark the interrupt controller device nodes with
+	 * FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
+	 * the probe of the interrupt controller device for suppliers
+	 * without drivers.
+	 */
+	for_each_node_with_property(np, "interrupt-controller")
+		np->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
+
 	for_each_matching_node_and_match(np, matches, &match) {
 		if (!of_property_read_bool(np, "interrupt-controller") ||
 				!of_device_is_available(np))
-- 
2.34.1

