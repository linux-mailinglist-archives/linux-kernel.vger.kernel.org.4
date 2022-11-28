Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1346F639F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiK1C0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK1C0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:26:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91574D2C4;
        Sun, 27 Nov 2022 18:26:40 -0800 (PST)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NL8Pp25LBzqSgr;
        Mon, 28 Nov 2022 10:22:38 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 10:26:38 +0800
Subject: Re: [PATCH RFC] scsi: core: remove unsed 'restarts' from scsi_device
To:     Yu Kuai <yukuai1@huaweicloud.com>, <ming.lei@redhat.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20221118113052.1324140-1-yukuai1@huaweicloud.com>
 <cefdae2e-67e3-b4b4-f569-31db960e991f@huaweicloud.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <9a8a1930-80bf-13f1-5512-124be01fcc99@huawei.com>
Date:   Mon, 28 Nov 2022 10:26:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <cefdae2e-67e3-b4b4-f569-31db960e991f@huaweicloud.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/26 16:54, Yu Kuai wrote:
> Hi,
> 
> ÔÚ 2022/11/18 19:30, Yu Kuai Ð´µÀ:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> During code review, I found that 'restarts' is not useful anymore after
>> the following commits:
>>
>> 1) commit ab3cee3762e5 ("blk-mq: In blk_mq_dispatch_rq_list() "no budget"
>> is a reason to kick")
>> 2) commit d3b38596875d ("blk-mq: run queue no matter whether the request
>> is the last request")
>> 3) commit 673235f91531 ("scsi: core: Fix race between handling 
>> STS_RESOURCE
>> and completion")
>>
>> Now that if get budget ever failed, block layer will make sure to
>> trigger new run queue for the hctx. Hence there is no need to run queue
>> from scsi layer in this case.
>>
> 
> Does anyone has suggestions about this patch?
> 
> More info why I tried to remove this:
> 
> while testing megaraid with 4 nvme with none elevator, the default
> queue_depth is 128, while I test it with fio 128 jobs and 1 iodepth,
> bw is about 4Gib/s, however, if I test with 128 jobs and 2 iodepth,
> bw is decreased to about 0.8Gib/s, and with this patch applied,
> bw can stay 4Gib/s in the later case.
> 

Hi Yu Kuai,

This information should be included in the commit message.

Thanks,
Jason
