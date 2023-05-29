Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F076714512
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjE2Go4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjE2Gox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:44:53 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA7190;
        Sun, 28 May 2023 23:44:50 -0700 (PDT)
Received: from [192.168.0.185] (unknown [95.90.238.95])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E30B961DFA908;
        Mon, 29 May 2023 08:44:04 +0200 (CEST)
Message-ID: <6074a7aa-bb9c-6803-dd94-bba208d47ba0@molgen.mpg.de>
Date:   Mon, 29 May 2023 08:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next] md/raid5: don't allow concurrent reshape with
 recovery
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230529031045.1760883-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230529031045.1760883-1-yukuai1@huaweicloud.com>
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

Dear Yu,


Thank you for your patch. As always some minor commons, you can also ignore.

Am 29.05.23 um 05:10 schrieb Yu Kuai:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> commit 0aecb06e2249 ("md/raid5: don't allow replacement while reshape

I’d start with a capital letter: Commit …

> is in progress") fix that replacement can be set if reshape is

fixes

> interrupted, which will cause that array can't be assemebled.

assembled

> There is a similar on the other side, if recovery is interrupted, then

similar *problem*?

> reshape can start, which will cause the same problem.
> 
> Fix the prblem by don't start reshape is recovery is still in progress.

•  problem
•  … by not starting to reshape while recovery is still in progress

> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid5.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 64865f9dd3f5..6db783ca71b7 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -8500,6 +8500,7 @@ static int raid5_start_reshape(struct mddev *mddev)
>   	struct r5conf *conf = mddev->private;
>   	struct md_rdev *rdev;
>   	int spares = 0;
> +	int i;

It won’t make a difference for the code I believe, but as the count 
variable can’t be negative, I’d use `unsigned int`.

>   	unsigned long flags;
>   
>   	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> @@ -8511,6 +8512,13 @@ static int raid5_start_reshape(struct mddev *mddev)
>   	if (has_failed(conf))
>   		return -EINVAL;
>   
> +	/* raid5 can't handle concurrent reshape and recovery */
> +	if (mddev->recovery_cp < MaxSector)
> +		return -EBUSY;
> +	for (i = 0; i < conf->raid_disks; i++)
> +		if (rdev_mdlock_deref(mddev, conf->disks[i].replacement))
> +			return -EBUSY;
> +
>   	rdev_for_each(rdev, mddev) {
>   		if (!test_bit(In_sync, &rdev->flags)
>   		    && !test_bit(Faulty, &rdev->flags))


Kind regards,

Paul
