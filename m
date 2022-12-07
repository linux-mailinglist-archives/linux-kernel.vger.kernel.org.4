Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24072645FFF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLGRTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiLGRSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:18:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B505596
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670433463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ggK7ydGfFji/4PPsKTJL88oxInG4TKWpE5XjChRZTIg=;
        b=YIt4g/7kC3g2SA2hQUP5clYWz3N8LMto7PhKlTNsCJch1taDKLm7Yh2UucA4AWBR0YTrH8
        OzH/qyMl3mBxwg7zUarlcSKYi2nVbVaaNOG+zjNMAwOa/2Z8SCtoPlBiLWPeAJXuB+JADe
        wLxDSpvZi30nEZu6al/vLWIzjCWNKqc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121--m4LbQ3cPhGA8XIs7DUBVA-1; Wed, 07 Dec 2022 12:17:41 -0500
X-MC-Unique: -m4LbQ3cPhGA8XIs7DUBVA-1
Received: by mail-ed1-f71.google.com with SMTP id y18-20020a056402359200b004635f8b1bfbso10450159edc.17
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 09:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggK7ydGfFji/4PPsKTJL88oxInG4TKWpE5XjChRZTIg=;
        b=G1BU96d8q6Onfhr93VrPSaPoKZ9uKAIEKwLrwpBuV3raTwD5xA2Rr+SbXXSpIKygbh
         iCM/2VEIuE1Vbt1OdjxalW3RzGg4V1Er3K+k+Hxu5+5wFo8taGj+Jqnx3j0lI61uKw+4
         ky6jC+cnpTiIKlhyqG2pmBpFogO00VHhoo7UI40kwVp9fE1v/Sphf89y2FU5yDXb3oXY
         PxvtvP+JXehrtSZLpzO4Fv9/r1qL85fGse0QbhgdZBbk5b00bLixQXeBaE+z93fhbyzG
         3sOSGRxr+dGYLdUH0hvOtiw8PTRyYhdKBB1OUK5I6EcYe22A/myjQ0ZcTxwHILW31Db7
         y4zw==
X-Gm-Message-State: ANoB5pnjkV8YrztSPOKN+z+3qIsbxiZ/2+APAAPYVZkZrLd3N2JAqLj6
        FNJvqkafjuInS6mrnN/vyzdaDl/t5fY5ZawzMi+BOmgz08xvgHBiQ2gfa/xM4ot0uwbmZaxCfko
        xtTk7M7WMQQD4lbuNWxHEUcIx
X-Received: by 2002:a05:6402:c84:b0:46b:98:f0f0 with SMTP id cm4-20020a0564020c8400b0046b0098f0f0mr43973355edb.38.1670433460826;
        Wed, 07 Dec 2022 09:17:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6K4Otxv7KQym8SomYbZ7TKR8z1sNHgidg4M0Y2grXwqRpOlJxQymQA+SNM3H8rxVrg83vKow==
X-Received: by 2002:a05:6402:c84:b0:46b:98:f0f0 with SMTP id cm4-20020a0564020c8400b0046b0098f0f0mr43973347edb.38.1670433460682;
        Wed, 07 Dec 2022 09:17:40 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id m17-20020a1709062b9100b0079800b81709sm8744352ejg.219.2022.12.07.09.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 09:17:39 -0800 (PST)
Message-ID: <b2438b56-034c-ec2a-019a-2f89f109aee7@redhat.com>
Date:   Wed, 7 Dec 2022 18:17:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] platform/x86/amd: pmc: Add a workaround for an s0i3 issue
 on Cezanne
Content-Language: en-US, nl
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>,
        Raul Rangel <rrangel@chromium.org>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
References: <20221116154341.13382-1-mario.limonciello@amd.com>
 <0d9f8f8c-3b45-dd6a-008b-6d9ffe8ccc93@redhat.com>
 <MN0PR12MB6101F972282D66202C95C0F2E2069@MN0PR12MB6101.namprd12.prod.outlook.com>
 <22d62cb7-17f4-c8d2-40fa-987bb2a4a0fa@redhat.com>
 <MN0PR12MB6101BA92D0A8DF652F10A121E2189@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <MN0PR12MB6101BA92D0A8DF652F10A121E2189@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On 12/6/22 00:02, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Thursday, November 17, 2022 10:09
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; S-k, Shyam-sundar
>> <Shyam-sundar.S-k@amd.com>
>> Cc: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>; Raul Rangel
>> <rrangel@chromium.org>; Mark Gross <markgross@kernel.org>; platform-
>> driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] platform/x86/amd: pmc: Add a workaround for an s0i3
>> issue on Cezanne
>>
>> Hi,
>>
>> On 11/17/22 17:06, Limonciello, Mario wrote:
>>> [Public]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Hans de Goede <hdegoede@redhat.com>
>>>> Sent: Thursday, November 17, 2022 08:06
>>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; S-k, Shyam-sundar
>>>> <Shyam-sundar.S-k@amd.com>
>>>> Cc: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>; Raul Rangel
>>>> <rrangel@chromium.org>; Mark Gross <markgross@kernel.org>;
>> platform-
>>>> driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH] platform/x86/amd: pmc: Add a workaround for an
>> s0i3
>>>> issue on Cezanne
>>>>
>>>> Hi Mario,
>>>>
>>>> On 11/16/22 16:43, Mario Limonciello wrote:
>>>>> Cezanne platforms under the right circumstances have a synchronization
>>>>> problem where attempting to enter s2idle may fail if the x86 cores are
>>>>> put into HLT before hardware resume from the previous attempt has
>>>>> completed.
>>>>>
>>>>> To avoid this issue add a 10-20ms delay before entering s2idle another
>>>>> time. This workaround will only be applied on interrupts that wake the
>>>>> hardware but don't break the s2idle loop.
>>>>>
>>>>> Cc: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>
>>>>> Cc: "Raul Rangel" <rrangel@chromium.org>
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> Thank you for your patch, I've applied this patch to my review-hans
>>>> branch:
>>>>
>> https://git.k
 %2F&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cb3c04b4449
