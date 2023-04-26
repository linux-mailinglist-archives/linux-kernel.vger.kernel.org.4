Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FFC6EF84A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjDZQUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjDZQUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFE17D83
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682525967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9wVdlNXWsjTJ8OTeZ7rpKexU/e87QLSsuW8JpNE/mYY=;
        b=YftjcTm7lznYmJ19gTrPzI+voHxReykPyuOL6QfGPlmPmzOK2sq2GlH9YntPJAIYD6G97y
        oulu9TY6HThGJyQFRmjwySTe6vZALr/30OClKs6+QizGzq5vOE+ah2McHMte1hfgTIOreh
        X41GuOxRSzt58F35bK88UAYAR92bWNk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301--NXaypTUOcikotdTO4xiDA-1; Wed, 26 Apr 2023 12:18:29 -0400
X-MC-Unique: -NXaypTUOcikotdTO4xiDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 333F3857F81;
        Wed, 26 Apr 2023 16:18:08 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEFB4C15BA0;
        Wed, 26 Apr 2023 16:18:07 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id E85134038CC40; Wed, 26 Apr 2023 13:10:54 -0300 (-03)
Date:   Wed, 26 Apr 2023 13:10:54 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZElNDltcv4PA0HsM@tpad>
References: <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
 <ZD/NAaa5TVcL7Mxm@tpad>
 <ZD/Qq9v0EDxUn7HW@tpad>
 <ZD/XoBTqJBL2G+Dk@tpad>
 <ZD/dYXJD2xcoWFoQ@localhost.localdomain>
 <ZD/xE6kR4RSOvUlR@tpad>
 <ZD/8R6sacS45ggyt@dhcp22.suse.cz>
 <ZEAYQBJmVwsjpjGY@tpad>
 <ZEFB8FSKWms2VmaL@tpad>
 <44f2df1a-ace4-0c44-166f-4f2fef49e0c1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f2df1a-ace4-0c44-166f-4f2fef49e0c1@suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 05:04:49PM +0200, Vlastimil Babka wrote:
> On 4/20/23 15:45, Marcelo Tosatti wrote:
> > Perhaps the complexity should be judged for individual cases 
> > of interruptions, and if a given interruption-free conversion 
> > is seen as too complex, then a "disable feature which makes use of per-CPU
> > caches" style solution can be made (and then userspace has to
> > explicitly request for that per-CPU feature to be disabled).
> > 
> > But i don't see that this patchset introduces unmanageable complexity,
> > neither: 
> > 
> > 01b44456a7aa7c3b24fa9db7d1714b208b8ef3d8 mm/page_alloc: replace local_lock with normal spinlock
> > 4b23a68f953628eb4e4b7fe1294ebf93d4b8ceee mm/page_alloc: protect PCP lists with a spinlock
> 
> Well that one is a bit different, as there was one kind of lock replaced
> with other kind of lock, 

local_lock is defined to NULL if CONFIG_PREEMPT_RT is not set. 
So for the !CONFIG_PREEMPT_RT case, it introduced a lock.

> the lock is uncontended unless there's remote
> flushes happening so it's not causing extra overhead for the fast paths,
> and later even the irq disabling was removed, which should even improve
> things. But this patchset is turning all vmstat counter increments a
> cmpxchg.

Yes, and we have a similar situation in this case:

1) CMPXCHG is already used to protect many vmstat counter increments.
2) The patchset adds "LOCK CMPXCHG" to existing CMPXCHG user.
3) The performance decrease is negligible, because cache locking is
effective.

"To test the performance difference, a page allocator microbenchmark:
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/mm/bench/page_bench01.c
with loops=1000000 was used, on Intel Core i7-11850H @ 2.50GHz.

For the single_page_alloc_free test, which does

       	/** Loop to measure **/
       	for (i = 0; i < rec->loops; i++) {
               	my_page = alloc_page(gfp_mask);
                if (unlikely(my_page == NULL))
                       	return 0;
                __free_page(my_page);
        }                                                                                                           

Unit is cycles.

Vanilla                 Patched         Diff
115.25                  117             1.4%"

To be honest, that 1.4% difference was not stable but fluctuated between
positive and negative percentages (so the performance difference was in
the noise).

So performance is not a decisive factor in this case.

