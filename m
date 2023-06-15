Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE2B730B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbjFNXLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbjFNXK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:10:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2A32964
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:10:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so11091635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1686784217; x=1689376217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEfh4EMCc4IqGl/BAj96gbhPEjHc5nbwj1sO374I1UA=;
        b=K1WZl6oLNfkdEChs+Ovrq1V9Cm05mE6kgCk0LxvIhTdhfsjWCKMAjISSuVS6TUgu5r
         TQKF+5KCfIZzDtnfDvmEWNDAKTHdKz3GCA/Cf5PjZW5a6kf97LgI2yafsyXJcI2SEjUv
         q3/+vdDRoqTV87UmCUSVwkeprW3lklAaJoJPAsx1pN3S4JJ24ttTNlCuSJuNzCxE/P8V
         ecmIPEUyIpBvcBIrD0u+dgoAkmulGRaY56DlkDyD9idkAyh8jJgjKrpeouJJCfWUECdP
         siuFN6ZKBQEX/NfrsVdY6UR/QQdfs/5BTt+RBv5QrW/MqqhMC3aUS/kHpnF+aBXJ4/Cc
         cGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686784217; x=1689376217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEfh4EMCc4IqGl/BAj96gbhPEjHc5nbwj1sO374I1UA=;
        b=HH11PPqIMJsVNz/hkmyYket49OerLmIwNg0EXj7duxM7rGh8++IVHIienIvfmisxYo
         MWNp0Lj8XItmtzCrhREZUlMKYONMzPwoMZ9io3Pxzm8P4/lFYA/TeuE2JYijXlpPOnR6
         rhCrtmK2OWqNzSlOs5lx9Q6Lmf8/kA6qvK1oJ6VpApq1ciJyIyq9Ga4QoKGQCdQL39G5
         t25xYOpx4RDFiHHEA2oxhMkgvts3R0Xmmx9EKWUBBW4J8B5zK00cqBLfP2GG6lgKNoMU
         seePinTKFCBRVjhE2HtzkGdVwT87FgHyBgeDSqQCjjiUxQx/lb420/wAFkPZ7k1AcIqc
         aUTQ==
X-Gm-Message-State: AC+VfDz2Z+c0ENYLhubC8kOapF+NMPWMzN7vBcmUFDWfkto/5OezuTAT
        mhj/1TK5PTmvrxRtcwaIdYVgoTkJuMq+Br05fBc=
X-Google-Smtp-Source: ACHHUZ4u/F6VStzS7y3pGTaJOty5h7bxsd/9ikWh82asEzz1GKxZZc48FFKjHsrzv74n/QFV7UlblA==
X-Received: by 2002:a5d:5909:0:b0:30f:cdde:5ded with SMTP id v9-20020a5d5909000000b0030fcdde5dedmr4403746wrd.48.1686784217447;
        Wed, 14 Jun 2023 16:10:17 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s12-20020a7bc38c000000b003f7ba52eeccsm18725261wmj.7.2023.06.14.16.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 16:10:17 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Subject: [PATCH v7 14/22] net/tcp: Add TCP-AO SNE support
Date:   Thu, 15 Jun 2023 00:09:39 +0100
Message-Id: <20230614230947.3954084-15-dima@arista.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230614230947.3954084-1-dima@arista.com>
References: <20230614230947.3954084-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sequence Number Extension (SNE) for TCP-AO.
This is needed to protect long-living TCP-AO connections from replaying
attacks after sequence number roll-over, see RFC5925 (6.2).

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_input.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9e0a3dd9e9e0..eed3f7631b4b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3528,9 +3528,21 @@ static inline bool tcp_may_update_window(const struct tcp_sock *tp,
 static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
 {
 	u32 delta = ack - tp->snd_una;
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao;
+#endif
 
 	sock_owned_by_me((struct sock *)tp);
 	tp->bytes_acked += delta;
+#ifdef CONFIG_TCP_AO
+	ao = rcu_dereference_protected(tp->ao_info,
+				       lockdep_sock_is_held((struct sock *)tp));
+	if (ao) {
+		if (ack < ao->snd_sne_seq)
+			ao->snd_sne++;
+		ao->snd_sne_seq = ack;
+	}
+#endif
 	tp->snd_una = ack;
 }
 
@@ -3538,9 +3550,21 @@ static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
 static void tcp_rcv_nxt_update(struct tcp_sock *tp, u32 seq)
 {
 	u32 delta = seq - tp->rcv_nxt;
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao;
+#endif
 
 	sock_owned_by_me((struct sock *)tp);
 	tp->bytes_received += delta;
+#ifdef CONFIG_TCP_AO
+	ao = rcu_dereference_protected(tp->ao_info,
+				       lockdep_sock_is_held((struct sock *)tp));
+	if (ao) {
+		if (seq < ao->rcv_sne_seq)
+			ao->rcv_sne++;
+		ao->rcv_sne_seq = seq;
+	}
+#endif
 	WRITE_ONCE(tp->rcv_nxt, seq);
 }
 
@@ -6371,6 +6395,17 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 * simultaneous connect with crossed SYNs.
 		 * Particularly, it can be connect to self.
 		 */
+#ifdef CONFIG_TCP_AO
+		struct tcp_ao_info *ao;
+
+		ao = rcu_dereference_protected(tp->ao_info,
+					       lockdep_sock_is_held(sk));
+		if (ao) {
+			ao->risn = th->seq;
+			ao->rcv_sne = 0;
+			ao->rcv_sne_seq = ntohl(th->seq);
+		}
+#endif
 		tcp_set_state(sk, TCP_SYN_RECV);
 
 		if (tp->rx_opt.saw_tstamp) {
-- 
2.40.0

