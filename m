Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D828F67BDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjAYVMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbjAYVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:12:05 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FFB23674
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:11:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P2GWz0Ll6z9xtmf
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:03:11 +0800 (CST)
Received: from [10.81.213.36] (unknown [10.81.213.36])
        by APP2 (Coremail) with SMTP id GxC2BwBXJl3KmtFjpY_GAA--.15701S2;
        Wed, 25 Jan 2023 22:10:46 +0100 (CET)
Message-ID: <f9f7a9b0-23c8-587f-61a9-ca4b0950ad1b@huaweicloud.com>
Date:   Wed, 25 Jan 2023 22:10:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
References: <Y9BdNVk2LQiUYABS@rowland.harvard.edu>
 <20230124225449.GY2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9CL8LBz+/mbbD00@rowland.harvard.edu>
 <20230125022019.GB2948950@paulmck-ThinkPad-P17-Gen-1>
 <cedf3a39-12cd-1cb1-ad5a-7c10768cee40@huaweicloud.com>
 <20230125150520.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9FMEATzv3gcTUe2@rowland.harvard.edu>
 <20230125171832.GH2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9F+SyLpxHwdK0rE@rowland.harvard.edu>
 <20230125194651.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9GSuzHFdRfLeAAp@andrea>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y9GSuzHFdRfLeAAp@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBXJl3KmtFjpY_GAA--.15701S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWUAr4xtF47WryrGF13XFb_yoW8Xr43pF
        WFkr4Yyr4Dtry0kw1kAw1jvayxuw4rtF45Jwn3Gws8uws0vrnYvr429w4Y9ayDZ393Gws0
        qrWDJa47ur1UKrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 1/25/2023 9:36 PM, Andrea Parri wrote:
>>> Why do you want the implementation to forbid it?  The pattern of the
>>> litmus test resembles 3+3W, and you don't care whether the kernel allows
>>> that pattern.  Do you?
>> Jonas asked a similar question, so I am answering you both here.
>>
>> With (say) a release-WRITE_ONCE() chain implementing N+2W for some
>> N, it is reasonably well known that you don't get ordering, hardware
>> support otwithstanding.  After all, none of the Linux kernel, C, and C++
>> memory models make that guarantee.  In addition, the non-RCU barriers
>> and accesses that you can use to create N+2W have been in very wide use
>> for a very long time.
>>
>> Although RCU has been in use for almost as long as those non-RCU barriers,
>> it has not been in wide use for anywhere near that long.  So I cannot
>> be so confident in ruling out some N+2W use case for RCU.
> Did some archeology...  the pattern, with either RCU sync plus a release
> or with two full fences plus a release, was forbidden by "ancient LKMM":
> the relevant changes were described in
>
>    https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/WeakModel.html#Coherence%20Point%20and%20RCU
>
>    Andrea

Fascinating! It says there "But the weak model allows it, as required" 
-- what does "as required" mean? Just "as required by dropping the 
constraint"?

Is there still a notion of "strong model" and "weak model", or was the 
strong model dropped?

jonas

