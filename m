Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499DA74D60C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGJMzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJMzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E1EC9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688993653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXqzw2uf5AumAr49qSdVm0C2PXPLiwvwsSvgFfTxD70=;
        b=VcPN62V21V0VkGoEd6EnsDIBS4dsHaoU2bK4NpcgOfZqEnxIdOWIKGmwUKtLOMeWNRRVMG
        quYsoRNnxAfQ40B9G2q/L46UeZg+H/2VdIHjdt7kEcHcnqOP8gkf1Oa5sel0hBFqaD3GAn
        ATBcGFvxm+uotZvBCZ2scDiDm8QfDjw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-2Y_xqh1uP0CgfzzPqIJoFQ-1; Mon, 10 Jul 2023 08:54:12 -0400
X-MC-Unique: 2Y_xqh1uP0CgfzzPqIJoFQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50bf847b267so3088430a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688993651; x=1691585651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXqzw2uf5AumAr49qSdVm0C2PXPLiwvwsSvgFfTxD70=;
        b=I1ubiVl4wM9Uk0UKcyGPsjXPLBNJiwxZUNdkBlUNM+Wb9ea0kC/wE4JmrM4xCpoXhF
         qpfmWukXJyBAbyLIHl8Cz9nBvkFDzwQCaYVVIp39xdCfy/i0uDMpLMJkki6cdpl0zW9i
         TMqtTghbh+zaZFybnAzAzA+NohvZGReThhttdgY8e7Aah/0g5t4vWRPowdwuPvEejJgF
         GKfuanHxkoudexHtnHAtyPtbKIm4NbxopPYbVrai42Waj2txQ2Ys95xpmlbRsYPXwP1t
         /+PIeolPu/XirqwtHmxT9wsQRkTnCUlHMCTCb7Q9nA3EgcKW9e25mxOj6TQ1ZpRmNCxo
         tlYg==
X-Gm-Message-State: ABy/qLZApCugKTqTAvDvLIl8HM2HDeQOuKbmYwMuoQJqPI5za1R4Ftmm
        uN0Q+vNWFUYrLE8gFNN4BGte5gyaPlJeuHDCX36orjpLoTNdJoRcHpkwfk5sQv3nYJebMvtCHXe
        ZiGVb/vBzAyrd4W7fnpgkjrJQ
X-Received: by 2002:aa7:dbd2:0:b0:51d:a94b:f8f2 with SMTP id v18-20020aa7dbd2000000b0051da94bf8f2mr12134539edt.2.1688993651021;
        Mon, 10 Jul 2023 05:54:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHkgc+0Cw/yf/AT2wYUXBD6BHtYyVoOSXaFFynE/PInbuhzPD81Dud4NXd2cH/D9+hBdsoV3w==
X-Received: by 2002:aa7:dbd2:0:b0:51d:a94b:f8f2 with SMTP id v18-20020aa7dbd2000000b0051da94bf8f2mr12134519edt.2.1688993650696;
        Mon, 10 Jul 2023 05:54:10 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id e15-20020a056402148f00b0051e2cde9e3esm5715989edv.75.2023.07.10.05.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:54:10 -0700 (PDT)
Message-ID: <615d1d62-514b-0cf4-9725-b899b06ecbc3@redhat.com>
Date:   Mon, 10 Jul 2023 14:54:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ACPI: video: Invoke _PS0 at boot for ACPI video
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230704074506.2304939-1-kai.heng.feng@canonical.com>
 <CAJZ5v0jwO1NJ_x2t3RV-kYDmVY9UtyexznCSZMAmQ-gK4dWCmA@mail.gmail.com>
 <f5a4f802-d6a1-050e-ec70-701048ab1a2f@redhat.com>
 <CAAd53p5nkE+QdxJwF_mEsNiEHvRwg+4D7yP77H6CDrMWPOX_zQ@mail.gmail.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAAd53p5nkE+QdxJwF_mEsNiEHvRwg+4D7yP77H6CDrMWPOX_zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/6/23 10:20, Kai-Heng Feng wrote:
