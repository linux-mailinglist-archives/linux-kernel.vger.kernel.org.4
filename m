Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B764FF4B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 16:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiLRP3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 10:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiLRP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 10:29:00 -0500
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B107D5F52
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 07:28:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 83F1820175;
        Sun, 18 Dec 2022 16:28:58 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o1MuEkFArtI1; Sun, 18 Dec 2022 16:28:58 +0100 (CET)
Received: from begin.home (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 645B120107;
        Sun, 18 Dec 2022 16:28:58 +0100 (CET)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1p6vb0-00C7YI-06;
        Sun, 18 Dec 2022 16:28:58 +0100
Date:   Sun, 18 Dec 2022 16:28:57 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbd] [patchv2 3/3] VT: Bump font size limitation to 64x128
 pixels
Message-ID: <20221218152857.qle75c6lhexkdoym@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Alexey Gladkov <legion@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
References: <20221218003209.503539532@ens-lyon.org>
 <20221218003237.503424466@ens-lyon.org>
 <Y58mKmE9Km+NujDa@example.org>
 <20221218145532.syqzu76q23rz4tx6@begin>
 <Y58wzU081UB1IsxB@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y58wzU081UB1IsxB@example.org>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov, le dim. 18 déc. 2022 16:25:01 +0100, a ecrit:
> On Sun, Dec 18, 2022 at 03:55:32PM +0100, Samuel Thibault wrote:
> > Alexey Gladkov, le dim. 18 déc. 2022 15:39:38 +0100, a ecrit:
> > > On Sun, Dec 18, 2022 at 01:32:12AM +0100, Samuel Thibault wrote:
> > > > -#define max_font_size 65536
> > > > +#define max_font_width	64
> > > > +#define max_font_height	128
> > > > +#define max_font_glyphs	512
> > > > +#define max_font_size	(max_font_glyphs*max_font_width*max_font_height)
> > > 
> > > As a suggestion that you can safely ignore. Maybe make max_font_glyphs a
> > > sysctl parameter to be able to use larger fonts ?
> > > 
> > > I get requests from time to time in kbd that it is not possible to load a
> > > larger font.
> > 
> > 64KiB was really low, while the theoretically possible max was
> > 32*32*512 = 512KB, so I understand there used to be such requests :)
> > 
> > Here, by setting the max to 64x128*512, I don't think we'll need more.
> 
> I was not talking about the size of one glyph, but about the number of
> glyphs in the font. Right now the font cannot have more than 512 glyphs.

That one is unfortunately *very* hardcoded in the VT code, since it's
the very representation of the console text in vc_screenbuf which is set
to the VGA-based 16bits per glyph, with a 8+8 or 9+7 separation between
glyph number and color number. Lifting that would be way more involved.

Samuel
