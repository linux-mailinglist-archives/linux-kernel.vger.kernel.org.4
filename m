Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951AD69E262
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjBUOdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjBUOdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:33:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19DB10C0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:33:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 19FC15C77D;
        Tue, 21 Feb 2023 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676989983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eP5ocU6XXUYDRuHy9gjU+cH8b1jImnrk7y/3atb8yAk=;
        b=2qX1BYT41Z5HLGBg+ZOFUSWk/W4yYC4+qRWmYA89gjUPOyUzYXzWfnrPKenl98Q5EXKwQ/
        BpUYtE3YEvnu5Vyk/D3GgYN0JX61w+jvifITQrNGiuajK+7cRKFdT8l2EIAMO0TZtGxPAK
        YYEg0hDLW81GWo/EHqXr/7nsjd/pI0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676989983;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eP5ocU6XXUYDRuHy9gjU+cH8b1jImnrk7y/3atb8yAk=;
        b=Md3SGknNU1/bhKHlAq+TS8xJ5ojRG8s8wheQHY1rKc/qxMFy98dYcQ4g+GxdZurd+ZIUBO
        /TsJ2YMFlwdCRZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E909713223;
        Tue, 21 Feb 2023 14:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dEZROB7W9GN6VAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Feb 2023 14:33:02 +0000
Message-ID: <0d7dde0e-ac9d-620a-cfe8-7897ed53be60@suse.cz>
Date:   Tue, 21 Feb 2023 15:33:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab updates for 6.3-rc1
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

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.3

This time it's just a bunch of smaller cleanups and fixes for SLAB and SLUB:

- Make it possible to use kmem_cache_alloc_bulk() early in boot when
  interrupts are not yet enabled, as code doing that started to appear via
  new maple tree users (by Thomas Gleixner).

- Fix debugfs-related memory leak in SLUB (by Greg Kroah-Hartman).

- Use the standard idiom to get head page of folio (by SeongJae Park)

- Simplify and inline is_debug_pagealloc_cache() in SLAB (by lvqian)

- Remove unused variable in SLAB (by Gou Hao)

----------------------------------------------------------------
Gou Hao (1):
      mm/slab: remove unused slab_early_init

Greg Kroah-Hartman (1):
      mm/slub: fix memory leak with using debugfs_lookup()

SeongJae Park (1):
      mm/sl{a,u}b: fix wrong usages of folio_page() for getting head pages

Thomas Gleixner (1):
      mm, slab/slub: Ensure kmem_cache_alloc_bulk() is available early

Vlastimil Babka (2):
      Merge branch 'slab/for-6.3/cleanups' into slab/for-linus
      Merge branch 'slab/for-6.3/fixes' into slab/for-linus

lvqian (1):
      mm/slab.c: cleanup is_debug_pagealloc_cache()

 mm/slab.c | 34 +++++++++++++++-------------------
 mm/slub.c | 13 +++++++------
 2 files changed, 22 insertions(+), 25 deletions(-)

