Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B8564FF30
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 15:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiLROzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 09:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLROzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 09:55:36 -0500
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD7DB1FD
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 06:55:35 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id F224F20172;
        Sun, 18 Dec 2022 15:55:32 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GwRZMTk7MbeD; Sun, 18 Dec 2022 15:55:32 +0100 (CET)
Received: from begin.home (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id C47C920170;
        Sun, 18 Dec 2022 15:55:32 +0100 (CET)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1p6v4e-00C6C4-1G;
        Sun, 18 Dec 2022 15:55:32 +0100
Date:   Sun, 18 Dec 2022 15:55:32 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbd] [patchv2 3/3] VT: Bump font size limitation to 64x128
 pixels
Message-ID: <20221218145532.syqzu76q23rz4tx6@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Alexey Gladkov <legion@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
References: <20221218003209.503539532@ens-lyon.org>
 <20221218003237.503424466@ens-lyon.org>
 <Y58mKmE9Km+NujDa@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y58mKmE9Km+NujDa@example.org>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Alexey Gladkov, le dim. 18 déc. 2022 15:39:38 +0100, a ecrit:
> On Sun, Dec 18, 2022 at 01:32:12AM +0100, Samuel Thibault wrote:
> > This moves 32x32 font size limitation checking down to drivers, so that
> > fbcon can allow large fonts.
> > 
> > We still keep a limitation to 64x128 pixels so as to have a simple bounded
> > allocation for con_font_get and in the userland kbd tool. That glyph size
> > will however be enough to have 128x36 characters on a "16/9 8K display".
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > 
> > ---
> > V1 -> V2: Switch con_font_get to kvmalloc/kvfree instead of kmalloc/kfree
> > 
> > Index: linux-6.0/drivers/tty/vt/vt.c
> > ===================================================================
> > --- linux-6.0.orig/drivers/tty/vt/vt.c
> > +++ linux-6.0/drivers/tty/vt/vt.c
> > @@ -4575,17 +4575,20 @@ void reset_palette(struct vc_data *vc)
> >  /*
> >   *  Font switching
> >   *
> > - *  Currently we only support fonts up to 32 pixels wide, at a maximum height
> > - *  of 32 pixels. Userspace fontdata is stored with 32 bytes (shorts/ints, 
> > - *  depending on width) reserved for each character which is kinda wasty, but 
> > - *  this is done in order to maintain compatibility with the EGA/VGA fonts. It 
> > - *  is up to the actual low-level console-driver convert data into its favorite
> > - *  format (maybe we should add a `fontoffset' field to the `display'
> > - *  structure so we won't have to convert the fontdata all the time.
> > + *  Currently we only support fonts up to 128 pixels wide, at a maximum height
> > + *  of 128 pixels. Userspace fontdata may have to be stored with 32 bytes
> > + *  (shorts/ints, depending on width) reserved for each character which is
> > + *  kinda wasty, but this is done in order to maintain compatibility with the
> > + *  EGA/VGA fonts. It is up to the actual low-level console-driver convert data
> > + *  into its favorite format (maybe we should add a `fontoffset' field to the
> > + *  `display' structure so we won't have to convert the fontdata all the time.
> >   *  /Jes
> >   */
> >  
> > -#define max_font_size 65536
> > +#define max_font_width	64
> > +#define max_font_height	128
> > +#define max_font_glyphs	512
> > +#define max_font_size	(max_font_glyphs*max_font_width*max_font_height)
> 
> As a suggestion that you can safely ignore. Maybe make max_font_glyphs a
> sysctl parameter to be able to use larger fonts ?
> 
> I get requests from time to time in kbd that it is not possible to load a
> larger font.

64KiB was really low, while the theoretically possible max was
32*32*512 = 512KB, so I understand there used to be such requests :)

Here, by setting the max to 64x128*512, I don't think we'll need more.
Even with a 8K screen (will such really exist and want a text console?)
the max 64x128 gets 128 characters on a single line, for soemthing like
36 lines. So I guess it's not worth adding yet another sysctl :)

Samuel
