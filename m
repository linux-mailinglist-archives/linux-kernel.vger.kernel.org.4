Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3257E73716D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjFTQZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjFTQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:24:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B36109
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:24:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f8fcaa31c7so52765375e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278294; x=1689870294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvRhWfjGWijJY7sMUNegX5KJAcsspmzp2LrXYV55wcM=;
        b=MqfBxYwoNRo9z3rwWOhLJzKGA/MTPdB9WcqMI/eXo3AJ0N3zssdzha33djxkMdiH81
         mzDozRI0sYIV+n4sJvP4R4PxOR2sjdrpoE0hzn1URYrZnCufh4vZ+jTgKt8qne4XJlCN
         Y31NEGK644D6o7trb2QSjyK5wpNaoIBwET1IBnW3bAPkfx/FN0yahmYx73HXgxBznbob
         9GCG+9WFq/W4pEGAs+UyNPlOUkWCiXrpXaQAJwUCYArX2lEpnf8PLZ4GA6GVVAxTDzM1
         P7YJYB69vcjTZ4sPnSWixsZxheRmGi1kACgiKQ/UtQ19+uwZRamILsZ5g4S4ZVCn8q0x
         jWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278294; x=1689870294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvRhWfjGWijJY7sMUNegX5KJAcsspmzp2LrXYV55wcM=;
        b=O/YujxI71lkAeqrS5ISX7KjR7KYyTcPCDFWUPy/D5o5UAWdi+DfqwT3KjBO85rEqZ2
         AncZ/D7nm+HsEomzvHLq4gf2z0b/rjboXkUlGhSjMbBYhrDHXRUuB0RHLieMVUWtdHmx
         Kn+bucO0QljYAg+I0XM77k3VgXZSPPRjv8viHeFN3jfjo2K2dZJQhSiyBOz/WtSgLCXk
         ni647bJlyzG7QNarXX1p2sbrNng7GsGzInMNA+IFf/jJJUI8GdzFg6XY5ys6s6SMKkrb
         H+k7HKxNzplTtMLEWloixtorVXp0klY2VUL5k0KFZBgi6a08bO2Z6E15BjifFXfVnVKb
         7vbw==
X-Gm-Message-State: AC+VfDyLFaPi1Ja2qt0TU8TOol+9EYvXI0mLokSD29MpJRmhDeNfdMlx
        hoFxCAf7HTofDgzKofHYs717QQ==
X-Google-Smtp-Source: ACHHUZ6JUhdxUZI+KfLnH6b3dYHiv9qi5f0P6CsV6QoRDSnZN0a8iowlc6lPvNU/ZfCRF3vh5QlNmg==
X-Received: by 2002:a05:600c:2113:b0:3f9:b345:d4a3 with SMTP id u19-20020a05600c211300b003f9b345d4a3mr4373434wml.14.1687278294175;
        Tue, 20 Jun 2023 09:24:54 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003f8fe1933e4sm15753056wms.3.2023.06.20.09.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:24:53 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 20 Jun 2023 18:24:18 +0200
Subject: [PATCH net 1/6] mptcp: handle correctly disconnect() failures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-1-f36aa5eae8b9@tessares.net>
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
        stable@vger.kernel.org, Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2867;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=Prhhf4fFguSy1+KxJcHFfLoLbT8zaG1uIQ7YWZ/gXmY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdLTBELYBTn8FzTSZGyQa0VRa6kUfsOLMAWbn
 xe7xQ+KQKGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHS0wAKCRD2t4JPQmmg
 c7U0D/4x7EfPKNtzI8F433H9Lr6FHrJ+T6wYMokxHsZcWQWGx3/pAJguLYDi0QDkwySr9eWWy4n
 TPEl3WNlGwBerB+Nn5EeYNM09pjKqQ1K5vt87O76T7l3TKIRgrBDi8wyHuTjECCi9FvJBaO0F5D
 TJLHqcNYs20dAzVlyp4dUVgcYEYSyU85xrVFmAUnvf6Y59OasKIuFR7qZzXrTT7Gp2ykH6Q24kQ
 5+PHAO20NLCYU3bWIVckc+8Eb7eNfK4tOVxbV8DeAtSeKGlmcuGvyRGd9CARus/cIw01+DKa0Ed
 vcMc9sZaTzWaQT+dVGV651fsYaN6ed3Ff4iZ7dMTIZNJYAINY5298vk98HpjH2k5G0VwlJ10Gf4
 ohfWCpmGRdm7HfG7b8jPPXrOUUifC0Ei9WYoi3zcz9hSBeHihx9k/s8G2FN7WQm/uZnmB51Q3Vd
 RtfFByVT/EUcdeCVpfTpWA7JtfzAc3o5uD+xTyBpySG0SV1HEIbuXKBrR6gmvUYplUiMdjTQ7lH
 K6XD0BgKNQ8d49tO7IZm0qvJz6lUcuvrbM2j7c+Et1uCADN1yjzm1ouMijODnnbmJRShhRFqA/m
 /gr+SBiW2NPBDd2rYm6IjmtITlqclttq+G4sj1r/XJHI/lCieHtDSsa0CqEg4odgPCLZub4ZnCe
 /LFNgRld0O0CbOQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

Currently the mptcp code has assumes that disconnect() can fail only
at mptcp_sendmsg_fastopen() time - to avoid a deadlock scenario - and
don't even bother returning an error code.

Soon mptcp_disconnect() will handle more error conditions: let's track
them explicitly.

As a bonus, explicitly annotate TCP-level disconnect as not failing:
the mptcp code never blocks for event on the subflows.

Fixes: 7d803344fdc3 ("mptcp: fix deadlock in fastopen error path")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Christoph Paasch <cpaasch@apple.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 67311e7d5b21..86f8a7621aff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1727,7 +1727,13 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
 			*copied_syn = 0;
 	} else if (ret && ret != -EINPROGRESS) {
-		mptcp_disconnect(sk, 0);
+		/* The disconnect() op called by tcp_sendmsg_fastopen()/
+		 * __inet_stream_connect() can fail, due to looking check,
+		 * see mptcp_disconnect().
+		 * Attempt it again outside the problematic scope.
+		 */
+		if (!mptcp_disconnect(sk, 0))
+			sk->sk_socket->state = SS_UNCONNECTED;
 	}
 	inet_sk(sk)->defer_connect = 0;
 
@@ -2389,7 +2395,10 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
-		tcp_disconnect(ssk, 0);
+		/* The MPTCP code never wait on the subflow sockets, TCP-level
+		 * disconnect should never fail
+		 */
+		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
 		msk->subflow->state = SS_UNCONNECTED;
 		mptcp_subflow_ctx_reset(subflow);
 		release_sock(ssk);
@@ -2812,7 +2821,7 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			break;
 		fallthrough;
 	case TCP_SYN_SENT:
-		tcp_disconnect(ssk, O_NONBLOCK);
+		WARN_ON_ONCE(tcp_disconnect(ssk, O_NONBLOCK));
 		break;
 	default:
 		if (__mptcp_check_fallback(mptcp_sk(sk))) {
@@ -3075,11 +3084,10 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	/* We are on the fastopen error path. We can't call straight into the
 	 * subflows cleanup code due to lock nesting (we are already under
-	 * msk->firstsocket lock). Do nothing and leave the cleanup to the
-	 * caller.
+	 * msk->firstsocket lock).
 	 */
 	if (msk->fastopening)
-		return 0;
+		return -EBUSY;
 
 	mptcp_listen_inuse_dec(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);

-- 
2.40.1

