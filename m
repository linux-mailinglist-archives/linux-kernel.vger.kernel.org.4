Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7341C6A9BE2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCCQke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCCQk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:40:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E8D1F4AC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677861584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A7qH7z8qcUef6NyJXfR2PL9084/lxkL2GnTDPhF4AIk=;
        b=DNKiG7boyw0e/8HcdQwK+O3PUjOGHzgkMG/s4Q21gncIKfzgNPKF7HQuwiMtZ9IIW3Tq+i
        m9skDZfCgBPOebMpqwKxijePnrfcfZpMPd5nuCrnYDuWHEG1icLGlmJ3rn8aOhu9qoRy8G
        SKxry9ff3Y67fXhP6ilIAPIgMFiuC0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-H4SqEBn-Otq_xZ4Ygilg-A-1; Fri, 03 Mar 2023 11:39:43 -0500
X-MC-Unique: H4SqEBn-Otq_xZ4Ygilg-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AE8185CCE4;
        Fri,  3 Mar 2023 16:39:43 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D454C2166B2B;
        Fri,  3 Mar 2023 16:39:42 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id B6B29401A0A1D; Fri,  3 Mar 2023 12:39:11 -0300 (-03)
Date:   Fri, 3 Mar 2023 12:39:11 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 02/11] this_cpu_cmpxchg: ARM64: switch
 this_cpu_cmpxchg to locked, add _local function
Message-ID: <ZAIUn05lmE36oglh@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.683821550@redhat.com>
 <ZAEMuD5pkk/TrK23@x1n>
 <ZAEPWQrdZd1N1rkn@tpad>
 <ZAEUNEWQ01w1WXlz@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAEUNEWQ01w1WXlz@x1n>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 04:25:08PM -0500, Peter Xu wrote:
> On Thu, Mar 02, 2023 at 06:04:25PM -0300, Marcelo Tosatti wrote:
> > On Thu, Mar 02, 2023 at 03:53:12PM -0500, Peter Xu wrote:
> > > On Thu, Feb 09, 2023 at 12:01:52PM -0300, Marcelo Tosatti wrote:
> > > > Goal is to have vmstat_shepherd to transfer from
> > > > per-CPU counters to global counters remotely. For this, 
> > > > an atomic this_cpu_cmpxchg is necessary.
> > > > 
> > > > Following the kernel convention for cmpxchg/cmpxchg_local,
> > > > change ARM's this_cpu_cmpxchg_ helpers to be atomic,
> > > > and add this_cpu_cmpxchg_local_ helpers which are not atomic.
> > > 
> > > I can follow on the necessity of having the _local version, however two
> > > questions below.
> > > 
> > > > 
> > > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > > 
> > > > Index: linux-vmstat-remote/arch/arm64/include/asm/percpu.h
> > > > ===================================================================
> > > > --- linux-vmstat-remote.orig/arch/arm64/include/asm/percpu.h
> > > > +++ linux-vmstat-remote/arch/arm64/include/asm/percpu.h
> > > > @@ -232,13 +232,23 @@ PERCPU_RET_OP(add, add, ldadd)
> > > >  	_pcp_protect_return(xchg_relaxed, pcp, val)
> > > >  
> > > >  #define this_cpu_cmpxchg_1(pcp, o, n)	\
> > > > -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> > > >  #define this_cpu_cmpxchg_2(pcp, o, n)	\
> > > > -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> > > >  #define this_cpu_cmpxchg_4(pcp, o, n)	\
> > > > -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> > > >  #define this_cpu_cmpxchg_8(pcp, o, n)	\
> > > > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> > > 
> > > This makes this_cpu_cmpxchg_*() not only non-local, but also (especially
> > > for arm64) memory barrier implications since cmpxchg() has a strong memory
> > > barrier, while the old this_cpu_cmpxchg*() doesn't have, afaiu.
> > > 
> > > Maybe it's not a big deal if the audience of this helper is still limited
> > > (e.g. we can add memory barriers if we don't want strict ordering
> > > implication), but just to check with you on whether it's intended, and if
> > > so whether it may worth some comments.
> > 
> > It happens that on ARM-64 cmpxchg_local == cmpxchg_relaxed.
> > 
> > See cf10b79a7d88edc689479af989b3a88e9adf07ff.
> 
> This is more or less a comment in general, rather than for arm only.
> 
> Fundamentally starting from this patch it's redefining this_cpu_cmpxchg().
> What I meant is whether we should define it properly then implement the
> arch patches with what is defined.
> 
> We're adding non-local semantics into it, which is obvious to me.

Which match the cmpxchg() function semantics.

> We're (silently, in this patch for aarch64) adding memory barrier semantics
> too, this is not obvious to me on whether all archs should implement this
> api the same way.

Documentation/atomic_t.txt says that _relaxed means "no barriers".

So i'd assume:

cmpxchg_relaxed: no additional barriers
cmpxchg_local:   only guarantees atomicity to wrt local CPU.
cmpxchg:	 atomic in SMP context.

https://lore.kernel.org/linux-arm-kernel/20180505103550.s7xsnto7tgppkmle@gmail.com/#r

There seems to be a lack of clarity in documentation.

> It will make a difference IMHO when the helpers are used in any other code
> clips, because IIUC proper definition of memory barrier implications will
> decide whether the callers need explicit barriers when ordering is required.

Trying to limit the scope of changes to solve the problem at hand.

More specifically what this patch does is:

1) Add this_cpu_cmpxchg_local, uses arch cmpxchg_local implementation
to back it.
2) Add this_cpu_cmpxchg, uses arch cmpxchg implementation to back it.

Note that now becomes consistent with cmpxchg and cmpxchg_local
semantics.

> > This patchset maintains the current behaviour
> > of this_cpu_cmpxch (for this_cpu_cmpxch_local), which was:
> > 
> >  #define this_cpu_cmpxchg_1(pcp, o, n)  \                                                                           
> > -       _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +       _pcp_protect_return(cmpxchg, pcp, o, n)
> >  #define this_cpu_cmpxchg_2(pcp, o, n)  \                                                                           
> > -       _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +       _pcp_protect_return(cmpxchg, pcp, o, n)
> >  #define this_cpu_cmpxchg_4(pcp, o, n)  \                                                                           
> > -       _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +       _pcp_protect_return(cmpxchg, pcp, o, n)
> >  #define this_cpu_cmpxchg_8(pcp, o, n)  \                                                                           
> > +       _pcp_protect_return(cmpxchg, pcp, o, n)
> > 
> > > > +
> > > > +#define this_cpu_cmpxchg_local_1(pcp, o, n)	\
> > > >  	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > > +#define this_cpu_cmpxchg_local_2(pcp, o, n)	\
> > > > +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > > +#define this_cpu_cmpxchg_local_4(pcp, o, n)	\
> > > > +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > > +#define this_cpu_cmpxchg_local_8(pcp, o, n)	\
> > > > +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > 
> > > I think cmpxchg_relaxed()==cmpxchg_local() here for aarch64, however should
> > > we still use cmpxchg_local() to pair with this_cpu_cmpxchg_local_*()?
> > 
> > Since cmpxchg_local = cmpxchg_relaxed, seems like this is not necessary.
> > 
> > > Nothing about your patch along since it was the same before, but I'm
> > > wondering whether this is a good time to switchover.
> > 
> > I would say that another patch is more appropriate to change this, 
> > if desired.
> 
> Sure on this one.  Thanks,
> 
> -- 
> Peter Xu
> 
> 

