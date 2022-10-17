Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B8960135D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJQQ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJQQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:26:44 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333996D579;
        Mon, 17 Oct 2022 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LsrwkTlIt2ogYpw8k6tYRHsjzsVijPyYjsn7Sph/6hQ=; b=q+Nfqb8rSGkZghKbkC16oDTaDD
        nz78q56JaGgk4Q5O/jtH+Ak+rcf3d/FhmLWfqqYfdrYOa5j2vmHD34X0tXIRnrFDDphijC0IUGjmO
        zXJF5Mkvyr4QHEOn6W5qEj2aoSpBmvmFrFIZTs8yPdn3dYlJ+ffSHkeMJvneA5OmaMYClZ60tOwy4
        bUioctvpBiZSLVtBc0LT2IaEhYLM/tydRHHo33FVCpAkXgNSHujX9iy8uWaJpvStkHZ10tbUl9UVh
        TYHdS3cHKcrK24tVVsaQToPy0CzAR+yHtsZIMaH5F2b8aLfwRO0KnlgNwF9rz24HO4dLJLQpStynX
        35779j8w==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1okSwd-000Tef-EU; Mon, 17 Oct 2022 18:26:27 +0200
Message-ID: <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
Date:   Mon, 17 Oct 2022 13:26:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221006234138.1835739-1-keescook@chromium.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221006234138.1835739-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 20:41, Kees Cook wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The crypto 'compress' interface is deprecated, so before adding new
> features, migrate to the acomp interface. Note that we are only using
> synchronous implementations of acomp, so we don't have to deal with
> asynchronous completion.
> 
> [ Tweaked error paths to avoid memory leak, as pointed out byGuilherme
>   G. Piccoli <gpiccoli@igalia.com>, and fixed pstore_compress()
>   return value -kees ]
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lore.kernel.org/lkml/CAMj1kXFnoqj+cn-0dT8fg0kgLvVx+Q2Ex-4CUjSnA9yRprmC-w@mail.gmail.com/
> Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/pstore/platform.c | 74 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 57 insertions(+), 17 deletions(-)
> 

Hi Kees, thanks for re-sending this one.

Just tested it on top of v6.0, with efi-pstore/ramoops, using zstd, lz4
and deflate - everything working as expected.
So, with the typo fixed, have my:

Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Cheers,


Guilherme
