Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353E772E757
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbjFMPft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242950AbjFMPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:35:38 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53CD1FD2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:35:20 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-39ca0c2970aso3101347b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686670520; x=1689262520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kjtt6h/eyDXrsElx877q0CT0QQQHILU6z+NJTWoiedk=;
        b=F0n7O/vVGUEeM/PKWb7Z42XfLu2iO15eOSZ1qtJ/2T8+w6YlgN8iMf0woohYLxd0B4
         hDk/1yEUrPySol/SrvWYjwbhEKkeQPxZgtkHeenQLOW1Ds9gWx9KtJP9xX3g6I7B8CHi
         1HCbG2HBqPmTBqinxu6vHSmwuXvIN+SxjxXtc7bEFDpOw5jcCU79H7yY4E4Xz7QFnoev
         YmIne1HSSiSqw1XfyFU+GSIo+/WDJZ86GjJpPKnUA5UKFau8X0/dlJd4sP+QHGTxazDy
         okLEdA0XyiJRcyVqu9apcw4+1f+x9yL/+yhAftzTIDhEoK9nGMcYro7VdEgZndaDZkOP
         mhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670520; x=1689262520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kjtt6h/eyDXrsElx877q0CT0QQQHILU6z+NJTWoiedk=;
        b=RHBxZFKroPY1qNbe9RookKxw9WlHJCgcC7TqeN1gCdfkrcs0irBswepk5+q/PQW1rh
         K63Oud76EZMYQHXouj6F2WO8YrMRpc/6UxUb2m5lH6kfI1xTzoH6NHaIXT/VBRp29P4t
         gJZbSu053jPRD/NXNtsEvTuqo/GAtIrpKoewj6kdMVce/Xyse40JX/2l+YYk6j2lB9NP
         P6PddDFCx/ha9HPcfiYgLai41AaqqyzAgHYKalDmdkCCmLVZyOHbQY9k7ncvGVUrCfbm
         umSNWDm1q5uLtUCwsbdIDOOtW73S1enYKciEAivAmC8f+857r7yPjh0yNKT5yKpE0z6d
         lz5A==
X-Gm-Message-State: AC+VfDyssP/wCDunyK0AJayHTA1CjRxJfc/Lqyk7Kk8xZnP92L0tng/l
        88Gm0q2EESbYd9c1kuN0NGexnMY92OVLhhOlmfI=
X-Google-Smtp-Source: ACHHUZ5tX/SjcwqcOnkrDPg1GUxe68ARht3DVnlyVF5s2FrIHG804D7O2i5qR7HAEpiuWTv/u0W5PQ==
X-Received: by 2002:a05:6808:208e:b0:39c:464f:a55f with SMTP id s14-20020a056808208e00b0039c464fa55fmr10111693oiw.24.1686670519867;
        Tue, 13 Jun 2023 08:35:19 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n2-20020acabd02000000b0039ce305ea4fsm1630807oif.14.2023.06.13.08.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:35:19 -0700 (PDT)
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
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH v4 06/10] irqchip/riscv-imsic: Improve IOMMU DMA support
Date:   Tue, 13 Jun 2023 21:04:11 +0530
Message-Id: <20230613153415.350528-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613153415.350528-1-apatel@ventanamicro.com>
References: <20230613153415.350528-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a separate RISC-V IMSIC MSI address for each CPU so changing
MSI (or IRQ) affinity results in re-programming of MSI address in
the PCIe (or platform) device.

Currently, the iommu_dma_prepare_msi() is called only once at the
time of IRQ allocation so IOMMU DMA domain will only have mapping
for one MSI page. This means iommu_dma_compose_msi_msg() called
by imsic_irq_compose_msi_msg() will always use the same MSI page
irrespective to target CPU MSI address. In other words, changing
MSI (or IRQ) affinity for device using IOMMU DMA domain will not
work.

To address the above issue, we do the following:
1) Map MSI pages for all CPUs in imsic_irq_domain_alloc()
   using iommu_dma_prepare_msi().
2) Extend iommu_dma_compose_msi_msg() to lookup the correct
   msi_page whenever the msi_page stored as iommu cookie
   does not match.

Reported-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/iommu/dma-iommu.c         | 24 +++++++++++++++++++++---
 drivers/irqchip/irq-riscv-imsic.c | 23 +++++++++++------------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7a9f0b0bddbd..df96bcccbe28 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1687,14 +1687,32 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	struct device *dev = msi_desc_to_dev(desc);
 	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	const struct iommu_dma_msi_page *msi_page;
+	struct iommu_dma_cookie *cookie;
+	phys_addr_t msi_addr;
 
-	msi_page = msi_desc_get_iommu_cookie(desc);
+	if (!domain || !domain->iova_cookie)
+		return;
 
-	if (!domain || !domain->iova_cookie || WARN_ON(!msi_page))
+	cookie = domain->iova_cookie;
+	msi_page = msi_desc_get_iommu_cookie(desc);
+	if (!msi_page || msi_page->phys != msi_addr) {
+		msi_addr = ((u64)msg->address_hi << 32) | msg->address_lo;
+		msi_addr &= ~(phys_addr_t)(cookie_msi_granule(cookie) - 1);
+
+		msi_desc_set_iommu_cookie(desc, NULL);
+		list_for_each_entry(msi_page, &cookie->msi_page_list, list) {
+			if (msi_page->phys == msi_addr) {
+				msi_desc_set_iommu_cookie(desc, msi_page);
+				break;
+			}
+		}
+		msi_page = msi_desc_get_iommu_cookie(desc);
+	}
+	if (WARN_ON(!msi_page))
 		return;
 
 	msg->address_hi = upper_32_bits(msi_page->iova);
-	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
+	msg->address_lo &= cookie_msi_granule(cookie) - 1;
 	msg->address_lo += lower_32_bits(msi_page->iova);
 }
 
diff --git a/drivers/irqchip/irq-riscv-imsic.c b/drivers/irqchip/irq-riscv-imsic.c
index 30247c84a6b0..19dedd036dd4 100644
--- a/drivers/irqchip/irq-riscv-imsic.c
+++ b/drivers/irqchip/irq-riscv-imsic.c
@@ -493,11 +493,18 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain,
 	int i, hwirq, err = 0;
 	unsigned int cpu;
 
-	err = imsic_get_cpu(&imsic->lmask, false, &cpu);
-	if (err)
-		return err;
+	/* Map MSI address of all CPUs */
+	for_each_cpu(cpu, &imsic->lmask) {
+		err = imsic_cpu_page_phys(cpu, 0, &msi_addr);
+		if (err)
+			return err;
+
+		err = iommu_dma_prepare_msi(info->desc, msi_addr);
+		if (err)
+			return err;
+	}
 
-	err = imsic_cpu_page_phys(cpu, 0, &msi_addr);
+	err = imsic_get_cpu(&imsic->lmask, false, &cpu);
 	if (err)
 		return err;
 
@@ -505,10 +512,6 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain,
 	if (hwirq < 0)
 		return hwirq;
 
-	err = iommu_dma_prepare_msi(info->desc, msi_addr);
-	if (err)
-		goto fail;
-
 	for (i = 0; i < nr_irqs; i++) {
 		imsic_id_set_target(hwirq + i, cpu);
 		irq_domain_set_info(domain, virq + i, hwirq + i,
@@ -528,10 +531,6 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain,
 	}
 
 	return 0;
-
-fail:
-	imsic_ids_free(hwirq, get_count_order(nr_irqs));
-	return err;
 }
 
 static void imsic_irq_domain_free(struct irq_domain *domain,
-- 
2.34.1

