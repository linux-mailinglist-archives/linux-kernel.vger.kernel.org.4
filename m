Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E97C60C255
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJYDpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiJYDp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E8E13CE3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666669523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2yyOON7LbQAPpeXWsN3XLmEjn+mjaX4CQWaI9pF4woU=;
        b=WPYIEjBBi2XIMZjDV5S9UEJOPOpL1lUc65Q7eXdg1r+XvnOrthyxDrFmYrZ0NxmGy26POc
        A/BLyALTxghTdAgUehIzB5jUM1UiFSvPjoFtwHmlTfxc6HoLCuPSYRgVGp7AQAy6GHqz4f
        rkaqUr8RvDs1W4icDR5+2pIxhQryTWI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-7uFxu-DhM2uK7vANZRugxQ-1; Mon, 24 Oct 2022 23:45:21 -0400
X-MC-Unique: 7uFxu-DhM2uK7vANZRugxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD4341C0514E;
        Tue, 25 Oct 2022 03:45:20 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D642020290A2;
        Tue, 25 Oct 2022 03:45:19 +0000 (UTC)
Date:   Tue, 25 Oct 2022 11:45:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH v2 4/8] mm/percpu: add comment to state the empty populated
 pages accounting
Message-ID: <Y1dbzOCshNffkbY8@MiWiFi-R3L-srv>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-5-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
blocks may not be populated with pages yet, while we still subtract 
the number here. The number of pages will be added back with
pcpu_chunk_populated() when populating pages.

Adding code comment to make that more understandable.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
- I said the opposite in the v1 code comment. It subtracts the nr_empty_pop_pages
  whether it's atomic allocation or not. In non atomic case, the number
  will be added back in pcpu_chunk_populated() when populating pages.

 mm/percpu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 68d5ba61c935..786c7a2eb4f0 100644
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
+	 * If the allocation is not atomic, some blocks may not be
+	 * populated with pages, while we account it here. The number
+	 * of pages will be added back with pcpu_chunk_populated()
+	 * when populating pages.
+	 */
 	if (nr_empty_pages)
 		pcpu_update_empty_pages(chunk, -nr_empty_pages);
 
-- 
2.34.1

