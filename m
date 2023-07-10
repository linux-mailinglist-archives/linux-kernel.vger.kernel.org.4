Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F179774DEA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjGJTzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGJTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:55:37 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12C2195
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:55:32 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so75285041fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689018931; x=1691610931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TuJbNypnpVhs5ccy6VCzsot2pQTpKecsxvKdtZKIDc=;
        b=KPJY8cRksPc5Z0O4jWdx7NaLRSVgzJf7zoaN5iN7Rjd6JBlPbUP34t0S/Wyeb7wVYS
         ZbtV1VnLSxowjpQqlvSoo6PWBGw3jzIYzeGPqrtpvxnFa+qkAceQdPECK/D2bcoFQX2J
         rXi3290F7MqI0Vesipb7e2xYmoyzpcTfIiWC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689018931; x=1691610931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TuJbNypnpVhs5ccy6VCzsot2pQTpKecsxvKdtZKIDc=;
        b=doRNS/q1hUQT3f/DF1PLAMha6PXA63sN79X3M2Kez9ZYgE3dvd41v7o1pMu/Y0+tE+
         EweL+zXutiQCS/kgmaQ3E3BHBGXM+aOGuG3wCbZd7eobOn8lQJ1M7HxlrXUzgIIDn2zX
         TqskFvWoxFWQWbtAYp2DVq7h+IQ5pSjzj6E2vXHSEj0ZceVp9CvjyPPtp82rulGd7CjO
         TERtztA2T/iDvghisfRyk4x5PnMxFNoo3VC/sBbx5+UHhkgMqgZy+/uGBIv2QrN/EGyg
         o15UG0b4B1UFRGK29OALm7jz9mCLuwtQKrfquv1xlOh+Il64qMQQ7YfaXd4e93IMKm3P
         0EIw==
X-Gm-Message-State: ABy/qLYUN3guVlTRXS23NOGW58G4NLClTxay96mpbx+vF6f1h9sawjVw
        1ihJwQRBu6TpYamnvRe+etTWejCrI4WCXHSMPXfpig==
X-Google-Smtp-Source: APBJJlE4GzEUhPNneqnHqAZyN9Cx1VMgS7n20DanqbTLQGz6tmFOKOmRk65skdqR0hjsqqeCdwk5pQFdcx/oW8GsqgA=
X-Received: by 2002:a2e:8706:0:b0:2b6:cca1:975f with SMTP id
 m6-20020a2e8706000000b002b6cca1975fmr11339961lji.13.1689018930148; Mon, 10
 Jul 2023 12:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230705073020.2030-1-thunder.leizhen@huawei.com>
 <20230705073020.2030-3-thunder.leizhen@huawei.com> <39430021-dc0d-4abd-8266-642e4e2dc7df@paulmck-laptop>
In-Reply-To: <39430021-dc0d-4abd-8266-642e4e2dc7df@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 10 Jul 2023 15:55:16 -0400
Message-ID: <CAEXW_YR_t-x-eYKLFmruOLqZv91oi=AJKEEeuqYosejjdscn1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rcu: Don't dump the stalled CPU on where RCU GP
 kthread last ran twice
To:     paulmck@kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 3:06=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Jul 05, 2023 at 03:30:20PM +0800, Zhen Lei wrote:
> > The stacks of all stalled CPUs will be dumped. If the CPU on where RCU =
GP
> > kthread last ran is stalled, its stack does not need to be dumped again=
.
> >
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>
> This one looks good.  Please feel free to rebase it before 1/2 and repost=
.

Just a small comment:
I wondered if this would make it harder to identify which stack among
the various CPU stacks corresponds to the one the GP kthread is
running on. However, this line does print the CPU number of the
thread, so it is perhaps not an issue:

                pr_err("%s kthread starved for %ld jiffies! g%ld f%#x
%s(%d) ->state=3D%#x ->cpu=3D%d\n",

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks.
