Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AB46EA5FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDUIjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDUIjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:39:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33648E64
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:39:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5EC321A4D;
        Fri, 21 Apr 2023 08:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682066343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BTlq0dIo+CYwQTq80W5QX5pdZ/tX5QOHdE+5C7sG38Q=;
        b=X/f+d+b8A8ImVeXEyEdSYf9yH+H1ZVBG43+kjfenmCp1mgKEA5ow88sjZsPwtB4Q+kGUNU
        CWE4OoRzVIpXdY3iCQxZ1pIEQoz2DOXZIAOdxnnwnCS2BHYWuiURAtgcCRdSlrhKR9KMvD
        WnF5bFdO0ZTjyDMWIcrXV5hZzr8Bu2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682066343;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BTlq0dIo+CYwQTq80W5QX5pdZ/tX5QOHdE+5C7sG38Q=;
        b=kVSC8+LN9vrpsekbi6X2P6s9RdZTlecXkjUWgbTnhMQPFRlP/6ehCPzZHseSh6SLS0F2QJ
        DFIb+nj/zFJx4PDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A98E41390E;
        Fri, 21 Apr 2023 08:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qJSwKKdLQmS+NQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 21 Apr 2023 08:39:03 +0000
Message-ID: <a27e87a0-04f3-2f8e-2494-3036ed7dabc9@suse.cz>
Date:   Fri, 21 Apr 2023 10:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab updates for 6.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

with the assumption that there's no rc8 this time, here's the slab pull
request ahead of the 6.4 merge window. And if there is rc8 after all,
shouldn't matter. Please pull:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.4

The main change is naturally the SLOB removal. Since its deprecation
in 6.2 I've seen no complaints so hopefully SLUB_(TINY) works well for
everyone and we can proceed.

Besides the code cleanup, the main immediate benefit will be allowing
kfree() family of function to work on kmem_cache_alloc() objects, which
was incompatible with SLOB. This includes kfree_rcu() which had no
kmem_cache_free_rcu() counterpart yet and now it shouldn't be necessary
anymore.

Besides that, there are several small code and comment improvements from
Thomas, Thorsten and Vernon.

----------------------------------------------------------------
Thomas Weißschuh (1):
      mm: slub: make kobj_type structure constant

Thorsten Scherer (1):
      slab: Adjust comment after refactoring of gfp.h

Vernon Yang (1):
      mm/slub: fix help comment of SLUB_DEBUG

Vlastimil Babka (8):
      mm/slob: remove CONFIG_SLOB
      mm, page_flags: remove PG_slob_free
      mm, pagemap: remove SLOB and SLQB from comments and documentation
      mm/slab: remove CONFIG_SLOB code from slab common code
      mm/slob: remove slob.c
      mm/slab: document kfree() as allowed for kmem_cache_alloc() objects
      Merge branch 'slab/for-6.4/trivial' into slab/for-next
      Merge branch 'slab/for-6.4/slob-removal' into slab/for-next

 Documentation/admin-guide/mm/pagemap.rst     |   6 +-
 Documentation/core-api/memory-allocation.rst |  17 +-
 fs/proc/page.c                               |   9 +-
 include/linux/page-flags.h                   |   4 -
 include/linux/rcupdate.h                     |   6 +-
 include/linux/slab.h                         |  41 +-
 init/Kconfig                                 |   2 +-
 kernel/configs/tiny.config                   |   1 -
 mm/Kconfig                                   |  22 -
 mm/Kconfig.debug                             |   6 +-
 mm/Makefile                                  |   2 -
 mm/slab.h                                    |  61 ---
 mm/slab_common.c                             |   7 +-
 mm/slob.c                                    | 757 ---------------------------
 mm/slub.c                                    |   2 +-
 tools/mm/page-types.c                        |   6 +-
 16 files changed, 32 insertions(+), 917 deletions(-)
 delete mode 100644 mm/slob.c
