Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D08609C48
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJXIRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJXIQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952E258169
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666599313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3MWDQZ+YEFLhc1+KrcZwWlcxn1kI2z+4saRqDzwGGg=;
        b=NtxNg0iHzGYBL0/u08pCAo8H38CwXaXcI/da0n/quz/rz6rEhuC33FTjAs4WiLP9Q7uvc2
        UusPO2mNUOOukg2zbny3aQRKOZAeJpW9ywdf9tTFbEb9wR3bNfsSWXfzjh4xl/k+3UrmH4
        pvfAvxG48RPpnnCmoE7+1fcHtldRmf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-wHg3keIwOaOlWtfbqML-FQ-1; Mon, 24 Oct 2022 04:15:07 -0400
X-MC-Unique: wHg3keIwOaOlWtfbqML-FQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A019101A56C;
        Mon, 24 Oct 2022 08:15:07 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE37940C6FA0;
        Mon, 24 Oct 2022 08:15:03 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 6/8] mm/percpu.c: remove the lcm code since block size is fixed at page size
Date:   Mon, 24 Oct 2022 16:14:33 +0800
Message-Id: <20221024081435.204970-7-bhe@redhat.com>
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

Since commit b239f7daf553 ("percpu: set PCPU_BITMAP_BLOCK_SIZE to
PAGE_SIZE"), the PCPU_BITMAP_BLOCK_SIZE has been set to page size
fixedly. So the lcm code in pcpu_alloc_first_chunk() doesn't make
sense any more, clean it up.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/percpu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 954abf916c7d..96191f7b61ba 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -72,7 +72,6 @@
 #include <linux/cpumask.h>
 #include <linux/memblock.h>
 #include <linux/err.h>
-#include <linux/lcm.h>
 #include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/mm.h>
@@ -1347,7 +1346,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 							 int map_size)
 {
 	struct pcpu_chunk *chunk;
-	unsigned long aligned_addr, lcm_align;
+	unsigned long aligned_addr;
 	int start_offset, offset_bits, region_size, region_bits;
 	size_t alloc_size;
 
@@ -1355,14 +1354,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 	aligned_addr = tmp_addr & PAGE_MASK;
 
 	start_offset = tmp_addr - aligned_addr;
-
-	/*
-	 * Align the end of the region with the LCM of PAGE_SIZE and
-	 * PCPU_BITMAP_BLOCK_SIZE.  One of these constants is a multiple of
-	 * the other.
-	 */
-	lcm_align = lcm(PAGE_SIZE, PCPU_BITMAP_BLOCK_SIZE);
-	region_size = ALIGN(start_offset + map_size, lcm_align);
+	region_size = ALIGN(start_offset + map_size, PAGE_SIZE);
 
 	/* allocate chunk */
 	alloc_size = struct_size(chunk, populated,
-- 
2.34.1

