Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B230D705444
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjEPQoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjEPQo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2443B10D8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684255401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKcrkflnER1P+rdmxeBIz0lO2UyMu/OownH5oaz4C1c=;
        b=fiQM9DvX2llGhPWPjSSFsvJaDpQS61Zno776c/d3jbH/QITzVc0PgSamJL4xImE88Bu3kt
        F65lsbTaP1VcTW4rIib9vwhxZb/A5k8L6yThz3L0o1rZW4O/IJ5VrS0VwE6fSL0b3dj0af
        YZ5OMqLk/f24ugZnOLAqogb2kr6y/uY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-gi4cxhiWODeVxBFYvNjRuQ-1; Tue, 16 May 2023 12:43:19 -0400
X-MC-Unique: gi4cxhiWODeVxBFYvNjRuQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-61acaa32164so26354936d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255399; x=1686847399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKcrkflnER1P+rdmxeBIz0lO2UyMu/OownH5oaz4C1c=;
        b=k2QYw5uz93mr5f4r2VMqWhv2gUDJfrbH+GR/pj7D8r9PmdriBwimliRqYrE6mgsHmU
         xidde+PsY5dWzM5jncLfAT71PgGAcvWREMH2o03mcTWU+RjylytI72+hv6ss0zqstqtZ
         757kfZj8GzClzyaijHJ0eVREjOjrC2WusRPhZcoAN4WWqiBx6fePKOrNQww4IktKX6Rm
         /FthWsCsbM5JvYG3YlSp+KEuW5Ix0jK85onf52KqDQlIfvi7+/iKiJqLo6+37GUFqjhj
         P8+mw6+cvVreJeaLIzdni5d0TpSdM7j5VIR27om9X15M1fHYCG2uImpLbj2uIL1ndDvS
         ZdgQ==
X-Gm-Message-State: AC+VfDxFTsLwFIsPN43iSNkhl+v4M0HiY+RjYBVEtGYOQCHh9RxbB990
        D5jGvjaa2N4YdNMvKH74Eey3r469DQn4frIGKpe/lquOYrxwg3M6VuaAcXKLBLuzA1fdq9YUHxP
        llkAMC9UOJmatGaqXIWwNgQx3
X-Received: by 2002:a05:6214:2526:b0:623:7348:4f07 with SMTP id gg6-20020a056214252600b0062373484f07mr22159qvb.1.1684255398919;
        Tue, 16 May 2023 09:43:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CEH7NUBu06Z7A3BFwaLQbq0W2FO20l0Zq86mlEYEpXqsP5w/l/Wd1DWkhStZV5mEZ3C35bw==
X-Received: by 2002:a05:6214:2526:b0:623:7348:4f07 with SMTP id gg6-20020a056214252600b0062373484f07mr22119qvb.1.1684255398483;
        Tue, 16 May 2023 09:43:18 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id z7-20020a0cf247000000b005ef4ad380cesm5747651qvl.10.2023.05.16.09.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:43:17 -0700 (PDT)
Date:   Tue, 16 May 2023 12:43:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: RFC for new feature to move pages from one vma to another
 without split
Message-ID: <ZGOyo11nSQwdTri6@x1n>
References: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
 <ZC8BgFSFC3cDcAcS@x1n>
 <CA+EESO4xfBsywi3TmMd+tu9shaSYypy9n9a5s+dAg08csh1r3Q@mail.gmail.com>
 <ZDV5RzSXairuyqRj@x1n>
 <CA+EESO6uGQRtcf=OEYEAuVFvo6WwfyU9qCB1jfKGuxVUkKeWrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EESO6uGQRtcf=OEYEAuVFvo6WwfyU9qCB1jfKGuxVUkKeWrw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 03:56:50PM -0700, Lokesh Gidra wrote:
