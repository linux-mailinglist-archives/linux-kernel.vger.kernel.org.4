Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CDD634416
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiKVS4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKVSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:55:51 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B728C4AF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:55:49 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id t4so11390449wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPghztDyNLrGZj1mqaJMElT+/qfziwsQcb93YPm7Lak=;
        b=dO73XNvLNUxhRWlOwGNlJpCjt4PXa88+Qjbo4PFwSZnzShYdiUS0WwRSvALrE/jBfQ
         CgWtYXSTCk0GPD2GmPJTp0jvNFCTo2S8Ymz98NFuvFl7RpSXRtjYibGjf76lrTRaucfa
         AKO1xsNMoULLDmXtifVslscIuTs30JbOq4ZE8eB5F2f0mYhoV6dNlcFZJOz0psyyTPZS
         Gx7CaYT1oMxBcO7PtxUttbLYOrW7lqwGDFbKGlEC9PBtEB7EPdtM9paGiOYWOL0ieG51
         YlfjrdaCorVbWzKheC88eTN2505iTCOvKaN6Dkqqsi9gFaShSA+x0/SabPvsbYt1utsc
         gppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPghztDyNLrGZj1mqaJMElT+/qfziwsQcb93YPm7Lak=;
        b=7wzih0MboGthysEHUjmKzfBQ0PEblOfqK7qJlvDNaGHU1XEd5TfgdHQnDamNQb0gdD
         I9vzGg02vcYKhtuXpFQIdZnfGF9jywd16IrHbve4lnic5JHZ7sMGBirsYeo8MgFNr223
         ebk6yqAQCtlI5gjH2G2QAemqo1M4o8CL/V4y+hqDUNrTSg/5kDAASuk4Rs7VKUj4Ai2u
         tH51XntelfFkELFV6AD9U5emqXKnGD2n1la6+rp+YDgU1JWAV105uNLaMk2C6mrfioeA
         4jrqstrcdZnmWP5aXRJOiBdqSd+Pa489Zz60+PGwAx9N31T3J1BKXQMfmWPBgJ70ebz0
         KCXA==
X-Gm-Message-State: ANoB5pk5x2jhwUELZ/0YzzjIvpMv9jpN26rh1hMfDPduT9Rkw00CMYzb
        6EQTbgqzlF9KnMGqbgGUh8HnTzoMIakh8A==
X-Google-Smtp-Source: AA0mqf7GN7b0ubP0erqtiVeGiIvEiAPWeOgyxmeOqIJg0KPRqKFVYwrI9eWZOiIQR1aFEWiXhoJE/g==
X-Received: by 2002:a05:600c:3d0c:b0:3cf:f66c:9246 with SMTP id bh12-20020a05600c3d0c00b003cff66c9246mr5429143wmb.27.1669143348802;
        Tue, 22 Nov 2022 10:55:48 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb12000000b002365730eae8sm14478044wrr.55.2022.11.22.10.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 10:55:48 -0800 (PST)
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
Subject: [PATCH v5 5/5] net/tcp: Separate initialization of twsk
Date:   Tue, 22 Nov 2022 18:55:34 +0000
Message-Id: <20221122185534.308643-6-dima@arista.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122185534.308643-1-dima@arista.com>
References: <20221122185534.308643-1-dima@arista.com>
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
Acked-by: Jakub Kicinski <kuba@kernel.org>
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

