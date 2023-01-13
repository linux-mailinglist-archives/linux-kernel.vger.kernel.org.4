Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDFF66A6D7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjAMXQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjAMXPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:15:37 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A22A78147;
        Fri, 13 Jan 2023 15:15:32 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4d59d518505so136375177b3.1;
        Fri, 13 Jan 2023 15:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ciy0ZWTd3lGR7fuS0JZR+cGtHCn30vXUtznCeqNuNtU=;
        b=P76dLekgwuMNxZPfxLDlCyL/lIIgZNjPmY8vqWnk0vw6tZRka1mEs/c8B0YbZ+vj4F
         TX5TiAAk93fQN3ebB++KENBioubOoKCEL3JihUsWc0QTwmYXioEV9h1tG67Ar3kjujNv
         Z/pIsqffFrsiSAswGddq5zo3MnHmlc4eXhaR2XkmKXUPMKeMhntx9MQ3yWXu2TGjPVI/
         7ahQSi7qmjq0c6FGW08WYmBTg15PzLqT9bk41vHUAuYM1moOM9f3s2ZKLABOaCn+5bEb
         bl7hhVRapNCFqtfbS25qUZcHq0nVJucpG0Gus9ivCPuJt3gmC3AZkJQw8ii+LiMD1Gt2
         Ef8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ciy0ZWTd3lGR7fuS0JZR+cGtHCn30vXUtznCeqNuNtU=;
        b=FVEovS7/5NRAXv9LklDo81nWNL0Pi24/snHm7HZT+pIqICOSj7MwSLbPLLNZzLRkAG
         Koa7VQ1k7rKY+/mY4h1a4cp+Z+PnmhOlQBFsKaGcSOvxjoavsT+XOKOPQTCX83JyFDmM
         qTKeHaSSj3xfyxnZ+Ea7GuIcyWB0vT5PAHNdQ3O+Iqwl15oSQ+Ga5qa+ofWANL/tBaEU
         flxCwWctsuRMXVKFJWmQblDQpQp5sD2XrJJ4jKu1h1W4HFbJYMk2HQ9RNdfNBNYUtPOn
         +N992iWar3YybNXgy3YLY0EH0SztTYBD1C1XRbR7j/51qIlJsybyugSt/OeQ93umJdxf
         LM+Q==
X-Gm-Message-State: AFqh2kqk5qm83iDOo4Koymkkb1xP4U3V8NpdVhu/UIIPru/IBjVFKW3s
        XXdb/ipM4YuCLorEUna8z8u0QVau7NhsqVA+vnI=
X-Google-Smtp-Source: AMrXdXum1Gc10mvDU+me61PfBaM5bpzVPQ2VyOympq/MwbmX4aEfLhJswzFyNI8ktuxhCAO0/ad2BGCOH77e+aAW7c0=
X-Received: by 2002:a05:690c:dc3:b0:4db:3ac0:78a3 with SMTP id
 db3-20020a05690c0dc300b004db3ac078a3mr941595ywb.266.1673651731430; Fri, 13
 Jan 2023 15:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-6-ojeda@kernel.org>
 <CAK7LNAQYk6s11MASRHW6oxtkqF00EJVqhHOP=5rynWt-QDUsXw@mail.gmail.com>
In-Reply-To: <CAK7LNAQYk6s11MASRHW6oxtkqF00EJVqhHOP=5rynWt-QDUsXw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 14 Jan 2023 00:15:20 +0100
Message-ID: <CANiq72kyUr9PGYqHTsNzYn0_cyuYA0vAxHLC08ivxKo5XvOESg@mail.gmail.com>
Subject: Re: [PATCH 6/6] kbuild: rust_is_available: normalize version matching
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
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

On Thu, Jan 12, 2023 at 7:23 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Maybe, your purpose is to use sed consistently, but
> perhaps you can avoid forking sed if you know the
> format of the first line.

The most unknown format would be the one of the libclang check, where
there may be other lines before the one we are interested in. However,
the pattern expansion would still match newlines, right?

> BTW, what is missing here is, you do not check if
> ${RUSTC} is really rustc.
>
> I can fool this script to print
> "arithmetic expression: expecting primary: "100000 *  + 100 *  + "

We can test if nothing was printed by `sed` for that (or do it with
shell builtins).

Having said that, I would say fooling the script on purpose is an more
of an oddity compared to the case `MAKEFLAGS` attempts to cover
(please see my reply on the other patch). So if we cover this, then I
would say we should really cover the other one.

Cheers,
Miguel
