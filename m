Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDD06E0077
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDLVGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDLVGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556586E96
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681333460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0bMZvsE0YPLZTGS16xnH5Lejha4qtBtyQdG3KbiVSs=;
        b=N7/wAjY1EvdYGrNsx79ZD+ZEvGSVhMYLA0KPQEaxyLD7SOuyIL/v3I5ueWoc0r0+FB6+sw
        Juvtly84O+f+Ze4Ssb2O2bWIWOAgkf+fi8E5Aqk4fyVniAo95GYLzbYELAhNewqfU49tgc
        NP0KJEzjZDy1fv2xIzoIp3Xo6tGkHdY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-PLwltWq5OUOtL6uoGWvELQ-1; Wed, 12 Apr 2023 17:04:18 -0400
X-MC-Unique: PLwltWq5OUOtL6uoGWvELQ-1
Received: by mail-wm1-f69.google.com with SMTP id m4-20020a05600c3b0400b003f0968719a7so2262630wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333457; x=1683925457;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0bMZvsE0YPLZTGS16xnH5Lejha4qtBtyQdG3KbiVSs=;
        b=dyLRf7FbCGo9eH1DkfKU2QIFsrcV4sWLBjFxamL6PkVKrw50sV7wWSfWdXs6GEOkhJ
         RYEmeeqJYVz5Tlmf3l2QppEKHXc4OrT7aNz1KVLohq1IEe6iQirKk4Xi3Kpxqq/MJNbD
         Yb6/6YMInHq6jIWVooGKVQKB0dVhFpnltRqm3ZhUEJ3w3daEJZw2TpkJC2lZBQC3I/nN
         NOLd6nGL8xZsoFzs7ztnXWEb5TdYHTv3Z7UidungCHlPWi7L9vA87BYWzjpNzx7EU2VQ
         2IKyzqdKEU4P7BfpniG4NdSCQsrUUA3Rar51qYdvmC3P+8xOsJp1ke1rBQdnxelVN73h
         9t7A==
X-Gm-Message-State: AAQBX9etcfbVQgv0+UC9407ThN8u65y9Sb4tyay3EVzeVkBiDdv9OwPT
        Ffm3F/aJHBgkdAS1ZnaSO1lTCneXQOxN3u6uN0kuv1prKJKopNIt6gH5qorijats7WW62Uf8kJe
        3SVyiZmQ9o2qT1dDEigEPI2A/
X-Received: by 2002:a7b:cb49:0:b0:3eb:3104:efec with SMTP id v9-20020a7bcb49000000b003eb3104efecmr76070wmj.16.1681333457422;
        Wed, 12 Apr 2023 14:04:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350YjRcE/zRqnHDiEsrN2JH7uxueKk3X88weqqIILukDbFDl5GuAcq0iOc8eQT5UTTwngdY48nw==
X-Received: by 2002:a7b:cb49:0:b0:3eb:3104:efec with SMTP id v9-20020a7bcb49000000b003eb3104efecmr76061wmj.16.1681333457103;
        Wed, 12 Apr 2023 14:04:17 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c228600b003ed2c0a0f37sm3535032wmf.35.2023.04.12.14.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:04:16 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Pierre Asselin <pa@panix.com>
Cc:     Pierre Asselin <pa@panix.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is
 calculated
In-Reply-To: <1afd3044c2aca9322ecf304941c7df66.squirrel@mail.panix.com>
References: <20230412150225.3757223-1-javierm@redhat.com>
 <2e07f818ccdff7023a060e732d7c4ef6.squirrel@mail.panix.com>
 <87jzyhror0.fsf@minerva.mail-host-address-is-not-set>
 <beeff0335ab4cc244d214a7baadba371.squirrel@mail.panix.com>
 <CAFOAJEdKBUg91pDmNYYw5xigUxjifBgOLz2YgD+xQ+WyEy=V2w@mail.gmail.com>
 <1afd3044c2aca9322ecf304941c7df66.squirrel@mail.panix.com>
Date:   Wed, 12 Apr 2023 23:04:15 +0200
Message-ID: <87fs94stgw.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Pierre Asselin" <pa@panix.com> writes:

>> And can you share the "linelength=" print out from simplefb ?
>
> Okay.  Three cases, see below.
>
> Your patch tries to fix the stride, but what if it's the _depth_
> that's wrong ?  Grub sets the mode, the pre-regression kernel picks this:
>     format=x8r8g8b8, mode=1024x768x32, linelength=4096
>

