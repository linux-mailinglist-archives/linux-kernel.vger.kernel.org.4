Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814DB71881D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEaRJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjEaRJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:09:28 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AB213D;
        Wed, 31 May 2023 10:09:25 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565aa2cc428so51898337b3.1;
        Wed, 31 May 2023 10:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685552964; x=1688144964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqDH4yuf9riVSA5V9W66V8AzL16NatN+7DvngwJVYHQ=;
        b=caLGCJsLWoGXEsdVIpGLUQt+zeJNOVI+LboWHPMIqBJWAnIgJ+242auCr4nUiBn5Mk
         hBnHQEitvKnQqFL7tBD57Xzc92LoREi2W2dR4C9s13QGZFqO520W4FweLarNlIDsUoTM
         p2zOOCZowyHijyUm0/VLa6QGp6JAMH8wfdoEKVdVVNMj42qxckZh/zr1oNhzYTXBn5cd
         67OcyM5lpazmLs8sZawR0AQvVA2c+LPakLZ3RlpDosOT9Y1dNwB2rm4dI/2sxnRirlSX
         MY5FdLAsdIEzXF38+2el4+6sXBSAQtN4Ojvd6vUtxr54YVSybND6VdspTprwDnNqvIqq
         wZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685552964; x=1688144964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqDH4yuf9riVSA5V9W66V8AzL16NatN+7DvngwJVYHQ=;
        b=ChtSxDu5hq48t9ruSB2/EgbNFGMteoHoiweVO1QRvtMybNvoc1Dy2l5Gwl1B8GE+QN
         STvGYP6ebMKWOw+r+GUvo0NR5WgqTWSefY80LNBBpkDcMmj+sHq+Qnjg/lF2BdaSSkb4
         xlEkZYWgrsSSRYAeiL3gY7QGRiW05ikSYKzARnV36IwwF2Mukl+cGt9ngXzQfG4ZNqGT
         NwjM2Y8nK9GePNI0v6g6DSi5OOGl6RbDzoJ3rNS4hWB/4lSLfNfm8HE2MwnPJIiw75jr
         Uu1OikCr44j8Vba+OLnNNCJu1M1FilyfiGqV0ibv7if69m1E7rKr3UyZIc0LEdUYivjw
         DbfQ==
X-Gm-Message-State: AC+VfDxG0kF9Rdq6Bok8eyLHKC0LlkqhkT3RuvlMf4SoAlASqa2p9ora
        N9in12MIcS8/Rvl6PV8CihT8j6R24j/oyCnARtQ=
X-Google-Smtp-Source: ACHHUZ6YRP+7GOjalS/xwoylUY0eFkX8MPFV32qCf9SvGRbSl26p2DWv6GCFWqaC5hFnT6ZojaI6Kh3uKPqGow4WfEI=
X-Received: by 2002:a25:f80e:0:b0:bac:f582:eefd with SMTP id
 u14-20020a25f80e000000b00bacf582eefdmr6912007ybd.35.1685552964512; Wed, 31
 May 2023 10:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230502124015.356001-1-aliceryhl@google.com>
In-Reply-To: <20230502124015.356001-1-aliceryhl@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 19:09:13 +0200
Message-ID: <CANiq72=zXOqvdttGjxGrbGoNvyz=QNb5sCE1FKROgKo5yEkfBQ@mail.gmail.com>
Subject: Re: [PATCH] rust: error: allow specifying error type on `Result`
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
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

On Tue, May 2, 2023 at 2:40=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Currently, if the `kernel::error::Result` type is in scope (which is
> often is, since it's in the kernel's prelude), you cannot write
> `Result<T, SomeOtherErrorType>` when you want to use a different error
> type than `kernel::error::Error`.
>
> To solve this we change the error type from being hard-coded to just
> being a default generic parameter. This still lets you write `Result<T>`
> when you just want to use the `Error` error type, but also lets you
> write `Result<T, SomeOtherErrorType>` when necessary.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel
