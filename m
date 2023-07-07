Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769FA74A860
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGGBPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGGBPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:15:30 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A901FDD;
        Thu,  6 Jul 2023 18:15:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QxwS80TjNz4f3jMD;
        Fri,  7 Jul 2023 09:15:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rEnZ6dkLseGNQ--.36248S3;
        Fri, 07 Jul 2023 09:15:20 +0800 (CST)
Subject: Re: [PATCH RFC 0/7] blk-mq: improve tag fair sharing
To:     Bart Van Assche <bvanassche@acm.org>,
        Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Christoph Hellwig <hch@lst.de>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230618160738.54385-1-yukuai1@huaweicloud.com>
 <4c9fea33-9c30-4ab9-c210-95e09d323837@acm.org>
 <82d44ba1-4389-079c-935a-cbb49203ca27@huaweicloud.com>
 <c4de836a-a2a1-847f-1525-1accb814e45e@acm.org>
 <84f9bfb4-293b-ad55-97e4-e8c611c5e9ca@huaweicloud.com>
 <dce8850c-92ee-8519-aa74-dc2d7ecc41e0@acm.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1f992908-f347-0b87-efee-58eb35b11c9c@huaweicloud.com>
Date:   Fri, 7 Jul 2023 09:15:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dce8850c-92ee-8519-aa74-dc2d7ecc41e0@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rEnZ6dkLseGNQ--.36248S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWfCw45XFy5Xr1xAF1fZwb_yoWfCFbE9r
        Wvqa42yr4DGF17Za1fKF1vvrWagFWUJr1rJa1DJa17K340kF15uws0grn5Xa1fJw1vyr95
        Wws0934xGw42vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/07/07 2:43, Bart Van Assche 写道:
> On 7/4/23 20:17, Yu Kuai wrote:
>> - currently borrowed tags will never be returned untill queue is idle,
>> I should figure out a way to return borrowed tags if this queue is not
>> busy, so that other queues can borrow tag from this queue.
> 
> At least for UFS this is a significant disadvantage. If e.g. one SCSI
> command is sent to the UFS WLUN every 20 seconds and the request queue
> timeout is 30 seconds then borrowed tags will never be returned.

Ok, thanks for the notice.
> 
> The complexity of this patch series is a concern to me. The complexity
> of this patch series may be a barrier towards merging this patch series
> in the upstream kernel.

Yeah, I see. Thanks for the review! However, all I have in mind will end
up make this patch series more complicated, I'll try my best to make the
code more readable in the next version.

Thanks,
Kuai
> 
> Thanks,
> 
> Bart.
> 
> 
> .
> 

