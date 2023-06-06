Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD227235FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjFFD6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjFFD6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:58:16 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D9C12D;
        Mon,  5 Jun 2023 20:58:14 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QZxXL6H6Hz4f3nKR;
        Tue,  6 Jun 2023 11:58:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7PSrn5kHOotLA--.51186S3;
        Tue, 06 Jun 2023 11:58:11 +0800 (CST)
Subject: Re: [PATCH -next v2] block: fix blktrace debugfs entries leak
To:     Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230531092606.3037560-1-yukuai1@huaweicloud.com>
 <20230531124404.GA27412@lst.de>
 <509bcea6-21f6-3f64-01c3-02215955283d@huaweicloud.com>
 <20230601061858.GA24071@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <386257b1-3060-62f4-c050-2069ae35b82c@huaweicloud.com>
Date:   Tue, 6 Jun 2023 11:58:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230601061858.GA24071@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7PSrn5kHOotLA--.51186S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4DWryrWw4rJr1xZr1DKFg_yoW8Gr47pa
        9Fvan0gr4UXr43Ka4xZw18u34S9ayfAFW5Krn5KryrCFs8Jry3XFW2gF1qvFy3Zas8GFW3
        Xa40vryDGw10grUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
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

Hi, Christoph

在 2023/06/01 14:18, Christoph Hellwig 写道:
> On Thu, Jun 01, 2023 at 09:50:22AM +0800, Yu Kuai wrote:
>> Hi, Christoph
>>
>> 在 2023/05/31 20:44, Christoph Hellwig 写道:
>>> I like where this is going, but did you check that this doesn't
>>> introduce a potential crash with the current /dev/sg based blktrace?
>>
>> I just start to look at how /dev/sg is created and destroyed, however,
>> I'm confused here, do you mean that the added blk_trace_shutdown() here
>> might cause that /dev/sg blktrace to access freed momory or NULL
>> pointer?
> 
> Yes.  Given that __blk_trace_remove clears out q->blk_trace and
> frees the blk trace structure I'm worried about that.
> 

sg ioctl call blktrace apis blk_trace_setup/startstop/remove(), and
these apis are all protected by 'q->debugfs_mutex', and they're safe
to call at anytime as long as request_queue is not released.

And I found that it's true sg can still enable blktrace through ioctl
after the related scsi device gendisk is released, I'm thinking about
following possible solution:

sg_device_destroy() is called at last, when all openers close and the
related device is deleted, so, I think we can get a queue reference
while initializing /dev/sg, and then remove blktrace and put queue
reference from sg_device_destroy().

Any suggestions?

Thanks,
Kuai

