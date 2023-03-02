Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF996A7D5C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCBJLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCBJLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:11:50 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7AE2BEE1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:11:49 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j11so5520946lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677748307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e4NkFRCFQ9uPhghd91o2bEM6FWXOrnEOgiDjs4m6iw0=;
        b=NaeRxidAGUd+JlPSw7Q9jU3sA4+WqFwFrIgZ9DNLRqmaYmLehIZ/IBM/4IWWw22MV6
         B55okjN3/Ak+p2LtfYUE5H9cUu2sZSmE5UG92YLsxKcoLDgS61+ZfUgwWMK0VY08ts+H
         R5XXpr0Rp7hLynNZCeSKiAgi3g524Yuv6MEu6Lva0PW4cvxqqwCM5LJOccxx4L3cSPXl
         R5MEtuDl512JfwGYyG/zVmSgZgvGVkXJbHllLWYRtNOPMZL50XJ0VuTEJ26y3wupyoDb
         rUtcrAxrAr5xEzm0wfS1S7ZWfotWyem4PU5L3BvuwgX/K759/USLn57DOzgdm41mV4EN
         QjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677748307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4NkFRCFQ9uPhghd91o2bEM6FWXOrnEOgiDjs4m6iw0=;
        b=o71sisMLcPOSB69ha1GH17ZiruMEWNmSklf1ecyuqJVRraHY6010s+PSJX7TKUghRb
         ZBAiEIlia+hycFQ/mf0r1ZThqsjDe4kZzCoVmmMj0jo+ZMgAJ9ibUTqQZV0L70+Hoinu
         Q7ZnyNawC+aSfqW9PTuACIAHpo+Tubey3MmiYTu7jFecp/UXXC6JF12ZgH4mAr0HeU3g
         JF+zKlQkcnp/BYT/30sovF27vJIPtbRrQqiNb7n9BkIMyndt4pg1gvK1+E4jVx2pq+wl
         APvAKv9hnoQuLbjUwVEBdVvk/Q1mPqSgDFkMdjLGQUt4gGsRR1bWnkJMCeZtb3XoHupO
         18rA==
X-Gm-Message-State: AO0yUKUXDXgCoSjrIgUtyYJFVUPQ1Y704syKdLK54p/NlETbDiNwNlUe
        uZQ5udIkKPdgMGI6QOnxyCmXi0wzQ84sRMa2rCkF+g==
X-Google-Smtp-Source: AK7set/rhJMt351kgIFqPCyoJ7vuDH92OQ4BPxijvFwXGBbXNRKxe8xq4gnRgtFL64UYuMfrPuPB3hzA6FwZK/oIexo=
X-Received: by 2002:a19:8c4e:0:b0:4dc:7e56:9839 with SMTP id
 i14-20020a198c4e000000b004dc7e569839mr662080lfj.5.1677748307318; Thu, 02 Mar
 2023 01:11:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674217480.git.linux@leemhuis.info> <bb5dfd55ea2026303ab2296f4a6df3da7dd64006.1674217480.git.linux@leemhuis.info>
 <20230301204602.5e9bf3c0@kernel.org> <ff62632d-7558-a86c-5541-a54de6e107e7@leemhuis.info>
 <20230301214023.610a9feb@kernel.org> <CACT4Y+bxUA1v14y0SGC887er5Nif3ZEanjO_m=K4WBwyNfmZHA@mail.gmail.com>
 <17fdf6f1-60ab-bfde-afc8-5afef6cc797b@leemhuis.info>
In-Reply-To: <17fdf6f1-60ab-bfde-afc8-5afef6cc797b@leemhuis.info>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 2 Mar 2023 10:11:32 +0100
Message-ID: <CACT4Y+Zm3d9jqK=R-E4xTihEUNdahagPyMPcinWowx8RABawrw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] checkpatch: warn when Reported-by: is not followed
 by Link:
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jakub Kicinski <kuba@kernel.org>, Joe Perches <joe@perches.com>,
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

