Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DDE66132D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 03:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjAHCtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 21:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjAHCtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 21:49:00 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9348136310
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 18:48:59 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v14so5397951qtq.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 18:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmjqh7ONQeiJtR4exSx+UURxXponkPwmMhBpHFeoyTQ=;
        b=ni1I5PAVgPwwKBIJ9xl3ttYhrP/rei7HmXi4KIz/G6eXEkebB0s9/GVqqS6dt84Qoc
         ScDbnr8PCi97a+dBat9wMbm5EBayKXNwOEcD3MspJszw4XStISB6Mi2L8hFAGciNehDk
         Mmw9I2vIi6fQQ0yy3nDB37Rg01sXVIubSpRSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmjqh7ONQeiJtR4exSx+UURxXponkPwmMhBpHFeoyTQ=;
        b=EpbcPue8vQ+LoK28NBJXduSyoeRs8hItuztCf0J+Jd3FnfJQx2gz42/lOmZdhWSdsv
         WLlTvQhxjF5JI++wQWkXI0Kz1QMoJuidQynVTeSEJ3Mdy3i09l2dSyG6za5mtQZSvGXX
         s+VgH2ujMqSuzoxYqn3VUi9kolNw0hU+0XWtIQ43MJgH3PnieY590awdlA270ZFAlrK9
         8DFoS6atPPfIdbeBiTfLqFZW2NWt/MIml3ZrnxC/FRIk2Ol/bHd70oV5nSEAM42e3ZEM
         5AKBbZgYdM2iPhycwKwwQloUYxwUb+N6IPj6YwjQplLLo5a9Q7XqnzdNIjcYyeJ25KJi
         pJOg==
X-Gm-Message-State: AFqh2kr7rweM2yx71T9xoBFy+y3KoUL7gN8x1O5Wx9s8pRi9fKnaF5cW
        uWXtRyAhuinB85MhDh15IyMW/Q==
X-Google-Smtp-Source: AMrXdXtJaUwY+5UcLFMu588QHftqM17Zb7ru7PnBOY9b9ENuIuo9+idkWEi9Hg5b2haaFkDpO+HJqA==
X-Received: by 2002:ac8:4408:0:b0:3a9:8984:1103 with SMTP id j8-20020ac84408000000b003a989841103mr77846169qtn.67.1673146138702;
        Sat, 07 Jan 2023 18:48:58 -0800 (PST)
Received: from smtpclient.apple ([2600:1003:b86e:d9d2:d5be:1589:426a:b60])
        by smtp.gmail.com with ESMTPSA id t1-20020ac86a01000000b003a7e4129f83sm2653833qtr.85.2023.01.07.18.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 18:48:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Date:   Sat, 7 Jan 2023 21:48:46 -0500
Message-Id: <0BF2065B-1E02-498C-B999-EB52F005B62E@joelfernandes.org>
References: <Y7nuFrJ3gjNzXmCz@lothringen>
Cc:     paulmck@kernel.org, Zqiang <qiang1.zhang@intel.com>,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y7nuFrJ3gjNzXmCz@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jan 7, 2023, at 5:11 PM, Frederic Weisbecker <frederic@kernel.org> wrot=
e:
>=20
> =EF=BB=BFOn Fri, Jan 06, 2023 at 07:01:28PM -0500, Joel Fernandes wrote:
>> (lost html content)

My problem is the iPhone wises up when I put a web link in an email. I want t=
o look into smtp relays but then if I spent time on fixing that, I might not=
 get time to learn from emails like these...=20

> I can't find a place where the exp grace period sends an IPI to
> CPUs slow to report a QS. But anyway you really need the tick to poll
> periodically on the CPU to chase a quiescent state.

Ok.

> Now arguably it's probably only useful when CONFIG_PREEMPT_COUNT=3Dy
> and rcu_exp_handler() has interrupted a preempt-disabled or bh-disabled
> section. Although rcu_exp_handler() sets TIF_RESCHED, which is handled
> by preempt_enable() and local_bh_enable() when CONFIG_PREEMPT=3Dy.
> So probably it's only useful when CONFIG_PREEMPT_COUNT=3Dy and CONFIG_PREE=
MPT=3Dn
> (and there is also PREEMPT_DYNAMIC to consider).

Makes sense. I think I was missing this use case and was going by the genera=
l design of exp grace periods.  I was incorrectly assuming the IPIs were bei=
ng sent repeatedly for hold out CPUs, which is not the case I think. But tha=
t would another way to fix it?

But yeah I get your point, the first set of IPIs missed it, so we need the r=
escue-tick for long non-rcu_read_lock() implicit critical sections..=20

> If CONFIG_PREEMPT_COUNT=3Dn, the tick can only report idle and user
> as QS, but those are already reported explicitly on ct_kernel_exit() ->
> rcu_preempt_deferred_qs().

Oh hmm, because that function is a NOOP for PREEMPT_COUNT=3Dy and PREEMPT=3D=
n and will not report the deferred QS?  Maybe it should then. However I thin=
k the tick is still useful if after the preempt disabled section, will still=
 did not exit the kernel.

We ought to start another Google doc on all of this if we have not yet=E2=80=
=A6

Thanks!

 - Joel

>=20
> Thanks.
>=20
>=20
