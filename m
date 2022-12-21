Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D436D652BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiLUDnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLUDnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:43:08 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A21EAD6;
        Tue, 20 Dec 2022 19:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671594180;
        bh=AwTHZsJE1OHmZw07jiGlqjcJAYhW0GUTvOa719wrfcw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g5Egj5vaNGMMyKDGyVK12hdPytUVLvpAYJlg5fhmDr2lN1H0B2+29ItSjzJA5gQL/
         3zF6gYuGrb6EJrrcOwre55oGT4vYz0Nwp2P3nzh49RLBim0oOTnWJl2CxwovVpu246
         SzK9ScSOWWln1fhaZulfuvND4o4PIEWv61jZRAgouqK0YOYwurQ3dvXLUuKx5TWk8q
         MQhX4hxvIp5kL0WQw702zFsQoL2f+067xBRGvt6xhctB+hRRHOCbgLuq9rFd2L5Dmu
         nk7beGL+LYfF7uy65mU2ZbmQm7QUfbIRpp8GZ3c5TiDIr/N52N7c+qiiovTivU20KM
         w64WGCwJw99zw==
Received: from [10.1.0.30] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NcK5w5GFlzbvj;
        Tue, 20 Dec 2022 22:43:00 -0500 (EST)
Message-ID: <f4199d1f-306c-681f-8bb9-26d66ecf5121@efficios.com>
Date:   Tue, 20 Dec 2022 22:43:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20221220140714.GB22763@lothringen>
 <CA83E649-8C79-4D39-9BFE-BBEF95968B98@joelfernandes.org>
 <20221220224459.GA25175@lothringen>
 <CAEXW_YSAv+MzZoW9RK9H3E6DAyZH+wB=4bMy5nXTOExSwgSwAg@mail.gmail.com>
 <20221221004957.GA29021@lothringen> <20221221005858.GA29316@lothringen>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221221005858.GA29316@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-20 19:58, Frederic Weisbecker wrote:
> On Wed, Dec 21, 2022 at 01:49:57AM +0100, Frederic Weisbecker wrote:
>> On Tue, Dec 20, 2022 at 07:15:00PM -0500, Joel Fernandes wrote:
>>> On Tue, Dec 20, 2022 at 5:45 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>>> Agreed about (1).
>>>
>>>> _ In (2), E pairs with the address-dependency between idx and lock_count.
>>>
>>> But that is not the only reason. If that was the only reason for (2),
>>> then there is an smp_mb() just before the next-scan post-flip before
>>> the lock counts are read.
>>
>> The post-flip barrier makes sure the new idx is visible on the next READER's
>> turn, but it doesn't protect against the fact that "READ idx then WRITE lock[idx]"
>> may appear unordered from the update side POV if there is no barrier between the
>> scan and the flip.
>>
>> If you remove the smp_mb() from the litmus test I sent, things explode.
> 
> Or rather, look at it the other way, if there is no barrier between the lock
> scan and the index flip (E), then the index flip can appear to be written before the
> lock is read. Which means you may start activating the index before you finish
> reading it (at least it appears that way from the readers pont of view).

Considering that you can have pre-existing readers from arbitrary index 
appearing anywhere in the grace period (because a reader can fetch the
index and be preempted for an arbitrary amount of time before 
incrementing the lock count), the grace period algorithm needs to deal 
with the fact that a newcoming reader can appear in a given index either 
before or after the flip.

I don't see how flipping the index before or after loading the 
unlock/lock values would break anything (except for unlikely counter 
overflow situations as previously discussed).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

