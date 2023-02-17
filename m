Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3015469B294
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBQSuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBQSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:50:12 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DCE3C2C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 10:50:10 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id p33so1116963pfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 10:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=txCbIcxMcKNWF/8/Xv4WaLkszxM0EFbIb80kOwi9Rfc=;
        b=DoyZ0IuvT9n0MkYehst+WgppOwJf4TBkUptMWVrr+72g5BBNmp9R+Jd5HsD22vWeow
         +ry/TEXLMU/Ft/r1cC7WjqyybGO9b9I9SRDu2Eq7ratNg6JQgVlYkMw6wJWEO9M4yxGC
         FlzWFl6/rPQGxhqhVz0td9KNMibW9jb1iUL1loJleWrTIIi+sLaondd3j77EpBuY3HTt
         rNPjllusoF93h15OUC9ZM9HYWozAcsDcVY1LFhQMJYIlN+FIB9F6p+fT47ZdADXSKrAM
         AljoCIDQwQSc2Kh+R9yG0ImV7hvIvtbUWa8dB7ey2t4jTnSqPy6BE+l4VD980Ae/4VO1
         /hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txCbIcxMcKNWF/8/Xv4WaLkszxM0EFbIb80kOwi9Rfc=;
        b=2vIaAke44p45Pxb8C5aDzZCFghJkjBAOZp8jYhrJWhyovxXKs8OKmen5uboZJQ02f7
         VMdtdOjQmzSI08WWm3hkuq2jfLl53y88zTe7OkHvNMbIFmuzHuQL7OSdW0LM+jBb4VmJ
         JsfRDMXFTwOlPG+r+gTvsFQYmLxYb5zfejC1N7e1vIdy7pYVtL8cFhl7uafNhLS5ezFS
         Lt53UvZ8aKGfjn4GmQxcVdHbZ1GjWzAA00MCVI1SWuA9fvJtin+1gvC7XlR+gBxyaBro
         yO7Iq1uf2fGpo2bcAOfvpzqK8nMjQ5g3cdx4qpQkVZkiOhxlwH9ZXh7ibhyZw262jdde
         qnuw==
X-Gm-Message-State: AO0yUKX4TSkO6EnItNqz8lNAIWDMMER/V3Yub4BUylphzViiLMuIfbh/
        xgfzq8BinkbbkYXQaZdaFlc=
X-Google-Smtp-Source: AK7set9KYoFRQrG2DJscVGs0pH8tAGSBxCGsCiCA+9GB+lMylmI+TFq2V2i+aqg9/Vw1XgM3dp91jQ==
X-Received: by 2002:aa7:9608:0:b0:5a8:cbcc:4b58 with SMTP id q8-20020aa79608000000b005a8cbcc4b58mr1454308pfg.12.1676659810012;
        Fri, 17 Feb 2023 10:50:10 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id u21-20020a62ed15000000b00581ad007a9fsm3385410pfh.153.2023.02.17.10.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 10:50:08 -0800 (PST)
Date:   Fri, 17 Feb 2023 18:49:53 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        aarcange@redhat.com
Subject: Re: [PATCH v3 26/35] mm: fall back to mmap_lock if vma->anon_vma is
 not yet set
Message-ID: <Y+/MUXZ8Mm0DKWSV@localhost>
References: <20230216051750.3125598-1-surenb@google.com>
 <20230216051750.3125598-27-surenb@google.com>
 <Y+5Pb4hGmV1YtNQp@casper.infradead.org>
 <CAJuCfpHR8k0GsrYPMjSBVLAbu3EZgDU081+5CnR1td0cLEyDFw@mail.gmail.com>
 <CAJuCfpHODBAV=riSPyvcmLbZVtXSdxrw2GMy8VOjvDV9yCyX8A@mail.gmail.com>
 <CAB=+i9ToNQ-se1XWGOGbiM_0QRBYjuhCF5A8Cdvius89t8r7Ag@mail.gmail.com>
 <CAJuCfpHeeRymNmAZ+FAFgdVMDFOHNeZB+7d6PHHL8uFVbshu8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHeeRymNmAZ+FAFgdVMDFOHNeZB+7d6PHHL8uFVbshu8g@mail.gmail.com>
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 08:13:01AM -0800, Suren Baghdasaryan wrote:
> On Fri, Feb 17, 2023 at 2:21 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > On Fri, Feb 17, 2023 at 11:15 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Thu, Feb 16, 2023 at 11:43 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Thu, Feb 16, 2023 at 7:44 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Wed, Feb 15, 2023 at 09:17:41PM -0800, Suren Baghdasaryan wrote:
> > > > > > When vma->anon_vma is not set, page fault handler will set it by either
> > > > > > reusing anon_vma of an adjacent VMA if VMAs are compatible or by
> > > > > > allocating a new one. find_mergeable_anon_vma() walks VMA tree to find
> > > > > > a compatible adjacent VMA and that requires not only the faulting VMA
> > > > > > to be stable but also the tree structure and other VMAs inside that tree.
> > > > > > Therefore locking just the faulting VMA is not enough for this search.
> > > > > > Fall back to taking mmap_lock when vma->anon_vma is not set. This
> > > > > > situation happens only on the first page fault and should not affect
> > > > > > overall performance.
> > > > >
> > > > > I think I asked this before, but don't remember getting an aswer.
> > > > > Why do we defer setting anon_vma to the first fault?  Why don't we
> > > > > set it up at mmap time?
> > > >
> > > > Yeah, I remember that conversation Matthew and I could not find the
> > > > definitive answer at the time. I'll look into that again or maybe
> > > > someone can answer it here.
> > >
> > > After looking into it again I'm still under the impression that
> > > vma->anon_vma is populated lazily (during the first page fault rather
> > > than at mmap time) to avoid doing extra work for areas which are never
> > > faulted. Though I might be missing some important detail here.
> >
> > I think this is because the kernel cannot merge VMAs that have
> > different anon_vmas?
> >
> > Enabling lazy population of anon_vma could potentially increase the
> > chances of merging VMAs.
> 
> Hmm. Do you have a clear explanation why merging chances increase this
> way? A couple of possibilities I can think of would be:
> 1. If after mmap'ing a VMA and before faulting the first page into it
> we often change something that affects anon_vma_compatible() decision,
> like vm_policy;
> 2. When mmap'ing VMAs we do not map them consecutively but the final
> arrangement is actually contiguous.
> 
> Don't think either of those cases would be very representative of a
> usual case but maybe I'm wrong or there is another reason?

Ok. I agree it does not represent common cases.

Hmm then I wonder how it went from the initial approach of "allocate anon_vma
objects only via fork()" [1] to "populate anon_vma at page faults". [2] [3]

Maybe Hugh, Andrea or Andrew have opinions?

[1] anon_vma RFC2, lore.kernel.org
https://lore.kernel.org/lkml/20040311065254.GT30940@dualathlon.random

[2] The status of object-based reverse mapping, LWN.net
https://lwn.net/Articles/85908

[3] rmap 39 add anon_vma rmap
https://gitlab.com/hyeyoo/linux-historical/-/commit/8aa3448cabdfca146aa3fd36e852d0209fb2276a

> 
> >
> > > > In the end rather than changing that logic I decided to skip
> > > > vma->anon_vma==NULL cases because I measured them being less than
> > > > 0.01% of all page faults, so ROI from changing that would be quite
> > > > low. But I agree that the logic is weird and maybe we can improve
> > > > that. I will have to review that again when I'm working on eliminating
> > > > all these special cases we skip, like swap/userfaults/etc.
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
