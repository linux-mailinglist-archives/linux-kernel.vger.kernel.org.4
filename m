Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E02639E70
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 01:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiK1ATv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 19:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1ATr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 19:19:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391DC6141;
        Sun, 27 Nov 2022 16:19:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D20A9B80B1A;
        Mon, 28 Nov 2022 00:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F08C43470;
        Mon, 28 Nov 2022 00:19:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GjPO03ju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669594781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGDNWDlrjoKkV18bX013f+9WmWZM0g+YAx70BBOO/2Q=;
        b=GjPO03juWqjidb6zzZMkl2qkH2uWs0O0x5Pxs3nWv0KJ+2r8iTUvJVFIBhmnACPzUtSIp/
        6/TTNYlJ0z7LKrrL7Jmhy1qQRy6fbyZPCOqySSAcAOn7g+G4XSRK689oPPz3kP++anYvyq
        37HBzL4b4azCFC4Tdx9+TyNM4pjx6MM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d135daf3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Nov 2022 00:19:40 +0000 (UTC)
Date:   Mon, 28 Nov 2022 01:19:36 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Samuel Neves <sneves@dei.uc.pt>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 3/3] x86: vdso: Wire up getrandom() vDSO implementation
Message-ID: <Y4P+mOFu2A9tj5/y@zx2c4.com>
References: <20221124165536.1631325-1-Jason@zx2c4.com>
 <20221124165536.1631325-4-Jason@zx2c4.com>
 <874jumy6me.ffs@tglx>
 <Y4PfjcQRfezjH4f+@zx2c4.com>
 <CAEX_ruEq8_W8i-+cfri2-BYBNDgZCinsfFKVeFjxNSfnGxW1xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEX_ruEq8_W8i-+cfri2-BYBNDgZCinsfFKVeFjxNSfnGxW1xg@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 10:39:27PM +0000, Samuel Neves wrote:
> On Sun, Nov 27, 2022 at 10:13 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Thomas,
> >
> > On Sat, Nov 26, 2022 at 12:08:41AM +0100, Thomas Gleixner wrote:
> > > Jason!
> > >
> > > On Thu, Nov 24 2022 at 17:55, Jason A. Donenfeld wrote:
> > > > +++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
> > > > +/*
> > > > + * Very basic SSE2 implementation of ChaCha20. Produces a given positive number
> > > > + * of blocks of output with a nonce of 0, taking an input key and 8-byte
> > > > + * counter. Importantly does not spill to the stack. Its arguments are:
> > >
> > > Basic or not.
> >
> > Heh, FYI I didn't mean "basic" here as in "doesn't need a review", but
> > just that it's a straightforward technique and doesn't do any
> > complicated multiblock pyrotechnics (which frankly aren't really
> > needed).
> >
> > > This needs a Reviewed-by from someone who understands SSE2
> > > and ChaCha20 before this can go anywhere near the x86 tree.
> >
> > No problem. I'll see to it that somebody qualified gives this a review.
> >
> 
> I did look at this earlier. It looks fine. I would recommend changing
> 
> + /* copy1,copy2 = key */
> + movdqu 0x00(key),copy1
> + movdqu 0x10(key),copy2
> 
> to
> 
> + /* copy1,copy2 = key */
> + movups 0x00(key),copy1
> + movups 0x10(key),copy2
> 
> which has the same semantics, but saves a couple of code bytes. Likewise for
> 
> + movdqu state0,0x00(output)
> + movdqu state1,0x10(output)
> + movdqu state2,0x20(output)
> + movdqu state3,0x30(output)
> 
> Otherwise,
> 
> Reviewed-by: Samuel Neves <sneves@dei.uc.pt> # for vgetrandom-chacha.S

Thanks for the review and for the suggestion. Will do.

Jason
