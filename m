Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C62705022
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjEPOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjEPOD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:03:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54A5525D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:03:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6EC601FEB0;
        Tue, 16 May 2023 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684245836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=va2PlQ9fTKLDOkUDFaD7bMLHV5h0Zea9LBMRTULprJM=;
        b=HtFvvTVEKv+y8AupTOrwFvnRCRrmdg0yXIP3Chj0aJpdMgAnv2N2q4E1/Lholg9C1lfQ25
        3YaItb2drBftDrrjpGryEa57dMoVqVPrcGSHGVh4SQVcH3RN4wfJkDUI9Fsd0+IY1VO5Nn
        eiN5s+Yb2XMuO7+CfI1Jg1gzzcygk6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684245836;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=va2PlQ9fTKLDOkUDFaD7bMLHV5h0Zea9LBMRTULprJM=;
        b=HPyHgRvU4Y6A8lFPt+FVrllqQrjupKckDCcBdfzN/44ua4G0Gm+KGjcZuqE5uW3hlzNg2S
        ct9c/O/y+TmRvbDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E4FC138F5;
        Tue, 16 May 2023 14:03:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SXTLIkuNY2SeWwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 16 May 2023 14:03:55 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v5 0/3] page_owner: print stacks and their counter
Date:   Tue, 16 May 2023 16:03:30 +0200
Message-Id: <20230516140333.3776-1-osalvador@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v4 -> v5:
     - Move page_owner_stack_threshold to page_owner file (suggested
       by Alexander Potapenko)
     - Make the stack refcount more generic, and do not
       assume it will be only used for page_owner (suggested by
       Alexander Potapenko)

Changes v3 -> v4:
     - Rebase (long time has passed)
     - Use boolean instead of enum for action by Alexander Potapenko
     - (I left some feedback untouched because it's been long and
        would like to discuss it here now instead of re-vamping
        and old thread)

Changes v2 -> v3:
     - Replace interface in favor of seq operations (suggested by Vlastimil)
     - Use debugfs interface to store/read valued (suggested by Ammar)

Hi,

page_owner is a great debug functionality tool that gets us to know
about all pages that have been allocated/freed and their stacktrace.
This comes very handy when e.g: debugging leaks, as with some scripting
we might be able to see those stacktraces that are allocating pages
but not freeing theme.

In my experience, that is one of the most useful cases, but it can get
really tedious to screen through all pages aand try to reconstruct the
stack <-> allocated/freed relationship. There is a lot of noise
to cancel off.

This patch aims to fix that by adding a new functionality into page_owner.
What this does is to create a new read-only file "page_owner_stacks",
which prints only the allocating stacktraces and their counting, being that
the times the stacktrace has allocated - the times it has freed.

So we have a clear overview of stacks <-> allocated/freed relationship
without the need to fiddle with pages and trying to match free stacktraces
with allocated stacktraces.

This is achieved by adding a new refcount_t field in the stack_record struct,
incrementing that refcount_t everytime the same stacktrace allocates,
and decrementing it when it frees a page. Details can be seen in the
respective patches.

We also create another file called "page_owner_threshold", which let us
specify a threshold, so when when reading from "page_owner_stacks",
we will only see those stacktraces which counting goes beyond the
threshold we specified.

One thing I am not completely happy about is to polute lib/stackdepot.c file
with the stack_* functions.
We could sort that out if the stack_record struct definitions were in a header
file instead of stackdepot.c.
But I am not sure about that trade-off, so suggestions are accepted.

A PoC can be found below:

# cat /sys/kernel/debug/page_owner_threshold
 0
# cat /sys/kernel/debug/page_owner_stacks > stacks_full.txt
# head -32 stacks_full.txt
 prep_new_page+0x10d/0x180
 get_page_from_freelist+0x1bd6/0x1e10
 __alloc_pages+0x194/0x360
 alloc_page_interleave+0x13/0x90
 new_slab+0x31d/0x530
 ___slab_alloc+0x5d7/0x720
 __slab_alloc.isra.85+0x4a/0x90
 kmem_cache_alloc+0x455/0x4a0
 acpi_ps_alloc_op+0x57/0x8f
 acpi_ps_create_scope_op+0x12/0x23
 acpi_ps_execute_method+0x102/0x2c1
 acpi_ns_evaluate+0x343/0x4da
 acpi_evaluate_object+0x1cb/0x392
 acpi_run_osc+0x135/0x260
 acpi_init+0x165/0x4ed
 do_one_initcall+0x3e/0x200
stack count: 2

 free_pcp_prepare+0x287/0x5c0
 free_unref_page+0x1c/0xd0
 __mmdrop+0x50/0x160
 finish_task_switch+0x249/0x2b0
 __schedule+0x2c3/0x960
 schedule+0x44/0xb0
 futex_wait_queue+0x70/0xd0
 futex_wait+0x160/0x250
 do_futex+0x11c/0x1b0
 __x64_sys_futex+0x5e/0x1d0
 do_syscall_64+0x37/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
stack count: 1

 

# echo 10000 > /sys/kernel/debug/page_owner_threshold
# cat /sys/kernel/debug/page_owner_stacks > stacks_10000.txt
# cat stacks_10000.txt 
 prep_new_page+0x10d/0x180
 get_page_from_freelist+0x1bd6/0x1e10
 __alloc_pages+0x194/0x360
 folio_alloc+0x17/0x40
 page_cache_ra_unbounded+0x96/0x170
 filemap_get_pages+0x23d/0x5e0
 filemap_read+0xbf/0x3a0
 __kernel_read+0x136/0x2f0
 kernel_read_file+0x197/0x2d0
 kernel_read_file_from_fd+0x54/0x90
 __do_sys_finit_module+0x89/0x120
 do_syscall_64+0x37/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
stack count: 36195

 prep_new_page+0x10d/0x180
 get_page_from_freelist+0x1bd6/0x1e10
 __alloc_pages+0x194/0x360
 folio_alloc+0x17/0x40
 page_cache_ra_unbounded+0x96/0x170
 filemap_get_pages+0x23d/0x5e0
 filemap_read+0xbf/0x3a0
 new_sync_read+0x106/0x180
 vfs_read+0x16f/0x190
 ksys_read+0xa5/0xe0
 do_syscall_64+0x37/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
stack count: 44484

 prep_new_page+0x10d/0x180
 get_page_from_freelist+0x1bd6/0x1e10
 __alloc_pages+0x194/0x360
 folio_alloc+0x17/0x40
 page_cache_ra_unbounded+0x96/0x170
 filemap_get_pages+0xdd/0x5e0
 filemap_read+0xbf/0x3a0
 new_sync_read+0x106/0x180
 vfs_read+0x16f/0x190
 ksys_read+0xa5/0xe0
 do_syscall_64+0x37/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
stack count: 17874

Oscar Salvador (3):
  lib/stackdepot: Add a refcount field in stack_record
  mm, page_owner: Add page_owner_stacks file to print out only stacks
    and their counte
  mm,page_owner: Filter out stacks by a threshold counter

 include/linux/stackdepot.h |   8 +++
 lib/stackdepot.c           | 128 ++++++++++++++++++++++++++++++++++---
 mm/page_owner.c            |  54 ++++++++++++++++
 3 files changed, 180 insertions(+), 10 deletions(-)

-- 
2.35.3

