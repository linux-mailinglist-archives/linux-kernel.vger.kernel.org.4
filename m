Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3231699A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBPQa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBPQa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:30:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBAE4D60F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676564994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7w8XJVwT2Jpg09oHeOyemAk6ZbMpWoFBWRabPFi9F0Q=;
        b=S/em+J5VXBQBnMznYxMc0IZDeIjSAXjShNxGj/UdoQjTgU5L1wiubH6UZRlrVpCcX0SHj3
        Glt3cSK0ndsiz1E6IM6WyFmYZSuIK+yqK6Jahwf4R/D8Xv8znqT6RMLANmM+ixEb6t6oMh
        913CCIMWrzbescbg5SnaCDFUBOt64x8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-375-zPfJeLpWOnCRBCeaiA3CpQ-1; Thu, 16 Feb 2023 11:29:52 -0500
X-MC-Unique: zPfJeLpWOnCRBCeaiA3CpQ-1
Received: by mail-il1-f200.google.com with SMTP id z8-20020a92d6c8000000b0031570404cf1so1586655ilp.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w8XJVwT2Jpg09oHeOyemAk6ZbMpWoFBWRabPFi9F0Q=;
        b=n950oI8Ld5BO9cGruvwE1flknALdkvUU15QpSoy897CFrb/Jhb30dFpq6Fr976aoOF
         zo8scNeDT/CTCzmPItELHDXOAgbAWJmpCa5gMpjbPYl60gVCRI7tvoad9rIUyqCz0j0n
         5PGMdBP1xiSeHXISRhJYniESDrNuxmnqRylHwra13LrAB4o8HPn14D7SQwe8IaJ91kkW
         e0CsSpFktPCcotOdP0svHMFt4C73nN5q4KIuOtcftk6wAExAOGLsdrS9kNhWla4L6Sp0
         qqmyqtPobjim9Me4SxHcMWI2PnYRORdcg8CTfvEHWtMN4Nn8tyftYJezdxs3K3+mxZ2a
         biJw==
X-Gm-Message-State: AO0yUKWnJE0R7zCkML4eVRgV4l9d32jaRmrqPyY4eZtj8sXIzRoBfnFY
        FygqWsjwkNvXi+v7H7jRLVA73QNnFKOYkqCrRjFHcQQs7Ts6lyMSzKGh9VysK+odg4uJXFOTJyR
        BsSCtlD/9eMZPKIxmSlZjBRB+
X-Received: by 2002:a6b:b2d1:0:b0:744:5aff:2ea9 with SMTP id b200-20020a6bb2d1000000b007445aff2ea9mr1603674iof.2.1676564990106;
        Thu, 16 Feb 2023 08:29:50 -0800 (PST)
X-Google-Smtp-Source: AK7set8Szs3hqBzHf1zOy5zUODM2Q5BxszRTU4f/pZ3Di+F7xhSUVWuRPPknjxxIeWHqiWB7Spi0Bg==
X-Received: by 2002:a6b:b2d1:0:b0:744:5aff:2ea9 with SMTP id b200-20020a6bb2d1000000b007445aff2ea9mr1603656iof.2.1676564989832;
        Thu, 16 Feb 2023 08:29:49 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id w5-20020a6bd605000000b007407ea5d07csm597246ioa.51.2023.02.16.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 08:29:48 -0800 (PST)
Date:   Thu, 16 Feb 2023 11:29:47 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
Message-ID: <Y+5Z+88Z3T2TyxUI@x1n>
References: <20230215210257.224243-1-peterx@redhat.com>
 <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:47:23AM +0100, David Hildenbrand wrote:
