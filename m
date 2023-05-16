Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA2705B37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjEPXT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEPXTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:19:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023E476AC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:19:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96b0235c10bso5111966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684279157; x=1686871157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwSoMyRdpmQIpvOJRBbBbU+dtgHHa8BVGaeM9DGLkfs=;
        b=XV8v15tX+PZVEafm8KvnxAaUQqH3DataU3UD+G++s6faFUIzXTXCNUoDb9m0VlfCQI
         eGN4ioACbazld0HLNFuNm7gQ6dbfcNc28blvMdsHDOwxVvOrzgHWkEGRUOtICDGyfGe+
         y+ZburXTEyfHh/B6vgZObfltJUXk86CLrYG7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684279157; x=1686871157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwSoMyRdpmQIpvOJRBbBbU+dtgHHa8BVGaeM9DGLkfs=;
        b=YlKkdhQq+vr33qxx+N/MIMDKEN3zHv49CwrgLEPlkEUbbwXJQGbnpzYH5fZovDXzcl
         k7cV9A51WX3jM5J57w8HK4ILozVerVjJbOUSF8jqge/EerQSuYbelAMfo+uVV1ZOO/GP
         FnW+IkEZ0q4C78XYxfTXCz4g4d2JO//FxVTRth4evLLiLidsm7tIXBqmd1mdATsSNKie
         a1mHMmQRzGaYN5lP6jcuudcU73z6G6GInoJr9ZZi274lDL3plyB7OixJIMjAwG4l0/QD
         NbKlxSovhDMadIUeoXArWHyqOHQrZSQUxFwX5itUrqhxPo3biUAzobOCINw5/rwPWhq1
         1O3Q==
X-Gm-Message-State: AC+VfDyMNijkl6ZWlNoISaqSTunTitMhOAyWNQLJtn8rzZB6RZV+6aAB
        HLh/0HwPbLl8eSIh9OJ2UJejBWDqHpQJfTmThAfC5A==
X-Google-Smtp-Source: ACHHUZ60o1CtsVnga/vSI7yTJ3kCDUwUVrQIAAy42Ge/Z705ttDlWgK2bgIRDUNnWgTaio7HX16Eyg==
X-Received: by 2002:a17:907:7f94:b0:969:e9ec:9a0 with SMTP id qk20-20020a1709077f9400b00969e9ec09a0mr32127707ejc.77.1684279157049;
        Tue, 16 May 2023 16:19:17 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906265300b0096595cc0810sm11536995ejc.72.2023.05.16.16.19.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 16:19:16 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-966287b0f72so7934366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:19:16 -0700 (PDT)
X-Received: by 2002:a17:907:25c1:b0:965:819b:1e73 with SMTP id
 ae1-20020a17090725c100b00965819b1e73mr33977651ejc.59.1684279155930; Tue, 16
 May 2023 16:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230516164947.86543-1-adobriyan@gmail.com> <20230516164947.86543-2-adobriyan@gmail.com>
 <20230516143910.ad39ddb949ca29d3a7cfdba1@linux-foundation.org>
In-Reply-To: <20230516143910.ad39ddb949ca29d3a7cfdba1@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 May 2023 16:18:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizmGie-9SznxRraSEAAQ7OHmyR0y0foWEDF35M7dfJEw@mail.gmail.com>
Message-ID: <CAHk-=wizmGie-9SznxRraSEAAQ7OHmyR0y0foWEDF35M7dfJEw@mail.gmail.com>
Subject: Re: [PATCH 2/3] auto: add "auto" keyword as alias for __auto_type
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
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

On Tue, May 16, 2023 at 2:39=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> It is pretty cool and could get used a lot.  Cc Linus for his thoughts?

I'm not against it, although I'm also not convinced we need / want to
convert existing users of typeof().

The reason we use typeof is that that has always worked in gcc, and
__auto_type is relatively "new" in contrast.

But we require at least gcc-5.1 anyway, so it should be fine.

Note that mindless conversions can be dangerous: using "typeof(x)" in
macros may end up feeling a bit verbose, and "auto" can appear nicer,
but the auto use needs to be *very* careful about integer promotions.

For example, in

  #define WRAPPER(c) do { \
        typeof(c) __c =3D (c);
        ...

it is very obvious what the type is.

But while using

   #define WRAPPER(c) do { \
        auto __c =3D (c);

gives you the same result with less redundancy (no need to state 'c'
twice), if you *ever* then happen to make that an integer expression
that is not *just* 'c' - even a trivial one - suddenly 'var' goes from
'char' to 'int' because of the integer expression.

So __auto_type (and I agree that if we use it, we should probably just
wrap it in an 'auto' #define, since the legacy 'auto' keyword is
useless) can result in simpler and more obvious code, but it can also
lead to subtle type issues that are easy to then overlook.

The above is not an argument against 'auto', but it's one reason I'm
not convinced some mindless "convert existing uses of __typeof__" is a
good idea even if it might make some of them more legible.

But I have nothing against people starting to use it in new code.

And no, I don't think we should do that

    KBUILD_CFLAGS +=3D -Dauto=3D__auto_type

in the Makefile as Alexey suggests.

I think this is a 'compiler_types.h' kind of thing, and goes along
with all the other "simplied syntax" things we do (ie we redefine
'inline', we add "__weak" etc etc etc).

                  Linus
