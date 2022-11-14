Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0695A6273B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiKNAKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiKNAKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6051D10B4E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668384549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=me7e7RxjgLHoWBExT7BydjYneJHdyExPgSmmtK1wP7o=;
        b=Nq3DnjvLB4CacaN4idyBz6gxk1hyNwEMFYSczYuny6pWwVPEcDRZYr8uraedLlrSnILcFT
        mULtQMuK+pSl3/CLsD74XLBYOma9klfNS9o1tQY6iqq2vRb0JyNG4q2+GQTN3bjV0tTGU1
        Tf/Bg8b7UvvjWHkLDQn1a7ElKmGUuX8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-7FcrlIiwNLeaWeasmkw-SQ-1; Sun, 13 Nov 2022 19:09:06 -0500
X-MC-Unique: 7FcrlIiwNLeaWeasmkw-SQ-1
Received: by mail-qv1-f69.google.com with SMTP id c6-20020ad44306000000b004bb8352cb4cso7617788qvs.14
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me7e7RxjgLHoWBExT7BydjYneJHdyExPgSmmtK1wP7o=;
        b=DSFEfkpj7UhtX+wER8v5XY4W6QOZu0v/e4OmdwtNEsnEJCXcju6WsqZ1GW/7YKC3Nk
         tLxx9y+l3QkvRuzmqJzzf4koxNd3rBH2RwK8mJNKO9DZVco9MegntwnzIPBsBg1GEXd7
         JRBjpw2W/vguB3H6j3UguWSBljNUEcL5yAaCwvey8DabSf5qu7VEixytwi6sat/YJ3c/
         N9aR3v0wD+fLGNGiBH/29+7uyzOqh0mmgvqubTQ7sZ3yXHrTuPO0jvha3n+qODu8byhA
         d/vK1E81K/9FHOQq/VEh+aTP1AvVSNtcEYAeVwnxn5qeSypyQpA82prtrRtcccRGwUwU
         0Xqg==
X-Gm-Message-State: ANoB5pkLpsSOCVsesOiFYhunUgo1zBGlNmouBEmxfCQ4vRB+oyqNgrTB
        uWeIjP0JUc3fUjt6xamx9zy1YC46B6WeCU5b3DxSP/FO9tIL2PUXVtoQ20j9xw2WcpgxB1JTKgr
        CNWpMPy1tKbPIEahOAqNbx8/Y
X-Received: by 2002:a05:622a:1aa0:b0:3a4:30bc:849a with SMTP id s32-20020a05622a1aa000b003a430bc849amr10156606qtc.524.1668384545727;
        Sun, 13 Nov 2022 16:09:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5srM3rasKE2BkTPbgSf3JKGnjUhTsrjOa6ll7ihoo2cq4I1hmCfhmWmQUUw/k9uLzWti0urQ==
X-Received: by 2002:a05:622a:1aa0:b0:3a4:30bc:849a with SMTP id s32-20020a05622a1aa000b003a430bc849amr10156585qtc.524.1668384545482;
        Sun, 13 Nov 2022 16:09:05 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id q204-20020a3743d5000000b006a6ebde4799sm5476697qka.90.2022.11.13.16.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 16:09:05 -0800 (PST)
Date:   Sun, 13 Nov 2022 19:09:03 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 0/3] fix hugetlb MADV_DONTNEED vma_lock handling
Message-ID: <Y3GHH96+k10TZ4Rl@x1n>
References: <20221111232628.290160-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221111232628.290160-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 03:26:25PM -0800, Mike Kravetz wrote:
> This series addresses the issue first reported in [1], and fully
> described in patch 3.  While exploring solutions to this issue,
> related problems with mmu notification calls were discovered.  The
> first two patches address those issues.
> 
> Previous discussions suggested further cleanup by removing the
> routine zap_page_range.  This is possible because zap_page_range_single
> is now exported, and all callers of zap_page_range pass ranges entirely
> within a single vma.  This work will be done in a later patch so as not
> to distract from this bug fix.
> 
> [1] https://lore.kernel.org/lkml/CAO4mrfdLMXsao9RF4fUE8-Wfde8xmjsKrTNMNC9wjUb6JudD0g@mail.gmail.com/
> 
> Mike Kravetz (3):
>   madvise: use zap_page_range_single for madvise dontneed
>   hugetlb: remove duplicate mmu notifications
>   hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

