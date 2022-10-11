Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F05FB765
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiJKPeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiJKPdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF2311C257
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665501741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gxl14rr+gZ4Prexr6Gkf/0xrN2bYKr3cP8aqjLcL9tI=;
        b=PzuEoo0aA2EPy7s3DolGqcBafmmhTh7de1OFMsv5IsIxB4DwKOnEZtOSrzAzUWrP3i2ebH
        S4z4HM2sFZFMqxeXQiCyiG25q1MYXSjgX1sHDawcV6H0k48ZxCRxR65geJNnlxVpgVUu6T
        L7I1bGuHu6063ohxq1z32afCfGBWN2Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-RLHEwjdZOHq8IbtPh4QX3w-1; Tue, 11 Oct 2022 10:54:18 -0400
X-MC-Unique: RLHEwjdZOHq8IbtPh4QX3w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E0AB3817962;
        Tue, 11 Oct 2022 14:54:16 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6751475066;
        Tue, 11 Oct 2022 14:54:14 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
        aahringo@redhat.com
Subject: [PATCHv2] mm: slab: comment __GFP_ZERO case for kmem_cache_alloc
Date:   Tue, 11 Oct 2022 10:54:13 -0400
Message-Id: <20221011145413.8025-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
changes since v2:
 - don't make a separate sentence for except

 mm/slab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index 10e96137b44f..a86879f42f2e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3482,7 +3482,8 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
  * @flags: See kmalloc().
  *
  * Allocate an object from this cache.  The flags are only relevant
- * if the cache has no available objects.
+ * if the cache has no available objects, except flag __GFP_ZERO which
+ * will zero the returned object.
  *
  * Return: pointer to the new object or %NULL in case of error
  */
-- 
2.31.1

