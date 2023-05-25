Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B53710BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbjEYMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjEYMN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:13:56 -0400
Received: from mail.nsr.re.kr (unknown [210.104.33.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162E1BB;
        Thu, 25 May 2023 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; s=LIY0OQ3MUMW6182UNI14; d=nsr.re.kr; t=1685016712; c=relaxed/relaxed; h=content-type:date:from:message-id:mime-version:subject:to; bh=r9CC3YFklz3i+XcbnKWGD5csS0s5IRx+zvD871hDGe4=; b=GH2soNeG+p4ODwPle/LOMysiyE3MOUObLZhH8QdfU14XDBrg5GNsHwaoZpj5wH+F7Kws/M1P4W0gpSsHxHglsyX09LbfCSLNKKnp/ocw0OB3GY7lhjLCExEc1BPUqTYspQlR5RVqKK8rYjEm1WGTvvZQqEwFbOAuGn+cwnalrvp8KjRqw3hBh9OICNS8vv5FFTEfpjSdSlOV89BKEcLMF6z/BRs/bwh+Wa/iFNgJzznSvXUL6vch99Lw5SvrjFG863MB3Xsoq71Xyjn8YPYxck/BoMJfMcubqQqIC8+cOf+b+Ox+YETxcehDP0N6S2d5fS5GIXzRfs9nm+zF45eWGw==
Received: from 210.104.33.70 (nsr.re.kr)
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128 bits))
        by mail.nsr.re.kr with SMTP; Thu, 25 May 2023 21:11:37 +0900
Received: from 192.168.155.188 ([192.168.155.188])
          by mail.nsr.re.kr (Crinity Message Backbone-7.0.1) with SMTP ID 803;
          Thu, 25 May 2023 21:13:28 +0900 (KST)
From:   Dongsoo Lee <letrhee@nsr.re.kr>
To:     linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Dongsoo Lee <letrhee@gmail.com>,
        Dongsoo Lee <letrhee@nsr.re.kr>
Subject: [PATCH v2 0/2] crypto: LEA block cipher implementation
Date:   Thu, 25 May 2023 21:12:59 +0900
Message-Id: <20230525121301.722682-1-letrhee@nsr.re.kr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This submission contains a generic C implementation of the LEA cipher algorithm and test vectors for it.

The LEA algorithm is a lightweight block cipher that processes data blocks of 128-bits and has three different key lengths, each with a different number of rounds:

- LEA-128: 128-bit key, 24 rounds,
- LEA-192: 192-bit key, 28 rounds, and
- LEA-256: 256-bit key, 32 rounds.

The round function of LEA consists of 32-bit ARX(modular Addition, bitwise Rotation, and bitwise XOR) operations. See [2, 5, 7] for details.

LEA is a Korean national standard block cipher, described in "KS X 3246"[1] and is also included in the international standard, "ISO/IEC 29192-2:2019 standard"[2].

It is one of the approved block ciphers for the current Korean Cryptographic Module Validation Program (KCMVP).

We expect that the first application of the patch would be disk encryption on the Gooroom platform ('Gooroom' is a Korean word, meaning 'cloud') [3]. Currently, the Gooroom platform uses AES-XTS for disk encryption. The main reason for submitting this patch is to make disk encryption with LEA (e.g. LEA-XTS) available on there.

The Gooroom platform is a government-driven Debian-based Linux distribution in South Korea. In Korea, there are many crypto companies that want to bundle Linux into their products and sell them. They create their own Gooroom platforms by modifying the original Gooroom platform for their services. (Of course, the Gooroom platform is not mandatory, and companies wishing to use Linux are free to choose an appropriate distribution.) BTW, in Korea, many crypto companies want to use LEA, because LEA is one of the block ciphers of the KCMVP, a validation program for commercial crypto S/W to be delivered to the Korean government.

The Linux Crypto API already has another Korean block cipher, ARIA, also one of the block ciphers of the KCVMP. However, LEA is more widely used than ARIA in industry nowadays, because LEA is one of the lightweight cryptography standard of ISO/IEC [2] and performs well on low-end devices that support 32-bit operations. So we think they are complementary to each other.

In general, it's obvious that the hardware-accelerated AES is the best performer. However, there exist not only environments where the hardware-accelerated AES is not supported, but also situations where AES is not preferred for various reasons. In these cases, if someone wants to encrypt using a block cipher, LEA could be an alternative.

There are also SIMD implementations for efficiently using LEA, which is not included in this patch. We have SSE2 and AVX2 assembly implementations, some of which were included in the previous version of the patch. The SIMD implementations are being re-implemented to support a wider range of environments.

Apart from this, we also have implemented LEA in lightweight environments such as 8-bit AVR, 16-bit MSP and 32-bit ARM [4]. If LEA were to be included in the Linux kernel, it would be possible to modify and supplement the submission with lightweight implementations to provide efficient encryption on embedded linux devices.

Although the designers of LEA did not provide test vectors in their paper [5], the ISO/IEC standard [2] and the KS standard [1] do. Furthermore, the Block Cipher LEA Specification("블록암호 LEA 규격서", written in Korean) document on the LEA introduction page [6] and the Wikipedia article on LEA [7] show the same test vectors as in the standards.

The test vectors for ECB, CBC, CTR, and GCM modes included in the testmgr module are taken from the KCMVP Cryptographic Algorithm Verification Criteria V3.0("KCMVP 검증대상 암호알고리즘 검증기준 V3.0", written in Korean) [8]. Test vectors for the XTS mode were generated by ourselves, and we crosschecked them using Crypto++ [9] and testmgr on Linux.

The implementation has been tested with kernel module tcrypt.ko and has passed the selftest using above-mentioned test vectors. It also has been tested with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS and KASAN enabled considering the previous review.

[1] KS X 3246, 128-bit block cipher LEA.
[2] ISO/IEC 29192-2:2019, Information security — Lightweight cryptography — Part 2: Block ciphers.
[3] https://github.com/gooroom https://www.gooroom.kr/
[4] https://github.com/cryptolu/FELICS/tree/master/block_ciphers/source/ciphers/LEA_128_128_v01/source
[5] Hong, Deukjo, et al. "LEA: A 128-bit block cipher for fast encryption on common processors.", WISA 2013.
[6] https://seed.kisa.or.kr/kisa/algorithm/EgovLeaInfo.do
[7] https://en.wikipedia.org/wiki/LEA_(cipher)
[8] https://seed.kisa.or.kr/kisa/kcmvp/EgovVerification.do
[9] https://www.cryptopp.com/

Changelog:
v2:
- Reimplemented the Generic C implementation as a Loop version.
  - The decryption code was adapted from an optimized implementation by Eric Biggers.
    https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?h=old/wip-lea&id=1d1cbba14380f8a1abc76baf939b9e51de047fb6
- Removed AVX2 SIMD implementation.
- Added comments for functions.
- Improved the description in Kconfig.
- Added test vectors from the standard documentation.

