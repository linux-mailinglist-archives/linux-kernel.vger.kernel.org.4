Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586FD5F8249
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 04:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJHCDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 22:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJHCDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 22:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96131100BD1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 19:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665194608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YD1fTxgY2o9DCFb1V0sfmRfUUrcgW7r49fbNShbAR5Q=;
        b=UUnc/Xm5lYnJfPSJFBhQ/PtUUqR+BGBLT2t9ym6m8rAfpskRVoVRZAp4auxIrBp1OeutJQ
        Yrn7GQ5/o2JtYE1tE+3gWl+b4Z/mGgsF2rmv+NSwJp1WFT2upMvFVr5TiTSkVd1B5Zz/p5
        eb2ax4DbzRUJN0I/0nk+Va8vbcb7/Ws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-Ufjlb0awPO-I2J3CZeuVDg-1; Fri, 07 Oct 2022 22:03:24 -0400
X-MC-Unique: Ufjlb0awPO-I2J3CZeuVDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A554C95D683;
        Sat,  8 Oct 2022 02:03:23 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 204ED145BA60;
        Sat,  8 Oct 2022 02:03:22 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
        aahringo@redhat.com
Subject: [PATCH] mm: slab: comment __GFP_ZERO case for kmem_cache_alloc
Date:   Fri,  7 Oct 2022 22:03:12 -0400
Message-Id: <20221008020312.1932347-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will add a comment for the __GFP_ZERO flag case for
kmem_cache_alloc(). As the current comment mentioned that the flags only
matters if the cache has no available objects it's different for the
__GFP_ZERO flag which will ensure that the returned object is always
zeroed in any case.

I have the feeling I run into this question already two times if the
user need to zero the object or not, but the user does not need to zero
the object afterwards. However another use of __GFP_ZERO and only zero
the object if the cache has no available objects would also make no
sense.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 mm/slab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index 10e96137b44f..7a84c2aae85a 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3482,7 +3482,8 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
  * @flags: See kmalloc().
  *
  * Allocate an object from this cache.  The flags are only relevant
- * if the cache has no available objects.
+ * if the cache has no available objects. Except flag __GFP_ZERO which
+ * will zero the returned object.
  *
  * Return: pointer to the new object or %NULL in case of error
  */
-- 
2.31.1

