Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7771F6082CB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJVARx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJVARt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:17:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96402B02DD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666397867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=amHJWELNNBFQ5oGfku8rGjqSoo/TG8P6T1HoY4z+rSA=;
        b=ShXwyvRFgM20zqZxey5KxO3J3NJwc/IG2ppXRMJCwK0Ffks2xU9Fl0FxROo4UOb4o0arOg
        RQAe1WCy9O5+iq8iDN41WLkUnGHllV6KWhHw4/MyzUqrn+5bOwi857IvmFAh6QfWtNUObM
        ZzIhawpFB00u3HS7iK/AjOO/RUqwGgQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-Te_rBxY_MxiW_LgZ7l5WRw-1; Fri, 21 Oct 2022 20:17:46 -0400
X-MC-Unique: Te_rBxY_MxiW_LgZ7l5WRw-1
Received: by mail-qk1-f200.google.com with SMTP id az32-20020a05620a172000b006ee8ae138a7so4705571qkb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amHJWELNNBFQ5oGfku8rGjqSoo/TG8P6T1HoY4z+rSA=;
        b=odm28P5DB5gfyVQrrIS8f0PYFeqJUzPSXPO1y0mD1VdkqTP0CnHy+Zp+ewGK8ux7NI
         O066lo+0TB7GUZl4waQvPrzlq7KwrxMjGUYG6nMF2Le/NlOl7hUVycb9UC5UaWfif8KX
         59QFP7Hw40x145BHK8plHWFMryxcJoKy/hQyxOA9mHG0E2Vq60UUeEwOZFvo66SfGWKe
         F5+UE5JaQnWtmfg86/2JynL7bnsWOGJejpNyyirE5aA8nZL1NBnCW8yevfeBZqwSUitP
         vJ9m4apI/sVCe7d2MKUyw19smoqWd7+Od2g5yjUnRagsCinNlhhjkiwMG55mcB5FmLXK
         LXgg==
X-Gm-Message-State: ACrzQf2bwfbpkWPcaS9r5eWdjFkhLsob/+ifIkNDrFP0bvOLKa5bV8X6
        6ghS6IS5AvPAg8K1mLSHRUM0K3VZhQ3TrigsGBoRIe1gaZvtvjyXs6twSnqwCN9GNEmVjX6pYe9
        MZo2uQa+iHEr4J6+xH704lkNJ
X-Received: by 2002:a05:620a:2809:b0:6bc:5e0d:d7b1 with SMTP id f9-20020a05620a280900b006bc5e0dd7b1mr16107999qkp.545.1666397865900;
        Fri, 21 Oct 2022 17:17:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4LAqprsVjIuNi4CfZOqxzbSbnJyVRuhCWZ+JoKJ64ng9n/C/AMy8gQVHgM7ynf0up0xY/mQg==
X-Received: by 2002:a05:620a:2809:b0:6bc:5e0d:d7b1 with SMTP id f9-20020a05620a280900b006bc5e0dd7b1mr16107981qkp.545.1666397865638;
        Fri, 21 Oct 2022 17:17:45 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006eed75805a2sm10874152qkp.126.2022.10.21.17.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 17:17:44 -0700 (PDT)
Date:   Fri, 21 Oct 2022 20:17:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        kernel test robot <yujie.liu@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        lkp@lists.01.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [shmem] 7a7256d5f5: WARNING:possible_recursive_locking_detected
Message-ID: <Y1M2p9OtBGnKwGUE@x1n>
References: <202210211215.9dc6efb5-yujie.liu@intel.com>
 <Y1KZ/NF5bNG1wykf@casper.infradead.org>
 <20221021133041.5811e1fb291eb6aaf122a59c@linux-foundation.org>
 <Y1Mh2S7fUGQ/iKFR@iweiny-desk3>
 <Y1MymJ/INb45AdaY@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1MymJ/INb45AdaY@iweiny-desk3>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 05:00:24PM -0700, Ira Weiny wrote:
