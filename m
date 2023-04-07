Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB06DA6D1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 03:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbjDGBQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 21:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjDGBQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B5683F2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 18:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680830122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=01JmNxplZurQ+Xgo8s8j9pd/36gHqtWFwc5rwB0ieoo=;
        b=GTAC+3lzBHetBUTRcttbJdmL+SX8qyaQ8CZrtsWY8kmRNrLPHfLxYeynhIeB1edoYf1lPl
        qjhSmyAs7lzvwGUYoP33RgkKuczuM53Ov1hI2KIbkHp5ImoOF2L1Bpq5swRbVTWJk6jSYQ
        mhwBLEZ6Y5YqZKB5aZcOs72RnTN13ZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-iYYgW6O4PA-YRirPD22h3A-1; Thu, 06 Apr 2023 21:15:17 -0400
X-MC-Unique: iYYgW6O4PA-YRirPD22h3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA241884340;
        Fri,  7 Apr 2023 01:15:16 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BC2C18EC6;
        Fri,  7 Apr 2023 01:15:10 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, rppt@kernel.org,
        thunder.leizhen@huawei.com, will@kernel.org, ardb@kernel.org,
        horms@kernel.org, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/3] arm64: kdump : take off the protection on crashkernel memory region
Date:   Fri,  7 Apr 2023 09:15:04 +0800
Message-Id: <20230407011507.17572-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

TODO:
======
Add purgatory to kexec_file_load interface on arm64, then checksum
verification can be done there to check if stamping on crashkernel
memory region happened.

v1->v2:
- When trying to revert commit 031495635b46, two hunks were missed in v1
  post. Remove them in v2. Thanks to Leizhen for pointing out this.
  - Remove code comment above arm64_dma_phys_limit definition added
    in commit 031495635b46;
  - Move the arm64_dma_phys_limit assignment back into zone_sizes_init()
    when both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are not enabled.

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
 arch/arm64/mm/init.c              | 34 +++---------------------
 arch/arm64/mm/mmu.c               | 43 -------------------------------
 5 files changed, 3 insertions(+), 105 deletions(-)

-- 
2.34.1

