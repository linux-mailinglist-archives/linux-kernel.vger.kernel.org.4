Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3946FB2F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjEHOa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjEHOaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:30:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E01E2129
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:29:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115eef620so34841917b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683556193; x=1686148193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ds73gnsFVEJ6u1RVbKPdKJnDIubBpKmFNgu55xzWEbU=;
        b=lJgy3Bj1z5Uiu48QnHfq5K+VBP28Zxgip9ER4Yf6hmQQ8lPjaEpD0RK119Wik1cOJJ
         iTNHWt1R/TFttkaNBKF61wx8kI5nvD0D/9ouPhVmGkGdKBAO/f6u7tSxBsDns2PtEpHY
         oIiE2l2cRByWteEpf1vB2MkOni0dvyrKrnVlA/aMsfRfyhdhsK9izbxuoBPC0x7czg3s
         juTXnjpVJf5pYCmVakR0Cgvp94ANIYMAK+LbvnfCPgH307fCgx//lO8LcLCqPQvCnR2s
         yrH86CmjZ09YK9L2qscqvWOhivunsdFbAzxUvjvEKMVRsEx5Gn4gHywXyeDI8k3mww/1
         TxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556193; x=1686148193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ds73gnsFVEJ6u1RVbKPdKJnDIubBpKmFNgu55xzWEbU=;
        b=ZVZcoVA/yssf/MmS32OKLDHXf3F47VJ2Ehx0n8biDd/KDN60Va/ZTU4B79kpPpgXob
         t9IdKucb42WqcLm2sU4TdHazh29hw4jVm0+G7TQ19ws7SRMPYQQ6TNFf1wSiXCJ9LIOM
         UoGVVXX9KO+WN7eMyzCekcTRNeAl+WOLExXpiPZyhO6e2iIoSEC1BUE+S2Bw2EncRLHN
         hnpSQfCcFdXCBu8LqMd1f5JdEejCffV2bh6Tr7IMJ4ChdnCDX7yIr+q0UqNt9bHoZOcc
         /owiVN6r1r6Bxw94VsRbiJWUPcsX0B7soocNTX684OkIQg8KRC87ey8SdAkHxK7qjA2T
         t4iQ==
X-Gm-Message-State: AC+VfDxQdeLCQZsZgLmb/7i8psmaIqYETnRHdRCaDJZN9mqTL02laUV7
        385at7FYAdkrRWU8yh6MJmL0OQ==
X-Google-Smtp-Source: ACHHUZ7IFh1sQXPuJWRHj2WWGpozWbXGdVg2fdaqzgld/0LycsTzWlJonjSeEsRixOIeWaZl5X+7Vg==
X-Received: by 2002:a05:6a20:a5a8:b0:d9:adc3:6a71 with SMTP id bc40-20020a056a20a5a800b000d9adc36a71mr10379138pzb.1.1683556193560;
        Mon, 08 May 2023 07:29:53 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.206])
        by smtp.gmail.com with ESMTPSA id k3-20020aa790c3000000b0063d46ec5777sm6082pfk.158.2023.05.08.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 07:29:53 -0700 (PDT)
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
Subject: [PATCH v3 11/11] MAINTAINERS: Add entry for RISC-V AIA drivers
Date:   Mon,  8 May 2023 19:58:42 +0530
Message-Id: <20230508142842.854564-12-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508142842.854564-1-apatel@ventanamicro.com>
References: <20230508142842.854564-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for RISC-V AIA drivers including the
RISC-V INTC driver which supports both AIA and non-AIA platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 083ba321fc7c..8f00b56ef8d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18111,6 +18111,18 @@ F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
 
+RISC-V AIA DRIVERS
+M:	Anup Patel <anup@brainfault.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/riscv,imsics.yaml
+F:	drivers/irqchip/irq-riscv-aplic.c
+F:	drivers/irqchip/irq-riscv-imsic.c
+F:	drivers/irqchip/irq-riscv-intc.c
+F:	include/linux/irqchip/riscv-aplic.h
+F:	include/linux/irqchip/riscv-imsic.h
+
 RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
-- 
2.34.1

