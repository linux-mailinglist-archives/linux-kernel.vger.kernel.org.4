Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB3B6C08F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCTCno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCTCnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:43:42 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322818169;
        Sun, 19 Mar 2023 19:43:38 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:db9:10da:64d2:4d67] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32K2h8Pd007607-32K2h8Pe007607
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 20 Mar 2023 10:43:08 +0800
Message-ID: <3c2f9226-8741-4e51-241f-5dbac45cc794@hust.edu.cn>
Date:   Mon, 20 Mar 2023 10:43:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH linux-next v2 1/3] platform/x86/intel/tpmi: Fix double
 free in tpmi_create_device()
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230309040107.534716-1-dzm91@hust.edu.cn>
 <20230309040107.534716-2-dzm91@hust.edu.cn>
 <dd36a2ab-d465-f857-30c6-3c0094babd31@redhat.com>
 <559654bbef8483fcd53458824f23814236b0c9e0.camel@linux.intel.com>
 <40d7cb19-5712-9754-b7bd-2b582055c929@hust.edu.cn>
 <41c9e613d718095e31674f625f48c60fe493d658.camel@linux.intel.com>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <41c9e613d718095e31674f625f48c60fe493d658.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/17 18:27, srinivas pandruvada wrote:
> Hi Dongliang,
>
> ...
> ...
>
>
>> Hi Srinivas and Hans,
>>
>> How about folding these three patches into one patch and resend a v3
>> patch?
>>
>> This will get all people together and avoid the previous embarrassing
>> sitation.
> This is NOT an embarrassing situation.
> Thanks for finding and fixing the issue.
>
> Thanks,
> Srinivas
>
Hi Srinivas,

Any conclusion about this patch set?

>> Dongliang Mu
>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
>>>>
>>>>
>>>>
>>>>> ---
>>>>>    drivers/platform/x86/intel/tpmi.c | 17 ++++-------------
>>>>>    1 file changed, 4 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/drivers/platform/x86/intel/tpmi.c
>>>>> b/drivers/platform/x86/intel/tpmi.c
>>>>> index c999732b0f1e..882fe5e4763f 100644
>>>>> --- a/drivers/platform/x86/intel/tpmi.c
>>>>> +++ b/drivers/platform/x86/intel/tpmi.c
>>>>> @@ -215,8 +215,8 @@ static int tpmi_create_device(struct
>>>>> intel_tpmi_info *tpmi_info,
>>>>>    
>>>>>           feature_vsec_dev = kzalloc(sizeof(*feature_vsec_dev),
>>>>> GFP_KERNEL);
>>>>>           if (!feature_vsec_dev) {
>>>>> -               ret = -ENOMEM;
>>>>> -               goto free_res;
>>>>> +               kfree(res);
>>>>> +               return -ENOMEM;
>>>>>           }
>>>>>    
>>>>>           snprintf(feature_id_name, sizeof(feature_id_name),
>>>>> "tpmi-
>>>>> %s", name);
>>>>> @@ -242,17 +242,8 @@ static int tpmi_create_device(struct
>>>>> intel_tpmi_info *tpmi_info,
>>>>>            * feature_vsec_dev memory is also freed as part of
>>>>> device
>>>>>            * delete.
>>>>>            */
>>>>> -       ret = intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev-
>>>>>> auxdev.dev,
>>>>> -                                feature_vsec_dev,
>>>>> feature_id_name);
>>>>> -       if (ret)
>>>>> -               goto free_res;
>>>>> -
>>>>> -       return 0;
>>>>> -
>>>>> -free_res:
>>>>> -       kfree(res);
>>>>> -
>>>>> -       return ret;
>>>>> +       return intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev-
>>>>>> auxdev.dev,
>>>>> +                                 feature_vsec_dev,
>>>>> feature_id_name);
>>>>>    }
>>>>>    
>>>>>    static int tpmi_create_devices(struct intel_tpmi_info
>>>>> *tpmi_info)
