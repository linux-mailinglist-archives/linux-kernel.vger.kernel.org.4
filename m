Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B184174BD95
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 15:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGHNQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 09:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHNQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 09:16:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456FFE55
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 06:16:01 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id I7mwqrPmVn02aI7mwqEG5C; Sat, 08 Jul 2023 15:15:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1688822158;
        bh=MtFS4H/mvjYBQ6kD2sk3yhpdjTWzlyIwy/D4XqevP4Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HeBBJKpw7QjGeqAKXjtW9K+A/j1qxIyP4Z1zGSbXu9RowIPmKLtfnvwiQ4OA7fYT+
         ynZxJA4onQ2YKhyb2xx+aT2meliqLoHnzUUHi5QZy3USNLU9R9p0vcxkFUeAdvycj7
         NvZqTPJS+7tvbnFvywGvWqICUwGihsuOJc5m2FeqkJQdL5mdY1hW20VbH5uiZlYlyV
         0Alv1EguSOV8CKnXcxwzuD8C3uFNV5vXWtKm8l93lwbM2U3FJQEQxrWiR3syveFvca
         2+5Jt9+YuYoMUgm9iQ6y8Kol3EeLVXZzA1UVQz36sGSJeraBfjmFBNYGehCksSPzlB
         jCdWdxt20YoTg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Jul 2023 15:15:58 +0200
X-ME-IP: 86.243.2.178
Message-ID: <19369234-8785-575b-ff24-9a21a9e82f0e@wanadoo.fr>
Date:   Sat, 8 Jul 2023 15:15:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: RE: [PATCH net v2 1/2] net: ll_temac: Fix DMA resources leak
To:     "Katakam, Harini" <harini.katakam@amd.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonas Suhr Christensen <jsc@umbraculum.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Haoyue Xu <xuhaoyue1@hisilicon.com>,
        huangjunxian <huangjunxian6@hisilicon.com>,
        Wang Qing <wangqing@vivo.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Esben Haabendal <esben@geanix.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Neeli, Srinivas" <srinivas.neeli@amd.com>
References: <20230205201130.11303-1-jsc@umbraculum.org>
 <20230205201130.11303-2-jsc@umbraculum.org>
 <5314e0ba3a728787299ca46a60b0a2da5e8ab23a.camel@redhat.com>
 <135b671b1b76978fb147d5fee1e1b922e2c61f26.camel@redhat.com>
 <20230207104204.200da48a@kernel.org>
 <bd639016-8a9c-4479-83b4-32306ad734ac@app.fastmail.com>
 <20230313114858.54828dda@kernel.org>
 <BYAPR12MB47736214A6B4AAF524752A8B9EBE9@BYAPR12MB4773.namprd12.prod.outlook.com>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <BYAPR12MB47736214A6B4AAF524752A8B9EBE9@BYAPR12MB4773.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/03/2023 à 06:15, Katakam, Harini a écrit :
> Hi Jakub, Jonas,
> 
>> -----Original Message-----
>> From: Jakub Kicinski <kuba@kernel.org>
>> Sent: Tuesday, March 14, 2023 12:19 AM
>> To: Jonas Suhr Christensen <jsc@umbraculum.org>; Katakam, Harini
>> <harini.katakam@amd.com>
>> Cc: Paolo Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; David S.
>> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
>> Michal Simek <michal.simek@xilinx.com>; Haoyue Xu
>> <xuhaoyue1@hisilicon.com>; huangjunxian <huangjunxian6@hisilicon.com>;
>> Wang Qing <wangqing@vivo.com>; Yang Yingliang
>> <yangyingliang@huawei.com>; Esben Haabendal <esben@geanix.com>;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH net v2 1/2] net: ll_temac: Fix DMA resources leak
>>
>> On Mon, 13 Mar 2023 19:37:00 +0100 Jonas Suhr Christensen wrote:
>>> On Tue, Feb 7, 2023, at 19:42, Jakub Kicinski wrote:
>>>> On Tue, 07 Feb 2023 12:36:11 +0100 Paolo Abeni wrote:
>>>>> You can either try change to phys type to __be32 (likely not
>>>>> suitable for -net and possibly can introduce even more warnings
>>>>> elsewhere)
>>>>
>>>> FWIW that seems like the best option to me as well. Let's ignore the
>>>> sparse warning for v3 and try to switch phys to __be32 in a separate
>>>> patch for net-next. No point adding force casts just to have to
>>>> remove them a week later, given how prevalent the problem is.
>>>>
>>>>> or explicitly cast the argument.
>>>
>>> I no longer have access to the hardware, so I'm not rewriting the
>>> batch. Feel free to take ownership of it and fix what's needed.
>>
>> Ack.
>>
>> Harini, are you the designated maintainer for this driver? Could you add a
>> MAINTAINERS entry for it? I don't see one right now.
>> And possibly pick up these patches / fix the problem, if you have the cycles?
> 
> Sure, Srinivas (cced) will pick up this series and send a v3.
> I'll get back on the state of this IP/driver for the maintainers list. Will include
> that patch in the beginning of the series as well.
> 
> Regards,
> Harini
> 

Hi,

this patch, or an updated version, has not reached -next yet.

Does someone still working on it, or did it got lost?

CJ
