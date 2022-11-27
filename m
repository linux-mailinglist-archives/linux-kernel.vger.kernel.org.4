Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB97D639C9D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiK0Tv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0TvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:51:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3B264DC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:51:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A070260DF7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 19:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E75C433C1;
        Sun, 27 Nov 2022 19:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669578684;
        bh=u/x3fW/kNN7k6/MnlQGpUtV7XW5nRo+M7USr9HpvEd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/sSpxdQIfJtGqzzYHBMhwtme35L2XQD2y8x0d09iM4lJd02TwbLUXuVYwZU2PVsX
         6GBmJRvWvNfptTxdRvE9Jq+A61+fd11sDKZv8//W1XkfNv6BazyTHSJfgsDYGnSm77
         qsbyvE4EpBBsuJDzRekoyBy78EKhcEuCfrvn7RPVMhpemRRk1EWYM2aZFMyz0vXYs0
         GIu3fvGDbLa+RVv1GS/uEkALoV+HGfW49Ky4038A0mhZPX3b2u5u9JQLRo0aEFCiYz
         tHcTqwR5mCXPD7fK2b5FvzyHcWa9ZpVm7dFXva5q3DLdZS15wyaBJzKjH2i7kNiGYB
         upDa8qTGeo0Nw==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/11] mm/damon/sysfs-schemes: implement scheme filters
Date:   Sun, 27 Nov 2022 19:51:21 +0000
Message-Id: <20221127195121.1388-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124212114.136863-9-sj@kernel.org>
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

On Thu, 24 Nov 2022 21:21:11 +0000 SeongJae Park <sj@kernel.org> wrote:

> Implement scheme filters functionality of DAMON sysfs interface by
> making the code reads the values of files under the filter directories
> and pass that to DAMON using DAMON kernel API.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs-schemes.c | 85 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 7f2bab617156..6f014b328e6f 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[...]
> +static int damon_sysfs_set_scheme_filters(struct damos *scheme,
> +		struct damon_sysfs_scheme_filters *sysfs_filters)
> +{
> +	int i;
> +	struct damos_filter *filter, *next;
> +
> +	damos_for_each_filter_safe(filter, next, scheme)
> +		damos_destroy_filter(filter);
> +
> +	for (i = 0; i < sysfs_filters->nr; i++) {
> +		struct damon_sysfs_scheme_filter *sysfs_filter =
> +			sysfs_filters->filters_arr[i];
> +		struct damos_filter *filter =
> +			damos_new_filter(sysfs_filter->type,
> +					sysfs_filter->matching);
> +		int err;
> +
> +		if (!filter)
> +			return -ENOMEM;
> +		if (filter->type == DAMOS_FILTER_TYPE_MEMCG) {
> +			err = damon_sysfs_memcg_path_to_id(
> +					sysfs_filter->memcg_path,
> +					&filter->memcg_id);
> +			if (err)
> +				return err;
> +		}

Newly created filter should be added to the scheme, but this patch is missing
the code.  Will add that in the next version of this patch.

> +	}
> +	return 0;
> +}
> +
