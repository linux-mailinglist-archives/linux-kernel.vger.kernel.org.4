Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43D46B8BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCNHKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCNHKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:10:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77FF498AD;
        Tue, 14 Mar 2023 00:10:19 -0700 (PDT)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PbPjP2tr6z17Kmy;
        Tue, 14 Mar 2023 15:07:21 +0800 (CST)
Received: from [10.174.178.159] (10.174.178.159) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 15:10:16 +0800
Message-ID: <b191b5b0-1dd8-e36a-75b3-d47f0195ca48@huawei.com>
Date:   Tue, 14 Mar 2023 15:10:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH-next] nbd: fix incomplete validation of ioctl arg
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>, <houtao1@huawei.com>, <yangerkun@huawei.com>,
        Zhong Jinghua <zhongjinghua@huaweicloud.com>
References: <20230206145805.2645671-1-zhongjinghua@huawei.com>
From:   zhongjinghua <zhongjinghua@huawei.com>
In-Reply-To: <20230206145805.2645671-1-zhongjinghua@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.159]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

Hello

Anyone looking this？

在 2023/2/6 22:58, Zhong Jinghua 写道:
> We tested and found an alarm caused by nbd_ioctl arg without verification.
> The UBSAN warning calltrace like below:
>
> UBSAN: Undefined behaviour in fs/buffer.c:1709:35
> signed integer overflow:
> -9223372036854775808 - 1 cannot be represented in type 'long long int'
> CPU: 3 PID: 2523 Comm: syz-executor.0 Not tainted 4.19.90 #1
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>   dump_backtrace+0x0/0x3f0 arch/arm64/kernel/time.c:78
>   show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x170/0x1dc lib/dump_stack.c:118
>   ubsan_epilogue+0x18/0xb4 lib/ubsan.c:161
>   handle_overflow+0x188/0x1dc lib/ubsan.c:192
>   __ubsan_handle_sub_overflow+0x34/0x44 lib/ubsan.c:206
>   __block_write_full_page+0x94c/0xa20 fs/buffer.c:1709
>   block_write_full_page+0x1f0/0x280 fs/buffer.c:2934
>   blkdev_writepage+0x34/0x40 fs/block_dev.c:607
>   __writepage+0x68/0xe8 mm/page-writeback.c:2305
>   write_cache_pages+0x44c/0xc70 mm/page-writeback.c:2240
>   generic_writepages+0xdc/0x148 mm/page-writeback.c:2329
>   blkdev_writepages+0x2c/0x38 fs/block_dev.c:2114
>   do_writepages+0xd4/0x250 mm/page-writeback.c:2344
>
> The reason for triggering this warning is __block_write_full_page()
> -> i_size_read(inode) - 1 overflow.
> inode->i_size is assigned in __nbd_ioctl() -> nbd_set_size() -> bytesize.
> We think it is necessary to limit the size of arg to prevent errors.
>
> Moreover, __nbd_ioctl() -> nbd_add_socket(), arg will be cast to int.
> Assuming the value of arg is 0x80000000000000001) (on a 64-bit machine),
> it will become 1 after the coercion, which will return unexpected results.
>
> Fix it by adding checks to prevent passing in too large numbers.
>
> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
> ---
>   drivers/block/nbd.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 592cfa8b765a..e1c954094b6c 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -325,6 +325,9 @@ static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
>   	if (blk_validate_block_size(blksize))
>   		return -EINVAL;
>   
> +	if (bytesize < 0)
> +		return -EINVAL;
> +
>   	nbd->config->bytesize = bytesize;
>   	nbd->config->blksize_bits = __ffs(blksize);
>   
> @@ -1111,6 +1114,9 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>   	struct nbd_sock *nsock;
>   	int err;
>   
> +	/* Arg will be cast to int, check it to avoid overflow */
> +	if (arg > INT_MAX)
> +		return -EINVAL;
>   	sock = nbd_get_socket(nbd, arg, &err);
>   	if (!sock)
>   		return err;
