Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8869F60F805
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiJ0MvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiJ0MvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:51:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527556112D;
        Thu, 27 Oct 2022 05:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD0B4B82617;
        Thu, 27 Oct 2022 12:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2197BC433B5;
        Thu, 27 Oct 2022 12:51:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="f2fM4ZDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666875062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7IPqLid7IqQX7xaoa0h3UH2jSWB/Ci1zDdeGKf+rIB4=;
        b=f2fM4ZDIKnXv9bRiVzrnlRhFtoKYOKi38u+1Cjf/ikMv1QsfHYOElJmM6dvRgufqXkl07H
        9KKLhchavXNOUhSIrwv/HWESXrTvH5RII6KF7ZQMjOLhPNo1KJeSFs2UyANZjdg5Yg1jjt
        yAbOl8idgbB+CTcIVlmplwVG3rHCdqw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4aff23bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Oct 2022 12:51:01 +0000 (UTC)
Date:   Thu, 27 Oct 2022 14:26:26 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 07/15] MIPS: IP27: clean out sn/nmi.h
Message-ID: <Y1p48oJVBeUSrfC2@zx2c4.com>
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <08c138e14f71c207c4428df9fd31154744be9d98.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08c138e14f71c207c4428df9fd31154744be9d98.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for working on this patchset. The magic-number.rst file has
always kind of bothered me with its outdated encouragements to magic up
every struct.

Technically, this series seems okay. It'd be nice if somebody had some
SGI hardware to figure out what NMI_MAGIC is all about, but that doesn't
need to block removing it from magic-number.rst, so that
magic-number.rst can be put to rest. Interestingly, though,
0x48414d4d455201 is "HAMMER\x01". The only reference to it I could find
on the Internet that wasn't this file itself was some forum on Intel
stuff? https://www.eevblog.com/forum/microcontrollers/intel-bare-metal-programming/msg1273587/#msg1273587
No idea.

Anyway, I suspect the actual issues that remain are mostly formalities,
as others have mentioned:

1) Add a 00/15 cover letter that explains your intentions, and make sure
   the "right people" are CC'd on that. Hard to say who that might be,
   given how diverse this patchset is. Maybe Andrew Morton? Or Kees
   Cook? No idea.

2) Fix up your commit messages:

> The only user is arch/mips/sgi-ip27/ip27-nmi.c;
> this file was imported wholesale in 2.3.99pre9-1,
> and received only whitespace updates since then
> 
> NMI_MAGIC isn't a magic number; it's unclear if it's actually used
> by the firmware in some capacity or if it's a holdover from copying
> the SGI code, but in the former case it's API
> and in the latter it's dead cruft
> 
> Lack of QEMU support makes this unvalidatable without the hardware,
> so leave it in

Add some trailing periods, and reformat this to have the usual
alignment. `gq` in vim will do that for you. So for that message, it
should become:

| The only user is arch/mips/sgi-ip27/ip27-nmi.c; this file was imported
| wholesale in 2.3.99pre9-1, and received only whitespace updates since
| then.
| 
| NMI_MAGIC isn't a magic number; it's unclear if it's actually used by
| the firmware in some capacity or if it's a holdover from copying the
| SGI code, but in the former case it's API and in the latter it's dead
| cruft.
| 
| Lack of QEMU support makes this unvalidatable without the hardware, so
| leave it in.

3) Ensure the "From:" header of your email matches your Signed-off-by:
   trailer.

4) Use "Link: " instead of "Ref: ", and make sure all of your tags are
   *above* your Signed-off-by:, not below.

5) Figure out what your name actually is. If it's fake (as somebody
   earlier suggested), either don't make it fake, or don't get caught
   with it being fake in some obvious way, as the kernel supposedly
   requires real names (George Spelvin notwithstanding). Probably (3) is
   enough to take care of this though.

I realize this is likely annoying administrivia. Sorry. So it goes with
Linux stuff.

Jason