>> 154cad4f8208dac8b61509%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C
>> 0%7C638042981632459900%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
>> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
>> 7C%7C&amp;sdata=3ZzdcI0BsHknBInf8V4MfrmNCkkc2U9ygYf4IP25LJ4%3D&
>> amp;reserved=0
>>  ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fpdx86%2Fplatform-
>>>> drivers-x86.git%2Flog%2F%3Fh%3Dreview-
>>>>
>> hans&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C674f8bf7a8
>>>>
>> 114f83a3b408dac8a4d941%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C
>>>>
>> 0%7C638042907591739047%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
>>>>
>> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
>>>>
>> 7C%7C&amp;sdata=XYwl%2FOvUFy%2Bgz9EY9oa35M%2BkLf%2Bud8PKXynQ
>>>> FlrUdoE%3D&amp;reserved=0
>>>>
>>>> Please let me know if it important to get this as a fix into 6.1,
>>>> I wasn't really planning on doing any more fixes pull-reqs for 6.1,
>>>> but I can do one if necessary.
>>>>
>>>
>>> AFAIK it's a corner case.  I think it can wait until 6.2, but I think it should
>> probably
>>> be Cc to 6.1 stable (which has the ability to run code in the check()) phase.
>>
>> Ok, I have added a:
>>
>> Cc: stable@vger.kernel.org # 6.1
>>
>> to the commit msg.
>>
>> Regards,
>>
>> Hans
> 
> Hi Hans,
> 
> I just wanted to update you on this workaround.  Previously it was believed to
> only be a very specific set of circumstances that happened on chromebooks running
> coreboot and an EC running cros_ec being utilized with unfortunate timing.
> 
> However it turns out that it can be "relatively" easily reproduced on UEFI machines
> as well though by suspending the laptop and then issuing anything that causes an
> ACPI event that otherwise shouldn't break the s2idle loop (such as closing the lid or
> unplugging the power adapter).
> 
> What will happen is that the SOC enters the deepest state up until the time of that
> ACPI event and then never enters again.  The most common case this will break I think
> is someone suspends the laptop in GNOME, closes the lid and then tosses it in their bag.
> If you examine /sys/kernel/debug/amd_pmc/* you'll see that the duration of time in
> deepest state matches the time between suspending in GNOME and closing the lid.
> 
> I wanted to provide you that context to decide if this should still try to catch this in
> a 6.1 final pull request or not.  Had I known how widely this helped at that time I
> would have advocated accordingly.

Based on the above I have prepared a pull-req to Linus with just this single
patch in it to get this added to 6.1 .

I'll Cc you on the pull-req submission to Linus.

Regards,

Hans





>>>>> ---
>>>>>  drivers/platform/x86/amd/pmc.c | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/drivers/platform/x86/amd/pmc.c
>>>> b/drivers/platform/x86/amd/pmc.c
>>>>> index ef4ae977b8e0..439d282aafd1 100644
>>>>> --- a/drivers/platform/x86/amd/pmc.c
>>>>> +++ b/drivers/platform/x86/amd/pmc.c
>>>>> @@ -739,8 +739,14 @@ static void amd_pmc_s2idle_prepare(void)
>>>>>  static void amd_pmc_s2idle_check(void)
>>>>>  {
>>>>>   struct amd_pmc_dev *pdev = &pmc;
>>>>> + struct smu_metrics table;
>>>>>   int rc;
>>>>>
>>>>> + /* CZN: Ensure that future s0i3 entry attempts at least 10ms passed
>>>> */
>>>>> + if (pdev->cpu_id == AMD_CPU_ID_CZN &&
>>>> !get_metrics_table(pdev, &table) &&
>>>>> +     table.s0i3_last_entry_status)
>>>>> +         usleep_range(10000, 20000);
>>>>> +
>>>>>   /* Dump the IdleMask before we add to the STB */
>>>>>   amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
>>>>>
>>>
> 

