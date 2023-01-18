Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994DE671E52
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjARNrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjARNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:46:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21830B28
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:16:44 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NxmSn0FNRzRrff;
        Wed, 18 Jan 2023 21:14:49 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 21:16:41 +0800
Subject: Re: [dm-devel] [PATCH] dm: remove unnecessary check when using
 dm_get_mdptr()
To:     Hou Tao <houtao@huaweicloud.com>, <dm-devel@redhat.com>
CC:     Mike Snitzer <snitzer@kernel.org>, <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>
References: <20221216042353.3132139-1-houtao@huaweicloud.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <e7fcd9fd-a882-2a97-a072-faf09441efbe@huawei.com>
Date:   Wed, 18 Jan 2023 21:16:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221216042353.3132139-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?

On 12/16/2022 12:23 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> __hash_remove() removes hash_cell with _hash_lock locked, so acquiring
> _hash_lock can guarantee no-NULL hc returned from dm_get_mdptr() must
> have not been removed and hc->md must still be md.
>
> __hash_remove() also acquires dm_hash_cells_mutex before setting mdptr
> as NULL, so in dm_copy_name_and_uuid() after acquiring
> dm_hash_cells_mutex and ensuring returned hc is not NULL, the returned
> hc must still be alive and hc->md must still be md.
>
> So removing these unnecessary hc->md != md checks when using
> dm_get_mdptr() with _hash_lock or dm_hash_cells_mutex acquired.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  drivers/md/dm-ioctl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> index 3bfc1583c20a..2a86524661d1 100644
> --- a/drivers/md/dm-ioctl.c
> +++ b/drivers/md/dm-ioctl.c
> @@ -772,7 +772,7 @@ static struct dm_table *dm_get_inactive_table(struct mapped_device *md, int *src
>  
>  	down_read(&_hash_lock);
>  	hc = dm_get_mdptr(md);
> -	if (!hc || hc->md != md) {
> +	if (!hc) {
>  		DMERR("device has been removed from the dev hash table.");
>  		goto out;
>  	}
> @@ -1476,7 +1476,7 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
>  	/* stage inactive table */
>  	down_write(&_hash_lock);
>  	hc = dm_get_mdptr(md);
> -	if (!hc || hc->md != md) {
> +	if (!hc) {
>  		DMERR("device has been removed from the dev hash table.");
>  		up_write(&_hash_lock);
>  		r = -ENXIO;
> @@ -2128,7 +2128,7 @@ int dm_copy_name_and_uuid(struct mapped_device *md, char *name, char *uuid)
>  
>  	mutex_lock(&dm_hash_cells_mutex);
>  	hc = dm_get_mdptr(md);
> -	if (!hc || hc->md != md) {
> +	if (!hc) {
>  		r = -ENXIO;
>  		goto out;
>  	}

