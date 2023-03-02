Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D303F6A84D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCBPD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCBPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:03:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DC8158B5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677769381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LVBHeaUDd3fMfdryiaZTF5F5Bv975tBnlPCSsjv5Pzs=;
        b=AE3JvrTtA6o+L/tN3KFTT7eXfnB1+ATjT8JoPnQF/UEUx5kH7l9Wi/LxxClkslGIE7Dcji
        17O5wNWXVdCbYe+QbgsdFAgRVTCS9DiHW5vpE9rFOOV6ls2lrIy/PiNUMOZZN5LMgDIzK8
        2qMar/wP5UlkNPSjmbSCPYteW4jRSW4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-1PGCLXHvPm-glmSZu0fXJA-1; Thu, 02 Mar 2023 09:48:48 -0500
X-MC-Unique: 1PGCLXHvPm-glmSZu0fXJA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8117485A5B1;
        Thu,  2 Mar 2023 14:48:47 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C6BF492C3E;
        Thu,  2 Mar 2023 14:48:47 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id D78F7403CC770; Thu,  2 Mar 2023 11:32:06 -0300 (-03)
Date:   Thu, 2 Mar 2023 11:32:06 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 02/11] this_cpu_cmpxchg: ARM64: switch
 this_cpu_cmpxchg to locked, add _local function
Message-ID: <ZACzZmPipYadVlan@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.683821550@redhat.com>
 <a754561a-1d0a-ebfb-952f-054bae6dc533@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a754561a-1d0a-ebfb-952f-054bae6dc533@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:42:57AM +0100, David Hildenbrand wrote:
> On 09.02.23 16:01, Marcelo Tosatti wrote:
> > Goal is to have vmstat_shepherd to transfer from
> > per-CPU counters to global counters remotely. For this,
> > an atomic this_cpu_cmpxchg is necessary.
> > 
> > Following the kernel convention for cmpxchg/cmpxchg_local,
> > change ARM's this_cpu_cmpxchg_ helpers to be atomic,
> > and add this_cpu_cmpxchg_local_ helpers which are not atomic.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > Index: linux-vmstat-remote/arch/arm64/include/asm/percpu.h
> > ===================================================================
> > --- linux-vmstat-remote.orig/arch/arm64/include/asm/percpu.h
> > +++ linux-vmstat-remote/arch/arm64/include/asm/percpu.h
> > @@ -232,13 +232,23 @@ PERCPU_RET_OP(add, add, ldadd)
> >   	_pcp_protect_return(xchg_relaxed, pcp, val)
> >   #define this_cpu_cmpxchg_1(pcp, o, n)	\
> > -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> >   #define this_cpu_cmpxchg_2(pcp, o, n)	\
> > -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> >   #define this_cpu_cmpxchg_4(pcp, o, n)	\
> > -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> >   #define this_cpu_cmpxchg_8(pcp, o, n)	\
> > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> > +
> > +#define this_cpu_cmpxchg_local_1(pcp, o, n)	\
> >   	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +#define this_cpu_cmpxchg_local_2(pcp, o, n)	\
> > +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +#define this_cpu_cmpxchg_local_4(pcp, o, n)	\
> > +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +#define this_cpu_cmpxchg_local_8(pcp, o, n)	\
> > +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > +
> 
> Call me confused (not necessarily your fault :) ).
> 
> We have cmpxchg_local, cmpxchg_relaxed and cmpxchg. this_cpu_cmpxchg_local_*
> now calls ... *drumroll* ... cmpxchg_relaxed.
> IIUC, cmpxchg_local is only guaranteed to be atomic WRO the current CPU
> (especially, protection against interrupts when the operation is implemented
> using multiple instructions). We do have a generic implementation that
> disables/enables interrupts.
>
> IIUC, cmpxchg_relaxed an atomic update without any memory ordering
> guarantees (in contrast to cmpxchg, cmpxchg_acquire, cmpxchg_acquire). We
> default to arch_cmpxchg if we don't have arch_cmpxchg_relaxed. arch_cmpxchg
> defaults to arch_cmpxchg_local, if not supported.
> 
> 
> Naturally I wonder:
> 
> (a) Should these new variants be rather called
>     this_cpu_cmpxchg_relaxed_* ?

No: it happens that on ARM-64 cmpxchg_local == cmpxchg_relaxed.

See cf10b79a7d88edc689479af989b3a88e9adf07ff.

> (b) Should these new variants rather call the "_local" variant?

They probably should. But this patchset maintains the current behaviour
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


Thanks.

