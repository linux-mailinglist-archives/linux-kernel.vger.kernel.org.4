Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365626A8F22
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 03:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCCCV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 21:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCCCVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 21:21:55 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B840441B67;
        Thu,  2 Mar 2023 18:21:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PSWv13THGz4f3jJ8;
        Fri,  3 Mar 2023 10:21:49 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBnFCK9WQFkzoH5EA--.23714S3;
        Fri, 03 Mar 2023 10:21:51 +0800 (CST)
Subject: Re: [PATCH] blk-mq: quiesce queue while reallocating hctxs
To:     Keith Busch <kbusch@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230221092436.3570192-1-yukuai1@huaweicloud.com>
 <ZAFMRUo9fdcJh/JD@kbusch-mbp.dhcp.thefacebook.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a4176f2e-ba96-b259-25fd-106031f281dd@huaweicloud.com>
Date:   Fri, 3 Mar 2023 10:21:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZAFMRUo9fdcJh/JD@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBnFCK9WQFkzoH5EA--.23714S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW5XFW8ur1UGrWrGryUJrb_yoWfZFc_uF
        ZYk347twnrGrnaqwn5KF4jvFnrua95WFW5Ja1xCw1kZF1rZa95Jr48WFyfuF47GwsFyas0
        qryDua1j9wsxXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/03/03 9:24, Keith Busch Ð´µÀ:
> On Tue, Feb 21, 2023 at 05:24:36PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> commit 8237c01f1696 ("blk-mq: use quiesced elevator switch when
>> reinitializing queues") add quiesce queue while switching elevator,
>> however, if old elevator is none, queue is still not quiesced. Hence
>> reallocating hctxs can concurrent with run queue. Fix it by also
>> quiesce queue in the beginning of __blk_mq_update_nr_hw_queues().
> 
> Is this actually fixing anything? The quiesced elevator switch was to prevent
> use-after-free from an elevator being torn down, but if you are not switching
> elevators, then what resource does quiescing protect?
> .
> 

What I can think of is hctx itself. run queue can fetch a hctx that will
be exited, I did't found any real problems yet, but I don't think it
is not good to run work for a exited or reused hctx.

Thanks,
Kuai

