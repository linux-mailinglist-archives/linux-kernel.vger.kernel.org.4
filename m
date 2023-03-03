Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C09F6A9BE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjCCQkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCCQk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:40:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C893121A19
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677861584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yac0IUFozu9Hbpn/S3tdeJCwB7OfuW1Z38QiynjRF/c=;
        b=iVd+3u1qstDZdBad3p1o72uXE6ib9kTd+rSWhm4gDX4V8VA+Jdy4YlTNTH62Pf2Yi4vSTo
        9YRK40P5hYVg7YzNDmnDXTJcQRUmBbrgiT9qWBWByUg+5Kt5/C2o/FbyKHiUmnWmMFFaaD
        bqy3HFs/KBof2pOWCARR09vrOMg64L8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-wZQY2SDpPNujwrXpzEKAQg-1; Fri, 03 Mar 2023 11:39:43 -0500
X-MC-Unique: wZQY2SDpPNujwrXpzEKAQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16E8A101A521;
        Fri,  3 Mar 2023 16:39:43 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B62FD40C6EC4;
        Fri,  3 Mar 2023 16:39:42 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 8DE8B403EA21C; Fri,  3 Mar 2023 12:47:02 -0300 (-03)
Date:   Fri, 3 Mar 2023 12:47:02 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 02/11] this_cpu_cmpxchg: ARM64: switch
 this_cpu_cmpxchg to locked, add _local function
Message-ID: <ZAIWds/yAuKAwb4a@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.683821550@redhat.com>
 <ZAEMuD5pkk/TrK23@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAEMuD5pkk/TrK23@x1n>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 03:53:12PM -0500, Peter Xu wrote:
> On Thu, Feb 09, 2023 at 12:01:52PM -0300, Marcelo Tosatti wrote:
> > Goal is to have vmstat_shepherd to transfer from
> > per-CPU counters to global counters remotely. For this, 
> > an atomic this_cpu_cmpxchg is necessary.
> > 
> > Following the kernel convention for cmpxchg/cmpxchg_local,
> > change ARM's this_cpu_cmpxchg_ helpers to be atomic,
> > and add this_cpu_cmpxchg_local_ helpers which are not atomic.
> 
> I can follow on the necessity of having the _local version, however two
> questions below.
> 
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > Index: linux-vmstat-remote/arch/arm64/include/asm/percpu.h
> > ===================================================================
> > --- linux-vmstat-remote.orig/arch/arm64/include/asm/percpu.h
> > +++ linux-vmstat-remote/arch/arm64/include/asm/percpu.h
> > @@ -232,13 +232,23 @@ PERCPU_RET_OP(add, add, ldadd)
> >  	_pcp_protect_return(xchg_relaxed, pcp, val)
> >  
> >  #define this_cpu_cmpxchg_1(pcp, o, n)	\
> > -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> >  #define this_cpu_cmpxchg_2(pcp, o, n)	\
> > -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> >  #define this_cpu_cmpxchg_4(pcp, o, n)	\
> > -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> >  #define this_cpu_cmpxchg_8(pcp, o, n)	\
> > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> 
> This makes this_cpu_cmpxchg_*() not only non-local, but also (especially
> for arm64) memory barrier implications since cmpxchg() has a strong memory
> barrier, while the old this_cpu_cmpxchg*() doesn't have, afaiu.

A later patch changes users of this_cpu_cmpxchg to
this_cpu_cmpxchg_local, which maintains behaviour.

> Maybe it's not a big deal if the audience of this helper is still limited
> (e.g. we can add memory barriers if we don't want strict ordering
> implication), but just to check with you on whether it's intended, and if
> so whether it may worth some comments.
> 
> > +
> > +#define this_cpu_cmpxchg_local_1(pcp, o, n)	\
> >  	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +#define this_cpu_cmpxchg_local_2(pcp, o, n)	\
> > +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +#define this_cpu_cmpxchg_local_4(pcp, o, n)	\
> > +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +#define this_cpu_cmpxchg_local_8(pcp, o, n)	\
> > +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> 
> I think cmpxchg_relaxed()==cmpxchg_local() here for aarch64, however should
> we still use cmpxchg_local() to pair with this_cpu_cmpxchg_local_*()?
> 
> Nothing about your patch along since it was the same before, but I'm
> wondering whether this is a good time to switchover.
> 
> The other thing is would it be good to copy arch-list for each arch patch?
> Maybe it'll help to extend the audience too.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
> 

