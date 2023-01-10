Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8035C664212
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjAJNiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbjAJNiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:38:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E03B75
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FShK9vXFfxDQ4VGD5JOqblYjjglMV5Oj0hc50k6vmGY=; b=We4DGf5kDltzbK3aK6i7Z/0oJz
        c8anxvmA2jXtu9UH4C3LD2musClj6rfaKyX8NSiyCs716ySnSnm2ucdtBPLKDzrN7DsAYyqNJQuwB
        oOQXGs+9p94OYohhBLyFMNpTVf1E10zPtLNuaSwwUqGPZOq4l7A03EBRFktyBKWx15kRPq8jPpqFQ
        rgfGLUIuwh6181aUWTknoCIevc+FAI2eWgJ1IMml1LsaeUvS0gnFSk1oTdX1cOxQ8IjCbJbn/XBgb
        fRdrY1/Q7qGPv+a4B9Bvcthi+URHKL2kuufKhzovpA7u+LktD+RsIB2lG6dsbIRcRDyWFrwgBTtqe
        amIYcpew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFEpB-003FO5-KZ; Tue, 10 Jan 2023 13:37:57 +0000
Date:   Tue, 10 Jan 2023 13:37:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: compaction: Remove redundant VM_BUG_ON() in
 compact_zone()
Message-ID: <Y71qNeLNeiBB5a/+@casper.infradead.org>
References: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
 <740a2396d9b98154dba76e326cba5e798b640ead.1673342761.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <740a2396d9b98154dba76e326cba5e798b640ead.1673342761.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 09:36:18PM +0800, Baolin Wang wrote:
> The compaction_suitable() will never return values other than COMPACT_SUCCESS,
> COMPACT_SKIPPED and COMPACT_CONTINUE, so after validation of COMPACT_SUCCESS
> and COMPACT_SKIPPED, we will never hit other unexpected case. Thus remove
> the redundant VM_BUG_ON() validation for the return values of compaction_suitable().

I don't understand why we'd remove this check.

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/compaction.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 62a61de44658..5e6f5e35748d 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2313,9 +2313,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>  	if (ret == COMPACT_SUCCESS || ret == COMPACT_SKIPPED)
>  		return ret;
>  
> -	/* huh, compaction_suitable is returning something unexpected */
> -	VM_BUG_ON(ret != COMPACT_CONTINUE);
> -
>  	/*
>  	 * Clear pageblock skip if there were failures recently and compaction
>  	 * is about to be retried after being deferred.
> -- 
> 2.27.0
> 
> 
