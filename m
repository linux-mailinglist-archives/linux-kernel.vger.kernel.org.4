Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822C669677E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjBNPAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjBNPAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:00:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC51BDA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676386803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Y0i1G7CGmJ3aU/RrjzieSXfqNBmOoSoOUJ9sUny07Y=;
        b=akN2hNUFRAe3BAFuc+n9UEozlziGVRwbgrJIe/3Kx0wfiYRdMizMLaYkK7zmnjRXbjr+4q
        9E4CaPbhmEzXOGve2PONuZcZTbzoCYQdDa1BNmh7rY80AziUzuxxTq0hM09wM1fIMrAx1b
        BKWNlIKp33v1WgXfz7Ei6XH8HI8hQjk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-150-QGNzbRPXO_qG8Z47ZKTgdw-1; Tue, 14 Feb 2023 10:00:01 -0500
X-MC-Unique: QGNzbRPXO_qG8Z47ZKTgdw-1
Received: by mail-ej1-f69.google.com with SMTP id jo5-20020a170906f6c500b008b133fc52e9so1009520ejb.22
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y0i1G7CGmJ3aU/RrjzieSXfqNBmOoSoOUJ9sUny07Y=;
        b=KpjsmDWxPJ1pUuljmRfkWhCq2RZ6aiEkvkQ5uBjlWjtSNHU2O3RsxaoZTLEuczSU4+
         4hlqzWYZrUhH+qqs+3Jvp5zWf+6daF5AomGYzvtEhAdGWc/9Y1s3gO9HqNonkoJoTGuE
         sxkjooN3A5crg/9KE0zFVh6HTfdaWsoY0WF3w+J+i0MOKvgVj4wuGRZ6D8T/EDamK1nT
         HvGWnkCUOsihMntmsvtOWGC4F+QO+e3d93jOrYrFcnajybMrFnBwH3cX62LnIAktsGZz
         cE4w5fyf+TEPQ5p5HKK0B9Tp3UP6PrYXCH9ZUyxGFU/y/1FMWpXj31CRPD914DA+Qf4K
         qm3g==
X-Gm-Message-State: AO0yUKVzWgiFMhf28DL9MH6LcqYnI9x1HMeDKgpN2+oDYcsjCPtofLlJ
        5qTdna5QLY1K4CIBa6sjzLiyJBOPpSXbuPDjakKOUzfxnuVS60Zg72XuKXpioCGn6NmmbRmrbnC
        pGUKwQcQx1x1T+ueICElQya2h
X-Received: by 2002:a50:aac2:0:b0:4ac:bf55:7d69 with SMTP id r2-20020a50aac2000000b004acbf557d69mr2608257edc.42.1676386800577;
        Tue, 14 Feb 2023 07:00:00 -0800 (PST)
X-Google-Smtp-Source: AK7set+cwMTzgQSeX9+VMvJQqzXqjKyplrTQ3LHy4WXUktpA6qt/fyjC2BwIKZEEbgoTe3bf1P8iGQ==
X-Received: by 2002:a50:aac2:0:b0:4ac:bf55:7d69 with SMTP id r2-20020a50aac2000000b004acbf557d69mr2608237edc.42.1676386800308;
        Tue, 14 Feb 2023 07:00:00 -0800 (PST)
Received: from [192.168.43.127] ([109.37.137.201])
        by smtp.gmail.com with ESMTPSA id r10-20020a50c00a000000b004acd14ab4dfsm2041132edb.41.2023.02.14.06.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 06:59:59 -0800 (PST)
Message-ID: <a3a2ca3b-9f9d-58d2-d0f0-0035291d81c5@redhat.com>
Date:   Tue, 14 Feb 2023 15:59:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Regression] Bug 217026 - Backlight control broken on kernels
 6.1.4+
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Daniel Dadap <ddadap@nvidia.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, albimarini4283@gmail.com
References: <197e2991-9d0a-4cb3-e2d3-f0f58fb28a2e@leemhuis.info>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <197e2991-9d0a-4cb3-e2d3-f0f58fb28a2e@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

