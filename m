Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964AA70C564
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjEVSjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjEVSjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:39:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB471B9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:39:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae3f74c98bso25535ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684780769; x=1687372769;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IkpcRDNkOOODVCnn1hDZZbsw/3fOEgCHc0bkhJY18A=;
        b=P1HLMkzla79i/ysHkbsLNfYqQ9PC1Xkr6LLFY6snfR1enM3WNmxZp5NNPrpRzv/xf+
         fD08OlxmKhCXYlLdpNJqU8yiGUVJqHh4BS+e6JtYIvBENgMqURL8WY1vjoncYEf7ftm6
         T5Uu0mby8+u4mbnVbfN66U+SffoXsJzyaktcQajoGskkMKpLw9fQgZtHpccZNSp2U9NZ
         N8yrbHC+J50NnSrPG8A94Xf/fKUh/qbtyGmJjKshGlpn+5YJ4oNJUqjksj5YZ88Oe2Ue
         RQW1d+7EAv3XB7CTni5ijbQbTykoqBibC1b44zpuWRDQt7e4NnhSIgdIwO1/rqJJnHg+
         7Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780769; x=1687372769;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IkpcRDNkOOODVCnn1hDZZbsw/3fOEgCHc0bkhJY18A=;
        b=gfM4aUQaIPMkZc9U+EGynfG4RGDP79S3spqmLoUuPnt4p6vJRqdcN8Qh/rr1OuZPKq
         2zCSxFf2G0ATCVnkB05lvLsNcLVGcscbdg676RowuTjXf0SjAEUL8LlvmQwpkm9ABRtR
         7m/J2YizANf9gWgU2bxeFz/+NLEMssojsgG7m+Mq3aS60gfREGavBQAQH5GCkJA1xWFU
         GY2mDnx1cYmwwLB9M0TxO/HPIChZ/zuVGwXHb/YTjRZ9/AGo7ctQGBQZAN3r8mBGpYFK
         8oCQUQDrCvfIQBU5OMploQZPMQfLJw65VN00JhgoSkyKZaMs45B99UhyiaSzyViCJOEU
         FAHw==
X-Gm-Message-State: AC+VfDz1UmwcWkEMTHWxbdG752eoCiKipHz7pGyX6/nMXYBtr5Byj6/h
        VcPTwSjFNPEzJJQ7nYy+ck2yXw==
X-Google-Smtp-Source: ACHHUZ7RGriAXZ4HwGIPMuA98nEGlUivY9OrkCxW0U/hbJBbuP1Ahs2ukARb2u60CxdpTF3O5QVB6w==
X-Received: by 2002:a17:902:f54c:b0:1ac:36e6:2801 with SMTP id h12-20020a170902f54c00b001ac36e62801mr13988plf.12.1684780769234;
        Mon, 22 May 2023 11:39:29 -0700 (PDT)
Received: from [2620:0:1008:11:2b0e:a3da:5943:182] ([2620:0:1008:11:2b0e:a3da:5943:182])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902744800b001ab0d815dbbsm5164339plt.23.2023.05.22.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:39:28 -0700 (PDT)
Date:   Mon, 22 May 2023 11:39:27 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     David Hildenbrand <david@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Alex Shi <alexs@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch] mm, debug: allow suppressing panic on CONFIG_DEBUG_VM
 checks
In-Reply-To: <b4dce681-e53c-a6fd-2dab-62a82ebc6dff@redhat.com>
Message-ID: <53dd9df8-e88f-f466-89f9-3fa141a10267@google.com>
References: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com> <b4dce681-e53c-a6fd-2dab-62a82ebc6dff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023, David Hildenbrand wrote:

