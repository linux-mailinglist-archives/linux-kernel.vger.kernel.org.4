Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973D074D22A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGJJun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjGJJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:49:53 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0804C0B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:44:34 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7835e2286c4so131522139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688982274; x=1691574274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nImulFWj8VTnTfSKoHJB+uK3WiURTzzmP3Vx/VbcYKk=;
        b=VTXy68xec4bhmW9pDxJRs7Lxt4uPbC7gF4LMj48mQK3wzfGRHYRnzhEHcFqOuN0a2Q
         8D2W0e4Muoehc49zlwPInLGIs+XsV4/kiCUXtwsP1YDKg20B7wWOfsa9dEGXl4+Bq7C0
         NhT93td4VQlVckeX/H97oSdJA0ZOupz6weZwf4kDr0xjcrsaNcOxU6QK+4JEgxLqxMU5
         auXrDbsIrE0Jr+veAXz37+wx5eNLlgg9+Kj9rVlJ525lyXnji+xE4Cfbvf6PrmZxJi7P
         1Mot6oS4PHEWsZeObMD6K8UXixOEB/DyGZr70ywvLq4PHsZ2LIrZkVA15LRUzY+Mw8kX
         h1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982274; x=1691574274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nImulFWj8VTnTfSKoHJB+uK3WiURTzzmP3Vx/VbcYKk=;
        b=SCxYLYkCULaqgQDhA2co4h9V9pNxgRXPCuzwVynmC4EofzAcc0n1jRgs1l3NcNK0T+
         Sp3b284zRz5mpNdoQHW+XbybevPmrOoAvb2Jf0UwqezZYR/B4BYqvIntD4vcf4oFm4cL
         /5fSQKcM2oBj5n7yibrPao+vWZLoj4mAMAz5KY++38EZCptL5NArfzbdvnYyrvQ1gmKc
         cMbJ7d5AxmmqhYQ3iThZvBF3hmGtVKg41jlr8iKY4WKLCB9uj8M+YlZZzMkZy3TJmXJe
         jNq2F2krUjLO28sMKClRGiT7i9SyiQLFHO+/VnR69Fi5CzvEgrClJpFVaSUIIU7FxZAC
         32CQ==
X-Gm-Message-State: ABy/qLY78o+rweaeRtZPKp6SCcAPwiiBZ9RKwAWA1nMQrQ6EAuSoNdDo
        5B/K19sdWtsZOQ/ghc/yTOY7Fw==
X-Google-Smtp-Source: APBJJlEmg7w6H1qqHwnL/IRaN/E1TKRmVu1FkXayf8dTKGHPqVsNKfhgmgebsAz2pwfoUW45zxPWcw==
X-Received: by 2002:a6b:fd0c:0:b0:783:62d0:88c with SMTP id c12-20020a6bfd0c000000b0078362d0088cmr11520021ioi.19.1688982274020;
        Mon, 10 Jul 2023 02:44:34 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id k1-20020a6b7a41000000b007870c56387dsm936938iop.49.2023.07.10.02.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:44:33 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 8/9] RISC-V: Select APLIC and IMSIC drivers
Date:   Mon, 10 Jul 2023 15:13:20 +0530
Message-Id: <20230710094321.1378351-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710094321.1378351-1-apatel@ventanamicro.com>
References: <20230710094321.1378351-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c07b9189c86..318f62a0a187 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -148,6 +148,8 @@ config RISCV
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

