Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9486360BE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiJXXOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiJXXOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1A1FF87
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666647273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sa227/HWN+mg/M9GF8z0s+pXLCfMWbPNsK+iHgKq07I=;
        b=YHtggSEa2E4qZHwPeoK9ojjSR2VKNOoobeKZJV6sN9TX55zVJINo1vJknCBOjFoyx4J2i4
        NzDSzKPNJ5QB3CFvFApeOE1DbLPcOxzTv7z7HTR9ZqpmGiaiiKj3QUEaQUk2OMJmJEVqS8
        t94WNFb/zKX5T4YjsYosFOfgmKbXkuU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-Z_ajM_2HNpaZCC2AxpbDPw-1; Mon, 24 Oct 2022 07:53:08 -0400
X-MC-Unique: Z_ajM_2HNpaZCC2AxpbDPw-1
Received: by mail-ed1-f69.google.com with SMTP id y10-20020a056402358a00b0045d5cf18d4cso9443410edc.17
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa227/HWN+mg/M9GF8z0s+pXLCfMWbPNsK+iHgKq07I=;
        b=IeXkN2pSha8Px9rVL5hvNKDfSs95vcfgCUZUBwTbbykiVzn2r/NrTZI4a6xo+mBWu3
         NcyB1ciJmmxnpHSAgJzTlUgxWA3NPIE7x58Wec6FhYBVmyFx9LMLNI9uNWAJ8oqKW8US
         PbUuL60tq3FcpV9WvRlIhgzbdj+2zChNK5pYzdx4nSl8MjOJVCFoxu2CqGYLHqi66Byw
         FznJ1V3eSpP+tY6SCLFt0K8jYqWu1xwPWTZHS1B2aVrorpbz8wyFniMo7kc77s19CLc1
         A4Y/HS5how5q0b/UBw+QN/czFA6cf7IGHOt/sGP2KAKGDT9wX285FmJRKwgdZnDY2VD+
         wMnQ==
X-Gm-Message-State: ACrzQf0HEpRuL7XC37Ip1uuDOWIkMPtwccRMVnl7rZ/7BIq07WcmZhPY
        KiaraFHK22Bl5E35w+hQp5FuGZ2fH3YVcT46V8hbEjputPGCQhyRb4Bzo+0LC7AXdL3LyFIkBvT
        HGALo5Pb4oGNC5GC+1CIiHLgu
X-Received: by 2002:a17:907:608f:b0:78e:1b60:60e2 with SMTP id ht15-20020a170907608f00b0078e1b6060e2mr27603516ejc.382.1666612387319;
        Mon, 24 Oct 2022 04:53:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6rKjf9vFNIG71zIVFmhWoGUssYXpRCR0TKoudwiSS8QTCTafqY38Nm8/FfK1Fy5krk9VAMgg==
X-Received: by 2002:a17:907:608f:b0:78e:1b60:60e2 with SMTP id ht15-20020a170907608f00b0078e1b6060e2mr27603473ejc.382.1666612387069;
        Mon, 24 Oct 2022 04:53:07 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id h3-20020a1709070b0300b007ab2d744801sm17394ejl.190.2022.10.24.04.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 04:53:06 -0700 (PDT)
Message-ID: <746e5cc6-516f-8f69-9d4b-8fe237de8fd6@redhat.com>
Date:   Mon, 24 Oct 2022 13:53:05 +0200
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
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221024113513.5205-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akihiko,

On 10/24/22 13:34, Akihiko Odaki wrote:
> Commit 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native()
> helper") and following commits made native backlight unavailable if
> CONFIG_ACPI_VIDEO is set and the backlight feature of ACPI video is
> unavailable, which broke the backlight functionality on Lenovo ThinkPad
> C13 Yoga Chromebook. Allow to fall back to native backlight in such
> cases.

I appreciate your work on this, but what this in essence does is
it allows 2 backlight drivers (vendor + native) to get registered
for the same panel again. While the whole goal of the backlight refactor
series landing in 6.1 was to make it so that there always is only
*1* backlight device registered instead of (possibly) registering
multiple and letting userspace figure it out. It is also important
to only always have 1 backlight device per panel for further
upcoming changes.

So nack for this solution, sorry.

