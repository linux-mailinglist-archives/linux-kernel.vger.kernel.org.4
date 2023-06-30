Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC4F74432D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjF3UaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3UaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD582D69
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688156965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7z4+FJGtx+jfLkCNL8iZp50XQ8kawtYgJi/zo0dFBDw=;
        b=T0gizRdiRckitO1wADxERpIhJlMGbBqMoQQHIw663V4ZFM+uDKCjDtw7iT2SL8h4ZaMq+G
        U/5Q1L6107QSYeGJTKLUEKEKLjESTLdcBti2UWcKqGAa5V0WsQDCSxtzv198XpkpnSwYku
        pND7KJAXi9z6QKbGpQUX6Tthe4QPmyc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-QAGutIREPyu0b9ArYSqdZA-1; Fri, 30 Jun 2023 16:29:23 -0400
X-MC-Unique: QAGutIREPyu0b9ArYSqdZA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa9a282fffso13218645e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688156962; x=1690748962;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7z4+FJGtx+jfLkCNL8iZp50XQ8kawtYgJi/zo0dFBDw=;
        b=H4CE8k8j3zvVHoefSrteQwhzoRnJ5PQe2wbAz7E6hwlAGlRpHuK9i9BBpfT+l+2GZJ
         1OAOfH6z35ZMhgUzJ4C/QR1dol+C8uaom/PnrSB4Rogn7Kp+eKvMGAE4HSN308hktah4
         BEC7mGu5U78eZC3JJ6jq17+OR+N5SYw5G/+mcxUyuEi4p9ORyfgS7W+q5bDkRQMTTya5
         2/yuDKqxii6jGm8U3INoVvoGA3XUDXlOZYjxWqGq9fhlY/uj+H25BhPlssaTmI5B3ns9
         yq1z3mRSPJHthksEKkLD7mw8kVvRo19D8QDgVY8sXGEMpBf5uJOFZ1vN9YrS8m1QR6Rc
         n0TQ==
X-Gm-Message-State: AC+VfDw6BO11OI6+JCobanDk5K3bJ8Tq6aNXvpx2iJjqeVrlu+1wt7BF
        Q1G1ZI3b8oCD6J3J4jP/GSUEQplUbulwlIi+TScfV/D7QRrq/s3MctbK80+5VrlEEW3geKHjVz/
        jJqAMXBMlXoUiVdpr3Skj1I6f
X-Received: by 2002:a7b:c8c9:0:b0:3f8:fe2a:25c2 with SMTP id f9-20020a7bc8c9000000b003f8fe2a25c2mr2902271wml.38.1688156962805;
        Fri, 30 Jun 2023 13:29:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5t8O8YZhUAlsnULK6AfHeoTDYcnWUXH+rludG0BAB8MB7qDFkZFaO5oKC6zcLL0Qt4ESi3eA==
X-Received: by 2002:a7b:c8c9:0:b0:3f8:fe2a:25c2 with SMTP id f9-20020a7bc8c9000000b003f8fe2a25c2mr2902251wml.38.1688156962461;
        Fri, 30 Jun 2023 13:29:22 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n10-20020a1c720a000000b003fa96620b23sm15085928wmc.12.2023.06.30.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 13:29:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
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
In-Reply-To: <ZJ8T/Fexkr9wEZoP@smile.fi.intel.com>
References: <20230629225113.297512-1-javierm@redhat.com>
 <ZJ8RY7ZUlryrPB50@smile.fi.intel.com>
 <878rc0etqe.fsf@minerva.mail-host-address-is-not-set>
 <ZJ8T/Fexkr9wEZoP@smile.fi.intel.com>
Date:   Fri, 30 Jun 2023 22:29:20 +0200
Message-ID: <875y74elsv.fsf@minerva.mail-host-address-is-not-set>
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

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Fri, Jun 30, 2023 at 07:38:01PM +0200, Javier Martinez Canillas wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Fri, Jun 30, 2023 at 12:51:02AM +0200, Javier Martinez Canillas wrote:
>> >> This patch series splits the fbdev core support in two different Kconfig
>> >> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
>> >> be disabled, while still having the the core fbdev support needed for the
>> >> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
>> >> disabling all fbdev drivers instead of having to be disabled individually.
>> >> 
>> >> The reason for doing this is that now with simpledrm, there's no need for
>> >> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
>> >
>> > How does simpledrm works with earlycon=efi?
>> >
>> 
>> simpledrm isn't for earlycon. For that you use a different driver (i.e:
>> drivers/firmware/efi/earlycon.c). I'm just talking about fbdev drivers
>> here that could be replaced by simpledrm.
>
> So, efifb can't be replaced. Please, fix your cover letter to reduce false
> impression of the scope of usage of the simpledrm.
>

Nothing to fixup.

You are conflating the efifb fbdev driver (drivers/video/fbdev/efifb.c)
with the efifb earlycon driver (drivers/firmware/efi/earlycon.c). I'm
talking about the former (which can be replaced by simpledrm) while you
are talking about the latter.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