On Thu, 2 Mar 2023 at 10:04, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
> On 02.03.23 09:27, Dmitry Vyukov wrote:
> > On Thu, 2 Mar 2023 at 06:40, Jakub Kicinski <kuba@kernel.org> wrote:
> >> On Thu, 2 Mar 2023 06:17:22 +0100 Thorsten Leemhuis wrote:
> >>> On 02.03.23 05:46, Jakub Kicinski wrote:
> >>>> On Fri, 20 Jan 2023 13:35:19 +0100 Thorsten Leemhuis wrote:
> >>>>> Encourage patch authors to link to reports by issuing a warning, if
> >>>>> a Reported-by: is not accompanied by a link to the report. Those links
> >>>>> are often extremely useful for any code archaeologist that wants to know
> >>>>> more about the backstory of a change than the commit message provides.
> >>>>> That includes maintainers higher up in the patch-flow hierarchy, which
> >>>>> is why Linus asks developers to add such links [1, 2, 3]. To quote [1]:
> >>>>
> >>>> Is it okay if we exclude syzbot reports from this rule?
> >>>> If full syzbot report ID is provided - it's as good as a link.
> >>>
> >>> Hmmm. Not sure. Every special case makes things harder for humans and
> >>> software that looks at a commits downstream. Clicking on a link also
> >>> makes things easy for code archaeologists that might look into the issue
> >>> months or years later (which might not even know how to find the report
> >>> and potential discussions on lore from the syzbot report ID).
> >>
> >> No other system comes close to syzbot in terms of reporting meaningful
> >> bugs, IMHO special casing it doesn't risk creep.
> >>
> >> Interestingly other bots attach links which are 100% pointless noise:
> >>
> >> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> >> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4174
> >>
> >> Oh, eh. Let's see how noisy this check is once the merge window is over.
> >>
> >>> Hence, wouldn't it be better to ask the syzbot folks to change their
> >>> reporting slightly and suggest something like this instead in their
> >>> reports (the last line is the new one):
> >>>
> >>> ```
> >>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>> Reported-by: syzbot+bba886ab504fcafecafe@syzkaller.appspotmail.com
> >>> Link: https://lore.kernel.org/r/cafecaca0cafecaca0cafecaca0@google.com/
> >>> ```
> >>>
> >>> This might not be to hard if they known the message-id in advance. Maybe
> >>> they could even use the syzbot report ID as msg-id to make things even
> >>> easier. And for developers not much would change afaics, they just need
> >>> to copy and paste two lines instead of one.
> >>
> >> Dmitry, WDYT?
> >
> > Adding a Link to syzbot reports should be relatively trivial.
>
> Sounds good.
>
> > Ted proposed to use Link _instead_ of Reported-by:
> > https://github.com/google/syzkaller/issues/3596
> >> in fact, it might be nice if we could encourage upstream developers
> >> put in the commit trailer:
> >> Link: https://syzkaller.appspot.com/bug?id=5266d464285a03cee9dbfda7d2452a72c3c2ae7c
> >> in addition to, or better yet, instead of:
> >> Reported-by: syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com
> >
> > We could also use a link in the Reported-by tag, e.g.:
> >
> > Reported-by: https://syzkaller.appspot.com/b/5266d464285a03cee9db
> >
> > Some folks parse Reported-by to collect stats.
> >
> > What is better?
>
> Here are my thoughts:
>
> * we should definitely have a "Link:" to the report in lore, as that's
> the long-term archive under our own control and also where discussions
> happen after the report was posted; but I'm biased here, as such a tag
> would make tracking with regzbot a no-brainer ;)
>
> * "Reported-by:" IMHO should stay for the hat tip and stats aspects; I
> don't care if it includes the syzbot report ID or not (omitting it might
> be good for the stats aspects and is more friendly to the eyes, but
> those are just details)
>
> * a Link: to the syzkaller web ui might be nice, too -- and likely is
> the easiest thing to look out for on the syzbot server side
>
> IOW something like this maybe:
>
> Reported-by: syzbot+cafecafecaca0cafecafe@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/cafecafecaca0cafecafe@google.com/
> Link: https://syzkaller.appspot.com/b/cafecafecaca0cafecafe
>
> Something like the following would look more normal, but of course is
> only possible if syzbot starts out to look for such Link: tags (not sure
> if the msgid is valid here, but you get the idea):
>
> Reported-by: syzbot@syzkaller.appspotmail.com
> Link:
> https://lore.kernel.org/r/syzbot+cafecafecaca0cafecafe-syzkaller-appspotmail-com@google.com/

Oh, you mean lore link.

We can parse out our hash from any tag, but the problem is that the
current email api we use, does not allow to specify Message-ID before
sending, so we don't know it when generating the text.
We don't even know it after sending, the API is super simple:
https://pkg.go.dev/google.golang.org/appengine/mail
So we don't know what the lore link will be...