I am aware that this breaks backlight control on some Chromebooks,
this was already reported and I wrote a long reply explaining why
things are done the way they are done now and also suggesting
2 possible (much simpler) fixes, see:
https://lore.kernel.org/linux-acpi/42a5f2c9-a1dc-8fc0-7334-fe6c390ecfbb@redhat.com/

Unfortunately the reported has not followed-up on this and
I don't have the hardware to test this myself.

Can you please try implementing 1 of the fixes suggested there
and then submit that upstream ?

Regards,

Hans









> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Akihiko Odaki (22):
>   drm/i915/opregion: Improve backlight request condition
>   ACPI: video: Introduce acpi_video_get_backlight_types()
>   LoongArch: Use acpi_video_get_backlight_types()
>   platform/x86: acer-wmi: Use acpi_video_get_backlight_types()
>   platform/x86: asus-laptop: Use acpi_video_get_backlight_types()
>   platform/x86: asus-wmi: Use acpi_video_get_backlight_types()
>   platform/x86: compal-laptop: Use acpi_video_get_backlight_types()
>   platform/x86: eeepc-laptop: Use acpi_video_get_backlight_types()
>   platform/x86: fujitsu-laptop: Use acpi_video_get_backlight_types()
>   platform/x86: ideapad-laptop: Use acpi_video_get_backlight_types()
>   platform/x86: msi-laptop: Use acpi_video_get_backlight_types()
>   platform/x86: msi-wmi: Use acpi_video_get_backlight_types()
>   platform/x86: nvidia-wmi-ec-backlight: Use
>     acpi_video_get_backlight_types()
>   platform/x86: panasonic-laptop: Use acpi_video_get_backlight_types()
>   platform/x86: samsung-laptop: Use acpi_video_get_backlight_types()
>   platform/x86: sony-laptop: Use acpi_video_get_backlight_types()
>   platform/x86: thinkpad_acpi: Use acpi_video_get_backlight_types()
>   platform/x86: toshiba_acpi: Use acpi_video_get_backlight_types()
>   platform/x86: dell-laptop: Use acpi_video_get_backlight_types()
>   platform/x86: intel_oaktrail: Use acpi_video_get_backlight_types()
>   ACPI: video: Remove acpi_video_get_backlight_type()
>   ACPI: video: Fallback to native backlight
> 
>  Documentation/gpu/todo.rst                    |  8 +--
>  drivers/acpi/acpi_video.c                     |  2 +-
>  drivers/acpi/video_detect.c                   | 54 ++++++++++---------
>  drivers/gpu/drm/i915/display/intel_opregion.c |  3 +-
>  drivers/platform/loongarch/loongson-laptop.c  |  4 +-
>  drivers/platform/x86/acer-wmi.c               |  2 +-
>  drivers/platform/x86/asus-laptop.c            |  2 +-
>  drivers/platform/x86/asus-wmi.c               |  4 +-
>  drivers/platform/x86/compal-laptop.c          |  2 +-
>  drivers/platform/x86/dell/dell-laptop.c       |  2 +-
>  drivers/platform/x86/eeepc-laptop.c           |  2 +-
>  drivers/platform/x86/fujitsu-laptop.c         |  4 +-
>  drivers/platform/x86/ideapad-laptop.c         |  2 +-
>  drivers/platform/x86/intel/oaktrail.c         |  2 +-
>  drivers/platform/x86/msi-laptop.c             |  2 +-
>  drivers/platform/x86/msi-wmi.c                |  2 +-
>  .../platform/x86/nvidia-wmi-ec-backlight.c    |  2 +-
>  drivers/platform/x86/panasonic-laptop.c       |  2 +-
>  drivers/platform/x86/samsung-laptop.c         |  2 +-
>  drivers/platform/x86/sony-laptop.c            |  2 +-
>  drivers/platform/x86/thinkpad_acpi.c          |  4 +-
>  drivers/platform/x86/toshiba_acpi.c           |  2 +-
>  drivers/video/backlight/backlight.c           | 18 +++++++
>  include/acpi/video.h                          | 21 ++++----
>  include/linux/backlight.h                     |  1 +
>  25 files changed, 85 insertions(+), 66 deletions(-)
> 

