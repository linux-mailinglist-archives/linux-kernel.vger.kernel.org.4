Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CAF710BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbjEYMFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjEYMFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:05:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CC59C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:05:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 77FDC21D66;
        Thu, 25 May 2023 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685016328;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rQIsiO41ktVyMsAWXNNe4e1XrL665FizATFtQHtOJdc=;
        b=dRB9JNpO0QbErDqsnjHZFexCFNall3fmqU7Rk3HMSJKFuhJvvBQ2ly0kl3yfQy8ynhpKY2
        lStR3+td8byQw+0w3E0VRPpKDI8q7bUPA0yy+RXXCYuEI/aIPDJ5GJmYSwnReSPttsargg
        /MQuXkevSNbVD3WmhIEGI+K15+33TEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685016328;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rQIsiO41ktVyMsAWXNNe4e1XrL665FizATFtQHtOJdc=;
        b=F43u4XwNzZZHr7IcO1SXQM7xcoPb5aJ5D+cxxIbSXAKPeIxzWu+IJGhn0ls26nVIQL92g5
        yOLEmKBokva8p2CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DA60134B2;
        Thu, 25 May 2023 12:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jK1RDghPb2TwKgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 25 May 2023 12:05:28 +0000
Date:   Thu, 25 May 2023 13:59:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm/slab: add new flag SLAB_NO_MERGE to avoid merging per
 slab
Message-ID: <20230525115920.GG30909@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230524101748.30714-1-dsterba@suse.com>
 <ZG4JYr14RpNQb8li@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG4JYr14RpNQb8li@debian-BULLSEYE-live-builder-AMD64>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:56:02PM +0900, Hyeonggon Yoo wrote:
> On Wed, May 24, 2023 at 12:17:48PM +0200, David Sterba wrote:
> > Add a flag that allows to disable merging per slab. This can be used for
> > more fine grained control over the caches or for debugging builds where
> > separate slabs can verify that no objects leak.
> > The slab_nomerge boot option is too coarse and would need to be enabled
> > on all testing hosts. 
> 
> There is no users nor interface to set this flag, I guess you're going
> to use it by modifying source code, when debugging?

An example usage

--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -12,6 +12,12 @@
 #include "async-thread.h"
 #include "block-rsv.h"
 
+#ifdef CONFIG_BTRFS_DEBUG
+#define SLAB_DEBUG_NO_MERGE            0
+#else
+#define SLAB_DEBUG_NO_MERGE            SLAB_NO_MERGE
+#endif
+
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
 #define BTRFS_OLDEST_GENERATION        0ULL
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5049,7 +5049,7 @@ int __init btrfs_ctree_init(void)
 {
        btrfs_path_cachep = kmem_cache_create("btrfs_path",
                        sizeof(struct btrfs_path), 0,
-                       SLAB_MEM_SPREAD, NULL);
+                       SLAB_MEM_SPREAD | SLAB_DEBUG_NO_MERGE, NULL);
        if (!btrfs_path_cachep)
                return -ENOMEM;
        return 0;
---

and this will be a permanent change, not added as needed.

> Does introducing new slub_debug option (i.e. slub_debug=N,pid_namespace)
> work for your use case? (there are some boot-time slub_debug options described in
> Documentation/mm/slub.rst)

I'd like to keep boot parameters unchanged, the testing setups are
different, physical, local VM, hosted. For the same reason the config
option CONFIG_SLUB_DEBUG_ON=y is very convenient.
