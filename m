Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991AA62CA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKPUR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiKPURy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:17:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3A453EC1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668629815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJMb3PweKDaHiAjKMFZLERnJkKA8ghZTOfHaWwXAhIc=;
        b=OSyL7Z+gG/1dUjMJmNfw6SgaLQ/D/oz88Ch7/65QUKMqZ3WXaCXh5xWbOJQjLh+jFgqtzP
        Umw+E6DBYIbKizbSdoNaw8+lQXTICibBxAYEaB3TmqOlSH7JhcXGcuJmH0mSy3+84MByqH
        F6Xx3KV6sa4jFzxluJvaSXodEaGgjqY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-192-PlUXQi9bOo6YNTKXDRtVJQ-1; Wed, 16 Nov 2022 15:16:53 -0500
X-MC-Unique: PlUXQi9bOo6YNTKXDRtVJQ-1
Received: by mail-qk1-f200.google.com with SMTP id bs7-20020a05620a470700b006fac7447b1cso18579789qkb.17
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJMb3PweKDaHiAjKMFZLERnJkKA8ghZTOfHaWwXAhIc=;
        b=DhuQqSXZLxhB5k8Lo+cIxMaE2OdL2UAQ5Hg8+JM+AmxOzSdVmMLHIx2D+xXoY/8rl/
         ad+gkY77j4bIHemI9WsTKz15DWgRoPxcL4N0xLS2rSsZ4WWxvF8P6IsWhbHKSK3kxMgT
         Aa8m+Ltv8oZYr1Z8Y2f/1NkscppG4LNM+AL+qyy8XO2hY89xcooL3V2cntjIMh1sr3aB
         miyLUH4g1Qrqj8sOQatlqymWEc6e63ybGoweq1Kg+VvvJd6uzQyGhivLcWfAsDZUdSlc
         idQJnB01bZ5eh7ljx7v1OXPdMoimuXWrp/hqVOXRkzptX29OF5HB7r87gNyh8gL93JIw
         XZWQ==
X-Gm-Message-State: ANoB5pkk3skzmNTy4A4XupM0qEU1Q3dZrZS0dm/B0bNEcQMglE43kBEj
        9jiYMoJb5kiKjRsIE+S0d9k6Ob1NxW/iDWuSixJkkcTVK/tf7HnuswiB9UdsItmRILwgiTMFPtZ
        BRfweHMq7XgAQICmWvPR11oqG
X-Received: by 2002:a0c:8170:0:b0:4bb:5935:55ca with SMTP id 103-20020a0c8170000000b004bb593555camr22407692qvc.79.1668629812703;
        Wed, 16 Nov 2022 12:16:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5aRLGEaHlnWsaZ/VJekIk1mm/UMDqHcXYp/X4E3nS3hDkgOLuv6G5RvAMyDSIkxiDlejByjQ==
X-Received: by 2002:a0c:8170:0:b0:4bb:5935:55ca with SMTP id 103-20020a0c8170000000b004bb593555camr22407663qvc.79.1668629812374;
        Wed, 16 Nov 2022 12:16:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id c8-20020ac86608000000b0039d02911555sm9185919qtp.78.2022.11.16.12.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:16:51 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:16:50 -0500
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
Subject: Re: [RFC PATCH v2 37/47] hugetlb: remove huge_pte_lock and
 huge_pte_lockptr
Message-ID: <Y3VFMs3a6LQy1BnZ@x1n>
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-38-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021163703.3218176-38-jthoughton@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:36:53PM +0000, James Houghton wrote:
> They are replaced with hugetlb_pte_lock{,ptr}. All callers that haven't
> already been replaced don't get called when using HGM, so we handle them
> by populating hugetlb_ptes with the standard, hstate-sized huge PTEs.

I didn't yet check the rational at all, but just noticed there's one more
of it for ppc code:

*** arch/powerpc/mm/pgtable.c:
huge_ptep_set_access_flags[264] assert_spin_locked(huge_pte_lockptr(huge_page_shift(h),

-- 
Peter Xu

