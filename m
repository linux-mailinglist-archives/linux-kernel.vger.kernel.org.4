Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E8D66A6B9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjAMXM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjAMXMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:12:24 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906F552C6A;
        Fri, 13 Jan 2023 15:12:23 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p188so24183675yba.5;
        Fri, 13 Jan 2023 15:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BY609W+RhGncJpLGsLFTmsHR4NCyfTU2HTS8CdOqR80=;
        b=BBLnmu7wTpyRpe1vlSApwJwOufO4BV2eXl8TNYC9oUJBKH082MttNKekZu41Pusf9m
         VmfJY4sr3we8ivvg8AJjtAGHmZCSZXt+BYZFuCNC1/j6iawjyIKQlVvQKKPiGt2F5fRE
         BjTkdPI4pDiWuvuCxVhCQfBOdIgBWJIwLEw/3tRTKIQJJOxLXKmlEBpNBoTQmslLiYrq
         ByKa9bMiyp26P8upBsPMMyrfkeWZDxgpqFaQb1jVNzq6/OLBpMBe33IV8qfcG+PoMtPh
         Ewg377TuvH4xJFzn3ahp+hGywE5Kb1w3ojHCFMZH0ok9JoRTIhKonHFFy2rK8BFCBeLa
         P0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BY609W+RhGncJpLGsLFTmsHR4NCyfTU2HTS8CdOqR80=;
        b=tsfohfGuYSmQr46m22m9dVhu8D/RWCPiZyPcUwrUeXLRkVJLcTkF9I3K39l0Wt031j
         3uMvkJUywBxS5oHR5dlxqWRcbaCqaikSrfvxG4/eGg/RTuZachss0HSP4HAhJQt3v7p+
         Skw4e2lWE4PzremfRHy7NAPbd3N83Qqim5NFoVUliCcSwFJXghBfWgKbU4adGHES077g
         LzEYPoc7eB6eqzYtpEQ5RRvp1JSm2m2O/BaAOcHX5x4WTY9qUJs0aJnTSMA8y4B+mgli
         OqUGFwvFDcBmytN2N4vs459f9TrCvRxTgkx+Wp6gLEAOhVBZD3uV/GsidCF7vaiTDGhl
         P1fw==
X-Gm-Message-State: AFqh2kqHiiKbDs3/jnQDTaX4mZn2+/ppdgW1L17HO3txurA1Q+GDq6eL
        an56WlLsxBs3eFCe0Yiercl2kZku0GxqifEWu44=
X-Google-Smtp-Source: AMrXdXuW5kHqYbDDTnFNIc+bjFmllra2oA7YOJ1yhQkhHBtfR/MKTNzI6i3veu3ZSRaw6B5iXKRb18lX3OuNPu4wyyY=
X-Received: by 2002:a25:7702:0:b0:7b4:bdd7:e631 with SMTP id
 s2-20020a257702000000b007b4bdd7e631mr3698278ybc.507.1673651542817; Fri, 13
 Jan 2023 15:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-4-ojeda@kernel.org>
 <CAK7LNARuGz=oFukWH4g=7zg1EbWP9rxpVXPgPrJBKHzLQW4N1Q@mail.gmail.com>
In-Reply-To: <CAK7LNARuGz=oFukWH4g=7zg1EbWP9rxpVXPgPrJBKHzLQW4N1Q@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 14 Jan 2023 00:12:11 +0100
Message-ID: <CANiq72=Evg9pQLCdtr+kTsr4fEewjKCkBw2dBYTB7WbPVy2wtg@mail.gmail.com>
Subject: Re: [PATCH 4/6] kbuild: rust_is_available: check if the script was
 invoked from Kbuild
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

On Thu, Jan 12, 2023 at 6:29 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I do not like this.
> We do not need to cater to every oddity.
>
> Checking MAKEFLAGS is too much.

I agree we should not attempt to catch every possible mistake in the
script, but there have been several people hitting precisely this case
(the latest is in the linked thread in the commit message), i.e. some
people read the `Makefile` and notice the script invocation, and go
execute it, but they are unlikely to be aware of the target in that
case.

> You can check RUSTC/BINDGEN/CC if you persist in this.

This is fine, and actually we should do it regardless of `MAKEFLAGS`.
I can add it to v2.

However, that does not cover the same thing as `MAKEFLAGS` is trying
to here. The reason is that even if they see e.g. "RUSTC is not set",
they will not know about how to call the script properly, i.e. through
the `Makefile` target.

For `RUSTC` and `BINDGEN`, it does not really matter (and we could
give a default to the variable, since the name rarely would be
different). However, for `CC`, the logic that Kbuild uses is more
complex, so it seems best to me to let Kbuild tell us what the actual
compiler is.

Cheers,
Miguel
