Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3814E63E2C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiK3VdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiK3VdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:33:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBFB900E7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669843930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x59hIThm5V0QLAqU1m85qGxeISVduxBHI6pskPD5vjI=;
        b=JKQru86oosN9VwlWMJSN++p2bJc+fu8QRGKphGmNOMQpBOq1LyGsJ7QlSg66F6C24V0K+b
        kBN4wXNM0ZHWPJJUGkwSCTR24BNMlIyHAWjEmEhCPeUrTFWuQctlEftgCuyxeG7X+B8YZo
        fRUmg+VnN5f/aK3GZDot2lSCLm5F+wk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-4xLk2rwZNeSWxk46c01NcA-1; Wed, 30 Nov 2022 16:32:08 -0500
X-MC-Unique: 4xLk2rwZNeSWxk46c01NcA-1
Received: by mail-qv1-f72.google.com with SMTP id u15-20020a0cec8f000000b004c704e015f7so73663qvo.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x59hIThm5V0QLAqU1m85qGxeISVduxBHI6pskPD5vjI=;
        b=54YOY95fiQ2MwkYmgWDOCkQX85LfzoJzr2fd6aP/lNDtLRTQycJxI/b7p31DNLbgHL
         7t4gfRw0xR1cuKJVB2UrKJk6ebY/nepQ3qcpp9YGUEs21RcYSCzs+2pVBXu//UP72CJq
         qLRmcEbODXGDiWZr0dr4SqkdE3LWBUZWZp4EhnUhw0Gy6tY698TmD2I3LxHeZy4Z8mQm
         zys9bQDZAiCiXFaazqG/5nIrAGUkqwXUSeR3xJzI+YVPDvHdTG6BzJo5fNl6inepy2fL
         RQrQYMqsi5l+3wu/r9T0UsvG+tHSmMkXczUlffAYfhk4jTNy7Df8uqg+es/TQkJqsiJ9
         k1FQ==
X-Gm-Message-State: ANoB5pl1ZB37NoNpqw/Pf4aZd1zuNl8yPm+B82dBowLGrpvFqPU3n2xk
        ns6vRQqdPuARA3bobtEGYjz+0WR09fEHaoKuULOEzP/EeB8HohD07NY3bTnfwC7x2zf+XH3xIgb
        hmxjOJWyvD04aLvLn9swnZ5UD
X-Received: by 2002:a37:5e84:0:b0:6ef:419:74d8 with SMTP id s126-20020a375e84000000b006ef041974d8mr55618160qkb.725.1669843927782;
        Wed, 30 Nov 2022 13:32:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf658zMR05fVIwmRQxhkPO+eZyx0BLxFwNGIqOQNpw9c7ja9gRDgVEySEL6AavvDf3AxrhcHzQ==
X-Received: by 2002:a37:5e84:0:b0:6ef:419:74d8 with SMTP id s126-20020a375e84000000b006ef041974d8mr55618130qkb.725.1669843927526;
        Wed, 30 Nov 2022 13:32:07 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id h19-20020ac85153000000b003a6328ee7acsm1459189qtn.87.2022.11.30.13.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:32:07 -0800 (PST)
Date:   Wed, 30 Nov 2022 16:32:05 -0500
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
Subject: Re: [RFC PATCH v2 25/47] hugetlb: add HGM support for
 copy_hugetlb_page_range
Message-ID: <Y4fL1SjtFif4/REe@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-26-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-26-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:41PM +0000, James Houghton wrote:
> This allows fork() to work with high-granularity mappings. The page
> table structure is copied such that partially mapped regions will remain
> partially mapped in the same way for the new process.
> 
> A page's reference count is incremented for *each* portion of it that is
> mapped in the page table. For example, if you have a PMD-mapped 1G page,
> the reference count and mapcount will be incremented by 512.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>

I have a feeling that this path is not triggered.  See:

bcd51a3c679d ("hugetlb: lazy page table copies in fork()", 2022-07-17)

It might be helpful to have it when exploring private mapping support of
hgm on page poison in the future.  But the thing is if we want this to be
accepted we still need a way to test it. I just don't see how to test this
without the private support being there..

-- 
Peter Xu

