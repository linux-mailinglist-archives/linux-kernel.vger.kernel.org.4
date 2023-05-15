Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92916702CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbjEOM33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240173AbjEOM32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:29:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EF96E4F
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:29:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 071914B3;
        Mon, 15 May 2023 05:30:11 -0700 (PDT)
Received: from [10.57.83.155] (unknown [10.57.83.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 778B53F663;
        Mon, 15 May 2023 05:29:25 -0700 (PDT)
Message-ID: <3a8ec4a6-625c-ba3e-06aa-f8a30d2170d2@arm.com>
Date:   Mon, 15 May 2023 13:29:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] perf/arm-cmn: fix compilation issue
Content-Language: en-GB
To:     Liming Wu <liming.wu@jaguarmicro.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230515012930.946-1-liming.wu@jaguarmicro.com>
 <ZGHt0OyK6ntqwqR6@FVFF77S0Q05N>
 <PSAPR06MB39429C77A11AA027B2E8EE67E1789@PSAPR06MB3942.apcprd06.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <PSAPR06MB39429C77A11AA027B2E8EE67E1789@PSAPR06MB3942.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-15 09:35, Liming Wu wrote:
>> The kernel builds as gnu11 (i.e. C11 + GNU extensions) since commit:
>>
>>    e8c07082a810fbb9 ("Kbuild: move to -std=gnu11")
>>
>> ... so that warning shouldn't be happenning.
>>
>> How are you triggering this? Have you modified KBUILD_CFLAGS?
> 
> Thanks for reply.
> This error occurs for I compiled the arn-cmn module separately.

You're free to build bits of mainline against older kernels if you want 
to and can make it work, but understand that what you're doing in that 
case is a backport. It can be expected that some things need adjusting 
when backporting, and this happens to be one of them; go back far enough 
and the irq_set_affinity() call would be another, IIRC.

The code in mainline here is correct for the mainline kernel, so there 
is nothing to fix.

Thanks,
Robin.

>> -----Original Message-----
>> From: Mark Rutland <mark.rutland@arm.com>
>> Sent: Monday, May 15, 2023 4:31 PM
>> To: Liming Wu <liming.wu@jaguarmicro.com>
>> Cc: will@kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; robin.murphy@arm.com
>> Subject: Re: [PATCH] perf/arm-cmn: fix compilation issue
>>
>> On Mon, May 15, 2023 at 09:29:30AM +0800, liming.wu@jaguarmicro.com
>> wrote:
>>> From: Liming Wu <liming.wu@jaguarmicro.com>
>>>
>>> This patch is used to fix following compilation issue with legacy gcc
>>> and define variables at the beginning of the function
>>>
>>> error: ‘for’ loop initial declarations are only allowed in C99 or C11 mode
>>> 2098 |                 for (int p = 0; p < CMN_MAX_PORTS; p++)
>>
>> The kernel builds as gnu11 (i.e. C11 + GNU extensions) since commit:
>>
>>    e8c07082a810fbb9 ("Kbuild: move to -std=gnu11")
>>
>> ... so that warning shouldn't be happenning.
>>
>> How are you triggering this? Have you modified KBUILD_CFLAGS?
>>
>>> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
>>> ---
>>>   drivers/perf/arm-cmn.c | 13 ++++++++-----
>>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c index
>>> 47d359f72957..2299fcde5b4a 100644
>>> --- a/drivers/perf/arm-cmn.c
>>> +++ b/drivers/perf/arm-cmn.c
>>> @@ -2009,8 +2009,11 @@ static int arm_cmn_discover(struct arm_cmn *cmn,
>> unsigned int rgn_offset)
>>>   	u16 child_count, child_poff;
>>>   	u32 xp_offset[CMN_MAX_XPS];
>>>   	u64 reg;
>>> -	int i, j;
>>> +	int i, j, p;
>>>   	size_t sz;
>>> +	void __iomem *xp_region;
>>> +	struct arm_cmn_node *xp;
>>> +	unsigned int xp_ports;
>>>
>>>   	arm_cmn_init_node_info(cmn, rgn_offset, &cfg);
>>>   	if (cfg.type != CMN_TYPE_CFG)
>>> @@ -2067,9 +2070,9 @@ static int arm_cmn_discover(struct arm_cmn *cmn,
>> unsigned int rgn_offset)
>>>   	cmn->dns = dn;
>>>   	cmn->dtms = dtm;
>>>   	for (i = 0; i < cmn->num_xps; i++) {
>>> -		void __iomem *xp_region = cmn->base + xp_offset[i];
>>> -		struct arm_cmn_node *xp = dn++;
>>> -		unsigned int xp_ports = 0;
>>> +		xp_region = cmn->base + xp_offset[i];
>>> +		xp = dn++;
>>> +		xp_ports = 0;
>>
>> None of these are for loop initial declarations. Even if we wanted to avoid the
>> warning, there's no need for these to change.
>>
>>>
>>>   		arm_cmn_init_node_info(cmn, xp_offset[i], xp);
>>>   		/*
>>> @@ -2095,7 +2098,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn,
>> unsigned int rgn_offset)
>>>   		 * from this, since in that case we will see at least one XP
>>>   		 * with port 2 connected, for the HN-D.
>>>   		 */
>>> -		for (int p = 0; p < CMN_MAX_PORTS; p++)
>>> +		for (p = 0; p < CMN_MAX_PORTS; p++)
>>
>> This shouldn't be necessary given the jernel builds as gnu11.
>>
>> Thanks,
>> Mark.
>>
>>>   			if (arm_cmn_device_connect_info(cmn, xp, p))
>>>   				xp_ports |= BIT(p);
>>>
>>> --
>>> 2.25.1
>>>
