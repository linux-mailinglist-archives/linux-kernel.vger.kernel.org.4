Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04CC731304
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244850AbjFOJFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244816AbjFOJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:05:34 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0103C2715;
        Thu, 15 Jun 2023 02:05:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qhbwk1nCMz4f55DK;
        Thu, 15 Jun 2023 17:05:26 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCH77JS1IpkhGIELw--.57144S3;
        Thu, 15 Jun 2023 17:05:23 +0800 (CST)
Subject: Re: [dm-devel] [PATCH -next v2 4/6] md: refactor
 idle/frozen_sync_thread() to fix deadlock
To:     Xiao Ni <xni@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     yi.zhang@huawei.com, yangerkun@huawei.com, snitzer@kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        song@kernel.org, dm-devel@redhat.com, guoqing.jiang@linux.dev,
        agk@redhat.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-5-yukuai1@huaweicloud.com>
 <05aa3b09-7bb9-a65a-6231-4707b4b078a0@redhat.com>
 <74b404c4-4fdb-6eb3-93f1-0e640793bba6@huaweicloud.com>
 <6e738d9b-6e92-20b7-f9d9-e1cf71d26d73@huaweicloud.com>
 <CALTww292gwOe-WEjuBwJn0AXvJC4AbfMZXC43EvVt3GCeBoHfw@mail.gmail.com>
 <5bf97ec5-0cb4-1163-6917-2bc98d912c2b@huaweicloud.com>
 <CALTww28UapJnK+Xfx7O9uEd5ZH2E7ufPT_7pKY6YYuzTZ0Fbdw@mail.gmail.com>
 <b96ec15b-6102-17bb-2c18-a487f224865b@huaweicloud.com>
 <CALTww2-knHOoX35NB73X-sMn1u8EJHLA=0aOnoVqVm83+fdG5Q@mail.gmail.com>
 <04700f85-62a2-1dbd-f330-80f9a13b7d2e@huaweicloud.com>
 <CALTww2-Wr8UbNFaLOyYv5Syh5q4J+hzRuo8Eakj_nOW+P4Cx7A@mail.gmail.com>
 <CALTww2_V=KVLqVVXpXZvGyrmT0N-WG1tFC+HaSEGNfHagaLHug@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bacb3159-514c-76e2-ef2e-353cb1a0e30b@huaweicloud.com>
Date:   Thu, 15 Jun 2023 17:05:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALTww2_V=KVLqVVXpXZvGyrmT0N-WG1tFC+HaSEGNfHagaLHug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77JS1IpkhGIELw--.57144S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw45WFW3KF45tr43try7Wrg_yoW8WrWrpr
        Z2k3W5KrWDGry0yFy2v3W0qFWFvrW7X345Xry3Gr13Aw15Krs0qrWUAayDuF97uFyrKw42
        v395Ja4fJF4UKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/06/15 16:17, Xiao Ni 写道:
>> Thanks for the example. I can understand the usage of it. It's the
>> side effect that removes the mutex protection for idle_sync_thread.
>>
>> There is a problem. New sync thread is started in md_check_recovery.
>> After your patch, md_reap_sync_thread is called in md_check_recovery
>> too. So it looks like they can't happen at the same time?

Of course they can't. md_check_recovery() can only do one thing at a
time.

> 
> After thinking a while, there is still a race possibility.
> 
> md_reap_sync_thread is called in pers deamon (e.g. raid10d ->
> md_check_recovery) and md_check_recovery returns. Before
> idle_sync_thread is woken, the new sync thread can be started in
> md_check_recovery again.
> 
> But it's really strange, when one people echo idle to sync_action.
> It's better to add some messages to notify the users that they need to
> echo idle to sync_action again to have a try. Is there a way that
> md_reap_sync_thread can wait idle_sync_thread?

I don't think this is a problem, echo idle only make sure to interupt
current sync_thread, there is no gurantee that sync_thread is not
running after "echo idle" is done with or without this patchset, before
this patchset, new sync thread can still start after the mutex is
released.

User shoud "echo forzen" instead of "echo idle" if they really what to
avoid new sync_thread to start.

Thanks,
Kuai
> 
> Regards
> Xiao
>>
>> Regards
>> Xiao
>>
>>>
>>> Thanks,
>>> Kuai
>>>
>>> --
>>> dm-devel mailing list
>>> dm-devel@redhat.com
>>> https://listman.redhat.com/mailman/listinfo/dm-devel
> 
> .
> 

