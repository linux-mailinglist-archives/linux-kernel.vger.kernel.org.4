Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFD96C7EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjCXNUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjCXNT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5864B233CF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679663951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oqnpIZ5GkpM+kmmJnZqA1o1ZNLYJuti4DYPr6Ni2jEw=;
        b=N515RUu9ALD4Xv2eZt+IlhJqSrWciRQanYwShqZVpdphHun0N1hnhJnMKSP8p//kDHbcnN
        MVZse3FhPsJIYcTXopTHDYGTmAn5RolGZcqhCloWH9ikcmismlYjE3ebB6CrSeRtklwbRy
        PwjLCnONnIf7Wa3KVbF07C9cGHCkClU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-GK-E1deeOayVA85ZKw2nlA-1; Fri, 24 Mar 2023 09:19:06 -0400
X-MC-Unique: GK-E1deeOayVA85ZKw2nlA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B647A801206;
        Fri, 24 Mar 2023 13:19:05 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B494492B0A;
        Fri, 24 Mar 2023 13:19:00 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, horms@kernel.org,
        thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
        will@kernel.org, kexec@lists.infradead.org, ardb@kernel.org,
        rppt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] arm64: kdump: defer the crashkernel reservation for platforms with no DMA memory zones
Date:   Fri, 24 Mar 2023 21:18:38 +0800
Message-Id: <20230324131838.409996-4-bhe@redhat.com>
In-Reply-To: <20230324131838.409996-1-bhe@redhat.com>
References: <20230324131838.409996-1-bhe@redhat.com>
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

In commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
platforms with no DMA memory zones"), reserve_crashkernel() is called
much earlier in arm64_memblock_init() to avoid causing base apge
mapping on platforms with no DMA meomry zones.

With taking off protection on crashkernel memory region, no need to call
reserve_crashkernel() specially in advance. The deferred invocation of
reserve_crashkernel() in bootmem_init() can cover all cases.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/include/asm/memory.h | 5 -----
 arch/arm64/mm/init.c            | 6 +-----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 78e5163836a0..efcd68154a3a 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -374,11 +374,6 @@ static inline void *phys_to_virt(phys_addr_t x)
 })
 
 void dump_mem_limit(void);
-
-static inline bool defer_reserve_crashkernel(void)
-{
-	return IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
-}
 #endif /* !ASSEMBLY */
 
 /*
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 58a0bb2c17f1..b888de59e0b7 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -408,9 +408,6 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (!defer_reserve_crashkernel())
-		reserve_crashkernel();
-
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
 
@@ -457,8 +454,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	if (defer_reserve_crashkernel())
-		reserve_crashkernel();
+	reserve_crashkernel();
 
 	memblock_dump_all();
 }
-- 
2.34.1

