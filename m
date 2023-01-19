Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500DF672E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjASBtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjASBpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:45:50 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF62653B20;
        Wed, 18 Jan 2023 17:45:08 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ny56R3MQzz4f4d8n;
        Thu, 19 Jan 2023 09:45:03 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgDnnLChoMhjQWXwBw--.53540S2;
        Thu, 19 Jan 2023 09:45:05 +0800 (CST)
Subject: Re: [PATCH v4 12/14] blk-mq: remove set of bd->last when get driver
 tag for next request fails
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
 <20230118093726.3939160-12-shikemeng@huaweicloud.com>
 <20230118174208.GH12399@lst.de>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <1f116b9b-8194-54c8-eedb-7f2c9cd493c6@huaweicloud.com>
Date:   Thu, 19 Jan 2023 09:45:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230118174208.GH12399@lst.de>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDnnLChoMhjQWXwBw--.53540S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw1ftry5Xry3WFyxKFy7trb_yoWkJFg_ur
        4jkFn7Gr98urn5Za13KFn3Z3yDKry5Wr98XryfXrW5G34fGFyvqw4kCFnxAF17JFW2k3s3
        KrsYq345tr4avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 1/19/2023 1:42 AM, Christoph Hellwig wrote:
> On Wed, Jan 18, 2023 at 05:37:24PM +0800, Kemeng Shi wrote:
>> Commit 113285b473824 ("blk-mq: ensure that bd->last is always set
>> correctly") will set last if we failed to get driver tag for next
>> request to avoid flush miss as we break the list walk and will not
>> send the last request in the list which will be sent with last set
>> normally.
>> This code seems stale now becase the flush introduced is always
>> redundant as:
>> For case tag is really out, we will send a extra flush if we find
>> list is not empty after list walk.
>> For case some tag is freed before retry in blk_mq_prep_dispatch_rq for
>> next, then we can get a tag for next request in retry and flush notified
>> already is not necessary.
> 
> I think Ming will know this code better than me, but aren't we
> losing the blk_mq_get_driver_tag call entirely here now.  Where
> is getting the driver tag covered now?
> 
We will get driver tag in blk_mq_prep_dispatch_rq at beginning of dispatch
loop, so it's fine to remove blk_mq_get_driver_tag here. Thanks.
-- 
Best wishes
Kemeng Shi

