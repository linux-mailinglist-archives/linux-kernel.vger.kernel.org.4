Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C881560AE2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiJXOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiJXOvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFFE10A7D3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666618057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZe1w3EPaVA+CN/q+Lt0jOZyvsYbOMnl65HsFpxBLe8=;
        b=UQ0xA9MVMW6JsoNwGeEAnpbjEYqwg72cctCj3DjvlmBz9qd5YKtk3bZnZxkpyHxmoZFWKv
        pWjS19jznl/I9bCA8Mcy71P4r8O5FhWtKpBKePu9jQXPU5TEPsq/NBicoTFDt8TsBaD702
        xv/jtFUEACL22Ku4iYsTTx/ocVr/xBE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-177-seodfEocN6OK94crLpu4vw-1; Mon, 24 Oct 2022 09:21:29 -0400
X-MC-Unique: seodfEocN6OK94crLpu4vw-1
Received: by mail-ed1-f69.google.com with SMTP id w20-20020a05640234d400b0045d0d1afe8eso9675011edc.15
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZe1w3EPaVA+CN/q+Lt0jOZyvsYbOMnl65HsFpxBLe8=;
        b=T+Uv8lCwS93KPwPk8QXnbR/sYbPPWjV+U/7F/K2YtpVbT0WsQBMxDnCGfcdNe/mg8l
         hwOlSIYvJE2yWcSvXaJR2723t1Dsn8C359CMMQjfo1x2ySkdXDDvq6kxbDe7iuaRk42Z
         5tX3SZDsyTYKfDK0wMUQkSsxZbHFxO9hQNHduTdZdjdPhR/WTGV1kFYzkY3JQS8P/2y0
         R6ITvObhe9QIqsYvwMhgd4kmTK2nPE1354xJEgeFVMwZ8qN2WdQbV5sCIpJoUurpIjVg
         Vkcem4HYWuY3OCS7jGe6iqkhvg2ocUuDNezOimmXjsIWM/RanoTvtwG2c8nxlwSC+7dE
         V5fw==
X-Gm-Message-State: ACrzQf1YmIqmc3mvp6mXmXpRUKjdv0EV5xc8npBIATTmH2lSmasYXhoy
        RJm/HitSNl8QBUj+qIotq004WTX1sVms6pQG5qy67RY6z3PU7awUzKmKts8xBzVSZjuwHVq6UoA
        aAJHClvupcI/bodZ9Nj64eFCg
X-Received: by 2002:a17:907:7627:b0:78d:b6f5:9f15 with SMTP id jy7-20020a170907762700b0078db6f59f15mr27908056ejc.149.1666617688156;
        Mon, 24 Oct 2022 06:21:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5eVoX3Zdsw3dT2G3BRaFLKO7Cw6SDF7Gj5r0DB42X2PLxNRQiYtexmaaMeTBVnA50ta6oFDw==
X-Received: by 2002:a17:907:7627:b0:78d:b6f5:9f15 with SMTP id jy7-20020a170907762700b0078db6f59f15mr27908007ejc.149.1666617687840;
        Mon, 24 Oct 2022 06:21:27 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709060cd100b00783c545544fsm15509207ejh.215.2022.10.24.06.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:21:27 -0700 (PDT)
Message-ID: <60672af8-05d2-113c-12b9-d635608be0dd@redhat.com>
Date:   Mon, 24 Oct 2022 15:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 00/22] Fallback to native backlight
Content-Language: en-US
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Ike Panhc <ike.pan@canonical.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Azael Avalos <coproscefalo@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Robert Moore <robert.moore@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org,
        devel@acpica.org
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
 <746e5cc6-516f-8f69-9d4b-8fe237de8fd6@redhat.com>
 <edec5950-cec8-b647-ccb1-ba48f9b3bbb0@daynix.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <edec5950-cec8-b647-ccb1-ba48f9b3bbb0@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/24/22 14:58, Akihiko Odaki wrote:
