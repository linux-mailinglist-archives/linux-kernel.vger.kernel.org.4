Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770BD60B8E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiJXT51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiJXT4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226687969A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666635546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8Yvakt3MK7rD0y3RReVeclZNu+K0N6huBCXY+hLsjg=;
        b=fK1idjXupkoHfdM/hucvoFt8+SE0VrW0vbweirwFNHHtXt4T+S2BaDjIClnAcYPDrMQI19
        TQ/6r3GNUihTTp4hhVq9N3JOwAnDYsElgW+C0xaRdrPeWGZgr531eUPMflYPa5BLBsMYNW
        2kFUbxE+x10ckb5Fr1sf1yz8l3J2tqg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-CGEqN4wVPsCye0RomuW2jg-1; Mon, 24 Oct 2022 14:19:04 -0400
X-MC-Unique: CGEqN4wVPsCye0RomuW2jg-1
Received: by mail-qt1-f198.google.com with SMTP id d12-20020a05622a100c00b0039ce6373d2cso7516836qte.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8Yvakt3MK7rD0y3RReVeclZNu+K0N6huBCXY+hLsjg=;
        b=IZZpG/WUfKUe9B4+8qt7kvP1ouIAnzC94THNTaIGKxq7exMfXlwBQleV61bomSmN3R
         W7bd3TkBkIV4Y8exRHOXG3/Jk2osTAnqJ1JiDQ+Yu0MdhLC2JuxbyHAhTkNzuM+63BOi
         nifBl+IcXyggbzfFbfIDKfLEtstgANMUUk0uY7+jEiZ9Mw2WzGiBUvgsDl6lLOixEsvC
         V9e2CdkAhbDOCJrlHEvqDznhLwA7ma3n95KtAEUsOvs8c455jNUvnvc21ZpwB1mwETbv
         sD24aJBebk9cF08D+UEJsdLHAJt2e2AZARSxYcGLdHZWwb6PVc4Uv30MgU+5BzJp5ReJ
         eSgQ==
X-Gm-Message-State: ACrzQf0Cj4ue2DVvrs/tlTol8CN/1xCsltPVi7lpZNHueXAt+WXbIRWe
        pbE42ilD7HEoxE1aNKAKeMRwmOhj3PS5lWWpvxFPCO8TOli9MdZpDdxVKfTulKm6IhibvL9S3zy
        kLyteekEQKgJLlWb5ZwzZPzyb
X-Received: by 2002:ac8:59c2:0:b0:39c:e3b4:1265 with SMTP id f2-20020ac859c2000000b0039ce3b41265mr27651376qtf.55.1666635543554;
        Mon, 24 Oct 2022 11:19:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5sUMaA/yGMGt9tvsXee0XTNi9PnrHPUDHcbhB8nWX8VOHAmdnt88LQsGtRV3/c6Bhui57suA==
X-Received: by 2002:ac8:59c2:0:b0:39c:e3b4:1265 with SMTP id f2-20020ac859c2000000b0039ce3b41265mr27651344qtf.55.1666635543265;
        Mon, 24 Oct 2022 11:19:03 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id ff12-20020a05622a4d8c00b0039cb5c9dbacsm348931qtb.22.2022.10.24.11.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:19:02 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:19:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        kernel test robot <yujie.liu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for rc] mm/shmem: Ensure proper fallback if page faults
Message-ID: <Y1bXFchNMMT3M0cJ@x1n>
References: <20221024043305.1491403-1-ira.weiny@intel.com>
 <Y1bDRpmPdYdilJzp@iweiny-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1bDRpmPdYdilJzp@iweiny-mobl>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:54:30AM -0700, Ira Weiny wrote:
> On Sun, Oct 23, 2022 at 09:33:05PM -0700, Ira wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The kernel test robot flagged a recursive lock as a result of a
> > conversion from kmap_atomic() to kmap_local_folio()[Link]
> > 
> > The cause was due to the code depending on the kmap_atomic() side effect
> > of disabling page faults.  In that case the code expects the fault to
> > fail and take the fallback case.
> > 
> > git archaeology implied that the recursion may not be an actual bug.[1]
> > However, the mmap_lock needed in the fault may be the one held.[2]
> > 
> > Add an explicit pagefault_disable() and a big comment to explain this
> > for future souls looking at this code.
> > 
> > [1] https://lore.kernel.org/all/Y1MymJ%2FINb45AdaY@iweiny-desk3/
> > [2] https://lore.kernel.org/all/Y1M2p9OtBGnKwGUE@x1n/
> > 
> > Fixes: 7a7256d5f512 ("shmem: convert shmem_mfill_atomic_pte() to use a folio")
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reported-by: kernel test robot <yujie.liu@intel.com>
> > Link: https://lore.kernel.org/r/202210211215.9dc6efb5-yujie.liu@intel.com
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Thanks to Matt and Andrew for initial diagnosis.
> > Thanks to Randy for pointing out C code needs ';'  :-D
> > Thanks to Andrew for suggesting an elaborate comment
> > Thanks to Peter for pointing out that the mm's may be the same.
> > ---
> >  mm/shmem.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 8280a5cb48df..c1bca31cd485 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2424,9 +2424,16 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
> >  
> >  		if (!zeropage) {	/* COPY */
> >  			page_kaddr = kmap_local_folio(folio, 0);
> > +			/*
> > +			 * The mmap_lock is held here.  Disable page faults to
> > +			 * prevent deadlock should copy_from_user() fault.  The
> > +			 * copy will be retried outside the mmap_lock.
> > +			 */
> 
> Offline Dave Hansen and I were discussing this and he was concerned that this
> comment implies that a deadlock would always occur rather than might occur.

Agreed, "prevent deadlock" might be too strong in this context.

> 
> I was not clear on this as I was thinking the read mmap_lock was non-recursive.
> 
> So I think we have 3 cases only 1 of which will actually deadlock and is, as
> Dave puts it, currently theoretical.
> 
> 	1) Different mm's are in play (no issue)
> 	2) Readlock implementation is recursive and same mm is in play (no issue)
> 	3) Readlock implementation is _not_ recursive (issue)
> 
> In both 1 and 2 lockdep is incorrectly flagging the issue but 3 is a problem
> and I think this is what Andrea was thinking.
> 
> Is that the case?

IMHO it would be good enough to just mention lockdep (as it can definitely
trigger) or just quote similarly as Andrea's original comment somehow:

    If the rwsem starves writers it wasn't strictly a bug but lockdep
    doesn't like it and this avoids depending on lowlevel implementation
    details of the lock.

IIUC no deadlock could really trigger at that time or Andrea should have
written it in some other way.  It also has actually summarized the goal
that then we won't rely on rwsem impl but just make it always work.

Thanks,

> 
> If so the above comment is incorrectly worded and I should update it.
> 
> Ira
> 
> > +			pagefault_disable();
> >  			ret = copy_from_user(page_kaddr,
> >  					     (const void __user *)src_addr,
> >  					     PAGE_SIZE);
> > +			pagefault_enable();
> >  			kunmap_local(page_kaddr);
> >  
> >  			/* fallback to copy_from_user outside mmap_lock */
> > -- 
> > 2.37.2
> > 
> 

-- 
Peter Xu

