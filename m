Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073CF70D96F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjEWJr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjEWJr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:47:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE15912B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:47:20 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2b42a8f9so4052172b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684835240; x=1687427240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMeJmdZ3LE5akFulN2YKZF3yDR93Nfz5GrpK/FAs6Mo=;
        b=B880Cxou7jMNKnnSKqDvzpC383QnKFgaQTrZAh4pbCWGQDOYZUEc8zYZUAxp7NPvWc
         CsjI7yZYanPUalpRPeD2nCqoLZMUtdNB+Ms+r7OTLt11AnB6gE9PzZX2y4l/uEgB82su
         bk4IUOW9jAt+YQbn+pEhnisTxz4JT9+fK1UPMkDDqmvFehCp110UUTwT82dkhOCRSV2B
         OusFDNXP5SXR3tQoyhiFkMm9c3F5Ystg4nQLs88KZkmM4R+US3twYrGo4ZoU+pTU+56O
         Al76H1vOTCw/bvnS3oRpbJAO76zM5SiM+8ysyWNCRK02fSpe4Lv3Usptqw1AiFqFxgJ3
         gufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835240; x=1687427240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMeJmdZ3LE5akFulN2YKZF3yDR93Nfz5GrpK/FAs6Mo=;
        b=BrF26BL2juIGQzJW0255CWB420yiKwHSZZpT6FsDIu6cOhJrhGsWMe5pWj88amkP/x
         AsERo43pWXd3WyIZroXvAT4x8a5bkfsZHC168G6jjyrZA6xQJI/MOaDSIbs2kBNRNtG+
         +UK+IWF9RwUu4Tww6XibBUG1VeN+fOlBS3PsATkaRqkXgw+fhdby3omnaiu/0VihVCbW
         T57cDfthwMZVdNulVYDBzlQxR/Di8oTD/AWqAn3TkqjBM1XPSm877OmJUJORE+HptJ9x
         oLf6/pN/pdh0tfMkfGU4TZXmFud4h7/2N6AVt90juFtbaSI0iGUFrTOFaPjnKGOQOX85
         44Zg==
X-Gm-Message-State: AC+VfDxt+siAtY2yOBHQpO1Wgxrj7xi4GQXP0Jq7LWXF6VI4II1oC4P8
        eW9SXmnI20roZWXJN4Lypp5x3A==
X-Google-Smtp-Source: ACHHUZ60ph85ln3tks03J8F3mcWJkoGwj8Q3B23yzE+pbnOSHqFgxY7Jd2TalWB1xt2fu/FZ4z/eVg==
X-Received: by 2002:a05:6a00:2e0e:b0:646:3c2:4d30 with SMTP id fc14-20020a056a002e0e00b0064603c24d30mr16266161pfb.30.1684835240594;
        Tue, 23 May 2023 02:47:20 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79116000000b0063b898b3502sm5457216pfh.153.2023.05.23.02.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:47:20 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v3 3/5] sock: Fix misuse of sk_under_memory_pressure()
Date:   Tue, 23 May 2023 17:46:50 +0800
Message-Id: <20230523094652.49411-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230523094652.49411-1-wuyun.abel@bytedance.com>
References: <20230523094652.49411-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status of global socket memory pressure is updated when:

  a) __sk_mem_raise_allocated():

	enter: sk_memory_allocated(sk) >  sysctl_mem[1]
	leave: sk_memory_allocated(sk) <= sysctl_mem[0]

  b) __sk_mem_reduce_allocated():

	leave: sk_under_memory_pressure(sk) &&
		sk_memory_allocated(sk) < sysctl_mem[0]

So the conditions of leaving global pressure are inconstant, which
may lead to the situation that one pressured net-memcg prevents the
global pressure from being cleared when there is indeed no global
pressure, thus the global constrains are still in effect unexpectedly
on the other sockets.

This patch fixes this by ignoring the net-memcg's pressure when
deciding whether should leave global memory pressure.

Fixes: e1aab161e013 ("socket: initial cgroup code.")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/net/sock.h | 9 +++++++--
 net/core/sock.c    | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index b0e5533e5909..257706710be5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1409,13 +1409,18 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 	return sk->sk_prot->memory_pressure != NULL;
 }
 
+static inline bool sk_under_global_memory_pressure(const struct sock *sk)
+{
+	return sk->sk_prot->memory_pressure &&
+		*sk->sk_prot->memory_pressure;
+}
+
 static inline bool sk_under_memory_pressure(const struct sock *sk)
 {
 	if (mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
-	return sk->sk_prot->memory_pressure &&
-		*sk->sk_prot->memory_pressure;
+	return sk_under_global_memory_pressure(sk);
 }
 
 static inline long
diff --git a/net/core/sock.c b/net/core/sock.c
index 5440e67bcfe3..801df091e37a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3095,7 +3095,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
 
-	if (sk_under_memory_pressure(sk) &&
+	if (sk_under_global_memory_pressure(sk) &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
 		sk_leave_memory_pressure(sk);
 }
-- 
2.37.3

