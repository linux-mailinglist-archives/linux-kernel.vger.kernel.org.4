Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BCA720027
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjFBLJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbjFBLJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:09:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35381A6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:08:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25676b4fb78so972563a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 04:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1685704134; x=1688296134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHcwCqmT88QjWYOy6xvs+vHpO7CsG0sAa7G35jZvfsI=;
        b=OA5XaZY4vmBg0Xt3T0oTbQ5FBUYjYpGRRJSQYv9h48q5t7Dkf3jqL2Wh+VEERk7NaF
         sKJG0bfTuW3mhSEW9NU6xonNpX6mAnxRubNbYC2CPLTVVHOnOB/toTTXLu5lB83VulJi
         t592ZJdjDAYP1TAze1mKLCSlRVXfMyExYcMsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685704134; x=1688296134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHcwCqmT88QjWYOy6xvs+vHpO7CsG0sAa7G35jZvfsI=;
        b=ZPLjbp7IWGQjsGb6Vi3QXzzbleuQnRlUyjnC0u+5oq38Xa3Yu6B2UV8mIXHOPnJ/LW
         JtJgVR9XpVtQuYRsHXCIOu7B8BytN3vU56A8crG1tTaKVqVTufVFrqLrvCXF/xlLPEi0
         XYnQIZyxL8gOX3dkBZEsfP3VTSaMayRU3PL6m2A8imSbyrHawlKaEQN3n5f8yWkYsucD
         981J8ihruWEudWpwBcO+TyKhc2mA3+opOUGI+qGUc4Zm6UbQgIRl+Dgm8gliTtuZ3s9e
         dCu7DUjHyZCWp6I2Di+8JKmhjRSkBKc8/8Tc5ksT2HhgjbzOluJb+X0chCyTmp7/12lX
         nrMg==
X-Gm-Message-State: AC+VfDyhVIWhQTbNnwj2birbD/0dcpOVFRWh+UWsbLgmehSj0gGrp08T
        /r9G1nRMoHg0nMH4LS9dwxn+JtgIKQ84OILeXfHs2w==
X-Google-Smtp-Source: ACHHUZ7ixeLRADYE+lRIK1uEgWAVmeFH+PZWdDf7mrNHGv0Y69eO+muKda/HM0JiFvBivGCy5EYJVzsN0ojd+b0ukuY=
X-Received: by 2002:a17:90b:241:b0:256:b190:2733 with SMTP id
 fz1-20020a17090b024100b00256b1902733mr995529pjb.33.1685704134531; Fri, 02 Jun
 2023 04:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230523181624.19932-1-ivan@cloudflare.com> <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
 <CABWYdi2A8ZfVJjmDpwiNhvYD8m-+PC5MsNRzofX7SXn2TTyY9Q@mail.gmail.com>
 <CAHC9VhQm9JEFozFMvNuBc_dx+XAqvJCY_Z8Dyf7q_RyDcNu=QA@mail.gmail.com>
 <CABWYdi3_zAVpeTRBou_Br-n6VXeM1xWTCSvu==QWdG4sd+nnnw@mail.gmail.com> <CAHC9VhReahw8G4Vc0eMdhQMLhGYE53=X48akC13rN4EPkiF3tQ@mail.gmail.com>
In-Reply-To: <CAHC9VhReahw8G4Vc0eMdhQMLhGYE53=X48akC13rN4EPkiF3tQ@mail.gmail.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Fri, 2 Jun 2023 12:08:43 +0100
Message-ID: <CALrw=nFdnSOyfd9X9qzpbTT8R_-m3uBM==FFkNSQ2XZsxUz0Fg@mail.gmail.com>
Subject: Re: [PATCH] audit: check syscall bitmap on entry to avoid extra work
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 3:15=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, May 24, 2023 at 2:05=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com>=
 wrote:
> >
> > On Tue, May 23, 2023 at 7:03=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > > Could you elaborate on what exactly you would like to see added? It=
's
> > > > not clear to me what is missing.
> > >
> > > I should have been more clear, let me try again ...
> > >
> > > From my perspective, this patch adds code and complexity to deal with
> > > the performance impact of auditing.  In some cases that is the right
> > > thing to do, but I would much rather see a more in-depth analysis of
> > > where the audit hot spots are in this benchmark, and some thoughts on
> > > how we might improve that.  In other words, don't just add additional
> > > processing to bypass (slower, more involved) processing; look at the
> > > processing that is currently being done and see if you can find a way
> > > to make it faster.  It will likely take longer, but the results will
> > > be much more useful.
> >
> > The fastest way to do something is to not do it to begin with.
>
> While you are not wrong, I believe you and I are focusing on different
> things.  From my perspective, you appear primarily concerned with
> improving performance by reducing the overhead of auditing.  I too am
> interested in reducing the audit overhead, but I also place a very
> high value on maintainable code, perhaps more than performance simply
> because the current audit code quality is so very poor.
> Unfortunately, the patch you posted appears to me as yet another
> bolt-on performance tweak that doesn't make an attempt at analyzing
> the current hot spots of syscall auditing, and ideally offering
> solutions.  Perhaps ultimately this approach is the only sane thing
> that can be done, but I'd like to see some analysis first of the
> syscall auditing path.

Ivan is out of office, but I would like to keep the discussion going.
We do understand your position and we're actually doing a project
right now to investigate audit performance better and this patch is
only the first thing which came up. Perhaps, we would have some other
improvements in the future.

But the way I see it - the audit subsystem performance and the way how
that subsystem plugs into the rest of the kernel code are two somewhat
independent things with the patch proposed here addressing the latter
(with full understanding that the former might be improved as well). I
think the fundamental issue we're trying to address here is that the
audit subsystem plugs into the kernel in a way, which is different
from conceptually similar systems, like netfilter, LSM,
kprobes/tracepoints etc, thus potentially breaking user expectations.
For example, when I use netfilter or LSMs - I see it as a system of
hooks: my code/rules/inspection plugs into some hooks of interest and
I fully understand that the kernel codepaths, where these hooks are
located, might be affected due to additional processing attached. Thus
I can adjust my code/rules/inspection to plug into only the minimum
required hooks to get the visibility or the effect I need without too
much affecting system performance.

So I (and most of us here really) had the same expectation from audit:
we thought that when you have a rule, which "monitors" a certain
system call, only that system call performance would be affected. IOW
we thought that system calls are a kind of a hook for audit rules and
it was a surprise for us to learn that when having a rule, which
monitors execve() for example, we can impact other unrelated system
calls in totally different workloads. I think this behaviour
fundamentally limits the ability of the audit users to optimise their
rules to monitor/collect only the minimum required information,
because as long as they need to monitor at least one system call -
they effectively monitor all of them. I do strongly suspect that most
Linux users would have a similar (mis-)expectation from the audit
subsystem, hence I think this patch will align the audit subsystem
better with the expectations from users.

Ignat
