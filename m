Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED3D6BDE25
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 02:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCQB3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 21:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCQB27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 21:28:59 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58B93929D;
        Thu, 16 Mar 2023 18:28:56 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:605a:756c:e115:9209] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32H1SMZr002218-32H1SMZs002218
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 17 Mar 2023 09:28:24 +0800
Message-ID: <40d7cb19-5712-9754-b7bd-2b582055c929@hust.edu.cn>
Date:   Fri, 17 Mar 2023 09:28:21 +0800
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
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <559654bbef8483fcd53458824f23814236b0c9e0.camel@linux.intel.com>
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


On 2023/3/17 02:18, srinivas pandruvada wrote:
> Hi Hans,
>
> On Thu, 2023-03-16 at 15:25 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 3/9/23 05:01, Dongliang Mu wrote:
>>> The previous commit 6a192c0cbf38 ("platform/x86/intel/tpmi: Fix
>>> double free reported by Smatch") incorrectly handle the
>>> deallocation of
>>> res variable. As shown in the comment, intel_vsec_add_aux handles
>>> all
>>> the deallocation of res and feature_vsec_dev. Therefore, kfree(res)
>>> can
>>> still cause double free if intel_vsec_add_aux returns error.
>>>
>>> Fix this by adjusting the error handling part in
>>> tpmi_create_device,
>>> following the function intel_vsec_add_dev.
>>>
>>> Fixes: 6a192c0cbf38 ("platform/x86/intel/tpmi: Fix double free
>>> reported by Smatch")
>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
>> IIRC then after this v2 was posted I still saw some comments on the
>> original v1 which was not posted on the list. Without the v1 comments
>> being on the list and this archived, I have lost track of what the
>> status of these patches is.
>>
>> Srinivas, can you let me know if I should merge these, or if more
>> changes are necessary ?
>>
>>  From the off-list discussion of v1 I got the impression more changes
>> are necessary, but I'm not sure.
> I was looking for changes submitted by the following patch
> "
> [PATCH linux-next v2 3/3] drivers/platform/x86/intel: fix a memory leak
> in intel_vsec_add_aux
> "
>
> Since I was not copied on this, I was unaware. So I was requesting this
> change.
>
> Thanks,
> Srinivas

Hi Srinivas and Hans,

How about folding these three patches into one patch and resend a v3 patch?

This will get all people together and avoid the previous embarrassing 
sitation.

Dongliang Mu

>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>> ---
>>>   drivers/platform/x86/intel/tpmi.c | 17 ++++-------------
>>>   1 file changed, 4 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/intel/tpmi.c
>>> b/drivers/platform/x86/intel/tpmi.c
>>> index c999732b0f1e..882fe5e4763f 100644
>>> --- a/drivers/platform/x86/intel/tpmi.c
>>> +++ b/drivers/platform/x86/intel/tpmi.c
>>> @@ -215,8 +215,8 @@ static int tpmi_create_device(struct
>>> intel_tpmi_info *tpmi_info,
>>>   
>>>          feature_vsec_dev = kzalloc(sizeof(*feature_vsec_dev),
>>> GFP_KERNEL);
>>>          if (!feature_vsec_dev) {
>>> -               ret = -ENOMEM;
>>> -               goto free_res;
>>> +               kfree(res);
>>> +               return -ENOMEM;
>>>          }
>>>   
>>>          snprintf(feature_id_name, sizeof(feature_id_name), "tpmi-
>>> %s", name);
>>> @@ -242,17 +242,8 @@ static int tpmi_create_device(struct
>>> intel_tpmi_info *tpmi_info,
>>>           * feature_vsec_dev memory is also freed as part of device
>>>           * delete.
>>>           */
>>> -       ret = intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev-
>>>> auxdev.dev,
>>> -                                feature_vsec_dev,
>>> feature_id_name);
>>> -       if (ret)
>>> -               goto free_res;
>>> -
>>> -       return 0;
>>> -
>>> -free_res:
>>> -       kfree(res);
>>> -
>>> -       return ret;
>>> +       return intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev-
>>>> auxdev.dev,
>>> +                                 feature_vsec_dev,
>>> feature_id_name);
>>>   }
>>>   
>>>   static int tpmi_create_devices(struct intel_tpmi_info *tpmi_info)
