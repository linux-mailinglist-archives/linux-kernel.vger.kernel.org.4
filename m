Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD173677F88
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjAWPWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjAWPWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:22:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F572BEFD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674487147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dAjCGEyu+CetHV6CkMW6JgjgwSUzdzfmM+USEBgwzng=;
        b=g/Cxrd4G6102KBPNy4gxf8dARfX02kOWOsO8581Rjy5UbIc0pmxoHjE2N4loJtB7Gp0oZq
        MYzj3b25dg+sf284ffNacXdevA1JUoaJIvtCc5G8pkRqt8ftYoW1h2e0soBmAu6TowanUu
        SetBnNSElLRUZm3nKXDX6hWouHvGQwU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-BvlkdGLWOzyM9oiSGR3NPw-1; Mon, 23 Jan 2023 10:19:06 -0500
X-MC-Unique: BvlkdGLWOzyM9oiSGR3NPw-1
Received: by mail-yb1-f199.google.com with SMTP id g73-20020a25db4c000000b00802b0159bccso8593323ybf.22
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAjCGEyu+CetHV6CkMW6JgjgwSUzdzfmM+USEBgwzng=;
        b=aNSlohVm07Z+OOq0bJfhidCaY1XEQG6NsQknAMArYoP+bOpWHDybwcuiCbnwalMf91
         FbYu/uC2J450mOcJOgfD3bKQtsaQYBtgK/Fb1Z7UjDKiaRlRaPzFTPkWnPcxNuLsqU4M
         eEYZGFTJAEWCX1f0WO4Jzm1ecx+KXNwCcAe6XuVm6LTwQ8Tky5Y1FMpEBoO8ARdCd3Cy
         C2kfYXMbaeRYoRfnQQnZskbetuZp3sV6g+vc+hinUwcBz31MLf7yxVcCCZ4illxVFbk2
         21VY2N/TYsH5nAiqJaZV+84JHfMbSO44ldjhPC2NuYweSjzbAhscViT7jAIOpnFhzU6L
         H7EA==
X-Gm-Message-State: AFqh2kobpWz7dcsuEhQrNpj4dAezCTOBRnf5TJq+Fl8JB6UYxgioecVk
        1HKc9bxI8dxjIGd64eBQOD5C9/OcraSgANJS2XE8/raJ6/+yr0IbhrDfS0mBGBHYA539zXJPpq0
        linFqGByinCVITmfFwELJH9WP
X-Received: by 2002:a25:4844:0:b0:802:dfdf:4efa with SMTP id v65-20020a254844000000b00802dfdf4efamr5505871yba.8.1674487145935;
        Mon, 23 Jan 2023 07:19:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtT1iHyYMaC6UskCZcrx1X3rLcukqYQk+FzypY3B/sY9FOpy3M7XMidQ86PMu755T3yk5P43w==
X-Received: by 2002:a25:4844:0:b0:802:dfdf:4efa with SMTP id v65-20020a254844000000b00802dfdf4efamr5505842yba.8.1674487145698;
        Mon, 23 Jan 2023 07:19:05 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id bs15-20020a05620a470f00b006b61b2cb1d2sm32001007qkb.46.2023.01.23.07.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:19:05 -0800 (PST)
Date:   Mon, 23 Jan 2023 10:19:03 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     James Houghton <jthoughton@google.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
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
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
Message-ID: <Y86lZxGEQOBv3Hmw@x1n>
References: <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey>
 <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <Y8m9gJX4PNoIrpjE@monkey>
 <Y8nCyqLF71g88Idv@x1n>
 <CADrL8HXkdxDdixWRKNw6RFdbiBX-Cb1Lk7qxg6LdeNywbMOaOA@mail.gmail.com>
 <Y8nNHKW0sTnrq8hw@x1n>
 <Y8nV2TvMK12yTPzE@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8nV2TvMK12yTPzE@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike,

On Thu, Jan 19, 2023 at 03:44:25PM -0800, Mike Kravetz wrote:
> On 01/19/23 18:07, Peter Xu wrote:
> > 
> > Actually when revisiting the locks I'm getting a bit confused on whether
> > the vma lock is needed if pmd sharing is anyway forbidden for HGM.  I
> > raised a question in the other patch of MADV_COLLAPSE, maybe they're
> > related questions so we can keep it there.
> 
> I can quickly answer that.  Yes.  The vma lock is also being used for
> fault/truncation synchronization.  Commit e700898fa075 make sure it is
> even used on architectures that do not support PMD sharing.
> 
> I had come up with a rather ugly method of using the fault mutex for
> fault/truncation synchronization, but using the vma lock was more
> elegant.

Thanks for answering, I'll need to read some more on truncation later.
Before that, since COLLAPSE will already require the i_mmap_rwsem write
lock already, does it mean it is naturally race-free against truncation
even without vma lock?

-- 
Peter Xu

