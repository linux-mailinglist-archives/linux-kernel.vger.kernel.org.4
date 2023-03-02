Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7CA6A8BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCBWWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCBWWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED98B457C5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677795687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yEbCEWqVbNsPXldhkX+B6BlDOXfOqO0gMIhL1iJ/rOI=;
        b=ImLvidLZf6CErhDej7s2DbFrn6R8iqZ/4JjQqWIgx8GECG1UlIOipOPJ6I8jHyTkuITocC
        EDATa0iWfwBNzGEn062llpxityN5OcVYKDmVzE+6TwVdkKAynNhw/dbzf7Q5TW/q0QI5+y
        y3MrO3WDvWJ40OFo3fUJY7w8wKYI9LY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-PDHdC8srPdGprZ9C3eaJ8Q-1; Thu, 02 Mar 2023 17:21:26 -0500
X-MC-Unique: PDHdC8srPdGprZ9C3eaJ8Q-1
Received: by mail-qt1-f197.google.com with SMTP id b7-20020ac85407000000b003bfb9cff263so444610qtq.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677795686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEbCEWqVbNsPXldhkX+B6BlDOXfOqO0gMIhL1iJ/rOI=;
        b=nfwuhjq/XoH2Qu1GK1eFxjk6qhkIiCxeb8mkUQuyPjsosX2H6Rv4Giu5WbHaqumVJh
         RNhyyTSc6kOtcmWz+USd6ynerlUKRAnyrXEzVhhvZO0B/jX8TRLFbNEyBCVTOgLA6IaJ
         0b+g23QDsWqaWZWhUYQBoeYS3MeNyWgz/tKCDCOT06vXu8bYuoBk9yukBcLIkKzG1sE5
         58uqMYqpOS/a2rsEEJOphmPUovdjfGf/zqEDbBfWjGUeTUmfUxR7Zk7sorGp6HBrI9rI
         0tPwPmTdgz6B2c4FOngBBsXEMJ4yCIvr0X50tFVUZtAY1OZlKUTURi6tQujmRREeo43v
         nYsg==
X-Gm-Message-State: AO0yUKWxzjjMfJ7sdk/FEhTnRFs7dk24Gw7kgGUYcbfoyDMLLmtM2n6J
        PmCdeHoNwOp8QfoEjyjGzDMmrW4i7U7ST9CGkL5dK7vVvcVYosts0cwKsCud7pVK/omcBOCsGTe
        aokZE89rEfDJVK9plguCXdaWdtzHphA==
X-Received: by 2002:a0c:b45b:0:b0:539:aae2:8dc4 with SMTP id e27-20020a0cb45b000000b00539aae28dc4mr17153747qvf.4.1677795685597;
        Thu, 02 Mar 2023 14:21:25 -0800 (PST)
X-Google-Smtp-Source: AK7set/myZPO3o575xsu/DEZMYZFH8KZmiW3qhXoX3GTstgHvA8TYzx+QH0MjGi9kY+0Oc9Jev1kIg==
X-Received: by 2002:a0c:b45b:0:b0:539:aae2:8dc4 with SMTP id e27-20020a0cb45b000000b00539aae28dc4mr17153715qvf.4.1677795685201;
        Thu, 02 Mar 2023 14:21:25 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id y22-20020a05620a44d600b0074270440092sm528742qkp.51.2023.03.02.14.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:21:24 -0800 (PST)
Date:   Thu, 2 Mar 2023 17:21:23 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Message-ID: <ZAEhY5lrxziDqpv5@x1n>
References: <20230227230044.1596744-1-peterx@redhat.com>
 <Y/1Mh5uivFt+zWKM@x1n>
 <9aa69bfb-c726-ac2c-127a-b21fd35ab40b@collabora.com>
 <92f2fd13-59f2-468d-d989-9b998a098795@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92f2fd13-59f2-468d-d989-9b998a098795@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 06:38:20PM +0100, David Hildenbrand wrote:
