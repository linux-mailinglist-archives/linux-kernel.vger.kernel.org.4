Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5896CCF4B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjC2BOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2BOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:14:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A126CCE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:14:20 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PmT5L4xL9zgZQS;
        Wed, 29 Mar 2023 09:11:02 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 09:14:17 +0800
Subject: Re: [PATCH v2] mtd: ubi: eba.c: fix return value overwrite issue in
 try_write_vid_and_data()
To:     Wang YanQing <udknight@gmail.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <bbrezillon@kernel.org>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230328153534.GA12409@udknight>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <8f312163-f809-9271-3f1d-792d23d1bdfa@huawei.com>
Date:   Wed, 29 Mar 2023 09:14:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230328153534.GA12409@udknight>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
>   Changes v1-v2:
>   1: add error code in warning message, suggested by Zhihao Cheng
>   
>   drivers/mtd/ubi/eba.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
> index 09c408c..4e1d807 100644
> --- a/drivers/mtd/ubi/eba.c
> +++ b/drivers/mtd/ubi/eba.c
> @@ -946,7 +946,7 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
>   				  int offset, int len)
>   {
>   	struct ubi_device *ubi = vol->ubi;
> -	int pnum, opnum, err, vol_id = vol->vol_id;
> +	int pnum, opnum, err, err2, vol_id = vol->vol_id;
>   
>   	pnum = ubi_wl_get_peb(ubi);
>   	if (pnum < 0) {
> @@ -981,10 +981,19 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
>   out_put:
>   	up_read(&ubi->fm_eba_sem);
>   
> -	if (err && pnum >= 0)
> -		err = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
> -	else if (!err && opnum >= 0)
> -		err = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
> +	if (err && pnum >= 0) {
> +		err2 = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
> +		if (err2) {
> +			ubi_warn(ubi, "failed to return physical eraseblock %d, error %d",
> +				 pnum, err2);
> +		}
> +	} else if (!err && opnum >= 0) {
> +		err2 = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
> +		if (err2) {
> +			ubi_warn(ubi, "failed to return physical eraseblock %d, error %d",
> +				 opnum, err2);
> +		}
> +	}
>   
>   	return err;
>   }
> 

