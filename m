Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599DD6A8ADC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCBUyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCBUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:54:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A3158B0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 12:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677790395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFteTQZxv39AZEWRs/xshoWQSfK5OjMT5GVWCCENUyA=;
        b=fWqEFiUVyhqakNvD7PHva19s7f55cxiE4oZcE4ioevnm8Zs9F1ofKqQEuInF9cc3oioN/9
        Qczb0h/fnnphyVRuW8NhrzuLPuGuCAdDxnxYIxdDHHwZIkjUSIurBxGyLexqZNL9gwVf2N
        E5DeXCq9ZvJ3NYsYHoRXYc8y0SrPE/c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-417-PDbcmt1FMQSceobjmLcHbg-1; Thu, 02 Mar 2023 15:53:14 -0500
X-MC-Unique: PDbcmt1FMQSceobjmLcHbg-1
Received: by mail-qv1-f70.google.com with SMTP id x18-20020ad44592000000b00571bb7cdc42so275016qvu.23
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 12:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677790394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFteTQZxv39AZEWRs/xshoWQSfK5OjMT5GVWCCENUyA=;
        b=7BaAZphTRxFjKZjiPT2ia0LwcYy/pDzVVddqxBMrJyfzMAD4HQgkikjRNzD39V1sU8
         GvA+4UGWFFfGEw3GYgUIsXdE1mufBu0zt9nBFmAft51VimhCdwfPdwez2k4G7XbAGISx
         2+RI5wP4q+SauTcZtWxoFTImvLcmkJozTo83XEmmHZn8KdwQFUMNfYXhejpZt38OH4GX
         GJmmmW5S8IQcKc27x7t24X4prfFp9GALoKWTYW87A/UlfSzxe1zhae4eGGkcmLvqvtSN
         xn1lRG8QikK+6/nltSa8KjA0loLAtyVCqty/+tTd1N2Qx1Px3p+YMLVZtFCDNqiG65iU
         t3+g==
X-Gm-Message-State: AO0yUKUuIpGhOAL4tz6rL+GgJrH295kgUW6WKJC/xIMQmPOPEzBddGFC
        6Fq/wRvxjPl0NFOOcJPHsPSwJSZTOg3qoe6vIDxvTKWEdfCI3g0N7wzOz9aYcYNnUpx60tyJZNQ
        1FcUsgyz1KDq8HDQytwXGh356
X-Received: by 2002:a05:622a:1391:b0:3bf:c458:5bac with SMTP id o17-20020a05622a139100b003bfc4585bacmr22136402qtk.0.1677790393866;
        Thu, 02 Mar 2023 12:53:13 -0800 (PST)
X-Google-Smtp-Source: AK7set/NOvojMFNnz7QT8jO4gKy6syuG1bvbocLVVPCmqIPO33iixEInIIUB6d6JLey/Olnx34XtXg==
X-Received: by 2002:a05:622a:1391:b0:3bf:c458:5bac with SMTP id o17-20020a05622a139100b003bfc4585bacmr22136378qtk.0.1677790393613;
        Thu, 02 Mar 2023 12:53:13 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id a190-20020a3798c7000000b00742aff9574asm363408qke.65.2023.03.02.12.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 12:53:13 -0800 (PST)
Date:   Thu, 2 Mar 2023 15:53:12 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 02/11] this_cpu_cmpxchg: ARM64: switch
 this_cpu_cmpxchg to locked, add _local function
Message-ID: <ZAEMuD5pkk/TrK23@x1n>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.683821550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230209153204.683821550@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 12:01:52PM -0300, Marcelo Tosatti wrote:
> Goal is to have vmstat_shepherd to transfer from
> per-CPU counters to global counters remotely. For this, 
> an atomic this_cpu_cmpxchg is necessary.
> 
> Following the kernel convention for cmpxchg/cmpxchg_local,
> change ARM's this_cpu_cmpxchg_ helpers to be atomic,
> and add this_cpu_cmpxchg_local_ helpers which are not atomic.

I can follow on the necessity of having the _local version, however two
questions below.

> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> Index: linux-vmstat-remote/arch/arm64/include/asm/percpu.h
> ===================================================================
> --- linux-vmstat-remote.orig/arch/arm64/include/asm/percpu.h
> +++ linux-vmstat-remote/arch/arm64/include/asm/percpu.h
> @@ -232,13 +232,23 @@ PERCPU_RET_OP(add, add, ldadd)
>  	_pcp_protect_return(xchg_relaxed, pcp, val)
>  
>  #define this_cpu_cmpxchg_1(pcp, o, n)	\
> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +	_pcp_protect_return(cmpxchg, pcp, o, n)
>  #define this_cpu_cmpxchg_2(pcp, o, n)	\
> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +	_pcp_protect_return(cmpxchg, pcp, o, n)
>  #define this_cpu_cmpxchg_4(pcp, o, n)	\
> -	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +	_pcp_protect_return(cmpxchg, pcp, o, n)
>  #define this_cpu_cmpxchg_8(pcp, o, n)	\
> +	_pcp_protect_return(cmpxchg, pcp, o, n)

This makes this_cpu_cmpxchg_*() not only non-local, but also (especially
for arm64) memory barrier implications since cmpxchg() has a strong memory
barrier, while the old this_cpu_cmpxchg*() doesn't have, afaiu.

Maybe it's not a big deal if the audience of this helper is still limited
(e.g. we can add memory barriers if we don't want strict ordering
implication), but just to check with you on whether it's intended, and if
so whether it may worth some comments.

> +
> +#define this_cpu_cmpxchg_local_1(pcp, o, n)	\
>  	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +#define this_cpu_cmpxchg_local_2(pcp, o, n)	\
> +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +#define this_cpu_cmpxchg_local_4(pcp, o, n)	\
> +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +#define this_cpu_cmpxchg_local_8(pcp, o, n)	\
> +	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)

I think cmpxchg_relaxed()==cmpxchg_local() here for aarch64, however should
we still use cmpxchg_local() to pair with this_cpu_cmpxchg_local_*()?

Nothing about your patch along since it was the same before, but I'm
wondering whether this is a good time to switchover.

The other thing is would it be good to copy arch-list for each arch patch?
Maybe it'll help to extend the audience too.

Thanks,

-- 
Peter Xu

