Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A634704453
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 06:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjEPE1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 00:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjEPE1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 00:27:43 -0400
Received: from mail.nsr.re.kr (unknown [210.104.33.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478513C27;
        Mon, 15 May 2023 21:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; s=LIY0OQ3MUMW6182UNI14; d=nsr.re.kr; t=1684211140; c=relaxed/relaxed; h=content-type:date:from:message-id:mime-version:subject:to; bh=HBi/8JzYkQRXK7f+rKqRBFiLUILZNW6t5000hG5Ul+A=; b=nveoYEfcSjttc/uXCF5SmU1wRpkm05yD4XL1v76BXptApTCwDvvbrCsskON+CLng5nioUvWorgyywHkaF2sLHqaL/d1UY6JDHxdWtWi0Oiyv88rQHIXCJLbsWXnvz0Hl6ilzPH0kV/i9IfZf1qVf2vvnRGo0uhiheCAjIRKfJ2vuGTkzlEQukukG9v8qovHQpbujjRcI800dtxs1Tb0BV2xT7OW39IEzM4453+GWCCJDZVtykeGRWwwaACIrbcmFY9126298VxuysFvxiTM88Oec+gkcCmKzmZWsygUDfqW1k0jy6xwMRUn8Ej7G/grYuEc38muTWsRw32dca8z4Xw==
Received: from 210.104.33.70 (nsr.re.kr)
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128 bits))
        by mail.nsr.re.kr with SMTP; Tue, 16 May 2023 13:25:25 +0900
Received: from 192.168.155.188 ([192.168.155.188])
          by mail.nsr.re.kr (Crinity Message Backbone-7.0.1) with SMTP ID 195;
          Tue, 16 May 2023 13:27:12 +0900 (KST)
From:   Dongsoo Lee <letrhee@nsr.re.kr>
To:     'Eric Biggers' <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        'Herbert Xu' <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@alien8.de>,
        'Dave Hansen' <dave.hansen@linux.intel.com>, x86@kernel.org,
        "'H. Peter Anvin'" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        'Dongsoo Lee' <letrhee@gmail.com>
References: <20230428110058.1516119-1-letrhee@nsr.re.kr> <20230428231952.GA3150@sol.localdomain>
In-Reply-To: <20230428231952.GA3150@sol.localdomain>
Subject: RE: [PATCH 0/3] crypto: LEA block cipher implementation
Date:   Tue, 16 May 2023 13:27:12 +0900
Message-ID: <000b01d987ae$af907700$0eb16500$@nsr.re.kr>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHK1YbJb9NIiePFBRS96VOevnCZtwH6THbqr2nfm4A=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your kind review and sorry for taking a bit of time to
respond.

We expect that the first application of the patch would be disk =
encryption
on the Gooroom platform ('Gooroom' is a Korean word, meaning 'cloud') =
[1].
Currently, the Gooroom platform uses AES-XTS for disk encryption. The =
main
reason for submitting this patch is to make disk encryption with LEA =
(e.g.
LEA-XTS) available in it.

The Gooroom platform is a government-driven Debian-based Linux =
distribution
in South Korea. In Korea, there are many crypto companies that want to
bundle Linux into their products and sell them. They create their own
Gooroom platforms by modifying the original Gooroom platform for their
services. (Of course, the Gooroom platform is not mandatory, and =
companies
wishing to use Linux are free to choose an appropriate distribution.) =
BTW,
in Korea, many crypto companies want to use LEA, because LEA is one of =
the
block ciphers of the KCMVP, a validation program for commercial crypto =
S/W
to be delivered to the Korean government.

The Linux Crypto API already has another Korean block cipher, ARIA, also
one of the block ciphers of the KCVMP. However, LEA is more widely used
than ARIA in industry nowadays, because LEA is one of the lightweight
cryptography standard of ISO/IEC [2] and performs well on low-end =
devices
that support 32-bit operations. So we think they are complementary to =
each
other.
LEA also performs slightly better in Generic C and AVX2 instruction
implementations than ARIA. While there is no AVX512 instruction
implementation of LEA yet, it is expected that the techniques used in =
the
AVX2 implementation can also be applied to AVX512. Rather, using 512-bit
registers and rotation instructions, LEA is expected to show even better
performance in AVX512 than in AVX2.

Performance comparisons of the two ciphers on a Ryzen R9 5950X using the
tcrypt module are shown below. Please note that this CPU does not =
support
GFNI and AVX512, so the results on ARIA may show less efficiency =
compared
to the ones offered by the current Linux kernel. The experiments on LEA
were done with the version that we are currently working on.

- 256-bit key, 4096 bytes
  - aes-aesni
    - ecb enc   1,637 cycles
    - ecb dec   1,608 cycles
    - ctr enc   1,649 cycles
  - aria-generic
    - ecb enc 235,293 cycles
    - ecb dec 237,949 cycles
    - ctr enc 240,754 cycles
  - lea-generic
    - ecb enc  31,945 cycles
    - ecb dec  50,511 cycles
    - ctr enc  33,942 cycles
  - aria-avx2
    - ecb enc  9,807 cycles
    - ecb dec 10,203 cycles
    - ctr enc 10,038 cycles
  - lea-avx2
    - ecb enc  5,784 cycles
    - ecb dec  7,423 cycles
    - ctr enc  6,136 cycles

In general, it's obvious that the hardware-accelerated AES is the best
performer. However, there exist not only environments where the =
hardware-
accelerated AES is not supported, but also situations where AES is not
preferred for various reasons. In these cases, if someone wants to =
encrypt
using a block cipher, LEA could be an alternative.

