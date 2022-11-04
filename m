Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263FA6193B0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiKDJjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKDJjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:39:17 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED66625B;
        Fri,  4 Nov 2022 02:39:16 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oqt9Z-00A29z-2P; Fri, 04 Nov 2022 17:38:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Nov 2022 17:38:57 +0800
Date:   Fri, 4 Nov 2022 17:38:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 00/13] Optimizing SM3 and SM4 algorithms using arm64
 NEON/CE instructions
Message-ID: <Y2TdseEBpJ7cu2Vg@gondor.apana.org.au>
References: <20221027065505.15306-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027065505.15306-1-tianjia.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 02:54:52PM +0800, Tianjia Zhang wrote:
> Hi folks,
> 
> This series of patches uses different arm64 instruction sets to optimize
> the SM3 and SM4 algorithms, as well as the optimization of different
> modes of SM4.
> 
> patch 1-2:   NEON instruction set optimization for SM3
> patch 3:     Refactored and streamlined SM4 NEON instruction implementation
> patch 4-5:   support test for new SM4 mode
> patch 6-8:   Refactored and streamlined SM4 CE instruction implementation
> patch 9-10:  CE accelerated implementation of SM4 CTS/XTS
> patch 11:    CE accelerated implementation of SM4 CMAC/XCBC/CBCMAC
> patch 12-13: CE accelerated implementation of SM4 CCM/GCM
> 
> v3 change:
>   - As Eric said, remove the code for ESSIV, including testmgr and tcrypt
> 
> v2 changes:
>   - remove ARMv9 SVE acceleration implementation
>   - rebase onto v6.1-rc1
> 
> Cheers,
> Tianjia
> 
> Tianjia Zhang (13):
>   crypto: arm64/sm3 - raise the priority of the CE implementation
>   crypto: arm64/sm3 - add NEON assembly implementation
>   crypto: arm64/sm4 - refactor and simplify NEON implementation
>   crypto: testmgr - add SM4 cts-cbc/xts/xcbc test vectors
>   crypto: tcrypt - add SM4 cts-cbc/xts/xcbc test
>   crypto: arm64/sm4 - refactor and simplify CE implementation
>   crypto: arm64/sm4 - simplify sm4_ce_expand_key() of CE implementation
>   crypto: arm64/sm4 - export reusable CE acceleration functions
>   crypto: arm64/sm4 - add CE implementation for CTS-CBC mode
>   crypto: arm64/sm4 - add CE implementation for XTS mode
>   crypto: arm64/sm4 - add CE implementation for cmac/xcbc/cbcmac
>   crypto: arm64/sm4 - add CE implementation for CCM mode
>   crypto: arm64/sm4 - add CE implementation for GCM mode
> 
>  arch/arm64/crypto/Kconfig           |   47 +-
>  arch/arm64/crypto/Makefile          |    9 +
>  arch/arm64/crypto/sm3-ce-glue.c     |    2 +-
>  arch/arm64/crypto/sm3-neon-core.S   |  600 +++++++++++++
>  arch/arm64/crypto/sm3-neon-glue.c   |  103 +++
>  arch/arm64/crypto/sm4-ce-asm.h      |  209 +++++
>  arch/arm64/crypto/sm4-ce-ccm-core.S |  328 ++++++++
>  arch/arm64/crypto/sm4-ce-ccm-glue.c |  303 +++++++
>  arch/arm64/crypto/sm4-ce-core.S     | 1205 ++++++++++++++++++---------
>  arch/arm64/crypto/sm4-ce-gcm-core.S |  741 ++++++++++++++++
>  arch/arm64/crypto/sm4-ce-gcm-glue.c |  286 +++++++
>  arch/arm64/crypto/sm4-ce-glue.c     |  575 ++++++++++++-
>  arch/arm64/crypto/sm4-ce.h          |   16 +
>  arch/arm64/crypto/sm4-neon-core.S   |  630 +++++++++-----
>  arch/arm64/crypto/sm4-neon-glue.c   |  172 +---
>  crypto/tcrypt.c                     |   21 +
>  crypto/testmgr.c                    |   19 +
>  crypto/testmgr.h                    |  977 ++++++++++++++++++++++
>  18 files changed, 5478 insertions(+), 765 deletions(-)
>  create mode 100644 arch/arm64/crypto/sm3-neon-core.S
>  create mode 100644 arch/arm64/crypto/sm3-neon-glue.c
>  create mode 100644 arch/arm64/crypto/sm4-ce-asm.h
>  create mode 100644 arch/arm64/crypto/sm4-ce-ccm-core.S
>  create mode 100644 arch/arm64/crypto/sm4-ce-ccm-glue.c
>  create mode 100644 arch/arm64/crypto/sm4-ce-gcm-core.S
>  create mode 100644 arch/arm64/crypto/sm4-ce-gcm-glue.c
>  create mode 100644 arch/arm64/crypto/sm4-ce.h
> 
> -- 
> 2.24.3 (Apple Git-128)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
