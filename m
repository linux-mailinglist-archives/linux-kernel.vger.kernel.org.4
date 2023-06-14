Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA5573028C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245651AbjFNO6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245239AbjFNO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:58:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB77D198D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c+DUuKPNc+TCTVK85+ONR9/WBIlqrFGJwe0k+eUv3R4=; b=s+Foz2h710mseAM15VhBFXvVbv
        HnJzv2lzoy1MDnLHOCJ1NiZO8FcPrZTDVAA8SI2XVCG/6SiXWDm1dJVKw0vRHoQIuP2vr9Xh6Mld/
        ZDT/3a5d5Y+J1mlMA0tXUAxHS/4RdplskmthXG+w8QO8eTPwyAf8c/a9h/9oGTmu3JpU70z/7Kwgo
        K6/iFy68SK1lTA7+veAiIUJCz4ynMQrFINSKE7VFept+g7ONH/qQSNXvgLoZBflIQDrmX28RUm2M+
        J/Roi+bORWpHpSJyUknT1GwwzuS+pEelkxjhqztgWf/Gs96xw0g/4eCGot3IKatyqLmSVOsLHXQ/p
        YnWczeNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9RxC-006Rio-NA; Wed, 14 Jun 2023 14:58:34 +0000
Date:   Wed, 14 Jun 2023 15:58:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 6/7] mm/gup: Accelerate thp gup even for "pages != NULL"
Message-ID: <ZInVmrJdLWxOEkeD@casper.infradead.org>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613215346.1022773-7-peterx@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 05:53:45PM -0400, Peter Xu wrote:
> +			if (page_increm > 1)
> +				WARN_ON_ONCE(
> +				    try_grab_folio(compound_head(page),

You don't need to call compound_head() here; try_grab_folio() works
on tail pages just fine.

> +						   page_increm - 1,
> +						   foll_flags) == NULL);
> +
> +			for (j = 0; j < page_increm; j++) {
> +				subpage = nth_page(page, j);
> +				pages[i+j] = subpage;
> +				flush_anon_page(vma, subpage, start + j * PAGE_SIZE);
> +				flush_dcache_page(subpage);

You're better off calling flush_dcache_folio() right at the end.

