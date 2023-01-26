Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879BE67D66F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjAZUbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAZUbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5E24B896
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674765059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ll0V3I7kfKN/RNSG+br5DK8YyR2aVaIIjphKRmGGxiI=;
        b=YCJrWGLNoKotDEuG8azrATnhykyLnL2cUXQTZMoHeD0aJLc1V7Wy03i3mevk8XtjWQyXPp
        BpUxT4IIRUO1c3FSKB9xDIBwBkU5V6vv6q3lFRqofiBLaUWhKnZFw4ouLW41QugNMBCqGt
        3cbCuR/uKdKYjw5GTHgnsNEOKKCy/XY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-H0QsmrbQM6KIJiAY0B-qtw-1; Thu, 26 Jan 2023 15:30:58 -0500
X-MC-Unique: H0QsmrbQM6KIJiAY0B-qtw-1
Received: by mail-qt1-f198.google.com with SMTP id w25-20020ac86b19000000b003b692f65ca2so1307214qts.20
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ll0V3I7kfKN/RNSG+br5DK8YyR2aVaIIjphKRmGGxiI=;
        b=sHnTbYI1kuExXHkxubwDgrBRwt2D3BTlRKhvFCOxX3CxbuGTdR3Iq4pU0nyqcrVdr+
         V/6vIP0Qy6fsG6jEdLCQb8bj7tD9y+96i2jixzrqXHEFKA6zWpXnDa/4Kvhu6enfQcYO
         8CGUYg6yznuHLE1XOjzmcLkR2pRyPMVmVrd4oPg50NVVncOc7yBWICY2i8P5SxxYjNjL
         h0I93rTIv9Nu/e24pBR/HaymdUk9l+a3H2ZTtsEgIdaFxgGOLEcnTki5k8GbRxYposaM
         k2kHTqC2Emhmc8sSDHNElXVcKmDLT4u5yy8BCZOi4tp5UMkkygt9FEyYwtnCK6gNabBv
         iH/A==
X-Gm-Message-State: AFqh2koKYKsskzkMmvTcCcYrnLLo0gxwqAQeu/t+tuBandbJnbYNKt+2
        iJQo/fVclJYHJDxAlnXZWCfGNMvLK+lYablLm0eJCqXCyo6lKD0HgE5zO7ofSdY6e9sSjqoi3lV
        LOIuvetcV804LySdgj1G+SUaV
X-Received: by 2002:ac8:58c3:0:b0:3a8:1635:ae5e with SMTP id u3-20020ac858c3000000b003a81635ae5emr71320839qta.39.1674765057966;
        Thu, 26 Jan 2023 12:30:57 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsmqtHY8vIOFu1YZY4r+FqY9oczaXkJg9GwDeOoCASEvlRqFe34h2YwWRwqOtzhCVBCtX3uPw==
X-Received: by 2002:ac8:58c3:0:b0:3a8:1635:ae5e with SMTP id u3-20020ac858c3000000b003a81635ae5emr71320784qta.39.1674765057487;
        Thu, 26 Jan 2023 12:30:57 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id 19-20020ac85713000000b003adc7f652a0sm1420494qtw.66.2023.01.26.12.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 12:30:56 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:30:47 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
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
Message-ID: <Y9Li93O6Ffwcr+vn@x1n>
References: <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
 <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
 <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey>
 <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <CADrL8HV92DaNm5bUwcOxsG8Lg4yLT6F13KWSbjkySPNAsgCfpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HV92DaNm5bUwcOxsG8Lg4yLT6F13KWSbjkySPNAsgCfpA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Thu, Jan 26, 2023 at 08:58:51AM -0800, James Houghton wrote:
> It turns out that the THP-like scheme significantly slows down
> MADV_COLLAPSE: decrementing the mapcounts for the 4K subpages becomes
> the vast majority of the time spent in MADV_COLLAPSE when collapsing
> 1G mappings. It is doing 262k atomic decrements, so this makes sense.
> 
> This is only really a problem because this is done between
> mmu_notifier_invalidate_range_start() and
> mmu_notifier_invalidate_range_end(), so KVM won't allow vCPUs to
> access any of the 1G page while we're doing this (and it can take like
> ~1 second for each 1G, at least on the x86 server I was testing on).

Did you try to measure the time, or it's a quick observation from perf?

IIRC I used to measure some atomic ops, it is not as drastic as I thought.
But maybe it depends on many things.

I'm curious how the 1sec is provisioned between the procedures.  E.g., I
would expect mmu_notifier_invalidate_range_start() to also take some time
too as it should walk the smally mapped EPT pgtables.

Since we'll still keep the intermediate levels around - from application
POV, one other thing to remedy this is further shrink the size of COLLAPSE
so potentially for a very large page we can start with building 2M layers.
But then collapse will need to be run at least two rounds.

-- 
Peter Xu

