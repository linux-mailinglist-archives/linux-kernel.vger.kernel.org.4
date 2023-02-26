Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CCB6A2F06
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 10:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBZJp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 04:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBZJp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 04:45:58 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804541352D;
        Sun, 26 Feb 2023 01:45:56 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id h19so3822194qtk.7;
        Sun, 26 Feb 2023 01:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDxhZAFqdoRCuyb8oRhrVi/sFN15zqpxYYgqeqQ31+A=;
        b=EFS29tu6qJAvSqtD7DEXa56teJh1gLs3/nKOc+Bci6Tv6izKI5qN/dZVh/PNznX3j3
         qmwnjhwC0CV8K5SyFWaN/5+ApehSoD7XnljE0gSDxhyh8wRC7gKEBJhhekH0b2uS6X8j
         UFrFXLifPR8UzRuh2jwr+icoveA/EHec6favMkcEnG/zQYmLlfBQoTCyd+hp0UwQzluy
         A2uuEE4ckH/DnxP7YxWbkWn3UhQ5EC725Rv8RorMbKeNWCRJ/fbdHBxXdRFi0ap4+NPt
         SJZTjxASctDsjgZOJa2eeJAnOGP5A2mTURFbdYm/RTBkSsQwORO3XUYbJmgjyAWfAK6S
         CuJQ==
X-Gm-Message-State: AO0yUKVT/2CkNRUYAO2x2juuoJ8cnBpS4O7leHuLEBedlgljqZzsxVhb
        mKXWJljykoy352XSGvbC319YtRhNoHI0tA==
X-Google-Smtp-Source: AK7set/FCeMksqTqFg2svfYGUVNl26KNGtKHN/eNL/1NcSe4U9Wwff4zy19/doD0ZTQuKQcf7oTgUg==
X-Received: by 2002:a05:622a:552:b0:3bf:c83d:5d4c with SMTP id m18-20020a05622a055200b003bfc83d5d4cmr6819811qtx.64.1677404755057;
        Sun, 26 Feb 2023 01:45:55 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id z22-20020ac87f96000000b003b63dfad2b4sm2799983qtj.0.2023.02.26.01.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 01:45:54 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-536c02eea4dso99547877b3.4;
        Sun, 26 Feb 2023 01:45:54 -0800 (PST)
X-Received: by 2002:a5b:d46:0:b0:a67:c976:c910 with SMTP id
 f6-20020a5b0d46000000b00a67c976c910mr1348469ybr.7.1677404754091; Sun, 26 Feb
 2023 01:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20230225121523.3288544-1-geert+renesas@glider.be>
 <20230225203052.0fd823a1ccf0619e89b315d8@linux-foundation.org> <20230225205749.2effb5f902dee8919704f3cd@linux-foundation.org>
In-Reply-To: <20230225205749.2effb5f902dee8919704f3cd@linux-foundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 26 Feb 2023 10:45:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXuP2f78t4ykRP37xNGSOZxEizd3ZvqOyedbLaHhfE1iw@mail.gmail.com>
Message-ID: <CAMuHMdXuP2f78t4ykRP37xNGSOZxEizd3ZvqOyedbLaHhfE1iw@mail.gmail.com>
Subject: Re: [PATCH] zram: Use atomic_long_read() to read atomic_long_t
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sun, Feb 26, 2023 at 5:57 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Sat, 25 Feb 2023 20:30:52 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> > > Fix this by using atomic_long_read() instead.
> > >
> > > Reported-by; noreply@ellerman.id.au
> >
> > That's an interesting one.  Was this mpe@?

No, from the kisskb build bot, which sends private emails to the
architecture maintainers when one of their builds fail:

----8<-------------------------------------------------------------------------------------------
Subject: kisskb: FAILED linux-next/m68k-defconfig/m68k-gcc8 Sat Feb 25, 14:34
From: noreply@ellerman.id.au
To: geert@linux-m68k.org
Date: Sat, 25 Feb 2023 03:35:59 -0000
Message-ID: <20230225033559.1.93322@37da20578230>

FAILED linux-next/m68k-defconfig/m68k-gcc8 Sat Feb 25, 14:34

http://kisskb.ellerman.id.au/kisskb/buildresult/14885627/

Commit:   Add linux-next specific files for 20230225
          8232539f864ca60474e38eb42d451f5c26415856
Compiler: m68k-linux-gcc (GCC) 8.5.0 / GNU ld (GNU Binutils) 2.36.1

Possible errors
---------------

drivers/block/zram/zram_drv.c:1234:23: error: passing argument 1 of
'atomic64_read' from incompatible pointer type
[-Werror=incompatible-pointer-types]
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:252: drivers/block/zram/zram_drv.o] Error 1
make[4]: *** [scripts/Makefile.build:494: drivers/block/zram] Error 2
make[3]: *** [scripts/Makefile.build:494: drivers/block] Error 2
make[2]: *** [scripts/Makefile.build:494: drivers] Error 2
make[1]: *** [Makefile:2028: .] Error 2
make: *** [Makefile:226: __sub-make] Error 2

Possible warnings (1)
----------------------

include/linux/list.h:74:12: warning: 'seed_devices' may be used
uninitialized in this function [-Wmaybe-uninitialized]
------------------------------------------------------------------------------------------>8-----

> > I like it when a Reported-by: is followed by a Link: to the report, so
> > I can go hunt down such things.
>
> I found this, and added it to the changelog:
>
> Reported-by: kernel test robot <lkp@intel.com>
>   Link: https://lore.kernel.org/oe-kbuild-all/202302241840.nwdXqE5r-lkp@intel.com/

That's a different bot ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
