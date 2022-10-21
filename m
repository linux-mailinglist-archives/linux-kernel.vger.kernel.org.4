Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D29607858
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiJUNZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJUNYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:24:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABAC34DD8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:24:52 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mv4rJ5tjCzJn1g;
        Fri, 21 Oct 2022 21:22:08 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 21:24:50 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 21:24:49 +0800
Subject: Re: [PATCH 2/2] ubi: Fix unreferenced object reported by kmemleak in
 ubi_resize_volume()
To:     Li Zetao <lizetao1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <dedekind@linutronix.de>, <haver@vnet.ibm.com>,
        <bbrezillon@kernel.org>
CC:     <boris.brezillon@free-electrons.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20221021102157.1341807-1-lizetao1@huawei.com>
 <20221021102157.1341807-3-lizetao1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9e6e3ed0-6709-320f-49b2-3e1056699647@huawei.com>
Date:   Fri, 21 Oct 2022 21:24:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20221021102157.1341807-3-lizetao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
> There is a memory leaks problem reported by kmemleak:
>
> unreferenced object 0xffff888102007a00 (size 128):
>    comm "ubirsvol", pid 32090, jiffies 4298464136 (age 2361.231s)
>    hex dump (first 32 bytes):
> ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>    backtrace:
> [<ffffffff8176cecd>] __kmalloc+0x4d/0x150
> [<ffffffffa02a9a36>] ubi_eba_create_table+0x76/0x170 [ubi]
> [<ffffffffa029764e>] ubi_resize_volume+0x1be/0xbc0 [ubi]
> [<ffffffffa02a3321>] ubi_cdev_ioctl+0x701/0x1850 [ubi]
> [<ffffffff81975d2d>] __x64_sys_ioctl+0x11d/0x170
> [<ffffffff83c142a5>] do_syscall_64+0x35/0x80
> [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> This is due to a mismatch between create and destroy interfaces, and
> in detail that "new_eba_tbl" created by ubi_eba_create_table() but
> destroyed by kfree(), while will causing "new_eba_tbl->entries" not
> freed.
>
> Fix it by replacing kfree(new_eba_tbl) with
> ubi_eba_destroy_table(new_eba_tbl)
>
> Fixes: 799dca34ac54 ("UBI: hide EBA internals")
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   drivers/mtd/ubi/vmt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
> index 74637575346e..9fbc64b997ce 100644
> --- a/drivers/mtd/ubi/vmt.c
> +++ b/drivers/mtd/ubi/vmt.c
> @@ -515,7 +515,7 @@ int ubi_resize_volume(struct ubi_volume_desc *desc, int reserved_pebs)
>   	return err;
>   
>   out_free:
> -	kfree(new_eba_tbl);
> +	ubi_eba_destroy_table(new_eba_tbl);
>   	return err;
>   }
>   

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

