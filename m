Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74062609C46
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJXIQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiJXIQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A3C4D800
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666599305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+dfYrksNn4TdevHXr7sUSqhlmuSgsZD4nCKZ/IkdDk=;
        b=cAUvlvdr7ErAxFrnDg3jWxpv9aR9iP+rNipsO3fUy4JQ2pDQxhIEOeTtuK8mqy7ovZWVio
        prdJHB2NMjLhc7Y4IlKA/DzvkA1AHxUix9LM8a5y8OXBlSmZlHXuVhcaodYYY7SqcLLMuC
        zzzZRENNCUDRpZ4UiC23EeKBpafZhDU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-6Bt9hgApOOS0VLkaDLvcJA-1; Mon, 24 Oct 2022 04:14:59 -0400
X-MC-Unique: 6Bt9hgApOOS0VLkaDLvcJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED68C185A78F;
        Mon, 24 Oct 2022 08:14:58 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C16240C6FA0;
        Mon, 24 Oct 2022 08:14:54 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 4/8] mm/percpu: add comment to state the empty populated pages accounting
Date:   Mon, 24 Oct 2022 16:14:31 +0800
Message-Id: <20221024081435.204970-5-bhe@redhat.com>
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

When allocating an area from a chunk, pcpu_block_update_hint_alloc()
is called to update chunk metadata, including chunk's and global
nr_empty_pop_pages. However, if the allocation is not atomic, some
blocks may not be populated with pages yet, while we still account it
here. The number of pages will be subtracted with pcpu_chunk_populated()
when populating pages.

Adding code comment to make that more understandable.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/percpu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index a8121302a79c..09e407338573 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -831,13 +831,15 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
 
 	/*
 	 * Update s_block.
-	 * block->first_free must be updated if the allocation takes its place.
-	 * If the allocation breaks the contig_hint, a scan is required to
-	 * restore this hint.
 	 */
 	if (s_block->contig_hint == PCPU_BITMAP_BLOCK_BITS)
 		nr_empty_pages++;
 
+	/*
+	 * block->first_free must be updated if the allocation takes its place.
+	 * If the allocation breaks the contig_hint, a scan is required to
+	 * restore this hint.
+	 */
 	if (s_off == s_block->first_free)
 		s_block->first_free = find_next_zero_bit(
 					pcpu_index_alloc_map(chunk, s_index),
@@ -912,6 +914,12 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
 		}
 	}
 
+	/*
+	 * If the allocation is not atomic, some blocks may not
+	 * be populated with pages, while we account it here.
+	 * The number of pages will be subtracted with
+	 * pcpu_chunk_populated() when populating pages.
+	 */
 	if (nr_empty_pages)
 		pcpu_update_empty_pages(chunk, -nr_empty_pages);
 
-- 
2.34.1

