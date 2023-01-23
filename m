Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B0678881
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjAWUlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjAWUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:40:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856E11E5FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M+2hSaJ+wA4mSIRRtNcRcMjyMLwH2Gn6mHrYpJGCE64=; b=S19br0bP5M3QiFob7wQv1Yu7pK
        0nZ1uBV1zrFUxjHD20Co8yc73fxke+E2kX8DRS3OqNf0f30wFs72BFEW56HC0SB71PYr+4FGCX6tg
        UbU35zhPMjwG2wCb9eXBGI5dzBy4z0uabfxFyrImC91hgldmEhFhvQk3dGQR/GifouSQtj+Y3ZyEn
        0wyKRCyL2dNxnqiJz3OKxI3AcHwq9i0zjE4mbkV86jMaXS3KySMpkaFJ+J4O8TSbwHB1h97t+iw8r
        UGqaSD657hUVCAP0Vz+fozyFBcNe5GAsPC9C8iHkcLYvqAAb9k57qAHCwXH7xs2mXU/M1OBbuOt5o
        /sAlUJYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK3b2-004Voj-Nz; Mon, 23 Jan 2023 20:39:16 +0000
Date:   Mon, 23 Jan 2023 20:39:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de
Subject: Re: [PATCH 2/2] mm/memory_hotplug: remove head page reference in
 scan_movable_pages()
Message-ID: <Y87wdBlxBrYjzADJ@casper.infradead.org>
References: <20230123202347.317065-1-sidhartha.kumar@oracle.com>
 <20230123202347.317065-2-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123202347.317065-2-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:23:47PM -0800, Sidhartha Kumar wrote:
> -		if (!PageHuge(page))
> +		folio = page_folio(page);
> +		if (!folio_test_hugetlb(folio))
>  			continue;
> -		head = compound_head(page);
>  		/*
>  		 * This test is racy as we hold no reference or lock.  The
>  		 * hugetlb page could have been free'ed and head is no longer

Assuming the comment is correct, this patch is also unsafe.

