Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE66865DD59
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjADUEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjADUEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2218E2E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 12:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672862630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCJoB+mKqkSz09nDtW8cNX32+uHYvkoQDhWihAl/a04=;
        b=FDQI0syLd9/I+UxactmcbeIHysifDNVePIaum+Ab4EVd6j3v/R6RlQA5RHr6HGtu78ba+l
        BqCEjym2FHpTZyXv4MKn3uv7ZCLzdGBvN7xVqSp1WbcVImFmWxXZOUWAshSvy3j4qyEizS
        9VqM2lJ/w61aPHkdwCuGcMqWYFP1hpg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-w41fms_MMwCRGvh2VbsaRA-1; Wed, 04 Jan 2023 15:03:49 -0500
X-MC-Unique: w41fms_MMwCRGvh2VbsaRA-1
Received: by mail-qt1-f197.google.com with SMTP id k4-20020ac84784000000b003a96744cee6so12314929qtq.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 12:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCJoB+mKqkSz09nDtW8cNX32+uHYvkoQDhWihAl/a04=;
        b=kCpMTgAPAJaJNGuPhyaIUyO6EYEjSNd7EKJu8zaxfMAhjgYWiFN4o5PSQwrKVaTx/u
         4MHfyhsZKhdlKtFdsQB2KI+nLhjb+UmDo4Vn9Zak8EwHAZWoRvHDAl8AyBC6n9M4KTcg
         qjqldzPnGlRcuOAni1rWBRUlDVLxF28j5/r2Gnjql8LANMGMuPBPBkACJf+Q8p6fyxEd
         lqDLzLpmscJjVR3yD7XAK7DVOFnOxZ8FWtgBNNAC+A3GSeBOv+cxTqRtXY8KPuCky6f0
         hrAigG5yXDTCzggxMFiXLDQxSJnce8xkJROjvf8a9et3Hyx7AQhp0xmwfvGHggeZcq+6
         Zhtw==
X-Gm-Message-State: AFqh2kqBbif2Nf5lS1g8FUkoMAPu91juHdZRPYyZqzYKPVlXFd3F8yWa
        KGjeglEte/MnQ+Fif2yHYs888MzrXrDXrjkjk/n75vsbhDO/wpi1RH0UwDG5e/hCrwn4fF+6db0
        8SISqqgdSgruKLaTY4PNe4wvb
X-Received: by 2002:ac8:4808:0:b0:3a8:16c0:d9c9 with SMTP id g8-20020ac84808000000b003a816c0d9c9mr68523839qtq.7.1672862628996;
        Wed, 04 Jan 2023 12:03:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsOBvwpHMgJ01kJRNO6mhggyjm6TVgBXS7eNzC/N5GqdjhLWSKBpavEwqMsvePbQso0RnMI/g==
X-Received: by 2002:ac8:4808:0:b0:3a8:16c0:d9c9 with SMTP id g8-20020ac84808000000b003a816c0d9c9mr68523815qtq.7.1672862628616;
        Wed, 04 Jan 2023 12:03:48 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-39-70-52-228-144.dsl.bell.ca. [70.52.228.144])
        by smtp.gmail.com with ESMTPSA id r14-20020ac87eee000000b003a6a92a202esm20665683qtc.83.2023.01.04.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 12:03:48 -0800 (PST)
Date:   Wed, 4 Jan 2023 15:03:47 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hugetlb: unshare some PMDs when splitting VMAs
Message-ID: <Y7Xbo0tUO26khHCA@x1n>
References: <20230101230042.244286-1-jthoughton@google.com>
 <Y7SA839SDcpf+Ll0@monkey>
 <CADrL8HVeOkj0QH5VZZbRzybNE8CG-tEGFshnA+bG9nMgcWtBSg@mail.gmail.com>
 <Y7Sq+Rs9cpSaHZSk@monkey>
 <CADrL8HV73m0nVJOK3uv4sbyGKOVZhVxSv2+i4pUV7tozu6vW5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HV73m0nVJOK3uv4sbyGKOVZhVxSv2+i4pUV7tozu6vW5Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 07:10:11PM +0000, James Houghton wrote:
> > > I'll see if I can confirm that this is indeed possible and send a
> > > repro if it is.
> >
> > I think your analysis above is correct.  The key being the failure to unshare
> > in the non-PUD_SIZE vma after the split.
> 
> I do indeed hit the WARN_ON_ONCE (repro attached), and the MADV wasn't
> even needed (the UFFDIO_REGISTER does the VMA split before "unsharing
> all PMDs"). With the fix, we avoid the WARN_ON_ONCE, but the behavior
> is still incorrect: I expect the address range to be write-protected,
> but it isn't.
> 
> The reason why is that hugetlb_change_protection uses huge_pte_offset,
> even if it's being called for a UFFDIO_WRITEPROTECT with
> UFFDIO_WRITEPROTECT_MODE_WP. In that particular case, I'm pretty sure
> we should be using huge_pte_alloc, but even so, it's not trivial to
> get an allocation failure back up to userspace. The non-hugetlb
> implementation of UFFDIO_WRITEPROTECT seems to also have this problem.
> 
> Peter, what do you think?

Indeed.  Thanks for spotting that, James.

Non-hugetlb should be fine with having empty pgtable entries. Anon doesn't
need to care about no-pgtable-populated ranges so far. Shmem does it with a
few change_prepare() calls to populate the entries so the markers can be
installed later on.

However I think the fault handling is still not well handled as you pointed
out even for shmem: that's the path I probably never triggered myself yet
before and the code stayed there since a very early version:

#define  change_pmd_prepare(vma, pmd, cp_flags)				\
	do {								\
		if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {	\
			if (WARN_ON_ONCE(pte_alloc(vma->vm_mm, pmd)))	\
				break;					\
		}							\
	} while (0)

I think a better thing we can do here (instead of warning and stop the
UFFDIO_WRITEPROTECT at the current stage) is returning with -ENOMEM
properly so the user can know the error.  We'll need to touch the stacks up
to uffd_wp_range() as it's the only one that can trigger the -ENOMEM so
far, so as to not ignore retval from change_protection().

Meanwhile, I'd also wonder whether we should call pagefault_out_of_memory()
because it should be the same as when pgtable allocation failure happens in
page faults, we may want to OOM already.  I can take care of hugetlb part
too along the way.

Man page of UFFDIO_WRITEPROTECT may need a fixup too to introduce -ENOMEM.

I can quickly prepare some patches for this, and hopefully it doesn't need
to block the current fix on split.

Any thoughts?

> 
> >
> > To me, the fact it was somewhat difficult to come up with this scenario is an
> > argument what we should just unshare at split time as you propose.  Who
> > knows what other issues may exist.
> >
> > > 60dfaad65a ("mm/hugetlb: allow uffd wr-protect none ptes") is the
> > > commit that introduced the WARN_ON_ONCE; perhaps it's a good choice
> > > for a Fixes: tag (if above is indeed true).
> >
> > If the key issue in your above scenario is indeed the failure of
> > hugetlb_unshare_all_pmds in the non-PUD_SIZE vma, then perhaps we tag?
> >
> > 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all pmds for hugetlbfs when
> > register wp")
> 
> SGTM. Thanks Mike.

Looks good here too.

Thanks,

-- 
Peter Xu