> On 15.02.23 22:02, Peter Xu wrote:
> > This is a new feature that controls how uffd-wp handles zero pages (aka,
> > empty ptes), majorly for anonymous pages only.
> > 
> > Note, here we used "zeropage" as a replacement of "empty pte" just to avoid
> > introducing the pte idea into uapi, since "zero page" is more well known to
> > an user app developer.
> > 
> > File memories handles none ptes consistently by allowing wr-protecting of
> > none ptes because of the unawareness of page cache being exist or not.  For
> > anonymous it was not as persistent because we used to assume that we don't
> > need protections on none ptes or known zero pages.
> > 
> > But it's actually not true.
> > 
> > One use case was VM live snapshot, where if without wr-protecting empty
> > ptes the snapshot can contain random rubbish in the holes of the anonymous
> > memory, which can cause misbehave of the guest when the guest assumes the
> > pages should (and were) all zeros.
> > 
> > QEMU worked it around by pre-populate the section with reads to fill in
> > zero page entries before starting the whole snapshot process [1].
> > 
> > Recently there's another need that raised on using userfaultfd wr-protect
> > for detecting dirty pages (to replace soft-dirty) [2].  In that case if
> > without being able to wr-protect zero pages by default, the dirty info can
> > get lost as long as a zero page is written, even after the tracking was
> > started.
> > 
> > In general, we want to be able to wr-protect empty ptes too even for
> > anonymous.
> > 
> > This patch implements UFFD_FEATURE_WP_ZEROPAGE so that it'll make uffd-wp
> > handling on zeropage being consistent no matter what the memory type is
> > underneath.  It doesn't have any impact on file memories so far because we
> > already have pte markers taking care of that.  So it only affects
> > anonymous.
> > 
> > One way to implement this is to also install pte markers for anonymous
> > memories.  However here we can actually do better (than i.e. shmem) because
> > we know there's no page that is backing the pte, so the better solution is
> > to directly install a zeropage read-only pte, so that if there'll be a
> > upcoming read it'll not trigger a fault at all.  It will also reduce the
> > changeset to implement this feature too.
> > 
> 
> There are various reasons why I think a UFFD_FEATURE_WP_UNPOPULATED, using
> PTE markers, would be more benficial:
> 
> 1) It would be applicable to anon hugetlb

Anon hugetlb should already work with non ptes with the markers?

> 2) It would be applicable even when the zeropage is disallowed
>    (mm_forbids_zeropage())

Do you mean s390 can disable zeropage with mm_uses_skeys()?  So far uffd-wp
doesn't support s390 yet, I'm not sure whether we over worried on this
effect.

Or is there any other projects / ideas that potentially can enlarge forbid
zero pages to more contexts?

> 3) It would be possible to optimize even without the huge zeropage, by
>    using a PMD marker.

This patch doesn't need huge zeropage being exist.

> 4) It would be possible to optimize even on the PUD level using a PMD
>    marker.

I think 3+4 is in general an interesting idea on using pte markers on
higher than pte levels, but that needs more changes.

Firstly, keep using pte markers is somehow preallocating the pgtables, so a
side effect of it could be speeding up future faults because they'll all
split into pmd locks and read doesn't need to fault at all, only writes.

Imagine when you hit a page fault on a pmd marker, it means you'll need to
spread that "marker" information to child ptes and you must - it moves the
slow operation of WP into future page faults in some way.  In some cases
(I'd say, most cases..) that's not wanted.  The same to PUDs.

> 
> Especially when uffd-wp'ing large ranges that are possibly all unpopulated
> (thinking about the existing VM background snapshot use case either with
> untouched memory or with things like free page reporting), we might neither
> be reading or writing that memory any time soon.

Right, I think that's a trade-off. But I still think large portion of
totally unpopulated memory should be rare case rather than majority, or am
I wrong?  Not to mention that requires a more involved changeset to the
kernel.

So what I proposed here is the (AFAIU) simplest solution towards providing
such a feature in a complete form.  I think we have chance to implement it
in other ways like pte markers, but that's something we can work upon, and
so far I'm not sure how much benefit we can get out of it yet.

Thanks,

-- 
Peter Xu

