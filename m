Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E766BF768
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 03:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCRCcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 22:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCRCcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 22:32:01 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BF57E8BB;
        Fri, 17 Mar 2023 19:31:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PdlPk5lsSz4f3jXk;
        Sat, 18 Mar 2023 10:31:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R+YIhVkDZF0FA--.28358S3;
        Sat, 18 Mar 2023 10:31:54 +0800 (CST)
Subject: Re: [PATCH v2 3/5] md: use md_thread api to wake up sync_thread
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-raid@vger.kernel.org,
        agk@redhat.com, snitzer@kernel.org, song@kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, logang@deltatee.com, guoqing.jiang@linux.dev,
        pmenzel@molgen.mpg.de, "yukuai (C)" <yukuai3@huawei.com>
References: <202303170904.640a8ece-oliver.sang@intel.com>
 <3e171048-060f-af7c-35ec-76fad4fb6f08@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <89b8377c-e953-f5c5-0ad9-d7b426f1a371@huaweicloud.com>
Date:   Sat, 18 Mar 2023 10:31:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3e171048-060f-af7c-35ec-76fad4fb6f08@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R+YIhVkDZF0FA--.28358S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw4kKr17GF1Duw1rtr4xZwb_yoWkuFcEgr
        45uryfWFy3Cw13Kr1vy34avrsxtw15AFy8XrWxJFW7tr12gF98WFs3Zr90y3Z3Z3ykCryj
        yryrZrZruws8ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
        04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/17 11:30, Yu Kuai 写道:
> Hi,
> 
> 在 2023/03/17 10:30, kernel test robot 写道:
>>
>> Greeting,
>>
>> FYI, we noticed INFO:task_blocked_for_more_than#seconds due to commit 
>> (built with gcc-11):
>>
>> commit: af2203c7e88c00d3ce072f18c18a36e2936372fd ("[PATCH v2 3/5] md: 
>> use md_thread api to wake up sync_thread")
>> url: 
>> https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/md-pass-a-md_thread-pointer-to-md_register_thread/20230315-142018 
>>
>> base: git://git.kernel.org/cgit/linux/kernel/git/song/md.git md-next
>> patch link: 
>> https://lore.kernel.org/all/20230315061810.653263-4-yukuai1@huaweicloud.com/ 
>>
>> patch subject: [PATCH v2 3/5] md: use md_thread api to wake up 
>> sync_thread
>>
> 
> I don't expect there is any difference between:
> 
> if (mddev->sync_thread)
>      wake_up_process(mddev->sync_thread->tsk);
> 
> and:
> 
> md_wakeup_thread(mddev->sync_thread);

I understand that they are different now.

md_wakeup_thread() only wakeup wait_event() from md_thread(), it will
not wake up 'md_thread->tsk' if it's runing.

Hence this patch is wrong.

Thanks,
Kuai

