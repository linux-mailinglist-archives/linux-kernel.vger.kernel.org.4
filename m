Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F18262CD24
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiKPVvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiKPVuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:50:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85B060E8A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668635326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gb7j/bSfwmKBgntX+bLM9T0km8Jf8pYUeq23+M2C16M=;
        b=Aff1n23XJKXDq3EKYvR2LALloKM8RInvIfgpiSp0iBN5tHXZD5ri06oc6ZzBxz4dKIBpK6
        8zKLhWzbLW7J7r0Keo796TqG0isUju0vpv+jKeffqaI+IMHTlJZkKq1KWVU8+j4GNde/M6
        gSjzDRVCyjvJRhYC56/BGXFTwsnNkqE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-368-IgkKz6kdNHKRLhowWtkiuQ-1; Wed, 16 Nov 2022 16:48:44 -0500
X-MC-Unique: IgkKz6kdNHKRLhowWtkiuQ-1
Received: by mail-qk1-f200.google.com with SMTP id u5-20020a05620a0c4500b006fb30780443so16679185qki.22
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb7j/bSfwmKBgntX+bLM9T0km8Jf8pYUeq23+M2C16M=;
        b=QlcMRA3OPMHkCrJmxknaf1NqRfNIv+SPV7z+h5H5v7jnl6gHSTKtk3b9+klpO6B2rr
         BrFgXzVFSI/CqJsKS2xgNw6/gPjXu2FrC7dQ289FMjf6tcvXTzuPy6RFTASVHZ4l6YjF
         7h2XEdNiqi48Xi7OqyG7iSEVQj1nJFS2ZbLe/jWKkwwGxcg00l0K1i4rw276OIg+oXxO
         1TNO22rX9zRW6Do4HWB9FJ8GHhAGhaCWgFLctQ1M8gOhJY0mj7ep6oPkzGDE/Zx++BeU
         OFxDv9Lx2JM12SWrlMlODZMV68l2AqAwXJZCl2+vh3esyvT96E1+VoBfxOpho1hVHw8T
         508g==
X-Gm-Message-State: ANoB5pnRlvq6kOtNv3sZuQ0AY18a+pTHiHaqDdVvTTAPEDxpIb/bHFKv
        aUggWza4GeHg4rprX8T6b5JApesPD3Uf0TWNy+bSbVXkBx0vY335qUSTulf0RsKusiRRguGc/3+
        IFGszixm3LUpgiL/qPKYmFsg=
X-Received: by 2002:ae9:ef0c:0:b0:6ea:8eb4:3898 with SMTP id d12-20020ae9ef0c000000b006ea8eb43898mr21421444qkg.588.1668635324215;
        Wed, 16 Nov 2022 13:48:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7qRR7lyPfh1G9FP29Lbv7v+knDVgTkc535wRE4ZJ7VapZ3sEbuHbJgrTLOn4ZuOtuRz4HoJw==
X-Received: by 2002:ae9:ef0c:0:b0:6ea:8eb4:3898 with SMTP id d12-20020ae9ef0c000000b006ea8eb43898mr21421434qkg.588.1668635323996;
        Wed, 16 Nov 2022 13:48:43 -0800 (PST)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id e7-20020a05622a110700b0038b684a1642sm9385264qty.32.2022.11.16.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:48:43 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:48:42 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH RFC v3 05/10] dm: make sure create and remove dm device
 won't race with open and close table
Message-ID: <Y3VaunS49xJvHflm@redhat.com>
References: <20221115141054.1051801-1-yukuai1@huaweicloud.com>
 <20221115141054.1051801-6-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115141054.1051801-6-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15 2022 at  9:10P -0500,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> From: Yu Kuai <yukuai3@huawei.com>
> 
> open_table_device() and close_table_device() is protected by
> table_devices_lock, hence use it to protect add_disk() and
> del_gendisk().
> 
> Prepare to track per-add_disk holder relations in dm.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/dm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 2917700b1e15..3728b56b364b 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1952,7 +1952,14 @@ static void cleanup_mapped_device(struct mapped_device *md)
>  		spin_unlock(&_minor_lock);
>  		if (dm_get_md_type(md) != DM_TYPE_NONE) {
>  			dm_sysfs_exit(md);
> +
> +			/*
> +			 * Hold lock to make sure del_gendisk() won't concurrent
> +			 * with open/close_table_device().
> +			 */
> +			mutex_lock(&md->table_devices_lock);
>  			del_gendisk(md->disk);
> +			mutex_unlock(&md->table_devices_lock);
>  		}
>  		dm_queue_destroy_crypto_profile(md->queue);
>  		put_disk(md->disk);
> @@ -2312,15 +2319,24 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
>  	if (r)
>  		return r;
>  
> +	/*
> +	 * Hold lock to make sure add_disk() and del_gendisk() won't concurrent
> +	 * with open_table_device() and close_table_device().
> +	 */
> +	mutex_lock(&md->table_devices_lock);
>  	r = add_disk(md->disk);
> +	mutex_unlock(&md->table_devices_lock);
>  	if (r)
>  		return r;
>  
>  	r = dm_sysfs_init(md);
>  	if (r) {
> +		mutex_lock(&md->table_devices_lock);
>  		del_gendisk(md->disk);
> +		mutex_unlock(&md->table_devices_lock);
>  		return r;
>  	}
> +
>  	md->type = type;
>  	return 0;
>  }
> -- 
> 2.31.1
> 

In the new comments added: s/concurrent/race/ ?

But otherwise:

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

