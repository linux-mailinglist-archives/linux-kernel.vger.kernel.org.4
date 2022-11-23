Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D30A63695C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbiKWS5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbiKWS5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:57:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375DE88FB2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669229765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6sqqXPcmfVlW87TsasyyU0paA+ECYRNhoy4wTU2alA=;
        b=F/gpKQt6pVHziyNXnY05f4BWmmViED+BTWf132l5BxUhvqoohgY1d/+9PYJGRD4l5i/0la
        Hxp/gLM1RmPdjRAjukgboygPA9icFg+PuCjawAVn1tLooOIEPidTaW7ZBYh/4cO4XQL0jT
        GjkrzQQx8exvF7/gmQK3s/umxjpSqHk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-_xy3ELJVMYW74syWELHwiA-1; Wed, 23 Nov 2022 13:56:04 -0500
X-MC-Unique: _xy3ELJVMYW74syWELHwiA-1
Received: by mail-qv1-f71.google.com with SMTP id 71-20020a0c804d000000b004b2fb260447so17200350qva.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6sqqXPcmfVlW87TsasyyU0paA+ECYRNhoy4wTU2alA=;
        b=BPTzf016AS5x7LCdLpjL1Wvnp9FU2Eue4VMcTPO7J8b6z9WZecNPMNwHfyft3Eg70Y
         Szx88IYpPwE4MVDb+8CxB/vOMQmBGCNATbcuzJRKCM0qZCJgqkJvkdBhoNTkafPNzusA
         sRyw7QgBOHToCqmHTsqE47OjbIE5BNtcJkNnu5uz8kQ/xaCKmF07aL3g4uv+boSQiptF
         b3c1w8fdui3jTXb/OKxlZtdDciTLxk+duTKeQKxBJHyNZK7TkUa0eYQHg669TXmWxlFh
         Gz75un5fDICzH3RjUac+8i21aGC65lHO3KXWCqwp8dxbPoyV2IdXp/COAuBwJZ+Di9pq
         R4jw==
X-Gm-Message-State: ANoB5pnn/Z7EmjThlZbmja/wlxtjnmzuVERQOGgwkN+6jVxy6TE6bUaC
        mntm918r6gY6UAOpn/NS3pNjWs5Tpuv4AXLyxgNnG6orA2q/6n6iaxZJCFuEED5W/VRC3LIQZRo
        pRr9qqPV/JJ1d9x/o0PBoxH6d
X-Received: by 2002:a05:622a:5819:b0:3a5:5d34:66a9 with SMTP id fg25-20020a05622a581900b003a55d3466a9mr11620630qtb.623.1669229763752;
        Wed, 23 Nov 2022 10:56:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7tQoi855YgG5ScHXRBMysHyiHRbOz7fpeOvjoKCM79Cg67F0B7UodUtg4i6tl93cBMMKALaA==
X-Received: by 2002:a05:622a:5819:b0:3a5:5d34:66a9 with SMTP id fg25-20020a05622a581900b003a55d3466a9mr11620607qtb.623.1669229763484;
        Wed, 23 Nov 2022 10:56:03 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id k1-20020a05620a414100b006eea4b5abcesm12566678qko.89.2022.11.23.10.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:56:03 -0800 (PST)
Date:   Wed, 23 Nov 2022 13:56:01 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH RFC v2 00/12] mm/hugetlb: Make huge_pte_offset()
 thread-safe for pmd unshare
Message-ID: <Y35swd4HHblyL3P7@x1n>
References: <20221118011025.2178986-1-peterx@redhat.com>
 <70376d57-7924-8ac9-9e93-1831248115a0@redhat.com>
 <Y343kIQ9l2d8wViz@x1n>
 <Y35kqkYQGW8ohKEa@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y35kqkYQGW8ohKEa@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:21:30AM -0800, Mike Kravetz wrote:
> On 11/23/22 10:09, Peter Xu wrote:
> > On Wed, Nov 23, 2022 at 10:40:40AM +0100, David Hildenbrand wrote:
> > > Let me try understand the basic problem first:
> > > 
> > > hugetlb walks page tables semi-lockless: while we hold the mmap lock, we
> > > don't grab the page table locks. That's very hugetlb specific handling and I
> > > assume hugetlb uses different mechanisms to sync against MADV_DONTNEED,
> > > concurrent page fault s... but that's no news. hugetlb is weird in many ways
> > > :)
> > > 
> > > So, IIUC, you want a mechanism to synchronize against PMD unsharing. Can't
> > > we use some very basic locking for that?
> > 
> > Yes we can in most cases.  Please refer to above paragraph [1] where I
> > referred Mike's recent work on vma lock.  That's the basic locking we need
> > so far to protect pmd unsharing.  I'll attach the link too in the next
> > post, which is here:
> > 
> > https://lore.kernel.org/r/20220914221810.95771-1-mike.kravetz@oracle.com
> > 
> > > 
> > > Using RCU / disabling local irqs seems a bit excessive because we *are*
> > > holding the mmap lock and only care about concurrent unsharing
> > 
> > The series wanted to address where the vma lock is not easy to take.  It
> > originates from when I was reading Mike's other patch, I forgot why I did
> > that but I just noticed there's some code path that we may not want to take
> > a sleepable lock, e.g. in follow page code.
> 
> Yes, it was the patch suggested by David,
> 
> https://lore.kernel.org/linux-mm/20221030225825.40872-1-mike.kravetz@oracle.com/
> 
> The issue was that FOLL_NOWAIT could be passed into follow_page_mask.  If so,
> then we do not want potentially sleep on the mutex.
> 
> Since you both are on this thread, I thought of/noticed a related issue.  In
> follow_hugetlb_page, it looks like we can call hugetlb_fault if FOLL_NOWAIT
> is set.  hugetlb_fault certainly has the potential for sleeping.  Is this also
> a similar issue?

Yeah maybe the clean way to do this is when FAULT_FLAG_RETRY_NOWAIT is set
we should always try to not sleep at all.

But maybe that's also not urgently needed. So far I don't see any real
non-sleepable caller of it exists - the only one (kvm) can actually sleep..

It's definitely not wanted, as kvm only attach NOWAIT for an async fault,
so ideally any wait should be offloaded into async threads.  Now with the
hugetlb code being able to sleep with NOWAIT, the waiting time will be
accounted to real fault time of vcpu and partly invalidate async page fault
handling.  Said that, it also means no immediate fault would trigger either.
It's just that for the pmd unshare we can start to at least use non-sleep
version of the locks.

Now I'm more concerned with huge_pmd_share(), which seems to have no good
option but only the RCU approach.

One other thing I noticed is I cannot quickly figure out whether
follow_hugetlb_page() is needed anymore, since follow_page_mask() seems to
be also fine with walking hugetlb pgtables.

follow_hugetlb_page() can be traced back to the git initial commit, I had a
feeling that the old version of follow_page_mask() doesn't support hugetlb,
but now after it's supported maybe we can drop follow_hugetlb_page() as a
whole?

-- 
Peter Xu

