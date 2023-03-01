Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0E06A6EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjCAOrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCAOrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:47:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8114391E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677681970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7X8XcutB/2RYQg/eBgt08BJzkG/fmKxEe2sBmV6RkF4=;
        b=UV8/+cOv53MBs5RVL/+M4isSADDe/7iwl6fhbro6mS4IgJqMb+gbC8li1+wuPXlPX1MjaL
        D+VGflvo270BTQGkOFYs9DI8gUxEWZb250bXo9IpkyUGpLIdxSBHFiwB4T3lOJYlaCQvvY
        TlC+rF+n6KJCWF9aPFgI4bDOI/z4xFg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-UjvGNKdBOGyg-Jv00DxicA-1; Wed, 01 Mar 2023 09:46:09 -0500
X-MC-Unique: UjvGNKdBOGyg-Jv00DxicA-1
Received: by mail-ed1-f72.google.com with SMTP id b1-20020aa7dc01000000b004ad062fee5eso19329303edu.17
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7X8XcutB/2RYQg/eBgt08BJzkG/fmKxEe2sBmV6RkF4=;
        b=ugmncu5NK8iBE+jv8T0TrxmOGPUNH30nssklrGFwoTgqa/ZXjP8SkAzDF6AFV5EBGp
         EaQ8gGLZgU93HI9qKOnSHqkE1/4w2ZcNPKlA3/5bDCqJYI9C4oQJmInz8DZtQjmfk/WK
         b3tN53BIIQz7OU+yDxtyZfWv7rXQaUC2LQ0hzrWSlORdsUfktSlu5PiG+9GoRGTw2UXW
         WzWAZIJ+QajRIUeltzETQVna5B8b7nYIAHx71cffJ7z/G388kYqn43h3bNrIAdK35u+J
         axsrgmnxqR8MF84v+6W17PK3YCCpQVUQhVwFJeV01jYyCqFDHjyRRUWsXheA4tPKzSLN
         9nOQ==
X-Gm-Message-State: AO0yUKXjK0FTNFvPkH+FZvG59XPvmbRvSobgjuNcIdRgptqtGXV1EWk+
        +V9jc60o3zlMBodBbjF+Brv45ZNxFT0q4MoZM4fgWcLi4Hz9DnndsVuvFP3aCaY+e+SHUQMtlDD
        PYCuFBg8NWs3yAJuMJq6coaTN4S54TA==
X-Received: by 2002:a17:906:2b8d:b0:8a9:f870:d25b with SMTP id m13-20020a1709062b8d00b008a9f870d25bmr6476806ejg.15.1677681967524;
        Wed, 01 Mar 2023 06:46:07 -0800 (PST)
X-Google-Smtp-Source: AK7set/PLKqoHcBrGi9S63DBzM/wtrKE/Xd5FNJZeI9iH/GmjoNRdL+tQtJkxMc+BzwYVlmoaLcozw==
X-Received: by 2002:a17:906:2b8d:b0:8a9:f870:d25b with SMTP id m13-20020a1709062b8d00b008a9f870d25bmr6476788ejg.15.1677681967196;
        Wed, 01 Mar 2023 06:46:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id k12-20020a508acc000000b004af71e8cc3dsm5675440edk.60.2023.03.01.06.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 06:46:06 -0800 (PST)
Message-ID: <9367d0f5-815a-e870-c8d0-047ca9f81c3f@redhat.com>
Date:   Wed, 1 Mar 2023 15:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 05/12] platform/x86: ISST: Add support for MSR 0x54
Content-Language: en-US, nl
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
 <20230211063257.311746-6-srinivas.pandruvada@linux.intel.com>
 <1950741c-b5a9-6883-0c16-391001540a25@redhat.com>
 <d79bc5e85ca61cbd978d7b9b349e076b7b94770a.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d79bc5e85ca61cbd978d7b9b349e076b7b94770a.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 3/1/23 15:41, srinivas pandruvada wrote:
> On Wed, 2023-03-01 at 15:30 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 2/11/23 07:32, Srinivas Pandruvada wrote:
>>> To map Linux CPU numbering scheme to hardware CPU numbering scheme
>>> MSR 0x53 is getting used. But for new generation of CPUs, this MSR
>>> is not valid. Since this is model specific MSR, this is possible.
>>>
>>> A new MSR 0x54 is defined. Use this MSR and convert the IOCTL
>>> format
>>> to match existing MSR 0x53, in this case user spaces don't need to
>>> be aware of this change.
>>>
>>> Signed-off-by: Srinivas Pandruvada
>>> <srinivas.pandruvada@linux.intel.com>
>>
>> I am not a fan of this. I expect that users of these new CPUs will
>> very likely also need a new intel-speed-select userspace tool
>> regardless
>> of doing this MSR munging/shuffling in the kernel. So why not fix
>> the tool to teach it about the MSR instead ?
> 
> Sure.
> 
> I can remove the format conversion in the kernel, so that user space
> tool will do that.
> 
> I think that's what you mean.

Yes that is what I mean.

>> If you have good arguments for doing this in the kernel please
>> add them the commit message for the next version, but my initial
>> reaction to this is that it is wrong to do this in the kernel
>> and that the tool should be fixed instead. So my preference
>> would be for this patch to be dropped from the next version of
>> the patch-set.
> 
> Since we can't read MSR from user space, this patch is still required
> to read only MSR 0x54. Just it will not do any format conversion. So
> format conversion will happen in user space tool.

