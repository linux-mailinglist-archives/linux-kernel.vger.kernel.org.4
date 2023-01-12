Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81CE6675C6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjALOY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbjALOX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:23:56 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561985564C;
        Thu, 12 Jan 2023 06:16:05 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id u9so45151615ejo.0;
        Thu, 12 Jan 2023 06:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7s1Hp6L+fR8Xqi7tlyntMmzEagmWp0BgSGtBgmjIU8=;
        b=u1yS/1zsAwjfebqK6/7413xA2+cSmDK3N7lo4Patim/gRYYN1AtoAJEeFj4A9yzO4L
         Uaf8gYBfHQaHtDiX658MYPwHIrrqXrDENR1wMakNRpT7c/MfnkR9uJyhKgD2n/PH+sN9
         SBbgz9ctM/89xxDrEjmKR+ET7QLo6TVAw28V6fPRr/CQUPJ5JotQZeKXlnt2dnNiU+nh
         MC1Wd0X3zbtHmvOokzDgl7VMVZAwt1ktK6/fHmRGBZGwEBRdr1Nfa39VWPkCNw/bM2tp
         EdD17cfi6CPrAHRX/Kaf7MW2YRyWlJrXic9snV5wbP7Tvr2ummIYccvf3TQ1Sp0dINHS
         U69Q==
X-Gm-Message-State: AFqh2kpWvFsMFvdl3TM/mSVX1VuCDp9txcS5FenjYyUE/WTWtfKPm2st
        /h0FLVuakX+f6VA2p7+xK5ptllGyfbIGc39UAEE=
X-Google-Smtp-Source: AMrXdXv7WQAdxWLHtR4nNw8monJdK7YTHBGcxO6VxhJR3UBhs6C3BPe7URv35TpaZ3164GMfgC2gTJQyQHj3wl8s5kw=
X-Received: by 2002:a17:906:b28f:b0:84d:381c:bdaa with SMTP id
 q15-20020a170906b28f00b0084d381cbdaamr1924685ejz.79.1673532963646; Thu, 12
 Jan 2023 06:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20230110211839.19572-1-rick.p.edgecombe@intel.com>
 <CAJZ5v0jnp3jLdD1wN1NjMfxrt+gYZ+im_quHdgsOrWve0XQaWg@mail.gmail.com> <cd2a9ccec0d88821fb0c7580f7ae934f2de71ddf.camel@intel.com>
