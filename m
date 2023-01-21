Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DA36761DE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjAUAEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAUAEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:04:32 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08193485BC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:04:28 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NzGcD0P4vz9v7Jf
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 07:56:28 +0800 (CST)
Received: from [10.81.218.54] (unknown [10.81.218.54])
        by APP2 (Coremail) with SMTP id GxC2BwDnbmXoK8tjX4WxAA--.46257S2;
        Sat, 21 Jan 2023 01:04:04 +0100 (CET)
Message-ID: <736020be-de00-3cd8-2325-c3efb87e03b6@huaweicloud.com>
Date:   Sat, 21 Jan 2023 01:03:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     paulmck@kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
References: <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8mfWTX7V69pAwo8@rowland.harvard.edu>
 <20230119215304.GA2948950@paulmck-ThinkPad-P17-Gen-1>
 <c5902c18-e0cc-125e-c2f5-7971f0a7ce07@huaweicloud.com>
 <20230120153909.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <cc3686b3-b234-b0ee-4d2d-15f54da4331b@huaweicloud.com>
 <20230120213727.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <44a2c301-900e-90ea-4b21-e5264102e699@huaweicloud.com>
 <20230120231952.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230120231952.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDnbmXoK8tjX4WxAA--.46257S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWDWr4UtrWkCrWDZr1UKFg_yoW8ur43pF
        WfKa1Skr18XFyktws7CrWxW34Fgas5Aay3GryFkrn5Aas8WFWIqr4rt3WSkF9Iywsavw4j
        vry5tasrGas5A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2023 12:19 AM, Paul E. McKenney wrote:
> On Fri, Jan 20, 2023 at 11:36:15PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/20/2023 10:37 PM, Paul E. McKenney wrote:
>>> Just out of curiosity, are you [set] up to run LKMM locally at your end?
>> I don't know what exactly that means. I generally run it on wetware.
>> But I sometimes ask Hernan to run Dat3M (on his machine) over all the litmus
>> tests in your repo to spot any obvious problems with variations I consider.
>> I don't think Dat3M is feature-complete with herd at the moment, just
>> unbelievably faster. For example I think it ignores all flags in the cat
>> files.
>> Oh, I just remembered that I also installed herd7 recently to make sure that
>> any patches I might send in satisfy herd7 syntax requirements (I think you
>> called this diagnostic driven development?), but I haven't used it to really
>> run anything.
>>
>> Is it too obvious that my words usually aren't backed by cold machine logic?
> Well, there was this in one of your messages from earlier today: "I'm not
> going to get it right today, am I?"  And I freely confess that this led
> me to suspect that you might not have been availing yourself of herd7's
> opinion before posting.  ;-)
The main reason I might usually not consult herd7's opinion is that it 
often takes a while to write a test case in a way herd7 accepts and 
treats as intended, but then even so the fact that some tests pass may 
just give some false confidence when some tricky case is being missed.
So I find the investment/increased confidence ratio to not yet be at the 
right point to do this when communicating somewhat informally on the 
mailing list, which is already taking quite a bit of my time (but at 
least I'm learning a lot during that time about stuff like RCU/SRCU, 
history of LKMM, etc.).
If I need to be more confident I'll use herd7 to make sure the syntax is 
correct and as a sanity check, and some paper or Coq proofs to be 
confident in the logic.

If you feel that I'm wasting the lists' time too much by making these 
kind of mistakes, let me know and I'll reconsider.

Best wishes, jonas

