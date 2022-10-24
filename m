Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6A6609C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiJXISs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJXISM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516E65008
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666599330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oB5FHCqdQzRcpJOgYsd1zcN5d+GwusZuRHj9Ye7P85Q=;
        b=MVVPlPV/zqchGBRP0L9jJ4IXX1nNCVDaaVg/AR6d6GrM6k8ReNJrJzgu59nRLD4umPcNJg
        Sdvk4qEZNx2AdpLs5tmLwSiaIbzCScmh/rz+B9XVM5E3adN44QTZfqoZlDkcNm6ZKgug86
        L5kBwgxIK7jeeB1ZdKOPMYcpWaEpSVY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-md_8dzoMOzCwdktsUExyUg-1; Mon, 24 Oct 2022 04:15:20 -0400
X-MC-Unique: md_8dzoMOzCwdktsUExyUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70B7E887400;
        Mon, 24 Oct 2022 08:15:19 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D63C40C6F9F;
        Mon, 24 Oct 2022 08:15:12 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH 8/8] mm/slub, percpu: correct the calculation of early percpu allocation size
Date:   Mon, 24 Oct 2022 16:14:35 +0800
Message-Id: <20221024081435.204970-9-bhe@redhat.com>
In-Reply-To: <20221024081435.204970-1-bhe@redhat.com>
References: <20221024081435.204970-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLUB allocator relies on percpu allocator to initialize its ->cpu_slab
during early boot. For that, the dynamic chunk of percpu which serves
the early allocation need be large enough to satisfy the kmalloc
creation.

However, the current BUILD_BUG_ON() in alloc_kmem_cache_cpus() doesn't
consider the kmalloc array with NR_KMALLOC_TYPES length. Fix that
with correct calculation.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 157527d7101b..8ac3bb9a122a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4017,7 +4017,8 @@ init_kmem_cache_node(struct kmem_cache_node *n)
 static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
 {
 	BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
-			KMALLOC_SHIFT_HIGH * sizeof(struct kmem_cache_cpu));
+			NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *
+			sizeof(struct kmem_cache_cpu));
 
 	/*
 	 * Must align to double word boundary for the double cmpxchg
-- 
2.34.1

