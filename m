Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5C1710D26
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbjEYNU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241251AbjEYNUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:20:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9110A135;
        Thu, 25 May 2023 06:20:23 -0700 (PDT)
Received: from kwepemm600002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QRpZV4l3NzTkdS;
        Thu, 25 May 2023 21:20:18 +0800 (CST)
Received: from [10.174.178.159] (10.174.178.159) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 21:20:19 +0800
Message-ID: <9e3302ac-7e1e-0925-3da1-7c9070c51a3c@huawei.com>
Date:   Thu, 25 May 2023 21:20:07 +0800
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
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
p.start + p.length < 0 can use  check_add_overflow instead.
