Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF016732445
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 02:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjFPAbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 20:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFPAbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 20:31:06 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93934294D;
        Thu, 15 Jun 2023 17:31:01 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bc405d9682cso102105276.0;
        Thu, 15 Jun 2023 17:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686875461; x=1689467461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYppjytCFIr8b6N24PrdO/vwx52yFU4wiVFPzdB6o/w=;
        b=EeqE/CoN2E30JfaUsBhHUZOFslau4cVO2/iBL5J0/7AGbMrgi0haWK3ojJUlNRhBQu
         WN7YCeFgrBZY1onVUqhUglKRKfJDm44fWF1p8OG9zfhxqFyHaQKueFzZRtiahOllRhYb
         B5IJ60EztBTVUxj4q10/4T/+2TW0tLMMGRCgT6zh+Thb3uCipyFqiNSk+2e1Y2FXYOBm
         Chwh2CyI7jl8+01ITrGWBiWKvwqS7E6O2yQq2zpcfmwFgeaSbDwLB/4jqtv3Bx1yzxzd
         9U9FlWL8wgsXKZBeOkHN5VS6fkxbZtllMsKUo7Fl1pbxgd+f9SbCzEnwSBNXx10fbc7j
         z74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686875461; x=1689467461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYppjytCFIr8b6N24PrdO/vwx52yFU4wiVFPzdB6o/w=;
        b=Rkee3+GUMdADPSN76uoYjmedRQN0qoPAJQ6niQWm9zOMCpSuA6HFt9LrZNpo1hc60o
         7trCRLa2nyNpliWMuMLS63CIldn5bxiMWLFROJ/PyJ5BwfkAORunNQ92dRl2bc1urBNt
         sPBmUm/K1yTDxN8eChnmPdbaiZcGI4xFyNI+qfgX43e1mfHwGV0qXIY/RrZiY6HebnNM
         x8r96k7DupqpVIBLWLZSrm8eQqSYLzvg9v2BPkHcK6bCXNxBcqgAN0NQOyRup2VohRIw
         RbRXVty3KJCzQ5a2w5QNYN6IU8Df4hZHrOhDqWxE3dHEyq8eW80W91cNZg7+9Dv6baA9
         7yyg==
X-Gm-Message-State: AC+VfDxGExvG9Rh4RuBM4xaFAdY2YVFTofs4+vYj5Wo/Oan0MAD3RqcV
        8EDeUAMs1sHqjqbf/SwK8sc8XAFzax9HGvYuJp043AwNRRQ=
X-Google-Smtp-Source: ACHHUZ6me3DutGktFufi6C4IhFzVFXSoM4Q3B7EWRJ6iJPtHftHM2HtFPlIExlo6yy+DskRRBQiy1nyVPPwnK/3Z9/k=
X-Received: by 2002:a0d:e242:0:b0:568:8b24:fd5f with SMTP id
 l63-20020a0de242000000b005688b24fd5fmr380613ywe.7.1686875460787; Thu, 15 Jun
 2023 17:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230528131802.6390-1-ethan.twardy@gmail.com> <20230528131802.6390-2-ethan.twardy@gmail.com>
In-Reply-To: <20230528131802.6390-2-ethan.twardy@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Jun 2023 02:30:49 +0200
Message-ID: <CANiq72ng7Ss=s36EXZyG+nx+DRd=XNM+ZU6kPmY00LKaXsjjSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] scripts/rust_is_available: Fix clang version check
To:     "Ethan D. Twardy" <ethan.twardy@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Tiago Lam <tiagolam@gmail.com>,
        Kees Cook <keescook@chromium.org>, Finn Behrens <me@kloenk.de>,
        "open list:RUST" <rust-for-linux@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 3:21=E2=80=AFPM Ethan D. Twardy <ethan.twardy@gmail=
.com> wrote:
>
> During out-of-tree builds where the path to the kernel source tree
> contains a version string, scripts/rust_is_available.sh incorrectly
> identified the version string of libclang to be the version string in
> the kernel sources path, resulting in CONFIG_RUST_IS_AVAILABLE
> erroneously set to 'n'.
>
> This issue was previously affecting builds on distributions, such as
> Gentoo Linux, where the kernel source tree is under version control,
> and placed under a path containing the current kernel version string
> in /usr/src.
>
> The fix is to take special care to match only the version string
> following the string 'clang version' in the output.
>
> To reproduce:
>
>   $ cd ~/build && make -C ~/linux-6.2.0 O=3D$PWD LLVM=3D1 rustavailable
>   [...]
>   *** libclang (used by the Rust bindings generator 'bindgen') is too old=
.
>   ***   Your version:    6.2.0
>   ***   Minimum version: 11.0.0
>   [...]
>
> Fixes: 78521f3399ab ("scripts: add `rust_is_available.sh`")
> Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>

Thanks a lot for this patch! This was previously reported and should
be fixed in this patch series (I added you as a reporter in v2):

    https://lore.kernel.org/rust-for-linux/20230616001631.463536-1-ojeda@ke=
rnel.org/

If you could please test the series, to make sure it solves your
issue, it would be great!

Cheers,
Miguel
