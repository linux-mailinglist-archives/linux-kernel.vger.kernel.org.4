Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D496D87A9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjDEUGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjDEUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:06:09 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812484C21
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:06:07 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54bfce685c1so29834507b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 13:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680725166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ygsa2eTf+xsXnZqg44gmYWf/SfHEolUj8FguWk7+UDw=;
        b=fTWp9KmFJz2xYp7Ti6E/KHeSEkcgCUkNm/Ld+An7nyyTPy0+5XfNbJPOONAzw0oSqZ
         37H7MN4YfUwzkwefkzW+DTSbBhb2CY9cAvWCcXLkKO8RkRUvv/6cEdO1Xe1duFtL5LXI
         3EfnV7+z4JWjb7N1Sur0CSSQh5T3xswufy/Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680725166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ygsa2eTf+xsXnZqg44gmYWf/SfHEolUj8FguWk7+UDw=;
        b=pSVVaWkQmJ+rAwBi1o7MpBoHzmjHm+TYtbxY8tgeakjpv+XN1Xg+kVi/fnkjnlMebs
         ClJ6MOgFUW0wmeX+kegSSOYqGgl0Z1kEd7rIvzNI9BP1gHc1ry1LjWfP/Cz4149f7JWc
         7tZEjWW8rovtPOK4TKpB/VBLNzWNhHTnxTz+RgALbV+CcCsx+0H8i0PGrcg8M+PtAqTE
         87w0jDyOvuGzffC6FijTYLgP3pUA8by61FGPK/kB6reUbguE40H3OuNKcn0jjGlzn7Tx
         pQZIRNc7qyRRnpFB23Wq8c19PYsf/VA73GEdQk4LtCm+7K6ATUAbLv3R2+4Ua8Do2ZDV
         JyDA==
X-Gm-Message-State: AAQBX9eXBNgXUHtILqpnbtGYUsIiTQ0rXkDkdv3/ZbYqdfw3ucwt2Dfc
        aP2MTrCDW0DFpuACiN2+MAWUM2n6oEzdtUxP4QAjQg==
X-Google-Smtp-Source: AKy350bxFI2ijOYOhKo2jnAxtu+TyF5TlidhEacKiqPzYtJcMbPArmvTXIOAEJrFmf9eL2lmAe3F++YmZW6fu3YfkXU=
X-Received: by 2002:a81:c406:0:b0:534:d71f:14e6 with SMTP id
 j6-20020a81c406000000b00534d71f14e6mr4454542ywi.9.1680725166569; Wed, 05 Apr
 2023 13:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230328092622.062917921@infradead.org> <20230328110354.562078801@infradead.org>
 <CAKfTPtAkFBw5zt0+WK7dWBUE9OrbOOExG8ueUE6ogdCEQZhpXQ@mail.gmail.com>
 <20230404092936.GD284733@hirez.programming.kicks-ass.net> <20230404135050.GA471948@google.com>
 <20230405083543.GZ4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230405083543.GZ4253@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 5 Apr 2023 16:05:55 -0400
Message-ID: <CAEXW_YQmG83_Yb9JgXapt9RgAs4m=fHnrOKRqfG9N_VMYcA88A@mail.gmail.com>
Subject: Re: [PATCH 14/17] sched/eevdf: Better handle mixed slice length
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, efault@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 4:36=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Tue, Apr 04, 2023 at 01:50:50PM +0000, Joel Fernandes wrote:
> > On Tue, Apr 04, 2023 at 11:29:36AM +0200, Peter Zijlstra wrote:
>
> > > Heh, this is actually the correct behaviour. If you have a u=3D1 and =
a
> > > u=3D.5 task, you should distribute time on a 2:1 basis, eg. 67% vs 33=
%.
> >
> > Splitting like that sounds like starvation of the sleeper to me. If som=
ething
> > sleeps a lot, it will get even less CPU time on an average than it woul=
d if
> > there was no contention from the u=3D1 task.
>
> No, sleeping, per definition, means you're not contending for CPU. What
> CFS does, giving them a little boost, is strictly yuck and messes with
> latency -- because suddenly you have a task that said it wasn't
> competing appear as if it were, but you didn't run it (how could you, it
> wasn't there to run) -- but it still needs to catch up.
>
> The reason it does that, is mostly because at the time we didn't want to
> do the whole lag thing -- it's somewhat heavy on the u64 mults and 32bit
> computing was still a thing :/ So hacks happened.

Also you have the whole "boost tasks" that sleep a lot with CFS right?
 Like a task handling user input sleeps a lot, but when it wakes up,
it gets higher dynamic priority as its vruntime did not advance. I
guess EEVDF also gets you the same thing but still messes with the CPU
usage?

> That said; I'm starting to regret not pushing the EEVDF thing harder
> back in 2010 when I first wrote it :/
>
> > And also CGroups will be even more weird than it already is in such a w=
orld,
> > 2 different containers will not get CPU time distributed properly- say =
if
> > tasks in one container sleep a lot and tasks in another container are C=
PU
> > bound.
>
> Cgroups are an abomination anyway :-) /me runs like hell. But no, I
> don't actually expect too much trouble there.

So, with 2 equally weighted containers, if one has a task that sleeps
50% of the time, and another has a 100% task, then the sleeper will
only run 33% of the time? I can see people running containers having a
problem with that (a customer running one container gets less CPU than
the other.). Sorry if I missed something.

But yeah I do find the whole EEVDF idea interesting but I admit I have
to research it more.

 - Joel
