Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BD572A41D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjFIUK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:10:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957991B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0HXVmnlVKBq0ssRDEmsoSJn11Ep+kO0iOz1cvxDsGzc=; b=vT+xFxtoVOxsh/JuBcSwVFlLSy
        r6fZ4SHqauLNA9/u3Aiy1rp8c0czsXItXrtZECi7eXEGWxbUikInvpRcBGgyU3pF7fmsLlVE1qF8D
        KlTB7x/z/xA408e5tWzxSWZ2SrKK2vlKiiLdgA2/GKBtbGYfrZtOm7PD04m3Twqn8QTvFiUNlxhZl
        BvVy0nx8n7c+20mtzJtpismK3vaH8HCZ0OvYcGWesw2xcvDU7WeRHU5bsFf2wRS3id+yilq7q4/CL
        ENMc/K75BorOzls2PQnRBSJCJ6ayKPlsuMWDVDtSHWMqZVcCWh5DQirBp3/rlbrl1m62gpBb/60aS
        s+7lw45Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7iRD-00Gzss-8m; Fri, 09 Jun 2023 20:10:23 +0000
Date:   Fri, 9 Jun 2023 21:10:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, david@redhat.com, nphamcs@gmail.com,
        jthoughton@google.com
Subject: Re: [PATCH 2/2] mm/hugetlb: add wrapper functions for interactions
 with page cache
Message-ID: <ZIOHL1dtyoaR1S/w@casper.infradead.org>
References: <20230609194947.37196-1-sidhartha.kumar@oracle.com>
 <20230609194947.37196-3-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609194947.37196-3-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 12:49:47PM -0700, Sidhartha Kumar wrote:
> +++ b/fs/hugetlbfs/inode.c
> @@ -617,20 +617,19 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  	struct hstate *h = hstate_inode(inode);
>  	struct address_space *mapping = &inode->i_data;
>  	const pgoff_t start = lstart >> huge_page_shift(h);
> -	const pgoff_t end = lend >> huge_page_shift(h);
>  	struct folio_batch fbatch;
>  	pgoff_t next, index;
>  	int i, freed = 0;
>  	bool truncate_op = (lend == LLONG_MAX);
>  
>  	folio_batch_init(&fbatch);
> -	next = start;
> -	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
> +	next = lstart;

That's suspicious.  Surely it should be

	next = lstart / PAGE_SIZE;

> +	while (filemap_get_folios(mapping, &next, lend - 1, &fbatch)) {

and 'end' is supposed to be a pgoff_t, so lend - 1 is also suspicious.

> -			index = folio->index;
> +			index = (folio->index) >> huge_page_shift(h);

You don't need to use brackets here.  While C's operator precedence is
legendarily confusing, the arrow operator binds far tighter than the
shift operator.

