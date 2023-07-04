Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA17469F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGDGsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGDGsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:48:00 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E914B1737
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:47:32 -0700 (PDT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-66a44bf4651so6169087b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 23:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688453247; x=1691045247;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACIBrwixBjWpiuudARGyb9TqOdMNUjtG62uNvT31qwI=;
        b=har9Ky9wxcTfr7a+7XLWZ09gUs3k4F7IqdbQo4+R80drTZQkdcMnuyfKGAoE4WVJHN
         g3CB9cF5Pf02fypx89PapkNbYxDfS5h/wZMe5E/2coUspxVsAJMUbBjegaRS03NBIJoH
         O8vBEljTC24jW493eP10JiyJ4mIW6aBpY7GwnZm/SLXipOp4JPzt1RL4qDj9i4Zurfvg
         gu959ZCAgaljYy/FMQJ/dIeF+IECtdmLrwydeZ/75x/aEJCzvIB+E38cFdJBzgy/eh0m
         L2/3IsH2pjJ5zuKewnSdywuOUGiXUUGawdpPy6c3kWnsgCN5fy1LcjU6BF9tTgjSsW5+
         Cy/g==
X-Gm-Message-State: AC+VfDyj3jOjo5ivds/O9jsTCYuN1JnLAK0BsYkjRROmkBihzBrRjuEL
        ma6oIvIaRHhJwKs4GELRiZ3x1xNaWbYhz3tawHnJ+IwtXOoe
X-Google-Smtp-Source: ACHHUZ4Gpgjn42qIrs/aUUCL9ENRyznyVbIaqmBiEl9n7unYwO7oqG5AEd5e+DIhhnRWaWvju73GeCWeYo+w2C316h50NXfH/Lvr
MIME-Version: 1.0
X-Received: by 2002:aa7:8685:0:b0:666:8f6c:c8ad with SMTP id
 d5-20020aa78685000000b006668f6cc8admr12033599pfo.2.1688453247045; Mon, 03 Jul
 2023 23:47:27 -0700 (PDT)
Date:   Mon, 03 Jul 2023 23:47:26 -0700
In-Reply-To: <20230704064710.3189-1-astrajoan@yahoo.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002937705ffa3a80b@google.com>
Subject: Re: [PATCH] can: j1939: prevent deadlock by changing j1939_socks_lock
 to rwlock
From:   syzbot <syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com>
To:     astrajoan@yahoo.com
Cc:     astrajoan@yahoo.com, davem@davemloft.net, edumazet@google.com,
        ivan.orlov0322@gmail.com, kernel@pengutronix.de, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        pabeni@redhat.com, robin@protonic.nl, skhan@linuxfoundation.org,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The following 3 locks would race against each other, causing the
> deadlock situation in the Syzbot bug report:
>
> - j1939_socks_lock
> - active_session_list_lock
> - sk_session_queue_lock
>
> A reasonable fix is to change j1939_socks_lock to an rwlock, since in
> the rare situations where a write lock is required for the linked list
> that j1939_socks_lock is protecting, the code does not attempt to
> acquire any more locks. This would break the circular lock dependency,
> where, for example, the current thread already locks j1939_socks_lock
> and attempts to acquire sk_session_queue_lock, and at the same time,
> another thread attempts to acquire j1939_socks_lock while holding
> sk_session_queue_lock.
>
> NOTE: This patch along does not fix the unregister_netdevice bug
> reported by Syzbot; instead, it solves a deadlock situation to prepare
> for one or more further patches to actually fix the Syzbot bug, which
> appears to be a reference counting problem within the j1939 codebase.
>
> #syz test:

This crash does not have a reproducer. I cannot test it.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>
> Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
> ---
>  net/can/j1939/j1939-priv.h |  2 +-
>  net/can/j1939/main.c       |  2 +-
>  net/can/j1939/socket.c     | 25 +++++++++++++------------
>  3 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> index 16af1a7f80f6..74f15592d170 100644
> --- a/net/can/j1939/j1939-priv.h
> +++ b/net/can/j1939/j1939-priv.h
> @@ -86,7 +86,7 @@ struct j1939_priv {
>  	unsigned int tp_max_packet_size;
>  
>  	/* lock for j1939_socks list */
> -	spinlock_t j1939_socks_lock;
> +	rwlock_t j1939_socks_lock;
>  	struct list_head j1939_socks;
>  
>  	struct kref rx_kref;
> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index ecff1c947d68..a6fb89fa6278 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -274,7 +274,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
>  		return ERR_PTR(-ENOMEM);
>  
>  	j1939_tp_init(priv);
> -	spin_lock_init(&priv->j1939_socks_lock);
> +	rwlock_init(&priv->j1939_socks_lock);
>  	INIT_LIST_HEAD(&priv->j1939_socks);
>  
>  	mutex_lock(&j1939_netdev_lock);
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index feaec4ad6d16..a8b981dc2065 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -80,16 +80,16 @@ static void j1939_jsk_add(struct j1939_priv *priv, struct j1939_sock *jsk)
>  	jsk->state |= J1939_SOCK_BOUND;
>  	j1939_priv_get(priv);
>  
> -	spin_lock_bh(&priv->j1939_socks_lock);
> +	write_lock_bh(&priv->j1939_socks_lock);
>  	list_add_tail(&jsk->list, &priv->j1939_socks);
> -	spin_unlock_bh(&priv->j1939_socks_lock);
> +	write_unlock_bh(&priv->j1939_socks_lock);
>  }
>  
>  static void j1939_jsk_del(struct j1939_priv *priv, struct j1939_sock *jsk)
>  {
> -	spin_lock_bh(&priv->j1939_socks_lock);
> +	write_lock_bh(&priv->j1939_socks_lock);
>  	list_del_init(&jsk->list);
> -	spin_unlock_bh(&priv->j1939_socks_lock);
> +	write_unlock_bh(&priv->j1939_socks_lock);
>  
>  	j1939_priv_put(priv);
>  	jsk->state &= ~J1939_SOCK_BOUND;
> @@ -329,13 +329,13 @@ bool j1939_sk_recv_match(struct j1939_priv *priv, struct j1939_sk_buff_cb *skcb)
>  	struct j1939_sock *jsk;
>  	bool match = false;
>  
> -	spin_lock_bh(&priv->j1939_socks_lock);
> +	read_lock_bh(&priv->j1939_socks_lock);
>  	list_for_each_entry(jsk, &priv->j1939_socks, list) {
>  		match = j1939_sk_recv_match_one(jsk, skcb);
>  		if (match)
>  			break;
>  	}
> -	spin_unlock_bh(&priv->j1939_socks_lock);
> +	read_unlock_bh(&priv->j1939_socks_lock);
>  
>  	return match;
>  }
> @@ -344,11 +344,11 @@ void j1939_sk_recv(struct j1939_priv *priv, struct sk_buff *skb)
>  {
>  	struct j1939_sock *jsk;
>  
> -	spin_lock_bh(&priv->j1939_socks_lock);
> +	read_lock_bh(&priv->j1939_socks_lock);
>  	list_for_each_entry(jsk, &priv->j1939_socks, list) {
>  		j1939_sk_recv_one(jsk, skb);
>  	}
> -	spin_unlock_bh(&priv->j1939_socks_lock);
> +	read_unlock_bh(&priv->j1939_socks_lock);
>  }
>  
>  static void j1939_sk_sock_destruct(struct sock *sk)
> @@ -484,6 +484,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>  
>  		priv = j1939_netdev_start(ndev);
>  		dev_put(ndev);
> +
>  		if (IS_ERR(priv)) {
>  			ret = PTR_ERR(priv);
>  			goto out_release_sock;
> @@ -1078,12 +1079,12 @@ void j1939_sk_errqueue(struct j1939_session *session,
>  	}
>  
>  	/* spread RX notifications to all sockets subscribed to this session */
> -	spin_lock_bh(&priv->j1939_socks_lock);
> +	read_lock_bh(&priv->j1939_socks_lock);
>  	list_for_each_entry(jsk, &priv->j1939_socks, list) {
>  		if (j1939_sk_recv_match_one(jsk, &session->skcb))
>  			__j1939_sk_errqueue(session, &jsk->sk, type);
>  	}
> -	spin_unlock_bh(&priv->j1939_socks_lock);
> +	read_unlock_bh(&priv->j1939_socks_lock);
>  };
>  
>  void j1939_sk_send_loop_abort(struct sock *sk, int err)
> @@ -1271,7 +1272,7 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
>  	struct j1939_sock *jsk;
>  	int error_code = ENETDOWN;
>  
> -	spin_lock_bh(&priv->j1939_socks_lock);
> +	read_lock_bh(&priv->j1939_socks_lock);
>  	list_for_each_entry(jsk, &priv->j1939_socks, list) {
>  		jsk->sk.sk_err = error_code;
>  		if (!sock_flag(&jsk->sk, SOCK_DEAD))
> @@ -1279,7 +1280,7 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
>  
>  		j1939_sk_queue_drop_all(priv, jsk, error_code);
>  	}
> -	spin_unlock_bh(&priv->j1939_socks_lock);
> +	read_unlock_bh(&priv->j1939_socks_lock);
>  }
>  
>  static int j1939_sk_no_ioctlcmd(struct socket *sock, unsigned int cmd,
> -- 
> 2.34.1
>
