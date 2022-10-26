Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17B60E35B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiJZObL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbiJZObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:31:09 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7868FE52DF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:31:08 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-369426664f9so149083847b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ5F1pjW8SMEXXHoQZ6QOHXEeoztHvn/vAaV/N7Q4oI=;
        b=Gsr8KaLxasXc4l5zrmV5WhlFPdgEtfHHjDx4RW3kHJyo5NwG1SZa55oM5xn0EP3Vpq
         nJOCb14YXZnPsDCk3AajqOrxBo3etW5seZVStyr49l/OwavxhNEdKnKz3s+D6r5ioMJP
         1Z2LpwQir5PHPNGJXLWBAsTJl4Prs6dDLKjRqGm5IM3w0/0Jf3gDES2Lh0gGeoj5ucs6
         M1qU5gsM4ETE398ftu/uRgMv39Ey8rRdEjgY5yNkppgvWiEa1YYOljF927CEYhq2DOn1
         lgji5dzlzUw3J63HXgIb5GbwUaaN6ckX7ZdSjsZChJi2zktUGPAFxYyWOhZ3M5iGb3VP
         wBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJ5F1pjW8SMEXXHoQZ6QOHXEeoztHvn/vAaV/N7Q4oI=;
        b=frnvNtn/JoT4G79oaEVLXwzcSzo0SzZ/Ef3OnysyNiiNfK9qcXuG8yrbg5meTG+gb/
         vXuYuzEtAQc6TCOS7s94EK2LP6NJhSzB6tqd0V7hazRY7tYZhq231to8A42kJaWnewHW
         AJBuLDy04G+Pdbw9J+94xJJRO5ZuBmQYEPelw0iD4ggyzIwasAX/1iuzGU4Iw1oiPlT5
         aQvDDn+LTXZHr9tJgCdp5/+j2roQlfW9HrSYTM+B5SRH4y4QmLUuFZCbiUfF14bB5kLI
         Rvyw+UI1ccVaVMhEf0u8larq8LBmTV5cnue5edjhVOCkdv8/OpJs57XWQy2Pc0QD1J0r
         ogFQ==
X-Gm-Message-State: ACrzQf13JHXmy0eVtV7yQZ0vj8rcut3YjtZpg21YybhYXX8WAxKaZmYP
        FG8udVIR5RGjQMhpQst0jBMAiSEtupKjIp8+TthxvA==
X-Google-Smtp-Source: AMsMyM7UZ69oVZczuSIXICeiTOFlXJbU5fAgP0OPxJsKQTmACTH9ACkVKBlggaJTW/1YUvn8+bROtDUgJEnfSACmOw0=
X-Received: by 2002:a81:1b09:0:b0:35d:cf91:aadc with SMTP id
 b9-20020a811b09000000b0035dcf91aadcmr39507860ywb.47.1666794667345; Wed, 26
 Oct 2022 07:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221026151558.4165020-1-luwei32@huawei.com>
In-Reply-To: <20221026151558.4165020-1-luwei32@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 26 Oct 2022 07:30:56 -0700
Message-ID: <CANn89iJQn5ET3U9cYeiT0ijTkab2tRDBB1YP3Y6oELVq0dj6Zw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: reset tp->sacked_out when sack is enabled
To:     Lu Wei <luwei32@huawei.com>, Pavel Emelyanov <xemul@openvz.org>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, xemul@parallels.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Oct 26, 2022 at 7:12 AM Lu Wei <luwei32@huawei.com> wrote:
>
> The meaning of tp->sacked_out depends on whether sack is enabled
> or not. If setsockopt is called to enable sack_ok via
> tcp_repair_options_est(), tp->sacked_out should be cleared, or it
> will trigger warning in tcp_verify_left_out as follows:
>
> ============================================
> WARNING: CPU: 8 PID: 0 at net/ipv4/tcp_input.c:2132
> tcp_timeout_mark_lost+0x154/0x160
> tcp_enter_loss+0x2b/0x290
> tcp_retransmit_timer+0x50b/0x640
> tcp_write_timer_handler+0x1c8/0x340
> tcp_write_timer+0xe5/0x140
> call_timer_fn+0x3a/0x1b0
> __run_timers.part.0+0x1bf/0x2d0
> run_timer_softirq+0x43/0xb0
> __do_softirq+0xfd/0x373
> __irq_exit_rcu+0xf6/0x140
>
> This warning occurs in several steps:
> Step1. If sack is not enabled, when server receives dup-ack,
>        it calls tcp_add_reno_sack() to increase tp->sacked_out.
>
> Step2. Setsockopt() is called to enable sack
>
> Step3. The retransmit timer expires, it calls tcp_timeout_mark_lost()
>        to increase tp->lost_out but not clear tp->sacked_out because
>        sack is enabled and tcp_is_reno() is false.
>
> So tp->left_out is increased repeatly in Step1 and Step3 and it is
> greater than tp->packets_out and trigger the warning. In function
> tcp_timeout_mark_lost(), tp->sacked_out will be cleared if Step2 not
> happen and the warning will not be triggered. So this patch clears
> tp->sacked_out in tcp_repair_options_est().
>
> Fixes: b139ba4e90dc ("tcp: Repair connection-time negotiated parameters")
> Signed-off-by: Lu Wei <luwei32@huawei.com>
> ---
>  net/ipv4/tcp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index ef14efa1fb70..188d5c0e440f 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3282,6 +3282,9 @@ static int tcp_repair_options_est(struct sock *sk, sockptr_t optbuf,
>                         if (opt.opt_val != 0)
>                                 return -EINVAL;
>
> +                       if (tcp_is_reno(tp))
> +                               tp->sacked_out = 0;
> +
>                         tp->rx_opt.sack_ok |= TCP_SACK_SEEN;
>                         break;
>                 case TCPOPT_TIMESTAMP:
> --
> 2.31.1
>

Hmm, I am not sure this is the right fix.

Probably TCP_REPAIR_OPTIONS should not be allowed if data has already been sent.

Pavel, what do you think ?
