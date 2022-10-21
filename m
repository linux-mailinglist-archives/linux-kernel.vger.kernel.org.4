Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94594607850
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiJUNYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJUNYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:24:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EE02700E4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:24:09 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mv4n50q9HzmV8R;
        Fri, 21 Oct 2022 21:19:21 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 21:24:07 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 21:24:06 +0800
Subject: Re: [PATCH 1/2] ubi: Fix use-after-free when volume resizing failed
To:     Li Zetao <lizetao1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <dedekind@linutronix.de>, <haver@vnet.ibm.com>,
        <bbrezillon@kernel.org>
CC:     <boris.brezillon@free-electrons.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20221021102157.1341807-1-lizetao1@huawei.com>
 <20221021102157.1341807-2-lizetao1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <017d217a-5497-2627-afe3-c3c4ef70723a@huawei.com>
Date:   Fri, 21 Oct 2022 21:24:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20221021102157.1341807-2-lizetao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

ÔÚ 2022/10/21 18:21, Li Zetao Ð´µÀ:
> There is an use-after-free problem reported by KASAN:
>    ==================================================================
>    BUG: KASAN: use-after-free in ubi_eba_copy_table+0x11f/0x1c0 [ubi]
>    Read of size 8 at addr ffff888101eec008 by task ubirsvol/4735
>
>    CPU: 2 PID: 4735 Comm: ubirsvol
>    Not tainted 6.1.0-rc1-00003-g84fa3304a7fc-dirty #14
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>    BIOS 1.14.0-1.fc33 04/01/2014
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x34/0x44
>     print_report+0x171/0x472
>     kasan_report+0xad/0x130
>     ubi_eba_copy_table+0x11f/0x1c0 [ubi]
>     ubi_resize_volume+0x4f9/0xbc0 [ubi]
>     ubi_cdev_ioctl+0x701/0x1850 [ubi]
>     __x64_sys_ioctl+0x11d/0x170
>     do_syscall_64+0x35/0x80
>     entry_SYSCALL_64_after_hwframe+0x46/0xb0
>     </TASK>
>
> When ubi_change_vtbl_record() returns an error in ubi_resize_volume(),
> "new_eba_tbl" will be freed on error handing path, but it is holded
> by "vol->eba_tbl" in ubi_eba_replace_table(). It means that the liftcycle
> of "vol->eba_tbl" and "vol" are different, so when resizing volume in
> next time, it causing an use-after-free fault.
>
> Fix it by not freeing "new_eba_tbl" after it replaced in
> ubi_eba_replace_table(), while will be freed in next volume resizing.
>
> Fixes: 801c135ce73d ("UBI: Unsorted Block Images")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   drivers/mtd/ubi/vmt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> index 8fcc0bdf0635..74637575346e 100644
> --- a/drivers/mtd/ubi/vmt.c
> +++ b/drivers/mtd/ubi/vmt.c
> @@ -464,7 +464,7 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
>   		for (i = 0; i < -pebs; i++) {
>   			err = ubi_eba_unmap_leb(ubi, vol, reserved_pebs + i);
>   			if (err)
> -				goto out_acc;
> +				goto out_free;
>   		}
>   		spin_lock(&ubi->volumes_lock);
>   		ubi->rsvd_pebs += pebs;
> @@ -512,6 +512,8 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
>   		ubi->avail_pebs += pebs;
>   		spin_unlock(&ubi->volumes_lock);
>   	}
> +	return err;
> +
>   out_free:
>   	kfree(new_eba_tbl);
>   	return err;

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

