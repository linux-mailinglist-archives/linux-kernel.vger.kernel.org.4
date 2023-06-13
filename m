Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E3272DBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbjFMIET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbjFMIEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5329D1BF4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686643388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V2WAoXU2sO6i7ouZ+ltrXmzd4T/KwU8+agEZUhVJ2/A=;
        b=ickTAITODDrOK26altYURzBFHLg6v6uksNQvyX5zVveecCRfUIyAGxXSeG+e+h9NlaBCyr
        LcOkbddI6CFDVuYznSopO0/0lmwsF6kKcDBpe5bhWtYx2rAizyXO72hD8mkoDfEifAKqqA
        q+5F9xhENQRUvd91haOMzOGKE4IVqbs=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-qRKOn8XvMdmYpLX6mA9vwg-1; Tue, 13 Jun 2023 04:03:04 -0400
X-MC-Unique: qRKOn8XvMdmYpLX6mA9vwg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39cdf9f9d10so1155438b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686643384; x=1689235384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V2WAoXU2sO6i7ouZ+ltrXmzd4T/KwU8+agEZUhVJ2/A=;
        b=ghCfliT4E18TVSxScURaYPVR83Lfo5sd30C6b7FUo8j3jRbcwuKF+c13TN3K/wuS9B
         cD9FG4q5SJkcbx1BX5VXrLV0WbAOttxBtBQ+9gI/owLrqt3m24laSuEEL7KLAf9H8+FZ
         eXzP+0gwIJhA5+iy8Q0cdZluddca327he/nNTq0mIOyOw2zmUvqojOxA1biJWMxrpKrS
         VZ41LMVwO2C4gfpGcqGPpGxy3J7SruLBFSz8R0DLwArIEewRV1KvyXBC7wPQlG6lIy9X
         ioZsnM7133muDsnT7cjDHojEDMOSaETwtg1OurvY8jfyk6YaNpv5x7cot136APKdWME9
         nmMw==
X-Gm-Message-State: AC+VfDztmOUBObVMbNm2RlH6EcI6YJkZ7dKcuDFBUj+Vr0eDWzJmtjXX
        3PPJZYfj73waFzAUC5BeAkz5u2LkgBqhsSMY/zlzW1tMRPl/9FF/CbFQVX0LzGZIZ8OuU2kE4Tc
        8Bj0FNcIoYpFljkN2jktOXUBP
X-Received: by 2002:a05:6808:221c:b0:39a:5e92:f459 with SMTP id bd28-20020a056808221c00b0039a5e92f459mr7996118oib.38.1686643383905;
        Tue, 13 Jun 2023 01:03:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xUDHntHnuiUM8nQFbipVkqgakxXsx7HwJmcyUfwoHuTXrCOl6qzVaRfoSHzNgRHa7Z0rmLw==
X-Received: by 2002:a05:6808:221c:b0:39a:5e92:f459 with SMTP id bd28-20020a056808221c00b0039a5e92f459mr7996106oib.38.1686643383607;
        Tue, 13 Jun 2023 01:03:03 -0700 (PDT)
Received: from [10.72.13.126] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090a3d0d00b0025954958e06sm9336256pjc.18.2023.06.13.01.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:03:03 -0700 (PDT)
Message-ID: <b780ccfd-66b1-fdd1-b33e-aa680fbd86f1@redhat.com>
Date:   Tue, 13 Jun 2023 16:02:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [dm-devel] [PATCH -next v2 2/6] md: refactor action_store() for
 'idle' and 'frozen'
To:     Yu Kuai <yukuai1@huaweicloud.com>, guoqing.jiang@linux.dev,
        agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org
Cc:     yi.zhang@huawei.com, yangerkun@huawei.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-3-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
In-Reply-To: <20230529132037.2124527-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/29 下午9:20, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
>
> Prepare to handle 'idle' and 'frozen' differently to fix a deadlock, there
> are no functional changes except that MD_RECOVERY_RUNNING is checked
> again after 'reconfig_mutex' is held.


Can you explain more about why it needs to check MD_RECOVERY_RUNNING 
again here?

>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/md.c | 61 ++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 45 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 9b97731e1fe4..23e8e7eae062 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4755,6 +4755,46 @@ action_show(struct mddev *mddev, char *page)
>   	return sprintf(page, "%s\n", type);
>   }
>   
> +static void stop_sync_thread(struct mddev *mddev)
> +{
> +	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> +		return;
> +
> +	if (mddev_lock(mddev))
> +		return;
> +
> +	/*
> +	 * Check again in case MD_RECOVERY_RUNNING is cleared before lock is
> +	 * held.
> +	 */
> +	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
> +		mddev_unlock(mddev);
> +		return;
> +	}
> +
> +	if (work_pending(&mddev->del_work))
> +		flush_workqueue(md_misc_wq);
> +
> +	if (mddev->sync_thread) {
> +		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> +		md_reap_sync_thread(mddev);
> +	}
> +
> +	mddev_unlock(mddev);
> +}
> +
> +static void idle_sync_thread(struct mddev *mddev)
> +{
> +	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +	stop_sync_thread(mddev);
> +}
> +
> +static void frozen_sync_thread(struct mddev *mddev)
> +{
> +	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +	stop_sync_thread(mddev);
> +}
> +
>   static ssize_t
>   action_store(struct mddev *mddev, const char *page, size_t len)
>   {
> @@ -4762,22 +4802,11 @@ action_store(struct mddev *mddev, const char *page, size_t len)
>   		return -EINVAL;
>   
>   
> -	if (cmd_match(page, "idle") || cmd_match(page, "frozen")) {
> -		if (cmd_match(page, "frozen"))
> -			set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> -		else
> -			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> -		if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
> -		    mddev_lock(mddev) == 0) {
> -			if (work_pending(&mddev->del_work))
> -				flush_workqueue(md_misc_wq);
> -			if (mddev->sync_thread) {
> -				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -				md_reap_sync_thread(mddev);
> -			}
> -			mddev_unlock(mddev);
> -		}
> -	} else if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> +	if (cmd_match(page, "idle"))
> +		idle_sync_thread(mddev);
> +	else if (cmd_match(page, "frozen"))
> +		frozen_sync_thread(mddev);
> +	else if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
>   		return -EBUSY;
>   	else if (cmd_match(page, "resync"))
>   		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);

