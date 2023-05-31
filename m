Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA557172D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjEaBHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjEaBHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:07:00 -0400
Received: from out-37.mta1.migadu.com (out-37.mta1.migadu.com [IPv6:2001:41d0:203:375::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A129118
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:06:55 -0700 (PDT)
Message-ID: <b9fd7105-eadc-29cb-fa2e-24109f4a99b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685495212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktzBuz1Q0UcNMvPLJbCEC7kXeHrx4XPsgK/A+XpXcuU=;
        b=EJC9mR5IYtOEihQJMiQ3p2YVDC9buKhBp0eZPGkk3yxFbf4kkEOCXDSGcAJRdu0n1J0i6P
        6xyGMgnkya/qb9Jz5rYkkr8qo3zDR4AwSBhGe/zxv+xDAH3PndkF47zRMHjkXOIZdUll9/
        dc4EuVou47LGbuMJ5DyzQt5Ukc8NXaU=
Date:   Wed, 31 May 2023 09:06:47 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2] md/raid5: don't allow concurrent reshape with recovery
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org,
        pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230529133410.2125914-1-yukuai1@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20230529133410.2125914-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/23 21:34, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>
> Commit 0aecb06e2249 ("md/raid5: don't allow replacement while reshape
> is in progress") fixes that replacement can be set if reshape is
> interrupted, which will cause that array can't be assembled.
>
> There is a similar problem on the other side, if recovery is
> interrupted, then reshape can start, which will cause the same problem.
>
> Fix the problem by not starting to reshape while recovery is still in
> progress.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes in v2:
>   - fix some typo in commit message.
>
>   drivers/md/raid5.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 8686d629e3f2..6615abf54d3f 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -8525,6 +8525,7 @@ static int raid5_start_reshape(struct mddev *mddev)
>   	struct r5conf *conf = mddev->private;
>   	struct md_rdev *rdev;
>   	int spares = 0;
> +	int i;
>   	unsigned long flags;
>   
>   	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> @@ -8536,6 +8537,13 @@ static int raid5_start_reshape(struct mddev *mddev)
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

Does it mean reshape and recovery  can happen in parallel without the 
change?
I really doubt about it given any kind of internal io (resync, reshape 
and recovery)
is handled by resync thread. And IIUC either md_do_sync or md_check_recovery
should avoid it, no need to do it in personality layer.

Thanks,
Guoqing
