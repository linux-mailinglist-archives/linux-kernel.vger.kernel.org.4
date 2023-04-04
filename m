Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4416D5629
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjDDBfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjDDBe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:34:58 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F581B0;
        Mon,  3 Apr 2023 18:34:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pr9Kz2Gg3z4f3nJh;
        Tue,  4 Apr 2023 09:34:47 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR+3fitktWF6GA--.58991S3;
        Tue, 04 Apr 2023 09:34:48 +0800 (CST)
Subject: Re: [PATCH v4 5/5] md: protect md_thread with rcu
To:     Logan Gunthorpe <logang@deltatee.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230402091236.976723-1-yukuai1@huaweicloud.com>
 <20230402091236.976723-6-yukuai1@huaweicloud.com>
 <84680f93-5936-4a80-fe9e-aed988654e28@deltatee.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <441acd06-606c-8f63-fd69-f7bc82841746@huaweicloud.com>
Date:   Tue, 4 Apr 2023 09:34:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <84680f93-5936-4a80-fe9e-aed988654e28@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR+3fitktWF6GA--.58991S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw15Xr4xCFy8Aw4UJr1kZrb_yoW8XrWfpF
        s8KFyj9r4DJryUZF4UCan5Ja4Fvr4SvFy3G34DK3s8Aas3Gws5tFy7uryFvr4fur95Ka47
        Xa1YqFn5Cryqyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.3 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Logan!

在 2023/04/03 23:53, Logan Gunthorpe 写道:
>>   
>>   /* caller need to make sured returned md_thread won't be freed */
>> -static inline struct md_thread *get_md_thread(struct md_thread *t)
>> +static inline struct md_thread *get_md_thread(struct md_thread __rcu *t)
>>   {
>> -	return t;
>> +	return rcu_access_pointer(t);
> 
> This should not be using rcu_access_pointer(). That function is only
> appropriate when the value of t is not being dereferenced. This should
> be using rcu_dereference_protected() with some reasoning as to why it's
> safe to use this function. It might make sense to open code this for
> every call site if the reasoning is different in each location.
> Preferrably the second argument in the check should be some lockdep
> condition that ensures this. If that's not possible, a comment
> explaining the reasoning why it is safe in all the call sites should be
> added here.

Yes, it's right rcu_dereference_protected() should be used here, I need
to take a look at each call site from patch 3 and figure out if they're
safe without rcu protection.

> 
> On one hand this is looking like my idea of using RCU is producing more
> churn than the spin lock. On the other hand I think it's cleaning up and
> documenting more unsafe use cases (like other potentially unsafe
> accesses of the the thread pointer). So I still think the RCU is a good
> approach here.

Yes, some other unsafe accesses is protected now in this patch. I'll
send a new version soon.

Thanks,
Kuai

