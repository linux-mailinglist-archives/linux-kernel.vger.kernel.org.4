Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D640E6C7EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjCXNTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjCXNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E9810261
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679663933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eq/LWUPaBWXPVPONNt+ItToEb0I4pgNnBO6KTxueUWc=;
        b=hH3IQ5MR8RzdvhHYnj47NOcbAv/wIECjrsJ2Po/HQfOePSMM57IUfWhmtT9dHM2bS6cv/c
        JMOXPbRJbGVDIuEEXupIEPexOeji9C3j661JGtMib++T4BJbeQEu9qHv47wWhyC6sGLm5b
        rcEpNSQiOMxaGqj1CgC7HovRyNBU7wE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-k6uFfsx5MiGYVH1ZdcxWyg-1; Fri, 24 Mar 2023 09:18:48 -0400
X-MC-Unique: k6uFfsx5MiGYVH1ZdcxWyg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08680101A54F;
        Fri, 24 Mar 2023 13:18:48 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD527492B0A;
        Fri, 24 Mar 2023 13:18:41 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org, ardb@kernel.org,
        rppt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] arm64: kdump : take off the protection on crashkernel memory region
Date:   Fri, 24 Mar 2023 21:18:35 +0800
Message-Id: <20230324131838.409996-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
=======
On arm64, block and section mapping is supported to build page tables.
However, currently it enforces to take base page mapping for the whole
linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
crashkernel kernel parameter is set. This will cause longer time of the
linear mapping process during bootup and severe performance degradation
during running time.

Root cause:
==========
On arm64, crashkernel reservation relies on knowing the upper limit of
low memory zone because it needs to reserve memory in the zone so that
devices' DMA addressing in kdump kernel can be satisfied. However, the
upper limit of low memory on arm64 is variant. And the upper limit can
only be decided late till bootmem_init() is called [1].

And we need to map the crashkernel region with base page granularity when
doing linear mapping, because kdump needs to protect the crashkernel region
via set_memory_valid(,0) after kdump kernel loading. However, arm64 doesn't
support well on splitting the built block or section mapping due to some
cpu reststriction [2]. And unfortunately, the linear mapping is done before
bootmem_init().

To resolve the above conflict on arm64, the compromise is enforcing to
take base page mapping for the entire linear mapping if crashkernel is
set, and CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabed. Hence
performance is sacrificed.

Solution:
=========
Comparing with the always encountered base page mapping for the whole
linear region, it's better to take off the protection on crashkernel memory
region for now because the protection can only happen in a chance in one
million, while the base page mapping for the whole linear mapping is
always mitigating arm64 systems with crashkernel set.

This can let distros have chance to back port this patchset to fix the
performance issue caused by the base page mapping in the whole linear
region.

Extra words
===========
I personally expect that  we can add these back in the near future
when arm64_dma_phys_limit is fixed, e.g Raspberry Pi enlarges the device
addressing limit to 32bit; or Arm64 can support splitting built block or
section mapping. Like this, the code is the simplest and clearest.

Or as Catalin suggested, for below 4 cases we currently defer to handle
in bootme_init(), we can try to handle case 3) in advance so that memory
above 4G can avoid base page mapping wholly. This will complicate the
already complex code, let's see how it looks if people interested post patch.

crashkernel=size
1)first attempt:  low memory under arm64_dma_phys_limit
2)fallback:       finding memory above 4G

crashkernel=size,high
3)first attempt:  finding memory above 4G
4)fallback:       low memory under arm64_dma_phys_limit


[1]
https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u

[2]
https://lore.kernel.org/linux-arm-kernel/20190911182546.17094-1-nsaenzjulienne@suse.de/T/

Baoquan He (3):
  arm64: kdump : take off the protection on crashkernel memory region
  arm64: kdump: do not map crashkernel region specifically
  arm64: kdump: defer the crashkernel reservation for platforms with no
    DMA memory zones

 arch/arm64/include/asm/kexec.h    |  6 -----
 arch/arm64/include/asm/memory.h   |  5 ----
 arch/arm64/kernel/machine_kexec.c | 20 --------------
 arch/arm64/mm/init.c              |  6 +----
 arch/arm64/mm/mmu.c               | 43 -------------------------------
 5 files changed, 1 insertion(+), 79 deletions(-)

-- 
2.34.1

