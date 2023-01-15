Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED71966B279
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjAOQMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjAOQMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:12:02 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A458CC19
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 08:12:01 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 203so27761231yby.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 08:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gYIq1cNRboBs2JYmx3+VNbJ7kJEXsaYlguTW8wp2/tg=;
        b=o3nklv7d8wtaIT7f/cQNajXlS/mLwByD9FpqHVDy9lQ9NIBG7fhzTfJVeiJQSrT5/b
         Ih6zXoSUfy/avdW+12de6xjtfP1oGOcQ0A4MjnfKFCBc0ipwiTEuZNJ5fVEI2dVL3Ty0
         x6nIvkVRCAjxbPFdlhgs3g3sUVmU1WdgOzgB4/A+fQS7o1z2BLZZoz+qNz6wUX9+cRPl
         z3MIrrQSU9FAAnP388mc+1ymY+pPIxOx8TyzhlbOyPWgxLw+j117axmFMtJztaweJUKJ
         Icz9ewkptiGPHd/GQH6Rt/KN8pKtggl1/Q1EHtdhjnRLTGNd7HdcqoXjC3Nt8tai05/l
         4TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYIq1cNRboBs2JYmx3+VNbJ7kJEXsaYlguTW8wp2/tg=;
        b=XmRr96W4F5BQ+C3F6JyEigKWYXLytYlvrLcM2ted5nZIsFD/VG3CzvJpzKrYN8Z0C/
         +s3ANAgTd6DisoAuLNQWl758GF4wRFxq+xC387Cv654p5XdIy1H35D7YLbMNjrvHf/pC
         RkFOpER1hBjURncxwnDvULAwxy/aI26Hj3kBOZOFcxmUAJeHHji1h6UHCJhoe/k+HX/T
         rl49+CRGaxFZR1Ahwl7OmYrzmPmnKGHk2HftNnn3Q/1jbBeQ50mapINGXTMmxNi0LzJS
         7E4FORcZiTqD0EI8woMWI1moMn6gGon/mM76fsYF5QAzCJABk+ryF3i/itI86XTgHO0P
         m5Vw==
X-Gm-Message-State: AFqh2kqUdsp/5Oo1Sz/zcVoa5d09iFGBaXJsnxXL6NwVyvxilIWXB6qx
        IU9iKd5657f9/dRDvelb1jRVUkReLhOKJRKfun9nGg==
X-Google-Smtp-Source: AMrXdXtLxYYleTmBEgpzFYr2/75sjuNk5VSr20IYJzYWRC2080wHsKVTUF5eNKqIh0eq52dG5NhTCOuuH3RwYj+zWWE=
X-Received: by 2002:a25:32d7:0:b0:7d5:dc31:81ed with SMTP id
 y206-20020a2532d7000000b007d5dc3181edmr475055yby.407.1673799120226; Sun, 15
 Jan 2023 08:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20230114132705.78400-1-kerneljasonxing@gmail.com>
In-Reply-To: <20230114132705.78400-1-kerneljasonxing@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 15 Jan 2023 17:11:48 +0100
Message-ID: <CANn89iJ+KW+=Z13o_K4RpZfoxO8rGaXRXQ07jZfpE5RMH0Uweg@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: avoid the lookup process failing to get sk in
 ehash table
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 2:27 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
>
> Fixes: 5e0724d027f0 ("tcp/dccp: fix hashdance race for passive sessions")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Link: https://lore.kernel.org/lkml/20230112065336.41034-1-kerneljasonxing@gmail.com/
> ---
> v2:
> 1) adding the sk node into the tail of list to prevent the race.
> 2) fix the race condition when handling time-wait socket hashdance.
> ---
>  net/ipv4/inet_hashtables.c    | 10 ++++++++++
>  net/ipv4/inet_timewait_sock.c |  6 +++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 24a38b56fab9..b0b54ad55507 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -650,7 +650,16 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
>         spin_lock(lock);
>         if (osk) {
>                 WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
> +               if (sk_hashed(osk))


nit: this should be:

if (sk_hashed(osk)) {  [1]
    /* multi-line ....
     * .... comment.
     */
   ret = sk_nulls_del_node_init_rcu(osk);
   goto unlock;
}
if (found_dup_sk) {  [2]

1) parentheses needed in [1]
2) No else if in [2], since you added a "goto unlock;"

> +                       /* Before deleting the node, we insert a new one to make
> +                        * sure that the look-up-sk process would not miss either
> +                        * of them and that at least one node would exist in ehash
> +                        * table all the time. Otherwise there's a tiny chance
> +                        * that lookup process could find nothing in ehash table.
> +                        */
> +                       __sk_nulls_add_node_tail_rcu(sk, list);
>                 ret = sk_nulls_del_node_init_rcu(osk);
> +               goto unlock;
>         } else if (found_dup_sk) {
>                 *found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
>                 if (*found_dup_sk)
> @@ -660,6 +669,7 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
>         if (ret)
>                 __sk_nulls_add_node_rcu(sk, list);
>
> +unlock:
>         spin_unlock(lock);

Thanks.