Yes that would be great, having the kernel read the MSR is fine
(of course).

Regards,

Hans



>>> ---
>>>  .../intel/speed_select_if/isst_if_common.c    | 51
>>> +++++++++++++++++++
>>>  1 file changed, 51 insertions(+)
>>>
>>> diff --git
>>> a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>>> b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>>> index 60e58b0b3835..97d1b4566535 100644
>>> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>>> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
>>> @@ -19,9 +19,13 @@
>>>  #include <linux/uaccess.h>
>>>  #include <uapi/linux/isst_if.h>
>>>  
>>> +#include <asm/cpu_device_id.h>
>>> +#include <asm/intel-family.h>
>>> +
>>>  #include "isst_if_common.h"
>>>  
>>>  #define MSR_THREAD_ID_INFO     0x53
>>> +#define MSR_PM_LOGICAL_ID      0x54
>>>  #define MSR_CPU_BUS_NUMBER     0x128
>>>  
>>>  static struct isst_if_cmd_cb punit_callbacks[ISST_IF_DEV_MAX];
>>> @@ -31,6 +35,7 @@ static int punit_msr_white_list[] = {
>>>         MSR_CONFIG_TDP_CONTROL,
>>>         MSR_TURBO_RATIO_LIMIT1,
>>>         MSR_TURBO_RATIO_LIMIT2,
>>> +       MSR_PM_LOGICAL_ID,
>>>  };
>>>  
>>>  struct isst_valid_cmd_ranges {
>>> @@ -73,6 +78,8 @@ struct isst_cmd {
>>>         u32 param;
>>>  };
>>>  
>>> +static bool isst_hpm_support;
>>> +
>>>  static DECLARE_HASHTABLE(isst_hash, 8);
>>>  static DEFINE_MUTEX(isst_hash_lock);
>>>  
>>> @@ -411,11 +418,43 @@ static int isst_if_cpu_online(unsigned int
>>> cpu)
>>>                 isst_cpu_info[cpu].pci_dev[1] =
>>> _isst_if_get_pci_dev(cpu, 1, 30, 1);
>>>         }
>>>  
>>> +       if (isst_hpm_support) {
>>> +               u64 raw_data;
>>> +
>>> +               ret = rdmsrl_safe(MSR_PM_LOGICAL_ID, &raw_data);
>>> +               if (!ret) {
>>> +                       /*
>>> +                        * Use the same format as MSR 53, for user
>>> space harmony
>>> +                        *  Format
>>> +                        *      Bit 0 – thread ID
>>> +                        *      Bit 8:1 – core ID
>>> +                        *      Bit 13:9 – Compute domain ID (aka
>>> die ID)
>>> +                        * From the MSR 0x54 format
>>> +                        *      [15:11] PM_DOMAIN_ID
>>> +                        *      [10:3] MODULE_ID (aka IDI_AGENT_ID)
>>> +                        *      [2:0] LP_ID (We don't care about
>>> these bits we only
>>> +                        *                      care die and core
>>> id
>>> +                        *      For Atom:
>>> +                        *              [2] Always 0
>>> +                        *              [1:0] core ID within module
>>> +                        *      For Core
>>> +                        *              [2:1] Always 0
>>> +                        *              [0] thread ID
>>> +                        */
>>> +                       data = (raw_data >> 11) & 0x1f;
>>> +                       data <<= 9;
>>> +                       data |= (((raw_data >> 3) & 0xff) << 1);
>>> +                       goto set_punit_id;
>>> +               }
>>> +       }
>>> +
>>>         ret = rdmsrl_safe(MSR_THREAD_ID_INFO, &data);
>>>         if (ret) {
>>>                 isst_cpu_info[cpu].punit_cpu_id = -1;
>>>                 return ret;
>>>         }
>>> +
>>> +set_punit_id:
>>>         isst_cpu_info[cpu].punit_cpu_id = data;
>>>  
>>>         isst_restore_msr_local(cpu);
>>> @@ -704,6 +743,12 @@ static struct miscdevice isst_if_char_driver =
>>> {
>>>         .fops           = &isst_if_char_driver_ops,
>>>  };
>>>  
>>> +static const struct x86_cpu_id hpm_cpu_ids[] = {
>>> +       X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,     NULL),
>>> +       X86_MATCH_INTEL_FAM6_MODEL(SIERRAFOREST_X,      NULL),
>>> +       {}
>>> +};
>>> +
>>>  static int isst_misc_reg(void)
>>>  {
>>>         mutex_lock(&punit_misc_dev_reg_lock);
>>> @@ -711,6 +756,12 @@ static int isst_misc_reg(void)
>>>                 goto unlock_exit;
>>>  
>>>         if (!misc_usage_count) {
>>> +               const struct x86_cpu_id *id;
>>> +
>>> +               id = x86_match_cpu(hpm_cpu_ids);
>>> +               if (id)
>>> +                       isst_hpm_support = true;
>>> +
>>>                 misc_device_ret = isst_if_cpu_info_init();
>>>                 if (misc_device_ret)
>>>                         goto unlock_exit;
>>
> 

