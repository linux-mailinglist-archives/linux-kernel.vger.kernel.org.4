Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D62734D98
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjFSI0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjFSI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:26:36 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF1A10E2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:26:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668709767b1so766589b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687163162; x=1689755162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8yD1wR7/XPi7gwA6elrYpxc4KO0mgxsWGuKssVmyeI=;
        b=WNEWwE+H7gcDOhV2Dj5pUjomec9Q1dRItxWLOwUse39FDkRFNWtAGNXrSIHa8T7Ll2
         uN9J8ANpjQCF9tOe8miijYmNYk0nfUdb18wt3+dAj+x3E4mJDQOUgneMkPoDaq6Ub6l8
         Do22aI1mst4d7HhCqd7pBZn1URcges292+Fru4h5IyfEAIxCnkBm/ekYqZWn7JDoxn+v
         KVqG7NUu7bL8bWqyMSC7/SmbEQEK+YU47feC1atSjnqmGaHtiGGe80hiBw3P6UpZunWh
         80o2kuAu9JnmlX2azWCZHoob/dMSrAGoEVEVx/dXvOPv5CQwNZPSH0LnDb/xWz55ffL4
         a+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687163162; x=1689755162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8yD1wR7/XPi7gwA6elrYpxc4KO0mgxsWGuKssVmyeI=;
        b=jNFCATNrG7+QaduCs4xnmzkf5UhOFnT5Sgdyd4FTHuoYGdLhOiz79cdEUuqQLGQSNp
         0PqoQ2uFz/6eExTfCNUpEK2m9qMBBavZaiAZzdQq3j6P2zFWcMFI7lUaAUDbb6uNdcW5
         Gq811Rd+9PCYPt6iDt0u5XBx3Oty/HFWv0Kqpdmlus8/tVEbgReJXqEN6Sx61PUc9Ct4
         +rQR4n0Yr+R0XhnQxUM6aPZC5oivfwXvBMsXlHL8ypgnUF92hpgNYpvnoqCjHnH4fY7q
         sYyw8Z+LhJUfGelj3PEc+YfCQNprD0p21hSMZLJQaTRczOtLy5RFfEdZJLQML9kYVNTD
         c1Kw==
X-Gm-Message-State: AC+VfDwPkxI7GI46GsYerFq+3sCVUM+oC2zvVFxMkYzP1Eo8YBJRuE12
        x7nUMBBo0MSParC31mUpQwJi8g==
X-Google-Smtp-Source: ACHHUZ61SXRvFwz2nwiq7U1Bpd/nBf/vrNF+H3x9Gp8UobOHG9D71Y53Y6gOfu9A/lYKVSKyEcVdyA==
X-Received: by 2002:a05:6a00:a02:b0:663:f82b:c6d9 with SMTP id p2-20020a056a000a0200b00663f82bc6d9mr10107983pfh.22.1687163162592;
        Mon, 19 Jun 2023 01:26:02 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id a6-20020aa780c6000000b00634b91326a9sm3060093pfn.143.2023.06.19.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:26:01 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] inet: Save one atomic op if no memcg to charge
Date:   Mon, 19 Jun 2023 16:25:47 +0800
Message-Id: <20230619082547.73929-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no net-memcg associated with the sock, don't bother
calculating its memory usage for charge.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 net/ipv4/inet_connection_sock.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 65ad4251f6fd..73798282c1ef 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -706,20 +706,24 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
 out:
 	release_sock(sk);
 	if (newsk && mem_cgroup_sockets_enabled) {
-		int amt;
+		int amt = 0;
 
 		/* atomically get the memory usage, set and charge the
 		 * newsk->sk_memcg.
 		 */
 		lock_sock(newsk);
 
-		/* The socket has not been accepted yet, no need to look at
-		 * newsk->sk_wmem_queued.
-		 */
-		amt = sk_mem_pages(newsk->sk_forward_alloc +
-				   atomic_read(&newsk->sk_rmem_alloc));
 		mem_cgroup_sk_alloc(newsk);
-		if (newsk->sk_memcg && amt)
+		if (newsk->sk_memcg) {
+			/* The socket has not been accepted yet, no need
+			 * to look at newsk->sk_wmem_queued.
+			 */
+			amt = sk_mem_pages(newsk->sk_forward_alloc +
+					   atomic_read(&newsk->sk_rmem_alloc));
+
+		}
+
+		if (amt)
 			mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
 						GFP_KERNEL | __GFP_NOFAIL);
 
-- 
2.37.3

