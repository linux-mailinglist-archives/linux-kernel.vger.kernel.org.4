Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF57161AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjE3NYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjE3NYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:24:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949ABD9;
        Tue, 30 May 2023 06:24:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QVtR938J0z4f3nTh;
        Tue, 30 May 2023 21:24:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rEU+XVkWUMyKg--.13490S3;
        Tue, 30 May 2023 21:24:38 +0800 (CST)
Subject: Re: [PATCH V1] block: Fix null pointer dereference issue on struct
 io_cq
To:     Pradeep Pragallapati <quic_pragalla@quicinc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230517084434.18932-1-quic_pragalla@quicinc.com>
 <07b8b870-a464-25a9-c0a6-c123fad05ff5@huaweicloud.com>
 <a29dcfa5-bb6a-d3b9-9fb7-cce87a8f8620@huaweicloud.com>
 <4648819c-2115-a981-1b74-0495b94d4233@huaweicloud.com>
 <b1b7e7f1-55c2-4833-040f-6cdb75f8c11b@quicinc.com>
 <00eefae6-8db4-139b-9f8a-9ed326817561@quicinc.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b7d92802-8403-874d-0cf5-d492e3ea96ae@huaweicloud.com>
Date:   Tue, 30 May 2023 21:24:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <00eefae6-8db4-139b-9f8a-9ed326817561@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rEU+XVkWUMyKg--.13490S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JryrJFWfJF4xWF1fur1kAFb_yoW3WFc_Ww
        4UuasrGwn0gw4xtrn8Krnaq34vqF18KF13JrWxAF4xG3s7Zas5AF4rJ393A347GrW7Jw48
        Cr1qga4SqFsxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
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

在 2023/05/30 21:15, Pradeep Pragallapati 写道:
> Hi,
> 
> On 5/22/2023 11:49 AM, Pradeep Pragallapati wrote:
>>
>> On 5/18/2023 6:14 PM, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2023/05/18 20:16, Yu Kuai 写道:
>>>
>>>> @@ -173,18 +171,17 @@ void ioc_clear_queue(struct request_queue *q)
>>>>   {
>>>>          LIST_HEAD(icq_list);
>>>>
>>>> +       rcu_read_lock();
>>>
>>> Sorry that I realized this is still not enough, following list_empty()
>>> and list_entry() can still concurrent with list_del(). Please try the
>>> following patch:
>> sure will try and update the results.
> 
> 
> At least for 80+hrs of testing, i didn't see the issue reproduced. seems 
> like it is helping my case.

Thanks for the test, I'll send a patch soon.

Kuai

