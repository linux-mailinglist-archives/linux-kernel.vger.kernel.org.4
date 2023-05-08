Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65446FB2EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjEHOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjEHOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:30:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9218A61
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:29:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64384274895so3208907b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683556189; x=1686148189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib+AURYSmjIxuoqk+PR8Eg/Z3fYq7w+OW68J7DC1sRs=;
        b=lhf0yTrL5foE3dgkCXYnbKFaPVDfELgWh9Qfu/YV+eeRXTgmNBLamrISJGm/kf8awb
         /Q+x7COPipzhN8O060faYDbfE9mfR23SP9HjXYhGusmHffrOHXqsmpI1CeuvtIza3iJb
         D2HJTugPooWWFNeSmHWphhPLl9HTV5glDX0ktJXkQfOxo9GqBoI+XQwkhqqVu2fbXa++
         7IVbVAbG5rwHmJWxdfwxWkg8E8AvJFCGWiFL1GD/XfG5ng5yS3gQtpftU4y0mQXFcrjF
         WuX4XDgTcmDX0aYWje38GHBLesDKvbasYOydQcOSSX1etOg97JceszynFQC+Wv6vzJdq
         tXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556189; x=1686148189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ib+AURYSmjIxuoqk+PR8Eg/Z3fYq7w+OW68J7DC1sRs=;
        b=QlaNf+m7ag/oKR2Jf5WnPTKmH1g0XpTrF2XM45lhejzoEsAzk6rWKV0XGnFgV8Ahba
         xrSPTyxgejdv7yix+8tJwDnxfA+D9U42QeDt9QaEczkhPVThnmgYTMghFsve4SX7PYnt
         8Rq2Ed2x6nJ+oIvsO20NSuKzo+3Bsv5Ks9bCzDF7m13pFwfnKHnIHT5fH7UWm1zFL/Cp
         WhWySQoefDRkRlLeI9e3tHa5aAZIaKrp4kpbHBjujVTONFOXGWBuhSTSBxfZtCOXolby
         NuOdTlE6Nvr04mxRcIaZerwg6W6t47Ctdn5pC5Y7Bfqk/+JKRYEU5GeuwqhJX7LRoz+j
         NrSg==
X-Gm-Message-State: AC+VfDwNAxlPJzUS757A0mAijVSEWj5mo22KaCppk6TQcEU+cVlVa9y2
        QdEwyzzaiNyx8WpRNqKw9Q6r6Q==
X-Google-Smtp-Source: ACHHUZ70ix2zTrDE9s+rnkB6ZVqKqawiFZ9UB6Fb2s+oNTDZtIBezM4K/5LRvwmXZR9QE5qBhwN0HA==
X-Received: by 2002:a05:6a00:b8a:b0:646:663a:9d60 with SMTP id g10-20020a056a000b8a00b00646663a9d60mr2975346pfj.10.1683556188702;
        Mon, 08 May 2023 07:29:48 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.206])
        by smtp.gmail.com with ESMTPSA id k3-20020aa790c3000000b0063d46ec5777sm6082pfk.158.2023.05.08.07.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:29:48 -0700 (PDT)
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
Subject: [PATCH v3 10/11] RISC-V: Select APLIC and IMSIC drivers
Date:   Mon,  8 May 2023 19:58:41 +0530
Message-Id: <20230508142842.854564-11-apatel@ventanamicro.com>
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

The QEMU virt machine supports AIA emulation and we also have
quite a few RISC-V platforms with AIA support under development
so let us select APLIC and IMSIC drivers for all RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 491ecd7d2336..1bc2c7659b7d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -135,6 +135,8 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
+	select RISCV_APLIC
+	select RISCV_IMSIC
 	select RISCV_INTC
 	select RISCV_TIMER if RISCV_SBI
 	select SIFIVE_PLIC
-- 
2.34.1

