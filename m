Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FF9746AC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjGDHh3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 03:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjGDHhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:37:25 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFFFE5B;
        Tue,  4 Jul 2023 00:37:24 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5728df0a7d9so66092607b3.1;
        Tue, 04 Jul 2023 00:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688456243; x=1691048243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttaFFJ0r0f9jhzySfvd5lZ1LEwbKcvVHje2Xigt05e4=;
        b=Wg6s6p9wLsYLXMQ54+1dGpn5wB2a68KaX2axjzS6Ud3qiI1n+ogWTxx1WzkdHKc5oy
         /yIHtdsVjn+v4KDuV9JpNHb6Zyd8zZ+Bi8t80S+vhxQCEg0zIZE4bUDiCuSfgUbvQMmP
         XQWb1SeP2Q6KwQtgQHZlSvILEsm0PktgszWvN/KfgKoxw+7acMGydkScvwG28a8S7ROG
         kEu5uHOeU9yBxvSI3OjiVFlsIUjJ7qzubfm2+NfegwTatpKIDz7+P0WXkO5HNvflkmdh
         csDndSvARMsjMlDg+pL3Im3aE95SmRRuPO1oLdjhWDLR31W/rnNdWx1a5rYr/sUWO2DO
         nq3w==
X-Gm-Message-State: ABy/qLbfV9Pd4mpZ3NfSUCXF0CAhk7jBg7K9dzviIkF+7/b6uwAXFBNZ
        AkKV4ZRzN9yaB8u5UJ7vk9dB+NpbimhgKQ==
X-Google-Smtp-Source: APBJJlHwlQ4ScDs0JUrT4LSjPnA+MDeRzxPICLf5D5cZ5Iw4ecLnyX62VhzbtCAF6MzvLhlIIagXMQ==
X-Received: by 2002:a81:5249:0:b0:579:efd3:964 with SMTP id g70-20020a815249000000b00579efd30964mr5781714ywb.52.1688456243148;
        Tue, 04 Jul 2023 00:37:23 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id z6-20020a816506000000b0056d443372f0sm5532978ywb.119.2023.07.04.00.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:37:22 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bacf685150cso6075115276.3;
        Tue, 04 Jul 2023 00:37:21 -0700 (PDT)
X-Received: by 2002:a5b:412:0:b0:ba8:7122:2917 with SMTP id
 m18-20020a5b0412000000b00ba871222917mr12316676ybp.0.1688456241685; Tue, 04
 Jul 2023 00:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230703230534.997525-1-javierm@redhat.com> <20230703230534.997525-2-javierm@redhat.com>
In-Reply-To: <20230703230534.997525-2-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jul 2023 09:37:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRg1OUy6UHuH4H+qkK-qO+jTKdVoG_SRM3q_PkyD+Bbw@mail.gmail.com>
Message-ID: <CAMuHMdXRg1OUy6UHuH4H+qkK-qO+jTKdVoG_SRM3q_PkyD+Bbw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] video: Add auxiliary display drivers to Graphics
 support menu
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Tue, Jul 4, 2023 at 1:05 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The drivers in this subsystem are for character-based LCD displays, which
> can fall into the same category of the DRM/KMS and fbdev drivers that are
> located under the "Graphics support" menu. Add auxdisplay there as well.
>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch!

> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -30,6 +30,8 @@ if HAS_IOMEM
>  config HAVE_FB_ATMEL
>         bool
>
> +source "drivers/auxdisplay/Kconfig"

This is inside the "if HAS_IOMEM" section, while there was no
such limitation before.

> +
>  source "drivers/char/agp/Kconfig"
>
>  source "drivers/gpu/vga/Kconfig"

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
