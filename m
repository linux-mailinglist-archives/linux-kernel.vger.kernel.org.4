Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03C069E0DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjBUMys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjBUMyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:54:46 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6224924128;
        Tue, 21 Feb 2023 04:54:37 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id o3so4139182qvr.1;
        Tue, 21 Feb 2023 04:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//uXXWrfrL/IjKv8DHyIfqNi69QuZlv/CPgv9vyCTyo=;
        b=2XyxEsIenDUif9ktZqZigdu3HzyCw3eVtHW+0nEP+SW7M/D1ioLiiGTfGI6SHfJ0Jg
         UQhA2QV2rcFM8x9mThmvnWCryOQWlToB5M2puh/9559syyF75a/KpubJkaxLIqCvc/9c
         mwJkTQqMn8/As0zFW8DN0MCn/i3HktbCBwrisNcJBdidJVPImCHEHIKj3setakEPXoo5
         fgrppkjiRa8S2StIbG+Q36sb8Ct2Al040+Z2aJlKWP11PGIoU2c8oijaPiT8Gg6BlNfP
         ltvTrAGBQ5c9h17kGLGQkODW3UffNjNW8YGFEklQ4R8ERYQqujvB04Yg5knA/lbhHj0j
         6xfA==
X-Gm-Message-State: AO0yUKUwVzG6pabAyrHH0GOPXDCgpd7sIFuf3pHgGSMwWWUTvEeBxuDZ
        ZByNPtF9dLYPhW58AGCazVkLtQ0sPpj+Ng==
X-Google-Smtp-Source: AK7set9JbXSLfibARf+xEIPK2avCUOOoqt3AM0dSA8D5EpGAVLFkFXTE4HDrh9FGN6ddsuHvrEw5xw==
X-Received: by 2002:ad4:5d4c:0:b0:56b:ee5a:89eb with SMTP id jk12-20020ad45d4c000000b0056bee5a89ebmr7582724qvb.19.1676984076225;
        Tue, 21 Feb 2023 04:54:36 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id b6-20020ae9eb06000000b0073ba46a585asm9690342qkg.64.2023.02.21.04.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 04:54:36 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-536bfa306c1so51378637b3.3;
        Tue, 21 Feb 2023 04:54:35 -0800 (PST)
X-Received: by 2002:a81:ac07:0:b0:533:9252:32fa with SMTP id
 k7-20020a81ac07000000b00533925232famr537048ywh.4.1676984075461; Tue, 21 Feb
 2023 04:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20230208111330.439504-1-gregkh@linuxfoundation.org> <20230208111330.439504-13-gregkh@linuxfoundation.org>
In-Reply-To: <20230208111330.439504-13-gregkh@linuxfoundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Feb 2023 13:54:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUmn2NG-uf3UavgXdHC0ma+r8w+g7Bjn_PiVykHakzf1g@mail.gmail.com>
Message-ID: <CAMuHMdUmn2NG-uf3UavgXdHC0ma+r8w+g7Bjn_PiVykHakzf1g@mail.gmail.com>
Subject: Re: [PATCH 12/21] driver core: bus: bus iterator cleanups
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Feb 8, 2023 at 12:15 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Convert the bus_for_each_dev(), bus_find_device, and bus_for_each_drv()
> functions to use bus_to_subsys() and not use the back-pointer to the
> private structure.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for your patch, which is now commit 83b9148df2c95e23 ("driver
core: bus: bus iterator cleanups") in driver-core-next.

I have bisected an early kernel crash on the Renesas Salvator-XS
board to this commit:

    Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000028
    ...
    Call trace:
     __lock_acquire+0x530/0x20f0
     lock_acquire.part.0+0xc8/0x210
     lock_acquire+0x64/0x80
     _raw_spin_lock+0x4c/0x60
     bus_to_subsys+0x24/0xac
     bus_for_each_dev+0x30/0xcc
     soc_device_match+0x4c/0xe0
     r8a7795_sysc_init+0x18/0x60
     rcar_sysc_pd_init+0xb0/0x33c
     do_one_initcall+0x128/0x2bc

> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -355,18 +355,20 @@ static struct device *next_device(struct klist_iter *i)
>  int bus_for_each_dev(const struct bus_type *bus, struct device *start,
>                      void *data, int (*fn)(struct device *, void *))
>  {
> +       struct subsys_private *sp = bus_to_subsys(bus);

If bus_to_subsys() is called from an early_initcall(), bus_kset is
still NULL, causing a crash.

>         struct klist_iter i;
>         struct device *dev;
>         int error = 0;
>
> -       if (!bus || !bus->p)

Before, the !bus->sp check prevented the crash...

> +       if (!sp)
>                 return -EINVAL;

... and instructed soc_device_match() to go into
early_soc_dev_attr mode.

I have sent a fix
"[PATCH] driver core: bus: Handle early calls to bus_to_subsys()"
https://lore.kernel.org/r/0a92979f6e790737544638e8a4c19b0564e660a2.1676983596.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
