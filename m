Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A526485A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiLIPdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiLIPc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:32:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184CE24948
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:32:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B9E781FF90;
        Fri,  9 Dec 2022 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670599973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=y1oe6AS8U5UukEMAdOkLhhvwGRmDfr7zc41wEr0hZu4=;
        b=ayn0wV8GS6fm+bmItqAdnHivEWnOPqYsn6x3fG3WSBMb6eGCo6df6N5pU72oObs20/tI5O
        wS+t9aQc60GZzPVEvoAbwNOrPl520SgEzEZRxuTMGUpvd1d4InltoP3udQZK43to+wLBKK
        dKARUHGnbuX9cS0J+KdE/glbz+z0NfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670599973;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=y1oe6AS8U5UukEMAdOkLhhvwGRmDfr7zc41wEr0hZu4=;
        b=kRLMNPLyBLrYAKA9pmp5HUvp99+kzkyCozx3WYfaHxhx/vjDjdrUzq1nZNI/aPYmqXNPqN
        e6fA7t30FUBf8JBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84F2913597;
        Fri,  9 Dec 2022 15:32:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hFDVHyVVk2N+LgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 09 Dec 2022 15:32:53 +0000
Message-ID: <8f81dbc0-da85-dff7-4a88-c0c4639649c1@suse.cz>
Date:   Fri, 9 Dec 2022 16:32:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab updates for 6.2-rc1
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
        Feng Tang <feng.tang@intel.com>,
        Dennis Zhou <dennis@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest slab updates from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.2-rc1

The changes, including the first step to remove SLOB, are summarized below.

There's one trivial conflict with percpu tree:
https://lore.kernel.org/all/20221122163634.3b21cf71@canb.auug.org.au/

======================================

