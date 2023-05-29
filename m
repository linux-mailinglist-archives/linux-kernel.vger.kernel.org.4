Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA5A714A01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjE2NPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE2NPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:15:07 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D63F1;
        Mon, 29 May 2023 06:14:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QVGGD3MmNz4f3prh;
        Mon, 29 May 2023 21:14:44 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7NDpXRkydjnKQ--.33661S3;
        Mon, 29 May 2023 21:14:45 +0800 (CST)
Message-ID: <e7b9a1ae-3dd9-84a1-561f-88d1cf3bf117@huaweicloud.com>
Date:   Mon, 29 May 2023 21:14:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] md/raid10: prioritize adding disk to 'removed' mirror
To:     Yu Kuai <yukuai1@huaweicloud.com>, linan666@huaweicloud.com,
        song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230527092007.3008856-1-linan666@huaweicloud.com>
 <45ee7cb9-6651-46a5-87a2-dd66532084d7@huaweicloud.com>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <45ee7cb9-6651-46a5-87a2-dd66532084d7@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7NDpXRkydjnKQ--.33661S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4DCw15WF1xAw1rCF4xtFb_yoW8AF4Upr
        40yw15KrWUJw1kKr1UGr1UJryrtrW8Jw4UJryUXFy7Cr45JryjqrWUXr4Y9r1DJrs3Jr15
        t3W5Jrn8ZFy8GrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
        xwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/29 21:00, Yu Kuai 写道:
> Hi,
> 
> 在 2023/05/27 17:20, linan666@huaweicloud.com 写道:
>> From: Li Nan <linan122@huawei.com>
>>
>> When add a new disk to raid10, it will traverse conf->mirror from start
>> and find one of the following mirror to add:
>>    1. mirror->rdev is set to WantReplacement and it have no replacement,
>>       set new disk to mirror->replacement.
>>    2. no mirror->rdev, set new disk to mirror->rdev.
>>
>> There is a array as below (sda is set to WantReplacement):
>>
>>      Number   Major   Minor   RaidDevice State
>>         0       8        0        0      active sync set-A   /dev/sda
>>         -       0        0        1      removed
>>         2       8       32        2      active sync set-A   /dev/sdc
>>         3       8       48        3      active sync set-B   /dev/sdd
>>
>> Use 'mdadm --add' to add a new disk to this array, the new disk will
>> become sda's replacement instead of add to removed position, which is
>> confusing for users. Meanwhile, after new disk recovery success, sda
>> will be set to Faulty.
>>
>> Prioritize adding disk to 'removed' mirror is a better choice. In the
>> above scenario, the behavior is the same as before, except sda will not
>> be deleted. Before other disks are added, continued use sda is more
>> reliable.
>>
> 
> I think this change make sense, however, it's better to do this for all
> personality instead of just for raid10.
> 
> Thanks,
> Kuai

raid5 is currently like this. If others are OK with this changes to 
raid10, I will modify raid1 later.

-- 
Thanks,
Nan

