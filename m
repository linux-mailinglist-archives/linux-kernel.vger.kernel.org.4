Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02745647892
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLHWGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLHWFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:05:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7BC80A26
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XHcJ8SFuAjHDaK1/sDcU1aP6FVHrSJrqK2PQkn+GzIA=; b=MaowyLHmWPQgkqBIN5HOcX+TId
        fnlYME6a45ZhMgxqrMWAn0NBXQL3Svo8/I8Oyd39Dy6Pq2xJiesE6aQVKwCM/PayQOO1foS2o33Yn
        nai5Vm3LF4vGAje6Zo5qVDNe+RDgZSeyAahV8zfKMw5TiR57my0xt7CfgATEi/zY+8jC3nn0v+uFZ
        d/EU4aCIfYafA3lMQxYu4iFvI9LPThGMV2Yz4i0gIJwHRtwJJxFpOKkglfHQnzMm6fOGNuPqdolt2
        p8sKfGq4dQXO4xDTiOenReWBMPnD8n4jE5uCTgaV9hzcVtxT2rPloeYBBf/VSyvzFVxh+kPHP5ooZ
        bOzc+IVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3P0S-007NAH-4g; Thu, 08 Dec 2022 22:04:40 +0000
Date:   Thu, 8 Dec 2022 22:04:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        tsahu@linux.ibm.com, david@redhat.com
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Message-ID: <Y5JfeL48K3OWfNOu@casper.infradead.org>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
 <Y5I78soNmAFv7pi8@casper.infradead.org>
 <Y5JCi3h8bUzLf3cu@monkey>
 <2723541a-79aa-c6b5-d82c-53db76b78145@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2723541a-79aa-c6b5-d82c-53db76b78145@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 01:58:20PM -0800, Sidhartha Kumar wrote:
> 5) improve the style of folio_set_order() by removing ifdefs from inside the
> function to doing
> 
> #ifdef CONFIG_64BIT
>  static inline void folio_set_order(struct folio *folio,
>                  unsigned int order)
>  {
> 	 VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> 
> 	 folio->_folio_order = order;
>          folio->_folio_nr_pages = order ? 1U << order : 0;
> }
> #else
> static inline void folio_set_order(struct folio *folio,
>                  unsigned int order)
>  {
> 	 VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> 
> 	 folio->_folio_order = order;
> }
> #endif

While we usually prefer to put ifdefs outside the function, I don't
think that's justified in this case.  I'd rather see a comment inside
the function like:

static inline void folio_set_order(struct folio *folio,
                unsigned int order)
{
	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);

	folio->_folio_order = order;
#ifdef CONFIG_64BIT
	/*
	 * When hugetlb dissolves a folio, we need to clear the tail
	 * page, rather than setting nr_pages to 1.
	 */
	folio->_folio_nr_pages = order ? 1U << order : 0;
#endif
}
