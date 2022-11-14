Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A56628671
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiKNRCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiKNRCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:02:08 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8EF32061
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:01:22 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id b131so13485134yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MJESMyQuA0vUoDJ+3W7NryXxAelgBmnrtfU7OLazAI4=;
        b=Z2LZSIvg3dPD3623GIVeFDIFg0YEgOCiMx/WnpO4MuRFNwy7DAH2Mn0aqV9kPSBahq
         VyIcxfqQHBdwThhe5oT7gsnYWS6XXZWFmln9xmA56F2ycm+m7QYb96otlDZT1wVQxvNy
         oGZeDIQqioSERHPEAVKNdrNfYIrpvO/E0Z+rMYrlJj49F8Uimo9e1EUXARVtAo1x+L4z
         c7uGvQJo/hhrChlTjW2Q7urOao0zTjHG1PFCrcuPgVr4b/PRL2uSbeya9O/UCE+xzQtm
         sbYcAimvpeWYReqnIM4d9L/QEiOPIGBtEE2g2hZ2FL8j5xZe1jzMhh0u5NiEwtH7QHSM
         cSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJESMyQuA0vUoDJ+3W7NryXxAelgBmnrtfU7OLazAI4=;
        b=iLwO9TKvtUv7OarLKQkFMjKjuknmqXWDNpL5eBhEh2JLPCnJi0D0pYeTr24Z+S3dOg
         +8q2hqHx4Nv6hu6CQnpDU5Pc24CHpN/vXJ9ddapuhj/2fVn3e6hmMg1Q+mP1XIV2FqFJ
         4ASqs2F6ywiQJR0qUAzIqYGKrO8geC5QFsm76IdmjovpSgfNdz7Ka7TaRvfGJrfaQYB3
         psD12SMbyGhTlsidIz71IE8sPafzxBLpx9Ru+KEByRpwvXbeS4I/VVVgdYgQ7Os5s4ZF
         Bk33X/ywPcBHKZApT6HqZ8UC3/qw1Y73fvKMnfAzPHxNl/daSH4p3O3iytPCIoKzevF1
         nU6w==
X-Gm-Message-State: ANoB5pn6CbI0e+Aso1mt5NHb+HM/sM1x6dge9lOtBBJUB6t3whjfn/Lc
        IA+5cenFn53uwluq7I8/fQLR0OzaXcF/Tin1LAc=
X-Google-Smtp-Source: AA0mqf6Ye+t5Dvd+X7n7eEFsve6okwlaJ2BCfgjIo60QDU4qMi7BpGAE6eK/XdhSLUipCCakAjdqMzumXbmH6qkMGrY=
X-Received: by 2002:a25:8503:0:b0:6be:9368:4bcd with SMTP id
 w3-20020a258503000000b006be93684bcdmr13042662ybk.632.1668445281712; Mon, 14
 Nov 2022 09:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20221114114344.18650-1-jirislaby@kernel.org> <20221114114344.18650-38-jirislaby@kernel.org>
In-Reply-To: <20221114114344.18650-38-jirislaby@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 14 Nov 2022 18:01:10 +0100
Message-ID: <CANiq72nWnFpC5JWv7Z1Fmg9vLoQoMbGG+wwFJm0GW81Pw0Me2w@mail.gmail.com>
Subject: Re: [PATCH 37/46] Compiler attributes, lto: disable __flatten with LTO
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:45 PM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> +#ifndef CONFIG_LTO_GCC
>  # define __flatten                     __attribute__((flatten))
> +#else
> +/* Causes very large memory use with gcc in LTO mode */
> +# define __flatten
> +#endif

Currently, this header avoids attributes that depend on configuration
options on purpose (see the comment at the top), so it would be best
to move it elsewhere, e.g. `compiler_types.h`.

Though I feel bad about having to move this attribute out since it is
just that config option compared to other more involved bits in
`compiler_types.h`... :(

Cheers,
Miguel
