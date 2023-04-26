Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728866EF26A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbjDZKni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240509AbjDZKn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:43:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDC14C03
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:43:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4ecb7fe8fb8so7307e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682505801; x=1685097801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1l22hRUUq/IeT+lj7j9mcQyEj+B5z+NRQ6K59AKwb4M=;
        b=dQ4cunzURjxkU0Leg7LAnW10B6iCwcl0niLLMCTpkjxaqk9CfBvAZ1HgYEeuNEf5Df
         zZ184SgUKghynTw2tZX+ypOybCxdyCKNL7DMU9IjJu/PdtY2ux8Z/c/xxwn9U7NV4+x8
         dbDsyMs04VHMB/zNnOJP4wUr69uff9Qqm/M2aWU00bT2qFUwxtFouULN9tFgPzMneHyv
         lVGDvP5erVVVmurehevtjGrXnOk0JRJsNeS0ZcaQFAOhgyLAM7167hxcZoAYKmlGkLH6
         KJ9Wkxb5NWiCh8R/jpMyPupA7BUJu+0Opr7z9XpWThO1NjmwZjfbmqdUc5nQgVBLootZ
         T22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682505801; x=1685097801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1l22hRUUq/IeT+lj7j9mcQyEj+B5z+NRQ6K59AKwb4M=;
        b=SUJx427MNo2mrpSRVvGw7c6SseJE2hozEYo9Bqzk8I8VkjIUwzi/zKzYv5XXYZ/b8X
         kcfDfkk85H053IW+LD0ITXqhIfSzZSPB1bUNk/64R7VHvPrShdIRgR7njd+WOfIkLbdd
         GeIzAIkAVAG4ES9T2r/Y0vV5N7ZKRXRlrg/HZo8/i6G5FHmEIFJTI6XmTXDaiNFOZBu2
         KD0Joguvqo8fFbn+azly4MQ3TBvcVkfO/Er0LI/Igv3/BaXsDt2rl6x4Qaz7s5KS5xIB
         45+kcj0sRi6vIZoNgic7WLheCME0tylirgCvM4IJJVwnSBDir8bP+eAJpXcB8Ex9w6y4
         eomg==
X-Gm-Message-State: AC+VfDz0Z1DUBQL8rQwhpLgsUzUz8yjiUaGGdES26AIA2oZsp6Pzj81W
        VX9F6ISk7OOhyoDtO6NOjYIWoHRZtkncbeCC+Y/d+w==
X-Google-Smtp-Source: ACHHUZ4B5f1M+sCvV1r/JKCKg4wqK2GIXRKY8DLF7nDMlL59wkEK2UGwq1KEigLY8M1WXsEVAUtJ+zjYP4xY+/V/nWc=
X-Received: by 2002:a05:6512:b08:b0:4e8:3fc8:4f80 with SMTP id
 w8-20020a0565120b0800b004e83fc84f80mr177986lfu.4.1682505801347; Wed, 26 Apr
 2023 03:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000079eebe05fa2ea9ad@google.com> <CANiq72mor1BkxpAT=v0EsQJN-7fvMjo9K5ooVk1x7ZbBDEyn8g@mail.gmail.com>
 <CACT4Y+aMdct_tjSYsBvvtGoDji6feOiANogRbp3N41qkzU+5CQ@mail.gmail.com>
 <CANiq72nm2dU2o_x_GQ5SdsXaK6yZiDXG2hXEYMykViEAZvuMqQ@mail.gmail.com>
 <CACT4Y+YyYnwg4a1zjTnBU=t0x5Brt1rGuzz-5pXf2Fz3cKf4FQ@mail.gmail.com> <CANiq72=vMydenfkxQx4X7kYvHD0cHzNK19xxxqow3WcLStsdRA@mail.gmail.com>
In-Reply-To: <CANiq72=vMydenfkxQx4X7kYvHD0cHzNK19xxxqow3WcLStsdRA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 26 Apr 2023 12:43:08 +0200
Message-ID: <CACT4Y+ZrwXB1W31Rr7rUUOoW15YbKfnC0khY9KnNk8FTf5uQnA@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in __dabt_svc
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     syzkaller@googlegroups.com, alex.gaynor@gmail.com,
        andriy.shevchenko@linux.intel.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, bpf@vger.kernel.org, gary@garyguo.net,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        ojeda@kernel.org, pmladek@suse.com, rostedt@goodmis.org,
        rust-for-linux@vger.kernel.org, senozhatsky@chromium.org,
        syzkaller-bugs@googlegroups.com, wedsonaf@gmail.com,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 at 12:30, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> > In which of the dozens of kernel testing systems? ;)
> > And also in heads of thousands of kernel developers and users?
> > All of them use get_maintainer.pl.
>
> I am aware, but `get_maintainer.pl` is fine as it is -- we still want
> to know about things that touch things that mention Rust in general,
> so that we can possibly be helpful to others, especially early on.
>
> However, if a bot is testing the kernel with Rust actually disabled at
> runtime, what I am saying is that the chance that it has something to
> do with Rust is quite low, especially if matched via `K:` rather than
> `F:`. Thus my request.
>
> Now, it could be nice to have some logic like that in
> `get_maintainer.pl` encoded for all bots to filter things out based on
> the kernel config and the type of match; but otherwise, yes, the bots
> would need to add the logic.
>
> Cc'ing Joe in case this is already possible in `get_maintainer.pl` or
> whether there could be a better approach.

I understand your intentions and they make sense.
But adding this logic to syzbot won't help thousands of users of
get_maintainer.pl and dozens of other testing systems. There also will
be a bit of get_maintainer.pl inside of syzbot code, so now all kernel
developers will need to be aware of it and also submit changes to
syzbot when they want to change maintainers logic.

I think this also equally applies to all other users of K:.
And a number of them had similar complaints re how K; works.

I am thinking if K: should actually apply just to patches and be
ignored for source files?
If there are files that belong to "rust" (or "bpf" or any other user
of K:), then I think these should be just listed explicitly in the
subsystem (that should be a limited set of files that can be
enumerated with wildcards).
It's also reasonable to apply K: to patches.
But if a random source file happened to mention "rust" somewhere once,
I am not sure you want to be CCed on all issues in that file.
Does it sound reasonable?
