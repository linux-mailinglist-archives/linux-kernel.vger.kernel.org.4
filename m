Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177506C8264
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjCXQcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjCXQca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA11CF55
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:32:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24D9562BE1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C7FC433EF;
        Fri, 24 Mar 2023 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679675527;
        bh=3PNX/74+gO354UCpwGADQlXhZg6ETuvttetxAJdAwJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0WpNtnpJMAZoEKPRE9qYxgAzboyL6KYBJl/kiLSZfdRyb5QKxMQaHd1+6nbqsaro
         6lGu7JnxcTAU+F45eMpy4xfUzde82hmH3iun38YGfNOjfyxPxCgIg8YIcvYzVZEYKe
         G9H3Em5GY2TqMoSAt3rpACK693gKLpxLu0kmpDt8LsXGNVi4wJd174EYtU0SjG6GbP
         TmttDpoLg8ltbXfM2wUa54mJW13RN1PiOrtvy7HQZQeAyhes4/xDrVMgayULUAZ0BS
         dgSHP+YxXzVjdP3kS1+l3rjXEpvs6msE5XTcAR3Fe9GgoYKdJvYPfzNijbX7VrQSr2
         0OqXK8pBNdVrA==
From:   SeongJae Park <sj@kernel.org>
To:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: make more kobj_type structures constant
Date:   Fri, 24 Mar 2023 16:32:02 +0000
Message-Id: <20230324163202.47254-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324-b4-kobj_type-damon2-v1-1-48ddbf1c8fcf@weissschuh.net>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, 24 Mar 2023 15:35:27 +0000 "Thomas Weißschuh" <linux@weissschuh.net> wrote:

> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> These structures were not constified in
> commit e56397e8c40d ("mm/damon/sysfs: make kobj_type structures constant")
> as they didn't exist when that patch was written.

Thank you for catching this!

> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/sysfs-schemes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 3cdad5a7f936..50cf89dcd898 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -384,7 +384,7 @@ static struct attribute *damon_sysfs_scheme_filter_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(damon_sysfs_scheme_filter);
>  
> -static struct kobj_type damon_sysfs_scheme_filter_ktype = {
> +static const struct kobj_type damon_sysfs_scheme_filter_ktype = {
>  	.release = damon_sysfs_scheme_filter_release,
>  	.sysfs_ops = &kobj_sysfs_ops,
>  	.default_groups = damon_sysfs_scheme_filter_groups,
> @@ -503,7 +503,7 @@ static struct attribute *damon_sysfs_scheme_filters_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(damon_sysfs_scheme_filters);
>  
> -static struct kobj_type damon_sysfs_scheme_filters_ktype = {
> +static const struct kobj_type damon_sysfs_scheme_filters_ktype = {
>  	.release = damon_sysfs_scheme_filters_release,
>  	.sysfs_ops = &kobj_sysfs_ops,
>  	.default_groups = damon_sysfs_scheme_filters_groups,
> 
> ---
> base-commit: 1e760fa3596e8c7f08412712c168288b79670d78
> change-id: 20230324-b4-kobj_type-damon2-0238ee9e8d8c
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
