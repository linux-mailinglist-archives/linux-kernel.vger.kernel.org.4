Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8138664359B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 21:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiLEU0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 15:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiLEU0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 15:26:40 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8F623EB5;
        Mon,  5 Dec 2022 12:26:39 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3cbdd6c00adso130376867b3.11;
        Mon, 05 Dec 2022 12:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/V+XRoAAVDbwLDUpAasAbDvgW2Q/zSZS6Pet2wCkVA=;
        b=IY/SmLYZWSJ+91/upBIDr1pKJMf7Z4P+sR1Tpul99Hp+qDpRRvgF8EXzNHpNtk/Hmg
         elvfnJPZKU2ddPZHscRQ9IJgXH8DTny6oA9He/t6BbdkC7HhfegnwrDJAO5FiC1yRth3
         IsDU4Wh456tiaBSFYyjj0piVFg5GYGKDhi/D2cfMrD9zlmjKbpC0yGN9QuzIHUhTkNO8
         0US0SXzblprJovU4cnXMmdiCIaQ/3PkX8valAswoURyrIBPQ0kWGLZHRLRuX69PJERVM
         VWkcbuc1A9HyM832YTPLtZo8kfgUuz2tTWTLrHVt8gmNJkIu5WYv8vH3lPW8kngtVkY0
         6RjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/V+XRoAAVDbwLDUpAasAbDvgW2Q/zSZS6Pet2wCkVA=;
        b=beCb+akyAGLiPiARzprUF8PY/5hEC2dy7Zv5XvtHqp3KtfRccvi4lwwJiurnb7PRlz
         Q91ho+sw80LCgZj1x+A+7KG/sVE7yk4dPtF+uB/1rK1V8pzYoehQjjLF3fhvqTpZuBJD
         VL4aJi0EHq84zALve1IVje9QaPbOzKH3uFtT/+4A1WsAKmP1k5ltTWkMRPN1mKO/UQU7
         TcGHN9XkUgGTGtgusC7jNOo8ixTjA9jikrbhpejKjtlFQQRav560+aDsEkB2NTlFPmeO
         wLcRUyqHhCToDTOI/g4SjmIbhdSvtnt+AcuPBiax9+E0R89sqLWspyR8DDXJow4QcjG7
         2H/Q==
X-Gm-Message-State: ANoB5pldriWd6y2NRLWqSu992PBEkAVPsBSBV/NU786JdY83tX2/e7Me
        08eGoOwAMwP0PJzClmWwpLKbeG2md/XQP3OGM1M=
X-Google-Smtp-Source: AA0mqf5WRZs/wGjjFhP0t/QeTG2bii0+REtPtfrLlh5CN8BBJC4ZqCohyX7X1yYj2ADlXkoN0RE5QZ8hhedVGAzCFVw=
X-Received: by 2002:a05:690c:b03:b0:3f4:6e40:89c3 with SMTP id
 cj3-20020a05690c0b0300b003f46e4089c3mr590407ywb.266.1670271998631; Mon, 05
 Dec 2022 12:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20221204231650.2604587-1-gary@garyguo.net>
In-Reply-To: <20221204231650.2604587-1-gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 5 Dec 2022 21:26:27 +0100
Message-ID: <CANiq72mXQed42DARuOjEipUffNxx97LRL+byZ0G2kjuRup6ZYQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: make compiler-builtin stubs non-global
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 5, 2022 at 12:17 AM Gary Guo <gary@garyguo.net> wrote:
>
> This patch was previous discussed on GitHub.

previous -> previously

> Link: https://github.com/Rust-for-Linux/linux/pull/779
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Hmm... Something happened to the patch (compared to v1): the triple
dashes, the diffstat, the base-commit etc. are not there. It can still
be applied, so no worries, but it feels a bit strange.

The newline between the tags should not be there. Instead, please put
it on top of `Link:` to keep tags separated (if you wanted to keep it
close to the sentence to refer to it, you can use "[1]" instead and
then "Link: https... [1]" in the tag).

> +// NOTE: if you are adding a new intrinsic is added here, you should also add it to
> +// `redirect-intrinsics` in `rust/Makefile`.

"is added" -> "". Also, what about putting the message at the top
instead (below the docs or perhaps after the macro but before the
calls to it)?

For the title of the patch, in the end I went with "rust: xxx: ..."
(where xxx is typically the name of the crate or the `kernel` crate
module), so perhaps "rust: compiler_builtins: make stubs non-global"
or similar?

Thanks a lot!

Cheers,
Miguel
