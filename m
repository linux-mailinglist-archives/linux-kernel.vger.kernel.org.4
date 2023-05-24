Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431D8710116
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbjEXWpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbjEXWpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F8090
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684968264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPoOjhwLXPec5N/XBPFEXrHrpaUF5lpSnwsns99mvPk=;
        b=V/EXWyUSflBB0qvnJ4quQdVCq4LC6STnCnl9sPUJE6ztKCTDAXJfMA+BaB8neyfm/Maxq6
        NAUnmgA19Qsq9saMYGQGnwAgtLzJvGUa3OS9FonvvN1IJTjcxEu8Wcc8baVDZjZsvOfp7A
        KcG07qOugxW02lHBwJl3eHLa4sXQouY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-dJeOY7hmNjKbj6EYJX4rOw-1; Wed, 24 May 2023 18:44:15 -0400
X-MC-Unique: dJeOY7hmNjKbj6EYJX4rOw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f386bb966cso2529331cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684968255; x=1687560255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPoOjhwLXPec5N/XBPFEXrHrpaUF5lpSnwsns99mvPk=;
        b=Lri2b1Usnc07HyzO0TABEfO4HsA5scf2atx3XfNvht6b6kIXGzwi/UXjGEQ3vjjXne
         HXwrlRoYX2GZ9gdbIclGeJF78cVmBOi1fTXJ9SNjbpEVcxrEPm8x5KoqcNkjXkjHNcMh
         MkhEi5NSSr7Qv0QskHkSTf5UBGepCbfoOf684x7Tjr6ZuAOCAdMoUn1ORTyik1EvtD8l
         XLZKWtaYX4S+wxACuYNesL8zj6rV7yrpM0d8KgAB3RvVsi3XDZbbIqV37Lp74L3RTMxc
         R84ANT9CJWaniUFBaJwd0l5sfcT4fIvl+VetdJt/fU+11n/NAxSPr+sarWwnkiyU/r+T
         xSxQ==
X-Gm-Message-State: AC+VfDzHtUl5+a9aVLoHoN2SPKVoQ+ZMw2Bh4zZPPw5ccgSowlCIhSfe
        tyb6UhAVrXAzv8WQLW83EWOrLNp0ZGwhTTb3P8FSlQeC/OLnHPhJC6iWSBr+6mm8O+BFkj2gdRc
        Y1onOcEUNItdakKZVIWkrHwrZ
X-Received: by 2002:a05:620a:2b92:b0:75b:3a99:241c with SMTP id dz18-20020a05620a2b9200b0075b3a99241cmr3995852qkb.7.1684968254996;
        Wed, 24 May 2023 15:44:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7DDwCvPTbPVkW+3OaRTKABEOPbZ8FcFX9lEyuaGjGgRdBSzhRkXTDsVeO4Keydw3iWkAeX+Q==
X-Received: by 2002:a05:620a:2b92:b0:75b:3a99:241c with SMTP id dz18-20020a05620a2b9200b0075b3a99241cmr3995817qkb.7.1684968254738;
        Wed, 24 May 2023 15:44:14 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id m5-20020ae9e005000000b007578b6d060bsm3573906qkk.126.2023.05.24.15.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:44:14 -0700 (PDT)
Date:   Wed, 24 May 2023 18:44:11 -0400
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
Message-ID: <ZG6TOyH7NJIgXxGX@x1n>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <49d92b15-3442-4e84-39bd-c77c316bf844@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49d92b15-3442-4e84-39bd-c77c316bf844@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hugh,

On Sun, May 21, 2023 at 10:07:35PM -0700, Hugh Dickins wrote:
> mfill_atomic_install_pte() and mfill_atomic_pte_zeropage() treat
> failed pte_offset_map_lock() as -EFAULT, with no attempt to retry.

Could you help explain why it should be -EFAULT, not -EAGAIN or -EEXIST?

IIUC right now if pte existed we have -EEXIST returned as part of the
userfault ABI, no matter whether it's pte or thp.

IMHO it may boil down to my limited knowledge on how pte_offset_map_lock()
is used after this part 2 series, and I assume the core changes will be in
your 3rd series (besides this one and the arch one).

Please shed some light if there's quick answers (IIUC this is for speeding
up collapsing shmem thps, but still no much clue here), or I can also wait
for reading the 3rd part if it'll come soon in any form.

Thanks,

-- 
Peter Xu

