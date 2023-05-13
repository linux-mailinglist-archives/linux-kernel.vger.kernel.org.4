Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2207013D9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 04:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241699AbjEMCEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 22:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEMCEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 22:04:02 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F141718;
        Fri, 12 May 2023 19:03:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QJ87Y308Zz4f3mLC;
        Sat, 13 May 2023 10:03:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbAH8F5k1m9UJQ--.37479S3;
        Sat, 13 May 2023 10:03:52 +0800 (CST)
Subject: Re: [PATCH -next v2 0/7] limit the number of plugged bio
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     akpm@osdl.org, neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230426082031.1299149-1-yukuai1@huaweicloud.com>
 <a7246f63-b499-8b26-e27a-3d16abc18ced@huaweicloud.com>
 <CAPhsuW4ZVs0QbWhHibL4A4LG72Q9bPabjCY7ZZkcshTYf+vhbg@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <88d2b016-376c-d65d-ef04-d9cdf5d7b096@huaweicloud.com>
Date:   Sat, 13 May 2023 10:03:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4ZVs0QbWhHibL4A4LG72Q9bPabjCY7ZZkcshTYf+vhbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbAH8F5k1m9UJQ--.37479S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfXF48Kr18JFWUCry5twb_yoW8XF1rpa
        y3GanYkF4kArnrAws2yF4xWry0ka1fJr4UXrn8KryxCF98WFyxWF1xKw45Kwn2vr93W3W2
        9ayUt3s7KFyvyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
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
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/13 8:50, Song Liu 写道:
> On Fri, May 12, 2023 at 2:43 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/04/26 16:20, Yu Kuai 写道:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Changes in v2:
>>>    - remove the patch to rename raid1-10.c
>>>
>>> This patchset tries to limit the number of plugged bio for raid1 and
>>> raid10, which is done in the last patch, other patches are some refactor
>>> and optimizations.
>>>
>>> This patchset is tested with a new test [1], this test triggers dirty
>>> pages writeback for 10s, and in the meantime checks disk inflight.
>>>
>>> Before this patchset, test will fail because inflight exceed threshold
>>> (threshold is set to 4096 in the test, in theory this can be mutch
>>>    greater as long as there are enough dirty pages and memory).
>>>
>>> After this patchset, inflight is within 96 (MAX_PLUG_BIO * copies).
>>>
>>> [1] https://lore.kernel.org/linux-raid/20230426073447.1294916-1-yukuai1@huaweicloud.com/
>>
>> Friendly ping...
> 
> I am sorry for the delay.
> 
> The set looks good overall, but I will need some more time to take a closer
> look. A few comments/questions:
> 
> 1. For functions in raid1-10.c, let's prefix them with raid1_ instead of md_*.
Ok, I'll change that in v3.

> 2. Do we need unplug_wq to be per-bitmap? Would a shared queue work?

I think this can work, the limitation is that global workqueue can
support 256 queued work at a time, but this should be enough.

Thanks,
Kuai
> 
> Thanks,
> Song
> .
> 

