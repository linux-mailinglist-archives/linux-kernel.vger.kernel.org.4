Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7026C8754
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCXVNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCXVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:13:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FF446BD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:13:10 -0700 (PDT)
Received: from [192.168.10.39] (unknown [119.155.2.20])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E6490660206A;
        Fri, 24 Mar 2023 21:13:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679692389;
        bh=txaOnhLH2D4ccynBeXElhufAFanFILa3bH1kjnNZJZs=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=JDEQbwquT419PgvuTeM/GUJzyJ9wfI32yh38MsDe1BWnDpI9euwMvGNmXd32pk10x
         0qbJ4CDBKFSpSX62yN8dlQOD1FyHPjE9+y86tUm9+F2FrFwpXOPqmtjO/Yn9WzUM7k
         6BUhprovL1Av+YDtR/cAWzclrH+XmFQLn9Mbs4cXhf7b0qUgMV4r437skabiA5KL0o
         myjBLJZjo/02bkjRDweJ8d48cyMb0eenTr7OfJviYfXlRWxKJIp+Tw4icvdbG+jbt+
         Lmi4W47lDX8Z6vDxjW0/cQ7elNSDGgckYQZCKT8gL/YPS8V0juzb70A/N6ExKTpptW
         pPKkAANs5xPqQ==
Message-ID: <eab20109-ffa2-461c-92ff-3eec4fa5c8a8@collabora.com>
Date:   Sat, 25 Mar 2023 02:12:55 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: make more kobj_type structures constant
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230324-b4-kobj_type-damon2-v1-1-48ddbf1c8fcf@weissschuh.net>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230324-b4-kobj_type-damon2-v1-1-48ddbf1c8fcf@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/23 8:35 PM, Thomas Weißschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> These structures were not constified in
> commit e56397e8c40d ("mm/damon/sysfs: make kobj_type structures constant")
> as they didn't exist when that patch was written.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

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

-- 
BR,
Muhammad Usama Anjum
