Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EBC71F2A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjFATIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFATIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:08:10 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049F184;
        Thu,  1 Jun 2023 12:08:03 -0700 (PDT)
Date:   Thu, 01 Jun 2023 19:07:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uplinklabs.net;
        s=protonmail; t=1685646480; x=1685905680;
        bh=lovUSrk93ENXOhw8lq+zt1tvyB45dc+7JHQ1bHcHwCY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=eqBIFUXyFnfkuDCUZzZLc82UrgimdrumUq0evWnuDTVgSEMc6wj7aYVVtxBs9tv4l
         tOETU39au2AkYJEx+aGHwlPBJCMvh8Rx/Gcpw2BnPQz/QFGEOo/Fw2rjmoO81ADhC7
         /1ceHpAHBW6pteof5+L/07v30IfL72OyGTOHgiroFlFTL3Uky9nUQwcJSQ4alQhYie
         0pNFPSrhzX8jW1sE7gPMNBiS+ZscISyEuEE0ZAdglV5Z/BnmVvVTOeWBOvOLz9+oXk
         sCtt0lkY7PQglZZhgVu+S6tBjP68oIGt8P/x4YtI/8QvQj0mZp4qIcspNl3d30jMkK
         RjkZV+mVA7vJw==
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Steven Noonan <steven@uplinklabs.net>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kernel@collabora.com
Subject: Re: Direct rdtsc call side-effect
Message-ID: <L9sTQNWVFoNxz-HmzFoXBX4twp84wuAx5Mf4LcxWw9k0rTAXI32rSl7WEOr7058iN6_Nyf8fLN-Ye3sq5THHjJCKG2vQLlpnVs77kKlLFV4=@uplinklabs.net>
In-Reply-To: <87h6rrdoy0.ffs@tglx>
References: <6719fb05-382c-8ec4-ccda-72798906a54b@collabora.com> <87mt1jeax1.ffs@tglx> <87h6rrdoy0.ffs@tglx>
Feedback-ID: 10620438:user:proton
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------796aa968aad2e57f8079f70824c4c45caea1f91b291b6bed56b8f34038fce5eb"; charset=utf-8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------796aa968aad2e57f8079f70824c4c45caea1f91b291b6bed56b8f34038fce5eb
Content-Type: multipart/mixed;boundary=---------------------17872929c4a151b04539e62bfec4da60

-----------------------17872929c4a151b04539e62bfec4da60
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Thursday, June 1st, 2023 at 11:20 AM, Thomas Gleixner <tglx@linutronix.=
de> wrote:
> Here is an example where it falls flat on its nose.
> =


> One of the early Ryzen laptops had a broken BIOS which came up with
> unsynchronized TSCs. I tried to fix that up, but couldn't get it to sync
> on all CPUs because for some stupid reason the TSC write got
> arbritrarily delayed (assumably by SMI/SMM).

Hah, I remember that. That was actually my laptop. A Lenovo ThinkPad A485 =
with a Ryzen 2700U. I've seen the problem since then occasionally on newer=
 Ryzen laptops (and even desktops). Without the awful "tsc=3Ddirectsync" p=
atch I wrote, which I've been carrying for years now in my own kernel buil=
ds, it just falls back to HPET. It's not pleasant, but at least it's a sta=
ble clock.

> After the vendor fixed the BIOS, I tried again and the problem
> persisted.
> =


> So on such a machine the 'fixup time' mechanism would simply render an
> otherwise perfectly fine TSC unusable for timekeeping.
> =


> We asked both Intel and AMD to add TSC_ADJUST probably 15 years
> ago. Intel added it with some HSW variants (IIRC) and since SKL all CPUs
> have it. I don't know why AMD thought it's not required. That could have
> spared a gazillion of bugzilla entries vs. the early Ryzen machines.
>

Agreed, TSC_ADJUST is the ultimate solution for any of these kinds of issu=
es. But last I heard from AMD, it's still several years out in silicon, an=
d there's plenty of hardware to maintain compatibility with. Ugh.

A software solution would be preferable in the meantime, but I don't know =
what options are left at this point.

The trap-and-emulate via SIGSEGV approach proposed earlier in the thread i=
s unfortunately not likely to be practical, assuming I implemented it prop=
erly.

One issue is how much overhead it has. This is an instruction that normall=
y executes in roughly 50 clock cycles (RDTSC) to 100 clock cycles (RDTSCP)=
 on Zen 3. Based on a proof-of-concept I wrote, the overhead of trapping a=
nd emulating with a signal handler is roughly 100x. On my Zen 3 system, it=
 goes up to around 10000 clock cycles per trapped read of RDTSCP. Most Win=
dows games that use this instruction directly are doing so under the assum=
ption that the TSC is faster to read than any of the native Windows API cl=
ock sources. If it's suddenly ~100x slower than even the slowest-to-read W=
indows clocksource, those games would likely become entirely unplayable, d=
epending on how frequently they do TSC reads. (And many do so quite often!=
)

Also, my proof-of-concept doesn't actually do the emulation part. It just =
traps the instruction and then executes that same instruction in the signa=
l handler, putting the results in the right registers. So it's a pass-thro=
ugh approach, which is about the best you can do performance wise.

Another issue is that the implementation might be tricky. In the case of W=
ine, you'd need to enable PR_TSC_SIGSEGV whenever entering the Windows exe=
cutable and PR_TSC_ENABLE whenever leaving it. If you don't, any of the no=
rmally well-behaved clock sources implemented using the TSC (e.g. CLOCK_MO=
NOTONIC_RAW, etc) would also fault on the Wine side. Also, there's some Wi=
ndows-specific trickery, in that the Windows registry exposes the TSC freq=
uency in a couple of places, so those would need to be replaced with the f=
requency of the emulated clocksource.

- Steven
-----------------------17872929c4a151b04539e62bfec4da60--

--------796aa968aad2e57f8079f70824c4c45caea1f91b291b6bed56b8f34038fce5eb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmR47GEJkAi2TYeeRSZQFiEE707zOy6TKdatSeTPCLZNh55F
JlAAAJDdAQD0c+SXDqA1PASyKgtok2FQ+jAcie8g0u2Rd/Grlp49QwEAzASw
DKrwVDCAWWVHMgksqgsdcchcU5d4UJu9AW2nIAk=
=lfCX
-----END PGP SIGNATURE-----


--------796aa968aad2e57f8079f70824c4c45caea1f91b291b6bed56b8f34038fce5eb--

