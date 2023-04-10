Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569366DC307
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 05:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDJDuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 23:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJDuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 23:50:03 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707B5188;
        Sun,  9 Apr 2023 20:50:02 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 72so3585454ybe.6;
        Sun, 09 Apr 2023 20:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681098601; x=1683690601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZzELvV3936iXZzgHBjpzCyX1go0GJ69vN7WBZJ+Bv8=;
        b=oYMStYGmVv3HL4vWXaCMfmE9e0uqk4VH59VWFzrCtXudhoDJbN8PmpWJi5dE1kiA3G
         So1YzteaHFY8FMz7Dsnt5ygflYfEST8dtNOROQMi24j/nKAinlEM+PAdmPiFPC9+Cx/7
         u5q33alY9hBc6JsHCfXzq7EzWgjXS4Q0LPmUd9scNGzID9zc9RzHc4ArrTIAy2H78Ufi
         UB4JHaY3vsc6U9WVMCb7CXm2fn2HtlYT98pj1qhEQ7yWagEtWnqzh6hi2FquRWeh55i6
         h+LD0OkWZ5iwXYjlkOs4tYJWqA9BDK45OTlRYavTOF58xSJhwV/8AvpcRRlAingIFstX
         ZVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681098601; x=1683690601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZzELvV3936iXZzgHBjpzCyX1go0GJ69vN7WBZJ+Bv8=;
        b=ODsC3G7ILVl3Pp7tfzNln1oCOlLl0DECNWop+e/V/Xs8ZRN1k/V1sjBT0gYwbfLHrd
         hzV9aZpaIIKvQT2j4Mvk+kflTCLphgQhRYSDIkiXTISLD8v1iXStWboW9w/va7IUos9s
         1rlh8GSbEiU7MglqWK5KvVQ+R2lwuiZe7lR1X8WGzRNF8IMmo7Sr/Udknu13PF4+cUQr
         CoLFG78IjETa4Qqhetv9Tdanu4mAkp55BFJ7qisuKRQnGXptpS5vHguwSn9/MZ1ZamJL
         87dGjmXgElhUfTASJzbaICjhTi41lBIkiFmLxbf4hMZzMT8b/QXAtumATamV2VrBvtiM
         ghzA==
X-Gm-Message-State: AAQBX9f8TpMTJZLNc5NLJNmfzV9/gn5o+9AUyM4cDr7il6mVws11NaSu
        raVBjRewl7A/2F3aGcEr3zMVj49fovOYal8TJsetCtwqBhE=
X-Google-Smtp-Source: AKy350beTI/QDlgxCjoujRd1i6AdLQRQCrsIL4G8pwbvogSpdTNDF02ae9Ouw6+ToOIU1AJR9Zxn09lripExTPu2FeQ=
X-Received: by 2002:a25:3157:0:b0:b8e:db4a:a366 with SMTP id
 x84-20020a253157000000b00b8edb4aa366mr3084603ybx.11.1681098601651; Sun, 09
 Apr 2023 20:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230224-rust-error-v3-0-03779bddc02b@asahilina.net>
In-Reply-To: <20230224-rust-error-v3-0-03779bddc02b@asahilina.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 10 Apr 2023 05:49:50 +0200
Message-ID: <CANiq72=M6GcMv67GYMCmJ=FUCD03rKSP5en7TfDTFw85qudfRw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] rust: error: Add missing wrappers to convert
 to/from kernel error codes
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 11:48=E2=80=AFAM Asahi Lina <lina@asahilina.net> wro=
te:
>
> Hi everyone!
>
> This series is part of the set of dependencies for the drm/asahi
> Apple M1/M2 GPU driver.
>
> It adds a bunch of missing wrappers in kernel::error, which are useful
> to convert to/from kernel error codes. Since these will be used by many
> abstractions coming up soon, I think it makes sense to merge them as
> soon as possible instead of bundling them with the first user. Hence,
> they have allow() tags to silence dead code warnings. These can be
> removed as soon as the first user is in the kernel crate.
>
> Getting this in first allows the subsequent abstractions to be merged in
> any order, so we don't have to worry about piecewise rebasing and fixing
> conflicts in the Error wrappers. See [1] for a complete tree with the DRM
> abstractions and all other miscellaneous work-in-progress prerequisites
> rebased on top of mainline.
>
> Most of these have been extracted from the rust-for-linux/rust branch,
> with author attribution to the first/primary author and Co-developed-by:
> for everyone else who touched the code.
>
> Attribution changes:
> - One of the patches had Miguel's old email in the tags, updated that per
>   his request.
> - Wedson's email changed from @google.com to @gmail.com (I understand
>   this is the current one).
>
> Sven: There is one patch from you in this series, do you want to send it
> yourself directly? I understand Wedson and Miguel are okay with me
> sending stuff on their behalf.
>
> [1] https://github.com/Rust-for-Linux/linux/pull/969/commits

Added (and then removed in later commits) two `#[allow(dead_code)]`s
as needed to make it compile.

Applied to `rust-next`. Thanks!

Cheers,
Miguel
