Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56362E121
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiKQQKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbiKQQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:10:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED91A79923
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668701354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTydP8D68mFHBn/QMPq/BVX9AdVep5BUs2AxfXVsOWk=;
        b=X6w8IVCj6R+a5Xhkgj8RtX9opBiuhXOicNqvyak9+EXSoXXhNNuDtVDpuSAyIt/D+1GKFx
        JgCGAYLsCKr3WzxykvzDKFpj9nyI6iad0U+g0MCVRl3EH3UNpf9+sxCANakVubTtYAIOGo
        0D4OE3jogcRDkCFkBvmh6zN03Iyx9xk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-403-LfMdWfaAOFiN0CjsRsuEwQ-1; Thu, 17 Nov 2022 11:09:09 -0500
X-MC-Unique: LfMdWfaAOFiN0CjsRsuEwQ-1
Received: by mail-ed1-f70.google.com with SMTP id x18-20020a05640226d200b00461e027f704so1518445edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTydP8D68mFHBn/QMPq/BVX9AdVep5BUs2AxfXVsOWk=;
        b=U4vxBpVrxel4ENssPnvswquwGHNGC+tSTNdbpGx4qWhPq9QatdrLkDFmJcz30q31YH
         TaCFE4B9GSP3CR07qBCZGqKXKa3wEMHolr7cDqHq8PdIKQgSypt79X3g6aEi0Y8/FK6K
         Tmwkws1qX+J4DazpMSe7+0zwtj+tBOjpVTvMVofFxKH9tPvG2MajCMIGgdEiT55ORnHu
         KcVcd/rQ9L2IN3RykOsxXC93he686mc0NxSRzN5ff+ZM4VVoJi3jPd1oGY/O40mtFjPY
         azoyGyrPRTmvnGvkZPd13DBUiIDucKSBAOeUootIccav0jod1GnG37FdLEwuNPmFor8k
         +T+A==
X-Gm-Message-State: ANoB5pkAlmATXRUHntK6ogBkwNo3emBnYPfdVPiV71qp1TEARP98DUnr
        KcvnBIOLBqm9e3L4lJ5rarrV7w+lW8+i8sxwb95FqMsq4MJ5zYodCg0DWJk33gjhCrtUWVwXNED
        aMAcNkwXCuGG0qFqOI6Iu0ixy
X-Received: by 2002:a05:6402:4311:b0:458:c66a:3664 with SMTP id m17-20020a056402431100b00458c66a3664mr2750772edc.79.1668701345723;
        Thu, 17 Nov 2022 08:09:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7OqedPTWE1KhaRZF8u06wf7CTyTqcmJQezsFirWy+OSvIjZmkh36n9rrUoIjhMP/4mr8S3eQ==
X-Received: by 2002:a05:6402:4311:b0:458:c66a:3664 with SMTP id m17-20020a056402431100b00458c66a3664mr2750755edc.79.1668701345484;
        Thu, 17 Nov 2022 08:09:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090631c400b00730bfe6adc4sm551618ejf.37.2022.11.17.08.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 08:09:04 -0800 (PST)
Message-ID: <22d62cb7-17f4-c8d2-40fa-987bb2a4a0fa@redhat.com>
Date:   Thu, 17 Nov 2022 17:09:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] platform/x86/amd: pmc: Add a workaround for an s0i3 issue
 on Cezanne
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Cc:     "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>,
        Raul Rangel <rrangel@chromium.org>,
        Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221116154341.13382-1-mario.limonciello@amd.com>
 <0d9f8f8c-3b45-dd6a-008b-6d9ffe8ccc93@redhat.com>
 <MN0PR12MB6101F972282D66202C95C0F2E2069@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <MN0PR12MB6101F972282D66202C95C0F2E2069@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 11/17/22 17:06, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Thursday, November 17, 2022 08:06
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; S-k, Shyam-sundar
>> <Shyam-sundar.S-k@amd.com>
>> Cc: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>; Raul Rangel
>> <rrangel@chromium.org>; Mark Gross <markgross@kernel.org>; platform-
>> driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] platform/x86/amd: pmc: Add a workaround for an s0i3
>> issue on Cezanne
>>
>> Hi Mario,
>>
>> On 11/16/22 16:43, Mario Limonciello wrote:
>>> Cezanne platforms under the right circumstances have a synchronization
>>> problem where attempting to enter s2idle may fail if the x86 cores are
>>> put into HLT before hardware resume from the previous attempt has
>>> completed.
>>>
>>> To avoid this issue add a 10-20ms delay before entering s2idle another
>>> time. This workaround will only be applied on interrupts that wake the
>>> hardware but don't break the s2idle loop.
>>>
>>> Cc: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>
>>> Cc: "Raul Rangel" <rrangel@chromium.org>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Thank you for your patch, I've applied this patch to my review-hans
>> branch:
>> https://git.k
 ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fpdx86%2Fplatform-
>> drivers-x86.git%2Flog%2F%3Fh%3Dreview-
>> hans&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C674f8bf7a8
>> 114f83a3b408dac8a4d941%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C
>> 0%7C638042907591739047%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
>> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
>> 7C%7C&amp;sdata=XYwl%2FOvUFy%2Bgz9EY9oa35M%2BkLf%2Bud8PKXynQ
>> FlrUdoE%3D&amp;reserved=0
>>
>> Please let me know if it important to get this as a fix into 6.1,
>> I wasn't really planning on doing any more fixes pull-reqs for 6.1,
>> but I can do one if necessary.
>>
> 
> AFAIK it's a corner case.  I think it can wait until 6.2, but I think it should probably
> be Cc to 6.1 stable (which has the ability to run code in the check()) phase.

Ok, I have added a:

Cc: stable@vger.kernel.org # 6.1

to the commit msg.

Regards,

Hans



>>> ---
>>>  drivers/platform/x86/amd/pmc.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/amd/pmc.c
>> b/drivers/platform/x86/amd/pmc.c
>>> index ef4ae977b8e0..439d282aafd1 100644
>>> --- a/drivers/platform/x86/amd/pmc.c
>>> +++ b/drivers/platform/x86/amd/pmc.c
>>> @@ -739,8 +739,14 @@ static void amd_pmc_s2idle_prepare(void)
>>>  static void amd_pmc_s2idle_check(void)
>>>  {
>>>  	struct amd_pmc_dev *pdev = &pmc;
>>> +	struct smu_metrics table;
>>>  	int rc;
>>>
>>> +	/* CZN: Ensure that future s0i3 entry attempts at least 10ms passed
>> */
>>> +	if (pdev->cpu_id == AMD_CPU_ID_CZN &&
>> !get_metrics_table(pdev, &table) &&
>>> +	    table.s0i3_last_entry_status)
>>> +		usleep_range(10000, 20000);
>>> +
>>>  	/* Dump the IdleMask before we add to the STB */
>>>  	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
>>>
> 

