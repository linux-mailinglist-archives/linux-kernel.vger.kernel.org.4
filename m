Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED75C7013EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 04:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241290AbjEMCVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 22:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjEMCVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 22:21:48 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D5D91;
        Fri, 12 May 2023 19:21:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QJ8X40J4Pz4f3kKb;
        Sat, 13 May 2023 10:21:40 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLAz9F5kn05VJQ--.55330S3;
        Sat, 13 May 2023 10:21:41 +0800 (CST)
Subject: Re: [PATCH v2 3/4] md/raid10: fix wrong setting of
 max_corr_read_errors
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linan666@huaweicloud.com, neilb@suse.de, Rob.Becker@riverbed.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230506012315.3370489-1-linan666@huaweicloud.com>
 <20230506012315.3370489-4-linan666@huaweicloud.com>
 <ddec947c-d2b9-e4fe-30e6-02c76f162ab3@huaweicloud.com>
 <CAPhsuW6zSN86vGO9rd-oTq4TuCYLc+ftrAO6mo6UE7qCNJaCUw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5db8b619-7eac-79be-10e4-1292a44b943b@huaweicloud.com>
Date:   Sat, 13 May 2023 10:21:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW6zSN86vGO9rd-oTq4TuCYLc+ftrAO6mo6UE7qCNJaCUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLAz9F5kn05VJQ--.55330S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4fGr43Kr4DGr45KFy5CFg_yoW5Ary5pw
        4kAas0vr4UJ34UCr9rtryq9a4FyrySyrW0kry8Jw4fX3sxtr9xta48Ga4jgr1kWr1fK3W3
        XFWDKrZrAa18tF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/05/13 9:08, Song Liu 写道:
> On Fri, May 5, 2023 at 7:02 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> 在 2023/05/06 9:23, linan666@huaweicloud.com 写道:
>>> From: Li Nan <linan122@huawei.com>
>>>
>>> max_corr_read_errors should not be negative number. Change it to
>>> unsigned int where use it.
>>>
>>
>> Looks good, feel free to add:
>>
>> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>>
>>> Fixes: 1e50915fe0bb ("raid: improve MD/raid10 handling of correctable read errors.")
>>> Signed-off-by: Li Nan <linan122@huawei.com>
> 
> Hmm.. Does the current code break in any cases?

The problem is that somewhere use unsigned value, and somewhere use
signed value, and I thinsk the only functional change is in
fix_read_error(), if max_read_errors is negative, the judgement will
always pass before this patch:

if (atomic_read(&rdev->read_errors) > max_read_errors)

Thanks,
Kuai
> 
> Thanks,
> Song
> 
>>> ---
>>>    drivers/md/md.c     | 2 +-
>>>    drivers/md/raid10.c | 5 +++--
>>>    2 files changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>>> index fd5c3babcd6d..4a1e566d6bdc 100644
>>> --- a/drivers/md/md.c
>>> +++ b/drivers/md/md.c
>>> @@ -4486,7 +4486,7 @@ __ATTR_PREALLOC(array_state, S_IRUGO|S_IWUSR, array_state_show, array_state_stor
>>>
>>>    static ssize_t
>>>    max_corrected_read_errors_show(struct mddev *mddev, char *page) {
>>> -     return sprintf(page, "%d\n",
>>> +     return sprintf(page, "%u\n",
>>>                       atomic_read(&mddev->max_corr_read_errors));
>>>    }
>>>
>>> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
>>> index 4fcfcb350d2b..4d615fcc6a50 100644
>>> --- a/drivers/md/raid10.c
>>> +++ b/drivers/md/raid10.c
>>> @@ -2727,7 +2727,8 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>>>        int sect = 0; /* Offset from r10_bio->sector */
>>>        int sectors = r10_bio->sectors;
>>>        struct md_rdev *rdev;
>>> -     int max_read_errors = atomic_read(&mddev->max_corr_read_errors);
>>> +     unsigned int max_read_errors =
>>> +                     atomic_read(&mddev->max_corr_read_errors);
>>>        int d = r10_bio->devs[r10_bio->read_slot].devnum;
>>>
>>>        /* still own a reference to this rdev, so it cannot
>>> @@ -2743,7 +2744,7 @@ static void fix_read_error(struct r10conf *conf, struct mddev *mddev, struct r10
>>>        check_decay_read_errors(mddev, rdev);
>>>        atomic_inc(&rdev->read_errors);
>>>        if (atomic_read(&rdev->read_errors) > max_read_errors) {
>>> -             pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %d:max %d]\n",
>>> +             pr_notice("md/raid10:%s: %pg: Raid device exceeded read_error threshold [cur %u:max %u]\n",
>>>                          mdname(mddev), rdev->bdev,
>>>                          atomic_read(&rdev->read_errors), max_read_errors);
>>>                pr_notice("md/raid10:%s: %pg: Failing raid device\n",
>>>
>>
> .
> 

