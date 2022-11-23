Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C08E63676D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbiKWRkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbiKWRjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:39:22 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAAE9E963
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:39:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso3368754wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmDkIrBVfUMbGOBltM7PoGg9g03wcI36X1ZwAu/jynQ=;
        b=LD4MRU/DCHliVq/YHIZWlJjin2QNdAQoGk6lgZc7akHPAmqjUFE+ut9mFMd5QKCTyf
         PJf2edhebPqnUqt4K8K299b4GrfwP7I5Copin0aWgc4XFCrjzWezRndf8zYDKvqNkCKw
         HdbrVFAo/kax408LxOrsyGVtsD9aBrZCeMyT3xf5JTdnUFpwUGLHhTCm8fpesn0qb5T/
         N3xgajw6m/aydB1XrJQaiBdcYpFNlAw1O8ABAZeXPMQAoBFMV4pxPD6PnCV7qJ7xHEn0
         Uj1z+rJP0hrEReE8EHSMJDn4spd8ohJxIRV08XYc0y6yrZ8jHJsjibrjIdViRC2PraV5
         jiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmDkIrBVfUMbGOBltM7PoGg9g03wcI36X1ZwAu/jynQ=;
        b=b3Yc96HRhxArtl69rVcllgBDu3/f9zzcY9SJmS7mAmwGaw0zbHOBCRi12iAV4qr3YJ
         L/6lBhJY0ZnjfH8hrM7nSqJiIXhF7tJE7KBpQJfK5BeA4cT65YnbNtHRyXnkc8pXR3uN
         6nvuppFNEVUQizdjAxnZyLX1Goqs3wOMfOb1orn7f1nHQXAAatgonMDXlpQ9RmMn83P7
         n1LlTlB07lORq1IS3uqH4TuTt1OXid12ueVgYviP7xI0mc7FTztdEcHrVUg3Mvxwn+cP
         SBW4Bqlpdq0YZdkXdCSuzvocgkIFMIyos4bJIW0Ph+Gd/lPiV1DiubrazPyx24Tu6kCJ
         qdUQ==
X-Gm-Message-State: ANoB5pl31Xyv9LhnVvFazrlOCtTwQrGi+f3xn5OrVLutpPzxYTNEhBa4
        /1ufxM2zUNSsH2XRQK6+THLcsc6gMwCEhw==
X-Google-Smtp-Source: AA0mqf7ymQbNbUEzGQzIwWAlN38NB9tz8tam6wmSGZCHApcPTqMq/u7sSBgUVZX6mslnPfL8DK6IeA==
X-Received: by 2002:a05:600c:2296:b0:3cf:baa6:8ca5 with SMTP id 22-20020a05600c229600b003cfbaa68ca5mr7025631wmf.178.1669225152774;
        Wed, 23 Nov 2022 09:39:12 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id v10-20020adfe28a000000b0023647841c5bsm17464636wri.60.2022.11.23.09.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:39:12 -0800 (PST)
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
Subject: [PATCH v6 4/5] net/tcp: Do cleanup on tcp_md5_key_copy() failure
Date:   Wed, 23 Nov 2022 17:38:58 +0000
Message-Id: <20221123173859.473629-5-dima@arista.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123173859.473629-1-dima@arista.com>
References: <20221123173859.473629-1-dima@arista.com>
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

If the kernel was short on (atomic) memory and failed to allocate it -
don't proceed to creation of request socket. Otherwise the socket would
be unsigned and userspace likely doesn't expect that the TCP is not
MD5-signed anymore.

Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ipv4/tcp_ipv4.c |  9 ++-------
 net/ipv6/tcp_ipv6.c | 15 ++++++++-------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2ae6a061f36e..e214098087fe 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1630,13 +1630,8 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	addr = (union tcp_md5_addr *)&newinet->inet_daddr;
 	key = tcp_md5_do_lookup(sk, l3index, addr, AF_INET);
 	if (key) {
-		/*
-		 * We're using one, so create a matching key
-		 * on the newsk structure. If we fail to get
-		 * memory, then we end up not copying the key
-		 * across. Shucks.
-		 */
-		tcp_md5_key_copy(newsk, addr, AF_INET, 32, l3index, key);
+		if (tcp_md5_key_copy(newsk, addr, AF_INET, 32, l3index, key))
+			goto put_and_exit;
 		sk_gso_disable(newsk);
 	}
 #endif
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 83304d6a6bd0..21486b4a9774 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1376,13 +1376,14 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	/* Copy over the MD5 key from the original socket */
 	key = tcp_v6_md5_do_lookup(sk, &newsk->sk_v6_daddr, l3index);
 	if (key) {
-		/* We're using one, so create a matching key
-		 * on the newsk structure. If we fail to get
-		 * memory, then we end up not copying the key
-		 * across. Shucks.
-		 */
-		tcp_md5_key_copy(newsk, (union tcp_md5_addr *)&newsk->sk_v6_daddr,
-				 AF_INET6, 128, l3index, key);
+		const union tcp_md5_addr *addr;
+
+		addr = (union tcp_md5_addr *)&newsk->sk_v6_daddr;
+		if (tcp_md5_key_copy(newsk, addr, AF_INET6, 128, l3index, key)) {
+			inet_csk_prepare_forced_close(newsk);
+			tcp_done(newsk);
+			goto out;
+		}
 	}
 #endif
 
-- 
2.38.1

