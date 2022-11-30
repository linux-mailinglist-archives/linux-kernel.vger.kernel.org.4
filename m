Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3726763E269
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiK3VCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiK3VCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:02:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3618324A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669842069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L42rLHtFBFKGLDIxtx1wN/+Aa4flR65WbTjaBq4HhSM=;
        b=etDjANrOPvhVjIdeDE2GnJozHf412ibQuH0TFdAvSew3/0q/wP9Dxof7hHDlhY76gRY1Hy
        XZWRi8e0ZFayRUCwbNBg4iNttEAG4xO9tGHYXfECBSLPA1VjnMoZTboXTDyqdrVRC+yLjG
        2NQPjFC/6qWZzv/zwHEJlXp/Cf4k2D4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-NUVBCnCDODyc84hwMXHvmw-1; Wed, 30 Nov 2022 16:01:07 -0500
X-MC-Unique: NUVBCnCDODyc84hwMXHvmw-1
Received: by mail-qv1-f72.google.com with SMTP id nn2-20020a056214358200b004bb7bc3dfdcso28752055qvb.23
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L42rLHtFBFKGLDIxtx1wN/+Aa4flR65WbTjaBq4HhSM=;
        b=40tny7ZdcOcf4WuZogyPSW258Kw917uZZPPpfvqYUj3brVpSkCdt6+yAQLnFodSBHe
         8LCNHDSaSzBqRLsWNd3wb54a6NzbzonFP4ZQi61EQ5w7nvwBsJq0Y3O5aWUzG2wuXsQR
         ca5qTd9TRiRHpi8U2FISO2eGq5YToDgQHr7GZbdW9jzW6IM2QQeyVwllstGpXqc32EqI
         lXs1/1mdHF4B0YLo8buv2u+NV7CJNVy3tZTv5qlofCqO2vxcUIQJxTE5JRH9XFQgUy6z
         g+mSILwRwJAZuBlyNar8p3M4jqbeGRUgdtRlKfBtzrnS2YI5BcXm23klAwy6QS7pGVYL
         5m9Q==
X-Gm-Message-State: ANoB5plmCVxXJmpNG80czs/LzRC4rN/LIiGT5l6PGPqN8kUmwBLE9bsc
        /ScTTXPMgm87MvVxSvSBbFRURJd/TR2s89mbmUWhuuWhNV4NrtRvnC9pUa6oCEyHtChHc1ZZu4H
        gxDc8uw5PsWYjfsLtforsmNHP
X-Received: by 2002:a0c:fec3:0:b0:4c6:86be:a0c9 with SMTP id z3-20020a0cfec3000000b004c686bea0c9mr40024928qvs.123.1669842066639;
        Wed, 30 Nov 2022 13:01:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf435WW7e+SRD2a0Ot/LRXewNLZWrlzaivBqjQjmp+Pm1l2nPA3XXu2BOI2f917QosYBdaVtmw==
X-Received: by 2002:a0c:fec3:0:b0:4c6:86be:a0c9 with SMTP id z3-20020a0cfec3000000b004c686bea0c9mr40024868qvs.123.1669842066197;
        Wed, 30 Nov 2022 13:01:06 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a0c5300b006fa84082b6dsm1858982qki.128.2022.11.30.13.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:01:05 -0800 (PST)
Date:   Wed, 30 Nov 2022 16:01:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 06/47] hugetlb: extend vma lock for shared vmas
Message-ID: <Y4fEkLkbYr7qfPQA@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-7-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-7-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:22PM +0000, James Houghton wrote:
> This allows us to add more data into the shared structure, which we will
> use to store whether or not HGM is enabled for this VMA or not, as HGM
> is only available for shared mappings.
> 
> It may be better to include HGM as a VMA flag instead of extending the
> VMA lock structure.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h |  4 +++
>  mm/hugetlb.c            | 65 +++++++++++++++++++++--------------------
>  2 files changed, 37 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index a899bc76d677..534958499ac4 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -121,6 +121,10 @@ struct hugetlb_vma_lock {
>  	struct vm_area_struct *vma;
>  };
>  
> +struct hugetlb_shared_vma_data {
> +	struct hugetlb_vma_lock vma_lock;
> +};

How about add a comment above hugetlb_vma_lock showing how it should be
used correctly?  We lacked documents on the lock for pmd sharing
protections, now if to reuse the same lock for HGM pgtables I think some
doc will definitely help.

To summarize, I think so far it means:

  - Read lock needed when one wants to stablize VM_SHARED pgtables (covers
    both pmd shared pgtables or hgm low-level pgtables)

  - Write lock needed when one wants to release VM_SHARED pgtable pages
    (covers both pmd unshare or releasing hgm low-level pgtables)

Or something like that.

-- 
Peter Xu

