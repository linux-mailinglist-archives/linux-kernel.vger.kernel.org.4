Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3208C6519A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiLTDaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiLTDay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:30:54 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2731154;
        Mon, 19 Dec 2022 19:30:47 -0800 (PST)
X-UUID: 75e0fbb66a1a4df2badb6ea42cae5b38-20221220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=T+zbj0FiGEVmFNF2y0DWDBR6s5YDkdyhMts5oqZTM20=;
        b=mJVOPZD21Jlvpph1p1C8n1xsH2sLQLDvcQ9zhMten8jeNIgZ1WA7+8G7kJpSrv3k2ml8xl8o+tyDN/QHCnDey3dEWqVBKJj/YMF1UdQzLQeb7gjl7Vz03CdYYxOSKuJ02kQ8qNqiINWoKNkPUnSvusbOcaQhBvrRZaxmZjn/KEI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:06a7866e-cb6c-4d30-8c6a-3da2e83986b9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:92b265f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 75e0fbb66a1a4df2badb6ea42cae5b38-20221220
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1128956095; Tue, 20 Dec 2022 11:30:43 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 20 Dec 2022 11:30:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 20 Dec 2022 11:30:42 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <johan+linaro@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <maz@kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <tglx@linutronix.de>, <x86@kernel.org>, <yj.chiang@mediatek.com>,
        <phil.chang@mediatek.com>, <mark-pk.tsai@mediatek.com>
Subject: [PATCH v3 0/19] irqdomain: fix mapping race and clean up locking
Date:   Tue, 20 Dec 2022 11:30:42 +0800
Message-ID: <20221220033042.27724-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221209140150.1453-1-johan+linaro@kernel.org>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Parallel probing (e.g. due to asynchronous probing) of devices that
> share interrupts can currently result in two mappings for the same
> hardware interrupt to be created.
> 
> This series fixes this mapping race and clean up the irqdomain locking
> so that in the end the global irq_domain_mutex is only used for managing
> the likewise global irq_domain_list, while domain operations (e.g.
> IRQ allocations) use per-domain (hierarchy) locking.
> 
> Johan
> 
> 
> Changes in v2
>  - split out redundant-lookup cleanup (1/4)
>  - use a per-domain mutex to address mapping race (2/4)
>  - move kernel-doc to exported function (2/4)
>  - fix association race (3/4, new)
>  - use per-domain mutex for associations (4/4, new)
> 
> Changes in v3
>  - drop dead and bogus code (1--3/19, new)
>  - fix racy mapcount accesses (5/19, new)
>  - drop revmap mutex (6/19, new)
>  - use irq_domain_mutex to address mapping race (9/19)
>  - clean up irq_domain_push/pop_irq() (10/19, new)
>  - use irq_domain_create_hierarchy() to construct hierarchies
>    (11--18/19, new)
>  - switch to per-domain locking (19/19, new)
> 
> 
> Johan Hovold (19):
>   irqdomain: Drop bogus fwspec-mapping error handling
>   irqdomain: Drop dead domain-name assignment
>   irqdomain: Drop leftover brackets
>   irqdomain: Fix association race
>   irqdomain: Fix disassociation race
>   irqdomain: Drop revmap mutex
>   irqdomain: Look for existing mapping only once
>   irqdomain: Refactor __irq_domain_alloc_irqs()
>   irqdomain: Fix mapping-creation race
>   irqdomain: Clean up irq_domain_push/pop_irq()
>   x86/ioapic: Use irq_domain_create_hierarchy()
>   x86/apic: Use irq_domain_create_hierarchy()
>   irqchip/alpine-msi: Use irq_domain_add_hierarchy()
>   irqchip/gic-v2m: Use irq_domain_create_hierarchy()
>   irqchip/gic-v3-its: Use irq_domain_create_hierarchy()
>   irqchip/gic-v3-mbi: Use irq_domain_create_hierarchy()
>   irqchip/loongson-pch-msi: Use irq_domain_create_hierarchy()
>   irqchip/mvebu-odmi: Use irq_domain_create_hierarchy()
>   irqdomain: Switch to per-domain locking
> 
>  arch/x86/kernel/apic/io_apic.c         |   8 +-
>  arch/x86/platform/uv/uv_irq.c          |   7 +-
>  drivers/irqchip/irq-alpine-msi.c       |   8 +-
>  drivers/irqchip/irq-gic-v2m.c          |   5 +-
>  drivers/irqchip/irq-gic-v3-its.c       |  13 +-
>  drivers/irqchip/irq-gic-v3-mbi.c       |   5 +-
>  drivers/irqchip/irq-loongson-pch-msi.c |   9 +-
>  drivers/irqchip/irq-mvebu-odmi.c       |  13 +-
>  include/linux/irqdomain.h              |   6 +-
>  kernel/irq/irqdomain.c                 | 328 ++++++++++++++-----------
>  10 files changed, 220 insertions(+), 182 deletions(-)
> 
> -- 
> 2.37.4

Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

We have the same issue and this patch series fix that.
Thanks!

Link: https://lore.kernel.org/lkml/20221219130620.21092-1-mark-pk.tsai@mediatek.com/
