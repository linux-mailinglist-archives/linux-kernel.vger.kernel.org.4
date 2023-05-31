Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C936718822
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjEaRKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjEaRKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:10:05 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70112135;
        Wed, 31 May 2023 10:10:04 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba8cd61ee2dso1815361276.1;
        Wed, 31 May 2023 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685553003; x=1688145003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5hNAeMykYH6m+pjlK4ZKQGtK0LDuyxxmWVTG0iy4gk=;
        b=RgBb769DkAHCjoOyku0LjFwuuuVlYaimpuChbm/e6uqQonNgWj6Wkw86cPMdU6eXz3
         IKYl4uH6w2nuanrD3CiroKb7ap7n18bm2RMoeLg/lKSqp/8MdBmzkuXUOIldyx2OkRT3
         ZzxCY3GKi2PQtdVqYrIBrp+fD4+xUvumOR+8v200q+Pmz6dY7YhinaEm8VmIbSzMeb3H
         S0ZI1aUrGebHJfqc29jWbkXjDdoLXBgdVvnvhT1Hd/QL3kg3qRFs8A5YuV4dpOsgxydk
         6tsP9dzvIlUb7JwM8sIneb6X4//FQJ755f8Khi6Ktc4kjIQAgt/l6LC7qbc8+/mXs584
         Hgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685553003; x=1688145003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5hNAeMykYH6m+pjlK4ZKQGtK0LDuyxxmWVTG0iy4gk=;
        b=R36eYezjeLlKLMvrBQGZQEMD+y/cSHl/5Cnoot47kI5bpa3QIxxOYbJTvyschm2XZK
         vtPZBlINl3dhMhkLbQvlVVVsZHLLsxzisLzliDtokBLRPyhnnlz9LMlPWLfQqzS+iaQx
         /qciYJAaDQWV7SmaItmNtQKzs98+ShBW5s7AsVWypxf2pJy7PQkNAG4kOmAoat5EflE3
         ixPhaZC+aUT6Urc8DfxFgxKxJcE1oEPO4Is1aplbqDhcSm6gE3dMAH3W01+RGkguQDIE
         yJEk2TQYTBizLOz78vlkYRS7iEfXLG7SglTEK3wJZkN54UA/xPYtWcZF1ybDMOp7JlTJ
         Ph8A==
X-Gm-Message-State: AC+VfDyTPRttT8shWm6cun4nBbTz1JU3U3oc68Q+fVnAuwjaUPUr2zTs
        d3E2RQajyB86rycF6RddSRsmJMcZlCF0RVWvXvA=
X-Google-Smtp-Source: ACHHUZ6gziPlD75sFBIWzYJKukeguq7CTPeNtKJWb7F/xT/sDpz2WsRUhNOlU+011ytGs8Qg/NrtXYae3YXJc9tUeRs=
X-Received: by 2002:a25:e64f:0:b0:bac:fd8d:94b5 with SMTP id
 d76-20020a25e64f000000b00bacfd8d94b5mr18876773ybh.13.1685553003652; Wed, 31
 May 2023 10:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230503141016.683634-1-aliceryhl@google.com>
In-Reply-To: <20230503141016.683634-1-aliceryhl@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 19:09:52 +0200
Message-ID: <CANiq72k6kSHPNjQr+PEB3KGO05M0mGet5un7jVeNeS_02uEzZQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: str: add conversion from `CStr` to `CString`
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
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

On Wed, May 3, 2023 at 4:10=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> These methods can be used to copy the data in a temporary c string into
> a separate allocation, so that it can be accessed later even if the
> original is deallocated.
>
> The API in this change mirrors the standard library API for the `&str`
> and `String` types. The `ToOwned` trait is not implemented because it
> assumes that allocations are infallible.
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel
