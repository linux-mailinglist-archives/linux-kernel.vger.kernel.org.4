Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E1972D501
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbjFLXgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjFLXgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:36:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08F710B;
        Mon, 12 Jun 2023 16:36:19 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bcd6c9948ebso1021916276.1;
        Mon, 12 Jun 2023 16:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686612979; x=1689204979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Uivj7/Q9yql/xb9uKNQvnL3YGWrQU/+WuXKXtQJByY=;
        b=eXCH40sdXoq5OtFW5Wc7capgAZvIj6/HX5LXYosL5HGQloCoZh+N+ZyRCgWqULbQH4
         R1glfSo0owUEDeOnlYYwNuBdGQiOhISlWhMXgQlRbw/MbXWMX3CrdNqVurd0m7EfOVdA
         qzom7zN7kpS/iPmG3LQfkTQY6rV+SsRd8CCVPxjIawjJar0oZIVfnib/MAcqS+GZuEjf
         wE/DhBMulPSc2ySu8SMLpF2uq0IdAJU4OiK3K+cDAytsefbELr4HFxd5SLl7PDZ6nhM8
         JOjOylyT+BJHQdcVwqiZD0WmkqT7SBi4yWjgGhWl3PJmFZOuQrQ1uO+069gIUdkMCjVT
         zumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686612979; x=1689204979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Uivj7/Q9yql/xb9uKNQvnL3YGWrQU/+WuXKXtQJByY=;
        b=gprVfmNNAPXL++COB2VwaA1Fw+tjUen0wsx4nS+3QggvXEiGujwOTyEXi2zety+xGP
         aI4pV+s8Vgf/TUG5/Z/viG475JwtjhIIMqElojrQlpkoQ/+pFaUfcO9QHMt+/nI7Ksev
         b/rItxRGPFQA6AfFDsC4JZPwVCvfjywvHmkNZzO5AXjSwuEz7mZV6xpWtbugPtlvfGyp
         AoW3UyeAKSRTOhRp6WNThzb371N3LrCOOKEKFVS7rvEGgp2GfTIo8nNdO6CAHcTUXp6L
         6CsAuybgsCrZo7Y+mbMFmzlt53l9Kzgl6Pu8utGMLiDFlCn1CpiKZUWns6m7ZFug5ms6
         PMKQ==
X-Gm-Message-State: AC+VfDwr9h1J5rcohR6lEOArmTXkWbVMfFmfap56ILJENidmZX7EOM+Q
        oAAjAGkOEof0g18fDQFmUW7sdy46cllpb3uRJg0Z3W7/pGw=
X-Google-Smtp-Source: ACHHUZ7FHp11Pap/dBpkC6coJLr9NQfk/SiiHMoYewbngISWHMgFGtI9hTpiNtlAQ8aSMRh7mCvY7RpVQCY78QEHfrA=
X-Received: by 2002:a5b:a4f:0:b0:bc5:4f79:a7c5 with SMTP id
 z15-20020a5b0a4f000000b00bc54f79a7c5mr134129ybq.26.1686612978754; Mon, 12 Jun
 2023 16:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230531174450.3733220-1-aliceryhl@google.com>
 <CAGngYiW_3HfebWZO5S=RXFqhNnsbnix-NaA0UGYRnRLd4SK65w@mail.gmail.com> <CANiq72=DJBW82L44icrrTo=_jrv=BS3cd10s6WuraXX7suW4tg@mail.gmail.com>
In-Reply-To: <CANiq72=DJBW82L44icrrTo=_jrv=BS3cd10s6WuraXX7suW4tg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 13 Jun 2023 01:36:07 +0200
Message-ID: <CANiq72nUkuQ+Bpi6+UE6hMwtngs=yiZcH826mt-wox=7Nq9wWw@mail.gmail.com>
Subject: Re: [PATCH v1] rust: error: integrate Rust error type with `errname`
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
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

On Mon, Jun 12, 2023 at 9:04=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Applied to `rust-next` -- reworded for clarity. Thanks!

When working on the KUnit changes that require this, I noticed this
didn't include the `CONFIG_SYMBOLIC_ERRNAME=3Dn` support we originally
had on the `rust` branch.

So I added the `errname` helper and force-pushed.

Cheers,
Miguel
