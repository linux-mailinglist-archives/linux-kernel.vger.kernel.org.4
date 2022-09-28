Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A710E5ED415
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 07:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiI1FF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 01:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiI1FFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 01:05:22 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C87E05DF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 22:05:21 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3321c2a8d4cso119859877b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 22:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yIwHCyB8UXxDRVJ9blrFHmL2cOgSYQrgb8iwQ11BtQw=;
        b=lf7H9XzSfRnChh6O787k71OJIMDVadXy0DCFZVcRoGy3c5IpXgOtPLTqeEZhoZEN/A
         pyIrzG6ZOa5d+I71Dz0Vfd1EjJMEzr4dghuNRFTiTX4dBdOVNtLVtDe7VuHW7PjKv9cY
         jfbC02O98XLFClRxlrbUMOR+TOh1dd8FuKTCyoJJbwhzp0ln8O62C7geK2+KCDk044ta
         8E96I3RqlqeMJs2dqfM8+XDI8vGRsIz3GR+cKJrRpwS/smu5i1xetTaODYEql+YBmi8X
         mBddEV0szaTAekN1LWoDYjYc1O0QU99+iXC3JIz1t9aewqRgTGciySCAdsZZ9LI3Zxpl
         MuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yIwHCyB8UXxDRVJ9blrFHmL2cOgSYQrgb8iwQ11BtQw=;
        b=CssZ1U+fXW0PYE+UtGeP/UUJW8p0+kViUt0AvX4bIZrFzYyQVDtxS0CfKoNkCNAOUf
         s4T8lxfzBQXZLqGimnJxTREk7YRaBHbwMy5Hrj6KOR5zyi/3tk3kfMCjPYkRu8tAyMAX
         6lriuLpSldmpayBZxg7fPmTH91ftXVDM/LKfAT+NHl8Jv8xygtlE41trTS0JM5l6sWva
         KwcBHrDzTRge5MqqVd3mjqbQ8+O/wQhnVZ6Jzy6dKaxs8y19WZQDI4zNTClqrOgQAMJE
         3brfkfA7Ad8r6Ntegys5ylwvvGfXp1rtWMc7tcD0oZDWrGomQ/ngleWm0kyD2smhYX1J
         GysA==
X-Gm-Message-State: ACrzQf16m3MJRFWR8/qMmFu64AP8b74DOGGJCoTkpXdjN7L0ZICaPK8Q
        7YrgJTUTdl2UQPdLAHG7S5/EeQ5O2/WLKOAv2rro7w==
X-Google-Smtp-Source: AMsMyM4Pf0cMnBGHDqdcpLnN4zgl8yODbitHCUy93bdRojqz8HL8ukq+SFSjdKBEsmXxdshFtfaPLXa8JmLl6DLX3wY=
X-Received: by 2002:a81:4e0d:0:b0:351:99d8:1862 with SMTP id
 c13-20020a814e0d000000b0035199d81862mr7543465ywb.278.1664341520327; Tue, 27
 Sep 2022 22:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220928002741.64237-1-kuniyu@amazon.com> <20220928002741.64237-3-kuniyu@amazon.com>
In-Reply-To: <20220928002741.64237-3-kuniyu@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 27 Sep 2022 22:05:09 -0700
Message-ID: <CANn89iK1HHhvJgDsym377DDxZ3hvL8b8_pbrjb-qeXFRbsvFKA@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/5] udp: Call inet6_destroy_sock() in setsockopt(IPV6_ADDRFORM).
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Sep 27, 2022 at 5:28 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> Commit 4b340ae20d0e ("IPv6: Complete IPV6_DONTFRAG support") forgot
> to add a change to free inet6_sk(sk)->rxpmtu while converting an IPv6
> socket into IPv4 with IPV6_ADDRFORM.  After conversion, sk_prot is
> changed to udp_prot and ->destroy() never cleans it up, resulting in
> a memory leak.
>
> This is due to the discrepancy between inet6_destroy_sock() and
> IPV6_ADDRFORM, so let's call inet6_destroy_sock() from IPV6_ADDRFORM
> to remove the difference.
>
> However, this is not enough for now because rxpmtu can be changed
> without lock_sock() after commit 03485f2adcde ("udpv6: Add lockless
> sendmsg() support").  We will fix this case in the following patch.
>
> Fixes: 4b340ae20d0e ("IPv6: Complete IPV6_DONTFRAG support")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv6/ipv6_sockglue.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index b61066ac8648..030a4cf23ceb 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -431,9 +431,6 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
>                 if (optlen < sizeof(int))
>                         goto e_inval;
>                 if (val == PF_INET) {
> -                       struct ipv6_txoptions *opt;
> -                       struct sk_buff *pktopt;
> -
>                         if (sk->sk_type == SOCK_RAW)
>                                 break;
>
> @@ -464,7 +461,6 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
>                                 break;
>                         }
>
> -                       fl6_free_socklist(sk);
>                         __ipv6_sock_mc_close(sk);
>                         __ipv6_sock_ac_close(sk);
>
> @@ -501,14 +497,9 @@ static int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
>                                 sk->sk_socket->ops = &inet_dgram_ops;
>                                 sk->sk_family = PF_INET;
>                         }
> -                       opt = xchg((__force struct ipv6_txoptions **)&np->opt,
> -                                  NULL);
> -                       if (opt) {
> -                               atomic_sub(opt->tot_len, &sk->sk_omem_alloc);
> -                               txopt_put(opt);
> -                       }
> -                       pktopt = xchg(&np->pktoptions, NULL);
> -                       kfree_skb(pktopt);
> +

 Why is this needed ? I think a comment could help.
> +                       np->rxopt.all = 0;

> +                       inet6_destroy_sock(sk);

This name is unfortunate. This really is an inet6_cleanup_sock() in
this context.

>
>                         /*
>                          * ... and add it to the refcnt debug socks count
> --
> 2.30.2
>
