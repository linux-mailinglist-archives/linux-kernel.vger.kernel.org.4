Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6475774416C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjF3RjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjF3RjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2130F7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688146685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVYUQaLIlYzTkSSGVDZ9hVc8AmWln/G3KSgwkF5UBS4=;
        b=VHtxW9Jiz4MzjsWZNXiKDRqKIwGWTH3hed6tMQgxhU4gJrlF8HgwHhJO6iDXKLiXqn7LA2
        j6QLkBfTHnOksewQ7RiZkqDuy4tIdFej0DcBnND1QTPqJ8iiZVzuONaQv5Mijlu2Zlj8Mj
        5+ILuh6mtiNZx0CCvxRiys7Al6lZZVA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643--sR6qs3wNmK8CM6cFcs4nA-1; Fri, 30 Jun 2023 13:38:04 -0400
X-MC-Unique: -sR6qs3wNmK8CM6cFcs4nA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30793c16c78so2726820f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688146683; x=1690738683;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVYUQaLIlYzTkSSGVDZ9hVc8AmWln/G3KSgwkF5UBS4=;
        b=TaA4yhjFEP99/iYP6lzHCPrqgr4Sgg0odXjUwU53oS9By4WuVaF7UvHTrGwiYTFhRF
         wVXAcMWTKsvp7o+3UPN3EnfbbgoK6q3Evt96ZPgoTFrEF5KdOrUylD3+n4PzBwctT7Qv
         4wiCQVlgpXRQPad0ZrXg0uXS8RFiH7lcn2xGt8dLqoJGWAP8K0BgJ4NwAYR3/oGCFLUx
         lFro9kXrM8yDeQmBbgyAmbeAzhBxlnc46mgC1tkAjx98yGMeCSUHa0L2nbPIwT/yzPUo
         QzvX2vojnpC70Sub1dkC8uKZjiYSpvL2ewJAin19Ic4ACDGlPqlPuYDd4Jo2lqju1u3h
         UPCA==
X-Gm-Message-State: ABy/qLbIv5Qp2/KI93LqaQjpKbcaLyyG9htHVP5fe/g1C09qh/OOwm9H
        WP/QwSkHirR3+xxw122c4/8aus9PGRgL/2lXuj1bxhCbRgHd/IJ+APFaqXob0DA+5lAp3QaPSi2
        Hwar4XebhdRe0QyI7Xedv/B4M
X-Received: by 2002:a05:6000:118b:b0:2fb:1d3a:93ff with SMTP id g11-20020a056000118b00b002fb1d3a93ffmr3144622wrx.61.1688146683306;
        Fri, 30 Jun 2023 10:38:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGNvUqGRtSpV8GYS4YvqUz/RSiCqQm8TkeXUu3ip49084GlOjfQ0N7UqSkJYBy9eyJgB2uFhw==
X-Received: by 2002:a05:6000:118b:b0:2fb:1d3a:93ff with SMTP id g11-20020a056000118b00b002fb1d3a93ffmr3144605wrx.61.1688146683015;
        Fri, 30 Jun 2023 10:38:03 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c13-20020adfe74d000000b0030ae499da59sm3745589wrn.111.2023.06.30.10.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:38:02 -0700 (PDT)
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
In-Reply-To: <ZJ8RY7ZUlryrPB50@smile.fi.intel.com>
References: <20230629225113.297512-1-javierm@redhat.com>
 <ZJ8RY7ZUlryrPB50@smile.fi.intel.com>
Date:   Fri, 30 Jun 2023 19:38:01 +0200
Message-ID: <878rc0etqe.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

Hello Andy,

> On Fri, Jun 30, 2023 at 12:51:02AM +0200, Javier Martinez Canillas wrote:
>> This patch series splits the fbdev core support in two different Kconfig
>> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
>> be disabled, while still having the the core fbdev support needed for the
>> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
>> disabling all fbdev drivers instead of having to be disabled individually.
>> 
>> The reason for doing this is that now with simpledrm, there's no need for
>> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
>
> How does simpledrm works with earlycon=efi?
>

simpledrm isn't for earlycon. For that you use a different driver (i.e:
drivers/firmware/efi/earlycon.c). I'm just talking about fbdev drivers
here that could be replaced by simpledrm.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

