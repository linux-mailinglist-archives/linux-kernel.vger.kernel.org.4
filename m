Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EB868163D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjA3QYO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Jan 2023 11:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjA3QYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:24:11 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E093A853;
        Mon, 30 Jan 2023 08:24:10 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id e8so10547105qts.1;
        Mon, 30 Jan 2023 08:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTSPMIlZAe730mTLIHGZJqCvmbGIHUoU+DViCsATefM=;
        b=4y2VBJlFA6onx4P9VMpsZyxCJrwSHlyF/9yj4JVfjmzQnmSRTMXGvwFAPk4mo/Dz5n
         SKXFDNB+Pqw6Ryosbx/AGAbFlsSRdoTjfr+tFB17HICz4Tx4SrpC2dAyssoAfC0D8I34
         gByH1+Jf2ws1tzQ9Rye7LELKwQHkjoDKKnAPrswInGvVvPvD4tBpbR5/pcn99hVBukGZ
         ku9ypKc89iZfF0WHj97XV3rOX7mys9KJ5HNi3ase7B5Wydf08Y7ncEDCzijsCMs5X06U
         Iqo9hrSITu0a5ikpxB+o/7Sd4r0VXrsGROeSFvoqtAcd99nX6oDrsqCuQU6bFgq/xpqi
         CgyA==
X-Gm-Message-State: AO0yUKXD7+T5hep6Am7t2t3HBoipj2LXeHJ8/G20MRlmah7a4BcMKhbM
        rGzKbRL9z5J5g/whewwxEzx8EiTmWTMy2A==
X-Google-Smtp-Source: AK7set9HsotzwRrhC8JOXW/xsBDCAshJ24jkakHL5qmaDXYZkSHtkzAsc29W7SXVWq88PaDh+rUXlQ==
X-Received: by 2002:a05:622a:1042:b0:3b8:461c:12ed with SMTP id f2-20020a05622a104200b003b8461c12edmr13554804qte.8.1675095849762;
        Mon, 30 Jan 2023 08:24:09 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id q26-20020a05620a025a00b0071de2b6d439sm3070481qkn.49.2023.01.30.08.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 08:24:09 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-50aa54cc7c0so139033647b3.8;
        Mon, 30 Jan 2023 08:24:09 -0800 (PST)
X-Received: by 2002:a81:5204:0:b0:507:86ae:c733 with SMTP id
 g4-20020a815204000000b0050786aec733mr2915037ywb.358.1675095849069; Mon, 30
 Jan 2023 08:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20230130152818.03c00ea3@canb.auug.org.au> <Y9fpvZCPlqTSvu1O@kroah.com>
In-Reply-To: <Y9fpvZCPlqTSvu1O@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jan 2023 17:23:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWOtVZKyn_k-ojXZDbSZ8Y-dSxHBhftCzTYQfWnQH564Q@mail.gmail.com>
Message-ID: <CAMuHMdWOtVZKyn_k-ojXZDbSZ8Y-dSxHBhftCzTYQfWnQH564Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the driver-core tree
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jan 30, 2023 at 5:08 PM Greg KH <greg@kroah.com> wrote:
> On Mon, Jan 30, 2023 at 03:28:18PM +1100, Stephen Rothwell wrote:
> > After merging the driver-core tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >
> > arch/powerpc/platforms/ps3/system-bus.c:472:19: error: initialization of 'int (*)(const struct device *, struct kobj_uevent_env *)' from incompatible pointer type 'int (*)(struct device *, struct kobj_uevent_env *)' [-Werror=incompatible-pointer-types]
> >   472 |         .uevent = ps3_system_bus_uevent,
> >       |                   ^~~~~~~~~~~~~~~~~~~~~
> > arch/powerpc/platforms/ps3/system-bus.c:472:19: note: (near initialization for 'ps3_system_bus_type.uevent')
> > arch/powerpc/platforms/pseries/ibmebus.c:436:22: error: initialization of 'int (*)(const struct device *, struct kobj_uevent_env *)' from incompatible pointer type 'int (*)(struct device *, struct kobj_uevent_env *)' [-Werror=incompatible-pointer-types]
> >   436 |         .uevent    = ibmebus_bus_modalias,
> >       |                      ^~~~~~~~~~~~~~~~~~~~
> > arch/powerpc/platforms/pseries/ibmebus.c:436:22: note: (near initialization for 'ibmebus_bus_type.uevent')
> >
> > Caused by commit
> >
> >   2a81ada32f0e ("driver core: make struct bus_type.uevent() take a const *")
>
> Ick, 0-day didn't catch this, which is odd, it must not build those
> arches :(

It does, but the bot seems to have some issues, as I didn't receive
any reports for a few days.
Last report of a ps3_defconfig build is 5 days old...

etje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
