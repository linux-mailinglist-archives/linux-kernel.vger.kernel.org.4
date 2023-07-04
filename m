Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01529747986
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGDVU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGDVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:20:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD5D127
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 14:20:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9891c73e0fbso13088866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 14:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688505654; x=1691097654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n75Dh2puDmWxs7IMDzFSoZlMiY6RQZaHybFGnsL1ZMY=;
        b=QOODvko3WFZFhybeNOP3lbChfYO1Uc3IsA5HH7WSwBUgpgyh1EyfYWsHcn3/OiI0s5
         EZEjJG6l6ecCFsAopwbb9PHUYFUDDCWOF/SvmiZrJLJHszYY7zanT9wcNB7r6h7J5bZs
         Tv9sfBOAsIbeONQX2EOkPHY5M2SHe9I/Rslnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688505654; x=1691097654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n75Dh2puDmWxs7IMDzFSoZlMiY6RQZaHybFGnsL1ZMY=;
        b=PODNybGg1kIlusyRY9B8uHoncnHO7BJulEj5qU5doczDmtWJhm297sPzCdxAmbsqfy
         MPoUQoNyjMYI4ci7/3Chkl0KxJmsO22Ide19mP/iLNpHEyWDjrfc1S8ff3h4u5wwe4GL
         fW1ss2m3jStabnonDWX1xaF6nc/oP9eXJE44NTQ+jKvFvZTz8xm5hC1Y1a9xeCVb96Kz
         DDfpBPaU00NX5a4XX80D0qmHp0/hQ/PwDsekLnmRtVhW9gO/JBk7qFgU8Y4emc87KEJC
         q/PDGT6y5gW/AWBTtzzk/Louh9JR8lyXW5gAlQUmIP4AmezMj5CVTJCh/LqnPATtZvgK
         Umtw==
X-Gm-Message-State: ABy/qLaCiNlu5xtylKsHjbJWlz5ozRzJLbv2hy70SIfi2tbC90jIjRlJ
        eiBkIZHjLGNs5Jpzn6oMQxiA+EIZmcH0X7CKUk+ddQ==
X-Google-Smtp-Source: APBJJlG6E+8J7PsAhmgqAa0ltSpiT4k+4qdznvEB9FsH9ucjZ+iCAI95dEoI5ct2lYwuDM/XxkJJMQ==
X-Received: by 2002:a17:907:2d2c:b0:98d:ebb7:a8b0 with SMTP id gs44-20020a1709072d2c00b0098debb7a8b0mr419800ejc.14.1688505654415;
        Tue, 04 Jul 2023 14:20:54 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id qk3-20020a170906d9c300b00984822540c9sm13784266ejb.96.2023.07.04.14.20.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 14:20:53 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so139411a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 14:20:53 -0700 (PDT)
X-Received: by 2002:a17:907:7f26:b0:966:1bf2:2af5 with SMTP id
 qf38-20020a1709077f2600b009661bf22af5mr379213ejc.22.1688505653634; Tue, 04
 Jul 2023 14:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <20230704211509.GA21834@1wt.eu>
In-Reply-To: <20230704211509.GA21834@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 14:20:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
Message-ID: <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
Subject: Re: Overly aggressive .gitignore file?
To:     Willy Tarreau <w@1wt.eu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 14:15, Willy Tarreau <w@1wt.eu> wrote:
>
> I don't understand why your completion on "git am" should rely on
> *tracked* files.

It doesn't.

Read that email again.

It fails on *untracked* files that are hidden from "git status" and
friends by our .gitignore pattern:

   *.mbx

added by commit 534066a983df (".gitignore: ignore *.cover and *.mbx")

So when I have those old stale mbx files around, I don't see them,
because "git status" will happily say

    nothing to commit, working tree clean

with no mention of those old turds.

Really. Try it.

> From a workflow perspective that makes no sense,
> as by definition, git am will consume only *untracked* files.

I don't think you actually read my email.

            Linus
