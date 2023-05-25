Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DA5710E0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbjEYOMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjEYOMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:12:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCFF191;
        Thu, 25 May 2023 07:12:26 -0700 (PDT)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QRqh75P1XzYsmC;
        Thu, 25 May 2023 22:10:15 +0800 (CST)
Received: from [10.174.178.159] (10.174.178.159) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 22:12:23 +0800
Message-ID: <5ec837a5-4e54-b5a2-fd53-a6d7845fb5d7@huawei.com>
Date:   Thu, 25 May 2023 22:12:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH -next] block: Fix the partition start may overflow in
 add_partition()
To:     Christoph Hellwig <hch@infradead.org>,
        Zhong Jinghua <zhongjinghua@huaweicloud.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>, <chengzhihao1@huawei.com>,
        <yangerkun@huawei.com>
References: <20230522070615.1485014-1-zhongjinghua@huaweicloud.com>
 <ZG8igEyXrFa4j/gf@infradead.org>
From:   zhongjinghua <zhongjinghua@huawei.com>
In-Reply-To: <ZG8igEyXrFa4j/gf@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.159]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600002.china.huawei.com (7.193.23.29)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/25 16:55, Christoph Hellwig 写道:
> On Mon, May 22, 2023 at 03:06:15PM +0800, Zhong Jinghua wrote:
>> +	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
>> +		return -EINVAL;
>> +
>>   	start = p.start >> SECTOR_SHIFT;
>>   	length = p.length >> SECTOR_SHIFT;
>>   
>> +	/* length may be equal to 0 after right shift */
>> +	if (!length || start + length > get_capacity(bdev->bd_disk))
>> +		return -EINVAL;
> While we're at it, shouldn't these be switched to use
> check_add_overflow?

However, using check_add_overflow requires the introduction of an 
additional local variable for the third parameter, which does not make 
much difference to the current check. Is it worth it?

e.g:

diff --git a/block/ioctl.c b/block/ioctl.c
index 3223ea862523..9a40e8f864cb 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -18,7 +18,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
  {
         struct gendisk *disk = bdev->bd_disk;
         struct blkpg_partition p;
-       long long start, length;
+       long long start, length, tmp_check;

         if (!capable(CAP_SYS_ADMIN))
                 return -EACCES;
@@ -33,7 +33,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
         if (op == BLKPG_DEL_PARTITION)
                 return bdev_del_partition(disk, p.pno);

-       if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
+       if (p.start < 0 || p.length <= 0 || check_add_overflow(p.start, 
p.length, &tmp_check))
                 return -EINVAL;

         start = p.start >> SECTOR_SHIFT;

Or do you have a better idea?