Apart from this, we also have implemented LEA in lightweight =
environments
such as 8-bit AVR and 16-bit MSP [3]. Only the assembly implementation =
of
LEA with AVX2 was submitted because the main goal was x86_64 as =
mentioned
earlier. If LEA were to be included in the Linux kernel, it would be
possible to modify and supplement the submission with lightweight
implementations to provide efficient encryption on low-performance =
devices.

Although the designers of LEA did not provide test vectors in their =
paper
[5], the ISO/IEC standard [2] and the KS standard [4] do. Furthermore, =
the
Block Cipher LEA Specification("=BA=ED=B7=CF=BE=CF=C8=A3 LEA =
=B1=D4=B0=DD=BC=AD", written in Korean)
document on the LEA introduction page [6] and the Wikipedia article on =
LEA
[7] show the same test vectors as in the standards.
The test vectors for ECB, CBC, CTR, and GCM modes included in the =
testmgr
module are taken from the KCMVP Cryptographic Algorithm Verification
Criteria V3.0("KCMVP =B0=CB=C1=F5=B4=EB=BB=F3 =
=BE=CF=C8=A3=BE=CB=B0=ED=B8=AE=C1=F2 =B0=CB=C1=F5=B1=E2=C1=D8 V3.0", =
written in
Korean) [8]. Test vectors for the XTS mode were generated by ourselves, =
and
we crosschecked them using Crypto++ [9] and testmgr on Linux.

[1] https://github.com/gooroom https://www.gooroom.kr/
[2] ISO/IEC 29192-2:2019, Information security - Lightweight =
cryptography -
Part 2: Block ciphers.
[3]
https://github.com/cryptolu/FELICS/tree/master/block_ciphers/source/ciphe=
rs/
LEA_128_128_v01/source
[4] KS X 3246, 128-bit block cipher LEA.
[5] Hong, Deukjo, et al. "LEA: A 128-bit block cipher for fast =
encryption
on common processors.", WISA 2013.
[6] https://seed.kisa.or.kr/kisa/algorithm/EgovLeaInfo.do
[7] https://en.wikipedia.org/wiki/LEA_(cipher)
[8] https://seed.kisa.or.kr/kisa/kcmvp/EgovVerification.do
[9] https://www.cryptopp.com/

+) We applied the optimization technique introduced in your the other
review to our decryption code. So, could you please let us know how to
state that fact clearly?

-----Original Message-----
From: Eric Biggers <ebiggers@kernel.org>=20
Sent: Saturday, April 29, 2023 8:20 AM
To: Dongsoo Lee <letrhee@nsr.re.kr>
Cc: linux-crypto@vger.kernel.org; Herbert Xu =
<herbert@gondor.apana.org.au>;
David S. Miller <davem@davemloft.net>; Thomas Gleixner
<tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Borislav Petkov
<bp@alien8.de>; Dave Hansen <dave.hansen@linux.intel.com>; =
x86@kernel.org;
H. Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel.org; David S.
Miller <abc@test.nsr.re.kr>; Dongsoo Lee <letrhee@gmail.com>
Subject: Re: [PATCH 0/3] crypto: LEA block cipher implementation

Hi Dongsoo,

On Fri, Apr 28, 2023 at 08:00:55PM +0900, Dongsoo Lee wrote:
> The Korean e-government framework contains various cryptographic=20
> applications, and KCMVP-validated cryptographic module should be used=20
> according to the government requirements. The ARIA block cipher, which =

> is already included in Linux kernel, has been widely used as a=20
> symmetric key cipher. However, the adoption of LEA increase rapidly=20
> for new applications.
>=20
> By adding LEA to the Linux kernel, Dedicated device drivers that=20
> require LEA encryption can be provided without additional crypto
implementation.
> An example of an immediately applicable use case is disk encryption=20
> using cryptsetup.
>=20
> The submitted implementation includes a generic C implementation that=20
> uses 32-bit ARX operations, and an optimized implementation for the
> x86_64 environment.

Can you elaborate further on the use case for this cipher?  Your
description above is very vague.  What is the actual use case when so =
many
other ciphers already exist, including much better studied ones?  Are
people being required to use this cipher, and if so under what =
situations?
There is also already another "national pride" block cipher from Korea
(ARIA); do we really need another one?

BTW, in 2018, I investigated LEA and various other ciphers as options =
for
storage encryption on ARM processors without the crypto extensions.  We
ended up not selecting LEA for several different reasons (e.g. see
https://lore.kernel.org/r/20180507232000.GA194688@google.com), and we =
later
created Adiantum for the use case.  But, it sounds like "storage =
encryption
on processors without crypto instructions" isn't the use case you have =
in
mind at all anyway, seeing as the only assembly code you're providing is
for x86_64.
What sort of use case do you actually have in mind?  Is this perhaps a =
PhD
thesis type of thing that won't actually be used in a real world
application?

IIRC, one of the issues with LEA was that the LEA paper doesn't provide
test vectors, so I couldn't be certain that I had actually implemented =
the
algorithm correctly.  It sounds like there are now test vectors =
available.
How confident are you that they actually match the original algorithm?

> The implementation has been tested with kernel module tcrypt.ko and=20
> has passed the selftest using test vectors for KCMVP[4]. The path also =

> test with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.

There is a KASAN out-of-bounds error in lea_set_key() when running the =
self-
tests.

- Eric