On 2/14/23 11:44, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217026 :
> 
>>  albimarini4283@gmail.com 2023-02-12 20:57:03 UTC
>>
>> Brightness control does not work with AMD Ryzen 5800H when using hybrid
>> graphics on kernel updates 6.1.4+. I am using a Lenovo Legion Slim 7
>> (2021, 15ACH6) currently running Arch Linux with the mainline kernel
>> 6.1.11, however, I have been testing my experience with this issue on
>> every point revision from 6.1.3 to 6.1.11.
>>
>>       CPU: AMD Ryzen 5 5800H with Radeon Graphics
>>       GPU: NVIDIA RTX 3060 Mobile / Max-Q (Proprietary NVIDIA driver,
>> tested with 525.78.01-1 (version prior to 6.1.4 being released) and
>> 525.89.02-1 (latest driver at time of writing))
>>       System Memory: 40 GB
>>       Display: Laptop (Laptop Screen)
>>
>> The only parameters applied at boot on my system are: nvidia-drm.modeset=1
>>
>> How to reproduce the issue:
>> Enable hybrid graphics/Optimus in BIOS setup.
>>
>> Prior to kernel version 6.1.4, /sys/class/backlight contained two entries:
>> amdgpu_bl0 and nvidia_wmi_ec_backlight
>>
>> With these two entries in /sys/class/backlight , I was able to write to
>> their respective brightness files directly or use a program like light
>> to change the values. Those values would change the brightness of the
>> screen depending on if I was using the AMD GPU or NVIDIA GPU to display
>> the current application. I could set these values to roughly the same
>> thing to achieve an overall complete brightness experience regardless of
>> whether or not I was currently running an application on my integrated
>> (AMD) GPU or dedicated (NVIDIA) GPU.
>>
>> Then, upon updating to kernel versions 6.1.4+, there is no longer an
>> amdgpu_bl0 entry in /sys/class/backlight , just a
>> nvidia_wmi_ec_backlight entry, making it impossible for me to change the
>> brightness on my display when using the iGPU. Interestingly, on kernels
>> 6.1.4+, running "journalctl -b -0 | grep backlight" returns an output
>> "amdgpu: [drm] Skipping amdgpu DM backlight registration", which was not
>> present in prior kernel versions.
>>
>> However, if I instead prepend the option "acpi_backlight=native" to my
>> kernel command line options at boot, "amdgpu_bl0" is once again present
>> in /sys/class/backlight but "nvidia_wmi_ec_backlight" has now
>> disappeared and is nowhere to be seen making it so I can change the
>> brightness when using the iGPU, but the brightness is stuck at max when
>> using the dedicated GPU. Running the above journalctl command at this
>> point returns no errors relating to my AMD GPU and does not mention
>> anything about the NVIDIA GPU. Trying different acpi_backlight options
>> on 6.1.4+ does not fix the issue and instead removes functionality.
>> acpi_backlight=vendor makes an entry called "ideapad" pop up in
>> /sys/class/backlight with nothing else. Changing the brightness values
>> in ideapad does nothing.
>> acpi_backlight=video makes only two entries appear in
>> /sys/class/backlight, acpi_video0 and acpi_video1. Changing the
>> brightness values in either of these directories does nothing.
>> acpi_backlight=none causes nothing to appear under /sys/class/backlight.
>>
>> If hybrid graphics is disabled, the display is connected to the NVIDIA
>> GPU and /sys/class/backlight/nvidia_0 is present, the NVIDIA driver can
>> change the display brightness without a problem.p
>>
>> Below is my lscpi -nn and dmidecode outputs on kernel 6.1.3 and 6.1.11.
>> [...]
> 
> See the ticket for more details.
> 
> [TLDR for the rest of this mail: I'm adding this report to the list of
> tracked Linux kernel regressions; the text you find below is based on a
> few templates paragraphs you might have encountered already in similar
> form.]
> 
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
> 
> #regzbot introduced: v6.1.3..v6.1.4
> https://bugzilla.kernel.org/show_bug.cgi?id=217026
> #regzbot title: backlight: brightness control stopped working on a Ryzen
> system with hybrid graphics
> #regzbot ignore-activity

Thank you for forwarding this. I have just added the following comment
to the bug:

"""
Yes this has already been reported on the malinglist.

There unfortunately is a firmware bug on the Lenovo Legion models.

On models with the Nvidia WMI EC backlight interface, when the laptop is configured in dynamic mux mode in the BIOS (1) the backlight should always be controlled by the Nvidia WMI EC backlight interface. So in theory the kernel is behaving as it should according to the documentation here.

But as you found out, some Legion models are not behaving as the Nvidia WMI spec says they should behave. This is also why you needed the hack/script to write brightness values to both backlight devices at the same time with older kernels.

Daniel Dadap from Nvidia is looking into this, but I'm afraid that we don't have a solution yet.

1) So that you can switch at runtime which GPU is connected to the builtin LCD panel
"""

Lets continue this inside bugzilla.

Regards,

Hans

