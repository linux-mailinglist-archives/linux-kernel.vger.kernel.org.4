Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D674F6B907E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCNKru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCNKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:47:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB528208;
        Tue, 14 Mar 2023 03:47:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PbVZz3nmNz4xDp;
        Tue, 14 Mar 2023 21:47:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678790830;
        bh=KuhEXXxO7odt2tOpWdOwGGmaEO+SI1OzAWU0pdYuXyM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KYpQ1r/VsI7SXBkdi3YF/jmnXzkdwp14eg8EVmX3q/h4KHucdJ2nQcsThQRpJPihe
         kl09uvNkoNLFBYZZySb4r2h0CteEAnpZHx5oOEQVJyVxV9+xmRK6FbffYqz+u86lN4
         fMc2OaHtQjohJl5q1wNzV5gsJm3crL4njd+NycJ5pzLSwcoPIjQIk2Cj5GU8XZHvPg
         rgGGnO284Mgwan/te1WtC7IKLqBp1lTIR8dgaOPBSIZFSEcto5MiaTZHfiS2np8FjN
         ARndGSA1WzzvNOMeNZum5lKGGHd0UDYy9EHSdpMywxdLy0uSXZAflzgZ2kqW1FuSLP
         QJuY6jplWW8tw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "ye.xingchen@zte.com.cn" <ye.xingchen@zte.com.cn>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dtsen@linux.ibm.com
Subject: Re: [PATCH] crypto: p10-aes-gcm - remove duplicate include header
In-Reply-To: <ZBA1EVdy1DvfxgRO@gondor.apana.org.au>
References: <202303141631511535639@zte.com.cn>
 <dbbd6ff3-5e17-9b63-9027-359e37ace668@csgroup.eu>
 <ZBA1EVdy1DvfxgRO@gondor.apana.org.au>
Date:   Tue, 14 Mar 2023 21:44:52 +1100
Message-ID: <87mt4fobmj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> writes:
> On Tue, Mar 14, 2023 at 08:47:30AM +0000, Christophe Leroy wrote:
>>
>> Any reason for resending ?
>
> The p10 patches were reverted, and have only just been re-instated.

Hmm. Seems none of them were ever Cc'ed to linuxppc-dev. So this is the
first I've seen of them.

We seem to have two almost identical copies of ppc-xlate.pl now :/

  $ find . -name ppc-xlate.pl
  ./arch/powerpc/crypto/ppc-xlate.pl
  ./drivers/crypto/vmx/ppc-xlate.pl

And notably the new one doesn't have the changes from commit
505ea33089dc ("powerpc/64: Add big-endian ELFv2 flavour to crypto VMX
asm generation"), so that probably breaks the build for some configs.

There's also now two new .pl files with identical names, but different
content to the copies in drivers/crypto/vmx:

  $ find . -name "*-ppc.pl" | xargs wc -l
     370 ./arch/powerpc/crypto/ghashp8-ppc.pl
     585 ./arch/powerpc/crypto/aesp8-ppc.pl
     243 ./drivers/crypto/vmx/ghashp8-ppc.pl
    3846 ./drivers/crypto/vmx/aesp8-ppc.pl
    5044 total


Also PPC_MODULE_FEATURE_P10 should be in arch/powerpc/include/asm/cpufeature.h.

And CRYPTO_AES_GCM_P10 should not depend on POWER10_CPU, that restricts
it to being built when the kernel is built to run *only* on Power10,
which basically no one does, certainly no distro.

The code needs to detect at runtime if it's on Power10, and only
register itself if so.

cheers