> On 02.03.23 18:19, Muhammad Usama Anjum wrote:
> > On 2/28/23 5:36 AM, Peter Xu wrote:
> > > On Mon, Feb 27, 2023 at 06:00:44PM -0500, Peter Xu wrote:
> > > > This is a new feature that controls how uffd-wp handles none ptes.  When
> > > > it's set, the kernel will handle anonymous memory the same way as file
> > > > memory, by allowing the user to wr-protect unpopulated ptes.
> > > > 
> > > > File memories handles none ptes consistently by allowing wr-protecting of
> > > > none ptes because of the unawareness of page cache being exist or not.  For
> > > > anonymous it was not as persistent because we used to assume that we don't
> > > > need protections on none ptes or known zero pages.
> > > > 
> > > > One use case of such a feature bit was VM live snapshot, where if without
> > > > wr-protecting empty ptes the snapshot can contain random rubbish in the
> > > > holes of the anonymous memory, which can cause misbehave of the guest when
> > > > the guest OS assumes the pages should be all zeros.
> > > > 
> > > > QEMU worked it around by pre-populate the section with reads to fill in
> > > > zero page entries before starting the whole snapshot process [1].
> > > > 
> > > > Recently there's another need raised on using userfaultfd wr-protect for
> > > > detecting dirty pages (to replace soft-dirty in some cases) [2].  In that
> > > > case if without being able to wr-protect none ptes by default, the dirty
> > > > info can get lost, since we cannot treat every none pte to be dirty (the
> > > > current design is identify a page dirty based on uffd-wp bit being cleared).
> > > > 
> > > > In general, we want to be able to wr-protect empty ptes too even for
> > > > anonymous.
> > > > 
> > > > This patch implements UFFD_FEATURE_WP_UNPOPULATED so that it'll make
> > > > uffd-wp handling on none ptes being consistent no matter what the memory
> > > > type is underneath.  It doesn't have any impact on file memories so far
> > > > because we already have pte markers taking care of that.  So it only
> > > > affects anonymous.
> > > > 
> > > > The feature bit is by default off, so the old behavior will be maintained.
> > > > Sometimes it may be wanted because the wr-protect of none ptes will contain
> > > > overheads not only during UFFDIO_WRITEPROTECT (by applying pte markers to
> > > > anonymous), but also on creating the pgtables to store the pte markers. So
> > > > there's potentially less chance of using thp on the first fault for a none
> > > > pmd or larger than a pmd.
> > > > 
> > > > The major implementation part is teaching the whole kernel to understand
> > > > pte markers even for anonymously mapped ranges, meanwhile allowing the
> > > > UFFDIO_WRITEPROTECT ioctl to apply pte markers for anonymous too when the
> > > > new feature bit is set.
> > > > 
> > > > Note that even if the patch subject starts with mm/uffd, there're a few
> > > > small refactors to major mm path of handling anonymous page faults. But
> > > > they should be straightforward.
> > > > 
> > > > So far, add a very light smoke test within the userfaultfd kselftest
> > > > pagemap unit test to make sure anon pte markers work.
> > > > 
> > > > [1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
> > > > [1] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > > v1->v2:
> > > > - Use pte markers rather than populate zero pages when protect [David]
> > > > - Rename WP_ZEROPAGE to WP_UNPOPULATED [David]
> > > 
> > > Some very initial performance numbers (I only ran in a VM but it should be
> > > similar, unit is "us") below as requested.  The measurement is about time
> > > spent when wr-protecting 10G range of empty but mapped memory.  It's done
> > > in a VM, assuming we'll get similar results on bare metal.
> > > 
> > > Four test cases:
> > > 
> > >          - default UFFDIO_WP
> > >          - pre-read the memory, then UFFDIO_WP (what QEMU does right now)
> > >          - pre-fault using MADV_POPULATE_READ, then default UFFDIO_WP
> > >          - UFFDIO_WP with WP_UNPOPULATED
> > > 
> > > Results:
> > > 
> > >          Test DEFAULT: 2
> > >          Test PRE-READ: 3277099 (pre-fault 3253826)
> > >          Test MADVISE: 2250361 (pre-fault 2226310)
> > >          Test WP-UNPOPULATE: 20850
> > In your case:
> > Default < WP-UNPOPULATE < MADVISE < PRE-READ
> > 
> > 
> > In my testing on next-20230228 with this patch and my uffd async patch:
> > 
> > Test DEFAULT: 6
> > Test PRE-READ: 37157 (pre-fault 37006)
> > Test MADVISE: 4884 (pre-fault 4465)
> > Test WP-UNPOPULATE: 17794
> > 
> > DEFAULT < MADVISE < WP-UNPOPULATE < PRE-READ
> > 
> > On my setup, MADVISE is performing better than WP-UNPOPULATE consistently.
> > I'm not sure why I'm getting this discrepancy here. I've liked your results
> > to be honest where we perform better with WP-UNPOPULATE than MADVISE. What
> > can be done to get consistent benchmarks over your and my side?
> 
> Probably because the current approach from Peter uses uffd-wp markers, and
> these markers can currently only reside on the PTE level, not on the PMD
> level yet.
> 
> With MADVISE you get a huge zeropage and avoid dealing with PTEs.

Yes, probably.  But then when write happens it'll be done there when split,
so the overhead was delayed.

Meanwhile I'll retest again (probably tomorrow..) with bare metals with THP
on/off to double check.

Muhammad, do you think the current performance will work for you?

Especially I want to double check with you again on whether
XFS/EXT4/... will be needed for the tracking purpose so you can reply here
together.  We shouldn't merge anything that doesn't have at least one
existing good use case, and we may need to rethink if it's not.

For performance, one approach is probably making uffd-wp async separate
from other features, where we can revert the meaning of uffd-wp bit to
mimic what soft-dirty does (I think this will look closer to what David
mentioned in the other thread), by defining uffd-wp=1 as "written" and
uffd-wp=0 as clean.

IIUC that'll make it one bit and work as fast as soft-dirty, meanwhile all
uffd-wp marker things can hopefully still be maintained.  However I really
don't like it to violate a lot of things, e.g., when UFFDIO_WRITEPROTECT
another round we'll need to DROP uffd-wp if async, but APPLY uffd-wp if
sync...  So in general it'll need more thoughts and slower to do.

-- 
Peter Xu

