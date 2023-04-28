Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB7C6F164C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjD1LCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjD1LCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:02:40 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Apr 2023 04:02:37 PDT
Received: from mail.nsr.re.kr (unknown [210.104.33.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E666E26B2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; s=LIY0OQ3MUMW6182UNI14; d=nsr.re.kr; t=1682679653; c=relaxed/relaxed; h=date:from:message-id:mime-version:subject:to; bh=fduGQRlBa9QiqU0Mjp18cRW/tGgDG1Os2W0gWXXl1nE=; b=gzK3bqBuQv/PpDKqBA2KPUAQTR+YobwFt3+JcthP6ELvWpOSGnIUwvi2XlKDHm9pZXyNj2/xiXwDD5Z7wlUYqbMtzdae9svSSKl/aKcELlaJA0mrOLsj6YOFVGbXbjPSNC4pFB12udMWy1U1QvjkHm1jIKr9fZal7kiSp8BUtv+6Igx79QLcD8enjYJMTtCcLO81IbZuvKTrS2uMXC1VbaSIeBj4T+y+j6ouGgEc8QPced754fGI+Nj0D/tfn0JjqLvxzWskCIGo1WxJj7ty7U4eLpGdX5cj3zFeKiGbvsX3LfcdDi/6Zrueh7mLZ16oR+Nf/fffilei2ts6EdlsOw==
Received: from 210.104.33.70 (nsr.re.kr)
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128 bits))
        by mail.nsr.re.kr with SMTP; Fri, 28 Apr 2023 19:59:31 +0900
Received: from 192.168.155.188 ([192.168.155.188])
          by mail.nsr.re.kr (Crinity Message Backbone-7.0.1) with SMTP ID 623;
          Fri, 28 Apr 2023 20:01:09 +0900 (KST)
From:   Dongsoo Lee <letrhee@nsr.re.kr>
To:     linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <abc@test.nsr.re.kr>,
        Dongsoo Lee <letrhee@gmail.com>,
        Dongsoo Lee <letrhee@nsr.re.kr>
Subject: [PATCH 0/3] crypto: LEA block cipher implementation
Date:   Fri, 28 Apr 2023 20:00:55 +0900
Message-Id: <20230428110058.1516119-1-letrhee@nsr.re.kr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This submission contains a generic C implementation of the LEA block
cipher and its optimized implementation within ECB, CBC, CTR, and XTR
cipher modes of operation for the x86_64 environment.

The LEA algorithm is a symmetric key cipher that processes data blocks
of 128bits and has three different key lengths, each with a different
number of rounds:

- LEA-128: 128-bit key, 24 rounds,
- LEA-192: 192-bit key, 28 rounds, and
- LEA-256: 256-bit key, 32 rounds.

The round function of LEA consists of 32-bit ARX(modular Addition,
bitwise Rotation, and bitwise XOR) operations. See [1, 2] for details.

The LEA is a Korean national standard block cipher, described in
"KS X 3246" and is also included in the international standard,
"ISO/IEC 29192-2:2019 standard (Information security - Lightweight
cryptography - Part 2: Block ciphers)".

It is one of the approved block ciphers for the current Korean
Cryptographic Module Validation Program (KCMVP).

The Korean e-government framework contains various cryptographic
applications, and KCMVP-validated cryptographic module should be used
according to the government requirements. The ARIA block cipher, which
is already included in Linux kernel, has been widely used as a symmetric
key cipher. However, the adoption of LEA increase rapidly for new
applications.

By adding LEA to the Linux kernel, Dedicated device drivers that require
LEA encryption can be provided without additional crypto implementation.
An example of an immediately applicable use case is disk encryption
using cryptsetup.

The submitted implementation includes a generic C implementation that
uses 32-bit ARX operations, and an optimized implementation for the
x86_64 environment.

The implementation same as submitted generic C implementation is
distributed through the Korea Internet & Security Agency (KISA),
could be found [3].

For the x86_64 environment, we use SSE2/MOVBE/AVX2 instructions. Since
LEA use four 32-bit unsigned integers for 128-bit block, the SSE2 and
AVX2 implementations encrypts four and eight blocks at a time for
optimization, repectively.
Our submission provides a optimized implementation of 4/8 block ECB, CBC
decryption, CTR, and XTS cipher operation modes on x86_64 CPUs
supporting AVX2. The MOVBE instruction is used for optimizing the CTR
mode.

The implementation has been tested with kernel module tcrypt.ko and has
passed the selftest using test vectors for KCMVP[4]. The path also test
with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.

- [1] https://en.wikipedia.org/wiki/LEA_(cipher)
- [2] https://seed.kisa.or.kr/kisa/algorithm/EgovLeaInfo.do
- [3] https://seed.kisa.or.kr/kisa/Board/20/detailView.do
- [4] https://seed.kisa.or.kr/kisa/kcmvp/EgovVerification.do

Dongsoo Lee (3):
      crypto: LEA block cipher implementation
      crypto: add LEA testmgr tests
      crypto: LEA block cipher AVX2 optimization

 arch/x86/crypto/Kconfig               |   22 +
 arch/x86/crypto/Makefile              |    3 +
 arch/x86/crypto/lea_avx2_glue.c       | 1112 +++++++++++++++++++++++++
 arch/x86/crypto/lea_avx2_x86_64-asm.S |  778 ++++++++++++++++++
 crypto/Kconfig                        |   12 +
 crypto/Makefile                       |    1 +
 crypto/lea_generic.c                  |  915 +++++++++++++++++++++
 crypto/tcrypt.c                       |   73 ++
 crypto/testmgr.c                      |   32 +
 crypto/testmgr.h                      | 1211 ++++++++++++++++++++++++++++
 include/crypto/lea.h                  |   39 +
 11 files changed, 4198 insertions(+)

