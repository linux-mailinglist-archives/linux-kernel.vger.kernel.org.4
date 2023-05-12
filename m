Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08B67011A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbjELVz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjELVzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:55:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643B7A80
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:55:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so93443526a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683928522; x=1686520522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fiE+4tw4ReS6W3aCfl6G3CwoVaQuhNT/4YECYUltEI=;
        b=OJJr4mO/dcfgE5zhlhhUEXfXNxlmuDngURq/m3HsbWoNM4ajZzUBnlwX2VvgFqtSg2
         rkmDSQ4Se2maurYnI4ymDN541x414zXYSiQuObhmxHDN889MsAD6KGgilyeaeWsyu1ql
         cGjhL5ZIsnvuMiaEn91Xo/0ffWdPrBLHGzOV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683928522; x=1686520522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fiE+4tw4ReS6W3aCfl6G3CwoVaQuhNT/4YECYUltEI=;
        b=l9f48Dwj1faWTvRg+4X7hhnTbS0HkcOD8/amUKlVfJkKfe7yZR7izx56e7V9vS262i
         YfXAtJDl2I9vpGLJCWRTGAMfIhyUtVUXHWtomLlbx5AzYFYWfw+meNUw9ibldtqswmkI
         WXQOso7QMXQ/xk1FKCC3hjtSh6j5F7+qPVrkQGhl3N17eIpOrWcuuCuEMdJ3OBElVYFy
         QPPPDqm0lROZurNFZ898h/uE5e0K87OLN18YGMxvNTidk9zoJymG+I2XbCvTI1Qz1fQO
         takw60eWmfJxz3CAGezsi+00IcH+TqtAGzEpATTA4ULA8QFoTBMuvMtIQ0NaeUo/1GWm
         t5Ig==
X-Gm-Message-State: AC+VfDx7LhFnCreP6n2ZmhrFcq8dvdOY7rll1tkpoj/wgYVZToacY8zv
        LtmQpcjliUQ5y9lLG6P2tOJs6tWZz6yj6S/lFlo=
X-Google-Smtp-Source: ACHHUZ6k+rsmje8WpqSD4OENNzHUK0l4ICMTGi5kj/yw/dIc34EKVAv4s7pF4jjiOLwVu6VaytSvMQ==
X-Received: by 2002:a17:907:9306:b0:932:f88c:c2ff with SMTP id bu6-20020a170907930600b00932f88cc2ffmr23046719ejc.34.1683928521765;
        Fri, 12 May 2023 14:55:21 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id og16-20020a1709071dd000b0096637a19dcasm5944901ejc.4.2023.05.12.14.55.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 14:55:21 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so93443389a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 14:55:20 -0700 (PDT)
X-Received: by 2002:a17:907:9306:b0:932:f88c:c2ff with SMTP id
 bu6-20020a170907930600b00932f88cc2ffmr23046686ejc.34.1683928520392; Fri, 12
 May 2023 14:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
 <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com> <CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com>
 <CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com>
 <4171c4b0-e24b-a7e2-9928-030cc14f1d8d@intel.com> <CAHk-=wiVLvz3RdZiSjLNGKKgR3s-=2goRPnNWg6cbrcwMVvndQ@mail.gmail.com>
 <CAHk-=wg4vpYz+xRtd+PsdmQ9gtNGbXrFKW3ndvXcrLEEDN0hyw@mail.gmail.com> <95c2e669-bce9-3dd5-e197-3faf816c4b45@intel.com>
In-Reply-To: <95c2e669-bce9-3dd5-e197-3faf816c4b45@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 May 2023 16:55:03 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjzEA_TO0wWNir0HzAFJ5_tMoQnrL_-8+igqmCZGVGdcw@mail.gmail.com>
Message-ID: <CAHk-=wjzEA_TO0wWNir0HzAFJ5_tMoQnrL_-8+igqmCZGVGdcw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 12:34=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> Were you really thinking of mm->count=3D=3D1, or did you mean
> mm->mm_users=3D=3D1?

Yeah, I meant mm_users.

And I was thinking that if it is 1, then it is stable - kind of like
how we do our optimization with file descriptors.

But you're right to worry about possibly other users incrementing the
mm_users count somehow - or just using "mmgrab()" to not increment it,
but be able to still fault on it etc.

> There's always a race there because mm->mm_users can always get bumped
> after the fork()er checks it.

Ugh. I was assuming that if they don't already have a reference to the
mm, they can't get one (becasue the '1' comes from 'current->mm', and
nobody else has that mm).

But maybe that's just not true. Looking around, we have things like

        pages->source_mm =3D current->mm;
        mmgrab(pages->source_mm);

that creates a ref to the mm with a grab, and then later it gets used.

So maybe the "no races can happen" is limited to *both* mm_users and
mm_count being 1. What would increment it in that case, when 'current'
is obviously busy forking?

That "both are one" might still be the common case for fork(). Hmm?

                Linus
