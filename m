Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75056A8BC9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCBW0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCBW0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:26:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD8329175
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677795961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFq8qp6M7dSmGx8Gz93tP0jf4xtRfEYWcv1XZPRpaEw=;
        b=KtVYdx1Mpk2I1aBkBRIczPUMuK8exOq+NWqWDP7GZ/qJZzMNyEuPXwo71SgDFrfipXYY0k
        nZdqOuw4Il79KxoMpUw0ctgx5lizV4Ky1+QMrm7ufOUr5MLLNvpxcK36FgUMzvVDbQxw32
        P1bX1iJ0e3Gr60Wbn+x8QghUUzMEwaU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-pAtAume1MO-G090Y0Z-igg-1; Thu, 02 Mar 2023 16:25:11 -0500
X-MC-Unique: pAtAume1MO-G090Y0Z-igg-1
Received: by mail-qk1-f198.google.com with SMTP id d10-20020a05620a240a00b0073baf1de8ebso184977qkn.19
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 13:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677792311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFq8qp6M7dSmGx8Gz93tP0jf4xtRfEYWcv1XZPRpaEw=;
        b=Adr9TaqDqjjdE3iqzeD6PE2mk/barykZr9zcDc8xp1Hqry7uRXQVg9NpW+nPkPGwt1
         yxPyoUHMHmFHkPlFNpnO7ei6eEtJmSQi3t3wzFyZWYrPuia2bWFhAzwHaP5zp62CSBys
         jXviFmP8Dnyl3uEu+QT/r3B1MRQQU4jZnnLAP47k2GjkURXaWrY9UNmu16xEUvkyQvPb
         OA6L1V2u26zF1Awx88LFMKajtL2Qs4CpxV4KSWwd/dLUT5AVFlmSIIMebsulzXDmb2VJ
         f1Yx/R/Vc5O+vD+pqOM9H3QV9ObFiYD6utfeNwyxudqoG5QqBDPrC4p0cxyruCVWbZox
         BA6Q==
X-Gm-Message-State: AO0yUKUBuM4AZzscQ50jeG2xUaKVlIQW1wEunr6RJ/aPgrijQNAwpxpV
        EZmq03Ayg5jneIZhMkfhpdwuOLUAvt6nKMiNbIzuqULICzdmtcr3QTwb+/IpMQ5AbIyBgzg78SB
        oEzXc3oa/zYxJ+JmCnRmxS75/
X-Received: by 2002:a05:622a:1a99:b0:3bf:a061:6cae with SMTP id s25-20020a05622a1a9900b003bfa0616caemr22098278qtc.5.1677792310863;
        Thu, 02 Mar 2023 13:25:10 -0800 (PST)
X-Google-Smtp-Source: AK7set9knXpqPtJm74PSh3rkR9iwQNfM4d1iprlf1Mh6s41OicEkxWL4aHCA/4Fo4DOaxsfggfbMRA==
X-Received: by 2002:a05:622a:1a99:b0:3bf:a061:6cae with SMTP id s25-20020a05622a1a9900b003bfa0616caemr22098258qtc.5.1677792310534;
        Thu, 02 Mar 2023 13:25:10 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id b1-20020ac84f01000000b003bb8c60cdf1sm422684qte.78.2023.03.02.13.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 13:25:09 -0800 (PST)
Date:   Thu, 2 Mar 2023 16:25:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 02/11] this_cpu_cmpxchg: ARM64: switch
 this_cpu_cmpxchg to locked, add _local function
Message-ID: <ZAEUNEWQ01w1WXlz@x1n>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.683821550@redhat.com>
 <ZAEMuD5pkk/TrK23@x1n>
 <ZAEPWQrdZd1N1rkn@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAEPWQrdZd1N1rkn@tpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 06:04:25PM -0300, Marcelo Tosatti wrote:
