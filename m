Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C336922EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjBJQII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjBJQIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59531CACD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676045238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BlezyZ0ctjzjBsdQv4yB2m2kychWterO+IryIxlv3FU=;
        b=QyQrfcdEeVij8fHbgZjhLMf+5xmaF4mH+RY/E/l9KFodn9ssrYCSYdBcxmFsxb30HkzHvH
        8EpqM7KDjP2Ab30WW2L7cBS2yWZKcrv6vgCWDOpa+AhGk5cE4OrEqt5iTEoxlh59qxpjN6
        o268dK8dfn+jP6eVtka36qdBOVt3tJk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-X51A51yTPTmtrX-0rN4AGw-1; Fri, 10 Feb 2023 11:07:16 -0500
X-MC-Unique: X51A51yTPTmtrX-0rN4AGw-1
Received: by mail-ed1-f71.google.com with SMTP id g19-20020a056402115300b004a26cc7f6cbso3832084edw.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlezyZ0ctjzjBsdQv4yB2m2kychWterO+IryIxlv3FU=;
        b=ONnTFoQ8rtYIwxONwi6H3pDPkGnoy2CRqCmtiStVPcfF0cOGqD+03as4Ug+nrsHrri
         P1oQL3bkq6firW7WMLllO4AQOe8Q5y/obEFO6J+jB0oqQwexntGbqctqv0drVxsxmWKA
         wfL4Nw9ysuDPJU/Sd7WN24HJTtwHPu7fz88DUk2HpyJg44AEbi55RLudQ3frUzkigor0
         o72yKiiaw+HHvLycIERz2q21t/3MeuACjGZ/7cPXe75tG4q6hHl0jqOyQmszAn4ZB56U
         HlkTaL4nLNrK18U7MlYQFIOtCBKHb+qTSpoJ9Md/cJ3EvTu8H+HQGPb0QwNqUjJFrwN5
         ZZGQ==
X-Gm-Message-State: AO0yUKV67WflUhfdVMYswxmW5kxK10z1JOkbrJu+iQe0FqaP9EV8F4wp
        uokkFoMlWC6+Vl2hpVBFyQBVENyVo3w1EkpNZbATXMqTHiMwLSfB/yXnRmLhwGFDwySe5v+X5G+
        034dUv2qkEPyzyo31F46+0B44
X-Received: by 2002:a17:906:6a20:b0:8af:33f8:dcb3 with SMTP id qw32-20020a1709066a2000b008af33f8dcb3mr8867485ejc.57.1676045235446;
        Fri, 10 Feb 2023 08:07:15 -0800 (PST)
X-Google-Smtp-Source: AK7set8xLB5+EcBlsR4FtkzhXIqY7I7EBw8qioq1VaRXVB+Bc7ZWbenCJq8C4WMCGwJXM+0m0vfbkw==
X-Received: by 2002:a17:906:6a20:b0:8af:33f8:dcb3 with SMTP id qw32-20020a1709066a2000b008af33f8dcb3mr8867452ejc.57.1676045235208;
        Fri, 10 Feb 2023 08:07:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v7-20020a170906858700b00883ec4c63ddsm2586397ejx.146.2023.02.10.08.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 08:07:14 -0800 (PST)
Message-ID: <b3a2d525-b30c-164c-705c-97fcb0016540@redhat.com>
Date:   Fri, 10 Feb 2023 17:07:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 9/9] drm/amdgpu: register a vga_switcheroo client for
 all GPUs that are not thunderbolt attached
Content-Language: en-US, nl
To:     Alex Deucher <alexdeucher@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Rander Wang <rander.wang@intel.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        David Airlie <airlied@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Evan Quan <evan.quan@amd.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Mark Gross <markgross@kernel.org>,
        Kerem Karabay <kekrby@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Aditya Garg <gargaditya08@live.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-10-orlandoch.dev@gmail.com>
 <CADnq5_PVsrk4+K45kVgU=r98B9GgC2CxbC8AvGUXRtv2sZAHPg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CADnq5_PVsrk4+K45kVgU=r98B9GgC2CxbC8AvGUXRtv2sZAHPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/10/23 16:53, Alex Deucher wrote:
> On Fri, Feb 10, 2023 at 3:04 AM Orlando Chamberlain
> <orlandoch.dev@gmail.com> wrote:
>>
>> From: Kerem Karabay <kekrby@gmail.com>
>>
>> Commit 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and
>> vga_switcheroo") made amdgpu only register a vga_switcheroo client for
>> GPU's with PX, however AMD GPUs in dual gpu Apple Macbooks do need to
>> register, but don't have PX. Instead of AMD's PX, they use apple-gmux.
> 
> Is there a way to detect apple-gmux instead?  Otherwise, we register
> vga_switcheroo on any system with multiple GPUs which is not what we
> want.

Yes since 6.1.y (either stable series or just take 6.2.0) the apple-gmux
detect code has been factored out into a stand-alone
apple_gmux_detect() helper inside:

include/linux/apple-gmux.h

For usage outside of the actual apple-gmux driver you can simply
pass NULL for both arguments.

This was necessary to reliably check if the apple-gmux should be
used for backlight control.

Note there also is the older apple_gmux_present() helper, which is
already used in some drm code. That function is not reliable though
it detects if the ACPI tables contain an ACPI device describing
the presence of a gmux, but it turns out even Apple has buggy ACPI
tables and the mere presence of that ACPI device is not a reliable
indicator the gmux is actually there.

I have not changed over any of the existing apple_gmux_present()
users for fear of unwanted side effects...

Regards,

Hans




>> Revert to the old logic of registering for all non-thunderbolt gpus,
>> like radeon and nouveau.
>>
>> Fixes: 3840c5bcc245 ("drm/amdgpu: disentangle runtime pm and vga_switcheroo")
>> Signed-off-by: Kerem Karabay <kekrby@gmail.com>
>> [Orlando Chamberlain <orlandoch.dev@gmail.com>: add commit description]
>> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 2f28a8c02f64..0bb553a61552 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3919,12 +3919,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>>                 vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
>>
>> -       if (amdgpu_device_supports_px(ddev)) {
>> -               px = true;
>> -               vga_switcheroo_register_client(adev->pdev,
>> -                                              &amdgpu_switcheroo_ops, px);
>> +       px = amdgpu_device_supports_px(ddev);
>> +
>> +       if (!pci_is_thunderbolt_attached(adev->pdev))
>> +               vga_switcheroo_register_client(adev->pdev, &amdgpu_switcheroo_ops, px);
>> +
>> +       if (px)
>>                 vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
>> -       }
>>
>>         if (adev->gmc.xgmi.pending_reset)
>>                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
>> @@ -4048,10 +4049,13 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>
>>         kfree(adev->bios);
>>         adev->bios = NULL;
>> -       if (amdgpu_device_supports_px(adev_to_drm(adev))) {
>> +
>> +       if (!pci_is_thunderbolt_attached(adev->pdev))
>>                 vga_switcheroo_unregister_client(adev->pdev);
>> +
>> +       if (amdgpu_device_supports_px(adev_to_drm(adev)))
>>                 vga_switcheroo_fini_domain_pm_ops(adev->dev);
>> -       }
>> +
>>         if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>>                 vga_client_unregister(adev->pdev);
>>
>> --
>> 2.39.1
>>
> 

