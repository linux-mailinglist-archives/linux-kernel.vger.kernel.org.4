Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DE168CDDE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjBGECR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjBGECN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:02:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A712066
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SlfuOIdUMdjnLHqe7YMHIMbmEgr9HQQJkrBfMgXp5KU=; b=Rm7SwKLfyFSh+zhXj4m/C0c3RY
        RghieOymR9Gx8Ww0KXpBXh+5UrqaykqhHnEnwKs0vENQlTmzJxTL4HANjLLUvrStZA3xpUMP2w5yM
        ePwO+3Ouk6HfX7oySEjDsNN7Vpt3MBIlye64wT7cjoWaIsFoirUw1SSxwbrnAC/ohDoBEsttXX9Ri
        70pTcISz9b6VlrvRn9AcVpaTLG5YRiN4prLr1OMFueTXeFM20R+gPfG3t6CNt+Q63EcYRTDZRsqkV
        DP6+Tdpn/ISJaxFM9YAhI3Fr1bgyF//g+R3ZV0UAH+2oaDT9Sjm+Q1uE0EsAPd3K8eHt97rzbMHjA
        gxJmigWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPFB1-00HQxz-L9; Tue, 07 Feb 2023 04:01:51 +0000
Date:   Tue, 7 Feb 2023 04:01:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        p.raghav@samsung.com, dave@stgolabs.net, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] shmem: add support to ignore swap
Message-ID: <Y+HNL9RoP48tquGd@casper.infradead.org>
References: <20230207025259.2522793-1-mcgrof@kernel.org>
 <20230207025259.2522793-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207025259.2522793-3-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:52:59PM -0800, Luis Chamberlain wrote:
> @@ -1334,11 +1336,15 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>  	struct shmem_inode_info *info;
>  	struct address_space *mapping = folio->mapping;
>  	struct inode *inode = mapping->host;
> +	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>  	swp_entry_t swap;
>  	pgoff_t index;
>  
>  	BUG_ON(!folio_test_locked(folio));
>  
> +	if (wbc->for_reclaim && unlikely(sbinfo->noswap))
> +		return AOP_WRITEPAGE_ACTIVATE;

Not sure this is the best way to handle this.  We'll still incur the
oevrhead of tracking shmem pages on the LRU, only to fail to write them
out when the VM thinks we should get rid of them.  We'd be better off
not putting them on the LRU in the first place.
