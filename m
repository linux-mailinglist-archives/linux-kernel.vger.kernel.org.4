Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAED26AA79C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 03:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCDCci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 21:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDCcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 21:32:36 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC6A664F7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 18:32:09 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PT81G5XW1z16NjP;
        Sat,  4 Mar 2023 10:29:22 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 4 Mar 2023 10:32:04 +0800
Subject: Re: [PATCH] ubi: Fix deadlock caused by recursively holding work_sem
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230304014141.2099204-1-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <2d3b033a-5329-be95-fe38-2cceb17b9014@huawei.com>
Date:   Sat, 4 Mar 2023 10:32:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230304014141.2099204-1-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> During the processing of the bgt, if the sync_erase() return -EBUSY
> or some other error code in __erase_worker(),schedule_erase() called
> again lead to the down_read(ubi->work_sem) hold twice and may get
> block by down_write(ubi->work_sem) in ubi_update_fastmap(),
> which cause deadlock.
> 
>            ubi bgt                        other task
>   do_work
>    down_read(&ubi->work_sem)          ubi_update_fastmap
>    erase_worker                         # Blocked by down_read
>     __erase_worker                      down_write(&ubi->work_sem)
>      schedule_erase
>       schedule_ubi_work
>        down_read(&ubi->work_sem)
> 
> Fix this by changing input parameter @nested of the schedule_erase() to
> 'true' to avoid recursively acquiring the down_read(&ubi->work_sem).
> 
> Also, fix the incorrect comment about @nested parameter of the
> schedule_erase() because when down_write(ubi->work_sem) is held, the
> @nested is also need be true.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217093
> Fixes: 2e8f08deabbc ("ubi: Fix races around ubi_refill_pools()")
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/ubi/wl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
> index 40f39e5d6dfc..26a214f016c1 100644
> --- a/drivers/mtd/ubi/wl.c
> +++ b/drivers/mtd/ubi/wl.c
> @@ -575,7 +575,7 @@ static int erase_worker(struct ubi_device *ubi, struct ubi_work *wl_wrk,
>    * @vol_id: the volume ID that last used this PEB
>    * @lnum: the last used logical eraseblock number for the PEB
>    * @torture: if the physical eraseblock has to be tortured
> - * @nested: denotes whether the work_sem is already held in read mode
> + * @nested: denotes whether the work_sem is already held
>    *
>    * This function returns zero in case of success and a %-ENOMEM in case of
>    * failure.
> @@ -1131,7 +1131,7 @@ static int __erase_worker(struct ubi_device *ubi, struct ubi_work *wl_wrk)
>   		int err1;
>   
>   		/* Re-schedule the LEB for erasure */
> -		err1 = schedule_erase(ubi, e, vol_id, lnum, 0, false);
> +		err1 = schedule_erase(ubi, e, vol_id, lnum, 0, true);
>   		if (err1) {
>   			spin_lock(&ubi->wl_lock);
>   			wl_entry_destroy(ubi, e);
> 

