Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B59A743BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjF3Mea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF3Me2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9B7ED
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688128415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g8RTn9EqhVA4WoU3sjJyfFdw9WjQDdZ+q4iTAZZl7DE=;
        b=iyUoViW0KGL5wREe2FgiCJ6fovK564De8Mqzwl2kYamwL2Y8PhEvIPgSrRFJBfe7teQP+E
        X9dME73wteUybBFsxtHGQBxU2Ed6oQaMkHH1ZF+QWxG0kt9KnaXT11OVBrtTzgNYBFSI5w
        EtcVCkxmw8s+y9u9UCjo+3ljpdrpVB8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-L0VwIAWTNROW32hoIusOTA-1; Fri, 30 Jun 2023 08:33:33 -0400
X-MC-Unique: L0VwIAWTNROW32hoIusOTA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fb89482c48so1815008e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 05:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688128412; x=1690720412;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8RTn9EqhVA4WoU3sjJyfFdw9WjQDdZ+q4iTAZZl7DE=;
        b=AyAKYOrPc6zNHcpg3v5aduUYtT1DavEsNa/6s2vT249Q1bPKOKZHwBcKHpTsgRHFRk
         sFYmGnusDJE8bVYMO9PuPjt5BJR2CoRhhqbIEoSVbEXX8cnk70ppeqf9kdKHIkxGGeZX
         gKPzmD3BxXmQi4izAGIcZH79IOih/RXfP2CVRH6gODRzMdY30GxZvVeG2V+FGRq3dHsZ
         TaaxXwk3RywQtc4B8Boo3jw2LXi9u6TxF3xWYCENgH//rR4J653OfYflI4NkuyZSqz35
         4Ka082U6L1rgVEFczEkRhCDApCrHqKA8cUOZWx8888Fi6jNkDnU/C26n5fJBONBz+Xpj
         pKjw==
X-Gm-Message-State: ABy/qLZpP9A/vN/vN584O718xKrbFQHu93DFeH5dSnsETLY0CCBE/hRX
        fJ+5fwOWVE9PWuV1l+GV1Reiue1qzFcrhQNtk/thelBNImd92tmwjiTiy2wMsVcQwuz0D/f+5u3
        Cf0ES29+lBvumJHaaW8Pyl2n9
X-Received: by 2002:a19:e01d:0:b0:4fb:7592:cc7a with SMTP id x29-20020a19e01d000000b004fb7592cc7amr1864473lfg.20.1688128412056;
        Fri, 30 Jun 2023 05:33:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEPcKIsx1PFyrX6glb99eed7uOYj0G9AORD207eHckxnKyQzVkzS+r7LJmJCOj1yiVBtwnBmg==
X-Received: by 2002:a19:e01d:0:b0:4fb:7592:cc7a with SMTP id x29-20020a19e01d000000b004fb7592cc7amr1864445lfg.20.1688128411633;
        Fri, 30 Jun 2023 05:33:31 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003f9cb3c8958sm22023924wmg.3.2023.06.30.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 05:33:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 0/2] Allow disabling all native fbdev drivers and only
 keeping DRM emulation
In-Reply-To: <d231d0fe-c5f5-073a-3b8c-9441e1674c24@suse.de>
References: <20230629225113.297512-1-javierm@redhat.com>
 <d231d0fe-c5f5-073a-3b8c-9441e1674c24@suse.de>
Date:   Fri, 30 Jun 2023 14:33:30 +0200
Message-ID: <87bkgxdt9h.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

Thanks a lot for your review.

> Hi Javier
>
> Am 30.06.23 um 00:51 schrieb Javier Martinez Canillas:
>> This patch series splits the fbdev core support in two different Kconfig
>> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
>> be disabled, while still having the the core fbdev support needed for the
>> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
>> disabling all fbdev drivers instead of having to be disabled individually.
>> 
>> The reason for doing this is that now with simpledrm, there's no need for
>> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
>> now disable them. But it would simplify the config a lot fo have a single
>> Kconfig symbol to disable all fbdev drivers.
>
> I still don't get the point of this change. We've disabled the fbdev 
> drivers once. And they are off now and remain off.
>

Yes, but doing that means you have a bunch of these in your kernel config:

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_ARMCLCD is not set
...

I don't know how the kernel configuration management for the OpenSUSE
kernel package works, but at least in Fedora this translates to needing to
have a lot of explicit disable configurations in the form of:

$ cat redhat/configs/common/generic/CONFIG_FB_CIRRUS 
# CONFIG_FB_CIRRUS is not set

$ ls redhat/configs/common/generic/CONFIG_FB_* | wc -l
61

I want to get rid of all those and the goal of this series is to reduce
that configuration to only:

$ cat redhat/configs/common/generic/CONFIG_FB
# CONFIG_FB is not set

$ cat redhat/configs/common/generic/CONFIG_FB_CORE
CONFIG_FB_CORE=y

> The patchset now introduces FB_CORE, which just adds more options. But 
> you're not reducing the code or compile time or any thing similar.
>

No need for any redhat/configs/common/generic/CONFIG_FB_* because those
don't need to be explicitly disabled anymore since CONFIG_FB isn't set.

And the "Frame buffer hardware drivers" section in the .config goes away.

So it is a configuration simplification even when you can achieve the same
with the existing Kconfig symbols.

> I'd like to suggest a change to these patches: rather then making FB and 
> DRM_FBDEV_EMULATION depend on FB_CORE, make them select FB_CORE. That 
> will allow the DRM subsystem to enable framebuffer emulation 
> independently from framebuffer devices. If either has been set, the 
> fbdev core will be selected.
>

Yes, I guess that making it a non user-visible option makes sense. I'm
just wary of using select because I've bitten in the past by circular
dependencies when other symbol depends on it.

But I'm OK with that change and will do in v2.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