> On 2022/10/24 20:53, Hans de Goede wrote:
>> Hi Akihiko,
>>
>> On 10/24/22 13:34, Akihiko Odaki wrote:
>>> Commit 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native()
>>> helper") and following commits made native backlight unavailable if
>>> CONFIG_ACPI_VIDEO is set and the backlight feature of ACPI video is
>>> unavailable, which broke the backlight functionality on Lenovo ThinkPad
>>> C13 Yoga Chromebook. Allow to fall back to native backlight in such
>>> cases.
>>
>> I appreciate your work on this, but what this in essence does is
>> it allows 2 backlight drivers (vendor + native) to get registered
>> for the same panel again. While the whole goal of the backlight refactor
>> series landing in 6.1 was to make it so that there always is only
>> *1* backlight device registered instead of (possibly) registering
>> multiple and letting userspace figure it out. It is also important
>> to only always have 1 backlight device per panel for further
>> upcoming changes.
>>
>> So nack for this solution, sorry.
>>
>> I am aware that this breaks backlight control on some Chromebooks,
>> this was already reported and I wrote a long reply explaining why
>> things are done the way they are done now and also suggesting
>> 2 possible (much simpler) fixes, see:
>> https://lore.kernel.org/linux-acpi/42a5f2c9-a1dc-8fc0-7334-fe6c390ecfbb@redhat.com/
>>
>> Unfortunately the reported has not followed-up on this and
>> I don't have the hardware to test this myself.
>>
>> Can you please try implementing 1 of the fixes suggested there
>> and then submit that upstream ?
>>
>> Regards,
>>
>> Hans
>>
> 
> Hi Hans,
> 
> Thanks for reviewing and letting me know the prior attempt.
> 
> In this case, there is only a native backlight device and no vendor backlight device so the duplication of backlight devices does not happen. I think it is better to handle such a case without quirks.

Adding a single heuristic for all chromebooks is something completely different
then adding per model quirks which indeed ideally should be avoided (but this
is not always possible).

> I understand it is still questionable to cover the case by allowing duplication when both of a vendor backlight device and native one. To explain my understanding and reasoning for *not* trying to apply the de-duplication rule to the vendor/native combination, let me first describe that the de-duplication which happens in acpi_video_get_backlight_type() is a heuristics and limited.
> 
> As the background of acpi_video_get_backlight_type(), there is an assumption that it should be common that both of the firmware, implementing ACPI, and the kernel have code to drive backlight. In the case, the more reliable one should be picked instead of using both, and that is what the statements in `if (video_caps & ACPI_VIDEO_BACKLIGHT)` does.
> 
> However, the method has two limitations:
> 1. It does not cover the case where two backlight devices with the same type exist.

This only happens when there are 2 panels; or 2 gpus driving a single panel
which are both special cases where we actually want 2 backlight devices.

> 2. The underlying assumption does not apply to vendor/native combination.
> 
> Regarding the second limitation, I don't even understand the difference between vendor and native. My guess is that a vendor backlight device uses vendor-specific ACPI interface, and a native one directly uses hardware registers. If my guess is correct, the difference between vendor and native does not imply that both of them are likely to exist at the same time. As the conclusion, there is no more motivation to try to de-duplicate the vendor/native combination than to try to de-duplicate combination of devices with a single type.
> 
> Of course, it is better if we could also avoid registering two devices with one type for one physical device. Possibly we can do so by providing a parameter to indicate that it is for the same "internal" backlight to devm_backlight_device_register(), and let the function check for the duplication. However, this rule may be too restrict, or may have problems I missed.
> 
> Based on the discussion above, we can deduce three possibilities:
> a. There is no reason to distinguish vendor and native in this case, and we can stick to my current proposal.
> b. There is a valid reason to distinguish vendor and native, and we can adopt the same strategy that already adopted for ACPI video/vendor combination.
> c. We can implement de-duplication in devm_backlight_device_register().
> d. The other possible options are not worth, and we can just implement quirks specific to Chromebook/coreboot.
> 
> In case b, it should be noted that vendor and native backlight device do not require ACPI video, and CONFIG_ACPI_VIDEO may not be enabled. In the case, the de-duplication needs to be implemented in backlight class device.