> On Wed, Jul 5, 2023 at 6:33 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 7/4/23 18:58, Rafael J. Wysocki wrote:
>>> On Tue, Jul 4, 2023 at 9:46 AM Kai-Heng Feng
>>> <kai.heng.feng@canonical.com> wrote:
>>>>
>>>> Screen brightness can only be changed once on some HP laptops.
>>>>
>>>> Vendor identified the root cause as Linux doesn't invoke _PS0 at boot
>>>> for all ACPI devices:
>>>
>>> This part of the changelog is confusing, because the evaluation of
>>> _PS0 is not a separate operation.  _PS0 gets evaluated when devices
>>> undergo transitions from low-power states to D0.
>>>
>>>>     Scope (\_SB.PC00.GFX0)
>>>>     {
>>>>         Scope (DD1F)
>>>>         {
>>>>             Method (_PS0, 0, Serialized)  // _PS0: Power State 0
>>>>             {
>>>>                 If (CondRefOf (\_SB.PC00.LPCB.EC0.SSBC))
>>>>                 {
>>>>                     \_SB.PC00.LPCB.EC0.SSBC ()
>>>>                 }
>>>>             }
>>>>             ...
>>>>         }
>>>>         ...
>>>>     }
>>>>
>>>> _PS0 doesn't get invoked for all ACPI devices because of commit
>>>> 7cd8407d53ef ("ACPI / PM: Do not execute _PS0 for devices without _PSC
>>>> during initialization").
>>
>> So this _PS0 which seems to be the one which needs to run here,
>> is not the _PS0 for the GFX0 ACPI device, but rather for a child ACPI device-node which describes the connector (assumed based on the small part of quoted DSDT, the actual definition of the DD1F device-node is missing).
> 
> I'll file a bugzilla and attach a full acpidump there.
> 
>>
>> Having a _PS0 method on a connector object is really weird IMHO. But if we need to invoke such a _PS0 method then IMHO that really should be done in the drm/kms driver. E.g. at least the i915 code already contains code to map the ACPI connector objects to the drm_connector objects, so it should be relatively easily to make that try and do a power-transition to D0 when enabling the connector.
> 
> Or put all ACPI devices to D0 at boot?
> According to the BIOS folks that's what Windows does.
> This way we can drop acpi_device_fix_up_power* helpers altogether.

Doing that will leave any devices for which we lack a driver at D0 for ever,
so that IMHO is not a good idea.

I guess calling acpi_device_fix_up_power_extended(device) from the
ACPI-video code, so that the connector sub-objects are put in D0 is
somewhat ok. Although I would prefer to see you first try to do
the same thing from the i915 driver instead.

If we do end up doing this from the acpi-video code please add
a comment above the call why this is done; and as Rafael mentioned
the commit msg needs to better explain things too.

Regards,

Hans



> 
>>
>> Also can you provide some more info on the hw on which this is being seen:
>>
>> 1. What GPU(s) is/are being used
> 
> Intel GFX.
> 
> AFAIK AMD based laptops also require this fixup too.
> 
>> 2. If there is a mux for hybrid gfx in which mode is the mux set ?
> 
> No. This happens to mux-less and dGPU-less laptops.
> 
>> 3. Wjich method is used to control the brightness (which backlight-class-devices show up under /sys/class/backlight) ?
> 
> intel_backlight.
> 
>>
>> And can you add this info to the commit msg for the next version of the patch ?
> 
> Sure.
> Can putting all devices to D0 be considered too? It's a better
> solution for the long wrong.
> 
> Kai-Heng
> 
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>>
>>> And yes, Linux doesn't put all of the ACPI devices into D0 during
>>> initialization, but the above commit has a little to do with that.
>>>
>>>> For now explicitly call _PS0 for ACPI video to workaround the issue.
>>>
>>> This is not what the patch is doing.
>>>
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>>  drivers/acpi/acpi_video.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>>>> index 62f4364e4460..793259bd18c8 100644
>>>> --- a/drivers/acpi/acpi_video.c
>>>> +++ b/drivers/acpi/acpi_video.c
>>>> @@ -2027,6 +2027,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
>>>>         if (error)
>>>>                 goto err_put_video;
>>>>
>>>> +       acpi_device_fix_up_power_extended(device);
>>>> +
>>>
>>> I would like to know what Hans thinks about this.
>>>
>>>>         pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
>>>>                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
>>>>                video->flags.multihead ? "yes" : "no",
>>>> --
>>>
>>
> 

