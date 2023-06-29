Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D20741F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 06:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjF2EgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 00:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjF2EgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 00:36:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E0210B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 21:36:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51d93425853so256538a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 21:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688013368; x=1690605368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ikys1zr7cMawvGGeYC9ud7X4b6QEolSbsQLEDLa8S8I=;
        b=H/Ioj9zyb7N6M+bHh1K4prVO+Uw/XsagqtsSeU0cg3/a6/Trk+iGHIt6DvHsAYjynF
         312OYjsMirspcGPcAvO9ZNxZPqs2m8oUb8I/m7Uk/dy+1utqI+O6N0RXkzq7qr9kPmoo
         zewxoY3xaAEokQ02S4VrYKD6bey2z+qGQEdYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688013368; x=1690605368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikys1zr7cMawvGGeYC9ud7X4b6QEolSbsQLEDLa8S8I=;
        b=QmTXqJpzDYBQKJsm87gVUwxA18SI1ebAUToMEwef4a5ZhjVcv9+xC3ssgll9K+Azg2
         tC7yG21n9q1jsWWTyyLjJHr1XAvH1nzNrLUFV6VbIPkwUwJaVaszHDDFoxYkiYQiEhXZ
         UYqb07xZ4mBZz21iQz/Tb3aFy8la4PGMsJj4nnW2pfXZmPhjAE62FpL4BXHepi+KKhiE
         HAQyWPHBjK5UMhxGgv8KjMiuaJSzvJ36gJp7rJwPF6leoVt50Ad0WKh1ufvjVNdlApv2
         PJBkx3rsdZLeF5dgKRU0HzS1ZlOTGBb7D3U36EM6EcTGFzITV/vrPunPM+pW81VTN0lx
         PiTg==
X-Gm-Message-State: AC+VfDz4wuxNMoL3WEII33ovbtCyU7m+r/D1fMNKf/7p0/3BUXmdIO/e
        cSMkSY2aDXB6NUHF5iELODV7Bq/BeMQKk6W+jTGXS0r5
X-Google-Smtp-Source: ACHHUZ6byGMKy8+Y0uyHYL5HNiwSOIzMIfxrXycZU4veQ618VIDmxflJlL1z+aWdrhafPAqlCNWelQ==
X-Received: by 2002:a05:6402:12c6:b0:51d:8ab1:5df4 with SMTP id k6-20020a05640212c600b0051d8ab15df4mr8015504edx.21.1688013368605;
        Wed, 28 Jun 2023 21:36:08 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id o7-20020aa7dd47000000b0051bf57aa0c6sm5380389edw.87.2023.06.28.21.36.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 21:36:07 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51d88f1c476so264771a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 21:36:06 -0700 (PDT)
X-Received: by 2002:aa7:d48f:0:b0:51d:a02d:f8fe with SMTP id
 b15-20020aa7d48f000000b0051da02df8femr6243450edr.29.1688013366534; Wed, 28
 Jun 2023 21:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whXn0YTojV=+J8B-r8KLvNtqc2JtCa4a_bdhf+=GN5OOw@mail.gmail.com>
 <202306282038.C3A12326A@keescook>
In-Reply-To: <202306282038.C3A12326A@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 21:35:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbbFHUF44At4YYOB9ZWg00rhFmyArD+KocXDX-+-8a1Q@mail.gmail.com>
Message-ID: <CAHk-=whbbFHUF44At4YYOB9ZWg00rhFmyArD+KocXDX-+-8a1Q@mail.gmail.com>
Subject: Re: Build error in crypto/marvell/cesa/cipher.c
To:     Kees Cook <keescook@chromium.org>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 20:48, Kees Cook <keescook@chromium.org> wrote:
>
> The unexpected bit is that without -fstrict-flex-arrays=3 (i.e. the
> default since the dawn of time), the compiler treats any array that
> happens to be the last struct member as a flexible array.

Oh. Ok, that explains why it's showing up for me now, at least. It's
an odd rule, but I can see why people would have done that.

I've only seen the zero- and one-sized arrays commonly used for the
traditional "fake flex array", but I guess other sizes can easily
happen.

                 Linus
