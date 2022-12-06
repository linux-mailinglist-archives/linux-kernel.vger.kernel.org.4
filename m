Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730A6644D75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 21:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiLFUr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 15:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiLFUrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 15:47:52 -0500
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB2417E3F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 12:47:50 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 7F6A320107;
        Tue,  6 Dec 2022 21:47:49 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WX83d12NAk93; Tue,  6 Dec 2022 21:47:49 +0100 (CET)
Received: from begin (unknown [46.231.241.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 5B44120101;
        Tue,  6 Dec 2022 21:47:49 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1p2eqy-009HsG-1g;
        Tue, 06 Dec 2022 21:47:48 +0100
Date:   Tue, 6 Dec 2022 21:47:48 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbd@lists.altlinux.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/3] VT: Bump font size limitation to 64x128 pixels
Message-ID: <20221206204748.jvwr4jgtukkutrmb@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbd@lists.altlinux.org, linux-kernel@vger.kernel.org
References: <20221205000739.583233140@ens-lyon.org>
 <20221205000807.896278194@ens-lyon.org>
 <45c09e48-9e69-2371-70d2-8a0b1e9f4899@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45c09e48-9e69-2371-70d2-8a0b1e9f4899@kernel.org>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby, le mar. 06 déc. 2022 07:48:37 +0100, a ecrit:
> On 05. 12. 22, 1:07, Samuel Thibault wrote:
> > This moves 32x32 font size limitation checking down to drivers, so that
> > fbcon can allow large fonts.
> > 
> > We still keep a limitation to 64x128 pixels so as to have a simple bounded
> > allocation for con_font_get and in the userland kbd tool. That glyph size
> > will however be enough to have 128x36 characters on a "16/9 8K display".
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > 
> > Index: linux-6.0/drivers/tty/vt/vt.c
> > ===================================================================
> > --- linux-6.0.orig/drivers/tty/vt/vt.c
> > +++ linux-6.0/drivers/tty/vt/vt.c
> > @@ -4575,17 +4575,20 @@ void reset_palette(struct vc_data *vc)
> ...
> > -#define max_font_size 65536
> > +#define max_font_width	64
> > +#define max_font_height	128
> > +#define max_font_glyphs	512
> > +#define max_font_size	(max_font_glyphs*max_font_width*max_font_height)
> 
> So this is 64K -> 4M switch. We should likely convert to kvmalloc() too.

Oh, indeed, I'll fix that as well.

Thanks,
Samuel
