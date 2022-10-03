Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EE55F3314
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJCQHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJCQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:07:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97153237F7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:06:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 414461F907;
        Mon,  3 Oct 2022 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664813218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1+vBjpOhSr8yI7p7f9vMFnK6TLTDuW3nTL14Y55+O3c=;
        b=A53v2QcSH0Oq7aWfwVwKhgm7T6DFUvmfPsv7orkoK54nsFnZUMxP+8DUhJqmbcebZKs6zY
        DtQBIayLCgbR19kvboi6fzTRTMchhv9JDJSocYAJ4I5tE2mK9emDEqKbNOBycerBtTxYRk
        tJXT3iAsu5fKJoTBtwlUG9wDXK90sLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664813218;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1+vBjpOhSr8yI7p7f9vMFnK6TLTDuW3nTL14Y55+O3c=;
        b=/tfIliFRrNXZD19BJhJW6bmqMBiBf+gMqw4la0QnAVeGhtRw3ao0AiL65AKkmwkZth2aag
        rzGJOr2th5uI6UDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EC641332F;
        Mon,  3 Oct 2022 16:06:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j9/fAqIIO2PUDQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 03 Oct 2022 16:06:58 +0000
Message-ID: <d1eaa4f7-6b88-9c14-91d2-84cdbd4b8a31@suse.cz>
Date:   Mon, 3 Oct 2022 18:06:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab changes for 6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Feng Tang <feng.tang@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest slab changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.1-rc1

This time I tried using topic branches much more than previously, hopefully in
an acceptable way. After rc5-ish I also tried to stabilize their merging into
for-next (and thus the resulting for-6.1) as well. Hence branches
slab/for-6.1/trivial and slab/for-6.1/slub_validation_locking appear to be
merged twice due an extra cleanup and fix, respectivelly, being added and
merged only last week. In slab/for-6.1/kmalloc_size_roundup I however decided
for squashing a fix last week [1] to avoid needless build errors while bisecting.

If a more simpler, even if "last-minute", topic branch merging is preferred
than this, please let me know.

I'm aware of one conflict with mm tree [2].

Thanks,
Vlastimil

[1] https://lore.kernel.org/all/0eb638e3-b9ac-6dec-6881-b885c7874b45@suse.cz/
[2] https://lore.kernel.org/all/20220906202644.6552d26c@canb.auug.org.au/

======================================

* The "common kmalloc v4" series [1] by Hyeonggon Yoo. While the plan after
  LPC is to try again if it's possible to get rid of SLOB and SLAB (and if
  any critical aspect of those is not possible to achieve with SLUB today,
  modify it accordingly), it will take a while even in case there are no
  objections. Meanwhile this is a nice cleanup and some parts (e.g. to the
  tracepoints) will be useful even if we end up with a single slab
  implementation in the future.

  - Improves the mm/slab_common.c wrappers to allow deleting duplicated
    code between SLAB and SLUB.
  - Large kmalloc() allocations in SLAB are passed to page allocator like
    in SLUB, reducing number of kmalloc caches.
  - Removes the {kmem_cache_alloc,kmalloc}_node variants of tracepoints,
    node id parameter added to non-_node variants.
  - 8 files changed, 341 insertions(+), 651 deletions(-)

* Addition of kmalloc_size_roundup()

  The first two patches from a series by Kees Cook [2] that introduce
  kmalloc_size_roundup(). This will allow merging of per-subsystem patches
  using the new function and ultimately stop (ab)using ksize() in a way that
  causes ongoing trouble for debugging functionality and static checkers.

* Wasted kmalloc() memory tracking in debugfs alloc_traces

  A patch from Feng Tang that enhances the existing debugfs alloc_traces
  file for kmalloc caches with information about how much space is wasted
  by allocations that needs less space than the particular kmalloc cache
  provides.

* My series [3] to fix validation races for caches with enabled debugging.

  - By decoupling the debug cache operation more from non-debug fastpaths,
    extra locking simplifications were possible and thus done afterwards.
  - Additional cleanup of PREEMPT_RT specific code on top, by Thomas Gleixner.
  - A late fix for slab page leaks caused by the series, by Feng Tang.