> Let me CC Linus, he might have an opinion on this.
> 
> On 22.05.23 01:07, David Rientjes wrote:
> > CONFIG_DEBUG_VM is used to enable additional MM debug checks at runtime.
> > This can be used to catch latent kernel bugs.
> > 
> > Because this is mainly used for debugging, it is seldom enabled in
> > production environments, including due to the added performance overhead.
> > Thus, the choice between VM_BUG_ON() and VM_WARN_ON() is somewhat loosely
> > defined.
> > 
> > VM_BUG_ON() is often used because debuggers would like to collect crash
> > dumps when unexpected conditions occur.
> > 
> > When CONFIG_DEBUG_VM is enabled on a very small set of production
> > deployments to catch any unexpected condition, however, VM_WARN_ON()
> > could be used as a substitute.  In these configurations, it would be
> > useful to surface the unexpected condition in the kernel log but not
> > panic the system.
> > 
> > In other words, it would be useful if checks done by CONFIG_DEBUG_ON
> > could both generate crash dumps for kernel developers *and* surface
> > issues but not crash depending on how it's configured.
> > 
> >   [ If it is really unsafe to continue operation, then BUG_ON() would be
> >     used instead so that the kernel panics regardless of whether
> >     CONFIG_DEBUG_VM is enabled or not. ]
> > 
> > Introduce the ability to suppress kernel panics when VM_BUG_ON*() variants
> > are used.  This leverages the existing vm_debug= kernel command line
> > option.
> > 
> > Additionally, this can reduce the risk of systems boot looping if
> > VM_BUG_ON() conditions are encountered during bootstrap.
> > 
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > ---
> > Note: the vm_debug= kernel parameter is only extensible for new debug
> > options, not for disabling existing debug options.
> > 
> > When adding the ability to selectively disable existing debug options,
> > such as in this patch, admins would need to know this future set of debug
> > options in advance.  In other words, if admins would like to preserve the
> > existing behavior of BUG() when VM_BUG_ON() is used after this patch, they
> > would have had to have the foresight to use vm_debug=B.
> > 
> > It would be useful to rewrite the vm_debug= interface to select the
> > specific options to disable rather than "disable all, and enable those
> > that are specified."  This could be done by making vm_debug only disable
> > the listed debug options rather than enabling them.
> > 
> > This change could be done before this patch is merged if that's the agreed
> > path forward.
> 
> 
> In general, I am not a fan of this. Someone told the system to VM_BUG_ON, but
> we ignore that and default to a warning. Yes, VM_BUG on get compiled out
> without CONFIG_DEBUG_VM, but we detected something (with more checks enabled!)
> that doesn't want the system to continue (could be an unrecoverable situation
> leading to data loss, for example).
> 

I think VM_BUG_ON*() and friends are used to crash the kernel for 
debugging so that we get a crash dump and because some variants don't 
exist for VM_WARN_ON().  There's no VM_WARN_ON_PAGE(), for example, unless 
implicitly converted with this patch.

I'm having a hard time finding a case where VM_BUG_ON() should *require* a 
kernel crash.  I'd be interested to know of these if they exist, though, 
because we have had good success discovering latent kernel bugs that have 
been reported to upstream with the exact approach being proposed here on a 
small set of production hosts.  To safely do that, we audited existing 
VM_BUG_ON()s in the code to make sure there was nothing that absolutely 
required a kernel crash.  That may have changed in more recent kernels, so 
any examples would be very useful.

> Yes, we want to convert more VM_BUG to VM_WARN (or rather WARN+recovery code
> as documented in coding-style.rst ), or even simply remove some of the old
> VM_BUG leftovers that might no longer be required. But then I'd much invest
> more time doing that step by step (keeping the VM_BUG + BUG that are
> absolutely reasonable) instead of adding such a config options.
> 

I'm not sure we actually want to do that, though, since VM_BUG_ON() does 
have a lot of benefit when debugging something: it can generate a crash 
dump that is tremendously useful to the kernel debugger who is iterating 
on their patch set.

The goal of this patch is to provide an additional use case for 
CONFIG_DEBUG_VM: we want to preserve the ability for kernel developers to 
quickly crash their debug kernel during development and add the additional 
use case of surfacing WARN_ON()s to the kernel log for unexpected issues 
on a small set of production hosts without crashing them.  This second use 
case has been very helpful in finding latent kernel bugs at runtime that 
we didn't even know existed in the kernel and could only be found while 
running on a limited production deployment.  If we had to crash the kernel 
to find those, and terminate all the associated guests/workloads, that 
would be a non-starter for us.

