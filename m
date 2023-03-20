Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D683F6C101A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCTLCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCTLCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:02:12 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3464298FF;
        Mon, 20 Mar 2023 03:57:43 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:2418:ee4b:9ca7:c944] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32KAv6dg028915-32KAv6dh028915
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 20 Mar 2023 18:57:06 +0800
Message-ID: <9068dfb4-044f-f54d-d0da-437659fcebe8@hust.edu.cn>
Date:   Mon, 20 Mar 2023 18:57:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH linux-next v2 2/3] drivers/platform/x86/intel/tpmi: revise
 the comment of intel_vsec_add_aux
To:     Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230309040107.534716-1-dzm91@hust.edu.cn>
 <20230309040107.534716-3-dzm91@hust.edu.cn>
 <8b58fbc5-93c6-9cbe-edda-e804c398ba52@redhat.com>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <8b58fbc5-93c6-9cbe-edda-e804c398ba52@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/20 18:33, Hans de Goede wrote:
> Hi,
>
> On 3/9/23 05:01, Dongliang Mu wrote:
>> intel_vsec_add_aux() is resource managed including res and
>> feature_vsec_dev memory.
>>
>> Fix this by revising the comment of intel_vsec_add_aux since res variable
>> will also be freed in the intel_vsec_add_aux.
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> Thank you for your patch, I've applied this patch to my review-hans
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
>
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
>
> Regards,
>
> Hans

Thanks, Hans.

Shall I send the patch related to memory leak to the mainline? The 
mainline is also prone to this issue?

>
>
>
>> ---
>>   drivers/platform/x86/intel/tpmi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
>> index 882fe5e4763f..036d0e0dba19 100644
>> --- a/drivers/platform/x86/intel/tpmi.c
>> +++ b/drivers/platform/x86/intel/tpmi.c
>> @@ -239,8 +239,8 @@ static int tpmi_create_device(struct intel_tpmi_info *tpmi_info,
>>   	/*
>>   	 * intel_vsec_add_aux() is resource managed, no explicit
>>   	 * delete is required on error or on module unload.
>> -	 * feature_vsec_dev memory is also freed as part of device
>> -	 * delete.
>> +	 * feature_vsec_dev and res memory are also freed as part of
>> +	 * device deletion.
>>   	 */
>>   	return intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev->auxdev.dev,
>>   				  feature_vsec_dev, feature_id_name);
