Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35106C08FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCTCo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCTCo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:44:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B870C10EA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 19:44:55 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PfzWv0nVnzSkgs;
        Mon, 20 Mar 2023 10:41:31 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 10:44:52 +0800
Subject: Re: [PATCH] mtd: ubi: eba.c: fix return value overwrite issue in
 try_write_vid_and_data()
To:     Wang YanQing <udknight@gmail.com>, <miquel.raynal@bootlin.com>,
        <bbrezillon@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230217165442.GA28288@udknight>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <8fbae9fa-f61b-e951-6a13-0629e458c48e@huawei.com>
Date:   Mon, 20 Mar 2023 10:44:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230217165442.GA28288@udknight>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch. Maybe many of history happened unconsistent ubifs images 
have related to this point. One small nit below.

> The commit 2d78aee426d8 ("UBI: simplify LEB write and atomic LEB change code")
> adds helper function, try_write_vid_and_data(), to simplify the code, but this
> helper function has bug, it will return 0 (success) when ubi_io_write_vid_hdr()
> or the ubi_io_write_data() return error number (-EIO, etc), because the return
> value of ubi_wl_put_peb() will overwrite the original return value.
> 
> This issue will cause unexpected data loss issue, because the caller of this
> function and UBIFS willn't know the data is lost.
> 
> Fixes: 2d78aee426d8 ("UBI: simplify LEB write and atomic LEB change code")
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>   drivers/mtd/ubi/eba.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
> index 09c408c..4e32b25 100644
> --- a/drivers/mtd/ubi/eba.c
> +++ b/drivers/mtd/ubi/eba.c
> @@ -981,10 +981,17 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
>   out_put:
>   	up_read(&ubi->fm_eba_sem);
>   
> -	if (err && pnum >= 0)
> -		err = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
> -	else if (!err && opnum >= 0)
> -		err = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
> +	if (err && pnum >= 0) {
> +		if (ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1) != 0) {

Could we also add error code returned from ubi_wl_put_peb() in warning 
message? Same with next ubifs_warn.
> +			ubi_warn(ubi, "failed to return physical eraseblock %d",
> +				 pnum);
> +		}
> +	} else if (!err && opnum >= 0) {
> +		if (ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0) != 0) {
> +			ubi_warn(ubi, "failed to return physical eraseblock %d",
> +				 opnum);
> +		}
> +	}
>   
>   	return err;
>   }
> 



