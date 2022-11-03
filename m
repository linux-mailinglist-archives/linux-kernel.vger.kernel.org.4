Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A87B617431
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiKCC2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCC1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:27:51 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B646A13D22
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:27:49 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3691e040abaso3474537b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 19:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17bwDB9IUgW3fyUTGB1tmRx1t29eVKRpvShoVqwSTlI=;
        b=SywoVxu8/kMN83AOdkVe+jhz39+TEf2NKeiWDIOg+YHMlt6vZ7IYZwxevkvgHBwAYl
         1jzgc61vVajEIn7JITLnLE3zWR11EpXA7676b9X0YMpP8doLMnDEmQHfYoa43uMMhuK6
         1Vzg0oCFFdwoca5ayGFGnQuFNIDGPkoipPdPBgvon2fZhebx9hTDR9pWsajiXE/2S8E9
         mYe0IZiKf+JkvaPTKgbuhIG6XVXjZmF02SKgqn1txKWQiyJwjCKCtUdyupRO1G63zX9P
         4a2akJvVVCmwzihbmUhlqEyhCJ5JeNrPqP547mU7K1UlxHvfovYoydPESByfHapoicmr
         5HIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17bwDB9IUgW3fyUTGB1tmRx1t29eVKRpvShoVqwSTlI=;
        b=QJsLCdZmMAkSIClzUUcpqUuANeizMiU2wP3UNV6F3PIqF6A+BptsP9NX9eHaBYkGgD
         +5d6CeRGGQetrnJzYES/p0wUUERbqp3j8D4scl2TT8Yvnt2Mu1J4KRqEzjc2PNQOcBkK
         nP2H3+HgqtrDc0UszTkzT/YGdG0EfKWaFH+9N748lczH+99r9mW+HeeiUHHwOz4NGzmi
         5Dw6PanGeW/QRhmMc5qfMq2BiNxCKyMINGJofU14Tsf192EckGikWcHY7hvs7nXfspeB
         G9jzGvFFE6K0nnpxJRtf6airOqHgWg746pytIJONTpFFq5f7dVVPxJ8E6cuqO0amEpAP
         DVhA==
X-Gm-Message-State: ACrzQf2jXO3rbih/JZD4u0Mh06kzH6hCy8u+pVKH4AwcDq59WJoqiuik
        SAqYs4Z3R10bSbBxjQiiqaYlqIuOxmys3aa0ON2h5Q==
X-Google-Smtp-Source: AMsMyM5WGDS1VFcxq1kb2SeMNhpTSWyoWmrqPAKIlSV/Wg34ZLIvaoL9a36VZSnMm1+ur/Q6LegwBwKaUWYS4cvtNX8=
X-Received: by 2002:a81:5a86:0:b0:36f:cece:6efd with SMTP id
 o128-20020a815a86000000b0036fcece6efdmr25750884ywb.489.1667442468618; Wed, 02
 Nov 2022 19:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221102132811.70858-1-luwei32@huawei.com> <CADVnQy=uE68AWKuSddKEt3T2X=HUYzs0SQPX31+HgafuysJzkA@mail.gmail.com>
 <ef5c0948-1a40-e4b7-5b1b-629cfcad1c37@huawei.com>
In-Reply-To: <ef5c0948-1a40-e4b7-5b1b-629cfcad1c37@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 2 Nov 2022 19:27:36 -0700
Message-ID: <CANn89i+e8OWGzyXCyrbHSLyfdLct8ENP52=AbDdUrg5kKmMprQ@mail.gmail.com>
Subject: Re: [patch net v3] tcp: prohibit TCP_REPAIR_OPTIONS if data was
 already sent
