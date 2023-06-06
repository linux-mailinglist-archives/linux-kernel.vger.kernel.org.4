Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52057250DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbjFFXiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbjFFXiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A876E5B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 16:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686094644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j899oAscb6cex41LPnjVmfNp2o1cfXB+0VQl+ebVWlM=;
        b=TJyamHJRqTCr7j7DdzS+/5q8A6B3vAPgzMkVBswWQMIU3b16Tm2u2UlHFBktKiXxBMD+Oq
        FY9RoY+bT4WecZGhmleRDmbuXe27+oeEASFXDfh5zHAIGIhBZV4sXNaKV1Uh0RNxqPMBP5
        Hwdk7/cUxFmkHLMrjXm6+Z310DHTwq4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-2SyWs4g3OyWkn5jowNs9ig-1; Tue, 06 Jun 2023 19:37:23 -0400
X-MC-Unique: 2SyWs4g3OyWkn5jowNs9ig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F9D280120A;
        Tue,  6 Jun 2023 23:37:22 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.22.17.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6C8A40CFD46;
        Tue,  6 Jun 2023 23:37:13 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        Aristeu Rozanski <aris@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: [PATCH] writeback: fix dereferencing NULL mapping->host on writeback_page_template
Date:   Tue,  6 Jun 2023 19:36:13 -0400
Message-Id: <20230606233613.1290819-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When commit 19343b5bdd16 ("mm/page-writeback: introduce tracepoint for
wait_on_page_writeback()") repurposed the writeback_dirty_page trace event
as a template to create its new wait_on_page_writeback trace event, it
ended up opening a window to NULL pointer dereference crashes due to
the (infrequent) occurrence of a race where an access to a page in the
swap-cache happens concurrently with the moment this page is being
written to disk and the tracepoint is enabled:

    BUG: kernel NULL pointer dereference, address: 0000000000000040
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 800000010ec0a067 P4D 800000010ec0a067 PUD 102353067 PMD 0
    Oops: 0000 [#1] PREEMPT SMP PTI
    CPU: 1 PID: 1320 Comm: shmem-worker Kdump: loaded Not tainted 6.4.0-rc5+ #13
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230301gitf80f052277c8-1.fc37 03/01/2023
    RIP: 0010:trace_event_raw_event_writeback_folio_template+0x76/0xf0
    Code: 4d 85 e4 74 5c 49 8b 3c 24 e8 06 98 ee ff 48 89 c7 e8 9e 8b ee ff ba 20 00 00 00 48 89 ef 48 89 c6 e8 fe d4 1a 00 49 8b 04 24 <48> 8b 40 40 48 89 43 28 49 8b 45 20 48 89 e7 48 89 43 30 e8 a2 4d
    RSP: 0000:ffffaad580b6fb60 EFLAGS: 00010246
    RAX: 0000000000000000 RBX: ffff90e38035c01c RCX: 0000000000000000
    RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90e38035c044
    RBP: ffff90e38035c024 R08: 0000000000000002 R09: 0000000000000006
    R10: ffff90e38035c02e R11: 0000000000000020 R12: ffff90e380bac000
    R13: ffffe3a7456d9200 R14: 0000000000001b81 R15: ffffe3a7456d9200
    FS:  00007f2e4e8a15c0(0000) GS:ffff90e3fbc80000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000000040 CR3: 00000001150c6003 CR4: 0000000000170ee0
    Call Trace:
     <TASK>
     ? __die+0x20/0x70
     ? page_fault_oops+0x76/0x170
     ? kernelmode_fixup_or_oops+0x84/0x110
     ? exc_page_fault+0x65/0x150
     ? asm_exc_page_fault+0x22/0x30
     ? trace_event_raw_event_writeback_folio_template+0x76/0xf0
     folio_wait_writeback+0x6b/0x80
     shmem_swapin_folio+0x24a/0x500
     ? filemap_get_entry+0xe3/0x140
     shmem_get_folio_gfp+0x36e/0x7c0
     ? find_busiest_group+0x43/0x1a0
     shmem_fault+0x76/0x2a0
     ? __update_load_avg_cfs_rq+0x281/0x2f0
     __do_fault+0x33/0x130
     do_read_fault+0x118/0x160
     do_pte_missing+0x1ed/0x2a0
     __handle_mm_fault+0x566/0x630
     handle_mm_fault+0x91/0x210
     do_user_addr_fault+0x22c/0x740
     exc_page_fault+0x65/0x150
     asm_exc_page_fault+0x22/0x30

This problem arises from the fact that the repurposed writeback_dirty_page
trace event code was written assuming that every pointer to mapping
(struct address_space) would come from a file-mapped page-cache object,
thus mapping->host would always be populated, and that was a valid case
before commit 19343b5bdd16. The swap-cache address space (swapper_spaces),
however, doesn't populate its ->host (struct inode) pointer, thus leading
to the crashes in the corner-case aforementioned.

commit 19343b5bdd16 ended up breaking the assignment of __entry->name and
__entry->ino for the wait_on_page_writeback tracepoint -- both dependent
on mapping->host carrying a pointer to a valid inode. The assignment of
__entry->name was fixed by commit 68f23b89067f ("memcg: fix a crash in
wb_workfn when a device disappears"), and this commit fixes the remaining
case, for __entry->ino.

Fixes: 19343b5bdd16 ("mm/page-writeback: introduce tracepoint for wait_on_page_writeback()")
Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 include/trace/events/writeback.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 86b2a82da546..54e353c9f919 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(writeback_folio_template,
 		strscpy_pad(__entry->name,
 			    bdi_dev_name(mapping ? inode_to_bdi(mapping->host) :
 					 NULL), 32);
-		__entry->ino = mapping ? mapping->host->i_ino : 0;
+		__entry->ino = (mapping && mapping->host) ? mapping->host->i_ino : 0;
 		__entry->index = folio->index;
 	),
 
-- 
2.39.2

