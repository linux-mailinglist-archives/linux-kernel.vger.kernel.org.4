Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AE9718812
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjEaRHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjEaRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:07:50 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00C91AD;
        Wed, 31 May 2023 10:07:46 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bad97da58adso6736455276.1;
        Wed, 31 May 2023 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685552866; x=1688144866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76vg60iW/EsEINmD+Bil9N8BO8s1pVlIY0spf2KHpnw=;
        b=AqFFPdnWQgjfaEVYQJhTRCZLbnnoP1T/OuVLPkM82QjyaLFvqLZkQvnLuFiUKznvbg
         5mnVnDzBYCxL/hKfAytTdiJQOLdEgoCvVB6AsWcKlQhmLeM+4GvfhyiTSKwYPOLeHCCr
         tKsAHo6lumCftCJDl3h3MmoFksS2OV/aCzedbK+fKrjLdgkBktemgwYem72t/j5R6V2U
         dXvny0xVl+mUZs5tJWBoYgmrvu6ydBZH+L8ohdlnNwHbsfpSkJkkjqZOpjXj7C1UA6It
         YihUAZcK76QDC7mPDkjbTJd7R2xdv95bumAe3vbat6Ttu/5QCDTK70W5HCpqe9JAsNCm
         BEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685552866; x=1688144866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76vg60iW/EsEINmD+Bil9N8BO8s1pVlIY0spf2KHpnw=;
        b=lDdTVvoOEbB5VpsQbrhgGsqG2Cvqfj5KUOiDMdy01TjIMHVWvsjmTPmcElblPsuryX
         XYw+nZ1qaxRTk8LIP6fCbF4lZnlIUS6lJZfl9JqNCulnI7xrTVr/tPE0txPaW7l6QYJO
         XxNIY+eN6ZKnvZIg3i1TiAHf9WdALN7SCc3IqyXHu5cTtbQyPoH4BNEiQrwC9H65NdLS
         5XGSjdny0YmP6RADE4fxyZ2wKFkGdyOdTaLQrx7EVu85pRNCZbHh1ye4y+cpy+6br/2j
         ZwHWyweJ2trWvA9Yr0nkBNPtArqXqgjMRu/AtpzHFrAAvj9js0VM7Wh1EqSjn7NkQ9HP
         ns7g==
X-Gm-Message-State: AC+VfDx2/0d4F6ZfpaZbnp1FLV8M0aXATzUqCQa9ybhr/3l6x+YfF+uw
        /pqux/K/4XP+c4ylx5X7dO7bDtJ9GSGwtixXbc4=
X-Google-Smtp-Source: ACHHUZ4uqNma9e3+EYkNu8p5+bzGEjXLgfIeVC5PLIfPRxyx/cw9q8ArFbk7Z8GRYiv9JC2uWP48jpw4dudhtW6vhuA=
X-Received: by 2002:a25:5087:0:b0:ba2:ca56:7206 with SMTP id
 e129-20020a255087000000b00ba2ca567206mr7209029ybb.17.1685552865848; Wed, 31
 May 2023 10:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230424081112.99890-1-benno.lossin@proton.me>
In-Reply-To: <20230424081112.99890-1-benno.lossin@proton.me>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 19:07:34 +0200
Message-ID: <CANiq72=OFioNTZiVR+vBkYs2Xum6Pv14x4kwNDqxJB0utB2dyA@mail.gmail.com>
Subject: Re: [PATCH 1/4] rust: macros: fix usage of `#[allow]` in `quote!`
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
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

On Mon, Apr 24, 2023 at 10:11=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> When using `quote!` as part of an expression that was not the last one
> in a function, the `#[allow(clippy::vec_init_then_push)]` attribute
> would be present on an expression, which is not allowed.
> This patch refactors that part of the macro to use a statement instead.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Series applied to `rust-next` (with the newline added) -- thanks everyone!

Cheers,
Miguel