Yes, it seems the VBE mode set by GRUB is x8r8g8b8. And the line length
calculation is also correct: 1024 * (32 / 8) = 4096.

> ========== Good ======================================================
> grub: gfxpayload=1024x768x24
> [    0.003333] Console: colour dummy device 128x48
> [    0.003333] printk: console [tty0] enabled
> [    0.417054] fbcon: Taking over console
> [    0.513399] pci 0000:01:05.0: vgaarb: setting as boot VGA device
> [    0.513431] pci 0000:01:05.0: vgaarb: bridge control possible
> [    0.513455] pci 0000:01:05.0: vgaarb: VGA device added:
> decodes=io+mem,owns=io+mem,locks=none
> [    0.513490] vgaarb: loaded
> [    3.337529] simple-framebuffer simple-framebuffer.0: framebuffer at
> 0xd8000000, 0x240000 bytes
> [    3.337567] simple-framebuffer simple-framebuffer.0: format=r8g8b8,
> mode=1024x768x24, linelength=3072

This is also correct when GRUB sets it to r8g8b8, since the line length
is: 1024 * (24 / 8) = 3072.

> [    3.338000] Console: switching to colour frame buffer device 128x48
> [    3.566490] simple-framebuffer simple-framebuffer.0: fb0: simplefb
> registered!
>
> ========== Bad after patch, typing blind to log in !==================
> grub: gfxpayload=keep
> [    0.003333] Console: colour dummy device 128x48
> [    0.003333] printk: console [tty0] enabled
> [    0.423925] fbcon: Taking over console
> [    0.520030] pci 0000:01:05.0: vgaarb: setting as boot VGA device
> [    0.520061] pci 0000:01:05.0: vgaarb: bridge control possible
> [    0.520085] pci 0000:01:05.0: vgaarb: VGA device added:
> decodes=io+mem,owns=io+mem,locks=none
> [    0.520120] vgaarb: loaded
> [    3.290444] simple-framebuffer simple-framebuffer.0: framebuffer at
> 0xd8000000, 0x240000 bytes
> [    3.290483] simple-framebuffer simple-framebuffer.0: format=r8g8b8,
> mode=1024x768x24, linelength=3072

Now, this is the part where things start to break I believe. Because you
mentioned before that gfxpayload=keep used to set the format to xr8g8b8
but now after my patch (and also after the original commit f35cd3fa7729)
it is set to r8g8b8 instead.

That *shouldn't* be an issue because it only means that the alpha channel
is discarded but maybe it is an issue for your display controller?

By the way, in https://www.panix.com/~pa/linux-6.3-simplefb/selected-modes
that you shared before the gfxpayload=keep GRUB option used to also led to
the pixel format being set to r8g8b8 instead of xr8g8b8. The difference is
that in that output the line lenght didn't match the pixel format and size:

[    3.290596] simple-framebuffer simple-framebuffer.0: format=r8g8b8, mode=1024x768x24, linelength=4096

but after my patch you mentioned that is:

[    3.290483] simple-framebuffer simple-framebuffer.0: format=r8g8b8, mode=1024x768x24, linelength=3072

which at least matches, so in a way is an improvement (even when it still
doesn't work).

> [    3.290916] Console: switching to colour frame buffer device 128x48
> [    3.519523] simple-framebuffer simple-framebuffer.0: fb0: simplefb
> registered!
>
> ========== Good, earlier kernel before regression ====================
> grub: gfxpayload=keep
> [    0.226675] Console: colour dummy device 128x48
> [    0.228643] printk: console [tty0] enabled
> [    0.429214] fbcon: Taking over console
> [    0.524994] pci 0000:01:05.0: vgaarb: setting as boot VGA device
> [    0.525025] pci 0000:01:05.0: vgaarb: bridge control possible
> [    0.525049] pci 0000:01:05.0: vgaarb: VGA device added:
> decodes=io+mem,owns=io+mem,locks=none
> [    0.525082] vgaarb: loaded
> [    3.320474] simple-framebuffer simple-framebuffer.0: framebuffer at
> 0xd8000000, 0x300000 bytes
> [    3.320513] simple-framebuffer simple-framebuffer.0: format=x8r8g8b8,
> mode=1024x768x32, linelength=4096

Yes, and it works because is the correct mode it seems but for some reason
after commit f35cd3fa7729 the pixel format is calculated incorrectly. We
can see that the total framebuffer size is 0x300000 bytes, which matches a
1024x768x34 mode framebuffer: 1024 * 768 * (34 / 8) = 3342336 = 0x300000.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

