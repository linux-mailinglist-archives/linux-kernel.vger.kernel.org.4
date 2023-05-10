Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C15E6FE706
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbjEJWJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbjEJWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:09:00 -0400
Received: from out-43.mta1.migadu.com (out-43.mta1.migadu.com [IPv6:2001:41d0:203:375::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348998690
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 15:08:32 -0700 (PDT)
Date:   Wed, 10 May 2023 15:08:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683756506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WrIQPQnkmZGURp0Bxb/q8NWjaJP+SM0tcC5NbyW/agE=;
        b=syYion/pf3iN5g6Erh/3IJtGMvtUP1OBfdD3Vp5MYVa4Lwh3Ievk83IcH0lqtCkDhM1UhN
        qHRIfMmS3RbokWDV5HvZmpwqnXrvohilj8m+uFX9+pcuE0VIwzX6rOM3WtEvscoATWoUJ8
        XBuQafjM5RUyAeeQUbrpb6ERXDxKJAE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCHv4] mm: optimization on page allocation when CMA enabled
Message-ID: <ZFwVypakvK7XJpFl@P9FQF9L96D.corp.robot.car>
References: <1683685251-2059-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683685251-2059-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 10:20:51AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Let us look at the series of scenarios below with WMARK_LOW=25MB,WMARK_MIN=5MB
> (managed pages 1.9GB). We can know that current 'fixed 1/2 ratio' start to use
> CMA since C which actually has caused U&R lower than WMARK_LOW (this should be
> deemed as against current memory policy, that is, UNMOVABLE & RECLAIMABLE should
> either stay around WATERMARK_LOW when no allocation or do reclaim via entering
> slowpath)
> 
> -- Free_pages
> |
> |
> -- WMARK_LOW
> |
> -- Free_CMA
> |
> |
> --
> 
> Free_CMA/Free_pages(MB)      A(12/30)     B(12/25)     C(12/20)
> fixed 1/2 ratio                 N             N           Y
> this commit                     Y             Y           Y
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

I'm mostly fine with the code. The commit message is still very confusing to me,
not sure I understand what exactly this table means. And you still use "U&R".

Also I'm a bit concerned about potential performance implications. Would be
great to provide some benchmarks or some data.
Probably it's ok because of we have pcp caches on top, but I'm not 100% sure.

Thanks!
