Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22E064E1BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLOT1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLOT05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:26:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E0D240AA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671132370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k17e/Mk6eHKUDmv6kqGv2CShAAzfB9x794ipMxN57Fc=;
        b=LoxyhnZhbWwjzuv/aQFj+22oJ1OoUSninsI6sMxtHX57gcjp9cUUoIKp3EDETfdeiCCnCG
        ejyHu6dGD55my17a22eytZ/Bm5CyQoBAh7Dpvo17liD9Ho877Xhfd65KsaUwKFHr6QkD67
        2JYhAmTvFXh5BvFemI8cVgddBqO60Ks=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-500-MQPQcqShP421BMDKGvgRBQ-1; Thu, 15 Dec 2022 14:26:08 -0500
X-MC-Unique: MQPQcqShP421BMDKGvgRBQ-1
Received: by mail-ej1-f69.google.com with SMTP id nc4-20020a1709071c0400b0078a5ceb571bso247111ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k17e/Mk6eHKUDmv6kqGv2CShAAzfB9x794ipMxN57Fc=;
        b=VtdNg7Pi49Hfs7UqxfJx/WCZVB/ZwuHfaOWiOEzyPm9BOi5/cBGE0lZg9lsxqG6QpJ
         m3a8/mIMu/a+syy0JRLeEonxLKg8+O3cS5aWggdJttjgt21pFFXIddcPHKhNEOkGlcmO
         4Xns54qd0+scnMsV0vIceruCBAmWCbpYHDstbwY7UmjiWzyHPA0SiAwEHB67Y7FhncIT
         rEDCKpd4AxUn3v+s6mVr2sRgmKjPjYLvFVahXLb0UVkScO1mGKTr4XshXa+mel6SVxg2
         y5xAnx2KqW1YWuLzqPiS3psKB7bofWuqv2vjazh+owK+Cn0S8AMeXMZ3qZVYlr68HxzH
         kXHw==
X-Gm-Message-State: ANoB5pmRJC37yeNEL32rJ4K7PGok8xbBeMm+B4+ni8gksuOukPn4oTN6
        twFZCpCib7evwtCIBN9kqQ6AgvVW3XcQvlLt02hpo/PtL1so7xDdhhXSB8rET9YiU2px/Uv/Fgb
        dsoe+y/vVI0bG5mPOIZshZ5GT
X-Received: by 2002:a17:906:fd53:b0:7c0:a247:2f3c with SMTP id wi19-20020a170906fd5300b007c0a2472f3cmr21059853ejb.1.1671132367687;
        Thu, 15 Dec 2022 11:26:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6ayknZX2ePYKmi2XB/Q9rAXw9e8NE9TQVAIGeD+8XmOtD/KU7pqPJVef/gaStp+B4H/Un5TA==
X-Received: by 2002:a17:906:fd53:b0:7c0:a247:2f3c with SMTP id wi19-20020a170906fd5300b007c0a2472f3cmr21059842ejb.1.1671132367467;
        Thu, 15 Dec 2022 11:26:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906329500b0078d3f96d293sm5469ejw.30.2022.12.15.11.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 11:26:06 -0800 (PST)
Message-ID: <249c1aa2-07a1-3e25-b5d6-929da32c47d3@redhat.com>
Date:   Thu, 15 Dec 2022 20:26:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] i2c: designware: Fix unbalanced suspended flag
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        jsd@semihalf.com, wsa@kernel.org
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20221213144524.368297-1-rf@opensource.cirrus.com>
 <8cf30cb2-6dec-b21b-ba15-f21490546426@redhat.com>
 <a467bab2-c3b0-0515-cb4a-66711b972115@linux.intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <a467bab2-c3b0-0515-cb4a-66711b972115@linux.intel.com>
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

