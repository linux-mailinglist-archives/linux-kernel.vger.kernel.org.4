Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20F6A63CF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 00:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjB1Xaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 18:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjB1Xa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:30:28 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98800F97B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:30:27 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id by8so12082353ljb.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677627026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOSxGvDXAN2XBjTFFoV5qPpPuqcyWu9fKmABaUWkmfs=;
        b=UluvzYOLn0CmJBu2rIfZPWCNBj1bg60iunkHhbMmYFNVN4tfeHPO3+wxDtyLzyzWE+
         mMLk8Wi7aJLmXjcPZNnxU6Heq5W4LcyUtu5vntA3gL8+NlDsP15jzMeE5Ht8Chb6rEVZ
         J6pJRRjGUrYX6zL4Jvhb56p8abe71e4dCRlmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677627026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOSxGvDXAN2XBjTFFoV5qPpPuqcyWu9fKmABaUWkmfs=;
        b=alfwGRmc2cqv2WCAhbIDVL1Ty2xEpeyFM0XjfzUTaLaROsGw+KUw4UM8z4JBv8Dxw6
         byReut8O4q/Jkkp8bFhHeDqTduCtcOr2lbfRSjkoV3vcH6jHFPylcpzdOjlcjdW51UmM
         NrO+yP7H2tpfRGq7AdcQJumjSlukaYriFkbqq+gcvPsfqk8+mAkxoErLiTJeNiZdqLNw
         4Q1LprRo6riOjRg9wLVGc2/ndEvrSU30v0Qvaaj7v6oVORFJi4V2vbfq8Nkl7EBgxQAY
         dwONQgtw74ePyFMN++2iTO5u/E1atv1Po+bF3Ot256+6daKz8bYr3AlQodQPVdRAy7At
         KS+g==
X-Gm-Message-State: AO0yUKW6z6cHlVBWUsPuReTbyJzxMGQf2AJoL2+Xb4XzSUB4f8po93gM
        MI5gT8A9Y7OHw4DVUFknyjJN2jQPNgqIz5YQZzQWqw==
X-Google-Smtp-Source: AK7set9xNRYPzLUDBbe907018mq80QIk4R5DUuPvY8T8qeEoSF0YbOKYjPygamDUCNdwkm9n/guf3XTS7hiQ13Dkfdg=
X-Received: by 2002:a05:651c:895:b0:293:4ab4:3bb1 with SMTP id
 d21-20020a05651c089500b002934ab43bb1mr2220633ljq.4.1677627025774; Tue, 28 Feb
 2023 15:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20230228155121.3416-1-ubizjak@gmail.com> <Y/5mguXPPqdP3MZF@google.com>
 <20230228160324.2a7c1012@gandalf.local.home> <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230228164124.77c126d2@gandalf.local.home>
In-Reply-To: <20230228164124.77c126d2@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 28 Feb 2023 18:30:14 -0500
Message-ID: <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Steve,

On Tue, Feb 28, 2023 at 4:41=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 28 Feb 2023 13:29:11 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>
> > All well and good, but the stall-warning code is nowhere near a fastpat=
h.
> >
> > Is try_cmpxchg() considered more readable in this context?
>
>
> -           cmpxchg(&rcu_state.jiffies_stall, js, jn) =3D=3D js) {
> +           try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
>
> It's basically the same :-/
>
> But looking at this use case, I'd actually NAK it, as it is misleading.

I'm trying to parse this. You are saying it is misleading, because it
updates js when it doesn't need to?

> As try_cmpxchg() is used to get rid of the updating of the old value. As =
in
> the ring buffer code we had:
>
> void ring_buffer_record_off(struct trace_buffer *buffer)
> {
>         unsigned int rd;
>         unsigned int new_rd;
>
>         do {
>                 rd =3D atomic_read(&buffer->record_disabled);
>                 new_rd =3D rd | RB_BUFFER_OFF;
>         } while (!atomic_cmpxchg(&buffer->record_disabled, &rd, new_rd) !=
=3D rd);

Hear you actually meant "rd" as the second parameter without the & ?

> }
>
> and the try_cmpxchg() converted it to:
>
> void ring_buffer_record_off(struct trace_buffer *buffer)
> {
>         unsigned int rd;
>         unsigned int new_rd;
>
>         rd =3D atomic_read(&buffer->record_disabled);
>         do {
>                 new_rd =3D rd | RB_BUFFER_OFF;
>         } while (!atomic_try_cmpxchg(&buffer->record_disabled, &rd, new_r=
d));
> }
>
> Which got rid of the need to constantly update the rd variable (cmpxchg
> will load rax with the value read, so it removes the need for an extra
> move).

So that's a good thing?

>
> But in your case, we don't need to update js, in which case the
> try_cmpxchg() does.

Right, it has lesser value here but I'm curious why you feel it also
doesn't belong in that ring buffer loop you shared (or did you mean,
it does belong there but not in other ftrace code modified by Uros?).

> The patch that Uros sent me for the ring buffer code also does some of
> that, which I feel is wrong.

I am guessing that is code *other than* the ring buffer loop above.

> So with that, I would nack the patch.

Dropping it for RCU is fine with me as well.

(And yes for the other thread, I had it backwards, try_cmpxchg is what
drops the need for cmp instruction -- sorry.)

thanks,

 -Joel
