Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F356B8BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCNHLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCNHLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:11:18 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2FB92F2F;
        Tue, 14 Mar 2023 00:11:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PbPnq4TGzz4f3lwy;
        Tue, 14 Mar 2023 15:11:11 +0800 (CST)
Received: from [10.174.178.159] (unknown [10.174.178.159])
        by APP4 (Coremail) with SMTP id gCh0CgCH77IPHhBkO7JgFQ--.59685S3;
        Tue, 14 Mar 2023 15:11:13 +0800 (CST)
Message-ID: <1fa79465-e6c9-fb9e-3952-cdd05178c40e@huaweicloud.com>
Date:   Tue, 14 Mar 2023 15:11:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH-next] nbd: fix incomplete validation of ioctl arg
To:     zhongjinghua <zhongjinghua@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
References: <20230206145805.2645671-1-zhongjinghua@huawei.com>
 <b191b5b0-1dd8-e36a-75b3-d47f0195ca48@huawei.com>
From:   zhongjinghua <zhongjinghua@huaweicloud.com>
In-Reply-To: <b191b5b0-1dd8-e36a-75b3-d47f0195ca48@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77IPHhBkO7JgFQ--.59685S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1UuFy8Zr4UZFyfKFyUWrg_yoW5ZF1DpF
        W8KFWUCryjkrn7WFWqqasrZFy5J3W7t3y3Gr97GFy7ZF1xGry2qFW8Wr9Ygw1UJrW8WFW5
        XFW5JFyv9w1UX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: x2kr0wpmlqwxtxd6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

Hello

Anyone looking this？

在 2023/3/14 15:10, zhongjinghua 写道:
> ping...
>
> Hello
>
> Anyone looking this？
>
> 在 2023/2/6 22:58, Zhong Jinghua 写道:
>> We tested and found an alarm caused by nbd_ioctl arg without 
>> verification.
>> The UBSAN warning calltrace like below:
>>
>> UBSAN: Undefined behaviour in fs/buffer.c:1709:35
>> signed integer overflow:
>> -9223372036854775808 - 1 cannot be represented in type 'long long int'
>> CPU: 3 PID: 2523 Comm: syz-executor.0 Not tainted 4.19.90 #1
>> Hardware name: linux,dummy-virt (DT)
>> Call trace:
>>   dump_backtrace+0x0/0x3f0 arch/arm64/kernel/time.c:78
>>   show_stack+0x28/0x38 arch/arm64/kernel/traps.c:158
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0x170/0x1dc lib/dump_stack.c:118
>>   ubsan_epilogue+0x18/0xb4 lib/ubsan.c:161
>>   handle_overflow+0x188/0x1dc lib/ubsan.c:192
>>   __ubsan_handle_sub_overflow+0x34/0x44 lib/ubsan.c:206
>>   __block_write_full_page+0x94c/0xa20 fs/buffer.c:1709
>>   block_write_full_page+0x1f0/0x280 fs/buffer.c:2934
>>   blkdev_writepage+0x34/0x40 fs/block_dev.c:607
>>   __writepage+0x68/0xe8 mm/page-writeback.c:2305
>>   write_cache_pages+0x44c/0xc70 mm/page-writeback.c:2240
>>   generic_writepages+0xdc/0x148 mm/page-writeback.c:2329
>>   blkdev_writepages+0x2c/0x38 fs/block_dev.c:2114
>>   do_writepages+0xd4/0x250 mm/page-writeback.c:2344
>>
>> The reason for triggering this warning is __block_write_full_page()
>> -> i_size_read(inode) - 1 overflow.
>> inode->i_size is assigned in __nbd_ioctl() -> nbd_set_size() -> 
>> bytesize.
>> We think it is necessary to limit the size of arg to prevent errors.
>>
>> Moreover, __nbd_ioctl() -> nbd_add_socket(), arg will be cast to int.
>> Assuming the value of arg is 0x80000000000000001) (on a 64-bit machine),
>> it will become 1 after the coercion, which will return unexpected 
>> results.
>>
>> Fix it by adding checks to prevent passing in too large numbers.
>>
>> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
>> ---
>>   drivers/block/nbd.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 592cfa8b765a..e1c954094b6c 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -325,6 +325,9 @@ static int nbd_set_size(struct nbd_device *nbd, 
>> loff_t bytesize,
>>       if (blk_validate_block_size(blksize))
>>           return -EINVAL;
>>   +    if (bytesize < 0)
>> +        return -EINVAL;
>> +
>>       nbd->config->bytesize = bytesize;
>>       nbd->config->blksize_bits = __ffs(blksize);
>>   @@ -1111,6 +1114,9 @@ static int nbd_add_socket(struct nbd_device 
>> *nbd, unsigned long arg,
>>       struct nbd_sock *nsock;
>>       int err;
>>   +    /* Arg will be cast to int, check it to avoid overflow */
>> +    if (arg > INT_MAX)
>> +        return -EINVAL;
>>       sock = nbd_get_socket(nbd, arg, &err);
>>       if (!sock)
>>           return err;

