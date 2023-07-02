Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DCD744D37
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGBKUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 06:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGBKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 06:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8320AE54
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 03:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688293181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CgQxeEa8jqCYUVhkKmhV5tOhyTakZG82kmCOFjxpLGQ=;
        b=SkWg1D5dfiGEhAnSVwSZu09k94bf9idMiK0beh+uQPdvM2L+utnPsybmkZASYFfWUfrd9V
        cfJ2rKZS7+LOQ+h05706cfS3PrCVHc1cDuGfZbgFDTNJ8u3qC0xFDmaFUaoU5IFMzGQhRK
        H1gG9jvAVm18rIHJPtLZ++/RQMcKRN8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-L48wZYvpNdOtfHFKDujn8g-1; Sun, 02 Jul 2023 06:19:40 -0400
X-MC-Unique: L48wZYvpNdOtfHFKDujn8g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-313f3c115eeso1477930f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 03:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688293179; x=1690885179;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgQxeEa8jqCYUVhkKmhV5tOhyTakZG82kmCOFjxpLGQ=;
        b=M7K73muJZneLXn4OQPqj29+dRv95gIJBNomLSbCj1KNv8nBozpCHubEup4XiUjXRrd
         vcRlCUymiDwxoXYCiobFrkOLJmfqzZI5F+ORuVtMDIEgP0AaH3lnjcBHAGPYipO58Hqd
         SbTZZSov4OLPCpaO0D+mp/lcBEa0bOhmKyDbC9TPp1OX4v9T+VlXtGVXlC3oewkt3PrU
         /JtBmodi40UTPABHUcPiwXjE4mavgC7t5yrL3cc9q8baQfafMQJYR6GTPfATltIvAFkk
         K0FONI0Zqri/Ff+7Ja1OmkohwY0BNzFYLNVyI25zNsj7Oa9S37iywPSoITmWApg7VQcU
         ixYA==
X-Gm-Message-State: ABy/qLa2uz0QqPiEz0SU5N478QexY/tLPiSN2bwQxNLBmbr/kabUJBLd
        /Ktnynj3+gijqyC7x4h1iAL8Hz9LA0AeZ+qO7PU08Gd3K2IVzouDIoJJTjTGdIwrXD47qK3wkQE
        7yY1cgW41PYXmgUvwWRXvaR20
X-Received: by 2002:a5d:6305:0:b0:314:c16:56a2 with SMTP id i5-20020a5d6305000000b003140c1656a2mr6649471wru.14.1688293178959;
        Sun, 02 Jul 2023 03:19:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlED9UAI+pN01OyAZSNkgl/k6bHCO5vXZ3hF4y0fd+CA4fhHoSTFMuvvTrZSJH9GgAxVfKoLzg==
X-Received: by 2002:a5d:6305:0:b0:314:c16:56a2 with SMTP id i5-20020a5d6305000000b003140c1656a2mr6649462wru.14.1688293178713;
        Sun, 02 Jul 2023 03:19:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d4111000000b003142eb75724sm2766867wrp.24.2023.07.02.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 03:19:38 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH v2 1/2] fbdev: Split frame buffer support in FB and
 FB_CORE symbols
In-Reply-To: <CAMuHMdWLRBePox24kBHBMhzKWZX2ncXCD_8JBZrWcbwo0eBZ1Q@mail.gmail.com>
References: <20230701214503.550549-1-javierm@redhat.com>
 <20230701214503.550549-2-javierm@redhat.com>
 <393ca142-5226-4779-a963-c34fb0464c59@app.fastmail.com>
 <CAMuHMdWLRBePox24kBHBMhzKWZX2ncXCD_8JBZrWcbwo0eBZ1Q@mail.gmail.com>
Date:   Sun, 02 Jul 2023 12:19:37 +0200
Message-ID: <87pm5aaa4m.fsf@minerva.mail-host-address-is-not-set>
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Arnd,
>

[...]

>>
>> That would leave CONFIG_FB_DEVICE as the only user visible option
>> for DRM-only configs, which is slightly odd for the menuconfig,
>> so I still wonder if that could be done differently.
>>
>> Is there actually a point in configurations for kernels with FB=y,
>> DRM=n and FB_DEVICE=n? If we don't expect that to be a useful
>> configuration, an easier way would be to have CONFIG_FB turn it
>> on implicitly and instead have a user-visible Kconfig option
>> below CONFIG_DRM_FBDEV_EMULATION that allows controlling the
>> creation of /dev/fb*.
>
> Such a combination would allow the user to still have a text console
> on a legacy fbdev, while not having to worry about possible security
> ramifications of providing fbdev userspace access.
>

Exactly, it may be a possible combination. Not sure how useful what would
be in practice but we shouldn't restrict that IMO.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