> On Thu, Mar 02, 2023 at 03:53:12PM -0500, Peter Xu wrote:
> > On Thu, Feb 09, 2023 at 12:01:52PM -0300, Marcelo Tosatti wrote:
> > > Goal is to have vmstat_shepherd to transfer from
> > > per-CPU counters to global counters remotely. For this, 
> > > an atomic this_cpu_cmpxchg is necessary.
> > > 
> > > Following the kernel convention for cmpxchg/cmpxchg_local,
> > > change ARM's this_cpu_cmpxchg_ helpers to be atomic,
> > > and add this_cpu_cmpxchg_local_ helpers which are not atomic.
> > 
> > I can follow on the necessity of having the _local version, however two
> > questions below.
> > 
> > > 
> > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > 
> > > Index: linux-vmstat-remote/arch/arm64/include/asm/percpu.h
> > > ===================================================================
> > > --- linux-vmstat-remote.orig/arch/arm64/include/asm/percpu.h
> > > +++ linux-vmstat-remote/arch/arm64/include/asm/percpu.h
> > > @@ -232,13 +232,23 @@ PERCPU_RET_OP(add, add, ldadd)
> > >  	_pcp_protect_return(xchg_relaxed, pcp, val)
> > >  
> > >  #define this_cpu_cmpxchg_1(pcp, o, n)	\
> > > -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> > >  #define this_cpu_cmpxchg_2(pcp, o, n)	\
> > > -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> > >  #define this_cpu_cmpxchg_4(pcp, o, n)	\
> > > -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> > >  #define this_cpu_cmpxchg_8(pcp, o, n)	\
> > > +	_pcp_protect_return(cmpxchg, pcp, o, n)
> > 
> > This makes this_cpu_cmpxchg_*() not only non-local, but also (especially
> > for arm64) memory barrier implications since cmpxchg() has a strong memory
> > barrier, while the old this_cpu_cmpxchg*() doesn't have, afaiu.
> > 
> > Maybe it's not a big deal if the audience of this helper is still limited
> > (e.g. we can add memory barriers if we don't want strict ordering
> > implication), but just to check with you on whether it's intended, and if
> > so whether it may worth some comments.
> 
> It happens that on ARM-64 cmpxchg_local == cmpxchg_relaxed.
> 
> See cf10b79a7d88edc689479af989b3a88e9adf07ff.

This is more or less a comment in general, rather than for arm only.

Fundamentally starting from this patch it's redefining this_cpu_cmpxchg().
What I meant is whether we should define it properly then implement the
arch patches with what is defined.

We're adding non-local semantics into it, which is obvious to me.

We're (silently, in this patch for aarch64) adding memory barrier semantics
too, this is not obvious to me on whether all archs should implement this
api the same way.

It will make a difference IMHO when the helpers are used in any other code
clips, because IIUC proper definition of memory barrier implications will
decide whether the callers need explicit barriers when ordering is required.

> 
> This patchset maintains the current behaviour
> of this_cpu_cmpxch (for this_cpu_cmpxch_local), which was:
> 
>  #define this_cpu_cmpxchg_1(pcp, o, n)  \                                                                           
> -       _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +       _pcp_protect_return(cmpxchg, pcp, o, n)
>  #define this_cpu_cmpxchg_2(pcp, o, n)  \                                                                           
> -       _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +       _pcp_protect_return(cmpxchg, pcp, o, n)
>  #define this_cpu_cmpxchg_4(pcp, o, n)  \                                                                           
> -       _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +       _pcp_protect_return(cmpxchg, pcp, o, n)
>  #define this_cpu_cmpxchg_8(pcp, o, n)  \                                                                           
> +       _pcp_protect_return(cmpxchg, pcp, o, n)
> 
> > > +
> > > +#define this_cpu_cmpxchg_local_1(pcp, o, n)	\
> > >  	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > +#define this_cpu_cmpxchg_local_2(pcp, o, n)	\
> > > +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > +#define this_cpu_cmpxchg_local_4(pcp, o, n)	\
> > > +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > > +#define this_cpu_cmpxchg_local_8(pcp, o, n)	\
> > > +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> > 
> > I think cmpxchg_relaxed()==cmpxchg_local() here for aarch64, however should
> > we still use cmpxchg_local() to pair with this_cpu_cmpxchg_local_*()?
> 
> Since cmpxchg_local = cmpxchg_relaxed, seems like this is not necessary.
> 
> > Nothing about your patch along since it was the same before, but I'm
> > wondering whether this is a good time to switchover.
> 
> I would say that another patch is more appropriate to change this, 
> if desired.

Sure on this one.  Thanks,

-- 
Peter Xu