I have been working on the ACPI/x86 backlight detection code since 2015, please trust
me when I say that allowing both vendor + native backlight devices at the same time
is a bad idea.

I'm currently in direct contact with the ChromeOS team about fixing the Chromebook
backlight issue introduced in 6.1-rc1.

If you wan to help, please read:

https://lore.kernel.org/linux-acpi/42a5f2c9-a1dc-8fc0-7334-fe6c390ecfbb@redhat.com/

And try implementing 1 if the 2 solutions suggested there.

Regards,

Hans



>>> Akihiko Odaki (22):
>>>    drm/i915/opregion: Improve backlight request condition
>>>    ACPI: video: Introduce acpi_video_get_backlight_types()
>>>    LoongArch: Use acpi_video_get_backlight_types()
>>>    platform/x86: acer-wmi: Use acpi_video_get_backlight_types()
>>>    platform/x86: asus-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: asus-wmi: Use acpi_video_get_backlight_types()
>>>    platform/x86: compal-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: eeepc-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: fujitsu-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: ideapad-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: msi-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: msi-wmi: Use acpi_video_get_backlight_types()
>>>    platform/x86: nvidia-wmi-ec-backlight: Use
>>>      acpi_video_get_backlight_types()
>>>    platform/x86: panasonic-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: samsung-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: sony-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: thinkpad_acpi: Use acpi_video_get_backlight_types()
>>>    platform/x86: toshiba_acpi: Use acpi_video_get_backlight_types()
>>>    platform/x86: dell-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: intel_oaktrail: Use acpi_video_get_backlight_types()
>>>    ACPI: video: Remove acpi_video_get_backlight_type()
>>>    ACPI: video: Fallback to native backlight
>>>
>>>   Documentation/gpu/todo.rst                    |  8 +--
>>>   drivers/acpi/acpi_video.c                     |  2 +-
>>>   drivers/acpi/video_detect.c                   | 54 ++++++++++---------
>>>   drivers/gpu/drm/i915/display/intel_opregion.c |  3 +-
>>>   drivers/platform/loongarch/loongson-laptop.c  |  4 +-
>>>   drivers/platform/x86/acer-wmi.c               |  2 +-
>>>   drivers/platform/x86/asus-laptop.c            |  2 +-
>>>   drivers/platform/x86/asus-wmi.c               |  4 +-
>>>   drivers/platform/x86/compal-laptop.c          |  2 +-
>>>   drivers/platform/x86/dell/dell-laptop.c       |  2 +-
>>>   drivers/platform/x86/eeepc-laptop.c           |  2 +-
>>>   drivers/platform/x86/fujitsu-laptop.c         |  4 +-
>>>   drivers/platform/x86/ideapad-laptop.c         |  2 +-
>>>   drivers/platform/x86/intel/oaktrail.c         |  2 +-
>>>   drivers/platform/x86/msi-laptop.c             |  2 +-
>>>   drivers/platform/x86/msi-wmi.c                |  2 +-
>>>   .../platform/x86/nvidia-wmi-ec-backlight.c    |  2 +-
>>>   drivers/platform/x86/panasonic-laptop.c       |  2 +-
>>>   drivers/platform/x86/samsung-laptop.c         |  2 +-
>>>   drivers/platform/x86/sony-laptop.c            |  2 +-
>>>   drivers/platform/x86/thinkpad_acpi.c          |  4 +-
>>>   drivers/platform/x86/toshiba_acpi.c           |  2 +-
>>>   drivers/video/backlight/backlight.c           | 18 +++++++
>>>   include/acpi/video.h                          | 21 ++++----
>>>   include/linux/backlight.h                     |  1 +
>>>   25 files changed, 85 insertions(+), 66 deletions(-)
>>>
>>
> 

