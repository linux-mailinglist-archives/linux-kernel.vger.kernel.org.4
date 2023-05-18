Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B98707798
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjERBtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjERBtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:49:12 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E04CE7A;
        Wed, 17 May 2023 18:49:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QMCZC3YDqz4f3p1T;
        Thu, 18 May 2023 09:49:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR8ShGVkF5GbIw--.28610S3;
        Thu, 18 May 2023 09:49:08 +0800 (CST)
Subject: Re: [PATCH 2/2] ufs: don't use the fair tag sharings
To:     Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ed Tsai <ed.tsai@mediatek.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        wsd_upstream@mediatek.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230509065230.32552-1-ed.tsai@mediatek.com>
 <20230509065230.32552-3-ed.tsai@mediatek.com>
 <ZF0K7A6G2cYBjSgn@infradead.org>
 <aa9af9ae-62a4-6469-244c-b5d9106bb044@acm.org>
 <ZF5G5ztMng8Xbd1W@infradead.org>
 <2740ee82-e35f-1cbf-f5d0-373f94eb14a5@acm.org>
 <de3f41a0-b13d-d4f6-765a-19b857bce53e@huaweicloud.com>
 <86065501-ab2e-09b4-71cd-c0b18ede00ed@acm.org>
 <a26e28a6-91e0-e803-749e-2ce957711c64@huaweicloud.com>
 <097caed2-10b3-7cd1-7c06-90f983e5c720@acm.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f9ccab59-91a1-69d5-6d20-2c6ea0e24b5a@huaweicloud.com>
Date:   Thu, 18 May 2023 09:49:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <097caed2-10b3-7cd1-7c06-90f983e5c720@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR8ShGVkF5GbIw--.28610S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKFykZryDXFW5WFyUCF4xCrg_yoWDuFc_uw
        4DZ3Z2gw17uryxKF4jgr4IqrWUta4UWw17XFW0gF1Sy3s5KFsxKr1DW3Z3ua9xXa1xKrn8
        ur4UX3WjqrWvgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/18 2:23, Bart Van Assche 写道:
> On 5/17/23 00:49, Yu Kuai wrote:
>> 在 2023/05/16 23:12, Bart Van Assche 写道:
>>> I propose that we switch to one of these two approaches:
>>
>> How about a smoothing method that the device with more io will share
>> more tag, and each device will get at least one tag?
> 
> Hi Yu,
> 
> hctx_may_queue() is called from the hot path (blk_mq_get_tag()). I'm 
> pretty sure that adding any nontrivial code in that path will cause a 
> performance (IOPS) regression. So I don't think that adding a smoothing 
> method in hctx_may_queue() is a realistic option.
> 

Currently, fair share from hctx_may_queue() requires two
atomic_read(active_queues and active_requests), I think this smoothing
method can be placed into get_tag fail path, for example, the more times
a disk failed to get tag in a period of time, the more tag this disk can
get, and all the information can be updated here(perhaps directly
record how many tags a disk can get, then hctx_may_queue() still only
require 2 atomic_read()).

Thanks,
Bart

