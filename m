Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F236A7039
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCAPvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCAPu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:50:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E074A1FC1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 07:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677685798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AISHGjJjYVMMIfHCSToeO8g4eUX3yHF7SiWG71ynO/8=;
        b=FuW8TQccQfSgH0hTPagdywgN+TmdktvySdaNGojbLhVC7zAD56nWnUw3SixoGP14gkNdxp
        Sv2fTDaaYURF9IEIRXH5kWI7uwkMuZ0iYvtZ0n2sxslB6tUaqY2cnk74L/wxcQ+SGO+ORS
        SyTlMlHOTBTVQ1SM58DXi/hvWFYNRkY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-474-W8qhkqkYNrqEcwMTI7hERA-1; Wed, 01 Mar 2023 10:49:57 -0500
X-MC-Unique: W8qhkqkYNrqEcwMTI7hERA-1
Received: by mail-ed1-f70.google.com with SMTP id q13-20020a5085cd000000b004af50de0bcfso20082189edh.15
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 07:49:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AISHGjJjYVMMIfHCSToeO8g4eUX3yHF7SiWG71ynO/8=;
        b=W8iW86y9AvTCzx8UKKun0+bGo/4neANlUGSDQISFuO5nKlY8gArM7ChaAfJY2ZFY3s
         yQaB5w1boND3t1VJ09tlHOO55+eIQASQa+xxhwbL5RZPg3/OduaDkPjjx1t1/RBbHKW7
         7T+KOLH/XLNj0YT+3dkPizDUgMrLd3Q5hpLS6G7O08ve9yf5ehnRWYq/K3Z1rF3CSIT7
         07kBf9+2ruehQpeiEp9QphpGRywMwW3yQH9vj6XEpujEoqFOcvvBoPOjWPPlykzniuc+
         wuvAuycrQ6V5EDdevJUM5t9rrXwdlzSQ5rAIzLrhXmr9y6GxIFYXPa4tK9UaUqsiEW8p
         mAjg==
X-Gm-Message-State: AO0yUKVWHrAHnC0yb78cGyxUhiPbM0unCZg51sqxOOS+VY2fq4fk0wpZ
        WKcQdmQ/BXUo/g7Dwe1deT2xHjXhm4Uw1ZmWYIyoJM+Yo8PV6uDM7Yq1THK+ViQBcGBtO11248U
        Xxx1JQBhjwRqReofFC5kH/K5r
X-Received: by 2002:a05:6402:10d5:b0:4ac:b6db:3ed0 with SMTP id p21-20020a05640210d500b004acb6db3ed0mr7313742edu.39.1677685795927;
        Wed, 01 Mar 2023 07:49:55 -0800 (PST)
X-Google-Smtp-Source: AK7set9d0y8bgwPIp/JhPoiyI1q3lg6Jl6SiK7ImM6P89ObUMArG3y02qfGDtpYyXbYhd4PEFe3Nkg==
X-Received: by 2002:a05:6402:10d5:b0:4ac:b6db:3ed0 with SMTP id p21-20020a05640210d500b004acb6db3ed0mr7313727edu.39.1677685795651;
        Wed, 01 Mar 2023 07:49:55 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 13-20020a508e0d000000b004af6e957b22sm5834727edw.6.2023.03.01.07.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 07:49:55 -0800 (PST)
Message-ID: <c2090596-3aab-fc1a-4fdf-f28f688cc666@redhat.com>
Date:   Wed, 1 Mar 2023 16:49:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for checking
 minimum SMU version
Content-Language: en-US, nl
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Cc:     Mark Gross <markgross@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230301150821.9791-1-mario.limonciello@amd.com>
 <846d6f46-07ab-4d4a-5623-417a469c3d0b@redhat.com>
 <MN0PR12MB6101781FC5089EA217CA48A9E2AD9@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <MN0PR12MB6101781FC5089EA217CA48A9E2AD9@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/1/23 16:31, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Hans de Goede <hdegoede@redhat.com>
