Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458EE6F8CC9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjEEX1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjEEX1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8D7E7D;
        Fri,  5 May 2023 16:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12EDC64174;
        Fri,  5 May 2023 23:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157CFC433D2;
        Fri,  5 May 2023 23:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683329252;
        bh=/WiVNmGDwllO/hZsuR/739XrMjTBbzdh4pn30YDREBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ych+mXj1sPCCyOvUrCbBNsvbkXy0MLPu3YQ9geQ/Znxy5k7THtMRDQPGtXRine5ss
         Y+15sS8DvVmMyv4uNy+IOIGR32LQUiuTIMB+0yX9XD6sJHQ0dve7Aaq/yBfDoizf4H
         5Dhkzi1tFsfIvRx/hxltV8+XzfKZ3+yq01mpx+FZ/DC6xbsyMkdRcMlnILpdwyWmaw
         gzTd+HfZarybBLLMgXiXx5mt5fldWpM+pNXsS4B6XNSwgW9IkZ1ZLZU20Jx77YCRbj
         TB+p0K0wI2wey/y14XQNHh9x7UuO6+C/Cs1pkm8wG4ChA0b44gry7W7jjugzYeIPCa
         Z5ADhmJY0Kb8A==
Date:   Fri, 5 May 2023 23:27:30 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 10/12] crypto: x86/aes - Prepare for a new AES
 implementation
Message-ID: <ZFWQ4sZEVu/LHq+Q@gmail.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-11-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410225936.8940-11-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 03:59:34PM -0700, Chang S. Bae wrote:
> Refactor the common C code to avoid code duplication. The AES-NI code uses
> it with a function pointer argument to call back the AES-NI assembly code.
> So will the AES-KL code.

Actually, the AES-NI XTS glue code currently makes direct calls to the assembly
code.  This patch changes it to make indirect calls.  Indirect calls are very
expensive these days, partly due to all the speculative execution mitigations.
So this patch likely causes a performance regression.  How about making
xts_crypt_common() and xts_setkey_common() be inline functions?

Another issue with having the above be exported symbols is that their names are
too generic, so they could easily collide with another symbols in the kernel.
To be exported symbols, they would need something x86-specific in their names.

>  arch/x86/crypto/Makefile           |   2 +-
>  arch/x86/crypto/aes-intel_asm.S    |  26 ++++
>  arch/x86/crypto/aes-intel_glue.c   | 127 ++++++++++++++++
>  arch/x86/crypto/aes-intel_glue.h   |  44 ++++++
>  arch/x86/crypto/aesni-intel_asm.S  |  58 +++----
>  arch/x86/crypto/aesni-intel_glue.c | 235 +++++++++--------------------
>  arch/x86/crypto/aesni-intel_glue.h |  17 +++

It's confusing having aes-intel, aesni-intel, *and* aeskl-intel.  Maybe call the
first one "aes-helpers" or "aes-common" instead?

> +struct aes_xts_ctx {
> +	u8 raw_tweak_ctx[sizeof(struct crypto_aes_ctx)] AES_ALIGN_ATTR;
> +	u8 raw_crypt_ctx[sizeof(struct crypto_aes_ctx)] AES_ALIGN_ATTR;
> +};

This struct does not make sense.  It should look like:

    struct aes_xts_ctx {
            struct crypto_aes_ctx tweak_ctx AES_ALIGN_ATTR;
            struct crypto_aes_ctx crypt_ctx AES_ALIGN_ATTR;
    };

The runtime alignment to a 16-byte boundary should happen when translating the
raw crypto_skcipher_ctx() into the pointer to the aes_xts_ctx.  It should not
happen when accessing each individual field in the aes_xts_ctx.

>  /*
> - * int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
> - *                   unsigned int key_len)
> + * int _aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
> + *                    unsigned int key_len)
>   */

It's conventional to use two leading underscores, not one.

- Eric
