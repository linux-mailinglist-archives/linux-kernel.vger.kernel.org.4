Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FC160F60A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiJ0LSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiJ0LSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:18:42 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF77F4184
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:18:41 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id z192so1538038yba.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTq4l/ef78moYrpScZ21ig6YKsWSFlDu+eO/n9004eE=;
        b=NEZG0rdCo1EVP07wN70uIzUx69ba88S95t7lJ0Rp01UbhhXdBEKjWyyWo+mcSX2F5d
         wRSyJPZ0glZA5jZb33SgKnwBKh+LbLRpO3PmIGMnOpA1xNYoABaVDzi8hx6ADZnNYDpt
         aQQh+pRpGDuBjw52VLk8SN4UXTQ5/r8Rn2psVi677BH70ZFWyjUjGA6YfL6TTGzNMheT
         8xzA600c0y8Ky75zZm/hKgJRo9NcgCFKCa+rypppHglMiRZ9ZFQAdMbM0B9peoejIUoQ
         WpE9V/g8/bdX95GU6UnA+KhPfN/4hHqU0nrtv5H0d72tYUkpkJmBSwoJM0WPdS7lAc6h
         9uQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTq4l/ef78moYrpScZ21ig6YKsWSFlDu+eO/n9004eE=;
        b=Sz4MU9paXklHgEVn/7/4Pnd0kdocnOn3XYMc/x206NW9HR1UjA90HK6WfVjab54cwy
         sg+3j/FA9GFvenGTJXXcEq9x8MPggoLU/+6Ro5IsLGCI+8dV9soBzV6wl9w+RB6YQ50q
         9NhvxVJ2bTQSgg7e37oL0zWuvSNz2EYkhPPclFhUWNkFL1zYtJ/la/JAYXBdGuhuQqbs
         iG1KfMezk39u3ZJdgQtnD+LB51tuJLAHN+3dkPtu4ktMpOtP3riPZauaC+gapo2v9iRP
         +SkF18rz9CnkBn2YvtI0yzkG49V6dtU0HZCvmkSQH7cot0eCWLnMzwjV6Qpt3ZpIPDr1
         4EKA==
X-Gm-Message-State: ACrzQf1BN3IGyzl1GOKVi5UnnOF5vRUBY3N4r5tG7XqNrrElD3lrAHDy
        bGip7Z/Dk4fik/jPP8DVjLyWnu4yoGr92NQHzDT1vw==
X-Google-Smtp-Source: AMsMyM50htoCOM1eEwFYOMwxYPmahs4HuqP+iHdQ2d96szeGlebl6IBzz9eU8xLd/RqiaKCiWG9xsoNXr4goR8v7MKk=
X-Received: by 2002:a25:32ca:0:b0:6ca:40e2:90c8 with SMTP id
 y193-20020a2532ca000000b006ca40e290c8mr33970276yby.55.1666869520904; Thu, 27
 Oct 2022 04:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221027114930.137735-1-luwei32@huawei.com> <CANn89iJ3Kiy7M6WRdBRwXAocFvqpR0ZbmxJ7JOg19NGSP37KfQ@mail.gmail.com>
 <CA+XRDbMX2q3MvxEEHVfkFD93pxHJ7-emLTbvj2UOBpUx_8tMtA@mail.gmail.com>
