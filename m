Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A456BE453
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCQIwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCQIwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8A04D2BC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679043100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fm5MA3d1uv4eRbM8QklMaZbFqc/Ou7mWY80ypyE/Dqk=;
        b=PTFlBlBCrJnDfGR1hc7KqNf4viI8F3850xKi8ZOqtYjTcNuBrSJjKOjvKN3+f/D0DetHww
        fAs2kQJvlIf/bo37SDxOHa16dfpz2OvvwnKipO18i1ycfbUrog3o7pDp1vnvraHVPWNpx2
        hA1Lv6oRxHZrmaDaExeYBBoyf8gyp6M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-BAnSLr6POiOwf9Nuw5Yoyw-1; Fri, 17 Mar 2023 04:51:39 -0400
X-MC-Unique: BAnSLr6POiOwf9Nuw5Yoyw-1
Received: by mail-ed1-f69.google.com with SMTP id b7-20020a056402350700b004d2a3d5cd3fso6828823edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fm5MA3d1uv4eRbM8QklMaZbFqc/Ou7mWY80ypyE/Dqk=;
        b=MiBFsEsoDKsy7RpvObdbcna1d5tt7aYg5ts7LK3dDEFtDTCvirzwaBac8T15nzl0wZ
         hSqUkzVNQTU1moz4M69DR14/sV5LeeMjA66auwXHRwSUHsN9OKsDfIntKFDWXLGaizE1
         Sq9R9h8OO28gvXqxsWXvJkhwZp+2Lp77vviyEQlxXGsG+O/txlrcgr5eioZE5f0tC4Lm
         piz5YtrH6E7M/oZzXuXaDsgAtk/E9kwVQL5o8jvvlcsr2/PdSkth1WTAn+zYaLOsoHH6
         T8/BRFLlhPSOEmq2Ft2b8I85VWEWLg50aIW7gbhVEhvKng7vNhAo5ut2fknD5fYBSKcw
         nCwg==
X-Gm-Message-State: AO0yUKU7wGrC2at4YRg370FYSAOwTAxjhAg2Yt5fH1j2gwJf7f7BARdO
        C4Bj2+rbjTauQRXPkzi3GrhM86jU7VFMD/cEYTnHJdQyVNbmiNeGtS0Og40SKzi7CyyOrAQV4Ht
        tzUAJFAjNVe4h/B2vfbufvN6TXRp9cBJz
X-Received: by 2002:a17:907:2cc6:b0:930:d30a:6c20 with SMTP id hg6-20020a1709072cc600b00930d30a6c20mr5733887ejc.17.1679043098112;
        Fri, 17 Mar 2023 01:51:38 -0700 (PDT)
X-Google-Smtp-Source: AK7set9MDw/m46G8qAEs0zLgpAhdxOqEf4mgpcBP0f71HhwEo8S+g9E4NvA8o054Pi7GeZthoTZWQg==
X-Received: by 2002:a17:907:2cc6:b0:930:d30a:6c20 with SMTP id hg6-20020a1709072cc600b00930d30a6c20mr5733868ejc.17.1679043097844;
        Fri, 17 Mar 2023 01:51:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b0092b606cb803sm714556ejp.140.2023.03.17.01.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:51:36 -0700 (PDT)
Message-ID: <7d535885-0bf1-bbeb-7a7e-89e67aaafa1e@redhat.com>
Date:   Fri, 17 Mar 2023 09:51:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH linux-next v2 1/3] platform/x86/intel/tpmi: Fix double
 free in tpmi_create_device()
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230309040107.534716-1-dzm91@hust.edu.cn>
 <20230309040107.534716-2-dzm91@hust.edu.cn>
 <dd36a2ab-d465-f857-30c6-3c0094babd31@redhat.com>
 <559654bbef8483fcd53458824f23814236b0c9e0.camel@linux.intel.com>
 <40d7cb19-5712-9754-b7bd-2b582055c929@hust.edu.cn>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <40d7cb19-5712-9754-b7bd-2b582055c929@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/17/23 02:28, Dongliang Mu wrote:
