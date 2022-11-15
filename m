Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1354862A3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiKOVUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiKOVTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:19:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1841F9CD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:19:46 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a14so26564417wru.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrKEt8xGpN11qf/n3/wg8niAJAFvn6hZvrWVQxWQt4g=;
        b=fiVUvzanF1MNolL7T+CltA94XNZSW4VdbdBPdch82XQjipq8aq+Yi7VAnWgnD8s2e+
         Lz8sQqgJ3eN+BHq+K8sXMQCxu2Irl6SBI0LizkFlYe0Ft367ENJzWfhc97792IVACQaP
         AnnteECEFW7PpNpaV/KlsRjvPC0XqXInp/eAjn1lYbyg6ba4N1l5CYutKCfWTpNgj1CM
         e7xGdPoqvSpco8RP05u/yzoIx/33Htfpa7rs8/ZItQKtNr8zu6GlsuliasvnGGcNdAZa
         lw7+8IUiTnxVekNcbDELxNh95fQKzP30cc1L3qf2ZEKXs9UZc5mOKirVB560+fXJjF8X
         pYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrKEt8xGpN11qf/n3/wg8niAJAFvn6hZvrWVQxWQt4g=;
        b=oxMlyABO1tLdailJrxB7Q2/xZm7qoPkakKH+gEvKsfB9adHR0mKLL9Hsz8JzpEx60G
         n5bOCzJwlRQiuL3w1lV7bcNTeX5Ya5Ns3EuDUliQ4uYyAo6sRvK/8zzBkAyHERHRkgjq
         SzeHVskIv4lKTFuGl6n6ug94PxICTCMk9JmskhBPtIQVt64mBlKVqY/vGkNukwfID/Ec
         y0IYHv43/ms/uzzt7dCv4DJ/DRlMt0MwGgZPwSPgkFK8ySQ63jtw6bkze5/PDAU6Kkvd
         Wl0GwN3q/zq6gy5pxKmTBZXq7Kp32NrUviSmSyfiEg9Omc0n17CzJji4F0Q2gB3jQIAl
         sn/Q==
X-Gm-Message-State: ANoB5pndBOywn7YPQSYLvPsyqu5isItLh8zX8/rO0eipfZP2Aa4dk6rZ
        /ULzMsxXF26/St5xFVQ2t9hlib8yXPCboA==
X-Google-Smtp-Source: AA0mqf6CV7LJUbYPSpLTBC3OLtXhrCWbq8SAxnpH7zuPrSXasJey8qmnKv7HkVUFLJDAiiJN+Va78w==
X-Received: by 2002:adf:f211:0:b0:23a:43b7:cdd5 with SMTP id p17-20020adff211000000b0023a43b7cdd5mr11857847wro.387.1668547160245;
        Tue, 15 Nov 2022 13:19:20 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c502900b003c65c9a36dfsm17201487wmr.48.2022.11.15.13.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:19:19 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Safonov <dima@arista.com>, Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org
Subject: [PATCH v4 5/5] net/tcp: Separate initialization of twsk
Date:   Tue, 15 Nov 2022 21:19:05 +0000
Message-Id: <20221115211905.1685426-6-dima@arista.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115211905.1685426-1-dima@arista.com>
References: <20221115211905.1685426-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert BUG_ON() to WARN_ON_ONCE() and warn as well for unlikely
static key int overflow error-path.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_minisocks.c | 61 +++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 50f91c10eb7b..1cfafad9ba29 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -240,6 +240,40 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(tcp_timewait_state_process);
 
+static void tcp_time_wait_init(struct sock *sk, struct tcp_timewait_sock *tcptw)
+{
+#ifdef CONFIG_TCP_MD5SIG
+	const struct tcp_sock *tp = tcp_sk(sk);
+	struct tcp_md5sig_key *key;
+
+	/*
+	 * The timewait bucket does not have the key DB from the
+	 * sock structure. We just make a quick copy of the
+	 * md5 key being used (if indeed we are using one)
+	 * so the timewait ack generating code has the key.
+	 */
+	tcptw->tw_md5_key = NULL;
+	if (!static_branch_unlikely(&tcp_md5_needed.key))
+		return;
+
+	key = tp->af_specific->md5_lookup(sk, sk);
+	if (key) {
+		tcptw->tw_md5_key = kmemdup(key, sizeof(*key), GFP_ATOMIC);
+		if (!tcptw->tw_md5_key)
+			return;
+		if (!tcp_alloc_md5sig_pool())
+			goto out_free;
+		if (!static_key_fast_inc_not_negative(&tcp_md5_needed.key.key))
+			goto out_free;
+	}
+	return;
+out_free:
+	WARN_ON_ONCE(1);
+	kfree(tcptw->tw_md5_key);
+	tcptw->tw_md5_key = NULL;
+#endif
+}
+
 /*
  * Move a socket to time-wait or dead fin-wait-2 state.
  */
@@ -282,32 +316,7 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 		}
 #endif
 
-#ifdef CONFIG_TCP_MD5SIG
-		/*
-		 * The timewait bucket does not have the key DB from the
-		 * sock structure. We just make a quick copy of the
-		 * md5 key being used (if indeed we are using one)
-		 * so the timewait ack generating code has the key.
-		 */
-		do {
-			tcptw->tw_md5_key = NULL;
-			if (static_branch_unlikely(&tcp_md5_needed.key)) {
-				struct tcp_md5sig_key *key;
-
-				key = tp->af_specific->md5_lookup(sk, sk);
-				if (key) {
-					tcptw->tw_md5_key = kmemdup(key, sizeof(*key), GFP_ATOMIC);
-					if (!tcptw->tw_md5_key)
-						break;
-					BUG_ON(!tcp_alloc_md5sig_pool());
-					if (!static_key_fast_inc_not_negative(&tcp_md5_needed.key.key)) {
-						kfree(tcptw->tw_md5_key);
-						tcptw->tw_md5_key = NULL;
-					}
-				}
-			}
-		} while (0);
-#endif
+		tcp_time_wait_init(sk, tcptw);
 
 		/* Get the TIME_WAIT timeout firing. */
 		if (timeo < rto)
-- 
2.38.1