* SLOB deprecation and SLUB_TINY

  The SLOB allocator adds maintenance burden and stands in the way of API
  improvements [1]. Deprecate it by renaming the config option (to make users
  notice) to CONFIG_SLOB_DEPRECATED with updated help text. SLUB should be
  used instead as SLAB will be the next on the removal list.

  Based on reports from a riscv k210 board with 8MB RAM, add a CONFIG_SLUB_TINY
  option to minimize SLUB's memory usage at the expense of scalability. This
  has resolved the k210 regression [2] so in case there are no others (that
  wouldn't be resolvable by further tweaks to SLUB_TINY) plan is to remove SLOB
  in a few cycles.

  Existing defconfigs with CONFIG_SLOB are converted to CONFIG_SLUB_TINY.

* kmalloc() slub_debug redzone improvements

  A series from Feng Tang that builds on the tracking or requested size for
  kmalloc() allocations (for caches with debugging enabled) added in 6.1, to
  make redzone checks consider the requested size and not the rounded up one,
  in order to catch more subtle buffer overruns. Includes new slub_kunit test.

* struct slab fields reordering to accomodate larger rcu_head

  RCU folks would like to grow rcu_head with debugging options, which breaks
  current struct slab layout's assumptions, so reorganize it to make this
  possible.

* Miscellaneous improvements/fixes

  - __alloc_size checking compiler workaround by Kees Cook.
  - Optimize and cleanup SLUB's sysfs init, by Rasmus Villemoes.
  - Make SLAB compatible with PROVE_RAW_LOCK_NESTING, by Jiri Kosina.
  - Correct SLUB's percpu allocation estimates, by Baoquan He.
  - Re-enableS LUB's run-time failslab sysfs control, by Alexander Atanasov.
  - Make tools/vm/slabinfo more user friendly when not run as root, by Rong Tao.
  - Dead code removal in SLUB, by Hyeonggon Yoo.

[1] https://lore.kernel.org/all/b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz/
[2] https://lore.kernel.org/all/6a1883c4-4c3f-545a-90e8-2cd805bcf4ae@opensource.wdc.com/

----------------------------------------------------------------
Alexander Atanasov (1):
      mm: Make failslab writable again

Baoquan He (2):
      percpu: adjust the value of PERCPU_DYNAMIC_EARLY_SIZE
      mm/slub, percpu: correct the calculation of early percpu allocation size

Feng Tang (5):
      mm/slub: only zero requested size of buffer for kzalloc when debug enabled
      mm: kasan: Extend kasan_metadata_size() to also cover in-object size
      mm/slub: extend redzone check to extra allocated kmalloc space than requested
      mm/slub, kunit: add SLAB_SKIP_KFENCE flag for cache creation
      mm/slub, kunit: Add a test case for kmalloc redzone check

Hyeonggon Yoo (1):
      mm/slub: remove dead code for debug caches on deactivate_slab()

Jiri Kosina (1):
      mm/slab: Annotate kmem_cache_node->list_lock as raw

Kees Cook (2):
      slab: Clean up SLOB vs kmalloc() definition
      slab: Remove special-casing of const 0 size allocations

Rasmus Villemoes (2):
      mm: slub: remove dead and buggy code from sysfs_slab_add()
      mm: slub: make slab_sysfs_init() a late_initcall

Rong Tao (1):
      tools/vm/slabinfo: indicates the cause of the EACCES error

Vlastimil Babka (25):
      mm/slub: perform free consistency checks before call_rcu
      mm/slab: move and adjust kernel-doc for kmem_cache_alloc
      mm/migrate: make isolate_movable_page() skip slab pages
      mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head
      Merge branch 'slab/for-6.2/cleanups' into slab/for-next
      Merge branch 'slab/for-6.2/locking' into slab/for-next
      Merge branch 'slab/for-6.2/slub-sysfs' into slab/for-next
      Merge branch 'slab/for-6.2/tools' into slab/for-next
      Merge branch 'slab/for-6.2/fit_rcu_head' into slab/for-next
      Merge branch 'slab/for-6.2/kmalloc_redzone' into slab/for-next
      Merge branch 'slab/for-6.2/alloc_size' into slab/for-next
      mm, slab: ignore hardened usercopy parameters when disabled
      mm, slub: add CONFIG_SLUB_TINY
      mm, slub: disable SYSFS support with CONFIG_SLUB_TINY
      mm, slub: retain no free slabs on partial list with CONFIG_SLUB_TINY
      mm, slub: lower the default slub_max_order with CONFIG_SLUB_TINY
      mm, slub: don't create kmalloc-rcl caches with CONFIG_SLUB_TINY
      mm, slab: ignore SLAB_RECLAIM_ACCOUNT with CONFIG_SLUB_TINY
      mm, slub: refactor free debug processing
      mm, slub: split out allocations from pre/post hooks
      mm, slub: remove percpu slabs with CONFIG_SLUB_TINY
      mm, slub: don't aggressively inline with CONFIG_SLUB_TINY
      mm, slob: rename CONFIG_SLOB to CONFIG_SLOB_DEPRECATED
      Merge branch 'slab/for-6.2/kmalloc_redzone' into slab/for-next
      Merge branch 'slub-tiny-v1r6' into slab/for-next

 Documentation/mm/slub.rst                      |   2 +
 arch/arm/configs/clps711x_defconfig            |   3 +-
 arch/arm/configs/collie_defconfig              |   3 +-
 arch/arm/configs/multi_v4t_defconfig           |   3 +-
 arch/arm/configs/omap1_defconfig               |   3 +-
 arch/arm/configs/pxa_defconfig                 |   3 +-
 arch/arm/configs/tct_hammer_defconfig          |   3 +-
 arch/arm/configs/xcep_defconfig                |   3 +-
 arch/openrisc/configs/or1ksim_defconfig        |   3 +-
 arch/openrisc/configs/simple_smp_defconfig     |   3 +-
 arch/riscv/configs/nommu_k210_defconfig        |   3 +-
 arch/riscv/configs/nommu_k210_sdcard_defconfig |   3 +-
 arch/riscv/configs/nommu_virt_defconfig        |   3 +-
 arch/sh/configs/rsk7201_defconfig              |   3 +-
 arch/sh/configs/rsk7203_defconfig              |   3 +-
 arch/sh/configs/se7206_defconfig               |   3 +-
 arch/sh/configs/shmin_defconfig                |   3 +-
 arch/sh/configs/shx3_defconfig                 |   3 +-
 include/linux/kasan.h                          |   5 +-
 include/linux/percpu.h                         |   2 +-
 include/linux/slab.h                           |  64 ++-
 include/linux/slab_def.h                       |   2 +
 include/linux/slub_def.h                       |   8 +-
 kernel/configs/tiny.config                     |   5 +-
 lib/Kconfig.kasan                              |   2 +-
 lib/slub_kunit.c                               |  57 ++-
 mm/Kconfig                                     |  38 +-
 mm/Kconfig.debug                               |   2 +-
 mm/kasan/generic.c                             |  19 +-
 mm/migrate.c                                   |  15 +-
 mm/slab.c                                      | 113 +++--
 mm/slab.h                                      |  86 ++--
 mm/slab_common.c                               |  27 +-
 mm/slub.c                                      | 553 +++++++++++++++++--------
 tools/vm/slabinfo.c                            |   6 +-
 35 files changed, 713 insertions(+), 344 deletions(-)
