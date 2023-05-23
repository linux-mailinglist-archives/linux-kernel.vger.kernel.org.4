Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20F570DEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbjEWOPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbjEWOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:15:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7FB130
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:15:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-510e419d701so1844056a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1684851328; x=1687443328;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=FebP/qFHl0Dl67q5FeEHc91aNblS1R2LhUrg1U/Isbo=;
        b=uVErkesMioUpkrd/1Qe0cl8yRr3/q5pXG3LizEb+fAw1xGGKvxRlfAXannm+NYXVIv
         tj5m5qgvO4xMFgQmlvarz48n3H+HNZpVVp3iJd6Flp4RLCXyiNKWnFC8UNR3eBPgfVaU
         X+hBw0yPUQ9Vux563zSj23KxmXRQxlE1Khw2/qD3MPe534UOPkK1cP7n2Wq7z5tOpy5F
         uBZ4WazFgOesOU2prwsUu3k495ea5HpCLD78qjF8Lzxdwtd2OXuCV/cKcnkdXpoohSLS
         b662HLi87+xdh6nOpVc83zJjOkgO08TnlbUFy6tAR5YztkQGc3vPa1cvs+O6X15eBSpm
         Pohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851328; x=1687443328;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FebP/qFHl0Dl67q5FeEHc91aNblS1R2LhUrg1U/Isbo=;
        b=gUtYZ2qPfNwJ7pUoY6FMN5/54aYkoVxaEMyZNEbpUUbFdLrWVdLZTjj5uqEMMTvCn4
         cDg2gFW84AsundZ8/iDTWibuIt2hk8Aqt3cy3vzyyZt4Sr+EFP4eW0TfE2nE4yH18JDs
         rteQRjd2g5l8uS9YTwLpAIn8aDlSK+L5SuiC4mVFIqywgmtDTh9xZSZP5e2Jfe498Nyj
         xa1ZWlAdzxQC33hcnQOb3Rcynd+60akeJe5pD+motCtKXyqzVACoLBikyjX9lPRjACpw
         ETSvo7E/kjzkQ5oCW4IZ4TWBWQrHSjphFwy+jXh0QglaG8z7QBxPyUG0UIdMGeDyjGc4
         DWBw==
X-Gm-Message-State: AC+VfDwcTux5Ry9mbNtDAKojfxzEFhR9Szo1BQ+znet5+BSr+VOgh13z
        JNnlGK3T9t0rhzM6euBbm/xJNw==
X-Google-Smtp-Source: ACHHUZ5qSPAcH861872AUO19Y6nXlt6YPQsMjbAHd3u7oOXwHcRCFReFB4UWevnWEwD06EKyPazqcQ==
X-Received: by 2002:a17:907:1c8b:b0:94e:48ac:9a51 with SMTP id nb11-20020a1709071c8b00b0094e48ac9a51mr16656005ejc.4.1684851328355;
        Tue, 23 May 2023 07:15:28 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id xa12-20020a170907b9cc00b0096637a19dccsm4510453ejc.210.2023.05.23.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:15:27 -0700 (PDT)
References: <20230517203119.3160435-1-aliceryhl@google.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 0/7] Bindings for the workqueue
Date:   Tue, 23 May 2023 16:14:37 +0200
In-reply-to: <20230517203119.3160435-1-aliceryhl@google.com>
Message-ID: <87ilcjdthc.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> This patchset contains bindings for the kernel workqueue.
>
> One of the primary goals behind the design used in this patch is that we
> must support embedding the `work_struct` as a field in user-provided
> types, because this allows you to submit things to the workqueue without
> having to allocate, making the submission infallible. If we didn't have
> to support this, then the patch would be much simpler. One of the main
> things that make it complicated is that we must ensure that the function
> pointer in the `work_struct` is compatible with the struct it is
> contained within.
>
> This patch could be significantly simplified if we already had the field
> projection bindings. However, we have decided to upstream the current
> version that does not depend on field projection first - the PR that
> introduces field projections will then include a commit that simplifies
> the workqueue implementation. (In particular, it would simplify the 5th
> patch in this series.)
>
> The first version of the workqueue bindings was written by Wedson, but
> I have rewritten much of it so that it uses the pin-init infrastructure
> and can be used with containers other than `Arc`.
>
> Alice Ryhl (4):
>   rust: workqueue: add low-level workqueue bindings
>   rust: workqueue: add helper for defining work_struct fields
>   rust: workqueue: add safe API to workqueue
>   rust: workqueue: add `try_spawn` helper method
>
> Wedson Almeida Filho (3):
>   rust: add offset_of! macro
>   rust: sync: add `Arc::{from_raw, into_raw}`
>   rust: workqueue: define built-in queues
>
>  rust/helpers.c           |   8 +
>  rust/kernel/lib.rs       |  37 ++
>  rust/kernel/sync/arc.rs  |  44 +++
>  rust/kernel/workqueue.rs | 715 +++++++++++++++++++++++++++++++++++++++
>  scripts/Makefile.build   |   2 +-
>  5 files changed, 805 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/workqueue.rs
>
>
> base-commit: ac9a78681b921877518763ba0e89202254349d1b

This does not compile for me. Could you link dependencies to be applied
first?

Best regards,
Andreas
