Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C3D7193E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjFAHGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjFAHGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:06:40 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB45EE7;
        Thu,  1 Jun 2023 00:06:38 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aef03.dynamic.kabel-deutschland.de [95.90.239.3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 09CC261E4052B;
        Thu,  1 Jun 2023 09:06:05 +0200 (CEST)
Message-ID: <2e36d874-4dd3-080c-3499-44f2f09b9169@molgen.mpg.de>
Date:   Thu, 1 Jun 2023 09:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/2] md/raid10: fix incorrect done of recovery
To:     linan666@huaweicloud.com
Cc:     song@kernel.org, neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
References: <20230601062424.3613218-1-linan666@huaweicloud.com>
 <20230601062424.3613218-2-linan666@huaweicloud.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230601062424.3613218-2-linan666@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Li,


Thank you for your patch.

Am 01.06.23 um 08:24 schrieb linan666@huaweicloud.com:
> From: Li Nan <linan122@huawei.com>

Unfortunately, I do not understand your commit message summary “fix 
incorrect done of recovery”. Maybe:

Do not add sparse disk when recovery aborts

> In raid10_sync_request(), if data cannot be read from any disk for
> recovery, it will go to 'giveup' and let 'chunks_skipped' + 1. After
> multiple 'giveup', when 'chunks_skipped >= geo.raid_disks', it will
> return 'max_sector', indicating that the recovery has been completed.
> However, the recovery is just aborted and the data remains inconsistent.
> 
> Fix it by setting mirror->recovery_disabled, which will prevent the spare
> disk from being added to this mirror. The same issue also exists during
> resync, it will be fixed afterwards.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   drivers/md/raid10.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index d93d8cb2b620..3ba1516ea160 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3303,6 +3303,7 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   	int chunks_skipped = 0;
>   	sector_t chunk_mask = conf->geo.chunk_mask;
>   	int page_idx = 0;
> +	int error_disk = -1;
>   
>   	/*
>   	 * Allow skipping a full rebuild for incremental assembly
> @@ -3386,7 +3387,20 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   		return reshape_request(mddev, sector_nr, skipped);
>   
>   	if (chunks_skipped >= conf->geo.raid_disks) {
> -		/* if there has been nothing to do on any drive,
> +		pr_err("md/raid10:%s: %s fail\n", mdname(mddev),
> +			test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ?  "resync" : "recovery");
> +		if (error_disk >= 0 &&
> +		    !test_bit(MD_RECOVERY_SYNC, &mddev->recovery)) {
> +			/*
> +			 * recovery fail, set mirrors.recovory_disabled,

recov*e*ry

> +			 * device shouldn't be added to there.
> +			 */
> +			conf->mirrors[error_disk].recovery_disabled =
> +						mddev->recovery_disabled;
> +			return 0;
> +		}
> +		/*
> +		 * if there has been nothing to do on any drive,
>   		 * then there is nothing to do at all..

Just one dot/period at the end?

>   		 */
>   		*skipped = 1;
> @@ -3638,6 +3652,8 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
>   						       mdname(mddev));
>   					mirror->recovery_disabled
>   						= mddev->recovery_disabled;
> +				} else {
> +					error_disk = i;
>   				}
>   				put_buf(r10_bio);
>   				if (rb2)


Kind regards,

Paul
