Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2BF6525A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiLTRjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLTRj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:39:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E7862CF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671557920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fEfc8sJnHm7K9aruHy33BZirM4UCmBd1CuSTlZNxnWo=;
        b=f378FLiCTEU48S5bhGhS0vPelNpWAsXVKBiOL2+Jok6qlwUrLKBwmC/e2wJhw/BIznkufV
        GjiCC5iCGaVAyOlZ8UD0nPkdLvY9pFmHnUPb16gQ/1VQUXjsmOZv29m0tWZwyh6+GbKJny
        78bwLCFoqyG+rNkcp9/GgJwX+ktk3GE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-CQWlfOA0NDajuyjkVcaysw-1; Tue, 20 Dec 2022 12:38:39 -0500
X-MC-Unique: CQWlfOA0NDajuyjkVcaysw-1
Received: by mail-qt1-f200.google.com with SMTP id o9-20020ac841c9000000b003a820e4c248so5777212qtm.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEfc8sJnHm7K9aruHy33BZirM4UCmBd1CuSTlZNxnWo=;
        b=xlee+szS2LdqtlkW9OXMOtGMB7jl23qa52K2cHVCLQMgwCyBshr1cmtOxotrkhwBIy
         zpJglqlSX4YyGbh630Wi4HNTBksydkHQJDUned63SNQCAvD3a04gpBSVoZ03qY/WOFMN
         i9s2/KADtiLGuF1cAyr6a4dhOsSte6+dU1EZYrTANYUnH6Ahx6886IXcsJsDS9BsW3lC
         xhUVSrUgC6n5UTHyWybCrhStpwNCu9OGQ6Ht9A3gld/ZERWBabkhYHWcAf1wZa5pVq3G
         3HHgHWAgUgL7q+XsIZuvtRTvlSbb4Lh3U7B3YBlRuwrTTLdRUXQAnpBFRYtnqyYjP4ws
         t2ug==
X-Gm-Message-State: AFqh2kq5sUY3AWR2XuMuI9qDvb+zN3PaHp+hp5xRwEeQs/E+yAxLqxNc
        +A1QFsG1/khIuVOiHYJtf6wp7Nh6X0b5R4wvtVlWZbT+1aw7sozGn8bvNTW4a0/btjmOEkIERWK
        HyFzBkgkuHif8sgehuwWib47u
X-Received: by 2002:ac8:7404:0:b0:3a9:8610:f9af with SMTP id p4-20020ac87404000000b003a98610f9afmr4892451qtq.14.1671557918842;
        Tue, 20 Dec 2022 09:38:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtg5R2YbTU53YK6jcMnW9vCQk+xxP9JBp96j27cdKzorbZMYmsqPt75wVleU8oFZr+Onr1Sjg==
X-Received: by 2002:ac8:7404:0:b0:3a9:8610:f9af with SMTP id p4-20020ac87404000000b003a98610f9afmr4892421qtq.14.1671557918568;
        Tue, 20 Dec 2022 09:38:38 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id r17-20020a05620a299100b006fb8239db65sm9360534qkp.43.2022.12.20.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 09:38:37 -0800 (PST)
Date:   Tue, 20 Dec 2022 12:38:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christian Brauner <brauner@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm: remove zap_page_range and change callers to use
 zap_vma_page_range
Message-ID: <Y6HzHFdXB02Roa7q@x1n>
References: <20221216192012.13562-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221216192012.13562-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 11:20:12AM -0800, Mike Kravetz wrote:
> zap_page_range was originally designed to unmap pages within an address
> range that could span multiple vmas.  While working on [1], it was
> discovered that all callers of zap_page_range pass a range entirely within
> a single vma.  In addition, the mmu notification call within zap_page
> range does not correctly handle ranges that span multiple vmas as calls
> should be vma specific.
> 
> Instead of fixing zap_page_range, change all callers to use the new
> routine zap_vma_page_range.  zap_vma_page_range is just a wrapper around
> zap_page_range_single passing in NULL zap details.  The name is also
> more in line with other exported routines that operate within a vma.
> We can then remove zap_page_range.
> 
> Also, change madvise_dontneed_single_vma to use this new routine.
> 
> [1] https://lore.kernel.org/linux-mm/20221114235507.294320-2-mike.kravetz@oracle.com/
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Peter Xu