* Smaller fixes and cleanups

  - Unneeded variable removals, by ye xingchen
  - A cleanup removing a BUG_ON() in create_unique_id(), by Chao Yu.

[1] https://lore.kernel.org/all/20220817101826.236819-1-42.hyeyoo@gmail.com/
[2] https://lore.kernel.org/all/20220923202822.2667581-1-keescook@chromium.org/
[3] https://lore.kernel.org/all/20220823170400.26546-1-vbabka@suse.cz/

----------------------------------------------------------------
Chao Yu (1):
      mm/slub: clean up create_unique_id()

Feng Tang (2):
      mm/slub: enable debugging memory wasting of kmalloc
      mm/slub: fix a slab missed to be freed problem

Hyeonggon Yoo (17):
      mm/slab: move NUMA-related code to __do_cache_alloc()
      mm/slab: cleanup slab_alloc() and slab_alloc_node()
      mm/slab_common: remove CONFIG_NUMA ifdefs for common kmalloc functions
      mm/slab_common: cleanup kmalloc_track_caller()
      mm/sl[au]b: factor out __do_kmalloc_node()
      mm/slab_common: fold kmalloc_order_trace() into kmalloc_large()
      mm/slub: move kmalloc_large_node() to slab_common.c
      mm/slab_common: kmalloc_node: pass large requests to page allocator
      mm/slab_common: cleanup kmalloc_large()
      mm/slab: kmalloc: pass requests larger than order-1 page to page allocator
      mm/sl[au]b: introduce common alloc/free functions without tracepoint
      mm/sl[au]b: generalize kmalloc subsystem
      mm/sl[au]b: cleanup kmem_cache_alloc[_node]_trace()
      mm/slab_common: unify NUMA and UMA version of tracepoints
      mm/slab_common: drop kmem_alloc & avoid dereferencing fields when not using
      mm/slab_common: move declaration of __ksize() to mm/slab.h
      mm/sl[au]b: check if large object is valid in __ksize()

Kees Cook (2):
      slab: Remove __malloc attribute from realloc functions
      slab: Introduce kmalloc_size_roundup()

Thomas Gleixner (1):
      slub: Make PREEMPT_RT support less convoluted

Vlastimil Babka (12):
      mm/slub: move free_debug_processing() further
      mm/slub: restrict sysfs validation to debug caches and make it safe
      mm/slub: remove slab_lock() usage for debug operations
      mm/slub: convert object_map_lock to non-raw spinlock
      mm/slub: simplify __cmpxchg_double_slab() and slab_[un]lock()
      Merge branch 'slab/for-6.1/trivial' into slab/for-next
      Merge branch 'slab/for-6.1/common_kmalloc' into slab/for-next
      Merge branch 'slab/for-6.1/slub_validation_locking' into slab/for-next
      Merge branch 'slab/for-6.1/trivial' into slab/for-next
      Merge branch 'slab/for-6.1/slub_debug_waste' into slab/for-next
      Merge branch 'slab/for-6.1/kmalloc_size_roundup' into slab/for-next
      Merge branch 'slab/for-6.1/slub_validation_locking' into slab/for-next

ye xingchen (2):
      mm/slab_common: Remove the unneeded result variable
      mm/slub: Remove the unneeded result variable

 Documentation/mm/slub.rst           |  33 +-
 include/linux/compiler_attributes.h |   3 +-
 include/linux/compiler_types.h      |   8 +-
 include/linux/slab.h                | 188 ++++----
 include/trace/events/kmem.h         |  74 +--
 mm/kfence/report.c                  |   1 +
 mm/slab.c                           | 305 +++----------
 mm/slab.h                           |  10 +
 mm/slab_common.c                    | 237 ++++++++--
 mm/slob.c                           |  45 +-
 mm/slub.c                           | 871 +++++++++++++++++-------------------
 11 files changed, 854 insertions(+), 921 deletions(-)

