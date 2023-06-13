Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59372E262
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242270AbjFMMAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242269AbjFMMAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:00:17 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7092124;
        Tue, 13 Jun 2023 05:00:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgRvG53PZz4f4684;
        Tue, 13 Jun 2023 20:00:10 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCXaK9KWohkdghwLg--.58089S3;
        Tue, 13 Jun 2023 20:00:11 +0800 (CST)
Subject: Re: [dm-devel] [PATCH -next v2 2/6] md: refactor action_store() for
 'idle' and 'frozen'
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>,
        guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org
Cc:     yi.zhang@huawei.com, yangerkun@huawei.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-3-yukuai1@huaweicloud.com>
 <b780ccfd-66b1-fdd1-b33e-aa680fbd86f1@redhat.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1aaf9150-bbd3-87a8-8d54-8b5d63ab5ed3@huaweicloud.com>
Date:   Tue, 13 Jun 2023 20:00:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b780ccfd-66b1-fdd1-b33e-aa680fbd86f1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXaK9KWohkdghwLg--.58089S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtFykCF13Gry3WryfZry3XFb_yoW3Xwb_C3
        yDKw15Wr18Aaya9r1qyw15Z347Krn0v34UGrZ5Zw45uw17WFs5Jrs8J3Z5Wr4UGFWqkr17
        AFyYqa13Jr429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
        04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
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

在 2023/06/13 16:02, Xiao Ni 写道:
> 
> 在 2023/5/29 下午9:20, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Prepare to handle 'idle' and 'frozen' differently to fix a deadlock, 
>> there
>> are no functional changes except that MD_RECOVERY_RUNNING is checked
>> again after 'reconfig_mutex' is held.
> 
> 
> Can you explain more about why it needs to check MD_RECOVERY_RUNNING 
> again here?

As I explain in the following comment:
>> +    /*
>> +     * Check again in case MD_RECOVERY_RUNNING is cleared before lock is
>> +     * held.
>> +     */
>> +    if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>> +        mddev_unlock(mddev);
>> +        return;
>> +    }

Thanks,
Kuai

