Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F246185B7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiKCRFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiKCRFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:05:11 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D31AF2A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:04:31 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 129so2948726ybb.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZv2dY0yFJqMLdVk2KmNZo3zHTpFU9k8HiT7lLkRxNw=;
        b=EHzFTNrmtlwDQ8zm75RvzwKMMrfRIx1GTZbsMP2AfoYM6+q1PViM+DzZCyYY7XF/Eq
         bQydB+nvfdgrA1ZI9AjnMHmpQ5F55HFUO6s3HZ3UBZJe5aHIK7NJG1T9XhEr3GJCDVNt
         AoNCDYew3A7FbcqMTIFeJrkTjpfidEUTn3r36ufp5o0VPoWwpxvke4wVIlRkdIP2yQDZ
         aSWubCjXkidUZ+N3Tf534tVusucLWZZZNbwxoXqHA6MQVlRVmGaRULB/c2TWkFx24XMk
         YXlVIfxQtvZaaw403A0YCMtGbXAoJeGGUlbfFVrYTbA3yfxQcTbwhNJXzV1kBG8mFLLt
         vafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZv2dY0yFJqMLdVk2KmNZo3zHTpFU9k8HiT7lLkRxNw=;
        b=8QnPsASqSLdAx7RlCZRiLkHm7T4KT8wBmExbo2/QkqTfk6XlPRRDLEteNuA49uPlIt
         3k5bqpJzzusKzsIwh+gl8jKbK99RBwSTQBciwvtj5XIZ2pqAMA0feS9G0OF4QKmsbznB
         glOjJdxqD9Fp9agutmgkcFnJIOzNeHdAf8qE92eFie76OQZkQHvimbvSlZmCBqj3WJN2
         5V0MSdnapnWnOzsdjZaVAYeNlNt3n/vXbN6xhilY1svurtpOqGWwMO6m4LxTEmlhv0GG
         TdR21HtRdT9KoSDNU3WuVmy/vhcwq3PhZj3Uwcrh+23TqVn0nV6RitfWWy6+RAvaLQ99
         m7lQ==
X-Gm-Message-State: ACrzQf39GV9+Lak8JJM+26vK1bais5EItfmSQpCpITI7jCqvvWLrksYy
        f3lp6+HEGFEZEerl4rdguYWcd5GaXHnpit/C9cE/Dg==
X-Google-Smtp-Source: AMsMyM4Dwbn9oGoS8pCqhuU1pSWVrzSW5pYUVHNZ/iIdST8NL8PoPk0Qb2ASkJM4NFq8qXCyXztAqfiM2oHozyiYOEM=
X-Received: by 2002:a25:7a01:0:b0:6b0:820:dd44 with SMTP id
 v1-20020a257a01000000b006b00820dd44mr28183106ybc.387.1667495070348; Thu, 03
 Nov 2022 10:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221102211350.625011-1-dima@arista.com> <20221102211350.625011-3-dima@arista.com>
 <CANn89iLbOikuG9+Tna9M0Gr-diF2vFpfMV8MDP8rBuN49+Mwrg@mail.gmail.com> <b053edbd-2dbd-f3f3-7f6c-c70d5b58a00d@arista.com>
In-Reply-To: <b053edbd-2dbd-f3f3-7f6c-c70d5b58a00d@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 3 Nov 2022 10:04:19 -0700
Message-ID: <CANn89i+2ZOaQwmJ9EBn7796byAn9=mQPyM_gzdchsWCy-_GrjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/tcp: Disable TCP-MD5 static key on
 tcp_md5sig_info destruction
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
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

On Thu, Nov 3, 2022 at 9:53 AM Dmitry Safonov <dima@arista.com> wrote:
>
> On 11/2/22 21:25, Eric Dumazet wrote:
> > On Wed, Nov 2, 2022 at 2:14 PM Dmitry Safonov <dima@arista.com> wrote:
> [..]
> >> @@ -337,11 +338,13 @@ EXPORT_SYMBOL(tcp_time_wait);
> >>  void tcp_twsk_destructor(struct sock *sk)
> >>  {
> >>  #ifdef CONFIG_TCP_MD5SIG
> >> -       if (static_branch_unlikely(&tcp_md5_needed)) {
> >> +       if (static_branch_unlikely(&tcp_md5_needed.key)) {
> >>                 struct tcp_timewait_sock *twsk = tcp_twsk(sk);
> >>
> >> -               if (twsk->tw_md5_key)
> >> +               if (twsk->tw_md5_key) {
> >
> > Orthogonal to this patch, but I wonder why we do not clear
> > twsk->tw_md5_key before kfree_rcu()
> >
> > It seems a lookup could catch the invalid pointer.
> >
> >>                         kfree_rcu(twsk->tw_md5_key, rcu);
> >> +                       static_branch_slow_dec_deferred(&tcp_md5_needed);
> >> +               }
> >>         }
>
> I looked into that, it seems tcp_twsk_destructor() is called from
> inet_twsk_free(), which is either called from:
> 1. inet_twsk_put(), protected by tw->tw_refcnt
> 2. sock_gen_put(), protected by the same sk->sk_refcnt
>
> So, in result, if I understand correctly, lookups should fail on ref
> counter check. Maybe I'm missing something, but clearing here seems not
> necessary?
>
> I can add rcu_assign_pointer() just in case the destruction path changes
> in v2 if you think it's worth it :-)

Agree, this seems fine.
