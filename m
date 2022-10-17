Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E40601130
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJQOcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiJQOch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0046612D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666017154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ECvCoZJCo97CkQetwaRsUtnWZo3n7fznxRDuF5QXiKQ=;
        b=Ok4ophxKwDMEfsvaNWqa9e3siTTl1RnbF/8zeCW26K7naw4MyrnG6YhzeIQlrYmwzobT3A
        VmBIrI49KWaLxz+GB8ZWYEODxENRfp3kKMGfPgE5xAtbCHKI8P3AXsltoocLxCyE7gyL1R
        jZ78Wy6LoCJyYZwofX0hdAai9sxaGEs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-kAoU2jPdOD6XP4a73arFjA-1; Mon, 17 Oct 2022 10:32:33 -0400
X-MC-Unique: kAoU2jPdOD6XP4a73arFjA-1
Received: by mail-ej1-f70.google.com with SMTP id hp41-20020a1709073e2900b0078e07dbf280so4696384ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECvCoZJCo97CkQetwaRsUtnWZo3n7fznxRDuF5QXiKQ=;
        b=FY5FIgUxCju+xHQnRYabMv8EI0RX4lFntEl0q1z34LLEKx6vCs1kwWtEB1x1ZJIn3L
         JpzJtpV7X5MIj6NryLzj5WVum0tv+5eizUjNeQp6ahi/DfosEqoHjVCVNKne/xKN5En7
         QttHZhUUeypCZagH7nSzzWUZpr2DbUvJ2n80DfaCST356HqKY1VCRF8XiwXRf3BM+hCB
         epcpneaC09V3QxDmEV159EqTz/jxrRM69qhS32tZVE5ScYR8H3CZQNdZV3YqwDlKgtyz
         xJ9UfOG1J9yYK44iOoJt6BiF1UkimiZCaGAa8Gwry+F8hB5VHHoU5YGSovp+3ePUNb9q
         EF5w==
X-Gm-Message-State: ACrzQf3q5d9eMncWp5XtMJ8Mey85dAI6Se8cOpTKNpNj3eS3Ych1KbGD
        OIgYMcfrMljuPcA5/U0f95GhkqWRVIHK0Exz8WMDX29WSExPH4/1QtdISathMWkR1uAW2X4fmL6
        vQUScxlnS3UMi3emliO/Ht4CV
X-Received: by 2002:a05:6402:169a:b0:458:fe61:d3b4 with SMTP id a26-20020a056402169a00b00458fe61d3b4mr10399828edv.140.1666017151781;
        Mon, 17 Oct 2022 07:32:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4swqYxAcbNp265DgIy5ZIEatZ8jOB+JEnRGWO1rH7ZH1tMq5g40Zs16WjhGEou4jtPQG6KbQ==
X-Received: by 2002:a05:6402:169a:b0:458:fe61:d3b4 with SMTP id a26-20020a056402169a00b00458fe61d3b4mr10399813edv.140.1666017151544;
        Mon, 17 Oct 2022 07:32:31 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id cq6-20020a056402220600b00458cc5f802asm7477249edb.73.2022.10.17.07.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 07:32:30 -0700 (PDT)
Message-ID: <490bed5d-8db4-dc31-7aed-bc5941c974c5@redhat.com>
Date:   Mon, 17 Oct 2022 16:32:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-gfx] alderlake crashes (random memory corruption?) with
 6.0 i915 / ucode related
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
 <87a65usvgq.fsf@intel.com> <877d0ysv1e.fsf@intel.com>
 <717fb4ab-5225-884f-37f9-2032c265824e@redhat.com>
 <241af90a-4cec-9266-8fb0-3c69f9880b52@leemhuis.info>
 <fac9a564-edff-db25-20d4-7146ae2a7dc8@redhat.com> <87tu42indv.fsf@intel.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <87tu42indv.fsf@intel.com>
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

Hi,

On 10/17/22 15:35, Jani Nikula wrote:
> On Mon, 17 Oct 2022, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 10/17/22 13:19, Thorsten Leemhuis wrote:
>>> CCing the regression mailing list, as it should be in the loop for all
>>> regressions, as explained here:
>>> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
>>
>> Yes sorry about that I meant to Cc the regressions list, not you personally,
>> but the auto-completion picked the wrong address-book entry
>> (and I did not notice this).
>>
>>> On 17.10.22 12:48, Hans de Goede wrote:
>>>> On 10/17/22 10:39, Jani Nikula wrote:
>>>>> On Mon, 17 Oct 2022, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>>>>> On Thu, 13 Oct 2022, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>> With 6.0 the following WARN triggers:
>>>>>>> drivers/gpu/drm/i915/display/intel_bios.c:477:
>>>>>>>
>>>>>>>         drm_WARN(&i915->drm, min_size == 0,
>>>>>>>                  "Block %d min_size is zero\n", section_id);
>>>>>>
>>>>>> What's the value of section_id that gets printed?
>>>>>
>>>>> I'm guessing this is [1] fixed by commit d3a7051841f0 ("drm/i915/bios:
>>>>> Use hardcoded fp_timing size for generating LFP data pointers") in
>>>>> v6.1-rc1.
>>>>>
>>>>> I don't think this is the root cause for your issues, but I wonder if
>>>>> you could try v6.1-rc1 or drm-tip and see if we've fixed the other stuff
>>>>> already too?
>>>>
>>>> 6.1-rc1 indeed does not trigger the drm_WARN and for now (couple of
>>>> reboots, running for 5 minutes now) it seems stable. 6.0.0 usually
>>>> crashed during boot (but not always).
>>>>
>>>> Do you think it would be worthwhile to try 6.0.0 with d3a7051841f0 ?
>>
>> So I have been trying 6.0.0 with d3a7051841f0 doing a whole bunch of
>> reboots + general use and that seems stable, then I reverted it and
>> the very first boot of the kernel with that broke again, so I'm
>> pretty sure that d3a7051841f0 fixes things.
>>
>> So d3a7051841f0 seems to do more then just fix the WARN().
> 
> Wow, so I guess we do screw up the parsing royally then. :o

I'm running the kernel with lockdep + list-debugging enabled and
I could not reproduce this (not easily at least) on a standard
Fedora 6.0.0 build without that. So maybe the parsing just manages
to write out of binds a tiny bit which just happens to hit a list_head
somewhere ... ?

Either way things look stable with d3a7051841f0 and it turns out
that Fedora already had that cherry-picked downstream in the
5.19.13 kernel which was stable for me too.

>> So lets try to get d3a7051841f0 added to the official stable series
>> ASAP (I just noticed that Mark Pearson from Lenovo has already added it
>> to Fedora's 6.0.2 build.
> 
> I think I'd also pick d3a7051841f0^ i.e. both commits:
> 
> d3a7051841f0 ("drm/i915/bios: Use hardcoded fp_timing size for generating LFP data pointers")
> 4e78d6023c15 ("drm/i915/bios: Validate fp_timing terminator presence")
> 
> for stable.

That sounds good, can you take care of submitting these to gkh ?

Regards,

Hans

