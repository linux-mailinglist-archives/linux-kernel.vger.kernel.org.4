Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFBE661342
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 03:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjAHCzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 21:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAHCzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 21:55:35 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32353631F
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 18:55:34 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z12so5368960qtv.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 18:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94VSKeewKQqz3/G+JzLpoWpxUxDnKLtB9JPUkyqWDYY=;
        b=jSGmaf2LjAm4LbCT4TUN3tOjD6YzGbMeXFn2kCYtuo2jVWeVr5VgCLN/h51cZUnIsI
         J37RC47iZoFPsVLcjMn1hNzIEh6sIdqtJnA43ZEXyXLBu5vClsT8AfAmCN5X+Mm1ysOE
         MoSKz+N1GiJ5d6yYf6HwFXKMIVFFr71vS1FyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94VSKeewKQqz3/G+JzLpoWpxUxDnKLtB9JPUkyqWDYY=;
        b=tRz9jQiRl8+pgeDLA3xuiEACWHdU1AILfWVX/aGHZFOZQ+7bBAQpLjqpntqw1/3vwu
         aoxtIJXVdBo+p2jlsVqYIpvtD3c5tGFJb3XgenC1NeaDgpQXr44YN8pbychEeNvoxeRs
         fwrbS9YT0XOY30raQofwJ5/JiScCU23+1peiYG4cFP5PMxDq7OfSQPwgkY6MjmG9lAhi
         pZJHvqG0FNeD9bgPs/Z3WcZh99Z1KQXTz8JsgDKKuXHtGYeMPNuIGiLozAfdHbyHoD3y
         g/uj3rTH4odpdZE+Hnb+kTOrbQWTLhuxrviX9QlCGIhzJPgEmTWn8rUEWg3dnj2iJC6i
         q6kg==
X-Gm-Message-State: AFqh2koOgFWVGbxt7HrHuJ7Om4Cac3zChFSI6aJSZxj1IkPaN+sUFwrv
        hsgvu/Du0ZSlLYKNj7q3ELnAhw==
X-Google-Smtp-Source: AMrXdXuyn/qox9tbjXom/kxe34t7sYA3lHGzPubUtOj0H5bzQSk8e89U+tEsuNczLqtQQAbuw+Nw4g==
X-Received: by 2002:ac8:7ed8:0:b0:3a7:ed21:ac47 with SMTP id x24-20020ac87ed8000000b003a7ed21ac47mr83673227qtj.18.1673146533997;
        Sat, 07 Jan 2023 18:55:33 -0800 (PST)
Received: from smtpclient.apple ([2600:1003:b86e:d9d2:d5be:1589:426a:b60])
        by smtp.gmail.com with ESMTPSA id l13-20020ac8724d000000b00399fe4aac3esm2677044qtp.50.2023.01.07.18.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 18:55:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Date:   Sat, 7 Jan 2023 21:55:22 -0500
Message-Id: <D445A93C-8315-4407-A8E4-C377BF63058A@joelfernandes.org>
References: <0BF2065B-1E02-498C-B999-EB52F005B62E@joelfernandes.org>
Cc:     paulmck@kernel.org, Zqiang <qiang1.zhang@intel.com>,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <0BF2065B-1E02-498C-B999-EB52F005B62E@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 7, 2023, at 9:48 PM, Joel Fernandes <joel@joelfernandes.org> wrote:=

>=20
> =EF=BB=BF
>>> On Jan 7, 2023, at 5:11 PM, Frederic Weisbecker <frederic@kernel.org> wr=
ote:
>>>=20
>>> =EF=BB=BFOn Fri, Jan 06, 2023 at 07:01:28PM -0500, Joel Fernandes wrote:=

>>> (lost html content)
>=20
> My problem is the iPhone wises up when I put a web link in an email. I wan=
t to look into smtp relays but then if I spent time on fixing that, I might n=
ot get time to learn from emails like these...=20
>=20
>> I can't find a place where the exp grace period sends an IPI to
>> CPUs slow to report a QS. But anyway you really need the tick to poll
>> periodically on the CPU to chase a quiescent state.
>=20
> Ok.
>=20
>> Now arguably it's probably only useful when CONFIG_PREEMPT_COUNT=3Dy
>> and rcu_exp_handler() has interrupted a preempt-disabled or bh-disabled
>> section. Although rcu_exp_handler() sets TIF_RESCHED, which is handled
>> by preempt_enable() and local_bh_enable() when CONFIG_PREEMPT=3Dy.
>> So probably it's only useful when CONFIG_PREEMPT_COUNT=3Dy and CONFIG_PRE=
EMPT=3Dn
>> (and there is also PREEMPT_DYNAMIC to consider).
>=20
> Makes sense. I think I was missing this use case and was going by the gene=
ral design of exp grace periods.  I was incorrectly assuming the IPIs were b=
eing sent repeatedly for hold out CPUs, which is not the case I think. But t=
hat would another way to fix it?
>=20
> But yeah I get your point, the first set of IPIs missed it, so we need the=
 rescue-tick for long non-rcu_read_lock() implicit critical sections..=20
>=20
>> If CONFIG_PREEMPT_COUNT=3Dn, the tick can only report idle and user
>> as QS, but those are already reported explicitly on ct_kernel_exit() ->
>> rcu_preempt_deferred_qs().
>=20
> Oh hmm, because that function is a NOOP for PREEMPT_COUNT=3Dy and PREEMPT=3D=
n and will not report the deferred QS?  Maybe it should then. However I thin=
k the tick is still useful if after the preempt disabled section, will still=
 did not exit the kernel.

I think meant I here, an atomic section (like bh or Irq disabled). There is n=
o such thing as disabling preemption for CONFIG_PREEMPT=3Dn. Or maybe I am c=
onfused again.  This RCU thing=E2=80=A6

Thanks.


>=20
> We ought to start another Google doc on all of this if we have not yet=E2=80=
=A6
>=20
> Thanks!
>=20
> - Joel
>=20
>>=20
>> Thanks.
>>=20
>>=20