>> Sent: Wednesday, March 1, 2023 09:28
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; S-k, Shyam-sundar
>> <Shyam-sundar.S-k@amd.com>
>> Cc: Mark Gross <markgross@kernel.org>; platform-driver-
>> x86@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/2] platform/x86/amd: pmc: Add a helper for checking
>> minimum SMU version
>>
>> Hi,
>>
>> On 3/1/23 16:08, Mario Limonciello wrote:
>>> In a few locations there is some boilerplate code for checking
>>> minimum SMU version.  Switch this to a helper for this check.
>>>
>>> No intended functional changes.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>  drivers/platform/x86/amd/pmc.c | 49 +++++++++++++++++-----------------
>>>  1 file changed, 24 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/amd/pmc.c
>> b/drivers/platform/x86/amd/pmc.c
>>> index 2edaae04a691..c42fa47381c3 100644
>>> --- a/drivers/platform/x86/amd/pmc.c
>>> +++ b/drivers/platform/x86/amd/pmc.c
>>> @@ -418,6 +418,22 @@ static int amd_pmc_get_smu_version(struct
>> amd_pmc_dev *dev)
>>>  	return 0;
>>>  }
>>>
>>> +static bool amd_pmc_verify_min_version(struct amd_pmc_dev *pdev,
>> int major, int minor)
>>> +{
>>> +	if (!pdev->major) {
>>> +		int rc = amd_pmc_get_smu_version(pdev);
>>> +
>>> +		if (rc) {
>>> +			dev_warn(pdev->dev, "failed to read SMU version:
>> %d\n", rc);
>>> +			return false;
>>> +		}
>>> +	}
>>> +	if (pdev->major > major)
>>> +		return true;
>>> +
>>> +	return pdev->major == major && pdev->minor >= minor;
>>> +}
>>> +
>>>  static ssize_t smu_fw_version_show(struct device *d, struct
>> device_attribute *attr,
>>>  				   char *buf)
>>>  {
>>> @@ -526,14 +542,7 @@ static int amd_pmc_idlemask_show(struct seq_file
>> *s, void *unused)
>>>  	struct amd_pmc_dev *dev = s->private;
>>>  	int rc;
>>>
>>> -	/* we haven't yet read SMU version */
>>> -	if (!dev->major) {
>>> -		rc = amd_pmc_get_smu_version(dev);
>>> -		if (rc)
>>> -			return rc;
>>> -	}
>>> -
>>> -	if (dev->major > 56 || (dev->major >= 55 && dev->minor >= 37)) {
>>
>> The 2 major checks here originally were not in sync, so for major == 55
>> *and* major == 56 it would only succeed if minor >= 37.
>>
>> Where as after this patch for major == 56 it will now always succeed.
>>
>> This feels like a bug in the original code, but might have been
>> intentional ? Please verify this.
> 
> @S-k, Shyam-sundar as the original author of that, can you please confirm?
> 
>>
>> After verifying please post a v2 updating the commit message to
>> point out this functional change.
>>
> 
> Sure, thanks.
> 
>>> +	if (amd_pmc_verify_min_version(dev, 55, 37)) {
>>>  		rc = amd_pmc_idlemask_read(dev, NULL, s);
>>>  		if (rc)
>>>  			return rc;
>>> @@ -686,15 +695,8 @@ static int amd_pmc_get_os_hint(struct
>> amd_pmc_dev *dev)
>>>  static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
>>>  {
>>>  	struct device *d;
>>> -	int rc;
>>>
>>> -	if (!pdev->major) {
>>> -		rc = amd_pmc_get_smu_version(pdev);
>>> -		if (rc)
>>> -			return rc;
>>> -	}
>>> -
>>> -	if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
>>> +	if (amd_pmc_verify_min_version(pdev, 64, 66))
>>>  		return 0;
>>>
>>>  	d = bus_find_device_by_name(&serio_bus, NULL, "serio0");
>>> @@ -718,14 +720,10 @@ static int amd_pmc_verify_czn_rtc(struct
>> amd_pmc_dev *pdev, u32 *arg)
>>>  	struct rtc_time tm;
>>>  	int rc;
>>>
>>> -	/* we haven't yet read SMU version */
>>> -	if (!pdev->major) {
>>> -		rc = amd_pmc_get_smu_version(pdev);
>>> -		if (rc)
>>> -			return rc;
>>> -	}
>>> +	if (disable_workarounds)
>>> +		return 0;
>>>
>>> -	if (pdev->major < 64 || (pdev->major == 64 && pdev->minor < 53))
>>> +	if (!amd_pmc_verify_min_version(pdev, 64, 53))
>>>  		return 0;
>>>
>>>  	rtc_device = rtc_class_open("rtc0");
>>> @@ -772,13 +770,14 @@ static void amd_pmc_s2idle_prepare(void)
>>>  	/* Reset and Start SMU logging - to monitor the s0i3 stats */
>>>  	amd_pmc_setup_smu_logging(pdev);
>>>
>>> -	/* Activate CZN specific platform bug workarounds */
>>> -	if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
>>> +	switch (pdev->cpu_id) {
>>> +	case AMD_CPU_ID_CZN:
>>>  		rc = amd_pmc_verify_czn_rtc(pdev, &arg);
>>>  		if (rc) {
>>>  			dev_err(pdev->dev, "failed to set RTC: %d\n", rc);
>>>  			return;
>>>  		}
>>> +		break;
>>>  	}
>>>
>>>  	msg = amd_pmc_get_os_hint(pdev);
>>
>>
>> Patch 2/2 looks good to me.
>>
>> Should I queue v2 (once posted) up as a fix for 6.3-rc#  ?
> 
> Yes please.  If it makes it easier I can re-order the series so that
> we add a check in 1/2 and switch to the helper as 2/2.
> 
> This might make it easier to take the LTS kernel too for stable,
> but I don't feel strongly.

I'm fine with keeping the order as is, I'm also fine with swapping it :)

Regards,

Hans