To:     "luwei (O)" <luwei32@huawei.com>
Cc:     Neal Cardwell <ncardwell@google.com>, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, xemul@parallels.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Nov 2, 2022 at 7:11 PM luwei (O) <luwei32@huawei.com> wrote:
>
>
> =E5=9C=A8 2022/11/2 10:46 PM, Neal Cardwell =E5=86=99=E9=81=93:
> > On Wed, Nov 2, 2022 at 8:23 AM Lu Wei <luwei32@huawei.com> wrote:
> >> If setsockopt with option name of TCP_REPAIR_OPTIONS and opt_code
> >> of TCPOPT_SACK_PERM is called to enable sack after data is sent
> >> and before data is acked, ...
> > This "before data is acked" phrase does not quite seem to match the
> > sequence below, AFAICT?
> >
> > How about something like:
> >
> >   If setsockopt TCP_REPAIR_OPTIONS with opt_code TCPOPT_SACK_PERM
> >   is called to enable SACK after data is sent and the data sender recei=
ves a
> >   dupack, ...
>       yes, thanks for suggestion
> >
> >
> >> ... it will trigger a warning in function
> >> tcp_verify_left_out() as follows:
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> WARNING: CPU: 8 PID: 0 at net/ipv4/tcp_input.c:2132
> >> tcp_timeout_mark_lost+0x154/0x160
> >> tcp_enter_loss+0x2b/0x290
> >> tcp_retransmit_timer+0x50b/0x640
> >> tcp_write_timer_handler+0x1c8/0x340
> >> tcp_write_timer+0xe5/0x140
> >> call_timer_fn+0x3a/0x1b0
> >> __run_timers.part.0+0x1bf/0x2d0
> >> run_timer_softirq+0x43/0xb0
> >> __do_softirq+0xfd/0x373
> >> __irq_exit_rcu+0xf6/0x140
> >>
> >> The warning is caused in the following steps:
> >> 1. a socket named socketA is created
> >> 2. socketA enters repair mode without build a connection
> >> 3. socketA calls connect() and its state is changed to TCP_ESTABLISHED
> >>     directly
> >> 4. socketA leaves repair mode
> >> 5. socketA calls sendmsg() to send data, packets_out and sack_outs(dup
> >>     ack receives) increase
> >> 6. socketA enters repair mode again
> >> 7. socketA calls setsockopt with TCPOPT_SACK_PERM to enable sack
> >> 8. retransmit timer expires, it calls tcp_timeout_mark_lost(), lost_ou=
t
> >>     increases
> >> 9. sack_outs + lost_out > packets_out triggers since lost_out and
> >>     sack_outs increase repeatly
> >>
> >> In function tcp_timeout_mark_lost(), tp->sacked_out will be cleared if
> >> Step7 not happen and the warning will not be triggered. As suggested b=
y
> >> Denis and Eric, TCP_REPAIR_OPTIONS should be prohibited if data was
> >> already sent. So this patch checks tp->segs_out, only TCP_REPAIR_OPTIO=
NS
> >> can be set only if tp->segs_out is 0.
> >>
> >> socket-tcp tests in CRIU has been tested as follows:
> >> $ sudo ./test/zdtm.py run -t zdtm/static/socket-tcp*  --keep-going \
> >>         --ignore-taint
> >>
> >> socket-tcp* represent all socket-tcp tests in test/zdtm/static/.
> >>
> >> Fixes: b139ba4e90dc ("tcp: Repair connection-time negotiated parameter=
s")
> >> Signed-off-by: Lu Wei <luwei32@huawei.com>
> >> ---
> >>   net/ipv4/tcp.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> >> index ef14efa1fb70..1f5cc32cf0cc 100644
> >> --- a/net/ipv4/tcp.c
> >> +++ b/net/ipv4/tcp.c
> >> @@ -3647,7 +3647,7 @@ int do_tcp_setsockopt(struct sock *sk, int level=
, int optname,
> >>          case TCP_REPAIR_OPTIONS:
> >>                  if (!tp->repair)
> >>                          err =3D -EINVAL;
> >> -               else if (sk->sk_state =3D=3D TCP_ESTABLISHED)
> >> +               else if (sk->sk_state =3D=3D TCP_ESTABLISHED && !tp->s=
egs_out)
> > The tp->segs_out field is only 32 bits wide. By my math, at 200
> > Gbit/sec with 1500 byte MTU it can wrap roughly every 260 secs. So a
> > caller could get unlucky or carefully sequence its call to
> > TCP_REPAIR_OPTIONS (based on packets sent so far) to mess up the
> > accounting and trigger the kernel warning.
> >
> > How about using some other method to determine if this is safe?
> > Perhaps using tp->bytes_sent, which is a 64-bit field, which by my
> > math would take 23 years to wrap at 200 Gbit/sec?
> >
> > If we're more paranoid about wrapping we could also check
> > tp->packets_out, and refuse to allow TCP_REPAIR_OPTIONS if either
> > tp->bytes_sent or tp->packets_out are non-zero. (Or if we're even more
> > paranoid I suppose we could have a special new bit to track whether
> > we've ever sent something, but that probably seems like overkill?)
> >
> > neal
> > .
>
> I didn't notice that u32 will be easily wrapped in huge network throughpu=
t,
> thank you neal.
>
> But tcp->packets_out shoud not be used because tp->packets_out can decrea=
se
> when expected ack is received, so it can decrease to 0 and this is the co=
mmon
> condition.

Right, so just use tp->bytes_sent

I doubt syzbot will be patient enough to wait for an overflow.
