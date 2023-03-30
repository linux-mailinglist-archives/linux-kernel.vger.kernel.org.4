Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C376D107D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjC3VFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjC3VE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:04:59 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F78D51E;
        Thu, 30 Mar 2023 14:04:58 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id cf7so25239456ybb.5;
        Thu, 30 Mar 2023 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680210297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VAVdnEyhBX67rGN9GmJ10KCD1xhjSGMvFHdAmoei0kE=;
        b=ji21yy6iIwZ6mLctHKNw0WVWnp80uefwFMB3pAqdOaeyJVs1cnDTdy0Y2yPA9P0wJj
         dTRsg9L527yxqWs0oL8BPhBZ3qJ5D89thjaWd9PgK4xoOqO36f4MZMgEPtBtlythhNtF
         GwYkRSZWM7O6dWxJakr9nhU0CMApXpV9cXVPdxNKk5agv9bz4slcq1l6ABTq34wqv1SK
         c4rbkOlsYuHMgRILFc1JpMjYdB4iUG4+S9xgQA6B2eCJ1qgd4tGi8ZxyUP+JhGV+Z0Al
         Q4k7EBbkP+eTNAjb4POe/H510aFnZeq5cK0ROkl5PZYbHeHueMS0txxQKTdYO8fsP11n
         i/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680210297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAVdnEyhBX67rGN9GmJ10KCD1xhjSGMvFHdAmoei0kE=;
        b=RCzgV4ymty34psqb6Yl6OXpzCdOMrSzyTJMjxZ261xJRjlw290U/fsPemkPj31SzIq
         j3SrbIavRZs0ehXT2cz7j0D7yIgfrx6xI5WherPgKJ6MJqeOh+DX50v9F1VvmHaAxDtx
         z7YSY5+xku+/FcfDoUe81RF/ufp943pOP4TXNrkwdGVHF9ORWnsd+sIv5765QjnQk1X6
         D1Wc6kC51SZ3ZKxO+BiONhTImztEnbkSS1mIU2fLKIssoUoEpHgjFDEGAy+tM6xtqxED
         m+rQ+lvMLeUKpe4UUHuktqYQlvmklZjp5S0WCU8iySLrsjyTp7wOvl/yDK7ra+woggDI
         fflA==
X-Gm-Message-State: AAQBX9e0W1TX9ZfMGhFt2KTV5Kdn2K1KiLWPQOmVGGurkAIEsxv1A4Et
        q28RXWQkTKp5H2vmErBPs8Db6aYYeWXIPiDU2G4=
X-Google-Smtp-Source: AKy350bIf64moUuEFjVkY4AP549wMMkFtIk23Xy2jMIC3JnVfmBHKLAwX/3amOJItj++ig1NJ30xI/9WU624TfYizT8=
X-Received: by 2002:a25:2d7:0:b0:997:c919:4484 with SMTP id
 206-20020a2502d7000000b00997c9194484mr13191255ybc.6.1680210297368; Thu, 30
 Mar 2023 14:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230330043954.562237-1-wedsonaf@gmail.com> <20230330043954.562237-13-wedsonaf@gmail.com>
 <04034640-2d89-dd63-07e5-29fa612aa458@protonmail.com> <06a7c5e7-fc5f-3860-7f17-7f3609de669a@protonmail.com>
In-Reply-To: <06a7c5e7-fc5f-3860-7f17-7f3609de669a@protonmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Thu, 30 Mar 2023 18:04:48 -0300
Message-ID: <CANeycqotBmHkXAFbibp3BerEt=RA6sse+dgAkmpcy+oFMiA-vA@mail.gmail.com>
Subject: Re: [PATCH 13/13] rust: sync: introduce `LockedBy`
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023 at 08:45, Benno Lossin <y86-dev@protonmail.com> wrote:
>
> On 30.03.23 13:28, Benno Lossin wrote:
>      struct Outer {
>          mtx1: Mutex<()>,
>          mtx2: Mutex<()>,
>          inners: Vec<Inner>,
>      }
>
>      struct Inner {
>          count: LockedBy<usize, ()>,
>      }
>
>      fn new_inner(outer: &Outer) -> Inner {
>          Inner { count: LockedBy::new(&outer.mtx1, 0) }
>      }
>
>      fn evil(outer: &Outer) {
>          let inner = outer.inners.get(0).unwrap();
>          let mut guard1 = outer.mtx1.lock();
>          let mut guard2 = outer.mtx2.lock();
>         // The pointee of `guard1` and `guard2` have the same address.
>          let ref1 = inner.count.access_mut(&mut *guard1);
>          let ref2 = inner.count.access_mut(&mut *guard2);
>          mem::swap(ref1, ref2);
>      }

This doesn't reproduce the issue because `mtx2` itself is not a ZST
(it contains a `struct mutex` before the data it protects).

Something like the following should reproduce it though:

    struct Outer {
         mtx1: Mutex<()>,
         zst: (),
     }

     fn evil(outer: &Outer) {
         let lb = LockedBy::new(&outer.mtx1, 0u8);
         let value = lb.access(&outer.zst);
         // Accessing "value" without holding `mtx1`.
         pr_info!("{}", *value);
     }
