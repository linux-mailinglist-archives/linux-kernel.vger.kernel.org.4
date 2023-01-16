Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4741C66B4E3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 01:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjAPADU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 19:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjAPADS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 19:03:18 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CAD3C04;
        Sun, 15 Jan 2023 16:03:16 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id t15so28550879ybq.4;
        Sun, 15 Jan 2023 16:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=utF0T11NIO5fzdSYdTniamVGFsvJmq4s7ZlcItgmdGo=;
        b=pTclYOItmik5tHCwf8CHR9HEI+jxxHl9DpN6G3hseWDVWz0WKC+e5ZjXrboN34vRfX
         33Bav9oBN2rl4ifdPBg9mopNU8+OME5/3vb0EGLRy4hpEnZou3TawUjewrn7VrpwfV2J
         8zmskMMVx/wGqDW8xuV8ZN2/DlU3nNlkcoEtd028kFWatiSJr2nUoPcnzr3dUmbAy7Im
         LsduvSOzVQJoC0UW413NdmK5a5Y6OVmA6G3B8hX79z0EYEtXIJyhHvuZD2ucjwAPqYH2
         4mpDd4N8mFQpWipR19rLRubB60j6njQiMVSDDZ4z7WG5TWm1hOYFmKNloonwJK7x8IUY
         8dIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utF0T11NIO5fzdSYdTniamVGFsvJmq4s7ZlcItgmdGo=;
        b=1ul/SUxbE8GBTR8qXjyKuCwvD1i1V+3gvaF9M4WWhD6jkr70NNk13Bw/k7VvSX0g8f
         ELW7Z8JhDGcHGy24rq8/slwfZaL4+mmUe9E08qKQfy+3xt8q7gShMbeTD8TlB1pHKbXM
         u43J7XD2ztDXTP8YdwdxhmHYAktDqEdld4OoamEHpahezBNSg2ADzAE3ejFRFHaRwO0g
         GHJ02S6Dni72rFkQfeGs2o+GfD7T1m5Q/NzAa7OaJc1meitu1mVavVnJMWhE5rJmH9tc
         uGXHM4VUgsM4ThvAQTIYda4MiTg19QCfI+Vn+aqrYv+cP/YPe7jZQ6ObhvT+16qIFpvc
         FwIA==
X-Gm-Message-State: AFqh2krkQWLW/zNSP9BFaNPfKqo6E71IWrNHxCbKrQ6xuPBeePlWeCQK
        mZ9HS84HLsizn0ARcZeG22aXwOIBG2Y5fxsKRbI=
X-Google-Smtp-Source: AMrXdXsGXvJ6fgLaVz+5qZXQBdJFCTv3K8NVETV+4FyUgyVMQCuNqGCqmRkc0+hweH28ipKE+hbdONR7DsrMxDekZ6E=
X-Received: by 2002:a25:7702:0:b0:7b4:bdd7:e631 with SMTP id
 s2-20020a257702000000b007b4bdd7e631mr4296168ybc.507.1673827395991; Sun, 15
 Jan 2023 16:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20230109204912.539790-1-ojeda@kernel.org>
In-Reply-To: <20230109204912.539790-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 Jan 2023 01:03:05 +0100
Message-ID: <CANiq72k9OP2TTPty2OcC5Od-R3wHsfhnc0BFR_XYjBtC5zf3gA@mail.gmail.com>
Subject: Re: [PATCH] rust: print: avoid evaluating arguments in `pr_*` macros
 in `unsafe` blocks
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        Domen Puncer Kugler <domen.puncerkugler@nccgroup.com>
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

On Mon, Jan 9, 2023 at 9:49 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> At the moment it is possible to perform unsafe operations in
> the arguments of `pr_*` macros since they are evaluated inside
> an `unsafe` block:
>
>     let x = &10u32 as *const u32;
>     pr_info!("{}", *x);
>
> In other words, this is a soundness issue.
>
> Fix it so that it requires an explicit `unsafe` block.
>
> Reported-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reported-by: Domen Puncer Kugler <domen.puncerkugler@nccgroup.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/479
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to rust-fixes, thanks all!

Cheers,
Miguel
