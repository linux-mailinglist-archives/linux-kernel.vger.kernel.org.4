Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA76A616F2A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiKBUwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiKBUwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751365585
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667422285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oR5BqgUdMPYHt7RBSvr6JxSAHZ0ghv1vkqRRC1Z5JNE=;
        b=NB3fWdzDoWWAaA3ejesPJB8GnaGtlp6NIB421Xitr+MV7/rD+xp3hN/LEvE7bndgfqHu92
        Vn8pok2FEKrm7nHFWzfgPw2Jlm29Qkoi9cMuUvq00LcYTJXF4QOTQ6IQkafB0l3hqmX0po
        dy+I9L5F4kV1Ndt3UBvkrD0oJmmVH8I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-3OdVyq60OZCNObaYkxu8mA-1; Wed, 02 Nov 2022 16:51:24 -0400
X-MC-Unique: 3OdVyq60OZCNObaYkxu8mA-1
Received: by mail-qk1-f198.google.com with SMTP id bq13-20020a05620a468d00b006fa5a75759aso3165176qkb.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR5BqgUdMPYHt7RBSvr6JxSAHZ0ghv1vkqRRC1Z5JNE=;
        b=awrQKTzk56R+N6dQ1uVwMIUCTGbOky8BHjIrdwDb1Nl/kQAaWB/onpKraOovwKfTV+
         vXleOi5q1Vm/CWGqolBVTRf2ddx+AyWy7jevSBbUxozeWXBZItUrCp/BRAGTYBZJdTEr
         Fx+MLVcI4mGCC2HQvmGwC8nyTKDWGknGQyJ2omre7cXIp/sup5WUpAziLHTbwdLs7YD4
         G/a15RGr7So6ndWTGAxIZ1qjxxXhfHmj7lvPejALmLcSSuz3FHPiY93SPT7ZFBWo+vQa
         i0gY6bEu3wRAIrzIyYo29DoLdQtaPuAD5UpUOVmp+PtCIhTAiWBx5DbAhKy5DAaIOElc
         BMFg==
X-Gm-Message-State: ACrzQf0qZ4Lt7OM25/wZ4jRx6in7reUqYgeJMWj6colyRI4N7w9jIT4l
        S0Jlf49rXNFEJOpHKQ4XViCDMfu5EaGkE6aqqFUVsCAcUyMDxkY3RHd0ETVzUwlO0VS6PDFdaut
        fVRQutGSyHqHmfsWMpn2KRQN9
X-Received: by 2002:ac8:7493:0:b0:3a5:287b:d6c8 with SMTP id v19-20020ac87493000000b003a5287bd6c8mr13850209qtq.241.1667422283966;
        Wed, 02 Nov 2022 13:51:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5z0sDnzwMjh5BpqiSm0cjc6QcEARteCcLX1X6LhHxG+A3UaBmwN01/wAzwejujYQEP3qWbyQ==
X-Received: by 2002:ac8:7493:0:b0:3a5:287b:d6c8 with SMTP id v19-20020ac87493000000b003a5287bd6c8mr13850185qtq.241.1667422283733;
        Wed, 02 Nov 2022 13:51:23 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id h22-20020ac85156000000b003a533886612sm3377442qtn.3.2022.11.02.13.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:51:23 -0700 (PDT)
Date:   Wed, 2 Nov 2022 16:51:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH RFC 02/10] mm/hugetlb: Comment huge_pte_offset() for its
 locking requirements
Message-ID: <Y2LYSYLj94ajCaOI@x1n>
References: <20221030212929.335473-1-peterx@redhat.com>
 <20221030212929.335473-3-peterx@redhat.com>
 <F09923E5-605F-476E-976F-C7EABDF64938@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F09923E5-605F-476E-976F-C7EABDF64938@gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:46:52PM -0700, Nadav Amit wrote:
> On Oct 30, 2022, at 2:29 PM, Peter Xu <peterx@redhat.com> wrote:
> 
> > huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
> > hugetlb address.
> > 
> > Normally, it's always safe to walk the pgtable as long as we're with the
> > mmap lock held for either read or write, because that guarantees the
> > pgtable pages will always be valid during the process.
> > 
> > But it's not true for hugetlbfs: hugetlbfs has the pmd sharing feature, it
> > means that even with mmap lock held, the PUD pgtable page can still go away
> > from under us if pmd unsharing is possible during the walk.
> > 
> > It's not always the case, e.g.:
> > 
> >  (1) If the mapping is private we're not prone to pmd sharing or
> >      unsharing, so it's okay.
> > 
> >  (2) If we're with the hugetlb vma lock held for either read/write, it's
> >      okay too because pmd unshare cannot happen at all.
> > 
> > Document all these explicitly for huge_pte_offset(), because it's really
> > not that obvious.  This also tells all the callers on what it needs to
> > guarantee huge_pte_offset() thread-safety.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > arch/arm64/mm/hugetlbpage.c | 32 ++++++++++++++++++++++++++++++++
> 
> Please excuse my ignorant question - is there something specific for arm64
> code here? Other archs seem to have similar code, no?

Oops, sorry, I meant to add this to the version in mm/hugetlb.c.  Or maybe
to linux/hugetlb.h would make more sense.

I should probably also mention that for any arch that does not support pmd
sharing at all (afaik, any arch outside arm, x86 and riscv), the shared
mapping locking rule should be the same as private.

-- 
Peter Xu

