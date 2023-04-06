Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C4F6D9672
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbjDFL4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238791AbjDFLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:55:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048C89EE8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:52:29 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Psfvq2xtWzrS37;
        Thu,  6 Apr 2023 19:50:47 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Apr 2023 19:52:03 +0800
Subject: Re: [PATCH 2/2] ubi: Correct the number of PEBs after a volume resize
 failure
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230406071331.1247429-1-wangzhaolong1@huawei.com>
 <20230406071331.1247429-3-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <a7de7544-7e81-587f-6d84-5cb2774c6c14@huawei.com>
Date:   Thu, 6 Apr 2023 19:52:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230406071331.1247429-3-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the error handing path `out_acc` of the ubi_resize_volume(),
> when `pebs < 0`, it means that the volume table record fails to be
> updated when the volume is shrinked. In this case, the number of
> ubi->avail_pebs` and `ubi->rsvd_pebs` should also be restored,
> otherwise the UBI will display an incorrect number of available PEBs.
> 
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> ---
>   drivers/mtd/ubi/vmt.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> index 97294def01eb..990571287e84 100644
> --- a/drivers/mtd/ubi/vmt.c
> +++ b/drivers/mtd/ubi/vmt.c
> @@ -515,13 +515,12 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
>   out_acc:
>   	spin_lock(&ubi->volumes_lock);
>   	vol->reserved_pebs = reserved_pebs - pebs;
> -	if (pebs > 0) {
> -		ubi->rsvd_pebs -= pebs;
> -		ubi->avail_pebs += pebs;
> +	ubi->rsvd_pebs -= pebs;
> +	ubi->avail_pebs += pebs;
> +	if (pebs > 0)
>   		ubi_eba_copy_table(vol, old_eba_tbl, vol->reserved_pebs);
> -	} else {
> +	else
>   		ubi_eba_copy_table(vol, old_eba_tbl, reserved_pebs);
> -	}
>   	vol->eba_tbl = old_eba_tbl;
>   	spin_unlock(&ubi->volumes_lock);
>   out_free:
> 

