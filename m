Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141D466E8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjAQVnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAQVjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:39:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805E24DE20
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673985859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mzwnjP64jKMnxG92NfKkitU4148esuOMPr7a584cgLk=;
        b=QhqW9VRdExrzHwYwrvKVavAUajZ4v3YuVqsriqRxWvswXYu7nQ4kmGT1inTt43DzVRmNGy
        Y6BLWJMzz3sxj9lzrjOA2IHUEgMA1s8G+taielUmwnpF5Mv33Kb4lpbLcrWlCUX4TWgK+O
        2PYs/oaEByd5EX7b3xJWuigGoBQhUOA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-386-WyPdpVY-NTm7S2NM8-Ri0A-1; Tue, 17 Jan 2023 15:04:18 -0500
X-MC-Unique: WyPdpVY-NTm7S2NM8-Ri0A-1
Received: by mail-wr1-f72.google.com with SMTP id l18-20020adfa392000000b002bbd5c680a3so6070128wrb.14
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzwnjP64jKMnxG92NfKkitU4148esuOMPr7a584cgLk=;
        b=XpxEjBnXVfWV33wXFKD/KBZ5vgB3Y75du5C17udn9CgaOB9AfLSa3P9/Xv7abU1p3r
         fZNRn2AYnsQ8Jif6wTmuSKCBNe85+dqxR+7RJQWcn4QfjJDyyAAKn0HlE5IRt5kl2ria
         P3wyX24sl95TpIPXfvSHj9Bu0uK+N6fvp0TAtZlWsWY0IholRgBORSDXxE+z3KCj/yrh
         dZO1o73ED/aaaGKQr+AaUUWNE7bjdeAA6Bg8caDvXJLPhHTCpoqxuTywrHANkTSlDGsP
         SKJh9Ed2QJ8D8eMzC/brrtlBdO4Xg92R83MfnIbMvQOYAdIJ6X3jUagoeFM/NzhvdUYM
         0T3w==
X-Gm-Message-State: AFqh2krIhI1pHJdmRtwUD3+fYcMUOEGHp2pxwZSoHy5Ncr9qSR146/qm
        IM0FYtiFZGea0UWCTZx8eI9VAKt4GZ9VO4RHpN1uikwGQBv4riaNKJJlsKweO3wjBXYNrnxaKGY
        R+N1ykz0QLT1kd+W9zdJVWK+H
X-Received: by 2002:a05:600c:4b06:b0:3da:fdf6:6a59 with SMTP id i6-20020a05600c4b0600b003dafdf66a59mr75362wmp.33.1673985857058;
        Tue, 17 Jan 2023 12:04:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuIpUpkEp1rT4yuT2zy4Jbbp9JpTBEf3SA3uw7zXp5dsbH8kudKBX3Hqk6N1uroDz//cIJZHg==
X-Received: by 2002:a05:600c:4b06:b0:3da:fdf6:6a59 with SMTP id i6-20020a05600c4b0600b003dafdf66a59mr75351wmp.33.1673985856802;
        Tue, 17 Jan 2023 12:04:16 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003d974076f13sm40500906wmo.3.2023.01.17.12.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 12:04:16 -0800 (PST)
Message-ID: <077a3ecf-c0e1-7b77-7b46-1acfef734769@redhat.com>
Date:   Tue, 17 Jan 2023 21:04:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] drm: panel: visionox: add backlight dependency
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230117165522.2104380-1-arnd@kernel.org>
 <CACRpkdb0rA8DmiGj79f6+6qOCChUuQrYzmQ+Yjk6BxeBzjM4_A@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CACRpkdb0rA8DmiGj79f6+6qOCChUuQrYzmQ+Yjk6BxeBzjM4_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 19:22, Linus Walleij wrote:
> On Tue, Jan 17, 2023 at 5:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> 
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The newly added driver uses the backlight subsystem but is missing the
>> corresponding Kconfig dependency:
>>
>> arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-visionox-vtdr6130.o: in function `visionox_vtdr6130_probe':
>> panel-visionox-vtdr6130.c:(.text+0xdee): undefined reference to `devm_backlight_device_register'
>>
>> Fixes: 65dc9360f741 ("drm: panel: Add Himax HX8394 panel controller driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Patch applied, thanks for fixing this!
> 
> Yours,
> Linus Walleij
>

Thanks Arnd and Linus for fixing this. Sorry that I missed it
while upstreaming the driver.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

