Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434696E84E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjDSW1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjDSW1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:27:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1488D309
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:25:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517bb01bac9so218160a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681943059; x=1684535059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92JmYNvjI4h3x1v84zDdO04a6NNcBv03E/psDBTJE8A=;
        b=nUPF7sXfdzfSW6QquvIfaq4GAfSYyZeAk0mT1xklq8pqmC8JoWNIvCjy+zgsODVUHq
         O1IjPJuK8sxnkfCXOFdrW+u9RpzMDpy7y7UdhAG0oCuYW3dH8GSGsOh9ODDRIxw2eaFz
         bkM34qwDSq7IzfX047RwYqZPP8OQknDg9R1karBknWrofSn/KUs6wUf/rHdpra1bOATf
         rzsEvtKv0XMZjsFArXphtLo3X7lGUkjGEGkW6yljl786vgCvygViLOvHooAc3u8hDTWy
         WbwJ4EH+yr+KTGNMLcFTkEfYKE8eHBN2A40w7EVpD08O7tCunWfP2Fwi90JATCfWffYG
         bUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943059; x=1684535059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92JmYNvjI4h3x1v84zDdO04a6NNcBv03E/psDBTJE8A=;
        b=PJy43iOoVWJzAXxi8o0u5f+adRyFG3jb05p5qHkoaVwLMb908wQ5KgaqkOpZnAGTOF
         MtUoGNSk1LR86Ak9203U0qP1y3id+UX+Z0cFXSBrGjpqdqeat29woucCuVLa3cGN40G1
         0Uiuvz5gRNW5b3f2nbzuufWezhBKOgQI01itUaLnoB8JjPN3vVo3MEPidXy7a7aYazLY
         zeIGFrgF/Ct7UrEdEvwsRG8F3vB6S6PkrzRakyWMVyH+kpqGncTx3XfwzlqQSrPhSqXb
         YaV83pC0yqMFbuxkN5aG73DQYApKPRESbv5bwLGRQeRcG8jhPvaSWW/tamP9do6EC6r9
         YmOg==
X-Gm-Message-State: AAQBX9czsD3FeNz2uTL4IbV2LFYfgpMwcTQ2CRAAL3riodDDJ2jZF5fV
        plt199bizFE6Be192qTDelu409b4z4rURw/BbBg=
X-Google-Smtp-Source: AKy350Z85naSstLXZzvY5D57utZL9LkLhfRNOpeuO+9VtZ6rJWlxmJ/TTxgn/rQUXeeW25YB/WTEcw==
X-Received: by 2002:a17:90a:cf81:b0:247:1f35:3314 with SMTP id i1-20020a17090acf8100b002471f353314mr3406729pju.48.1681943059019;
        Wed, 19 Apr 2023 15:24:19 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001a681fb3e77sm11867810plt.44.2023.04.19.15.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:24:18 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rajnesh Kanwal <rkanwal@rivosinc.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-coco@lists.linux.dev, Dylan Reid <dylan@rivosinc.com>,
        abrestic@rivosinc.com, Samuel Ortiz <sameo@rivosinc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [RFC kvmtool 09/10] riscv: Don't emit MMIO devices for CoVE VM.
Date:   Wed, 19 Apr 2023 15:23:49 -0700
Message-Id: <20230419222350.3604274-10-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419222350.3604274-1-atishp@rivosinc.com>
References: <20230419222350.3604274-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

The CoVE VMs do not support MMIO devices yet. Do not emit
MMIO device nodes for CoVE VMs.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 riscv/fdt.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/riscv/fdt.c b/riscv/fdt.c
index 07ec336..a7d32b3 100644
--- a/riscv/fdt.c
+++ b/riscv/fdt.c
@@ -210,22 +210,25 @@ static int setup_fdt(struct kvm *kvm)
 			       riscv_irqchip_phandle));
 	_FDT(fdt_property(fdt, "ranges", NULL, 0));
 
-	/* Virtio MMIO devices */
-	dev_hdr = device__first_dev(DEVICE_BUS_MMIO);
-	while (dev_hdr) {
-		generate_mmio_fdt_nodes = dev_hdr->data;
-		generate_mmio_fdt_nodes(fdt, dev_hdr,
-					riscv__generate_irq_prop);
-		dev_hdr = device__next_dev(dev_hdr);
-	}
+	/* CoVE VMs do not support MMIO devices yet */
+	if (!kvm->cfg.arch.cove_vm) {
+		/* Virtio MMIO devices */
+		dev_hdr = device__first_dev(DEVICE_BUS_MMIO);
+		while (dev_hdr) {
+			generate_mmio_fdt_nodes = dev_hdr->data;
+			generate_mmio_fdt_nodes(fdt, dev_hdr,
+						riscv__generate_irq_prop);
+			dev_hdr = device__next_dev(dev_hdr);
+		}
 
-	/* IOPORT devices */
-	dev_hdr = device__first_dev(DEVICE_BUS_IOPORT);
-	while (dev_hdr) {
-		generate_mmio_fdt_nodes = dev_hdr->data;
-		generate_mmio_fdt_nodes(fdt, dev_hdr,
-					riscv__generate_irq_prop);
-		dev_hdr = device__next_dev(dev_hdr);
+		/* IOPORT devices */
+		dev_hdr = device__first_dev(DEVICE_BUS_IOPORT);
+		while (dev_hdr) {
+			generate_mmio_fdt_nodes = dev_hdr->data;
+			generate_mmio_fdt_nodes(fdt, dev_hdr,
+						riscv__generate_irq_prop);
+			dev_hdr = device__next_dev(dev_hdr);
+		}
 	}
 
 	/* PCI host controller */
-- 
2.25.1

