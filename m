Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A9473D8BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 09:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjFZHp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 03:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFZHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 03:45:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F097B8F;
        Mon, 26 Jun 2023 00:45:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68D002F4;
        Mon, 26 Jun 2023 00:46:09 -0700 (PDT)
Received: from [10.57.28.58] (unknown [10.57.28.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A6823F73F;
        Mon, 26 Jun 2023 00:45:23 -0700 (PDT)
Message-ID: <6faf93fe-f8ef-32ea-47ad-08531d630dd8@arm.com>
Date:   Mon, 26 Jun 2023 08:45:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
Content-Language: en-US
To:     Di Shen <cindygm567@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, Di Shen <di.shen@unisoc.com>,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com
References: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
 <20230619063534.12831-1-di.shen@unisoc.com>
 <CAJZ5v0i9fyfNYyhAMqr0iYPbUNwrcvL7mxK1rMo+00mNRWKV6w@mail.gmail.com>
 <CAJZ5v0gHBxbU7Q0KYKsSVk+9nzSxot_JxUkcaAXrDxQx5_a7_Q@mail.gmail.com>
 <dbfe2b14-794a-e4d9-caf4-15d69ef86091@arm.com>
 <CAJZ5v0iOSWDBU0d4QPpsKwAW9N2u1mf-BLdKCtJ_49e8P0ZD7g@mail.gmail.com>
 <62c35d1c-7dcd-7bf2-253e-65cdfd6e92cc@arm.com>
 <CAJZ5v0iX2WYVjXWecJHVB_w1HAAOLDJvFLTMALGQF3pfv-rKSw@mail.gmail.com>
 <2884a54e-4db0-bf47-3b8a-0deb337208d8@arm.com>
 <CAHYJL4qJkNS3OUrunu3LJZRz6wjoJne68kN8eVjdyGXkBdNGKw@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAHYJL4qJkNS3OUrunu3LJZRz6wjoJne68kN8eVjdyGXkBdNGKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/23 09:39, Di Shen wrote:
> On Fri, Jun 23, 2023 at 4:10 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 6/22/23 19:27, Rafael J. Wysocki wrote:

[snip]

>>>
>>> So there seems to be a claim that IPA is the only governor needing the
>>> ->reset() callback, but I have not seen any solid analysis confirming
>>> that.  It very well may be the case, but then the changelog should
>>> clearly explain why this is the case IMO.
>>
>> I agree, the patch header doesn't explain that properly. Here is the
>> explanation for this Intelligent Power Allocator (IPA):
>>
>> The IPA controls temperature using PID mechanism. It's a closed
>> feedback loop. That algorithm can 'learn' from the 'observed'
>> in the past reaction for it's control decisions and accumulates that
>> information in the part called 'error integral'. Those accumulated
>> 'error' gaps are the differences between the set target value and the
>> actually achieved value. In our case the target value is the target
>> temperature which is coming from the trip point. That part is then used
>> with the 'I' (of PID) component, so we can compensate for those
>> 'learned' mistakes.
>> Now, when you change the target temperature value - all your previous
>> learned errors won't help you. That's why Intelligent Power Allocator
>> should reset previously accumulated history.
>>
> 
> Yes, THAT's the point!
> Maybe I need to write the commit message in more detail.
> 

Yes, please extend that description.

Regards,
Lukasz