> 
> > ---
> >   .../admin-guide/kernel-parameters.txt         |  1 +
> >   include/linux/mmdebug.h                       | 20 ++++++++++++++-----
> >   mm/debug.c                                    | 14 ++++++++++++-
> >   3 files changed, 29 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > b/Documentation/admin-guide/kernel-parameters.txt
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6818,6 +6818,7 @@
> >   			debugging features.
> >     			Available options are:
> > +			  B	Enable panic on MM debug checks
> >   			  P	Enable page structure init time poisoning
> >   			  -	Disable all of the above options
> >   diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> > --- a/include/linux/mmdebug.h
> > +++ b/include/linux/mmdebug.h
> > @@ -13,34 +13,44 @@ void dump_page(struct page *page, const char *reason);
> >   void dump_vma(const struct vm_area_struct *vma);
> >   void dump_mm(const struct mm_struct *mm);
> >   +extern bool debug_vm_bug_enabled;
> > +
> >   #ifdef CONFIG_DEBUG_VM
> > -#define VM_BUG_ON(cond) BUG_ON(cond)
> > +#define VM_BUG_ON(cond)
> > \
> > +	do {								\
> > +		if (unlikely(cond)) {					\
> > +			if (likely(debug_vm_bug_enabled))		\
> > +				BUG();					\
> > +			else						\
> > +				WARN_ON(1);				\
> > +		}							\
> > +	} while (0)
> >   #define VM_BUG_ON_PAGE(cond, page)					\
> >   	do {								\
> >   		if (unlikely(cond)) {					\
> >   			dump_page(page, "VM_BUG_ON_PAGE("
> > __stringify(cond)")");\
> > -			BUG();						\
> > +			VM_BUG_ON(1);					\
> >   		}							\
> >   	} while (0)
> >   #define VM_BUG_ON_FOLIO(cond, folio)
> > \
> >   	do {								\
> >   		if (unlikely(cond)) {					\
> >   			dump_page(&folio->page, "VM_BUG_ON_FOLIO("
> > __stringify(cond)")");\
> > -			BUG();						\
> > +			VM_BUG_ON(1);					\
> >   		}							\
> >   	} while (0)
> >   #define VM_BUG_ON_VMA(cond, vma)					\
> >   	do {								\
> >   		if (unlikely(cond)) {					\
> >   			dump_vma(vma);					\
> > -			BUG();						\
> > +			VM_BUG_ON(1);					\
> >   		}							\
> >   	} while (0)
> >   #define VM_BUG_ON_MM(cond, mm)
> > \
> >   	do {								\
> >   		if (unlikely(cond)) {					\
> >   			dump_mm(mm);					\
> > -			BUG();						\
> > +			VM_BUG_ON(1);					\
> >   		}							\
> >   	} while (0)
> >   #define VM_WARN_ON_ONCE_PAGE(cond, page)	({			\
> > diff --git a/mm/debug.c b/mm/debug.c
> > --- a/mm/debug.c
> > +++ b/mm/debug.c
> > @@ -224,10 +224,15 @@ void dump_mm(const struct mm_struct *mm)
> >   }
> >   EXPORT_SYMBOL(dump_mm);
> >   +/* If disabled, warns but does not panic on added CONFIG_DEBUG_VM checks
> > */
> > +bool debug_vm_bug_enabled = true;
> > +EXPORT_SYMBOL(debug_vm_bug_enabled);
> > +
> >   static bool page_init_poisoning __read_mostly = true;
> >     static int __init setup_vm_debug(char *str)
> >   {
> > +	bool __debug_vm_bug_enabled = true;
> >   	bool __page_init_poisoning = true;
> >     	/*
> > @@ -237,13 +242,17 @@ static int __init setup_vm_debug(char *str)
> >   	if (*str++ != '=' || !*str)
> >   		goto out;
> >   +	__debug_vm_bug_enabled = false;
> >   	__page_init_poisoning = false;
> >   	if (*str == '-')
> >   		goto out;
> >     	while (*str) {
> >   		switch (tolower(*str)) {
> > -		case'p':
> > +		case 'b':
> > +			__debug_vm_bug_enabled = true;
> > +			break;
> > +		case 'p':
> >   			__page_init_poisoning = true;
> >   			break;
> >   		default:
> > @@ -254,9 +263,12 @@ static int __init setup_vm_debug(char *str)
> >   		str++;
> >   	}
> >   out:
> > +	if (debug_vm_bug_enabled && !__debug_vm_bug_enabled)
> > +		pr_warn("Panic on MM debug checks disabled by kernel command
> > line option 'vm_debug'\n");
> >   	if (page_init_poisoning && !__page_init_poisoning)
> >   		pr_warn("Page struct poisoning disabled by kernel command line
> > option 'vm_debug'\n");
> >   +	debug_vm_bug_enabled = __debug_vm_bug_enabled;
> >   	page_init_poisoning = __page_init_poisoning;
> >     	return 1;
> > 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 