> On Tue, Apr 11, 2023 at 8:14 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Apr 10, 2023 at 12:41:31AM -0700, Lokesh Gidra wrote:
> > > On Thu, Apr 6, 2023 at 10:29 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > Hi, Lokesh,
> > > >
> > > > Sorry for a late reply.  Copy Blake Caldwell and Mike too.
> > >
> > > Thanks for the reply. It's extremely helpful.
> > > >
> > > > On Thu, Feb 16, 2023 at 02:27:11PM -0800, Lokesh Gidra wrote:
> > > > > I) SUMMARY:
> > > > > Requesting comments on a new feature which remaps pages from one
> > > > > private anonymous mapping to another, without altering the vmas
> > > > > involved. Two alternatives exist but both have drawbacks:
> > > > > 1. userfaultfd ioctls allocate new pages, copy data and free the old
> > > > > ones even when updates could be done in-place;
> > > > > 2. mremap results in vma splitting in most of the cases due to 'pgoff' mismatch.
> > > >
> > > > Personally it was always a mistery to me on how vm_pgoff works with
> > > > anonymous vmas and why it needs to be setup with vm_start >> PAGE_SHIFT.
> > > >
> > > > Just now I tried to apply below oneliner change:
> > > >
> > > > @@ -1369,7 +1369,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> > > >                         /*
> > > >                          * Set pgoff according to addr for anon_vma.
> > > >                          */
> > > > -                       pgoff = addr >> PAGE_SHIFT;
> > > > +                       pgoff = 0;
> > > >                         break;
> > > >                 default:
> > > >                         return -EINVAL;
> > > >
> > > > The kernel even boots without a major problem so far..
> > > >
> > > > I had a feeling that I miss something else here, it'll be great if anyone
> > > > knows.
> > > >
> > > > Anyway, I agree mremap() is definitely not the best way to do page level
> > > > operations like this, no matter whether vm_pgoff can match or not.
> > > >
> > > > >
> > > > > Proposing a new mremap flag or userfaultfd ioctl which enables
> > > > > remapping pages without these drawbacks. Such a feature, as described
> > > > > below, would be very helpful in efficient implementation of concurrent
> > > > > compaction algorithms.
> > > >
> > > > After I read the proposal, I had a feeling that you're not aware that we
> > > > have similar proposals adding UFFDIO_REMAP.
> > >
> > > Yes, I wasn't aware of this. Thanks a lot for sharing the details.
> > > >
> > > > I think it started with Andrea's initial proposal on the whole uffd:
> > > >
> > > > https://lore.kernel.org/linux-mm/1425575884-2574-1-git-send-email-aarcange@redhat.com/
> > > >
> > > > Then for some reason it's not merged in initial version, but at least it's
> > > > been proposed again here (even though it seems the goal is slightly
> > > > different; that may want to move page out instead of moving in):
> > > >
> > > > https://lore.kernel.org/linux-mm/cover.1547251023.git.blake.caldwell@colorado.edu/
> > >
> > > Yeah, this seems to be the opposite of what I'm looking for. IIUC,
> > > page out REMAP can't
> > > satisfy any MISSING userfault. In fact, it enables MISSING faults in
> > > future. Maybe a flag
> > > can be added to uffdio_remap struct to accommodate this case, if it is
> > > still being pursued.
> >
> > Yes, I don't think that's a major problem if the use cases share mostly the
> > same fundation.
> >
> > > >
> > > > Also worth checking with the latest commit that Andrea maintains himself (I
> > > > doubt whether there's major changes, but still just to make it complete):
> > > >
> > > > https://gitlab.com/aarcange/aa/-/commit/2aec7aea56b10438a3881a20a411aa4b1fc19e92
> > > >
> > > > So far I think that's what you're looking for. I'm not sure whether the
> > > > limitations will be a problem, though, at least mentioned in the old
> > > > proposals of UFFDIO_REMAP.  For example, it required not only anonymous but
> > > > also mapcount==1 on all src pages.  But maybe that's not a problem here
> > > > too.
> > >
> > > Yes, this is exactly what I am looking for. The mapcount==1 is not a
> > > problem either. Any idea why the patch isn't merged?
> >
> > The initial verion of discussion mentioned some of the reason of lacking
> > use cases:
> >
> > https://lore.kernel.org/linux-mm/20150305185112.GL4280@redhat.com/
> >
> Thanks for sharing the link. I assume the 20% performance gap in
> UFFDIO_COPY vs UFFDIO_REMAP is
> just for ioctl calls. But (at least) in case of compaction (our use
> case), COPY increases other overheads.

Per my read:

        Yes, we already measured the UFFDIO_COPY is faster than
        UFFDIO_REMAP, the userfault latency decreases -20%.

It was the fault latency so it can be more than the pure ioctl
measurements.  However I think the point is valid that for this specific
use case it's not purely adding memory but also including removals.  It
seems indeed a proper use case to me at least for what I can see now.

> It leads to more page allocations, mem-copies, and madvises than
> required. OTOH, with REMAP:
> 
> 1) Page allocations can be mostly avoided by recycling the pages as
> they are freed during compaction
> 2) Memcpy (for compacting objects) into the page (from (1)) is needed
> only once (as compared to COPY wherein it does another memcpy).
> Furthermore, as described in the RFC, sometimes even 1 memcpy isn't
> required (with REMAP)
> 3) As pages are being recycled in userspace, there would be far fewer
> pages to madvise at the end of compaction.
> 
> Also, as described in the RFC, REMAP allows moving pages within heap
> for page-level coarse-grained compaction, which helps by avoiding
> swapping in the page. This wouldn't be possible with COPY.

Please feel free to pick up the work if you think that's the right one for
you.  IMHO it'll be very helpful if you can justify how REMAP could improve
the use case in the cover letter with some real numbers.

Thanks,

-- 
Peter Xu

