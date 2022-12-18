Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED4B64FF44
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 16:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiLRPZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 10:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLRPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 10:25:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0136340
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 07:25:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFF81B80B4A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 15:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD11C433EF;
        Sun, 18 Dec 2022 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671377106;
        bh=4gvNIrOrPZYaRJcxWZB41Xg2/07b3wQFAjpScUE+VSg=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Cd9gOFEjoI197rXSdbsuYdtlOyVdXPZC/5da4a8vCoo+evJ7YwVpcMR/Is+7580TG
         61JkojsJRhWeqoKlUcDBo8r+njVzIcFC5CLwm/9F/wx14ZHq8YiX/2c3HBgrQSXpWb
         uI8cGQgEskaYBCvWC9J5K4k6Z2b1l0Mc1vmeb5PvejRpRpoTvlDeB5e0+wIri/csB6
         S7nSUWR2Lf6tGUUptf5A3s+F5/mJAVBbd+C15aD+18J7pGg5OgXRqytxVhCWkJFnGc
         95wBLE8JDCtemapsmuKv6IUmibhvukfXftnCkLcT68bjpOq/9ekmw8XRlF2QsN8rZg
         6auNqNfTHMf/g==
Date:   Sun, 18 Dec 2022 16:25:01 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbd] [patchv2 3/3] VT: Bump font size limitation to 64x128
 pixels
Message-ID: <Y58wzU081UB1IsxB@example.org>
References: <20221218003209.503539532@ens-lyon.org>
 <20221218003237.503424466@ens-lyon.org>
 <Y58mKmE9Km+NujDa@example.org>
 <20221218145532.syqzu76q23rz4tx6@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221218145532.syqzu76q23rz4tx6@begin>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 03:55:32PM +0100, Samuel Thibault wrote:
> Hello,
> 
> Alexey Gladkov, le dim. 18 déc. 2022 15:39:38 +0100, a ecrit:
> > On Sun, Dec 18, 2022 at 01:32:12AM +0100, Samuel Thibault wrote:
> > > This moves 32x32 font size limitation checking down to drivers, so that
> > > fbcon can allow large fonts.
> > > 
> > > We still keep a limitation to 64x128 pixels so as to have a simple bounded
> > > allocation for con_font_get and in the userland kbd tool. That glyph size
> > > will however be enough to have 128x36 characters on a "16/9 8K display".
> > > 
> > > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > > 
> > > ---
> > > V1 -> V2: Switch con_font_get to kvmalloc/kvfree instead of kmalloc/kfree
> > > 
> > > Index: linux-6.0/drivers/tty/vt/vt.c
> > > ===================================================================
> > > --- linux-6.0.orig/drivers/tty/vt/vt.c
> > > +++ linux-6.0/drivers/tty/vt/vt.c
> > > @@ -4575,17 +4575,20 @@ void reset_palette(struct vc_data *vc)
> > >  /*
> > >   *  Font switching
> > >   *
> > > - *  Currently we only support fonts up to 32 pixels wide, at a maximum height
> > > - *  of 32 pixels. Userspace fontdata is stored with 32 bytes (shorts/ints, 
> > > - *  depending on width) reserved for each character which is kinda wasty, but 
> > > - *  this is done in order to maintain compatibility with the EGA/VGA fonts. It 
> > > - *  is up to the actual low-level console-driver convert data into its favorite
> > > - *  format (maybe we should add a `fontoffset' field to the `display'
> > > - *  structure so we won't have to convert the fontdata all the time.
> > > + *  Currently we only support fonts up to 128 pixels wide, at a maximum height
> > > + *  of 128 pixels. Userspace fontdata may have to be stored with 32 bytes
> > > + *  (shorts/ints, depending on width) reserved for each character which is
> > > + *  kinda wasty, but this is done in order to maintain compatibility with the
> > > + *  EGA/VGA fonts. It is up to the actual low-level console-driver convert data
> > > + *  into its favorite format (maybe we should add a `fontoffset' field to the
> > > + *  `display' structure so we won't have to convert the fontdata all the time.
> > >   *  /Jes
> > >   */
> > >  
> > > -#define max_font_size 65536
> > > +#define max_font_width	64
> > > +#define max_font_height	128
> > > +#define max_font_glyphs	512
> > > +#define max_font_size	(max_font_glyphs*max_font_width*max_font_height)
> > 
> > As a suggestion that you can safely ignore. Maybe make max_font_glyphs a
> > sysctl parameter to be able to use larger fonts ?
> > 
> > I get requests from time to time in kbd that it is not possible to load a
> > larger font.
> 
> 64KiB was really low, while the theoretically possible max was
> 32*32*512 = 512KB, so I understand there used to be such requests :)
> 
> Here, by setting the max to 64x128*512, I don't think we'll need more.

I was not talking about the size of one glyph, but about the number of
glyphs in the font. Right now the font cannot have more than 512 glyphs.

> Even with a 8K screen (will such really exist and want a text console?)
> the max 64x128 gets 128 characters on a single line, for soemthing like
> 36 lines. So I guess it's not worth adding yet another sysctl :)

Ok.

> Samuel
> 

-- 
Rgrds, legion

