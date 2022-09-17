Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094295BBABC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 23:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIQVnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 17:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQVnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 17:43:19 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93AF2E9CE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 14:43:17 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id g8so17517097iob.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 14:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=b9bwUAUeen3ZxuyndIbZYoAduo/aHvBL3BmOUTyZqvE=;
        b=CM3cRv7m9TdrNLRi6rmQ9jU84QtM6gTd1m+k4MPbENvwXrBaNmXJ9aBHpXFQC+yE/E
         QnAGN/VRjYdEwgSN6P0oFywzdvT0POfMc4vaL3/ZXXFRUNiBdABnI8plMiNCyaQmQq95
         0HhwHv2ts064bm9DKlbpcKaTMdJupT6pNrh4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b9bwUAUeen3ZxuyndIbZYoAduo/aHvBL3BmOUTyZqvE=;
        b=aULS4P6dmogfyD9EAF5um+MEGtif8Fp2JDksTHv5HmGZVvi0TRmBjMHnzl3aLWUzSO
         rhMcoVYOcAsd597F4jBgafkhiyF7Dej9+bePclnoXWisemO5vZqGIVw4nnHeQ/OhEt0D
         4AqwZFtK4AYyvqxPwkwE/K37Rk7OzHJgUdQSfTZOMLJcg/p/DQDHbth8+6e74zIqGdv9
         hKlzafw6g95UwmPdlwzyQga3X9TcQemu94tcHxxdEZtMJV5Y9R0pi1PyZkPtJp/5yI1Y
         AXThXxSQEWcS0y82PXeG1Bwum8NgT573sQvLYihsus4R+IM4V+d8xpcFiNNyhV/YDyoA
         Zkmg==
X-Gm-Message-State: ACrzQf209m39oYHWIEwt4iVB61sBuWNe/wABgucnCQYi68o0XB3vMqdW
        vjTPkJ7Mi873P3izfqCFhS2EUt/9giaflzdJM3zabg==
X-Google-Smtp-Source: AMsMyM4AGE4CG1BNZBSt3toXCS8NcpeYiEEPPXKMjJbkwtML5PP1t0OfOJ62bApctQfdhMxJwvnflyru33gD/zK4jbA=
X-Received: by 2002:a05:6602:26d5:b0:68a:db5d:2923 with SMTP id
 g21-20020a05660226d500b0068adb5d2923mr4409914ioo.175.1663450997039; Sat, 17
 Sep 2022 14:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220917164200.511783-1-joel@joelfernandes.org>
 <20220917164200.511783-4-joel@joelfernandes.org> <20220917195807.GA39579@lothringen>
In-Reply-To: <20220917195807.GA39579@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 17 Sep 2022 17:43:06 -0400
Message-ID: <CAEXW_YQxwDF5jhS9gdLa0FsNeD+WoZL0PQydMbT4hsUtLm0hMA@mail.gmail.com>
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
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 3:58 PM Frederic Weisbecker <frederic@kernel.org> w=
rote:
>
> On Sat, Sep 17, 2022 at 04:42:00PM +0000, Joel Fernandes (Google) wrote:
> > @@ -2809,17 +2825,15 @@ void call_rcu(struct rcu_head *head, rcu_callba=
ck_t func)
> >       }
> >
> >       check_cb_ovld(rdp);
> > -     if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
> > +
> > +     if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags)) {
> > +             __trace_rcu_callback(head, rdp);
> >               return; // Enqueued onto ->nocb_bypass, so just leave.
> > +     }
>
> I think the bypass enqueues should be treated differently. Either with ex=
tending
> the current trace_rcu_callback/trace_rcu_kvfree_callback (might break too=
ls)
>
> or
> with creating a new trace_rcu_callback_bypass()/trace_rcu_kvfree_callback=
_bypass().
>
> Those could later be paired with a trace_rcu_bypass_flush().

I am having a hard time seeing why it should be treated differently.
We already increment the length of the main segcblist even when
bypassing. Why not just call the trace point instead of omitting it?
Otherwise it becomes a bit confusing IMO (say someone does not enable
your proposed new bypass tracepoint and only enables the existing one,
then they would see weird traces where call_rcu is called but their
traces are missing trace_rcu_callback). Not to mention - your
suggestion will also complicate writing tools that use the existing
rcu_callback tracepoint to monitor call_rcu().

Also if you see the definition of rcu_callback, "Tracepoint for the
registration of a single RCU callback function.".  That pretty much
fits the usage here.

As for tracing of the flushing, I don=E2=80=99t care about tracing that at =
the
moment using tracepoints, but I don=E2=80=99t mind if it is added later.

Maybe let=E2=80=99s let Paul help resolve our disagreement on this one? :)

thanks,

 - Joel

>
>
> Thanks.
>
>
> > +
> >       // If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb=
_lock.
> >       rcu_segcblist_enqueue(&rdp->cblist, head);
> > -     if (__is_kvfree_rcu_offset((unsigned long)func))
> > -             trace_rcu_kvfree_callback(rcu_state.name, head,
> > -                                      (unsigned long)func,
> > -                                      rcu_segcblist_n_cbs(&rdp->cblist=
));
> > -     else
> > -             trace_rcu_callback(rcu_state.name, head,
> > -                                rcu_segcblist_n_cbs(&rdp->cblist));
> > +     __trace_rcu_callback(head, rdp);
> >
> >       trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
> >
> > --
> > 2.37.3.968.ga6b4b080e4-goog
> >
