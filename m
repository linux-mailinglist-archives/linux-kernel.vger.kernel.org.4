Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36086D1789
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCaGgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCaGg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:36:28 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307DA18FBC;
        Thu, 30 Mar 2023 23:36:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PnrCp13Vwz4f3l85;
        Fri, 31 Mar 2023 14:36:22 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgBH9CFmfyZk8oCJFw--.10165S3;
        Fri, 31 Mar 2023 14:36:23 +0800 (CST)
Subject: Re: [PATCH v3 3/3] md: protect md_thread with rcu
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Logan Gunthorpe <logang@deltatee.com>, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230330202046.795213-1-yukuai1@huaweicloud.com>
 <20230330202046.795213-4-yukuai1@huaweicloud.com>
 <67b0f0fb-e9f3-b716-f22f-0ca091a291b0@deltatee.com>
 <7efda5d2-96bf-05a4-418d-122bfdf2ce04@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f54452de-c5f2-aeab-1218-c0ed3990a481@huaweicloud.com>
Date:   Fri, 31 Mar 2023 14:36:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7efda5d2-96bf-05a4-418d-122bfdf2ce04@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CFmfyZk8oCJFw--.10165S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4fJF1rAF1fXFyfJr4xZwb_yoW8JF4xpF
        W8Kay0kr45ArWvvr12yayUA34Fvr1fX3W5ArykGayfA3y7W3yaqrWj9ryUuas8urZ5Ww1Y
        gw1Yg347u3yUJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/31 9:08, Yu Kuai 写道:
> Hi, Logan!
> 
> 在 2023/03/31 3:35, Logan Gunthorpe 写道:
>>
>> A couple points:
>>
>> I don't think we need a double pointer here. rcu_dereference() doesn't
>> actually do anything but annotate the fact that we are accessing a
>> pointer protected by rcu. It does require annotations on that pointer
>> (__rcu) which is checked by sparse (I suspect this patch will produce a
>> lot of sparse errors from kbuild bot).
>>
>> I think all we need is:
>>
>> void md_wakeup_thread(struct md_thread __rcu *rthread)
>> {
>>     struct md_thread *thread;
>>
>>     rcu_read_lock();
>>     thread = rcu_dereference(rthread);
>>     ...
>>     rcu_read_unlock();
>>
>> }
>>
>> The __rcu annotation will have to be added to all the pointers this
>> function is called on as well as to md_register_thread() and
>> md_unregister_thread(). And anything else that uses those pointers.
>> Running sparse on the code and eliminating all new errors for the patch
>> is important.
> 
> Yes, you're right, I'll remove patch 2 and update patch 3. And I'll try
> to run sparse before sending the new version.
> 

By the way, I observed lots of sparse errors and warnings for current
code, will it make sense to fix them?

Thanks,
Kuai

