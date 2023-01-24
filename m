Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F83F67A371
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjAXT5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjAXT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:57:19 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BACA2E0DC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:57:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P1cVH2H96z9v7gD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:29:27 +0800 (CST)
Received: from [10.45.158.189] (unknown [10.45.158.189])
        by APP1 (Coremail) with SMTP id LxC2BwCHCwdXM9Bj7+7DAA--.13988S2;
        Tue, 24 Jan 2023 20:37:05 +0100 (CET)
Message-ID: <87b8e8ba-a53d-c3e5-1478-9e6cc2b78fee@huaweicloud.com>
Date:   Tue, 24 Jan 2023 20:36:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] tools/memory-model Flag suspicious use of srcu cookies
To:     paulmck@kernel.org, Alan Stern <stern@rowland.harvard.edu>
Cc:     parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230124143951.23372-1-jonas.oberhauser@huaweicloud.com>
 <Y9ATHMm/iVG8goln@rowland.harvard.edu>
 <20230124191535.GT2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230124191535.GT2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCHCwdXM9Bj7+7DAA--.13988S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryfJFWfAry8uFy5Gr45Jrb_yoW8trW5pF
        W8K3Z5GF4DXFy3Crs2vr17WryFy39IqrW3Xrn5JryxA3s0q3Z7CryfKFyY9FnxXr42va1j
        vr1YqFZrJa4DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7IUbG2NtUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2023 8:15 PM, Paul E. McKenney wrote:
> On Tue, Jan 24, 2023 at 12:19:24PM -0500, Alan Stern wrote:
>> On Tue, Jan 24, 2023 at 03:39:51PM +0100, Jonas Oberhauser wrote:
>>> The herd model of LKMM deviates from actual implementations in the
>>> range of cookies that might be returned by srcu_lock() and similar
>>> functions.  As a consequence, code that relies on srcu_lock()
>>> returning specific values might pass on the herd model but fail in
>>> the real world.
>>>
>>> This patch flags any code that looks at the value of a cookie
>>> without passing it on to an srcu_unlock().  This indicates that the
>>> cookie value might be being used in ways that can lead herd to
>>> produce incorrect results, as in the following (contrived) case:
>>>
>>> P0(struct srcu_struct *ss)
>>> {
>>> 	int r = srcu_read_lock(ss);
>>> 	if (r==0)
>>> 		srcu_read_unlock(ss, r);
>>> }
>>>
>>> Without this patch, the code passes herd7 without any warnings.
>>>
>>> With this patch, this code is flagged with illegal-srcu-cookie-ctrl,
>>> indicating that a cookie is used to compute a control condition.
>>> Such scenarios potentially lead to other branches of the code that
>>> are possible in real usage not being evaluated by herd7.  In this
>>> example, this affects the branch where r!=0, which would lead to
>>> an unmatched read side critical section and thus to hangs of
>>> synchronize_srcu() calls.
>>>
>>> Besides use of cookies in control conditions, the patch also flags
>>> use in address computation and any time a cookie is inspected but
>>> not later passed to srcu_read_unlock().
>>>
>>> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
>>> ---
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Thank you both!
>
> I wordsmithed the commit log as follows, but then realized that this
> depends on Alan's earlier patch.

Yeah, I don't know if I did this correctly. I based it on the 
lkmm-srcu.2023.01.20a branch.
Let me know if I should have done this differently.

Looking through your changes to learn for future submissions:

> [...]
>
> This patch flags any code that looks at the value of a cookie
> without passing it on to an srcu_unlock().

You missed this one : )

Have fun, jonas

