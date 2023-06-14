Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D2072F645
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbjFNH1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243696AbjFNHZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD62C268C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686727487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCVjUpCiaki4fcM43NzRGyadlOcYPcJBZy9bfHP7iJM=;
        b=BizKCsGLF9tWyC7lB6V3J6WYwTmwBYz4jA/6UeJBuvs1ecOfQ9OChcIo3Rtdk3v83+sGWA
        w9iBPAXMOTWIQV8I6L8pI3rfAl/mIef8eTiv0fFp9OIokNt8MRCdInqQMKt6c8dLrIDYA4
        K/tv/sdh6O4jrPyv2h/RRBykjGKXxdM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-9ubG4J51PD-0sSC72BMXLg-1; Wed, 14 Jun 2023 03:24:34 -0400
X-MC-Unique: 9ubG4J51PD-0sSC72BMXLg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-25e229aec3dso154641a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686727473; x=1689319473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pCVjUpCiaki4fcM43NzRGyadlOcYPcJBZy9bfHP7iJM=;
        b=agAKtZleHB1/zz0CVh8uPk+79FCsN0tsUycyaLRJxH8yLvld4nmxbXlHA3ejsIg0i7
         TNpwEsYPoxd6hHZ+8U1XSwgqQYyMBY9iUyn+8GPSgxLFZimA/tVah7R+wTs0QdP8NdMs
         yrCPflj8/ML1BVfqRhF7KIOZdq5Iwcoc0hL0Kz+kVcZLgR/AiGk8IZbYwgI5kiC6T2CO
         3Tms1oCaKXhLgcraRarGRH/fRdVNKIrQo52RiCZtFb9LThZvLvt5vrFXRfDH1c1QgCAp
         ny/gjvSJYBuQrjRoxtCOYcKJTsf44x4N/4tuPNBX0xqpZRskAkLbwbDC6MnAawqi1wqi
         6gOQ==
X-Gm-Message-State: AC+VfDwGLsnsqUL+y8XJNV6rnkTqHAVn/I2eNWp5815GLw9lItW0ghBQ
        4JQPXaJ/KMQlI/O/RK3l3mAsZIU+aEP5/Dl1Q3sbItjMeCA/ctsKHoZoUg7cnoW4er7wmUImyVJ
        dFw3xQYi48AVvMu2m76xwRWtQ51xONijagpac9A==
X-Received: by 2002:a17:90a:668f:b0:256:5637:2b30 with SMTP id m15-20020a17090a668f00b0025656372b30mr566756pjj.40.1686727473320;
        Wed, 14 Jun 2023 00:24:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7EPJjztLMyL9Tzcno6Zl5Y5jx5gQ+t9tCC5omV1ac4iYoqRpze/H9csdp7PFs0QWTEfbOY0w==
X-Received: by 2002:a17:90a:668f:b0:256:5637:2b30 with SMTP id m15-20020a17090a668f00b0025656372b30mr566748pjj.40.1686727472996;
        Wed, 14 Jun 2023 00:24:32 -0700 (PDT)
Received: from [10.72.13.126] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k65-20020a17090a4cc700b0025bf64ac0besm4465972pjh.55.2023.06.14.00.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 00:24:32 -0700 (PDT)
Message-ID: <d5407a0d-f97b-ce31-9319-911695f2e5e8@redhat.com>
Date:   Wed, 14 Jun 2023 15:24:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [dm-devel] [PATCH -next v2 6/6] md: enhance checking in
 md_check_recovery()
To:     Yu Kuai <yukuai1@huaweicloud.com>, guoqing.jiang@linux.dev,
        agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org
Cc:     yi.zhang@huawei.com, yangerkun@huawei.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-7-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
In-Reply-To: <20230529132037.2124527-7-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/29 下午9:20, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
>
> For md_check_recovery():
>
> 1) if 'MD_RECOVERY_RUNING' is not set, register new sync_thread.
> 2) if 'MD_RECOVERY_RUNING' is set:
>   a) if 'MD_RECOVERY_DONE' is not set, don't do anything, wait for
>     md_do_sync() to be done.
>   b) if 'MD_RECOVERY_DONE' is set, unregister sync_thread. Current code
>     expects that sync_thread is not NULL, otherwise new sync_thread will
>     be registered, which will corrupt the array.
>
> Make sure md_check_recovery() won't register new sync_thread if
> 'MD_RECOVERY_RUNING' is still set, and a new WARN_ON_ONCE() is added for
> the above corruption,
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index f90226e6ddf8..9da0fc906bbd 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9397,16 +9397,24 @@ void md_check_recovery(struct mddev *mddev)
>   		if (mddev->sb_flags)
>   			md_update_sb(mddev, 0);
>   
> -		if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
> -		    !test_bit(MD_RECOVERY_DONE, &mddev->recovery)) {
> -			/* resync/recovery still happening */
> -			clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> -			goto unlock;
> -		}
> -		if (mddev->sync_thread) {
> +		/*
> +		 * Never start a new sync thread if MD_RECOVERY_RUNNING is
> +		 * still set.
> +		 */
> +		if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
> +			if (!test_bit(MD_RECOVERY_DONE, &mddev->recovery)) {
> +				/* resync/recovery still happening */
> +				clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> +				goto unlock;
> +			}
> +
> +			if (WARN_ON_ONCE(!mddev->sync_thread))
> +				goto unlock;
> +
>   			md_reap_sync_thread(mddev);
>   			goto unlock;
>   		}
> +
>   		/* Set RUNNING before clearing NEEDED to avoid
>   		 * any transients in the value of "sync_action".
>   		 */

It makes the logical more clear.

Reviewed-by: Xiao Ni <xni@redhat.com>

