Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A626801D5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjA2VsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2VsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:48:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FFA1630C
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:48:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1F2D60C44
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 21:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6D9C433EF;
        Sun, 29 Jan 2023 21:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675028896;
        bh=rhFf7uedNxdey8EUF7LX7Ea/PKGhbbJ0ekQViXUqr0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rOHfC31UD2cUvJGxuNujV60wU4nBKmcOyjITFlE0VdHO+5d7EhJE4Nocfc/xpXTyV
         UKQeqUPQ3vb8vSXg2/FkEveP20SQUNe2UUF7ZamH4DaC+lsKYERxgU3PlLPwMWASMa
         DLz3xAeXJt7ieD/rQy9thZr3cRksofKSWFmYzUCY=
Date:   Sun, 29 Jan 2023 13:48:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Ma Wupeng <mawupeng1@huawei.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: memcg: fix NULL pointer in
 mem_cgroup_track_foreign_dirty()
Message-Id: <20230129134815.21083b65ef3ae4c3e7fae8eb@linux-foundation.org>
In-Reply-To: <20230129024451.121590-1-wangkefeng.wang@huawei.com>
References: <20230129024451.121590-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023 10:44:51 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> As commit 18365225f044 ("hwpoison, memcg: forcibly uncharge LRU pages"),

Merged in 2017.

> hwpoison will forcibly uncharg a LRU hwpoisoned page, the folio_memcg
> could be NULl, then, mem_cgroup_track_foreign_dirty_slowpath() could
> occurs a NULL pointer dereference, let's do not record the foreign
> writebacks for folio memcg is null in mem_cgroup_track_foreign() to
> fix it.
> 
> Reported-by: Ma Wupeng <mawupeng1@huawei.com>
> Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")

Merged in 2019.

> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1688,10 +1688,13 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
>  static inline void mem_cgroup_track_foreign_dirty(struct folio *folio,
>  						  struct bdi_writeback *wb)
>  {
> +	struct mem_cgroup *memcg;
> +
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	if (unlikely(&folio_memcg(folio)->css != wb->memcg_css))
> +	memcg = folio_memcg(folio);
> +	if (unlikely(memcg && &memcg->css != wb->memcg_css))
>  		mem_cgroup_track_foreign_dirty_slowpath(folio, wb);
>  }

Has this null deref actually been observed, or is this from code
inspection?  (This is why it's nice to include the Link: after a
Reported-by!)

Do we have any theories why this took so many years to surface?

I'm confused about the mention of 18365225f044, but the Fixes: target
is a different commit.  Please explain this?

Do you think the fix should be backported into earlier -stable kernels?
If so, it will need some rework due to the subsequent folio
conversion.