In-Reply-To: <cd2a9ccec0d88821fb0c7580f7ae934f2de71ddf.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Jan 2023 15:15:52 +0100
Message-ID: <CAJZ5v0hffKjor=kzr71esaw7M2BV5vCTEY7pg67-iWXZ98sQBw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/hibernate: Use fixmap for saving unmapped pages
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Brown, Len" <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 9:46 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2023-01-11 at 21:35 +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 10, 2023 at 10:19 PM Rick Edgecombe
> > <rick.p.edgecombe@intel.com> wrote:
> > >
> > > Hibernate uses the direct map to read memory it saves to disk.
> > > Since
> > > sometimes pages are not accessible on the direct map ("not present"
> > > on
> > > x86), it has special case logic to temporarily make a page present.
> > > On x86
> > > these direct map addresses can be mapped at various page sizes, but
> > > the
> > > logic works ok as long as the not present pages are always mapped
> > > as
> > > PAGE_SIZE such that they don't require a split to map the region as
> > > present. If the address was mapped not present by a larger page
> > > size, the
> > > split may fail and hibernate would then try to read an address
> > > mapped not
> > > present.
> > >
> > > Today on x86 there are no known cases of this (huge not present
> > > pages on
> > > the direct map), but it has come up from time to time when
> > > developing
> > > things that operate on the direct map. It blocked making
> > > VM_FLUSH_RESET_PERMS support huge vmalloc when that came up, and
> > > also
> > > has been a complication for various direct map protection efforts.
> > >
> > > This dependency is also pretty hidden and easily missed by people
> > > poking at
> > > the direct map. For this reason, there are warnings in place to
> > > complain
> > > but not handle this scenario.
> > >
> > > One way to make this more robust would be to create some new CPA
> > > functionality that can know to map and reset the whole huge page in
> > > the
> > > case of trying to map a subpage. But for simplicity and smaller
> > > code, just
> > > make x86 hibernate have its own fixmap PTE that it can use to point
> > > to 4k pages when it encounters an unmapped direct map page.
> > >
> > > Move do_copy_page() to a header such that it can be used in an arch
> > > breakout. Rename it hib_copy_page() to be more hibernate specific
> > > since
> > > it could appear in other files.
> > >
> > > Use __weak for the arch breakout because there is not a suitable
> > > arch
> > > specific header to use the #define method.
> > >
> > > Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > ---
> > >
> > > Rebase to v6.2-rc3 (original still applied) and resending per:
> > >
> https://lore.kernel.org/lkml/CAJZ5v0i6cxGD+V6G+q-Y_Lp-ov51_zmkZr8ZGpCtqWV-e=BsLg@mail.gmail.com/
> > >
> > >  arch/x86/include/asm/fixmap.h |  3 +++
> > >  arch/x86/power/hibernate.c    | 10 ++++++++++
> > >  include/linux/suspend.h       | 13 +++++++++++++
> > >  kernel/power/snapshot.c       | 21 +++++++--------------
> > >  4 files changed, 33 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/fixmap.h
> > > b/arch/x86/include/asm/fixmap.h
> > > index d0dcefb5cc59..0fceed9a4152 100644
> > > --- a/arch/x86/include/asm/fixmap.h
> > > +++ b/arch/x86/include/asm/fixmap.h
> > > @@ -108,6 +108,9 @@ enum fixed_addresses {
> > >  #ifdef CONFIG_PARAVIRT_XXL
> > >         FIX_PARAVIRT_BOOTMAP,
> > >  #endif
> > > +#ifdef CONFIG_HIBERNATION
> > > +       FIX_HIBERNATE,
> > > +#endif
> > >
> > >  #ifdef CONFIG_ACPI_APEI_GHES
> > >         /* Used for GHES mapping from assorted contexts */
> > > diff --git a/arch/x86/power/hibernate.c
> > > b/arch/x86/power/hibernate.c
> > > index 6f955eb1e163..473b6b5f6b7e 100644
> > > --- a/arch/x86/power/hibernate.c
> > > +++ b/arch/x86/power/hibernate.c
> > > @@ -147,6 +147,16 @@ int arch_hibernation_header_restore(void
> > > *addr)
> > >         return 0;
> > >  }
> > >
> > > +void copy_unmapped_page(void *dst, struct page *page)
> > > +{
> > > +       WARN_ON(!preempt_count());
> >
> > I don't think the above is needed.  The code using this function
> > cannot be preempted anyway AFAICS.
>
> The reason I thought it was useful was because this function is now
> defined in a header. Someone else might decide to use it. Does it seem
> more useful?

Well, it is exposed now, but only in order to allow the __weak
function to be overridden.  I don't think it is logically valid to use
it anywhere beyond its original call site.

To make that clear, I would call it something hibernation-specific,
like hibernate_copy_unmapped_page() and I would add a kerneldoc
comment to it to describe its intended use.

Furthermore, I'm not sure about the new code layout.

Personally, I would prefer hibernate_map_page() and
hibernate_unmap_page() to be turned into __weak functions and possibly
overridden by the arch code, which would allow the amount of changes
to be reduced and do_copy_page() wouldn't need to be moved into the
header any more.

> >
> > > +
> > > +       set_fixmap(FIX_HIBERNATE, page_to_phys(page));
> > > +       __flush_tlb_all();
> >
> > So do TLBs need to be flushed before copying every single page?
> > Basically, they are all copied in one loop.
>
> It is only one fixmap entry so it needs to be flushed after changing
> the PTE to point to a different page. But this is only for the case of
> unmapped pages, the more common mapped pages are copied from the direct
> map like usual.

OK

> >
> > > +       hib_copy_page(dst, (void *)fix_to_virt(FIX_HIBERNATE));
> > > +       clear_fixmap(FIX_HIBERNATE);
> > > +}
> > > +
> > >  int relocate_restore_code(void)
> > >  {
> > >         pgd_t *pgd;
> > > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > > index cfe19a028918..0b19b910526e 100644
> > > --- a/include/linux/suspend.h
> > > +++ b/include/linux/suspend.h
> > > @@ -447,6 +447,19 @@ extern bool hibernation_available(void);
> > >  asmlinkage int swsusp_save(void);
> > >  extern struct pbe *restore_pblist;
> > >  int pfn_is_nosave(unsigned long pfn);
> > > +void copy_unmapped_page(void *dst, struct page *page);
> > > +
> > > +/*
> > > + * This is needed, because copy_page and memcpy are not usable for
> > > copying
> > > + * task structs.
> > > + */
> > > +static inline void hib_copy_page(long *dst, long *src)
> > > +{
> > > +       int n;
> > > +
> > > +       for (n = PAGE_SIZE / sizeof(long); n; n--)
> > > +               *dst++ = *src++;
> > > +}
> > >
> > >  int hibernate_quiet_exec(int (*func)(void *data), void *data);
> > >  #else /* CONFIG_HIBERNATION */
> > > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > > index cd8b7b35f1e8..344c071f29d3 100644
> > > --- a/kernel/power/snapshot.c
> > > +++ b/kernel/power/snapshot.c
> > > @@ -1369,16 +1369,11 @@ static unsigned int count_data_pages(void)
> > >         return n;
> > >  }
> > >
> > > -/*
> > > - * This is needed, because copy_page and memcpy are not usable for
> > > copying
> > > - * task structs.
> > > - */
> > > -static inline void do_copy_page(long *dst, long *src)
> > > +void __weak copy_unmapped_page(void *dst, struct page *page)
> > >  {
> > > -       int n;
> > > -
> > > -       for (n = PAGE_SIZE / sizeof(long); n; n--)
> > > -               *dst++ = *src++;
> > > +       hibernate_map_page(page);
> > > +       hib_copy_page(dst, page_address(page));
> > > +       hibernate_unmap_page(page);
> > >  }
> > >
> > >  /**
> > > @@ -1392,11 +1387,9 @@ static inline void do_copy_page(long *dst,
> > > long *src)
> > >  static void safe_copy_page(void *dst, struct page *s_page)
> > >  {
> > >         if (kernel_page_present(s_page)) {
> > > -               do_copy_page(dst, page_address(s_page));
> > > +               hib_copy_page(dst, page_address(s_page));
> > >         } else {
> > > -               hibernate_map_page(s_page);
> > > -               do_copy_page(dst, page_address(s_page));
> > > -               hibernate_unmap_page(s_page);
> > > +               copy_unmapped_page(dst, s_page);
> > >         }
> > >  }
> > >
> > > @@ -1417,7 +1410,7 @@ static void copy_data_page(unsigned long
> > > dst_pfn, unsigned long src_pfn)
> > >         if (PageHighMem(s_page)) {
> > >                 src = kmap_atomic(s_page);
> > >                 dst = kmap_atomic(d_page);
> > > -               do_copy_page(dst, src);
> > > +               hib_copy_page(dst, src);
> > >                 kunmap_atomic(dst);
> > >                 kunmap_atomic(src);
> > >         } else {
> > > --
> > > 2.17.1
> > >
