Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8338F72E75E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbjFMPgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243011AbjFMPgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:36:38 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0213E1FED
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:36:03 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39ce0ab782fso1499203b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686670542; x=1689262542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2Xd9VrBwLbHtLKIQskpVMxqXuUIvC51FdoSD93zF58=;
        b=eoDG88MPohQdD8mTy13OLdX2W8nk3lkOY7N/bPjxNBYi0Vv3N8OVnfd0FU/nsMIMgl
         SsXoSqpVhq1E1lHktImYF6Ehvf6+LfsX8r6QWsdCWYRsaj+2kssVdlR4E75yiArARoFg
         VGPCHUGwSy7HUO3GHtnxBWwPoJx1RDH73dD1JWRZ4N4cifO4f3bDmNZ9aZrlm+mpA0pq
         GaFzQyLnUrf3j3rtMEjbzkGSRXFzWB/rI+GCfKBoPjbsC5mbpHv9ulNqZ/BxZEM3NSgy
         LUrS+4dmRel9oWXxqXUcrEGWFBMZOhtLij2yXuQovR7xCUgw+kubX5ePh/gS4vnvwEIC
         LmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670542; x=1689262542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2Xd9VrBwLbHtLKIQskpVMxqXuUIvC51FdoSD93zF58=;
        b=M092aV79+dWdHab16Q4nNMjhWN12rBPP3dXmvACoMj0vgG+g+KD1OuT5CxcD9h0C76
         EdPXXwPpJL23rWUL6qRCEBAPVREerdxgM0S5iRttNFOWiTRljU32S44QEEF+hflT35M3
         tFfN3elJHisLvNKl7O/Aqd0bH1BB0e9Sal8NKCxpLJUcJDdg9DpACVpNuK8vx6BaEXjD
         0m6oJUZX8n13zSKYQSlL3KMY6nNxxQYD8VL6vif/q16MocDJQb66Ap7pn4hvGHbMs3Ql
         acsq+CzpgSXudyX2taOXQ02tOL6dvFcxOpQI1kaLhRNsfuxR2h5p8XP7Un9dstgLfIWl
         s92w==
X-Gm-Message-State: AC+VfDzgUb+5o+mXH1ChKjFd+r+VXYnl+qVjyQetWuPKluXj54lHRDRH
        /Rlxeo2fmLuOHvd1kin7H0PZXg==
X-Google-Smtp-Source: ACHHUZ4fGN6+pLsSEZtbSZN+RvQPBaMKXCh9QusFq41gaS7bI9BEqNW3PdifLeNjp8b1Uwl6EKWtOA==
X-Received: by 2002:a05:6808:1448:b0:399:169:75d8 with SMTP id x8-20020a056808144800b00399016975d8mr9406572oiv.35.1686670542358;
        Tue, 13 Jun 2023 08:35:42 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n2-20020acabd02000000b0039ce305ea4fsm1630807oif.14.2023.06.13.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:35:42 -0700 (PDT)
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
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 09/10] RISC-V: Select APLIC and IMSIC drivers
Date:   Tue, 13 Jun 2023 21:04:14 +0530
Message-Id: <20230613153415.350528-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613153415.350528-1-apatel@ventanamicro.com>
References: <20230613153415.350528-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index ff37d8ebe989..19233d59be37 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -136,6 +136,8 @@ config RISCV
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

