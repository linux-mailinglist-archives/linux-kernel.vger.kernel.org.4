Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E28465A576
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 16:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiLaPQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 10:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiLaPQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB9CB3E
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 07:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672499729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsnHjuo2pdM6+4oo2kO0ihKSfLJNkSQudAlSWQORiGk=;
        b=aIc6wp0x0SWsUHFvoES+IJxWAHvoCPqjf/nIk27BtbS0GTKTf9CUV4CN9+gmC2TmDNnLJu
        nCln84iwnC0UvsKcVAEpgnFxCYuMK4v5Uzdzoy1zY8f97Ypi7j/ftK5gtoYyMqELHrwXY6
        xmPe5/KYiT4YUNKRYkRp5ywl5aRhi0s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-TXDme9UzPdC92W-qOWp1FA-1; Sat, 31 Dec 2022 10:15:27 -0500
X-MC-Unique: TXDme9UzPdC92W-qOWp1FA-1
Received: by mail-wm1-f72.google.com with SMTP id fl12-20020a05600c0b8c00b003d96f0a7f36so11314254wmb.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 07:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsnHjuo2pdM6+4oo2kO0ihKSfLJNkSQudAlSWQORiGk=;
        b=Vf/FZ/FZYZMmj45pFO+qaRuWHNtp38SqrdsCPSt0jrjH1C6P5hBPaWLQvjqj3VqZA0
         C+Mtkr0b3kLN9znu9TnwWkYQWEPR0NXoCfsaDuOF4Qh0tbGZ+K17bFgJSQHCpv3SB4je
         5MaJbLwV3kML2sOEE35qOi+1pUe3eISZ0/JeXmAw1EhUJc2EpnSvagK4yujmt1GEYjai
         btCl53nUSqaRvtNV9HMfVBMfmfTk/ITXDpIEnizXm67dcZU2TzU93CJ0EGfl6i/G73NU
         6uYdTUrwaSas0Bo9cr5UEzuHECviYZiyhqS+WBIMDmPx0Tmo9cPbB67iNqR+Yt7sR2f4
         Ip0Q==
X-Gm-Message-State: AFqh2kqJexobFXUj4otMYY77iEV4kZ7Yzvcw9XYT0F6+WhGeFLy5cHUV
        yE3ngo/KARgNhGlj2R/f5WseKdRMtk0HxaPn7VqMCyjzRrHwXie9a20C1HwAJVXJerMl8EJMgUk
        CB9L5PuZwLQeNsAdrFBRZGGW2
X-Received: by 2002:a05:6000:1a47:b0:242:12cf:fba8 with SMTP id t7-20020a0560001a4700b0024212cffba8mr26695849wry.55.1672499726453;
        Sat, 31 Dec 2022 07:15:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt3XUJS5GUF6p64VIOAm4GEa6JxtjwW5MNUyIWr6PTYR4yXtXv26VscTAr2zrRfaCPvL2Pt3A==
X-Received: by 2002:a05:6000:1a47:b0:242:12cf:fba8 with SMTP id t7-20020a0560001a4700b0024212cffba8mr26695829wry.55.1672499726120;
        Sat, 31 Dec 2022 07:15:26 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e11-20020adf9bcb000000b00242442c8ebdsm23800641wrc.111.2022.12.31.07.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 07:15:25 -0800 (PST)
Message-ID: <7120dfd4-305f-69ac-fee8-123196ed06a9@redhat.com>
Date:   Sat, 31 Dec 2022 16:15:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/4] drm: panel: Add Himax HX8394 panel controller
 driver
Content-Language: en-US
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Mader <robert.mader@posteo.de>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Peter Robinson <pbrobinson@gmail.com>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        dri-devel@lists.freedesktop.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20221230113155.3430142-1-javierm@redhat.com>
 <20221230113155.3430142-3-javierm@redhat.com>
 <20221230154043.7v3zmzqdrnouqzd2@core>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221230154043.7v3zmzqdrnouqzd2@core>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ondřej,

Thanks a lot for your comments.

On 12/30/22 16:40, Ondřej Jirman wrote:
> Hi Javier,
> 
> On Fri, Dec 30, 2022 at 12:31:52PM +0100, Javier Martinez Canillas wrote:
>> From: Kamil Trzciński <ayufan@ayufan.eu>
>>
>> The driver is for panels based on the Himax HX8394 controller, such as the
>> HannStar HSD060BHW4 720x1440 TFT LCD panel that uses a MIPI-DSI interface.
> 
> I see you've removed debug printks from enable/disable/prepare/unprepare

Yes, because as you said were debug printks. Feel free to propose adding the
debug printks if you consider useful for normal usage and not just for devel
purposes.

> hooks. Have you tested the driver thoroughly with various DRM apps,
> with DPM/suspend/resume, etc.?
>

I did not. I wasn't expecting suspend and resume to work on the PPP given its
support is quite minimal currently.
 
> The dw-mipi-dsi driver does some unorthodox things[1], that can lead to unbalanced
> calls to these functions in some situations, and that's why all these printks
> were there. To ensure the driver hooks are called correctly, while preparing
> the code for upstreaming. This lead to broken display in some situations during
> suspend/resume.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c#L868
>

This needs to be fixed in the dw-mipi-dsi driver then. But at least we will get
a panel-himax-hx8394 driver in mainline to avoid having to use downstream trees
for development and testing.

> Also, have you checked the clocks are actually configured correctly by the
> rk3399 cru driver? I have a lot of trouble with that, too. clk driver sometimes
> selects the fractional clock, but does not give it the necessary >20x difference
> between input/output clock rates. You'll only notice if you measure clock rates
> directly, by looking at actual refresh rate, by using some testing DRM app.
> Clock subsystem sometimes shuffles things around if you switch VOPs and use big
> VOP for mipi-dsi display, instead of the default small VOP.
>

I have not. Just verified that the display was working on my PPP and could start
a mutter wayland session. We could fix the clock configuration as follow-up IMO.

> I'll test this patchset in a few days against purely mainline code, but I'm
> pretty sure looking at the modes you use, that this will not work on some
> Pinephone Pro's, and will cause display corruption when you fix your clock
> setup, so that CRU actually outputs 74.25MHz as requested by the mode. (Which
> can be fixed by this patch https://github.com/megous/linux/commit/f7ee16f12ee8a44ee2472f2967ca27768106e00f)
> 

As mentioned, I prefer to make the support incremental. First having the panel
driver and then we can fix any remaining issue as follow-up patch series.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

