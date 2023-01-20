Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AA4675FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjATVl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATVlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:41:55 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA444F344
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:41:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NzCRj5n3kz9v7Nc
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 05:33:53 +0800 (CST)
Received: from [10.81.218.54] (unknown [10.81.218.54])
        by APP2 (Coremail) with SMTP id GxC2BwAn9119CstjKhmxAA--.5889S2;
        Fri, 20 Jan 2023 22:41:29 +0100 (CET)
Message-ID: <ea37d3d9-4ed3-872a-aed9-f34c4553f6f1@huaweicloud.com>
Date:   Fri, 20 Jan 2023 22:41:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     paulmck@kernel.org, Andrea Parri <parri.andrea@gmail.com>,
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
References: <Y8gjUKoHxqR9+7Hx@rowland.harvard.edu>
 <3dabbcfb-858c-6aa0-6824-05b8cc8e9cdb@gmail.com>
 <20230118201918.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <a5637181-1675-7973-489c-e5d24cbd25c2@huaweicloud.com>
 <20230118211201.GL2948950@paulmck-ThinkPad-P17-Gen-1>
 <09f084d2-6128-7f83-b2a5-cbe236b1678d@huaweicloud.com>
 <20230119001147.GN2948950@paulmck-ThinkPad-P17-Gen-1>
 <0fae983b-2a7c-d44e-8881-53d5cc053f09@huaweicloud.com>
 <20230119184107.GT2948950@paulmck-ThinkPad-P17-Gen-1>
 <64b48a7b-624c-26bd-be9b-0522fc490b28@huaweicloud.com>
 <Y8q+u09ynxnvjVi5@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8q+u09ynxnvjVi5@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAn9119CstjKhmxAA--.5889S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF45tw18Xr4kCryxCFyUWrg_yoW8Ww4DpF
        Wxtw1Skry7ZF1xGwsFqw1Utry8A34Fq3y3J3s8XFZ2y3y5trnaqrn2g3yY9F13G3yxKFWU
        XryYqFyqy348JFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2023 5:18 PM, Alan Stern wrote:
> On Fri, Jan 20, 2023 at 11:13:00AM +0100, Jonas Oberhauser wrote:
>> Perhaps we could say that reading an index without using it later is
>> forbidden?
>>
>> flag ~empty [Srcu-lock];data;rf;[~ domain(data;[Srcu-unlock])] as
>> thrown-srcu-cookie-on-floor
> We already flag locks that don't have a matching unlock.

Of course, but as you know this is completely orthogonal.

> I don't see any point in worrying about whatever else happens to the index.

Can you briefly explain how the operational model you have in mind for 
srcu's up and down allows x==1 (and y==0 and idx1==idx2) in the example 
I sent before (copied with minor edit below for convenience)?

P0{
     idx1 = srcu_down(&ss);
     store_rel(p1, true);


     shared cs

     R x == 1

     while (! load_acq(p2));
     R idx2 == idx1 // for some reason, we got lucky!
     srcu_up(&ss,idx1);
}

P1{
     idx2 = srcu_down(&ss);
     store_rel(p2, true);

     shared cs

     R y == 0

     while (! load_acq(p1));
     srcu_up(&ss,idx2);
}

P2 {
     W y = 1
     srcu_sync(&ss);
     W x = 1
}


I can imagine models that allow this but they aren't pretty. Maybe you 
have a better operational model?

>
>> So if there is an srcu_down() that produces a cookie that is read by some
>> read R, and R doesn't then pass that value into an srcu_up(), the
>> srcu-warranty is voided.
> No, it isn't.
I quote Paul:
"If you do anything else at all with it, anything at all, you just 
voided your SRCU warranty. For that matter, if you just throw that value 
on the floor and don't pass it to an srcu_up_read() execution, you also 
just voided your SRCU warranty."

Best wishes,
jonas

