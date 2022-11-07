Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C838161F1A0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiKGLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiKGLPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:15:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97EAD101CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:15:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75F401FB;
        Mon,  7 Nov 2022 03:15:45 -0800 (PST)
Received: from [10.57.67.115] (unknown [10.57.67.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C5583F73D;
        Mon,  7 Nov 2022 03:15:37 -0800 (PST)
Message-ID: <5cf4b3b9-9c0d-8e30-3159-d63c7f5b9648@arm.com>
Date:   Mon, 7 Nov 2022 11:15:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 5.10] coresight: cti: Fix hang in cti_disable_hw()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     James Clark <james.clark@arm.com>, stable@kernel.org,
        Aishwarya TCV <Aishwarya.TCV@arm.com>,
        Cristian Marussi <Cristian.Marussi@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221102112003.2318583-1-james.clark@arm.com>
 <Y2jLvmF0GZ6yHY0m@kroah.com> <4d44d2c8-a8ec-1729-d3cc-9ae8beb48045@arm.com>
 <Y2jVXdX1Mx5eXAiB@kroah.com> <99b25aab-ba87-b875-9f5f-c7dd9444b8c8@arm.com>
 <Y2jc4f+iEfA9qAQA@kroah.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <Y2jc4f+iEfA9qAQA@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 07/11/2022 10:24, Greg Kroah-Hartman wrote:
> On Mon, Nov 07, 2022 at 09:59:24AM +0000, Suzuki K Poulose wrote:
>> On 07/11/2022 09:52, Greg Kroah-Hartman wrote:
>>> On Mon, Nov 07, 2022 at 09:23:26AM +0000, Suzuki K Poulose wrote:
>>>> On 07/11/2022 09:11, Greg Kroah-Hartman wrote:
>>>>> On Wed, Nov 02, 2022 at 11:20:03AM +0000, James Clark wrote:
>>>>>> commit 6746eae4bbaddcc16b40efb33dab79210828b3ce upstream.
>>>>>
>>>>> Isn't this commit 665c157e0204176023860b51a46528ba0ba62c33 instead?
>>>>
>>>> This was reverted in commit d76308f03ee1 and pushed in later
>>>> with fixups as 6746eae4bbadd.
>>>
>>> So which should be applied?
>>
>> Sorry, this particular post is a backport for v5.10 stable branch.
>>
>>>
>>> confused,
>>
>> Now I am too. What is expected here ? My understanding is, we
>> should stick the "upstream" commit that is getting backported
>> at the beginning of the commit description. In that sense,
>> the commit id in this patch looks correct to me. Please let
>> me know if this is not the case.
>>
>> As such, this is only for 5.10.x branch. The rest are taken
>> care of.
>>
>> Please let us know if we are something missing.
> 
> We already have commit 665c157e0204176023860b51a46528ba0ba62c33 queued
> up in the 5.10 stable queue.  Is that not correct?  It has the same

We pushed the fix as part of the coresight fixes for 6.1 [0], as

commit: 6746eae4bbad "coresight: cti: Fix hang in cti_disable_hw()"


But, the version in there, produced a build warning with "unused
variable" (with CONFIG_WERROR) [1] and thus was reverted in [2],

commit: d76308f03ee1: Revert "coresight: cti: Fix hang in cti_disable_hw()"


Later, we sent you the corrected fix separately [3], which was queued as
commit "6746eae4bbadd".

6746eae4bbad coresight: cti: Fix hang in cti_disable_hw()

So, in effect, here is what we have in the tree :

$ git log --oneline | grep "cti: Fix"
6746eae4bbad coresight: cti: Fix hang in cti_disable_hw()
d76308f03ee1 Revert "coresight: cti: Fix hang in cti_disable_hw()"
665c157e0204 coresight: cti: Fix hang in cti_disable_hw()

> subject line as this one.

I understand the "same" subject line has caused this confusion. Will
modify it in the future avoid this confusion.

So, kindly drop "665c157e0204" from the queue for 5.10, it would fail to
apply there anyway so does the correct "6746eae4bbad". This backport
is appropriate for 5.10 branch, with the correct version.

I have double checked the versions pulled into 6.0.x [4] and 5.15.x [5] 
branches and they all have the correct one (6746eae4bbad) applied.

[0] https://lkml.kernel.org/r/16664341837810@kroah.com
[1] https://lkml.kernel.org/r/20221024135752.2b83af97@canb.auug.org.au
[2] https://lkml.kernel.org/r/166659326494120@kroah.com
[3] https://lkml.kernel.org/r/1666717705115206@kroah.com
[4] https://lkml.kernel.org/r/166719866563237@kroah.com
[5] https://lkml.kernel.org/r/16671983698786@kroah.com


Hope this helps.

Suzuki

> 
> Still confused.
> 
> thanks,
> 
> greg k-h