> On Fri, Oct 21, 2022 at 03:48:57PM -0700, Ira wrote:
> > On Fri, Oct 21, 2022 at 01:30:41PM -0700, Andrew Morton wrote:
> > > On Fri, 21 Oct 2022 14:09:16 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> > > 
> > > > On Fri, Oct 21, 2022 at 12:10:17PM +0800, kernel test robot wrote:
> > > > > FYI, we noticed WARNING:possible_recursive_locking_detected due to commit (built with gcc-11):
> > > > > 
> > > > > commit: 7a7256d5f512b6c17957df7f59cf5e281b3ddba3 ("shmem: convert shmem_mfill_atomic_pte() to use a folio")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > 
> > > > Ummm.  Looks to me like this now occurs because of this part of the
> > > > change:
> > > > 
> > > >                 if (!zeropage) {        /* COPY */
> > > > -                       page_kaddr = kmap_atomic(page);
> > > > +                       page_kaddr = kmap_local_folio(folio, 0);
> > > >                         ret = copy_from_user(page_kaddr,
> > > >                                              (const void __user *)src_addr,
> > > >                                              PAGE_SIZE);
> > > > -                       kunmap_atomic(page_kaddr);
> > > > +                       kunmap_local(page_kaddr);
> > > > 
> > > > Should I be using __copy_from_user_inatomic() here?
> > 
> > I would say not.  I'm curious why copy_from_user() was safe (at least did not
> > fail the checkers).  :-/
> > 
> > > 
> > > Caller __mcopy_atomic() is holding mmap_read_lock(dst_mm) and this
> > > copy_from_user() calls
> > > might_fault()->might_lock_read(current->mm->mmap_lock).
> > > 
> > > And I guess might_lock_read() gets upset because we're holding another
> > > mm's mmap_lock.  Which sounds OK to me, unless a concurrent
> > > mmap_write_lock() could jam things up.
> > > 
> > > But I cannot see why your patch would suddenly trigger this warning -
> > > kmap_local_folio() and kmap_atomic() are basically the same thing.
> > 
> > It is related to your patch but I think what you did made sense on the surface.
> > 
> > On the surface copy_from_user() should not require pagefaults to be disabled.
> > But that side affect of kmap_atomic() was being used here because it looks like
> > the code is designed to fallback if the fault was not allowed:[1]
> > 
> > mm/shmem.c
> > ...
> >                         page_kaddr = kmap_local_folio(folio, 0);
> >                         ret = copy_from_user(page_kaddr,
> >                                              (const void __user *)src_addr,
> >                                              PAGE_SIZE);
> >                         kunmap_local(page_kaddr);
> > 
> >                         /* fallback to copy_from_user outside mmap_lock */
> >                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >                         if (unlikely(ret)) {
> >                                 *pagep = &folio->page;
> >                                 ret = -ENOENT;
> >                                 /* don't free the page */
> >                                 goto out_unacct_blocks;
> >                         }
> > ...
> > 
> > So this is one of those rare places where the kmap_atomic() side effects were
> > being depended on...  :-(
> > 
> > [1] might_fault() does not actually mean the code completes the fault.
> > 
> > mm/memory.c
> > ...
> > void __might_fault(const char *file, int line)
> > {
> >         if (pagefault_disabled())
> >                 return;
> > ...
> > 
> > > 
> > > I see that __mcopy_atomic() is using plain old kmap(), perhaps to work
> > > around this?  But that's 2015 code and I'm not sure we had such
> > > detailed lock checking in those days.
> > 
> > No kmap() can't work around this.  That works because the lock is released just
> > above that.
> > 
> > mm/userfaultfd.c
> > ...
> >                         mmap_read_unlock(dst_mm);
> >                         BUG_ON(!page);
> > 
> >                         page_kaddr = kmap(page);
> >                         err = copy_from_user(page_kaddr,
> >                                              (const void __user *) src_addr,
> >                                              PAGE_SIZE);
> >                         kunmap(page);
> > ...
> > 
> > So I think the correct solution is below because we want to prevent the page
> > fault.
> 
> I was about to get this patch ready to send when I found this:
> 
> commit b6ebaedb4cb1a18220ae626c3a9e184ee39dd248
> Author: Andrea Arcangeli <aarcange@redhat.com>
> Date:   Fri Sep 4 15:47:08 2015 -0700
> 
>     userfaultfd: avoid mmap_sem read recursion in mcopy_atomic
> 
>     If the rwsem starves writers it wasn't strictly a bug but lockdep
>     doesn't like it and this avoids depending on lowlevel implementation  
>     details of the lock.
>     
>     [akpm@linux-foundation.org: delete weird BUILD_BUG_ON()]
>     Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
>     Acked-by: Pavel Emelyanov <xemul@parallels.com>
> ...
> 
> So I wonder if the true fix is something to lockdep?

I think lockdep used to complain because we can be taking the same mmap_sem
twice in this case (the 2nd one during the useraddr page fault).  So to
answer the other question - yeah the current->mm and dest_mm can definitely
be the same one in this context.

> 
> Regardless I'll send the below patch because it will restore things to a
> working order.
> 
> But I'm CC'ing Andrea for comments.

Open-code disabling of pagefault sounds okay to me.  pagefault_disable()
used to be covering the kmap procedure too as done in kmap_atomic(), but
frankly I don't know whether there's a real difference.

Yeah, let's see whether we can get a confirmation from Andrea.

Thanks,

-- 
Peter Xu

