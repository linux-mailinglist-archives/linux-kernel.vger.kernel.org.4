Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A466549D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjAKGbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbjAKGbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:31:13 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147FBCE2A;
        Tue, 10 Jan 2023 22:31:01 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NsHqy3CWFz4f42pR;
        Wed, 11 Jan 2023 14:30:54 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgAXf7KfV75j4uwGBg--.29723S2;
        Wed, 11 Jan 2023 14:30:56 +0800 (CST)
Subject: Re: [PATCH v3 07/14] blk-mq: make blk_mq_commit_rqs a general
 function for all commits
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
 <20230111130159.3741753-8-shikemeng@huaweicloud.com>
 <20230111054520.GA17158@lst.de>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <c51cbadb-bfd8-5f26-6bc3-5ad975b5db39@huaweicloud.com>
Date:   Wed, 11 Jan 2023 14:30:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230111054520.GA17158@lst.de>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAXf7KfV75j4uwGBg--.29723S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4kJw4xCFW7GF1rKryxuFg_yoWkKFb_CF
        1jy3srC3yUG3ZIq3ySkF13ZF1jg3yUWF1rXayqqrWrG3s5ZrWfKFykGa4fu3W8Gw42vFya
        gFyfX34jvrWFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
        7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Christoph, thank you for taking time to review, alos sorry for the bother
of code style problem. I will fix them in next version.
on 1/11/2023 1:45 PM, Christoph Hellwig wrote:
> On Wed, Jan 11, 2023 at 09:01:52PM +0800, Kemeng Shi wrote:
>> 1. rename orignal blk_mq_commit_rqs to blk_mq_plug_commit_rqs as
>> trace_block_unplug is only needed when we dispatch request from plug list.
> 
> Why?  I think always having the trace even for the commit case seems
> very useful for making the traces useful.
I think unplug event more likely means that request going to be sent to driver
was plugged and in plug list. And the current code do only trace unplug event
when dispatching requests from plug list. If so, would it be better to add
a new event to trace commit?
>> +/* blk_mq_commit_rqs and blk_mq_plug_commit_rqs notify driver using
>> + * bd->last that there is no more requests. (See comment in struct
> 
> This is not the normal kernel comment style.
> 
>> +static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int queued)
>> +{
>> +	if (hctx->queue->mq_ops->commit_rqs && queued) {
>> +		hctx->queue->mq_ops->commit_rqs(hctx);
>> +	}
> 
> No need for the braces.
> 

-- 
Best wishes
Kemeng Shi

