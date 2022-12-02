Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A0963FD65
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiLBA5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiLBA52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:57:28 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30919CB23E;
        Thu,  1 Dec 2022 16:57:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NNZKX70b5z4f3kKc;
        Fri,  2 Dec 2022 08:57:20 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgCXrLdwTYljf+TsBQ--.3634S2;
        Fri, 02 Dec 2022 08:57:22 +0800 (CST)
Subject: Re: [PATCH 1/5] sbitmap: don't consume nr for inactive waitqueue to
 avoid lost wakeups
To:     Gabriel Krisman Bertazi <krisman@suse.de>,
        Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        liuzhiqiang@huawei.com
References: <20221201045408.21908-1-shikemeng@huawei.com>
 <20221201045408.21908-2-shikemeng@huawei.com> <87y1rrmeq3.fsf@suse.de>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <20551512-a703-9637-29d8-931f5a76e392@huaweicloud.com>
Date:   Fri, 2 Dec 2022 08:57:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87y1rrmeq3.fsf@suse.de>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgCXrLdwTYljf+TsBQ--.3634S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFy5Jw4UtF43JrWDAFW3trb_yoWDZFb_Kw
        4vgFWay39agFnrWw1Yka17uFnxGFW8Gw1kCr40qF9ayF1ftrs3AFsxCrZ5uF4xG34kAFnY
        gFn0v34vvr429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



on 12/1/2022 9:32 PM, Gabriel Krisman Bertazi wrote:
> Kemeng Shi <shikemeng@huawei.com> writes:
> 
>> If we decremented queue without waiters, we should not decremente freed
>> bits number "nr", or all "nr" could be consumed in a empty queue and no
>> wakeup will be called.
>> Currently, for case "wait_cnt > 0", "nr" will not be decremented if we
>> decremented queue without watiers and retry is returned to avoid lost
>> wakeups. However for case "wait_cnt == 0", "nr" will be decremented
>> unconditionally and maybe decremented to zero. Although retry is
>> returned by active state of queue, it's not actually executed for "nr"
>> is zero.
>>
> 
> Hi Kemeng,
> 
> Fwiw, I sent a patch rewriting this algorithm which is now merged in
> axboe/for-next.  It drops the per-waitqueue wait_cnt entirely.  You can
> find it here:
> 
> https://lore.kernel.org/lkml/20221110153533.go5qs3psm75h27mx@quack3/T/
> 
> Thanks!
Hi Gabriel,
Thanks for remind me of this, I will recheck my patches in the
axboe/for-next branch.

-- 
Best wishes
Kemeng Shi

