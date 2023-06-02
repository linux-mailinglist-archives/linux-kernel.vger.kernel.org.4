Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD95471FB96
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjFBIMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjFBIL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:11:59 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC8F19B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:11:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53063897412so1709077a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685693516; x=1688285516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCepPOl9mp4meHusGBh1Wos+X24ELWJG4xhc1EAvakM=;
        b=akVOHUmEY2HrSn8sCzEPkJCFaO4u/D8Dl9fqbknyN67dHYkE9iTOGSKXYoTJp6cVCd
         JRl8C39ECchyPoiYpI/L8CS3Bn86nSsQnpFshC4ZMefWpdMj0zzc6//2p2olbGZ2xWTL
         1bQXup3D0YO7GRokeldNi9fgYYhlqHntQbM6BpJy04r8p7E4nCjFY16KmEXA2chJkH17
         m6LIljvVpIUuddw7o4NcWuHZP2Hw6BQBMPCqmzvnsRrHSvuKCVsLrhDbPDn8dsaov90H
         bOXS93BM+3QrLj9jFZtV+yrsJzn3pOKUGkUfUicRFlygWh/gPgOc0/Ypcg4bN+tt9Dfl
         WQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685693516; x=1688285516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCepPOl9mp4meHusGBh1Wos+X24ELWJG4xhc1EAvakM=;
        b=AZkNYlACDwjqe37LxSzYAYE/bKCe5mcyJQ+QOceVDwDdRt3+V+eX1U8CnS6ZOMXaxh
         K7Qdt7mZ9N3/g0Em/2ZrZb1pCgqAL5laWNY+IBk7hfiL/CgEoz3gNBDVo8HUwPLLmcx0
         bRDrJkAx+RHpZyZ50Eipbsc+W9apbC9d4ezV5ipJnP/m2Z1yZLm52wFL2y2H9saU9JTj
         omPfBRE/rr5WSbmIzG4Dl8io5OD/JT492hcdYMA55NR+4iGcg6gCqcdRH7oWfuTjP+QR
         KRYS2qGEk+wnh/Btn+M/26fsLi0ozelLUDj6b7uYWca9aA/pyUWeksBktEzn4v23IAy2
         3QfA==
X-Gm-Message-State: AC+VfDx/hkjobsNd8YKbnsptjnTHfFzLdBalkuUiuy6r3Rdj712bZXR9
        axUr87mKInAmmMw3bqscliOEbA==
X-Google-Smtp-Source: ACHHUZ5DwYTBIaQBiPoaru74ouktiUFZQ/5VNR/JoQ2bzJ9gjHqpW8vuV2nlRo37pxM4NQD552U2Cw==
X-Received: by 2002:a17:902:c94b:b0:1b1:a9e7:5d4b with SMTP id i11-20020a170902c94b00b001b1a9e75d4bmr2030133pla.22.1685693516240;
        Fri, 02 Jun 2023 01:11:56 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001b025aba9edsm703570plb.220.2023.06.02.01.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:11:55 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/3] net-memcg: Fold dependency into memcg pressure cond
Date:   Fri,  2 Jun 2023 16:11:33 +0800
Message-Id: <20230602081135.75424-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230602081135.75424-1-wuyun.abel@bytedance.com>
References: <20230602081135.75424-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 656ea89f60ff..3f63253ee092 100644
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
index 14fa716cac50..d4c358bc0c52 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -259,8 +259,7 @@ extern unsigned long tcp_memory_pressure;
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