In-Reply-To: <CA+XRDbMX2q3MvxEEHVfkFD93pxHJ7-emLTbvj2UOBpUx_8tMtA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Oct 2022 04:18:30 -0700
Message-ID: <CANn89iJCctdu=3TKbQp13ffAvzc+XVAnfHw5ndDnhdXvU5peRg@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: reset tp->sacked_out when sack is enabled
To:     Pavel Emelyanov <ovzxemul@gmail.com>
Cc:     Lu Wei <luwei32@huawei.com>, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, Pavel Emelyanov <xemul@parallels.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, den@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Oct 27, 2022 at 4:14 AM Pavel Emelyanov <ovzxemul@gmail.com> wrote:
>
>
>
> =D1=87=D1=82, 27 =D0=BE=D0=BA=D1=82. 2022 =D0=B3., 14:08 Eric Dumazet <ed=
umazet@google.com>:
>>
>> On Thu, Oct 27, 2022 at 3:45 AM Lu Wei <luwei32@huawei.com> wrote:
>> >
>> > If setsockopt with option name of TCP_REPAIR_OPTIONS and opt_code
>> > of TCPOPT_SACK_PERM is called to enable sack after data is sent
>> > and before data is acked, it will trigger a warning in function
>> > tcp_verify_left_out() as follows:
>> >
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > WARNING: CPU: 8 PID: 0 at net/ipv4/tcp_input.c:2132
>> > tcp_timeout_mark_lost+0x154/0x160
>> > tcp_enter_loss+0x2b/0x290
>> > tcp_retransmit_timer+0x50b/0x640
>> > tcp_write_timer_handler+0x1c8/0x340
>> > tcp_write_timer+0xe5/0x140
>> > call_timer_fn+0x3a/0x1b0
>> > __run_timers.part.0+0x1bf/0x2d0
>> > run_timer_softirq+0x43/0xb0
>> > __do_softirq+0xfd/0x373
>> > __irq_exit_rcu+0xf6/0x140
>> >
>> > This warning occurs in several steps:
>> > Step1. If sack is not enabled, when server receives dup-ack,
>> >        it calls tcp_add_reno_sack() to increase tp->sacked_out.
>> >
>> > Step2. Setsockopt() is called to enable sack
>> >
>> > Step3. The retransmit timer expires, it calls tcp_timeout_mark_lost()
>> >        to increase tp->lost_out but not clear tp->sacked_out because
>> >        sack is enabled and tcp_is_reno() is false.
>> >
>> > So tp->left_out is increased repeatly in Step1 and Step3 and it is
>> > greater than tp->packets_out and trigger the warning. In function
>> > tcp_timeout_mark_lost(), tp->sacked_out will be cleared if Step2 not
>> > happen and the warning will not be triggered. As suggested by Denis
>> > and Eric, TCP_REPAIR_OPTIONS should be prohibited if data was already
>> > sent.
>> >
>> > socket-tcp tests in CRIU has been tested as follows:
>> > $ sudo ./test/zdtm.py run -t zdtm/static/socket-tcp*  --keep-going \
>> >        --ignore-taint
>> >
>> > socket-tcp* represent all socket-tcp tests in test/zdtm/static/.
>> >
>> > Fixes: b139ba4e90dc ("tcp: Repair connection-time negotiated parameter=
s")
>> > Signed-off-by: Lu Wei <luwei32@huawei.com>
>> > ---
>> >  net/ipv4/tcp.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> > index ef14efa1fb70..ef876e70f7fe 100644
>> > --- a/net/ipv4/tcp.c
>> > +++ b/net/ipv4/tcp.c
>> > @@ -3647,7 +3647,7 @@ int do_tcp_setsockopt(struct sock *sk, int level=
, int optname,
>> >         case TCP_REPAIR_OPTIONS:
>> >                 if (!tp->repair)
>> >                         err =3D -EINVAL;
>> > -               else if (sk->sk_state =3D=3D TCP_ESTABLISHED)
>> > +               else if (sk->sk_state =3D=3D TCP_ESTABLISHED && !tp->p=
ackets_out)
>>
>> You keep focusing on packets_out  :/
>>
>> What I said was : TCP_REPAIR_OPTIONS must be denied if any packets
>> have been sent (and possibly already ACK)
>
>
>
> If repair mode is ON, why does socket send any packets? This shouldn't ha=
ppen from my perspective.

Exactly.

TCP_REPAIR is easily abused by fuzzers.

We need to enforce sanity rules in the kernel, not assuming user space
is following the CRIU way of doing things.

>
> -- Pavel
>
>>
>> Looking at tp->packets_out alone is not sufficient.
>>
>> >                         err =3D tcp_repair_options_est(sk, optval, opt=
len);
>> >                 else
>> >                         err =3D -EPERM;
>> > --
>> > 2.31.1
>> >
