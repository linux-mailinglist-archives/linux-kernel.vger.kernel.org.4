Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A1C6C7ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjCXJIl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 05:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjCXJIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:08:36 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33D7BBA7;
        Fri, 24 Mar 2023 02:08:31 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5418d54d77bso21582777b3.12;
        Fri, 24 Mar 2023 02:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679648911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Roc/MzbwWfU/L3JLIUeZiBYVx/CrsAmPFC4IMxSQC4o=;
        b=lZD2aeEDms+Wgole/+nAB8eYjckk7Yq5BQw2dZFiCjYdRS5d25B1/pv3wb8HZIAfmG
         BPw8pSm+inymB/IGmEI+4oWJAV1wn5Q/kvfFITjNrOLKTQ6f8PhAOb4BB9VU3VrFOQZ9
         cM9+da6LxwXKMjaJGf/EFjpng5s4ojb30FNWjZ1ObFLi2MF8rcJDPayhJzVYVRjRli5f
         oWG0f2rVVP1ft2hZgY91fK8W+vFUKIgO1b8jgC03yDs2wKs5pm4OrxWHA9ZkEahkI5QP
         roLbXPrKN9xvA+3bbk9rhan1XE1NHh481vyVT4gY7Ina42m3YefwyTtsFT3fYbV40PIS
         zzAA==
X-Gm-Message-State: AAQBX9cEGxh2x3pPdGE6CIVywTiI8vAVCgNwRGTTzvSv1sqgmJn/9yXK
        4owmz0WYzADGsTjvClVpoDHIHkTUl4DODA==
X-Google-Smtp-Source: AKy350Y3rzqmeTA8BdS1FC18yCgI/opxZUI+C+dbEbtlWHEuZeTQSj46YcaD0GWC8BLM8Qe9ZtlplQ==
X-Received: by 2002:a81:6dc6:0:b0:538:5b3a:f11e with SMTP id i189-20020a816dc6000000b005385b3af11emr1635273ywc.35.1679648910966;
        Fri, 24 Mar 2023 02:08:30 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 7-20020a810707000000b00545a0818492sm313317ywh.34.2023.03.24.02.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 02:08:29 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id b18so1358939ybp.1;
        Fri, 24 Mar 2023 02:08:29 -0700 (PDT)
X-Received: by 2002:a25:688a:0:b0:b46:c5aa:86ef with SMTP id
 d132-20020a25688a000000b00b46c5aa86efmr731865ybc.12.1679648909365; Fri, 24
 Mar 2023 02:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230302211759.30135-1-nick.alcock@oracle.com>
 <20230302211759.30135-11-nick.alcock@oracle.com> <ZAoGLhRpTr5f7AD/@kroah.com>
 <ZApf0iNOsSAUbhMz@bombadil.infradead.org> <ZArc0ib697JIwKou@kroah.com> <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
In-Reply-To: <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Mar 2023 10:08:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
Message-ID: <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 8:42 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Fri, Mar 10, 2023 at 08:31:30AM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Mar 09, 2023 at 02:38:10PM -0800, Luis Chamberlain wrote:
> > > On Thu, Mar 09, 2023 at 05:15:42PM +0100, Greg Kroah-Hartman wrote:
> > > > On Thu, Mar 02, 2023 at 09:17:52PM +0000, Nick Alcock wrote:
> > > > > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> > > > > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> > > > > are used to identify modules. As a consequence, uses of the macro
> > > > > in non-modules will cause modprobe to misidentify their containing
> > > > > object file as a module when it is not (false positives), and modprobe
> > > > > might succeed rather than failing with a suitable error message.
> > > > >
> > > > > So remove it in the files in this commit, none of which can be built as
> > > > > modules.
> > > > >
> > > > > Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> > > > > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > > > Cc: linux-modules@vger.kernel.org
> > > > > Cc: linux-kernel@vger.kernel.org
> > > > > Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > > > ---
> > > > >  drivers/tty/n_null.c | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
> > > > > index f913b665af725..c24f75942c49d 100644
> > > > > --- a/drivers/tty/n_null.c
> > > > > +++ b/drivers/tty/n_null.c
> > > > > @@ -63,7 +63,6 @@ static void __exit n_null_exit(void)
> > > > >  module_init(n_null_init);
> > > > >  module_exit(n_null_exit);
> > > > >
> > > > > -MODULE_LICENSE("GPL");
> > > > >  MODULE_AUTHOR("Alan Cox");
> > > > >  MODULE_ALIAS_LDISC(N_NULL);
> > > > >  MODULE_DESCRIPTION("Null ldisc driver");
> > > > > --
> > > > > 2.39.1.268.g9de2f9a303
> > > > >
> > > >
> > > > Nope, sorry, this is not good to do, please fix kbuild instead of
> > > > forcing a tree-wide change like this.
> > >
> > > Masahiro Yamada already NACK'd it such effort:
> > >
> > > https://lkml.kernel.org/r/CAK7LNAQLttPD=Ae==e0CYeQtS78=o_JZFK+zxa29JnUYio52Ug@mail.gmail.com
> > >
> > > And his descriptiuon of the reasoning and logic is explained here:
> > >
> > > https://lore.kernel.org/all/CAK7LNASL7_RgfASstBvN6AzhR=nMU=HsQvODf5q13Xud8tBWRQ@mail.gmail.com/
> > >
> > > Let me summarize it though with a few quotes from him:
> > >
> > > "Having false-positives in modules.builtin should be OK"
> > > "In this sense, having always-builtin entries in module.builtin is OK."
> >
> > None of that matters, sorry.
> >
> > Again, all I am saying is that you can not have some MODULE_() macros
> > that are ok for code that is built in, and some that are not, for
> > "reasons" that have to do how you all are treating the build system
> > infrastructure as you are now putting arbritrary requirements for all
> > driver authors (of which there are thousands) to know this.
>
> As noted once again, it is not putting hard requirement. Future tooling
> not yet added would just not benefit from distinguishing symbols for
> your modules.
>
> I'm happy to live with module authors not wanting to remove the module
> license tag from their modules if they can never actually be modules
> from not benefitting from the above tooling gains as its just cherry
> on top tooling gains.

Apparently lots of these patches have not arrived in linux-next
without Acks (we're still discussing about this, right???).

And some of the modified files have no SPDX-License-Identifier
lines yet, so we are losing important licensing information:

$ git grep -L SPDX-License-Identifier -- $(git show $(git log
--oneline v6.3-rc1..linux-next/master | grep "remove MODULE_LICENSE in
non-modules" | cut -d " " -f 1) | lsdiff --strip=1)
drivers/bus/arm-cci.c
drivers/bus/imx-weim.c
drivers/bus/simple-pm-bus.c
drivers/gpu/drm/drm_mipi_dsi.c
drivers/irqchip/irq-mvebu-pic.c
drivers/reset/reset-axs10x.c
drivers/reset/reset-hsdk.c
drivers/soc/sunxi/sunxi_sram.c
drivers/video/fbdev/asiliantfb.c
drivers/video/fbdev/gbefb.c
drivers/video/fbdev/imsttfb.c
drivers/xen/xenbus/xenbus_probe.c
lib/glob.c

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
