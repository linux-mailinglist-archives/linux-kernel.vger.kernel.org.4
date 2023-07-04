Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9317B746B4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGDH5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGDH5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AFEE70
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688457416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yfSuLMbi885ncjU/SXY8s5ylufowrHraHlPM4HxykdE=;
        b=C2ZkW5jChF1LVX1PIQPeEzdWjt7+Ct5ZK8cpWSTw4fS9my/bAK60eZSOn0qzA7jyQWPIxP
        lszllsajYmvJ9stuuzcPWkxHF1TFDHRbBNOro3cgYcgUKJPVFIvjwIVEHSGB+2vNqgbGeh
        ceng5fY9RVEibzb6GHc2MzN6RzIAz3o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-2pPkClM2OACNaEyRYKeccw-1; Tue, 04 Jul 2023 03:56:52 -0400
X-MC-Unique: 2pPkClM2OACNaEyRYKeccw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-313ec030acbso2155155f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457411; x=1691049411;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfSuLMbi885ncjU/SXY8s5ylufowrHraHlPM4HxykdE=;
        b=bE7tVI09E3WqOr+ojg190qZoi3zUWUrrRBoR4rqs8clG8o/rKDrofQCEse0c/WIZc0
         nuvKlfvmzPfw83pjkQvEn9bWKQkdY9ae6F+c2enMMHTsGuE1DLTk7qIn5HMDToIpQ9q4
         oz2DiicW3Elg923/zW4hEgfdd0BZrE7oPAkoF0vO9i7ZQ2Ng62naeZFF6Pj/F336z18u
         850daz0kE1TrOq8wN3XRgMjj4oTfB/XEr+PSf3HY5KmtDXbtNn+TQ7hhAmlLU32VrhzG
         qDxVv7rh1zTDXOY9LC8ZeaNhA7t6fgZ4bL+gjX09umITVBbAOl6E6WV0IyHTUk3dBT+z
         P6Uw==
X-Gm-Message-State: ABy/qLaweoAP4k06bErsipFokpcizKWa7k1wT7ULJ74FLc+8H2A1qR1i
        iCyrXiAHUxqF0jREwYDFtJ0SM7IuI8PrZDyWJ0O8hcH/qt0WjcH/mDObI61/fOtMDSbs0tsHcVW
        15wBanMTlY5xMDOxNJe/EHskU
X-Received: by 2002:a5d:464a:0:b0:314:17ac:5bac with SMTP id j10-20020a5d464a000000b0031417ac5bacmr11844911wrs.33.1688457411270;
        Tue, 04 Jul 2023 00:56:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFU3Enu3ZhJIcLl8uDKqbLIoqK9rspavgFUf3CsZtMjrcO2FgaiIgTbGO0/u6yb7XYsnrsZMQ==
X-Received: by 2002:a5d:464a:0:b0:314:17ac:5bac with SMTP id j10-20020a5d464a000000b0031417ac5bacmr11844900wrs.33.1688457410930;
        Tue, 04 Jul 2023 00:56:50 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d17-20020adffbd1000000b002fb60c7995esm27613884wrs.8.2023.07.04.00.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:56:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v4 4/5] fbdev: Split frame buffer support in FB and
 FB_CORE symbols
In-Reply-To: <ZKPIQngz6WkzASqa@smile.fi.intel.com>
References: <20230703230534.997525-1-javierm@redhat.com>
 <20230703230534.997525-5-javierm@redhat.com>
 <ZKPIQngz6WkzASqa@smile.fi.intel.com>
Date:   Tue, 04 Jul 2023 09:56:49 +0200
Message-ID: <87edloyuri.fsf@minerva.mail-host-address-is-not-set>
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


Hello Andy,

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, Jul 04, 2023 at 01:05:28AM +0200, Javier Martinez Canillas wrote:
>> Currently the CONFIG_FB option has to be enabled even if no legacy fbdev
>> drivers are needed (e.g: only to have support for framebuffer consoles).
>> 
>> The DRM subsystem has a fbdev emulation layer, but depends on CONFIG_FB
>> and so it can only be enabled if that dependency is enabled as well.
>> 
>> That means fbdev drivers have to be explicitly disabled if users want to
>> enable CONFIG_FB, only to use fbcon and/or the DRM fbdev emulation layer.
>> 
>> This patch introduces a non-visible CONFIG_FB_CORE symbol that could be
>> enabled just to have core support needed for CONFIG_DRM_FBDEV_EMULATION,
>> allowing CONFIG_FB to be disabled (and automatically disabling all the
>> fbdev drivers).
>> 
>> Nothing from fb_backlight.o and fbmon.o is used by the DRM fbdev emulation
>> layer so these two objects can be compiled out when CONFIG_FB is disabled.
>
> ...
>
> Wondering if
>
>   if FB_CORE
>   ...
>   endif
>
> makes Kconfig looking better instead of replacing all these "depends on" lines.
>

Yes, I discussed that with Arnd and he said that the if / endif is just
syntax sugar so I didn't do that change to keep the patches simpler. But
is something that you could change as a follow-up if you prefer that way.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