On 12/15/22 16:09, Jarkko Nikula wrote:
> Hi
> 
> On 12/14/22 13:28, Hans de Goede wrote:
>> Hi Richard,
>>
>> On 12/13/22 15:45, Richard Fitzgerald wrote:
>>> Ensure that i2c_mark_adapter_suspended() is always balanced by a call to
>>> i2c_mark_adapter_resumed().
>>>
>>> dw_i2c_plat_resume() must always be called, so that
>>> i2c_mark_adapter_resumed() is called. This is not compatible with
>>> DPM_FLAG_MAY_SKIP_RESUME.
>>>
>>> The pairing of pm_runtime_force_suspend() and pm_runtime_force_resume()
>>> can replace this. If nothing is using the driver, and it is not currently
>>> suspended, it will be put into runtime-suspend and will be left in
>>> runtime-suspend during the system resume.
>>>
>>> pm_runtime_force_suspend() is not compatible with DPM_FLAG_SMART_SUSPEND
>>> so this must also be removed. DPM_FLAG_SMART_SUSPEND will set the device
>>> back to pm_runtime_active() during resume_noirq if it cannot skip resume.
>>> This would lead to the inconsistent state where the driver runtime_suspend
>>> has been called (by force_suspend()) but it is marked active (by PM core).
>>>
>>> The unbalanced suspended flag was introduced by
>>> commit c57813b8b288 ("i2c: designware: Lock the adapter while setting the
>>> suspended flag")
>>>
>>> Before that commit, the system and runtime PM used the same functions. The
>>> DPM_FLAG_MAY_SKIP_RESUME was used to skip the system resume if the driver
>>> had been in runtime-suspend. If system resume was skipped, the suspended
>>> flag would be cleared by the next runtime resume. The check of the
>>> suspended flag was _after_ the call to pm_runtime_get_sync() in
>>> i2c_dw_xfer(). So either a system resume or a runtime resume would clear
>>> the flag before it was checked.
>>>
>>> Having introduced the unbalanced suspended flag with that commit, a further
>>> commit 80704a84a9f8 ("i2c: designware: Use the
>>> i2c_mark_adapter_suspended/resumed() helpers")
>>>
>>> changed from using a local suspended flag to using the
>>> i2c_mark_adapter_suspended/resumed() functions. These use a flag that is
>>> checked by I2C core code before issuing the transfer to the bus driver, so
>>> there was no opportunity for the bus driver to runtime resume itself before
>>> the flag check.
>>>
>>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>>> Fixes: c57813b8b288 ("i2c: designware: Lock the adapter while setting the suspended flag")
>>
>> Thank you. I like the new approach in this version.
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
> I noticed a resume regression with this patch but not all machines and only when resuming from s2idle. After resume all devices on those machines are in D0 even their runtime state show they are suspended. Works with v6.1.
> 
> - Baytrail based MRD7 with one I2C bus shared with PUNIT
> 
> After boot. All ok (5th bus is shared with PUNIT and not power managed)
> 
> cat /sys/bus/platform/devices/80860F41\:0*/power/runtime_status
> suspended
> suspended
> suspended
> suspended
> active
> 
> cat /sys/bus/platform/devices/80860F41\:0*/firmware_node/power_state
> D3hot
> D3hot
> D3hot
> D3hot
> D0
> 
> After suspend-to-idle (s2idle) resume cycle. Devices stay in D0
> 
> cat /sys/bus/platform/devices/80860F41\:0*/power/runtime_status
> suspended
> suspended
> suspended
> suspended
> active
> 
> cat /sys/bus/platform/devices/80860F41\:0*/firmware_node/power_state
> D0
> D0
> D0
> D0
> D0

Ah yes this makes sense. We leave the device runtime-suspended,
but since the system-level resume handler does run, the ACPI
pm domain resume handler also has ran before calling the
driver level callback and the acpi pm domain handler will have
put the device in D0 before calling the driver level
resume handler.

So now the device actually is in D0 while the pm-core
thinks it is left in runtime-suspended state, so it
will not runtime suspend it later, as would happen when
not using force_runtime-suspend + force-runtime-resume (*).

So yeah this is not going to work. I think instead we need
to go back to v1 together with the changes which I proposed
for v1. As I mentioned when reviewing v1, v1 is not prefect,
but it really is an ok solution to this.

Regards,

Hans


*) which does not actually always runtime resume despite
its name



