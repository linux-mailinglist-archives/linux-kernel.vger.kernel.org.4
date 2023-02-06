Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2498368C6FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjBFTos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjBFToq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:44:46 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB44B55B3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:44:45 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id d189so7727202ybc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CdFA/Nuf17JZ3Ib0aYe7R5OWWBIm4F7R8oUteEyqTAI=;
        b=q2GfOUz6JO+U8UffkqIA8mb4Src1zQgvg0jtmVwyOYZw+vM2O3IOuw3sFJL7yWbm8X
         aZI/ZI3JkjKfd6A4RaMgr2erzsJkjJ8M+Vjb3Htsa/ORrKjjXRMs8//RylWuOD7wS5GJ
         CquNd0eQl7QpNlKODbQUWWgopdD148IG7VNg+XjFn6iPpHk7DATdL17sdyhZJPC9kPqh
         RPZB6bvggZGGJAPKucM0qU20WmxL1WYfqwy0mS2efY/VdbcAx9O/TjgbZ2eE7Dd3AfW+
         GKqSv+hcB7HjS2iWw/GptkPYAV6kG/JFtCt3yWq+zhDzu2fhD6SQynxCuM3z042DhV2r
         kglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdFA/Nuf17JZ3Ib0aYe7R5OWWBIm4F7R8oUteEyqTAI=;
        b=oukm4xfMjfgq/mcvfhjiWKf1vY4ySev4Cvy+LhwjpzmQwMHQUjaGU3FZgOtoO+eW8o
         WB3jUzATvgX0f87zjkw0Wa1QV1MHtziZ+6kK4+9P0eb8MxiYZr8QIdSP8ngNoktiTV75
         j2+blBpbvREmk9YnWiOtE/NU0TYhG48PvT/HzDao+CfSSXyr+rLoXFUjzXaJpiWBMUc8
         buaE+xmVfksF09xextObhxDbjDyry/MJo8LrATmSj7Oz269NZvIGzIUtRbP69lPpbjq3
         mCgcu+OjTso3b5P4lyN6IUl74ySS5n8yOuSUcKbECElM4T9G63UP7cBal3px62vzelHU
         gOrg==
X-Gm-Message-State: AO0yUKUdPUofYPR1RrJ1KPoKBA+dARomoDfReyFPI4RO34g09V0WMgC9
        B68eWbSE3NWxrfz7gj95LDd5HXA2D/SLxFULKAZA2kEUJulGYHY=
X-Google-Smtp-Source: AK7set9UTRaA9Pl7bsHqAlFYzjhxIy0j7MwqOZyP4oMh4PXhFG29ynnTL07seChopHShj2HPhiMIl8aJZYJ2V9Z+zIw=
X-Received: by 2002:a25:26c1:0:b0:80b:6201:bee7 with SMTP id
 m184-20020a2526c1000000b0080b6201bee7mr138276ybm.340.1675712684751; Mon, 06
 Feb 2023 11:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20230203200138.3872873-1-jstultz@google.com> <20230205183424.xwt54mlyixxgkhl6@offworld>
In-Reply-To: <20230205183424.xwt54mlyixxgkhl6@offworld>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 6 Feb 2023 11:44:33 -0800
Message-ID: <CANDhNCqCahrCDRL2gg3c7E6vjY6cRThdDDE3=weTu2325ib3SQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] locktorture: Add nested_[un]lock() hooks and
 nlocks parameter
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
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

On Sun, Feb 5, 2023 at 11:01 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
> On Fri, 03 Feb 2023, John Stultz wrote:
>
> >In order ot extend locktorture to support lock nesting, add
>           ^ to

Fixed. Thanks for catching this!

> >nested_lock() and nested_unlock() hooks to the torture ops.
> >
> >These take a 32bit lockset mask which is generated at random,
> >so some number of locks will be taken before the main lock is
> >taken and released afterwards.
> >
> >Additionally, add nlocks module parameter to allow specifying
> >the number of nested locks to be used.
> >
> >This has been helpful to uncover issues in the proxy-exec
> >series development.
> >
> >This was inspired by locktorture extensions originally implemented
> >by Connor O'Brien, for stress testing the proxy-execution series:
> >  https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/
> >
> >Comments or feedback would be greatly appreciated!
>
> Both of the above statements should be in a cover letter patch.

I'll drop the second line, but I'd like to preserve Connor's
contribution in the git log.
If it's ok, I'll keep it to just one of the patches to not be repetitive.


> >Cc: Davidlohr Bueso <dave@stgolabs.net>
> >Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >Cc: Josh Triplett <josh@joshtriplett.org>
> >Cc: Joel Fernandes <joel@joelfernandes.org>
> >Cc: Juri Lelli <juri.lelli@redhat.com>
> >Cc: Valentin Schneider <vschneid@redhat.com>
> >Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >Signed-off-by: John Stultz <jstultz@google.com>
>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>
> With some small nits below.
>
> >---
> > kernel/locking/locktorture.c | 23 +++++++++++++++++++----
> > 1 file changed, 19 insertions(+), 4 deletions(-)
> >
> >diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> >index 9c2fb613a55d..f4fbd3194654 100644
> >--- a/kernel/locking/locktorture.c
> >+++ b/kernel/locking/locktorture.c
> >@@ -48,6 +48,9 @@ torture_param(int, stat_interval, 60,
> > torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> > torture_param(int, verbose, 1,
> >            "Enable verbose debugging printk()s");
> >+torture_param(int, nlocks, 0, "Number of nested locks");
>
> Maybe rename the parameter to 'nested_locks'? It would also be good to
> inform the 8 limit. "Number of nested locks (max = 8)".


Done!

Thanks so much for your time reviewing and the feedback!

I'll resend the reworked patches shortly.
-john
