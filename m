Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFDD6A7C95
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCBI1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCBI1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:27:53 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A792B4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:27:51 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z5so16758547ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 00:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677745669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UvH0qWq2voeqICqThZWox9cofodtW3GD3fZuZJYXbfk=;
        b=JlXxNWkZ94/0B9RzyMbYrbB+djHS5nODibI5oFhOR4jwrHPinhhxJMbwweAZVpV0eD
         wWIlWObAbRBNrUwQk2tBO6AVJ0ezGtwgU+VfWGCywrX8pwHC3uD6Pi4Ck3/16KFuhk1h
         Z1JOwLPWIvrsonspOwhCzmRUJfFNVdxzHkd1sUc72bYaCy6ObHS44dSj0CEMhMQv78nE
         Ytml7ohdatezqcouv3Jb1nJ8aRPM+GtFmfPq22o5PvQhlJlb/CF2h+CQhUKxr6dEnnEx
         /Av5zZQ8N6PMxyUISrQnvZsCaGhGcugukf7DzwMCyJQhHqjqwbic34lCgF6qUjSAeTLV
         sNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677745669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvH0qWq2voeqICqThZWox9cofodtW3GD3fZuZJYXbfk=;
        b=z7eGCOfR7pDx+fmu2vowm/i0Ks0YYngBLDp9+uKl7ovOfWEq0t23b1SVdbKqMRvTvF
         avanvP1VIeT3/oIAG56p9FIK/JmkzI1P1e3dsu9VWzhdd74e+7Zwudo487DIvMRVRl2v
         TgL/emZttyf4ZUWO2UlO/ezRcjQgdHTAfhBQzFuLdSZ7FaUToanqbpgEZUYfc2O5Q0Bw
         HdM8yqnvSL4l4sPC9kfPgViWBKPG1JUmj6MAu2ypsMCpsbeWrBRtdvlS1SfzLaJCHpGS
         BhCM/ggn/03m0D8Vuelv91gV+r9TarmMJBueBmcmg8OO+SzkV0iv8Rim7EMfx6rA0V37
         fOlA==
X-Gm-Message-State: AO0yUKVorL0ejtYHHgoRm49TfkdX+jZ6yIzaog5SNK5GUAulRnr3pS4B
        arkXxF2yoR+15i4einzlIf3iU9zt2l/Ppt9eIFUWYw==
X-Google-Smtp-Source: AK7set+ddZNt1rtcoQRdowhfguIDsicZwiCLb+zLaQuAg8DVckOwrtBbOg5qknB6r2tId5AwAR3RGtC69IWoFrceyrQ=
X-Received: by 2002:a05:651c:386:b0:295:d63a:949e with SMTP id
 e6-20020a05651c038600b00295d63a949emr1557158ljp.4.1677745668950; Thu, 02 Mar
 2023 00:27:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674217480.git.linux@leemhuis.info> <bb5dfd55ea2026303ab2296f4a6df3da7dd64006.1674217480.git.linux@leemhuis.info>
 <20230301204602.5e9bf3c0@kernel.org> <ff62632d-7558-a86c-5541-a54de6e107e7@leemhuis.info>
 <20230301214023.610a9feb@kernel.org>
In-Reply-To: <20230301214023.610a9feb@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 2 Mar 2023 09:27:36 +0100
Message-ID: <CACT4Y+bxUA1v14y0SGC887er5Nif3ZEanjO_m=K4WBwyNfmZHA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] checkpatch: warn when Reported-by: is not followed
 by Link:
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 at 06:40, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 2 Mar 2023 06:17:22 +0100 Thorsten Leemhuis wrote:
> > On 02.03.23 05:46, Jakub Kicinski wrote:
> > > On Fri, 20 Jan 2023 13:35:19 +0100 Thorsten Leemhuis wrote:
> > >> Encourage patch authors to link to reports by issuing a warning, if
> > >> a Reported-by: is not accompanied by a link to the report. Those links
> > >> are often extremely useful for any code archaeologist that wants to know
> > >> more about the backstory of a change than the commit message provides.
> > >> That includes maintainers higher up in the patch-flow hierarchy, which
> > >> is why Linus asks developers to add such links [1, 2, 3]. To quote [1]:
> > >
> > > Is it okay if we exclude syzbot reports from this rule?
> > > If full syzbot report ID is provided - it's as good as a link.
> >
> > Hmmm. Not sure. Every special case makes things harder for humans and
> > software that looks at a commits downstream. Clicking on a link also
> > makes things easy for code archaeologists that might look into the issue
> > months or years later (which might not even know how to find the report
> > and potential discussions on lore from the syzbot report ID).
>
> No other system comes close to syzbot in terms of reporting meaningful
> bugs, IMHO special casing it doesn't risk creep.
>
> Interestingly other bots attach links which are 100% pointless noise:
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4174
>
> Oh, eh. Let's see how noisy this check is once the merge window is over.
>
> > Hence, wouldn't it be better to ask the syzbot folks to change their
> > reporting slightly and suggest something like this instead in their
> > reports (the last line is the new one):
> >
> > ```
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+bba886ab504fcafecafe@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/r/cafecaca0cafecaca0cafecaca0@google.com/
> > ```
> >
> > This might not be to hard if they known the message-id in advance. Maybe
> > they could even use the syzbot report ID as msg-id to make things even
> > easier. And for developers not much would change afaics, they just need
> > to copy and paste two lines instead of one.
>
> Dmitry, WDYT?

Hi Jakub, Thorsten,

Adding a Link to syzbot reports should be relatively trivial.

Ted proposed to use Link _instead_ of Reported-by:

https://github.com/google/syzkaller/issues/3596
> in fact, it might be nice if we could encourage upstream developers
> put in the commit trailer:
> Link: https://syzkaller.appspot.com/bug?id=5266d464285a03cee9dbfda7d2452a72c3c2ae7c
> in addition to, or better yet, instead of:
> Reported-by: syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com

We could also use a link in the Reported-by tag, e.g.:

Reported-by: https://syzkaller.appspot.com/b/5266d464285a03cee9db

Some folks parse Reported-by to collect stats.

What is better?
