Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F8B65C882
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbjACU4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjACU4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:56:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8844CEE32
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UE4pFETTCLCzR95QKSBJ3qT45YjNJI4csCeU5tD4KaQ=; b=u6TSBbldGd41Xz/Vk18GdgWB9c
        KaVf8X0givCS+fAja7O6AhPir7fXdlqrFxnNpRACQZVT1ffR4SKowzRat7d6LuIXJjxfaJlX5ZlqD
        U33fcLY0HCslISlwcSrRx3brql1Ul1r0Pj/yO85oovODlE8nw52Xz9TCZkBbJLDutWWX22Dbm4PO7
        0fteLjWEHVZepqyxrzhDXevgpu5LCTarJkqKM7LkQdaYNx896BHVZsnA8z4h0Idqq+uxBy8VurDvW
        n3Zz/ks0sspuqzNMHb4YizowAHvnqeJNoRfN90s928uN4TzSRkHJ3tazHojmFSmeZDAsc0bSh/Qwv
        UpcQ8UFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCoL5-00EP9P-Vf; Tue, 03 Jan 2023 20:56:52 +0000
Date:   Tue, 3 Jan 2023 20:56:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 1/8] mm/hugetlb: convert isolate_hugetlb to
 folios
Message-ID: <Y7SWk2cGmZnKlPZN@casper.infradead.org>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-2-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103191340.116536-2-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 01:13:33PM -0600, Sidhartha Kumar wrote:
> +++ b/include/linux/mm.h
> @@ -775,6 +775,11 @@ static inline bool get_page_unless_zero(struct page *page)
>  	return page_ref_add_unless(page, 1, 0);
>  }
>  
> +static inline bool get_folio_unless_zero(struct folio *folio)
> +{
> +	return folio_ref_add_unless(folio, 1, 0);
> +}
> +

I think that's folio_try_get() in linux/page_ref.h.

The rest looks good though.
