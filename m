Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0B670A416
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 02:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjETAqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 20:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjETAqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 20:46:36 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FE619F;
        Fri, 19 May 2023 17:46:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QNQ5348DPz4f3l91;
        Sat, 20 May 2023 08:46:31 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgCH77JoGGhkawM3Jw--.59245S3;
        Sat, 20 May 2023 08:46:32 +0800 (CST)
Message-ID: <537ffeb6-5b46-ebc7-cf48-19f9d628967c@huaweicloud.com>
Date:   Sat, 20 May 2023 08:46:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH OLK-5.10 v3 3/4] md/raid10: fix wrong setting of
 max_corr_read_errors
To:     Song Liu <song@kernel.org>, linan666@huaweicloud.com
Cc:     neilb@suse.de, Rob.Becker@riverbed.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
References: <20230515134808.3936750-1-linan666@huaweicloud.com>
 <20230515134808.3936750-4-linan666@huaweicloud.com>
 <CAPhsuW4SweXwqCN-_z926CSw4+i0-nHKj8wNooKBvV-1YJ1moQ@mail.gmail.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <CAPhsuW4SweXwqCN-_z926CSw4+i0-nHKj8wNooKBvV-1YJ1moQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77JoGGhkawM3Jw--.59245S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1kJr45KF1ktr1xtr1UKFg_yoW8Gr48pF
        4kGas0vr4UAF17AFsFvrykuasYyasakrWUGryUAa4fXF98Wry3Cr9rKa9agF1vgr1rKF13
        XFsIg3s8C3W8trDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
        xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAkucUUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/20 6:06, Song Liu 写道:
> On Mon, May 15, 2023 at 6:49 AM <linan666@huaweicloud.com> wrote:
>>
>> From: Li Nan <linan122@huawei.com>
>>
>> max_corr_read_errors should not be negative number. Change it to
>> unsigned int where use it.
>>
>> Fixes: 1e50915fe0bb ("raid: improve MD/raid10 handling of correctable read errors.")
>> Signed-off-by: Li Nan <linan122@huawei.com>
>> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/md/md.c     | 2 +-
>>   drivers/md/raid10.c | 5 +++--
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index 5bba071ea907..b69ddfb1662a 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -4484,7 +4484,7 @@ __ATTR_PREALLOC(array_state, S_IRUGO|S_IWUSR, array_state_show, array_state_stor
>>
>>   static ssize_t
>>   max_corrected_read_errors_show(struct mddev *mddev, char *page) {
>> -       return sprintf(page, "%d\n",
>> +       return sprintf(page, "%u\n",
>>                         atomic_read(&mddev->max_corr_read_errors));
>>   }
> 
> max_corr_read_errors is atomic_t, so a signed integer. So these
> signed => unsigned changes are pretty error prone. Can we just
> add check in max_corrected_read_errors_store() so we never store
> a negative value?
> 
> Thanks,
> Song
> 

I will check input in v4

-- 
Thanks,
Nan

