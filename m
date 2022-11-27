Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29041639C48
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 19:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiK0SXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 13:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiK0SXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 13:23:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8751149
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 10:22:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1166B60E84
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 18:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C20C433C1;
        Sun, 27 Nov 2022 18:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669573376;
        bh=57HIenwr4Kxr7NNYG8vCR5qqJX7zD83iy2OLbU6pyIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Emh5Ol8sdOZJZuy9excDvXibwZaXZtYmloEpPcDw06KILvTUTJc/Dd0GyAVPgxmIq
         0moiWYEXes3Tga3TndQa7tlyjHkJ+FNUhfkU+p7mYuACkKCVtnzGPkjfAg5XzFGhVV
         7wa6AXUUPJCJqDgIgCOoT9fgkhMJv2Ai/LCSr9zMFVE7PLEiQnbyvmw6if3qyKK7gu
         vYsDpH+Fu4H/7rCbR5/+6BfNDwHngS5rCuSTnzrZge9FyDpfOOFTw0jRUMg9R6OnUs
         45rEM0Fp2lRlWBrNypsHWZDLAVej53hvOmxtuA7+MNANiWcyD2XmoFNPo2ns7jsLUQ
         EwYSSHPt1JhOA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/11] mm/damon/sysfs-schemes: connect filter directory and filters directory
Date:   Sun, 27 Nov 2022 18:22:54 +0000
Message-Id: <20221127182254.4850-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124212114.136863-8-sj@kernel.org>
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

On Thu, 24 Nov 2022 21:21:10 +0000 SeongJae Park <sj@kernel.org> wrote:

> Implement 'nr_filters' file under 'filters' directory, which will be
> used to populate specific number of 'filter' directory under the
> directory, similar to other 'nr_*' files in DAMON sysfs interface.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs-schemes.c | 67 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index afbfc55a8e84..7f2bab617156 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[...]
> @@ -401,6 +407,57 @@ damon_sysfs_scheme_filters_alloc(void)
>  	return kzalloc(sizeof(struct damon_sysfs_scheme_filters), GFP_KERNEL);
>  }
>  
> +static void damon_sysfs_scheme_filters_rm_dirs(
> +		struct damon_sysfs_scheme_filters *filters)
> +{
> +	struct damon_sysfs_scheme_filter **filters_arr = filters->filters_arr;
> +	int i;
> +
> +	for (i = 0; i < filters->nr; i++)
> +		kobject_put(&filters_arr[i]->kobj);
> +	filters->nr = 0;
> +	kfree(filters_arr);
> +	filters->filters_arr = NULL;
> +}

This function should also be called from damon_Sysfs_scheme_rm_dirs() but this
patch is missing that.  This could result in undeleted filters directory when
writing 0 to 'nr_schemes' file.  Next version of this patchset will fix that.


Thanks,
SJ

[...]
