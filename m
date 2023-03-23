Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE66C5FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjCWGc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCWGc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:32:56 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8685120;
        Wed, 22 Mar 2023 23:32:55 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PhwWQ4S5Nz4f3k5b;
        Thu, 23 Mar 2023 14:32:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDX0R+S8htk_pqkFQ--.47155S3;
        Thu, 23 Mar 2023 14:32:52 +0800 (CST)
Subject: Re: [PATCH -next 1/6] Revert "md: unlock mddev before reap
 sync_thread in action_store"
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Yu Kuai <yukuai1@huaweicloud.com>, logang@deltatee.com,
        pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        Marc Smith <msmith626@gmail.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
 <20230322064122.2384589-2-yukuai1@huaweicloud.com>
 <2c2599ec-ac35-6494-aedf-93ecca1969ee@linux.dev>
 <d1d27b2a-96ec-319e-4690-64e781c9a473@huaweicloud.com>
 <b91ae03a-14d5-11eb-8ec7-3ed91ff2c59e@linux.dev>
 <31e7f59e-579a-7812-632d-059ed0a6d441@huaweicloud.com>
 <3fc2a539-e4cc-e057-6cf0-da7b3953be6e@linux.dev>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3aa073e9-5145-aae2-2201-5ba48c09c693@huaweicloud.com>
Date:   Thu, 23 Mar 2023 14:32:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3fc2a539-e4cc-e057-6cf0-da7b3953be6e@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDX0R+S8htk_pqkFQ--.47155S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWUWr18CF4rKr1kKFWfZrb_yoW8KFW3pF
        WfG3Z8Xw4kAw4Iya4jvw1Iqa4Fvw4jvrWUGr95Ga4kJ345GrWIqFy8ua1DuayDXrZ7Aa12
        vayrtFs3Za95u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.4 required=5.0 tests=KHOP_HELO_FCRDNS,MAY_BE_FORGED,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/03/23 11:50, Guoqing Jiang 写道:

> Combined your debug patch with above steps. Seems you are
> 
> 1. add delay to action_store, so it can't get lock in time.
> 2. echo "want_replacement"**triggers md_check_recovery which can grab lock
>      to start sync thread.
> 3. action_store finally hold lock to clear RECOVERY_RUNNING in reap sync 
> thread.
> 4. Then the new added BUG_ON is invoked since RECOVERY_RUNNING is cleared
>      in step 3.

Yes, this is exactly what I did.

> sync_thread can be interrupted once MD_RECOVERY_INTR is set which means 
> the RUNNING
> can be cleared, so I am not sure the added BUG_ON is reasonable. And 
> change BUG_ON

I think BUG_ON() is reasonable because only md_reap_sync_thread can
clear it, md_do_sync will exit quictly if MD_RECOVERY_INTR is set, but
md_do_sync should not see that MD_RECOVERY_RUNNING is cleared, otherwise
there is no gurantee that only one sync_thread can be in progress.

> like this makes more sense to me.
> 
> +BUG_ON(!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
> +!test_bit(MD_RECOVERY_INTR, &mddev->recovery));

I think this can be reporduced likewise, md_check_recovery clear
MD_RECOVERY_INTR, and new sync_thread triggered by echo
"want_replacement" won't set this bit.

> 
> I think there might be racy window like you described but it should be 
> really small, I prefer
> to just add a few lines like this instead of revert and introduce new 
> lock to resolve the same
> issue (if it is).

The new lock that I add in this patchset is just try to synchronize idle
and forzen from action_store（patch 3), I can drop it if you think this
is not necessary.

The main changes is patch 4, new lines is not much and I really don't
like to add new flags unless we have to, current code is already hard
to understand...

By the way, I'm concerned that drop the mutex to unregister sync_thread
might not be safe, since the mutex protects lots of stuff, and there
might exist other implicit dependencies.

> 
> TBH, I am reluctant to see the changes in the series, it can only be 
> considered
> acceptable with conditions:
> 
> 1. the previous raid456 bug can be fixed in this way too, hopefully Marc 
> or others
>      can verify it.
> 2. pass all the tests in mdadm

I already test this patchset with mdadm, If there are reporducer for
raid456 bug, I can try to verify it myself.

Thanks,
Kuai
> 
> Thanks,
> Guoqing
> .
> 