> 
> On 2023/3/17 02:18, srinivas pandruvada wrote:
>> Hi Hans,
>>
>> On Thu, 2023-03-16 at 15:25 +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 3/9/23 05:01, Dongliang Mu wrote:
>>>> The previous commit 6a192c0cbf38 ("platform/x86/intel/tpmi: Fix
>>>> double free reported by Smatch") incorrectly handle the
>>>> deallocation of
>>>> res variable. As shown in the comment, intel_vsec_add_aux handles
>>>> all
>>>> the deallocation of res and feature_vsec_dev. Therefore, kfree(res)
>>>> can
>>>> still cause double free if intel_vsec_add_aux returns error.
>>>>
>>>> Fix this by adjusting the error handling part in
>>>> tpmi_create_device,
>>>> following the function intel_vsec_add_dev.
>>>>
>>>> Fixes: 6a192c0cbf38 ("platform/x86/intel/tpmi: Fix double free
>>>> reported by Smatch")
>>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>
>>> IIRC then after this v2 was posted I still saw some comments on the
>>> original v1 which was not posted on the list. Without the v1 comments
>>> being on the list and this archived, I have lost track of what the
>>> status of these patches is.
>>>
>>> Srinivas, can you let me know if I should merge these, or if more
>>> changes are necessary ?
>>>
>>>  From the off-list discussion of v1 I got the impression more changes
>>> are necessary, but I'm not sure.
>> I was looking for changes submitted by the following patch
>> "
>> [PATCH linux-next v2 3/3] drivers/platform/x86/intel: fix a memory leak
>> in intel_vsec_add_aux
>> "
>>
>> Since I was not copied on this, I was unaware. So I was requesting this
>> change.
>>
>> Thanks,
>> Srinivas
> 
> Hi Srinivas and Hans,
> 
> How about folding these three patches into one patch and resend a v3 patch?
> 
> This will get all people together and avoid the previous embarrassing sitation.

If I understand things correctly then patch 1/3 needs 3/3 to function correctly, right ?

I would not fold them together, smaller patches are easier to review / understand, but maybe change the order and put patch 3/3 first? (so make it 1/3) ?

I can even do that when applying if you agree that is the better order.

Regards,

Hans



>>>> ---
>>>>   drivers/platform/x86/intel/tpmi.c | 17 ++++-------------
>>>>   1 file changed, 4 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/intel/tpmi.c
>>>> b/drivers/platform/x86/intel/tpmi.c
>>>> index c999732b0f1e..882fe5e4763f 100644
>>>> --- a/drivers/platform/x86/intel/tpmi.c
>>>> +++ b/drivers/platform/x86/intel/tpmi.c
>>>> @@ -215,8 +215,8 @@ static int tpmi_create_device(struct
>>>> intel_tpmi_info *tpmi_info,
>>>>            feature_vsec_dev = kzalloc(sizeof(*feature_vsec_dev),
>>>> GFP_KERNEL);
>>>>          if (!feature_vsec_dev) {
>>>> -               ret = -ENOMEM;
>>>> -               goto free_res;
>>>> +               kfree(res);
>>>> +               return -ENOMEM;
>>>>          }
>>>>            snprintf(feature_id_name, sizeof(feature_id_name), "tpmi-
>>>> %s", name);
>>>> @@ -242,17 +242,8 @@ static int tpmi_create_device(struct
>>>> intel_tpmi_info *tpmi_info,
>>>>           * feature_vsec_dev memory is also freed as part of device
>>>>           * delete.
>>>>           */
>>>> -       ret = intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev-
>>>>> auxdev.dev,
>>>> -                                feature_vsec_dev,
>>>> feature_id_name);
>>>> -       if (ret)
>>>> -               goto free_res;
>>>> -
>>>> -       return 0;
>>>> -
>>>> -free_res:
>>>> -       kfree(res);
>>>> -
>>>> -       return ret;
>>>> +       return intel_vsec_add_aux(vsec_dev->pcidev, &vsec_dev-
>>>>> auxdev.dev,
>>>> +                                 feature_vsec_dev,
>>>> feature_id_name);
>>>>   }
>>>>     static int tpmi_create_devices(struct intel_tpmi_info *tpmi_info)

