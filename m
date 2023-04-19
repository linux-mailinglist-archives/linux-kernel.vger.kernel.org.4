Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DC36E8508
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjDSWfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjDSWe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:34:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1D5359C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:34:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a8097c1ccfso5411235ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681943592; x=1684535592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joeGaZNojBtAEH48oFyXyXsTdXyxZ+syATM0NtCwkJg=;
        b=ntvu7mkg4AjS+6jbV0G8nxsZY4v30uZ4L6H/4yKw7ILa4JZ8ImylR4y1268f4Z50RK
         yp3K3jByMPLCRLbHX4cBVCaB/0HMZJcwshCnzpnr/gUVuDntELj2Puzl5waJ86AQM7L9
         davbmjlnfHoalz4Q2lB4J0u4kB5RV16Hhc3wzLWodVpXh3zvq8PFAGReDNP2mrS7xdGD
         s6Il5ZWD0yfr64TRt9aWFImjZVZA3EaV0LaCFlieNMHfOgF+upQm4kqT5dlP7kvhL/I4
         rM96oHWIPJOoV8LegDMD0aG63ZYJqSc4uX4MGM5DeB8TnEBI9TTREJlSelnXxaSW74bU
         b1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681943592; x=1684535592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joeGaZNojBtAEH48oFyXyXsTdXyxZ+syATM0NtCwkJg=;
        b=hOOk/jX+yH6LOaMC7JHVHxwyPbhtYxz6YgtmyToDMzBBmFcErAK1A/IFsu+LuHvdsl
         85ubGq5voclPx2YirW3foTJLratiY6R5027c617PsQnIrdueMKnOEaVzhNd6M7H+qgFw
         CS4XSahYNU9inRaWmhSrM/dp4y9rw9NpYV38rBfjaLOzFeHC+kOO0fizVqFM0O6EhCHf
         eG++myLFuNL1QNhHfmqhEOG9l+PoxrVr+IUHbFffiA+iCjnf3V5Y8AS3OF4qXP+29bW4
         7lJ1NmN1SBE0E35IbxU2ZHoaC3LOe6JbdgTZV021LWYynwyk6IoEDlHhfYd8cPVQ/MtI
         3Qtg==
X-Gm-Message-State: AAQBX9eAavEsslDaK8TKn5DzL7IdIy3sbwzbt1G/dDXaoPHtvixbRots
        MTWtpxoZPg8CW93CxxGsUBMQAp9U5A1rqgXVVgo=
X-Google-Smtp-Source: AKy350bpDV/yb/MMXonhLvjhCzwnd1ozKuOFojavKdcbbpka5zKY4L/5Rw/zrIiOtje9GuJuXPaRMw==
X-Received: by 2002:a17:902:7891:b0:1a1:bf22:2b6e with SMTP id q17-20020a170902789100b001a1bf222b6emr6634040pll.43.1681943060762;
        Wed, 19 Apr 2023 15:24:20 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001a681fb3e77sm11867810plt.44.2023.04.19.15.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:24:20 -0700 (PDT)
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
Subject: [RFC kvmtool 10/10] riscv: cove: Don't emit interrupt_map for pci devices in fdt.
Date:   Wed, 19 Apr 2023 15:23:50 -0700
Message-Id: <20230419222350.3604274-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419222350.3604274-1-atishp@rivosinc.com>
References: <20230419222350.3604274-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

CoVE VMs don't support pin based interrupts yet as APLIC isn't
supported.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 riscv/fdt.c                  |  2 +-
 riscv/include/kvm/kvm-arch.h |  2 +-
 riscv/pci.c                  | 83 +++++++++++++++++++-----------------
 3 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/riscv/fdt.c b/riscv/fdt.c
index a7d32b3..115ae17 100644
--- a/riscv/fdt.c
+++ b/riscv/fdt.c
@@ -232,7 +232,7 @@ static int setup_fdt(struct kvm *kvm)
 	}
 
 	/* PCI host controller */
-	pci__generate_fdt_nodes(fdt);
+	pci__generate_fdt_nodes(fdt, kvm);
 
 	_FDT(fdt_end_node(fdt));
 
diff --git a/riscv/include/kvm/kvm-arch.h b/riscv/include/kvm/kvm-arch.h
index 08ac54a..9f6967f 100644
--- a/riscv/include/kvm/kvm-arch.h
+++ b/riscv/include/kvm/kvm-arch.h
@@ -104,7 +104,7 @@ void aia__create(struct kvm *kvm);
 
 void plic__create(struct kvm *kvm);
 
-void pci__generate_fdt_nodes(void *fdt);
+void pci__generate_fdt_nodes(void *fdt, struct kvm *kvm);
 
 int riscv__add_irqfd(struct kvm *kvm, unsigned int gsi, int trigger_fd,
 		     int resample_fd);
