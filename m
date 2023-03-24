Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD356C7AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjCXJO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCXJOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:14:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA834212A5;
        Fri, 24 Mar 2023 02:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53781B82316;
        Fri, 24 Mar 2023 09:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDCEC433D2;
        Fri, 24 Mar 2023 09:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679649258;
        bh=WCARbpiOxTXO6BSITyeU7LBK8Ia30GL8OgERpWRb294=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1wYyxBmFwqHj5JKS5mx9C0QS/hQJBQcg2Zj202xg9u5gVb1A03KlPH3WC7i1QgXX
         Lrh2aQNsrNmFwYyiHuBO/ARcN7/9nKjGjBVBpgJSvxZqrVoihuM4SCYhyxQpNv3qvy
         /R2KCJrnps5ZkSX5GabmhkzHE9z1eexBu1ugM3gw=
Date:   Fri, 24 Mar 2023 10:14:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
Message-ID: <ZB1p5zRp7rlGGuCP@kroah.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
 <20230302211759.30135-11-nick.alcock@oracle.com>
 <ZAoGLhRpTr5f7AD/@kroah.com>
 <ZApf0iNOsSAUbhMz@bombadil.infradead.org>
 <ZArc0ib697JIwKou@kroah.com>
 <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
 <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:08:17AM +0100, Geert Uytterhoeven wrote:
> On Fri, Mar 10, 2023 at 8:42 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > On Fri, Mar 10, 2023 at 08:31:30AM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Mar 09, 2023 at 02:38:10PM -0800, Luis Chamberlain wrote:
> > > > On Thu, Mar 09, 2023 at 05:15:42PM +0100, Greg Kroah-Hartman wrote:
> > > > > On Thu, Mar 02, 2023 at 09:17:52PM +0000, Nick Alcock wrote:
> > > > > > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> > > > > > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> > > > > > are used to identify modules. As a consequence, uses of the macro
> > > > > > in non-modules will cause modprobe to misidentify their containing
> > > > > > object file as a module when it is not (false positives), and modprobe
> > > > > > might succeed rather than failing with a suitable error message.
> > > > > >
> > > > > > So remove it in the files in this commit, none of which can be built as
> > > > > > modules.
> > > > > >
> > > > > > Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> > > > > > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > > > > Cc: linux-modules@vger.kernel.org
> > > > > > Cc: linux-kernel@vger.kernel.org
> > > > > > Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > > > > ---
> > > > > >  drivers/tty/n_null.c | 1 -
> > > > > >  1 file changed, 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
> > > > > > index f913b665af725..c24f75942c49d 100644
> > > > > > --- a/drivers/tty/n_null.c
> > > > > > +++ b/drivers/tty/n_null.c
> > > > > > @@ -63,7 +63,6 @@ static void __exit n_null_exit(void)
> > > > > >  module_init(n_null_init);
> > > > > >  module_exit(n_null_exit);
> > > > > >
> > > > > > -MODULE_LICENSE("GPL");
> > > > > >  MODULE_AUTHOR("Alan Cox");
> > > > > >  MODULE_ALIAS_LDISC(N_NULL);
> > > > > >  MODULE_DESCRIPTION("Null ldisc driver");
> > > > > > --
> > > > > > 2.39.1.268.g9de2f9a303
> > > > > >
> > > > >
> > > > > Nope, sorry, this is not good to do, please fix kbuild instead of
> > > > > forcing a tree-wide change like this.
> > > >
> > > > Masahiro Yamada already NACK'd it such effort:
> > > >
> > > > https://lkml.kernel.org/r/CAK7LNAQLttPD=Ae==e0CYeQtS78=o_JZFK+zxa29JnUYio52Ug@mail.gmail.com
> > > >
> > > > And his descriptiuon of the reasoning and logic is explained here:
> > > >
> > > > https://lore.kernel.org/all/CAK7LNASL7_RgfASstBvN6AzhR=nMU=HsQvODf5q13Xud8tBWRQ@mail.gmail.com/
> > > >
> > > > Let me summarize it though with a few quotes from him:
> > > >
> > > > "Having false-positives in modules.builtin should be OK"
> > > > "In this sense, having always-builtin entries in module.builtin is OK."
> > >
> > > None of that matters, sorry.
> > >
> > > Again, all I am saying is that you can not have some MODULE_() macros
> > > that are ok for code that is built in, and some that are not, for
> > > "reasons" that have to do how you all are treating the build system
> > > infrastructure as you are now putting arbritrary requirements for all
> > > driver authors (of which there are thousands) to know this.
> >
> > As noted once again, it is not putting hard requirement. Future tooling
> > not yet added would just not benefit from distinguishing symbols for
> > your modules.
> >
> > I'm happy to live with module authors not wanting to remove the module
> > license tag from their modules if they can never actually be modules
> > from not benefitting from the above tooling gains as its just cherry
> > on top tooling gains.
> 
> Apparently lots of these patches have not arrived in linux-next
> without Acks (we're still discussing about this, right???).
> 
> And some of the modified files have no SPDX-License-Identifier
> lines yet, so we are losing important licensing information:
> 
> $ git grep -L SPDX-License-Identifier -- $(git show $(git log
> --oneline v6.3-rc1..linux-next/master | grep "remove MODULE_LICENSE in
> non-modules" | cut -d " " -f 1) | lsdiff --strip=1)
> drivers/bus/arm-cci.c
> drivers/bus/imx-weim.c
> drivers/bus/simple-pm-bus.c
> drivers/gpu/drm/drm_mipi_dsi.c
> drivers/irqchip/irq-mvebu-pic.c
> drivers/reset/reset-axs10x.c
> drivers/reset/reset-hsdk.c
> drivers/soc/sunxi/sunxi_sram.c
> drivers/video/fbdev/asiliantfb.c
> drivers/video/fbdev/gbefb.c
> drivers/video/fbdev/imsttfb.c
> drivers/xen/xenbus/xenbus_probe.c
> lib/glob.c

Ick, that's not ok at all.

Again, I strongly feel that removing MODULE_LICENSE() lines from files
that just don't happen to be built as a module is not ok as no other
MODULE_*() macro has this arbitrary restriction.

thanks,

greg k-h
