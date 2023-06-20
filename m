Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74270737172
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjFTQZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjFTQZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:25:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D04810A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:25:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f90bff0f27so25412325e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278299; x=1689870299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Znjz9mhWIkZAzM3bIGR89qxXvHDPKMA75QcoPc3MXbs=;
        b=fjHkYLbe0be2lmDc2DbzliG3daRP8Cwy06e4lWbBzihbpEvjrLDc4IpnCrklJPm9y/
         TrVPeC4nxdDD+X9nVbCkLnjfNhQCO4ETgtXMWa7UoMTJy9HgEkfxkjDwQ1CdJeUtsoYS
         JGzvkldrixNbVNxPNAvFOwqaF/XGy3paO6imJBQZgW9Vora7xJ49Yl3Qa3ii6TZjnbA0
         um/RD4koPftR93T6D1qFbrFLliTFjM6MUBdRZ2fROywwJ5Ri5/evXYEEpBPGKVaJwNnX
         CTw2OAEDgYCEaXnQV3KXDzD05oQVevUDcQzXLC5ZCtnrMKkf7hjqc32i88cFWHarU3GN
         OLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278299; x=1689870299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Znjz9mhWIkZAzM3bIGR89qxXvHDPKMA75QcoPc3MXbs=;
        b=ZXdVGa+pz24sNQ+PA/ya2QQQgIxns18VaRZGdzZm38WyIpC0zmdDdJBfLNPArKTZzl
         i5GJUdZduhn4/lJbWxxdgUzvN3d2v4CfsZAWk1ytRKJpxJGnGtO78rLtJB9BJBl2Kr/4
         0ISd9qePwlEHcb7ctXkDvExVZSEGjp4aL8MHPXVg/8cE/6fY0fs//o3DpsNL3Jb6gJyD
         wbTbfdtz0hGJex2BXkCF5NlcMqfGSBdhw4LRBXfg/32PS6Osvb195y67u4yZth3FHDAH
         OU0Hk1phtpJD5NatrrQdb5Uj4WBxExudXATv5412tG7BxXbF1i/LW2Hf0HZmoo3tcFWA
         s/mA==
X-Gm-Message-State: AC+VfDyibcUUF6DXLtAoYRN38t1pzxBUaFFyaymgLogv7089boV6npif
        D4Ulzk0chGDVbXgrY8H1wLJFVQ==
X-Google-Smtp-Source: ACHHUZ4wiLUY+Cf2Yma1uofHbvwI5tQcGLbRTlxlEi+dJ/ojWLtPbmVMni/kTCWN4E5uhAJojkAVZg==
X-Received: by 2002:a1c:6a07:0:b0:3f9:b13b:a1cd with SMTP id f7-20020a1c6a07000000b003f9b13ba1cdmr3960518wmc.16.1687278298940;
        Tue, 20 Jun 2023 09:24:58 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003f8fe1933e4sm15753056wms.3.2023.06.20.09.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:24:58 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 20 Jun 2023 18:24:23 +0200
Subject: [PATCH net 6/6] mptcp: ensure listener is unhashed before updating
 the sk status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-6-f36aa5eae8b9@tessares.net>
References: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
In-Reply-To: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Christoph Paasch <cpaasch@apple.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3462;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=XrTodyZuRWl4/4OQC7pAwj7PljaPvC+0axsjgRjlweQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdLU59rYoS7PISGtstSFpyCDz13h50kwKhhsz
 UQhglzkRciJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHS1AAKCRD2t4JPQmmg
 c85lEADP17RDWFFhZabVkHlxq7xu4jsB18M64f5ecSn1Q1W0UimQtRHq5TqzSexe/LTDZwijN4R
 usgqHa6AAfyU4TzLIu819mQKV0A2apCfVhzOAcMr2JDvez8Jl+UMG6xHBzabivfIECOKeK1Ja8l
 CLqYFWlhghut3N4SU0ue0wTLO6OxkDBr85cz271+DRv3jpGZRbOgQu/g8T9cGEuO8shFUp5OvUI
 Yu3Qjzv/zUM5WGOajxnQc6b5GL2Aj3SZLETNtB+Lj2RVjuDgIp6lT+ftKzUUV4H1LAXZlU5pTuC
 HtprYVd7qZzUcO4xJvkj03Neu42M4AEFL02lu9bM7hRiByklUb5M7hP5HVBqZGGbqdDpSwRnywo
 wp4FyQI/9R0otMK4HyKzc10oOB8rOpOm2vjC9XEJGBEjb7L+SxvgLrzWPE8dRKCJWsD7Dn4sO1U
 n7pGJrs1qPJcBcuBbH98/jBlkrJUCvcGC9901bxlpFgBeVUl+AlBvbgfjSFy7WDx9CVHpk0bEMt
 Wun0sKe5W4/vblO3i8br8uiS7/0wtOlCNft7zQZR1LY2BlTCvfXZqyoDdg8Usg6S9kB8TUZMz7G
 jbRUwOylPsIe2dEyhNjpMUECCsaRE5MRr2yE0xn4V81S1IrPZ9tp2IcP2flYl6fYAaTJQbVKgyq
 PIn8PYetOam3Txg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP protocol access the listener subflow in a lockless
manner in a couple of places (poll, diag). That works only if
the msk itself leaves the listener status only after that the
subflow itself has been closed/disconnected. Otherwise we risk
deadlock in diag, as reported by Christoph.

Address the issue ensuring that the first subflow (the listener
one) is always disconnected before updating the msk socket status.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/407
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_netlink.c |  1 +
 net/mptcp/protocol.c   | 31 +++++++++++++++++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 59f8f3124855..1224dfca5bf3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1047,6 +1047,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
+	inet_sk_state_store(newsk, TCP_LISTEN);
 	err = kernel_listen(ssock, backlog);
 	if (err)
 		return err;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a66ec341485e..a6c7f2d24909 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2368,13 +2368,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		kfree_rcu(subflow, rcu);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
-		if (ssk->sk_state == TCP_LISTEN) {
-			tcp_set_state(ssk, TCP_CLOSE);
-			mptcp_subflow_queue_clean(sk, ssk);
-			inet_csk_listen_stop(ssk);
-			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
-		}
-
 		__tcp_close(ssk, 0);
 
 		/* close acquired an extra ref */
@@ -2902,10 +2895,24 @@ static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
 	return EPOLLIN | EPOLLRDNORM;
 }
 
-static void mptcp_listen_inuse_dec(struct sock *sk)
+static void mptcp_check_listen_stop(struct sock *sk)
 {
-	if (inet_sk_state_load(sk) == TCP_LISTEN)
-		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	struct sock *ssk;
+
+	if (inet_sk_state_load(sk) != TCP_LISTEN)
+		return;
+
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	ssk = mptcp_sk(sk)->first;
+	if (WARN_ON_ONCE(!ssk || inet_sk_state_load(ssk) != TCP_LISTEN))
+		return;
+
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	mptcp_subflow_queue_clean(sk, ssk);
+	inet_csk_listen_stop(ssk);
+	mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
+	tcp_set_state(ssk, TCP_CLOSE);
+	release_sock(ssk);
 }
 
 bool __mptcp_close(struct sock *sk, long timeout)
@@ -2918,7 +2925,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
-		mptcp_listen_inuse_dec(sk);
+		mptcp_check_listen_stop(sk);
 		inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
 	}
@@ -3035,7 +3042,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (msk->fastopening)
 		return -EBUSY;
 
-	mptcp_listen_inuse_dec(sk);
+	mptcp_check_listen_stop(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_timer(sk);

-- 
2.40.1

