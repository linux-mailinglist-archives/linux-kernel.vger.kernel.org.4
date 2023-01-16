Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B00866C35F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjAPPMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjAPPLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:11:46 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC04301BF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:59:58 -0800 (PST)
Date:   Mon, 16 Jan 2023 14:59:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail; t=1673881196; x=1674140396;
        bh=zzF9mAQN1tOBRS7sao22BNfZIlVCplVmqFFZ1O+i9rQ=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=PeWRTFyZ5oaod8KIEvldYz8XEm18qXWxt/IZefcD5a+Y/YTjdCq1zkY+4KeEEz8PC
         vX4ti3EzR1zcuC6fkj3Pge1gIAHhHzbW9+DH7jl+TzK13q7hwiS+MQEyWvYWiz5poq
         urQ3kcCoT1rzfhzh5f2dKN1J1qTerMlJZkqf2wOWPp0O7o2sXQbY+0VqzZn2seNdrd
         2G/UfDWw9OY991VbA+GX35XY4icIf5elnTaVpDHqgeQs2/csr9UVq6KYWRZuczlU5/
         +Ta0vNF0xeDFPKMwR7/cYBzEZne8HkH4g6f15DQrJq3FTilfyGvcFqPMMwQc8IJyVo
         2cikKCqAFtEuw==
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     "ardb@kernel.org" <ardb@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Lafreniere <peter@n8pjl.ca>
Subject: [PATCH] crypto: x86 - exit fpu context earlier in ECB/CBC macros
Message-ID: <IBooTlGWpNE7pOelt0gm21bxW7wBILNYJ1HaoPbbfdEEMwz0Pp92vpd_OUlhNFNAitFThTi27P6q6NvcYMKm-y7tjwiF9YbImWjhgC3UDMk=@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the ecb/cbc macros hold fpu context unnecessarily when using=20
scalar cipher routines (e.g. when handling odd sizes of blocks per walk).

Change the macros to drop fpu context as soon as the fpu is out of use.

No performance impact found (on Intel Haswell).

Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
---
 arch/x86/crypto/ecb_cbc_helpers.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/crypto/ecb_cbc_helpers.h b/arch/x86/crypto/ecb_cbc_he=
lpers.h
index eaa15c7b29d6..b83085e18ab0 100644
--- a/arch/x86/crypto/ecb_cbc_helpers.h
+++ b/arch/x86/crypto/ecb_cbc_helpers.h
@@ -14,12 +14,13 @@
 #define ECB_WALK_START(req, bsize, fpu_blocks) do {=09=09=09\
 =09void *ctx =3D crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));=09\
+=09const int __fpu_blocks =3D (fpu_blocks);=09=09=09=09\
 =09const int __bsize =3D (bsize);=09=09=09=09=09\
 =09struct skcipher_walk walk;=09=09=09=09=09\
 =09int err =3D skcipher_walk_virt(&walk, (req), false);=09=09\
 =09while (walk.nbytes > 0) {=09=09=09=09=09\
 =09=09unsigned int nbytes =3D walk.nbytes;=09=09=09\
-=09=09bool do_fpu =3D (fpu_blocks) !=3D -1 &&=09=09=09\
-=09=09=09      nbytes >=3D (fpu_blocks) * __bsize;=09=09\
+=09=09bool do_fpu =3D __fpu_blocks !=3D -1 &&=09=09=09\
+=09=09=09      nbytes >=3D __fpu_blocks * __bsize;=09=09\
 =09=09const u8 *src =3D walk.src.virt.addr;=09=09=09\
 =09=09u8 *dst =3D walk.dst.virt.addr;=09=09=09=09\
 =09=09u8 __maybe_unused buf[(bsize)];=09=09=09=09\
@@ -35,7 +36,12 @@
 } while (0)
=20
 #define ECB_BLOCK(blocks, func) do {=09=09=09=09=09\
-=09while (nbytes >=3D (blocks) * __bsize) {=09=09=09=09\
+=09const int __blocks =3D (blocks);=09=09=09=09=09\
+=09if (do_fpu && __blocks < __fpu_blocks) {=09=09=09\
+=09=09kernel_fpu_end();=09=09=09=09=09\
+=09=09do_fpu =3D false;=09=09=09=09=09=09\
+=09}=09=09=09=09=09=09=09=09\
+=09while (nbytes >=3D __blocks * __bsize) {=09=09=09=09\
 =09=09(func)(ctx, dst, src);=09=09=09=09=09\
 =09=09ECB_WALK_ADVANCE(blocks);=09=09=09=09\
 =09}=09=09=09=09=09=09=09=09\
@@ -53,7 +59,12 @@
 } while (0)
=20
 #define CBC_DEC_BLOCK(blocks, func) do {=09=09=09=09\
-=09while (nbytes >=3D (blocks) * __bsize) {=09=09=09=09\
+=09const int __blocks =3D (blocks);=09=09=09=09=09\
+=09if (do_fpu && __blocks <  __fpu_blocks) {=09=09=09\
+=09=09kernel_fpu_end();=09=09=09=09=09\
+=09=09do_fpu =3D false;=09=09=09=09=09=09\
+=09}=09=09=09=09=09=09=09=09\
+=09while (nbytes >=3D __blocks * __bsize) {=09=09=09=09\
 =09=09const u8 *__iv =3D src + ((blocks) - 1) * __bsize;=09\
 =09=09if (dst =3D=3D src)=09=09=09=09=09=09\
 =09=09=09__iv =3D memcpy(buf, __iv, __bsize);=09=09\
--=20
2.39.0


