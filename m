Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E00766D337
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 00:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbjAPXfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 18:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbjAPXew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:34:52 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963E14EF3;
        Mon, 16 Jan 2023 15:32:12 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id a9so15320807ybb.3;
        Mon, 16 Jan 2023 15:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2eGx37EmHA0N0W9tODp3iY+Jtr51iEGe4dAXEDxPGHg=;
        b=XRlIs7dhg5iCvVEvX8TYR7BIQKWSK4S519EMsig4S5hCPso4dy7drqtAvz6p3eSBk9
         TL9nFCr1BHLTa/c154LoKHJxh3bg+zI74O6EVrr1xoP5MHfNiypcPqxsnhkkbpIrQQuu
         GuWKMCHBBY+Op8eDdAMcV3jZ9tpnlV19zXWNLzGzC2eag5zGIn5UzTLIzWQjAHb/tdvM
         7wxakp2+ndRz65RdQfgyxVWNNJmSobFZOgUKAOcopDU5EfuHSHDddPDacsMHVDQ+zjtT
         uRXhjiCzOw6fHAgZVPkK1SYmMuYnLCvGN2G2NxAQLlTxyju4nGP5M6+7QwQeF08oh2SS
         2Grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eGx37EmHA0N0W9tODp3iY+Jtr51iEGe4dAXEDxPGHg=;
        b=lzxOOobC0PcGkH3//gyBHvUWgbVEoN1yogqG1l1lgA8tu+9dfCwZ2kikry20T+BBMt
         RAlJ7HjnGd4vUGuTNmJ7B6c26UTQNIxAMgg2FOtataFQysNxBfoVxz//CORrp0NxzGnt
         kvxTb+Oig8xjH4EgzDWvWfp+r5IEVtWeHrPEAmK2htrbkYPrmb8aINeF703QQyolE0t8
         khEhPL2Mzt/Mdjdo0fDlV9dbPtrHGxPvxgSLkAS4Tv7ihQCzPn2cMeio8oGFlWIZ/ogq
         NBhq35zE8qpHXnIn8NP8Qis5nrbpeAdWXp8AFBqyT6TZbbRyUK1lnSOCz/vXS/H9gvfr
         VR1Q==
X-Gm-Message-State: AFqh2koKhuVuFtPKpp1BwzHWApwwe+bZwrs24ySNUU3hvYmhyKVb6XY3
        v5x8dGDjsBYlzuJiRyFlhpp69ZewAW4PB4uriZOTsc0PSFkIU6qi
X-Google-Smtp-Source: AMrXdXuE1UAGgnxyZDwm/YOVUXX3/p67x7O3O4eboTy7D5CVHVN0IgALnQIj866+lQInoK43ZnNG9XsjVJ+vYXBy6yU=
X-Received: by 2002:a25:ca51:0:b0:7bf:b130:9e24 with SMTP id
 a78-20020a25ca51000000b007bfb1309e24mr195541ybg.328.1673911931888; Mon, 16
 Jan 2023 15:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20221206010519.39075-1-ojeda@kernel.org>
In-Reply-To: <20221206010519.39075-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 17 Jan 2023 00:32:00 +0100
Message-ID: <CANiq72kTrfYzmgdLjOecsVTQzHdy_ZDaCO2KgbODtHpL0pS7Qw@mail.gmail.com>
Subject: Re: [PATCH v1] rust: alloc: remove the `borrow` module (`ToOwned`, `Cow`)
To:     ojeda@kernel.org
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Josh Triplett <josh@joshtriplett.org>
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

On Tue, Dec 6, 2022 at 2:05 AM <ojeda@kernel.org> wrote:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> The `Cow` type [1] requires that its generic parameter type implements
> the `ToOwned` trait [2], which provides a method to create owned data
> from borrowed data, usually by cloning.
>
> However, it is infallible, and thus in most cases it is not useful for
> the kernel. [3]
>
> Therefore, introduce `cfg(no_borrow)` to remove the `borrow` module
> (which contains `ToOwned` and `Cow`) from `alloc`.
>
> Link: https://doc.rust-lang.org/alloc/borrow/enum.Cow.html [1]
> Link: https://doc.rust-lang.org/alloc/borrow/trait.ToOwned.html [2]
> Link: https://lore.kernel.org/rust-for-linux/20221204103153.117675b1@GaryWorkstation/ [3]
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to rust-next, thanks all!

Cheers,
Miguel
