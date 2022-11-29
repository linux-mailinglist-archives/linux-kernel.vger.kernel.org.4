Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E243C63CA70
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiK2VUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiK2VUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:20:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A996037D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669756795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LSzicMX2zlmciN98+hI9iZ8zrUz0Rds/n2uEFyoUuaA=;
        b=WCnCPkP5wxXaMjtb4Cb+XzXX+2iTsTEdepzdJw+SJi9/I9rba0fsmsrfVMkjV5l3Kw4FtR
        3F/l5/ewcfTG+/5csXgDysMB9XT2dQzstDFaDDFFizH9Srr9dueQjlvuNh1XbqC/PC/2Ey
        ifM4Z77iXbv7Aeg62W+z6/PPUOnRJOA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-dgxoYReXPmaQBQMb9juCnA-1; Tue, 29 Nov 2022 16:19:54 -0500
X-MC-Unique: dgxoYReXPmaQBQMb9juCnA-1
Received: by mail-qv1-f72.google.com with SMTP id y11-20020ad457cb000000b004c6fafdde42so14988552qvx.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSzicMX2zlmciN98+hI9iZ8zrUz0Rds/n2uEFyoUuaA=;
        b=PbblDz3H45cgQ5Bjdtqyia5eDQ1xke7BgM/GlC5gHfwmmqxBr4hyDhpN8jpedauTso
         /Rz5suv2esxR3EVYvVFf5lDH4D39a86ppP67geS2WH7i5wpecHWZOU9s+6jJisNPsosZ
         /JlGwV7KxzvqtLZMk9jXMXy2bIk3+/Bl6Bsx6N2wJDcHVWOuO1kjCpFy3Hdya18Ucr2n
         gbeDmNzm8xe8zUdi2xAvWq6WWoPdbqmbEwUoAZCp2ninHlBl684MMGrw2Kn2YzgAsfbq
         BEq0u1Spc/FupeBLxUkX7pq8Ozyz+oVsYTfE+HjREHBSfBXfCLizhV9sVu73K17QRbPm
         3JCQ==
X-Gm-Message-State: ANoB5pnncsl2HygJYNCpcqi3a37H3nGyv3izpvUkMLfzh8TQG4u4qKYQ
        dDix8iIrj+QUN5RxiKbA1RWnEeSTFoMCXItxwdrwtCSmhwL3VCwG4wIkZytBxc6UPz6J7MhZEWA
        leWXymNKAr6hCfTfza9V9PPhP
X-Received: by 2002:a05:620a:41a:b0:6f3:b4d7:1725 with SMTP id 26-20020a05620a041a00b006f3b4d71725mr35090531qkp.535.1669756793831;
        Tue, 29 Nov 2022 13:19:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4FB6g3Ml877sJriaBgHYXO9Y4BtizTPhnM+s3EwLLchGB47okFkhLxAVMj+0FWqI+0+/qU1g==
X-Received: by 2002:a05:620a:41a:b0:6f3:b4d7:1725 with SMTP id 26-20020a05620a041a00b006f3b4d71725mr35090507qkp.535.1669756793572;
        Tue, 29 Nov 2022 13:19:53 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id w23-20020ae9e517000000b006f9f3c0c63csm11051297qkf.32.2022.11.29.13.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 13:19:53 -0800 (PST)
Date:   Tue, 29 Nov 2022 16:19:52 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 00/10] mm/hugetlb: Make huge_pte_offset() thread-safe for
 pmd unshare
Message-ID: <Y4Z3eKU/hYFOyGnU@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129124944.8eff54cda65d0f5a8a089e22@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221129124944.8eff54cda65d0f5a8a089e22@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

On Tue, Nov 29, 2022 at 12:49:44PM -0800, Andrew Morton wrote:
> On Tue, 29 Nov 2022 14:35:16 -0500 Peter Xu <peterx@redhat.com> wrote:
> 
> > Based on latest mm-unstable (9ed079378408).
> > 
> > This can be seen as a follow-up series to Mike's recent hugetlb vma lock
> > series for pmd unsharing, but majorly covering safe use of huge_pte_offset.
> 
> We're at -rc7 (a -rc8 appears probable this time) and I'm looking to
> settle down and stabilize things...

I targeted this series for the next release not current, because there's no
known report for it per my knowledge.

The reproducer needs explicit kernel delays to trigger as mentioned in the
cover letter.  So far I didn't try to reproduce with a generic kernel yet
but just to verify the existance of the problem.

> 
> > 
> > ...
> >
> > huge_pte_offset() is always called with mmap lock held with either read or
> > write.  It was assumed to be safe but it's actually not.  One race
> > condition can easily trigger by: (1) firstly trigger pmd share on a memory
> > range, (2) do huge_pte_offset() on the range, then at the meantime, (3)
> > another thread unshare the pmd range, and the pgtable page is prone to lost
> > if the other shared process wants to free it completely (by either munmap
> > or exit mm).
> 
> That sounds like a hard-to-hit memory leak, but what we have here is a
> user-triggerable use-after-free and an oops.  Ugh.

IIUC it's not a leak, but it's just that huge_pte_offset() can walk the
(pmd-shared) pgtable page and also trying to take the pgtable lock even
though the page can already be freed in parallel, hence accessing either
the page or the pgtable lock after the pgtable page got freed.

E.g., the 1st warning was trigger by:

static inline struct lock_class *hlock_class(struct held_lock *hlock)
{
	unsigned int class_idx = hlock->class_idx;

	/* Don't re-read hlock->class_idx, can't use READ_ONCE() on bitfield */
	barrier();

	if (!test_bit(class_idx, lock_classes_in_use)) {
		/*
		 * Someone passed in garbage, we give up.
		 */
		DEBUG_LOCKS_WARN_ON(1);  <----------------------------
		return NULL;
	}
        ...
}

I think it's because the spin lock got freed along with the pgtable page,
so when we want to lock the pgtable lock we see weird lock state in
dep_map, as the lock pointer is not valid at all.

-- 
Peter Xu

