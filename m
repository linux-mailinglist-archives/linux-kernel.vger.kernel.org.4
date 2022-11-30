Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286E463E0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiK3T0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3T0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:26:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82838565E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 11:26:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 638D0B81CB8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3069C433C1;
        Wed, 30 Nov 2022 19:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669836398;
        bh=5LR5nZNtSi/Kxu1y5TcusuYTtmflF/F58GD4wz8A6tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SREZe5jdo0z5QVLSdrd5b0OVFXg61U4/Toe+uHLqAu5+dhjXGqEcvPpu5Bf5uzF2f
         ejG8HkfnDf60Z5/pj8/h6WGr1ajfx6psmvzyv9J7XaH53zaa+ZDnVh8morJRd8r6Gj
         qT9OPkWumBDYRPx1esRxs+bpOlnEsUGnsWTfzbRpeY3IinzZTKE1d09QKFdKWCAPNt
         6ao2pdaLZSgdULhCDyCZWVKdw2nL2I7XPvHOT6MfwiG2fZjncbIadndltZhYrgOv1G
         NsokxYq/ch394MEBS93KP2g/mpcWauv3KfJ7PTrWmLg6IKeUYOuR8rbHM0iDv57eFw
         daF7L8MIHjN/A==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/11] mm/damon/sysfs-schemes: implement scheme filters
Date:   Wed, 30 Nov 2022 19:26:36 +0000
Message-Id: <20221130192636.116555-1-sj@kernel.org>
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
> +static int damon_sysfs_memcg_path_to_id(char *memcg_path, unsigned short *id)
> +{
> +	struct mem_cgroup *memcg;
> +	char *path;
> +
> +	if (!memcg_path)
> +		return -EINVAL;
> +
> +	path = kmalloc(sizeof(*path) * PATH_MAX, GFP_KERNEL);
> +	if (!path)
> +		return -ENOMEM;
> +
> +	for (memcg = mem_cgroup_iter(NULL, NULL, NULL); memcg;
> +			memcg = mem_cgroup_iter(NULL, memcg, NULL)) {
> +		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
> +			*id = mem_cgroup_id(memcg);

Forgot mentioning this.  Removed memcgs can still be iterated, so this can
result in getting id of already removed cgroup.  If the user input is valid but
there is a removed memcg that has same path, this could be confused.

Removed memcg would have id 0.  The next version of this will handle the case.


Thanks,
SJ

> +			break;
> +		}
> +	}
> +
> +	kfree(path);
> +	return 0;
> +}
