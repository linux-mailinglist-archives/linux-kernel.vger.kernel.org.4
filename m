Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6F60F5EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiJ0LJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ0LIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:08:53 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935A5DD886
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:08:52 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-368edbc2c18so9902357b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cvN8zMp/kGbBVRdZ2w/ZaO+JP8ztxqKFdgd3JqFW+5I=;
        b=ZMeBl5zizFmkZJor2OkucWX40X5KUqJbRNAu4GwhRJB3heXDBztLwAmmqYUOC1gXxU
         srRy6Yzbjtf7O0wUfOo9SD9Qi9vL+AUE/pAlBw7LqZpZI2FjZfnKQuO3KMxczVCnFxcQ
         LSy9q36JksjSgml0Vx+7grVv7UIKOAc5YX/hap5q4BJsYeMHSAl+f2NoW2sagreDlzbe
         Zi3p1bcm5U5Q5CNTSJfftOUZjm1+tf91QLaUN57y91L0HTtd5LiCFT87XvVMflml57hz
         sHR27CJpNz3Ua/8jGuK6ihsMIzT8sry//0AD+nvQTgsYkUit3Txa6Q8mz4cHhGWiYZKU
         9RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvN8zMp/kGbBVRdZ2w/ZaO+JP8ztxqKFdgd3JqFW+5I=;
        b=qzXgEDMbdeA2U4LF8k6sMkW9qF+TD0P8EZRFG/nskNwPnsSR+GVcxKcoTPZcYv6jcg
         Bf4tmW+aZdDjN5Rm/M4v+8dWZ4mDY9mHBtrLkZ3PHn1CLhe4F4NJoiljkUk+hGKjSsEH
         A14jkFtXNxq5eG12cTgZIU+z6CU+YDozPIMiOVDCAMmp2em8c+Xk7m+++VmPSEVvZrAD
         uzd8K3XNL9nUkh1PaFLFa4bdtpnAHAukk3S3PX+yb2sMZNntJipuQAM6WC9QeH9N9vml
         JFGhGoIsRxsA+R4J6JthHSYUB8YqLtFzUMp0Unfx37RTU8O2/ADh40T9e/YW2vGfWe5e
         jquA==
X-Gm-Message-State: ACrzQf2sMnE4YBR00PWkoe6Dvuq3hNiTuE1Sq5sGCoxuQOm3NC95JBNH
        dGQLH7fWhmpDtB+t9VdaWwgZNIp3v5Hgf1Lt403BEg==
X-Google-Smtp-Source: AMsMyM5sMyl3cH49vBlzh9pKybtVWOnAyuTN9IW14NAuG3Xf3R5lb9vreRLQCOosoTtsFhwEMRUHItLLfNRDKk0QVnk=
X-Received: by 2002:a81:c11:0:b0:36a:bcf0:6340 with SMTP id
 17-20020a810c11000000b0036abcf06340mr26642274ywm.467.1666868931530; Thu, 27
 Oct 2022 04:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221027114930.137735-1-luwei32@huawei.com>
In-Reply-To: <20221027114930.137735-1-luwei32@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Oct 2022 04:08:40 -0700
Message-ID: <CANn89iJ3Kiy7M6WRdBRwXAocFvqpR0ZbmxJ7JOg19NGSP37KfQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: reset tp->sacked_out when sack is enabled
To:     Lu Wei <luwei32@huawei.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, xemul@parallels.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ovzxemul@gmail.com, ptikhomirov@virtuozzo.com, den@virtuozzo.com
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

On Thu, Oct 27, 2022 at 3:45 AM Lu Wei <luwei32@huawei.com> wrote:
>
> If setsockopt with option name of TCP_REPAIR_OPTIONS and opt_code
> of TCPOPT_SACK_PERM is called to enable sack after data is sent
> and before data is acked, it will trigger a warning in function
> tcp_verify_left_out() as follows:
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
> happen and the warning will not be triggered. As suggested by Denis
> and Eric, TCP_REPAIR_OPTIONS should be prohibited if data was already
> sent.
>
> socket-tcp tests in CRIU has been tested as follows:
> $ sudo ./test/zdtm.py run -t zdtm/static/socket-tcp*  --keep-going \
>        --ignore-taint
>
> socket-tcp* represent all socket-tcp tests in test/zdtm/static/.
>
> Fixes: b139ba4e90dc ("tcp: Repair connection-time negotiated parameters")
> Signed-off-by: Lu Wei <luwei32@huawei.com>
> ---
>  net/ipv4/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index ef14efa1fb70..ef876e70f7fe 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3647,7 +3647,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
>         case TCP_REPAIR_OPTIONS:
>                 if (!tp->repair)
>                         err = -EINVAL;
> -               else if (sk->sk_state == TCP_ESTABLISHED)
> +               else if (sk->sk_state == TCP_ESTABLISHED && !tp->packets_out)

You keep focusing on packets_out  :/

What I said was : TCP_REPAIR_OPTIONS must be denied if any packets
have been sent (and possibly already ACK)

Looking at tp->packets_out alone is not sufficient.

>                         err = tcp_repair_options_est(sk, optval, optlen);
>                 else
>                         err = -EPERM;
> --
> 2.31.1
>
