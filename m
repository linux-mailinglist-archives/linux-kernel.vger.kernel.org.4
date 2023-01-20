Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A6675F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjATU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjATU5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:57:12 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E824C0F0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:57:11 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NzBS959vHz9v7HD
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 04:49:13 +0800 (CST)
Received: from [10.81.223.78] (unknown [10.81.223.78])
        by APP2 (Coremail) with SMTP id GxC2BwAH2F4GAMtjBPWwAA--.5651S2;
        Fri, 20 Jan 2023 21:56:48 +0100 (CET)
Message-ID: <f2ee717f-586f-7ffe-7729-64c88ab36cad@huaweicloud.com>
Date:   Fri, 20 Jan 2023 21:56:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     paulmck@kernel.org
Cc:     Andrea Parri <parri.andrea@gmail.com>,
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
References: <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230120035521.GA319650@paulmck-ThinkPad-P17-Gen-1>
 <126e32b7-caa7-0a1e-4589-885aef7c5a39@huaweicloud.com>
 <fbbd5a65-7f93-ba5e-d8a6-236d9af43c47@huaweicloud.com>
 <20230120153242.GE2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230120153242.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAH2F4GAMtjBPWwAA--.5651S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyUGFyDAryxJw4xWFWfKrg_yoW8Xr43pF
        W8tFZ8C34DJrWIvas3Kr40yF1fXw43twsxJry3G3y8Z345Xas3K3yfKayrZrZxCr13Kw4Y
        9w4av39xAF4kZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2023 4:32 PM, Paul E. McKenney wrote:
> On Fri, Jan 20, 2023 at 01:51:01PM +0100, Jonas Oberhauser wrote:
>> I'm not going to get it right today, am I?
> Believe me, I know that feeling!  Open-source development is therefore
> an extremely good character-building exercise.  At least that is what
> I keep telling myself.  ;-)

"Calvin, go do something you hate! Being miserable builds character!"

>
>> +let srcu-rscs = ([Srcu-lock] ; (data ; [~ Srcu-unlock] ; rfe) * ; data ;
>> [Srcu-unlock]) & loc
>>
>> I see now that I copied the format from your message but without realizing
>> the original had a `|` where I have a `;`.
>> I hope this version is finally right and perhaps more natural than the (data
>> | rf) version, considering rf can't actually appear in most places and this
>> more closely matches carry-dep;data.
>> But of course feel free to use
>> +let srcu-rscs = ([Srcu-lock] ; (data  | [~ Srcu-unlock] ; rf)+ ;
>> [Srcu-unlock]) & loc
>> instead if you prefer.
>
> The reason for favoring "rf" over "rfe" is the possibility of a litmus
> test where the process containing the srcu_down_read() sometimes but
> not always also has the matching srcu_up_read().  Perhaps a pair of "if"
> statements control which process does the matching srcu_up_read().

If you put the redefinition of data early enough to affect this 
definition, the rfi option should be covered by the carry-dep in the 
redefinition of data, so I left it out.

> And thank you!!!

always ;-)

jonas

