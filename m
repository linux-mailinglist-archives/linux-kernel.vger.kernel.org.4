Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884C45F229C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 12:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJBKdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 06:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJBKdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 06:33:46 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC623FEC7;
        Sun,  2 Oct 2022 03:33:30 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 890431C0016; Sun,  2 Oct 2022 12:33:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1664706809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sL//6B25nNw0Y4iq69YQZ+ORINfToWI2jMeD5zLOJ6Y=;
        b=Wcoxvgrb9ADpe5BdcRrI1rChvOFEJAl1KxvnFblPpbRqRbLdivige8kxRdj+rjUmn/jjjU
        PF+i1AiH3zo0DRkwF3sG3YJ2ZJuFeWRsjeuShZOy2g/wC9uwecGwnji+AV9TaJtBVsWmFM
        5SKTJdQJzsz37EDeU86hrFin/sIYfAU=
Date:   Sun, 2 Oct 2022 12:33:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        keescook@chromium.org, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2] x86/mm: Refuse W^X violations
Message-ID: <20221002095516.GA10085@duo.ucw.cz>
References: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
 <20220921200726.GA3094503@roeck-us.net>
 <4dd594ad-490a-68ee-9e32-fbd9f135bd54@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <4dd594ad-490a-68ee-9e32-fbd9f135bd54@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2022-09-21 13:59:06, Dave Hansen wrote:
> On 9/21/22 13:07, Guenter Roeck wrote:
> > [    2.042861] CPA refuse W^X violation: 8000000000000063 -> 0000000000=
000063 range: 0x00000000c00a0000 - 0x00000000c00a0fff PFN a0
> > ILLOPC: cbc65efa: 0f 0b
> > [    2.043267] WARNING: CPU: 0 PID: 1 at arch/x86/mm/pat/set_memory.c:6=
00 __change_page_attr_set_clr+0xdca/0xdd0
> ...
> > [    2.050307] ---[ end trace 0000000000000000 ]---
> > [    2.050762] PCI: PCI BIOS area is rw and x. Use pci=3Dnobios if you =
want it NX.
> > [    2.051115] kernel tried to execute NX-protected page - exploit atte=
mpt? (uid: 0)
> > [    2.051115] BUG: unable to handle page fault for address: c00fd2bf
>=20
> This _looks_ like it is working as intended.  The PCI BIOS code tried to
> make a RWX page.  The CPA code refused to do it and presumably returned
> an error, leaving a RW page, non-executable page.  The PCI code didn't
> check the set_memory_x() return code and tried to go execute anyway.
> That resulted in the oops.
>=20
> I was able to reproduce this pretty easily.  The workaround from dmesg
> is pci=3Dnobios.  That seems to do the trick for me, although that advise
> was sandwiched between a warning and an oops, so not the easiest to find.
>=20
> I'm a bit torn what to do on this one.  Breaking the boot is bad, but so
> is leaving RWX memory around.

Well, the original patch is bad. Boot regressions are not acceptable.

We should first add an WARN_ON(), debug and fix the failures, then we
can start refusing the transitions.

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYzlo6QAKCRAw5/Bqldv6
8vZ3AJ9nEa1qzDyVCUdWg8V5OCDTqCwgrwCggLKJ7UAySYFOkZwYuUunmIYkL8k=
=hn0t
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
