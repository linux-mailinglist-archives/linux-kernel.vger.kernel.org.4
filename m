Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F227479AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjGDVpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGDVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:45:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB3DE59
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 14:45:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso9587827e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 14:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688507105; x=1691099105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lTzqTcLNdQWHGk/4LwYDzV1l/9yOlLZxSySpuQU5rrc=;
        b=PpEQwno00coGbfBGQEFiMDtNotaPQDKAHs+KadR8ibcEcolKTpYiocVARsC3mv2jra
         Tm0tk1xrvRirVN4IsNfgcfAYZmPvG7ABTLmjXfaxvgUAP1supyq8TVmp7lF7PmBNQ0fw
         BdjttO5YKgjUO7RkgjdByCGQbFps8+JArQ9Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688507105; x=1691099105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTzqTcLNdQWHGk/4LwYDzV1l/9yOlLZxSySpuQU5rrc=;
        b=jtTm6r73zdsnYAha3Rk7Hm5SjKIttfmLvED1gCOP4wz0RZ3jIC4bVNKyF2DIKAlgvM
         uvN78XEP1U9rULWCJ/c/FNcNpnsa4dbUT07xdq6M5qhoDsLjBLhcQWTrSGdPQ9tXxVaD
         dOk+JxzgkV76i/S9N/8wJt5kj99OAC901EKlE/8Lg4wDkANje0ygNFA9FiMqlzuvtPMY
         LEt1knxwT7k6Hk/F2flsfHaPEISf7cVA9HK6BPqLRWTIqhqJ0VPZqda6y2JuIBDiSSh8
         ag0DNbD53MQJ0odZZ1wMUicrY0/5aT3qVyD17hm6NJOFjTFZvD3oOdqLwjZRiXOqqpBt
         WdaA==
X-Gm-Message-State: ABy/qLZe00ZTTAfGlrcc2bxIGOIAMtreW625bJquskWMexPLBnln8c/+
        RSH6D99GC+okbdrVfUW6PgmwSkD9TQruejLmb3V7cyo6
X-Google-Smtp-Source: APBJJlE8EFsGIVNw8iUsES70wf4Xs95jaTcJZg92B/jWMbYpi0H97UAhFEs7kzqL4rJPIlGHJCGG6g==
X-Received: by 2002:a05:6512:39c3:b0:4f9:570c:7b28 with SMTP id k3-20020a05651239c300b004f9570c7b28mr11842271lfu.32.1688507104906;
        Tue, 04 Jul 2023 14:45:04 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id c15-20020a056402100f00b0051a5cf5fcaasm12160551edu.23.2023.07.04.14.45.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 14:45:04 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so7650790a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 14:45:04 -0700 (PDT)
X-Received: by 2002:aa7:c3d1:0:b0:51e:1095:5ae5 with SMTP id
 l17-20020aa7c3d1000000b0051e10955ae5mr4828868edr.8.1688507104103; Tue, 04 Jul
 2023 14:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <20230704211509.GA21834@1wt.eu> <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
 <20230704213415.GA21872@1wt.eu>
In-Reply-To: <20230704213415.GA21872@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 14:44:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPEjrB7eCukREhWu-0qfjbFD-K8sk1TYYRgeHzYr1tuQ@mail.gmail.com>
Message-ID: <CAHk-=wjPEjrB7eCukREhWu-0qfjbFD-K8sk1TYYRgeHzYr1tuQ@mail.gmail.com>
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

On Tue, 4 Jul 2023 at 14:34, Willy Tarreau <w@1wt.eu> wrote:
>
> But the git am completion rules should actually *not* rely on
> git status output. At least in my opinion.

Christ, Willy.

Where did I talk about git am completion rules?

b4 am DOES THE RIGHT THING.

Completion DOES THE RIGHT THING.

THOSE STUPID HISTORICAL TURDS IS THE PROBLEM.

And the reason those turds exist? Because I don't notice, BECAUSE GIT
STATUS DOESN'T TELL ME!

> Here I pressed [Tab] after "2023" and it automatically completed.

Go back and READ THE EMAIL ALREADY.

Let me quote the relevant part again:

** The reason it doesn't auto-complete ends up being that my kernel tree
** contains some other random stale mbx file from the _previous_ time I
** did that, because they effectively get hidden from "git status" etc by
** our .gitignore file.

so go and create an OLD STALE TURD that *ALSO* has that 2023-xyz name,
and now try again.

Notice how auto-completion doesn't work, because there are now
*multiple* files beginning with the same filename.

Auto-completion isn't smart enough to know "oh, he already committed
that old mbox file and I should ignore it".

And _I_ didn't notice until auto-complete failed, because our
".gitignore" file told all the infrastructure to - wait for it -
ignore that file.

So "git status" at no point gave me that helpful

   Untracked files:
     (use "git add <file>..." to include in what will be committed)
   2023xyzzy.mbx

output to let me know that "Oh, btw, you have that old turd in your tree".

Please. Read the email.

              Linus
