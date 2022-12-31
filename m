Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759A365A4A9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiLaNe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLaNeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:34:24 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F38FC9;
        Sat, 31 Dec 2022 05:34:23 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-43ea87d0797so330630177b3.5;
        Sat, 31 Dec 2022 05:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OlG2ZWLwbg11x7JqxmIJ3EwjPFABMN8qelHH8mpSWZc=;
        b=cfYlJYBuHpSDOAhy/8zE8zsVlHJeZBQvdMGgSLilSsfqdHmDmRuo5IRnNdWKhthSVZ
         93kPS4nSL+i+ht2tAVBdY49beKm5cIqQIMcGS4pxOUO7k3H9UiQ6pRQkqp5o4LGgkQP7
         zyg45TdoBwwGqNL/qEYI4IjYihrQQ8mvr2RoyL6hWLecnWmI93BNmnZWpoMIGznaWVBE
         G74UF7DULynd028rHwswinaDkTl+z6YmeveQ8z81iIvIRrCOODcc/mwTmaWeUgJOKGeY
         0KHDhyP/H4hVJx7zJsMJcRCOMOx03aC2s9Zhezlx3CpPf4bcb5jTyyoiG2eWyXCIFe9Y
         hWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlG2ZWLwbg11x7JqxmIJ3EwjPFABMN8qelHH8mpSWZc=;
        b=l9tJBRDXxItkh8IRFU4Bkhd8L7ZtA3JYa1cPxubjXiJn2hG/Q9ipEkccmF9wwyvN0b
         APeAOOHBYh/oEHPter8T0DTrsWYc4iPEguWr1gDTOp2xgKzgLR8XGv445Np3eUHWf1hH
         GPOKWsOmOCbUvF/UbIkgLG9oeA+jwhD6E2aOCPPAQRrxExK4mayQGNAhtfzW8QGSs2+/
         NcqTYeZya+pWgABoENimxrgSIhBPl2Soi0ZgYK1YhY5YmvR9+naMZTvXojL53Uq28oW1
         zrP79dpxCicnxB+Ey39FXhy0EvkEQoel6EnL/rcut/JmjycrO+0rLyta7krMNhS8C9hP
         NpoA==
X-Gm-Message-State: AFqh2kpEH6wKBejPQ9A6dS8F8s6LBoDV8Zbg1N9cj6m0VlB4enfXSDwC
        RzOqrTzR7D0TGcSn2y7hqSbzj2AzLjN/1J7NpEg=
X-Google-Smtp-Source: AMrXdXuTGtVzVPnubHM0TtSu1jEEw41VpKdyluBDPas/jnvfbBCV/QMV44rkDFhm0CXUR7AuOEsyjwLk51bvrotnYPI=
X-Received: by 2002:a0d:ea54:0:b0:483:813:c70f with SMTP id
 t81-20020a0dea54000000b004830813c70fmr2048084ywe.266.1672493662289; Sat, 31
 Dec 2022 05:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20221231064203.1623793-1-masahiroy@kernel.org>
In-Reply-To: <20221231064203.1623793-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 31 Dec 2022 14:34:11 +0100
Message-ID: <CANiq72m5E1MehfqdrkmJt43fAzUMc9kEKu7x4WaALdgDGJ30-g@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: fix dep-file processing for rust
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        llvm@lists.linux.dev, rust-for-linux@vger.kernel.org
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

On Sat, Dec 31, 2022 at 7:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Masahiro Yamada (6):
>   kbuild: specify output names separately for each emission type from
>     rustc
>   fixdep: parse Makefile more correctly to handle comments etc.
>   kbuild: remove sed commands after rustc rules
>   fixdep: refactor hash table lookup
>   fixdep: avoid parsing the same file over again
>   fixdep: do not parse *.so, *.rmeta, *.rlib

These cleanups are great, and it is a pleasure to see proper
integration with `fixdep` -- thanks a ton! :)

Will you want to take them through the kbuild tree? (I guess so, given
the bulk of it is on `fixdep`)

Cheers,
Miguel