diff --git a/riscv/pci.c b/riscv/pci.c
index 9760ca3..31ea286 100644
--- a/riscv/pci.c
+++ b/riscv/pci.c
@@ -17,7 +17,7 @@ struct of_interrupt_map_entry {
 	u32				irqchip_sense;
 } __attribute__((packed));
 
-void pci__generate_fdt_nodes(void *fdt)
+void pci__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 {
 	struct device_header *dev_hdr;
 	struct of_interrupt_map_entry irq_map[OF_PCI_IRQ_MAP_MAX];
@@ -67,51 +67,56 @@ void pci__generate_fdt_nodes(void *fdt)
 	_FDT(fdt_property(fdt, "reg", &cfg_reg_prop, sizeof(cfg_reg_prop)));
 	_FDT(fdt_property(fdt, "ranges", ranges, sizeof(ranges)));
 
-	/* Generate the interrupt map ... */
-	dev_hdr = device__first_dev(DEVICE_BUS_PCI);
-	while (dev_hdr && nentries < ARRAY_SIZE(irq_map)) {
-		struct of_interrupt_map_entry *entry;
-		struct pci_device_header *pci_hdr = dev_hdr->data;
-		u8 dev_num = dev_hdr->dev_num;
-		u8 pin = pci_hdr->irq_pin;
-		u8 irq = pci_hdr->irq_line;
+	/* CoVE VMs do not support pin based interrupts yet as APLIC isn't
+	 * supported.
+	 */
+	if (!kvm->cfg.arch.cove_vm) {
+		/* Generate the interrupt map ... */
+		dev_hdr = device__first_dev(DEVICE_BUS_PCI);
+		while (dev_hdr && nentries < ARRAY_SIZE(irq_map)) {
+			struct of_interrupt_map_entry *entry;
+			struct pci_device_header *pci_hdr = dev_hdr->data;
+			u8 dev_num = dev_hdr->dev_num;
+			u8 pin = pci_hdr->irq_pin;
+			u8 irq = pci_hdr->irq_line;
 
-		entry = ((void *)irq_map) + (nsize * nentries);
-		*entry = (struct of_interrupt_map_entry) {
-			.pci_irq_mask = {
-				.pci_addr = {
-					.hi	= cpu_to_fdt32(of_pci_b_ddddd(dev_num)),
-					.mid	= 0,
-					.lo	= 0,
+			entry = ((void *)irq_map) + (nsize * nentries);
+			*entry = (struct of_interrupt_map_entry) {
+				.pci_irq_mask = {
+					.pci_addr = {
+						.hi	= cpu_to_fdt32(of_pci_b_ddddd(dev_num)),
+						.mid	= 0,
+						.lo	= 0,
+					},
+					.pci_pin	= cpu_to_fdt32(pin),
 				},
-				.pci_pin	= cpu_to_fdt32(pin),
-			},
-			.irqchip_phandle	= cpu_to_fdt32(riscv_irqchip_phandle),
-			.irqchip_line		= cpu_to_fdt32(irq),
-		};
+				.irqchip_phandle	= cpu_to_fdt32(riscv_irqchip_phandle),
+				.irqchip_line		= cpu_to_fdt32(irq),
+			};
 
-		if (riscv_irqchip_line_sensing)
-			entry->irqchip_sense = cpu_to_fdt32(IRQ_TYPE_LEVEL_HIGH);
+			if (riscv_irqchip_line_sensing)
+				entry->irqchip_sense = cpu_to_fdt32(IRQ_TYPE_LEVEL_HIGH);
 
-		nentries++;
-		dev_hdr = device__next_dev(dev_hdr);
-	}
+			nentries++;
+			dev_hdr = device__next_dev(dev_hdr);
+		}
 
-	_FDT(fdt_property(fdt, "interrupt-map", irq_map, nsize * nentries));
+		_FDT(fdt_property(fdt, "interrupt-map", irq_map, nsize * nentries));
 
-	/* ... and the corresponding mask. */
-	if (nentries) {
-		struct of_pci_irq_mask irq_mask = {
-			.pci_addr = {
-				.hi	= cpu_to_fdt32(of_pci_b_ddddd(-1)),
-				.mid	= 0,
-				.lo	= 0,
-			},
-			.pci_pin	= cpu_to_fdt32(7),
-		};
+		/* ... and the corresponding mask. */
+		if (nentries) {
+			struct of_pci_irq_mask irq_mask = {
+				.pci_addr = {
+					.hi	= cpu_to_fdt32(of_pci_b_ddddd(-1)),
+					.mid	= 0,
+					.lo	= 0,
+				},
+				.pci_pin	= cpu_to_fdt32(7),
+			};
 
-		_FDT(fdt_property(fdt, "interrupt-map-mask", &irq_mask,
-				  sizeof(irq_mask)));
+			_FDT(fdt_property(fdt, "interrupt-map-mask", &irq_mask,
+					  sizeof(irq_mask)));
+		}
 	}
 
 	/* Set MSI parent if available */
-- 
2.25.1

