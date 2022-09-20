Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF9A5BEB60
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiITQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiITQwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:52:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C3D647DB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF38A62545
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 16:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D890C433D6;
        Tue, 20 Sep 2022 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663692760;
        bh=Oh2dl9d4nX47VYSB8qPNmpq1Zk2XZIiNPnT0V++Qr88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4tmSnx++nKzK93WeJaV1LJZTXiy04Vj/m2fiS4zMjVm3fdUmiE3hOrgYsh1xagPC
         7vzBqiG3MDNCUgU5sZkuwB9NG7ycZuyej3zkymiFHt/Stmjr0io6cnFghApGfA+56v
         g5XZP9SHiZhxWEKic4knqIFLCBKw7DDYWrJ41GVuf8mI3h7ikRx/wwt4SLvJQdlssf
         5aAMwzfdblmpOpadJnKcg1I2AiJ0NWDqiNmOQx7kVYbP/3wZCWFQxxSo4dGrg9eod+
         N43K7tq8t+bJPZuFk1lRee1oM+WI9y0L7dRZ34P3Ee6RQgKeWOC5RFl5Dj3ZBWoOJd
         U/HnolC7c05Bg==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH v2] mm/damon: deduplicate damon_{reclaim,lru_sort}_apply_parameters()
Date:   Tue, 20 Sep 2022 16:52:38 +0000
Message-Id: <20220920165238.59328-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1663645461-21084-1-git-send-email-kaixuxia@tencent.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 11:44:21 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The bodies of damon_{reclaim,lru_sort}_apply_parameters() contain
> duplicates. This commit add a common function
> damon_set_region_biggest_system_ram_default() to removes the
> duplicates.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> Suggested-by: SeongJae Park <sj@kernel.org>
> ---
> v2:
>  -change the common function name and add kernel comment.
> 
>  include/linux/damon.h |  3 ++-
>  mm/damon/core.c       | 35 ++++++++++++++++++++++++++++++++++-
>  mm/damon/lru_sort.c   | 13 +++----------
>  mm/damon/reclaim.c    | 13 +++----------
>  4 files changed, 42 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index e7808a84675f..ed5470f50bab 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -557,7 +557,8 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
>  int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
>  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
>  
> -bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end);
> +int damon_set_region_biggest_system_ram_default(struct damon_target *t,
> +				unsigned long *start, unsigned long *end);
>  
>  #endif	/* CONFIG_DAMON */
>  
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 9c80c6eb00c2..9e96cb9fb5db 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1245,7 +1245,8 @@ static int walk_system_ram(struct resource *res, void *arg)
>   * Find biggest 'System RAM' resource and store its start and end address in
>   * @start and @end, respectively.  If no System RAM is found, returns false.
>   */
> -bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
> +static bool damon_find_biggest_system_ram(unsigned long *start,
> +						unsigned long *end)
>  
>  {
>  	struct damon_system_ram_region arg = {};
> @@ -1259,6 +1260,38 @@ bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
>  	return true;
>  }
>  
> +/*

We also need to add one more asterisk here to make this a valid kerneldoc
comment.

> + * damon_set_region_biggest_system_ram_default() - Set the region of the given
> + * monitoring target as requested, or biggest 'System RAM'.
> + * @t:		The monitoring target to set the region.
> + * @start:	The pointer to the start address of the region.
> + * @end:	The pointer to the end address of the region.
> + *
> + * This function sets the region of @t as requested by @start and @end.  If the
> + * values of the two pointers are pointing to are zero, however, this function
> + * finds the biggest 'System RAM' resource and set the region to cover the
> + * resource.  In the latter case, this function saves the start and end address
> + * of the resource in @start and @end, respectively.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int damon_set_region_biggest_system_ram_default(struct damon_target *t,
> +			unsigned long *start, unsigned long *end)
> +{
> +	struct damon_addr_range addr_range;
> +
> +	if (*start > *end)
> +		return -EINVAL;
> +
> +	if (!*start && !*end &&
> +		!damon_find_biggest_system_ram(start, end))
> +		return -EINVAL;
> +
> +	addr_range.start = *start;
> +	addr_range.end = *end;
> +	return damon_set_regions(t, &addr_range, 1);
> +}
> +
[...]

Thanks,
SJ
