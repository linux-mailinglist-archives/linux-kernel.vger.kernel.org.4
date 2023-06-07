Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372767264D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbjFGPjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjFGPjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05442125
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686152311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zHVq+AaJsRP3MMD5HoVnegJq1rhI+iZeYf1Kj+A0Nvo=;
        b=TssTSqZ+3E/UfDqo0W67A1o/MbwPonadgsI6PrBdmixASQapSKAgmtkPK9tZ/Tzjl0B20c
        hBvVZ8WMBgcNYb4BkLFdZI8es9zkA0kANX7oXmTG88Oq1n0G1aH6atPrGK2WSrph7i/+ZN
        Gxfw9PygbJiFaO3QuUeN9xZS8g8xioo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-I2WAyRDjMVuH8TWHLXFAUg-1; Wed, 07 Jun 2023 09:56:15 -0400
X-MC-Unique: I2WAyRDjMVuH8TWHLXFAUg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-626195b48c8so65890986d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686146174; x=1688738174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHVq+AaJsRP3MMD5HoVnegJq1rhI+iZeYf1Kj+A0Nvo=;
        b=hp3qkazyPBcoiStE2cokaOm1r9ut2pnnV7wFiGhgQ21iswkjDkwpeDriOknmcKqwjr
         yrdxYSZmzaej/EML7A+a9pGRdOioASPK4RBSXcGo0rctt3SeRXlbQsUJRREdSk/0T6yq
         9ehNYdTQkIri1n6wceLGMz047fhQoLed+rb6x9XNjZXQtU2bLQ0AhKiwBl/VKjT4TQL5
         /hMXYK8lMvMt8Wkv583UyDRgDOFTM95SNr7qX3D5o8ivViJS3SN+XrhQXJKdsuch6/zN
         o+xynMqLc/Mr75vO9TVTrdcyaTy9u0Q4Y1yJ00e3IqlX9m2j+VsDKVMq8EibjRo8qiXG
         RM/w==
X-Gm-Message-State: AC+VfDw+LvTIIQ1Eh1GCetp62m/du73jP2DVkcmnhT61U1u3gJSf1kl0
        rQELkUAtKmrbUhEPFOmIS7jsvgO965xfILYNhTw8A4tOTuoMXspBwyb3NQjzEkV7iVXatfuXuWa
        U7EVGDZbLTdqgkMfyX+ifwS7s9x5DGB6z2Tevh91nAJ+7uXGRg38=
X-Received: by 2002:a05:6214:d0a:b0:626:17b2:5583 with SMTP id 10-20020a0562140d0a00b0062617b25583mr2995552qvh.0.1686146174411;
        Wed, 07 Jun 2023 06:56:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5HEDyEyI1XjMl1yL6Vf9kP387Y6xhzYFVTHowmTz0vgcWT3RbgWM1B06oyD5ILkdVw/rYU26DuplYERBf00D8=
X-Received: by 2002:a05:6214:d0a:b0:626:17b2:5583 with SMTP id
 10-20020a0562140d0a00b0062617b25583mr2995538qvh.0.1686146174135; Wed, 07 Jun
 2023 06:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230607053940.39078-10-bagasdotme@gmail.com> <20230607053940.39078-13-bagasdotme@gmail.com>
In-Reply-To: <20230607053940.39078-13-bagasdotme@gmail.com>
From:   Richard Fontana <rfontana@redhat.com>
Date:   Wed, 7 Jun 2023 09:56:03 -0400
Message-ID: <CAC1cPGzZGWxS1qdKZkMuHrCenegje-M0QE0tFG5UotHAjN5vmQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] crypto: drbg: Convert dual BSD 3-Clause/GPL-1.0
 license boilerplate to SPDX identifier
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Linux Crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Stephan Mueller <smueller@chronox.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 1:41=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> Replace the boilerplate with corresponding SPDX tag. Since there is no
> explicit GPL version, assume GPL 1.0+.
>
> Cc: Stephan Mueller <smueller@chronox.de>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  crypto/drbg.c | 33 +--------------------------------
>  1 file changed, 1 insertion(+), 32 deletions(-)
>
> diff --git a/crypto/drbg.c b/crypto/drbg.c
> index ff4ebbc68efab1..f797deaf3952ef 100644
> --- a/crypto/drbg.c
> +++ b/crypto/drbg.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-1.0+
>  /*
>   * DRBG: Deterministic Random Bits Generator
>   *       Based on NIST Recommended DRBG from NIST SP800-90A with the fol=
lowing
> @@ -9,38 +10,6 @@
>   *
>   * Copyright Stephan Mueller <smueller@chronox.de>, 2014
>   *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, and the entire permission notice in its entirety,
> - *    including the disclaimer of warranties.
> - * 2. Redistributions in binary form must reproduce the above copyright
> - *    notice, this list of conditions and the following disclaimer in th=
e
> - *    documentation and/or other materials provided with the distributio=
n.
> - * 3. The name of the author may not be used to endorse or promote
> - *    products derived from this software without specific prior
> - *    written permission.
> - *
> - * ALTERNATIVELY, this product may be distributed under the terms of
> - * the GNU General Public License, in which case the provisions of the G=
PL are
> - * required INSTEAD OF the above restrictions.  (This clause is
> - * necessary due to a potential bad interaction between the GPL and
> - * the restrictions contained in a BSD-style copyright.)
> - *
> - * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> - * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> - * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
> - * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
> - * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> - * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
> - * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> - * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> - * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> - * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
> - * DAMAGE.

The non-GPL portion of this notice does not match BSD-3-Clause as
currently defined by SPDX (see:
https://github.com/spdx/license-list-XML/blob/main/src/BSD-3-Clause.xml).
This is at least the third time in your recent patches that you have
assumed that a non-GPL license matches a particular SPDX identifier
without (apparently) checking.

That's assuming it's appropriate to represent this as a dual license
and omit the 'ALTERNATIVELY' parenthetical. I'm not sure how I feel
about that.

Richard

