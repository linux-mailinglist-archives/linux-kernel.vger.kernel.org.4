Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2CA715D86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjE3LlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjE3Lk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:40:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EF5B0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:40:33 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d2a613ec4so3121128b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685446833; x=1688038833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSeZy3dBgM/hAvW1l4S3j81M4ry+F3vLfbl4Wg72DeY=;
        b=hhLQ3LoKBaJEJ5y7uGQ1a6tBrIrMZV+1pnIfqUg+3PPYZLcdnc+7VDqo7mmHd61hrj
         Sd4swO79Q16159eQDWb/4DVkqYPSM/uwLu9+nrIMavuQvSS0iMMA2tKxbWYOLOTyMNNW
         8Q9YqbEBpn+Nx2pNK4smxSztJf5X5kZARTJKBTBELw90yTB1VKCkqnwAR8Px/p/KKR7V
         fOhc0w5nYnh7RRxeDgcc3lEBrXih07VolZo5Ebp7QGT1yNFQEfcQDeiZsXJhF9CLMeJk
         SavXV7b4KyPrvCtY6W/D4aQTnvHV5HjuN8C1ttrCgPPMzrSoHBP01IYNksy9EhRLI1EZ
         mTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685446833; x=1688038833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSeZy3dBgM/hAvW1l4S3j81M4ry+F3vLfbl4Wg72DeY=;
        b=arwlp0/MzzkCSrhup4Jv/h++0yPDRtuFwhc/eFFVj5DLcfQF5oH4/1hbl+6c564hI+
         yA3/Er1wia5j8hKnOPi+k2UhDf5fvaFEwkAfuh/9Vj27ZIheaw70Z/M6wlxTSD7OfbH9
         KJLg7beFbJuldD9RpzE+8HZZPv2lqEbrABYDSWYZ8Nu2esRpd1lZKn4wX25CWxfZaK6e
         /RgFcPDrCDpY9f1xuXwjQqKx/drJdU01UC5TVGT4Zc/9LyaGJnLe7/3WleFWUb4SVMz2
         gGazQ+mCuO4A+saU+guS56MEUx416F2UCNnF8mmfR6sbkRwSagubnLoDHxeyVuHqZsBe
         Z1qQ==
X-Gm-Message-State: AC+VfDwmgx/T1MS30+xIc1bKOR15V4aQvP0XWBBtiIT2ljZ7Lqjo1qRB
        WMqQxtrKly7BFZtVr2aXHJud0g==
X-Google-Smtp-Source: ACHHUZ4xzkdDhUOHefB08/7eoqUUKTgwsuecz4t21GvJg0uPWZgET1FRSQPRi1s3ik542LqiUkJgag==
X-Received: by 2002:a05:6a20:8e14:b0:103:b0f9:7110 with SMTP id y20-20020a056a208e1400b00103b0f97110mr2307010pzj.11.1685446833446;
        Tue, 30 May 2023 04:40:33 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j20-20020aa78dd4000000b00642ea56f06fsm1515103pfr.0.2023.05.30.04.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 04:40:32 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 1/4] net-memcg: Fold dependency into memcg pressure cond
Date:   Tue, 30 May 2023 19:40:08 +0800
Message-Id: <20230530114011.13368-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230530114011.13368-1-wuyun.abel@bytedance.com>
References: <20230530114011.13368-1-wuyun.abel@bytedance.com>
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

The callers of mem_cgroup_under_socket_pressure() should always make
sure that (mem_cgroup_sockets_enabled && sk->sk_memcg) is true. So
instead of coding around all the callsites, put the dependencies into
mem_cgroup_under_socket_pressure() to avoid redundancy and possibly
bugs.

This change might also introduce slight function call overhead *iff*
the function gets expanded in the future. But for now this change
doesn't make binaries different (checked by vimdiff) except the one
net/ipv4/tcp_input.o (by scripts/bloat-o-meter), which is probably
negligible to performance:

add/remove: 0/0 grow/shrink: 1/2 up/down: 5/-5 (0)
Function                                     old     new   delta
tcp_grow_window                              573     578      +5
tcp_try_rmem_schedule                       1083    1081      -2
tcp_check_space                              324     321      -3
Total: Before=44647, After=44647, chg +0.00%

So folding the dependencies into mem_cgroup_under_socket_pressure()
is generally a good thing and provides better readablility.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/memcontrol.h | 2 ++
 include/net/sock.h         | 3 +--
 include/net/tcp.h          | 3 +--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 222d7370134c..a1aead140ff8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1743,6 +1743,8 @@ void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
+	if (!mem_cgroup_sockets_enabled || !memcg)
+		return false;
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_pressure)
 		return true;
 	do {
diff --git a/include/net/sock.h b/include/net/sock.h
index 8b7ed7167243..641c9373b44b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1414,8 +1414,7 @@ static inline bool sk_under_memory_pressure(const struct sock *sk)
 	if (!sk->sk_prot->memory_pressure)
 		return false;
 
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
+	if (mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
 	return !!*sk->sk_prot->memory_pressure;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 04a31643cda3..3c5e3718b454 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -261,8 +261,7 @@ extern unsigned long tcp_memory_pressure;
 /* optimized version of sk_under_memory_pressure() for TCP sockets */
 static inline bool tcp_under_memory_pressure(const struct sock *sk)
 {
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
+	if (mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
 	return READ_ONCE(tcp_memory_pressure);
-- 
2.37.3

