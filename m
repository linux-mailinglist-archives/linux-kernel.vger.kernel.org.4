Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216DD6A8B9A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCBWSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCBWSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:18:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C43A251
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677795481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uQ5SSw6v6jkYdu8pUhZUUJgBB1SJYEgd5Q/CexLSglM=;
        b=T+AYtlZWRyxW5eTxVOnTPR9NWJ9DxPdroXA4BBIIIj681jeotRO1RvUAAycnt3x8ImvGFX
        BlQ5yXdTqWCNadf/XBqYR0JNnrOeU+YdBMrhw0i9Y2RPijQW1ETjY+k35aTsN7YhOY/Wma
        wvHhIaIyZuYQC1kk/tU0MpC4jRiw+/8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-VAq8u0t7MzKbczVyVcrBkQ-1; Thu, 02 Mar 2023 16:17:19 -0500
X-MC-Unique: VAq8u0t7MzKbczVyVcrBkQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA74A185A78B;
        Thu,  2 Mar 2023 21:17:18 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5FA740C83B6;
        Thu,  2 Mar 2023 21:17:18 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 37D79400E055B; Thu,  2 Mar 2023 18:04:25 -0300 (-03)
Date:   Thu, 2 Mar 2023 18:04:25 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 02/11] this_cpu_cmpxchg: ARM64: switch
 this_cpu_cmpxchg to locked, add _local function
Message-ID: <ZAEPWQrdZd1N1rkn@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.683821550@redhat.com>
 <ZAEMuD5pkk/TrK23@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAEMuD5pkk/TrK23@x1n>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
> 
> Maybe it's not a big deal if the audience of this helper is still limited
> (e.g. we can add memory barriers if we don't want strict ordering
> implication), but just to check with you on whether it's intended, and if
> so whether it may worth some comments.

It happens that on ARM-64 cmpxchg_local == cmpxchg_relaxed.

See cf10b79a7d88edc689479af989b3a88e9adf07ff.

This patchset maintains the current behaviour
of this_cpu_cmpxch (for this_cpu_cmpxch_local), which was:

 #define this_cpu_cmpxchg_1(pcp, o, n)  \                                                                           
-       _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+       _pcp_protect_return(cmpxchg, pcp, o, n)
 #define this_cpu_cmpxchg_2(pcp, o, n)  \                                                                           
-       _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+       _pcp_protect_return(cmpxchg, pcp, o, n)
 #define this_cpu_cmpxchg_4(pcp, o, n)  \                                                                           
-       _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
+       _pcp_protect_return(cmpxchg, pcp, o, n)
 #define this_cpu_cmpxchg_8(pcp, o, n)  \                                                                           
+       _pcp_protect_return(cmpxchg, pcp, o, n)

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

Since cmpxchg_local = cmpxchg_relaxed, seems like this is not necessary.

> Nothing about your patch along since it was the same before, but I'm
> wondering whether this is a good time to switchover.

I would say that another patch is more appropriate to change this, 
if desired.

> The other thing is would it be good to copy arch-list for each arch patch?
> Maybe it'll help to extend the audience too.

Yes, should have done that (or CC each individual maintainer). Will do
on next version.

Thanks.

