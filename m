Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD446F90B6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjEFI7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjEFI7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:59:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10C549E8
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 01:59:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaf91ae451so24722545ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 01:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683363559; x=1685955559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/yFOZs9UBviVnHJO1aVdELp7g3Y/8jlve773AyEi+qo=;
        b=KQpgaYXFK2A85M/RCva4x3AfDUaf3aYrBM1vsRUfoQGIOH6c3V9XLfWSprpd258rLw
         K/I75OR1FFIASPpdBEm/wO86r5MVhUCo8Ql1YcRoZSqowa+pzJsNLCZpldnKKeOBmbka
         jtodE6583Ef9EOMk/CiVC0TaVEB+hD2dc+1sx6qGYH7zTkQe8qKK5F8wCWIZHdld3PoC
         oY6FoWpcysb/+4lkQrM1bndqmTgOWum2LB9S5ItLRmfX87whljQXk4tY7nH4hqfHRT7w
         BV2GpAdZunJBx/IJQgFaT8Q99ptNpnpFTkehb/CthD7fTpO9+0sDNUpffNp8FnJuqApw
         pm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683363559; x=1685955559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yFOZs9UBviVnHJO1aVdELp7g3Y/8jlve773AyEi+qo=;
        b=CRJ1bmruLo6QL3bsgfIl14WAtqMgUMGTkMZwdLJkVs4lCJ9OLKQVNXETeF5VpK/CvH
         lADp0TO29EVXpGSZigGxQV0uC4m6ZeSudFZg6OlVnO3aBGHeKNoznPBTgRzbe9rV/VSQ
         UGODbblTmqlctNN4MEIaMsPhou1g1xdkH0H1tntldCIDbT19I/EgWrZ/Ol8UBDp1nJRG
         nHpNNELNSH1yZ/TS69s45eKjAMY44xBZr2AG2BHCITjjSSYF68q3mxdJoFDcbHydE+74
         asfGJsSSdmsdOGVeZC3yxq2bhuJgLXM8SlmhyhCOUxhpSMI1Ck+vqjRUcPZ0PztgwdMK
         Mv7Q==
X-Gm-Message-State: AC+VfDy+PX0eLlhmulMkstUk1FJEjfvqU84BeOVmZ11rrJvxwGG+Qxbk
        M8OkgaSklZ889YK+ZSJv06U2fw==
X-Google-Smtp-Source: ACHHUZ6AgOAs6K75h6psskFE61rfVFqoB/jeU15IOwds4ac9MR35NBruz5ueGPNh/FkckpCITsDYCw==
X-Received: by 2002:a17:903:6ce:b0:1a6:3799:ec2a with SMTP id kj14-20020a17090306ce00b001a63799ec2amr3451130plb.35.1683363559334;
        Sat, 06 May 2023 01:59:19 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902740200b001aaf2172418sm3083332pll.95.2023.05.06.01.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 01:59:18 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH] sock: Fix misuse of sk_under_memory_pressure()
Date:   Sat,  6 May 2023 16:59:03 +0800
Message-Id: <20230506085903.96133-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 180d8cd942ce ("foundations of per-cgroup memory pressure
controlling") wrapped proto::memory_pressure status into an accessor
named sk_under_memory_pressure(), and in the next commit e1aab161e013
("socket: initial cgroup code") added the consideration of net-memcg
pressure into this accessor.

But with the former patch applied, not all of the call sites of
sk_under_memory_pressure() are interested in net-memcg's pressure.
The __sk_mem_{raise,reduce}_allocated() only focus on proto/netns
pressure rather than net-memcg's. IOW this accessor are generally
used for deciding whether should reclaim or not.

Fixes: e1aab161e013 ("socket: initial cgroup code")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/net/sock.h |  5 -----
 net/core/sock.c    | 17 +++++++++--------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8b7ed7167243..752d51030c5a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1404,11 +1404,6 @@ static inline int sk_under_cgroup_hierarchy(struct sock *sk,
 #endif
 }
 
-static inline bool sk_has_memory_pressure(const struct sock *sk)
-{
-	return sk->sk_prot->memory_pressure != NULL;
-}
-
 static inline bool sk_under_memory_pressure(const struct sock *sk)
 {
 	if (!sk->sk_prot->memory_pressure)
diff --git a/net/core/sock.c b/net/core/sock.c
index 5440e67bcfe3..8d215f821ea6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3017,13 +3017,14 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 		}
 	}
 
-	if (sk_has_memory_pressure(sk)) {
-		u64 alloc;
-
-		if (!sk_under_memory_pressure(sk))
-			return 1;
-		alloc = sk_sockets_allocated_read_positive(sk);
-		if (sk_prot_mem_limits(sk, 2) > alloc *
+	if (prot->memory_pressure) {
+		/*
+		 * If under global pressure, allow the sockets that are below
+		 * average memory usage to raise, trying to be fair between all
+		 * the sockets under global constrains.
+		 */
+		if (!*prot->memory_pressure ||
+		    sk_prot_mem_limits(sk, 2) > sk_sockets_allocated_read_positive(sk) *
 		    sk_mem_pages(sk->sk_wmem_queued +
 				 atomic_read(&sk->sk_rmem_alloc) +
 				 sk->sk_forward_alloc))
@@ -3095,7 +3096,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, amount);
 
-	if (sk_under_memory_pressure(sk) &&
+	if (sk->sk_prot->memory_pressure && *sk->sk_prot->memory_pressure &&
 	    (sk_memory_allocated(sk) < sk_prot_mem_limits(sk, 0)))
 		sk_leave_memory_pressure(sk);
 }
-- 
2.37.3

