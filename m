Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554D55BBAE2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 00:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIQWmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 18:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQWmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 18:42:42 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C132AC49
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 15:42:41 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id c4so20245816iof.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 15:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=kahzIo799kyEdsYA+23YsXtPtnybsy8lc1MLAua0e7E=;
        b=Rf3WH51PkjSqqIi93EzQibr1PLt7e/h+ghOoTUlaLFbW1ZMlcwydeSTtDZR7p84h3r
         pDXF7HNP4GO5DdBNB5RBpxGGAwqO3Zv1Zw+/hNJyYbOjMtR1AeRuKsigfDgI065K5+P7
         fXQ95DsvPYW1ASsWe0RFgAbCbsmPHOWk3wJnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kahzIo799kyEdsYA+23YsXtPtnybsy8lc1MLAua0e7E=;
        b=2nyPsQOii4069/S4WXVl5yGdj0vkdSiNhQwTf0/OD5ab1fuBcuy8FSxVm/7OWbki9R
         ZcRb5jhLQoCVuDeqXnYhAXlvamvYBa3a5MBgLRe2Qv6KD8+BvblWqwsszOUZrMKabvTe
         ySHKTHgo+VX7faaFK/ZzcZL684WIVhTvseWF++fGAgRYZP9OhfHRmsEvFKiv1kA2qKKZ
         qrKOzTCZ4Y37ZDGgX7MfTn7ncbi2tf6YxrbhsDJWlxEJvrz5BqcwaflAo/0KTLtaVp1k
         GbKiGIOwgCJ+wcBJSKA5OAcN16wvWaflUF1bkSvcn0Df9wBrmQHQ1fHScIC0rkjbIrcu
         2Ybg==
X-Gm-Message-State: ACrzQf3ouDqc85GzwbNgIJsSuqvayGUbpv4J3utxScLoB/5ZFhdXPrgM
        AlnwJFgZDAIciXWG7/oGZdqTSgdI9G3W020kOez8jQ==
X-Google-Smtp-Source: AMsMyM4D6EMYXRIrbuXciSc9uyILe9hzR1LlpWVr7/Sre3HhKRI38byd9jGaieo0sA/pnbfV0wzBeKiQzcFyeiVLE5Y=
X-Received: by 2002:a05:6638:19:b0:35a:52a2:dfbe with SMTP id
 z25-20020a056638001900b0035a52a2dfbemr4871472jao.213.1663454560516; Sat, 17
 Sep 2022 15:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220917164200.511783-1-joel@joelfernandes.org>
 <20220917164200.511783-4-joel@joelfernandes.org> <20220917195807.GA39579@lothringen>
 <CAEXW_YQxwDF5jhS9gdLa0FsNeD+WoZL0PQydMbT4hsUtLm0hMA@mail.gmail.com> <20220917222108.GB40100@lothringen>
In-Reply-To: <20220917222108.GB40100@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 17 Sep 2022 18:42:29 -0400
Message-ID: <CAEXW_YSbwRUqz1f2i4LQpxmSyW5PWYWnifRj0UaTHP6pL7m9Lw@mail.gmail.com>
Subject: Re: [PATCH rcu/next 3/3] rcu: Call trace_rcu_callback() also for
 bypass queuing (v2)
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 6:21 PM Frederic Weisbecker <frederic@kernel.org> w=
rote:
>
> On Sat, Sep 17, 2022 at 05:43:06PM -0400, Joel Fernandes wrote:
> > On Sat, Sep 17, 2022 at 3:58 PM Frederic Weisbecker <frederic@kernel.or=
g> wrote:
> > >
> > > On Sat, Sep 17, 2022 at 04:42:00PM +0000, Joel Fernandes (Google) wro=
te:
> > > > @@ -2809,17 +2825,15 @@ void call_rcu(struct rcu_head *head, rcu_ca=
llback_t func)
> > > >       }
> > > >
> > > >       check_cb_ovld(rdp);
> > > > -     if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> > > > +
> > > > +     if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags)) {
> > > > +             __trace_rcu_callback(head, rdp);
> > > >               return; // Enqueued onto ->nocb_bypass, so just leave=
.
> > > > +     }
> > >
> > > I think the bypass enqueues should be treated differently. Either wit=
h extending
> > > the current trace_rcu_callback/trace_rcu_kvfree_callback (might break=
 tools)
> > >
> > > or
> > > with creating a new trace_rcu_callback_bypass()/trace_rcu_kvfree_call=
back_bypass().
> > >
> > > Those could later be paired with a trace_rcu_bypass_flush().
> >
> > I am having a hard time seeing why it should be treated differently.
> > We already increment the length of the main segcblist even when
> > bypassing. Why not just call the trace point instead of omitting it?
>
> I'm not suggesting to omit it. I'm suggesting to improve its precision.

That's exactly what I'm doing :-). It is imprecise the way it is, by
calling it where it needs to be (not omitting it), I am making it more
precise.

> > Otherwise it becomes a bit confusing IMO (say someone does not enable
> > your proposed new bypass tracepoint and only enables the existing one,
> > then they would see weird traces where call_rcu is called but their
> > traces are missing trace_rcu_callback).
>
> Well, if they decided to see only half of the information...

It is not that they decide, there are lots of RCU tracepoints and it
is likely common to enable just a few of them.

> > Not to mention - your
> > suggestion will also complicate writing tools that use the existing
> > rcu_callback tracepoint to monitor call_rcu().
>
> If we add another tracepoint, the prototype will be the same as the
> existing one, not many lines to add. If instead we extend the existing
> tracepoint, it's merely just a flag to check or ignore.
>
> OTOH your suggestion doesn't provide any bypass related information.

Bypass related information is not relevant to this patch. I am already
using trace_rcu_callback() in my (yet to be released) rcutop, and I
don't use it for any bypass information.

> > Also if you see the definition of rcu_callback, "Tracepoint for the
> > registration of a single RCU callback function.".  That pretty much
> > fits the usage here.
>
> Doesn't tell if it's a bypass or not.

It doesn't tell a lot of things, so what? Saying that it is bypass is
not the point of this patch.

> > As for tracing of the flushing, I don=E2=80=99t care about tracing that=
 at the
> > moment using tracepoints
>
> You will soon enough ;-)

I respect your experience in the matter :-)

> > but I don=E2=80=99t mind if it is added later.
> > Maybe let=E2=80=99s let Paul help resolve our disagreement on this one?=
 :)
>
> FWIW, I would be personally interested in such tracepoints (or the extens=
ion

Understood.

> of the existing ones, whichever way you guys prefer), they would be of gr=
eat help
> for debugging.
>
> Also if rcu_top is ever released, I really hope the kernel will be ready =
in
> case we want the tool to display bypass related informations.

I feel the main issue you have with my patch is that it does not add
the information you want, however the information you mention is
beyond the scope of the patch and can in future/different patches.
This patch only fixes an *existing* broken tracepoint.

I can certainly add a new bypass-related tracepoint in the future, but
I don't see how that's relevant to my patch.

> Please be careful while designing tracepoints that may be consumed by use=
rspace
> released tools. Such tracepoints eventually turn into ABI and there is no=
 way
> back after that.

Sure thing, that's why I'm fixing the broken tracepoint. Some
registered callbacks can be invisible to the user.

 - Joel
