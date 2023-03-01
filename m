Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5066A645F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCAApr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjCAApo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:45:44 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D936EB5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:45:43 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id x6so6620275ljq.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 16:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677631541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5m78WOJU8Q8f13mfbwHzzeODEphAMSlmLmtQWAwznk=;
        b=vpxgg+RzU+WKen19EqJk1/2sn3MXymj9IIvV/DR2kisgIdPkoFuP3jcfGI67/Rt3yY
         5eFWE/bDHwCeOjzjavdS0mY9XG34GY+ykXfnDVE+sxxPFzNXE59BN7LcqrLcG61zkrNu
         g6fLacramYtPypiSVZjQyPcjEwaWp+NBGS7NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677631541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5m78WOJU8Q8f13mfbwHzzeODEphAMSlmLmtQWAwznk=;
        b=yAPww++93WxV4irVVI0VFtrcWbRC48OaZJzgpcuLfC2hwPYDmjHhRICZyOYbv6RunS
         3Xz+kgYTfFzu2OJMG+5p8hx8jkb3q7KZYiBidpXNbKFarsAyCfaVKsuhtxfObvL9QQip
         0Tdd1BmAEai/FW4EYXGOrQ/JbeERk8wbIetN1PLPiF23sRCyaV2T0TIhDChlqIwZBTdf
         pRho1n9QO7vMU1uDLxwtfIo3GuZIi6nE8271dMDmXSQirY/G8LBCT5a3jhdseX/nZxWB
         gWWJLvOjwhymx8pLA+5SAVvx/RYk//dgz3L3RUUA+eOU/pLPodA9bRuOsoJowtHWaQcj
         M83w==
X-Gm-Message-State: AO0yUKXmhw5/VJRFbhSypALvc9ZOql/FU48LQ35l2xyQsjJK5QIQLuxj
        rzQl1Ve7uVZjJQvWdLnmmqX+3N/++OXaPjrXoO6lYU3YmYiwFg==
X-Google-Smtp-Source: AK7set9/hh2o8bm+fHkpcQlrQgSugVTdVkvXiR4SF1VBEJL6/MYChjro+BqRIATBG8FcsZvy4Kopido8eRPwR7bEO+4=
X-Received: by 2002:a05:651c:b9b:b0:295:8ef2:8744 with SMTP id
 bg27-20020a05651c0b9b00b002958ef28744mr1400092ljb.3.1677631541365; Tue, 28
 Feb 2023 16:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20230228155121.3416-1-ubizjak@gmail.com> <Y/5mguXPPqdP3MZF@google.com>
 <20230228160324.2a7c1012@gandalf.local.home> <20230228212911.GX2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230228164124.77c126d2@gandalf.local.home> <CAEXW_YQ515_DOLVUm48GvDADuaY2mSrYTaKa7u6jYDNqBncJww@mail.gmail.com>
 <20230228190846.79b06089@gandalf.local.home>
In-Reply-To: <20230228190846.79b06089@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 28 Feb 2023 19:45:30 -0500
Message-ID: <CAEXW_YTRG+7oTGgmqSKpC6Wzft6vsjOzEDkN=eLpcEWeAxYwdg@mail.gmail.com>
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

On Tue, Feb 28, 2023 at 7:08=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
[...]
> >
> > >
> > > But in your case, we don't need to update js, in which case the
> > > try_cmpxchg() does.
> >
> > Right, it has lesser value here but I'm curious why you feel it also
> > doesn't belong in that ring buffer loop you shared (or did you mean,
> > it does belong there but not in other ftrace code modified by Uros?).
>
> The ring buffer patch had more than one change, where half the updates we=
re
> fine, and half were not.

Thanks for all the clarifications. Good to know such loop design
patterns can benefit from it!


 - Joel
