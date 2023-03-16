Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6632C6BCB3F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjCPJoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCPJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98EACC2C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678959801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P76DINGwLN3jYPnTLgFDgnOUdVkQEqE2bdfQVbKORjo=;
        b=OJRhNPRfVy7fNuiZmLLnVZju5T2KNrr5SsRJcFJpuV3TPpjCNrHzgJTpXRkbH8RnSWGT1j
        GGoVOIxGxp7QD/KVJMDtANRQl6rBPc+F0YBu8DmwFJoTIO3jVxNdDh66XLpkx+2I/C2f1/
        p3fbeuviO5Mwgc2QEJBArNDoYEkhbZw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-xw9eZ-PZPfSFfCY-_eiyMA-1; Thu, 16 Mar 2023 05:43:20 -0400
X-MC-Unique: xw9eZ-PZPfSFfCY-_eiyMA-1
Received: by mail-ed1-f69.google.com with SMTP id w6-20020a05640234c600b004fc0e5b4433so2165101edc.18
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678959799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P76DINGwLN3jYPnTLgFDgnOUdVkQEqE2bdfQVbKORjo=;
        b=wbzgnEEkR0ZVd3CcKkH5xsrZx+LOvbedG7DqXDJz4+nPs8HYAIPqJ+yJPDtZ4L7M8+
         +HmM1Xkla8yDr+CyPk94qTrBHuDfKXYkEakkspydJJsMPDL90JOVRqfWQoGopEYf3qNM
         Y+Bj1QO/4kWynZyjjZjSNOH+HXVkiSVM4zNZ/62RbB57uanAcu+H1se6dyUuNX/eQRfq
         2pEH+BfDo14lydRrCakJ/Qo1oNJpI6G6CvNW2kexUGWLOeLiC3Xddmc4vSADZRKGANv7
         btHoQWqBIsdFlOFykpzO2arBKLc+BLHI1qQlfARyumzszBTzM9D+XAMAMqI2mM0D9If5
         bx2g==
X-Gm-Message-State: AO0yUKXjdWRk4VxQmlE+Zw9MkPZ8Anyqj4NGLylD72LANEJMMHqSVhKS
        ahdfMRBVMlkk7/knWWej4RQ4nFyV4lcDrfjzZ45VGzTOAY1eupTNYtldh3ziH6EZ8jP50nFT4Xp
        SXzCG5u3pZ3igZ0bpYPe3SRF3
X-Received: by 2002:a17:907:c508:b0:92c:6fbf:28 with SMTP id tq8-20020a170907c50800b0092c6fbf0028mr11131713ejc.64.1678959799130;
        Thu, 16 Mar 2023 02:43:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set9ABacgIfpMNu8b5pxHf2TkCJA8LMCLwd2GIJtR06o8lF73WzUup/jJcRknqUbwOk8DJbXvqw==
X-Received: by 2002:a17:907:c508:b0:92c:6fbf:28 with SMTP id tq8-20020a170907c50800b0092c6fbf0028mr11131697ejc.64.1678959798893;
        Thu, 16 Mar 2023 02:43:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id e23-20020a170906375700b008cff300cf47sm3603646ejc.72.2023.03.16.02.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 02:43:18 -0700 (PDT)
Message-ID: <fc45ace6-546c-59cd-016d-906b6bcb1831@redhat.com>
Date:   Thu, 16 Mar 2023 10:43:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/8] platform/x86/intel/ifs: Reorganize driver data
Content-Language: en-US, nl
To:     "Joseph, Jithu" <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230301015942.462799-2-jithu.joseph@intel.com>
 <a6ae936e-effd-3794-e6fb-11b33a4d6eb1@redhat.com>
 <2ae25756-7403-ad5f-548a-50e633040bf9@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2ae25756-7403-ad5f-548a-50e633040bf9@intel.com>
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

On 3/13/23 22:34, Joseph, Jithu wrote:
> 
> 
> On 3/13/2023 7:46 AM, Hans de Goede wrote:
>> Hi Jithu,
>>
>> On 3/1/23 02:59, Jithu Joseph wrote:
> 
>>>  
>>> +struct ifs_const_data {
>>> +	int	integrity_cap_bit;
>>> +	int	test_num;
>>> +};
>>> +
>>
>> This is a description of the specific capabilties / bits of
>> the IFS on e.g. Saphire Rapids, so please name this appropriately
>> for example:
>>
>> struct ifs_hw_caps  {
>> 	int	integrity_cap_bit;
>> 	int	test_num;
>> };
> 
> This can be renamed to ifs_test_caps as it holds test specific fields.

Ack.

>>
>> You got this exactly the wrong way around, there should be a single
>>
>> static const struct ifs_hw_caps saphire_rapids_caps = {
>> 	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
>> 	.test_num = 0,
>> };
>>
>> And then struct ifs_device { } should have a "const struct ifs_hw_caps *hw_caps"
>> which gets initialized to point to &saphire_rapids_caps. So that your const
>> data is actually const.
>>
>> Where as since the r/w data's lifetime is couple to the misc-device lifetime
>> there is no need to dynamically allocate it just keep that embedded, so that
>> together you get:
> 
> Noted 
> 
>>
>> struct ifs_device {
>> 	const struct ifs_hw_caps *hw_caps;
>> 	struct ifs_data data;
>> 	struct miscdevice misc;
>> };
>>
> 
> The initialization portion, taking into account your suggestion above, translates to:

Yes, assuming we go with 1 ifs_device per test type.

Regards,

Hans


> static const struct ifs_test_caps scan_test = {
> 	.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
> 	.test_num = IFS_TYPE_SAF,
> };
> 
> static const struct ifs_test_caps array_test = {
> 	.integrity_cap_bit = MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT,
> 	.test_num = IFS_TYPE_ARRAY_BIST,
> };
> 
> static struct ifs_device ifs_devices[] = {
> 	[IFS_TYPE_SAF] = {
> 		.test_caps = &scan_test,
> 		.misc = {
> 			.name = "intel_ifs_0",
> 			.minor = MISC_DYNAMIC_MINOR,
> 			.groups = plat_ifs_groups,
> 		},
> 	},
> 	[IFS_TYPE_ARRAY_BIST] = {
> 		.test_caps = &array_test,
> 		.misc = {
> 			.name = "intel_ifs_1",
> 			.minor = MISC_DYNAMIC_MINOR,
> 			.groups = plat_ifs_array_groups,
> 		},
> 	},
> };
> 
> Jithu
> 

