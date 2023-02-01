Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FDB6865DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjBAMXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjBAMXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:23:45 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6641B4860D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:23:31 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a184so12480007pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 04:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JEkiUTacxMxuQViA2zFVDrCybVhWswU79PAFJJV/w9g=;
        b=JFlcwhut2YxmzOnINTmfWPgykYOoLnNzxL7qoNOpca+oiLZu8x5995wnOMAxVO+Ros
         XgubNWP6I84WorhX/iUfTp0ZDNOaxcuFDzmMCuFrPtBkuuwag9xqEI4RqxxPsooCQ0FQ
         8ItpDZyF9Zv4u2C+Vf2/v7tnRbxkE0PXjCp8YbR7borkIjcoVXpNWrcJDiJDLyjgnV/h
         u+tsoufLduN4tVPPYx1Pb4csiCV27ywPKrB0bIF6biJifnwwzaBm16XfH7DpmZgLL3tX
         3uDLvtanpupnMFpJac9gBh/h5/dmuW1WAMrZpBHcqEuzjxkX8xL9mH5HpZhHq2X6gAz4
         07MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEkiUTacxMxuQViA2zFVDrCybVhWswU79PAFJJV/w9g=;
        b=dCtaZze46rpSvILqQkN56RtER9KKpzXCQ1PLPbUKgKmq9ZfdkdMV4nWv98KyAELD/l
         qd0EKfNR2viaw+joxqnPm3pn6H7B6x390w0nyhtc+OV70fYHb3vYCC7f75NGpkRktEAA
         fgVajYP0Vi3511NnmnoXjFDCjJzMXVdqCp+s7Ue2uKWqRaUiAq149Ox9btWQE2IF+Ec8
         P/SvDFFhl6xtUPK3kq0RgvGHk1UiBYILs3JGOC3EntwDDxqZJrtiyi4HTb5dh0sSu4wn
         Ri/bH6QoZnZIIaLA86/8HQGN8DmZOuPhu+Iacd4ISa1/VAt32ppN4GbXTktnjDjep6+/
         sWPQ==
X-Gm-Message-State: AO0yUKU9idFMTvuTGdduWkoBM4yQs4qdKNTQLShsysqU9Zh3zAnpMqu0
        PZh+pbJr3tELHYlCfKr82Ik=
X-Google-Smtp-Source: AK7set+GpUrYJx7Y0L584QZ8mHnSLMQmzHWvHob6Mlx6VGj4q3DTD2lRBF5v76Gk3l8+0GlLwkWQow==
X-Received: by 2002:a05:6a00:1392:b0:593:91e4:99e2 with SMTP id t18-20020a056a00139200b0059391e499e2mr2628027pfg.34.1675254210775;
        Wed, 01 Feb 2023 04:23:30 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id y40-20020a056a001ca800b0058dbb5c5038sm243351pfw.182.2023.02.01.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 04:23:29 -0800 (PST)
Date:   Wed, 1 Feb 2023 21:23:16 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v4 4/7] mm: replace vma->vm_flags direct modifications
 with modifier calls
Message-ID: <Y9pZtC+IEjVQO6fh@hyeyoo>
References: <20230126193752.297968-1-surenb@google.com>
 <20230126193752.297968-5-surenb@google.com>
 <Y9jSFFeHYZE1/yFg@hyeyoo>
 <CAJuCfpEzaVkgQt=C-33jAh1vLVJAjoyM8X5AD9CzyDUJnPDCkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEzaVkgQt=C-33jAh1vLVJAjoyM8X5AD9CzyDUJnPDCkw@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:54:22AM -0800, Suren Baghdasaryan wrote:
> On Tue, Jan 31, 2023 at 12:32 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > On Thu, Jan 26, 2023 at 11:37:49AM -0800, Suren Baghdasaryan wrote:
> > > Replace direct modifications to vma->vm_flags with calls to modifier
> > > functions to be able to track flag changes and to keep vma locking
> > > correctness.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> > > Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  arch/arm/kernel/process.c                          |  2 +-
> > >  120 files changed, 188 insertions(+), 199 deletions(-)
> > >
> >
> > Hello Suren,
> 
> Hi Hyeonggon,
> 
> >
> > [...]
> >
> > Whoa, it's so long.
> > Mostly looks fine but two things I'm not sure about:
> >
> > > diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
> > > index 9dda47b3fd70..7be4e6c9f120 100644
> > > --- a/drivers/misc/open-dice.c
> > > +++ b/drivers/misc/open-dice.c
> > > @@ -95,12 +95,12 @@ static int open_dice_mmap(struct file *filp, struct vm_area_struct *vma)
> > >               if (vma->vm_flags & VM_WRITE)
> > >                       return -EPERM;
> > >               /* Ensure userspace cannot acquire VM_WRITE later. */
> > > -             vma->vm_flags &= ~VM_MAYWRITE;
> > > +             vm_flags_clear(vma, VM_MAYSHARE);
> > >       }
> >
> > I think it should be:
> >         s/VM_MAYSHARE/VM_MAYWRITE/
> 
> Good eye! Yes, this is definitely a bug. Will post a next version with this fix.
> 
> >
> > > diff --git a/mm/mlock.c b/mm/mlock.c
> > > index 5c4fff93cd6b..ed49459e343e 100644
> > > --- a/mm/mlock.c
> > > +++ b/mm/mlock.c
> > > @@ -380,7 +380,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
> > >        */
> > >       if (newflags & VM_LOCKED)
> > >               newflags |= VM_IO;
> > > -     WRITE_ONCE(vma->vm_flags, newflags);
> > > +     vm_flags_reset(vma, newflags);
> > >
> > >       lru_add_drain();
> > >       walk_page_range(vma->vm_mm, start, end, &mlock_walk_ops, NULL);
> > > @@ -388,7 +388,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
> > >
> > >       if (newflags & VM_IO) {
> > >               newflags &= ~VM_IO;
> > > -             WRITE_ONCE(vma->vm_flags, newflags);
> > > +             vm_flags_reset(vma, newflags);
> > >       }
> > >  }
> >
> > wondering the if the comment above is still true?
> >
> >         /*
> >          * There is a slight chance that concurrent page migration,
> >          * or page reclaim finding a page of this now-VM_LOCKED vma,
> >          * will call mlock_vma_folio() and raise page's mlock_count:
> >          * double counting, leaving the page unevictable indefinitely.
> >          * Communicate this danger to mlock_vma_folio() with VM_IO,
> >          * which is a VM_SPECIAL flag not allowed on VM_LOCKED vmas.
> >          * mmap_lock is held in write mode here, so this weird
> >          * combination should not be visible to other mmap_lock users;
> >          * but WRITE_ONCE so rmap walkers must see VM_IO if VM_LOCKED.
> >          */
> >
> > does ACCESS_PRIVATE() still guarentee that compiler cannot mysteriously
> > optimize writes like WRITE_ONCE()?
> 
> I don't see ACCESS_PRIVATE() providing the same guarantees as
> WRITE_ONCE(), therefore I think this also needs to be changed. I'll
> need to introduce something like vm_flags_reset_once() and use it
> here. vm_flags_reset_once() would do WRITE_ONCE() and otherwise would
> be identical to vm_flags_reset().
>
> I'll post a new version with the fixes later today.
>
> Thanks for the review!
> Suren.

Thanks for quick reply!

Andrew's fix and the new patch looks good to me.
with these two things addressed:

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>


Regards,
Hyeonggon
