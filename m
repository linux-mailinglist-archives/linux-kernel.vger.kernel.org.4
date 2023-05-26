Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C78712A97
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjEZQ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEZQ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F879D3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685118313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PsJszb3Fdl+4KCiTmg2OAMXb15gljPH7bH8CgxNSabY=;
        b=bq2TUNhw03SGpftD8xkSNyCnL2H1B2ErsL3boM2qkhPuCQ2GDnMyx5lL+VHNsOaakdgfZE
        BTZUZGBiXz7NKGw1tzoee/qqoLGTmYgHEEIrh/3XzL/DnHcpb4zQ3RXqBTLtxKmXkcKALK
        QVBoAbTtCN13y8nAXjqI/DhkFx3EIFM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-fDqGAbp2OxaQ8pheLT8DGA-1; Fri, 26 May 2023 12:25:12 -0400
X-MC-Unique: fDqGAbp2OxaQ8pheLT8DGA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f6b1853e80so1604591cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685118311; x=1687710311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsJszb3Fdl+4KCiTmg2OAMXb15gljPH7bH8CgxNSabY=;
        b=G+ELu/PuxC4znNO+drYYETO04A9wM2oOI9QvI+fmlsmZi8MbJ8BiCfA1ftXpHIZiNc
         Syl2wcc7kjZ6GS1fX3k/vVdvKChPvIo6vW3e6SalWHkPIXLNW0uCli6uxz1m5yHs5x+z
         cmxA5PDRN4Jb9AksBaRFZFdGSClBVZS73QAehBwDxczGDz4Z3AxB0qms86px5tvfUGcV
         ry9mlK2ytChVH1bIH4jbehQCS+kqRZOdzZ2fY0j6CbIr8fdgvobZxmTYfvHl6crqIxH8
         h8Fa2h28dGNwJ0XQtY3nJa9MMT6Kq68KIW5/gFHTisqbmU/1yzdU2p2IqcHXjRvNEgMM
         QpLA==
X-Gm-Message-State: AC+VfDwZLCr0vvgHHeqcXwDaccp18TjOn02uMtC2lqaCVK8U/dHkJoIp
        XQzeEOF/c60gBH3hvh3eI1niOP1tornNgix0Mnr2lJDSFDzZb/dDgmOrxUqckS5B1QiFHCFUdFX
        hBqmQAdhlNtYIpTx8F/Kd9oS7
X-Received: by 2002:a05:6214:5183:b0:625:86ed:8ac8 with SMTP id kl3-20020a056214518300b0062586ed8ac8mr2440714qvb.4.1685118311451;
        Fri, 26 May 2023 09:25:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5e8uegKmA/XAEGaKWCkbZfbcirz0MPWJeTqDxxGlyKLoSTi1jAZy/i5FQlX1uWj6LhW7xDDA==
X-Received: by 2002:a05:6214:5183:b0:625:86ed:8ac8 with SMTP id kl3-20020a056214518300b0062586ed8ac8mr2440666qvb.4.1685118311138;
        Fri, 26 May 2023 09:25:11 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id nd13-20020a056214420d00b0061b58b07130sm35719qvb.137.2023.05.26.09.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 09:25:10 -0700 (PDT)
Date:   Fri, 26 May 2023 12:25:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 15/31] mm/userfaultfd: allow pte_offset_map_lock() to fail
Message-ID: <ZHDdYYQfqwiLSTzo@x1n>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <49d92b15-3442-4e84-39bd-c77c316bf844@google.com>
 <ZG6TOyH7NJIgXxGX@x1n>
 <8f2131ac-8996-e4b3-2aad-7a4d11bd538f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f2131ac-8996-e4b3-2aad-7a4d11bd538f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 03:06:27PM -0700, Hugh Dickins wrote:
> On Wed, 24 May 2023, Peter Xu wrote:
> > On Sun, May 21, 2023 at 10:07:35PM -0700, Hugh Dickins wrote:
> > > mfill_atomic_install_pte() and mfill_atomic_pte_zeropage() treat
> > > failed pte_offset_map_lock() as -EFAULT, with no attempt to retry.
> > 
> > Could you help explain why it should be -EFAULT, not -EAGAIN or -EEXIST?
> 
> Thanks a lot for looking, Peter.
> 
> No good justification for -EFAULT: I just grabbed the closest, fairly
> neutral, error code that I could see already being in use there: but now
> that you mention -EAGAIN, which I can see being used from mfill_atomic(),
> yes, that would be ideal - and consistent with how it's already being used.
> 
> I'll make that change, thanks for suggesting.  (And it had bugged me how
> my fs/userfaultfd.c was electing to retry, but this one electing to fail.)

Thanks.

> 
> > 
> > IIUC right now if pte existed we have -EEXIST returned as part of the
> > userfault ABI, no matter whether it's pte or thp.
> 
> It might or might not correspond to -EEXIST - it might even end up as
> -EFAULT on a retry after -EAGAIN: I see mfill_atomic() contains both
> -EEXIST and -EFAULT cases for pmd_trans_huge().  Actually, I could
> say that the -EFAULT case there corresponds to the -EFAULT in this
> 15/31 patch, but that would be by coincidence not design: I'm happier
> with your -EAGAIN suggestion.

I had a feeling that that 2nd -EFAULT there could crash some userapp
already if it got returned somewhere, because the userapp shouldn't expect
that.  IMHO it should also return -EAGAIN, or even -EEXIST because even if
user retries, we should highly possibly see that thp again, so the -EEXIST
should possibly follow anyway.

Not a big deal here I think - if an userapp can trigger that -EFAULT I'd
say it's also a user bug because it made two decisions already on resolving
page fault for single VA, and it's racy between them..

> 
> > 
> > IMHO it may boil down to my limited knowledge on how pte_offset_map_lock()
> > is used after this part 2 series, and I assume the core changes will be in
> > your 3rd series (besides this one and the arch one).
> > 
> > Please shed some light if there's quick answers (IIUC this is for speeding
> > up collapsing shmem thps, but still no much clue here), or I can also wait
> > for reading the 3rd part if it'll come soon in any form.
> 
> It wouldn't be particularly easy to deduce from the third series of
> patches, rather submerged in implementation details.  Just keep in mind
> that, like in the "old" pmd_trans_unstable() cases, there may be instants
> at which, when trying to get the lock on a page table, that page table
> might already have gone, or been replaced by something else e.g. a THP,
> and a retry necessary at the outer level (if it's important to persist).

I'm actually still curious how the 3rd series will look like; would love to
read it when it comes.

Thanks,

-- 
Peter Xu

