Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AAF67C9ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbjAZLa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbjAZLaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:30:55 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BA95A808
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:30:52 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P2dbt2wSFz9xFHR
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:22:50 +0800 (CST)
Received: from [10.48.129.37] (unknown [10.48.129.37])
        by APP1 (Coremail) with SMTP id LxC2BwDXXAhJZNJjRC7LAA--.322S2;
        Thu, 26 Jan 2023 12:30:28 +0100 (CET)
Message-ID: <edadb690-e791-0e9c-e641-ea8876abe96e@huaweicloud.com>
Date:   Thu, 26 Jan 2023 12:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Patch 2/2] tools/memory-model: Provide exact SRCU semantics
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <Y9GO3xEYkIQq/qSl@rowland.harvard.edu>
 <Y9GPI/g23YWx+0Ce@rowland.harvard.edu> <Y9GPVnK6lQbY6vCK@rowland.harvard.edu>
 <c44183e7-44ae-4be3-bb47-517067a112b5@huaweicloud.com>
 <Y9Gyuj+2UFefUdJS@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y9Gyuj+2UFefUdJS@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDXXAhJZNJjRC7LAA--.322S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1xWr4fKF4kCF1DAF17GFg_yoW8ArW3pF
        W8KFZ3J3WavryS9r42934rGryrJ34FqFZrtrs7GF4xJ34rXr98Gr1fKw45uFy5Gr1xGa93
        Xr4Fq3sxJ395AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2023 11:52 PM, Alan Stern wrote:
> On Wed, Jan 25, 2023 at 10:04:29PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/25/2023 9:21 PM, Alan Stern wrote:
>>>    (* Validate nesting *)
>>>    flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
>>>    flag ~empty Srcu-unlock \ range(srcu-rscs) as unmatched-srcu-unlock
>>> +flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
>> [...] 
>>>    // SRCU
>>> -srcu_read_lock(X)  __srcu{srcu-lock}(X)
>>> -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
>>> +srcu_read_lock(X) __load{srcu-lock}(*X)
>>> +srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
>>> +srcu_down_read(X) __load{srcu-lock}(*X)
>>> +srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
>> How do you feel about introducing Srcu-up and Srcu-down with this patch?
> Why invent new classes for them?  They are literally the same operation
> as Srcu-lock and Srcu-unlock; the only difference is how the kernel's
> lockdep checker treats them.
I don't think they're necessarily implemented in a compatible way, so

r = srcu_lock(s);
srcu_up(s,r);

might not actually work, but would currently be ok'ed by LKMM. With 
different classes you could state
   flag ~empty [Srcu-lock];srcu-rscs;[Srcu-up] as srcu-mismatch-lock-to-up
   flag ~empty [Srcu-down];srcu-rscs;[Srcu-unlock] as 
srcu-mismatch-down-to-unlock

I think with the current implementation this code might work, but I 
don't feel like this is inherently true.

You could then also go ahead and define the "same CPU" requirement as a 
flag for lock and unlock specifically, like
   flag ~empty [Srcu-lock];srcu-rscs & ext as srcu-lock-unlock-mismatch-CPU
or so.

Best wishes, jonas

