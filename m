Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4931870B5D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjEVHGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjEVHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:05:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3859C94
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:02:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d604cc0aaso756561b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684738919; x=1687330919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKnhyBNVHnSoKN/wGLElGxvEFyvxXF8SFNAoMlqNKrY=;
        b=ZmZuiA9chQo3zzFy1MN/j1tmB3q9BwCEWejSH0Rw60P8CaMT86ntqYQ03QfwrZEVwq
         FkbNnm6pV+w/CbkyNpQ+JIfm6QmwN+qoKl+h+4+1xWAYo+xx2dS5AKRsDAhmXzTm3riv
         6Yo7TWV0fJGX3G/KMzwrWpCBq6ukeZdBlNENLcrA8ScMItzQjo6RKpDunzDs2oanPBXD
         bT6lMxF4eYBiZGA4Lw23kjUspUGRjpSUqS+8SDubOpIx/Nv5FJzFWf0+MgMdaFfeddqZ
         lv86fX/pMhyqLJO8qog2FKOhcCKTrmCQUbQsEEaaKowuWMks0r3LIMi2U5OtkHIU1Vd4
         ihOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738919; x=1687330919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKnhyBNVHnSoKN/wGLElGxvEFyvxXF8SFNAoMlqNKrY=;
        b=CXB4z2UTHpHNxTt67WzIZ00IRNwFM+KGPQ8h8GSNbO6ob8+1dfg8YRGDr7bT69HYl1
         qDHMe8XVZaZ07Zq3KJIdd/r/49yRnjnQj8ieLXwR0tOJ+fjjghXjGNM7Xvf7TB+p/c0x
         e1MI5w24AdJna1cLpai15YytZkavrcRDv9hlI7ngyLxF7f8kAtN+G+czeTbow20kexzD
         cUrcEyoqSI0Bv9/pxUCeydi7LDkBrf/MdZ2liRQ+sdCEiGWfrxUmVKavONxcBE7rPBS5
         akA7Ex9z+IRs+2B55tTkI3CixqTsBuozQ/vjCJyhK4Y2A4fqNTWrzzK3cr9dqLiiIqPH
         d2Ng==
X-Gm-Message-State: AC+VfDyl/XXWLxr6VRYRFkoncGBgdh4RwOWulcJZtsh+BUAp/HMawPlb
        rRGDX4ItZ2zUpyxc2EIzcrHr4A==
X-Google-Smtp-Source: ACHHUZ4B/jsyzL/apdJ3kEiN7e27Upz2uNormul3H87UZR7L7LeAxfmRdG+5Y/bM8xTdHdg7t8zukg==
X-Received: by 2002:a05:6a21:918c:b0:106:3b67:b5db with SMTP id tp12-20020a056a21918c00b001063b67b5dbmr9275449pzb.18.1684738919559;
        Mon, 22 May 2023 00:01:59 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d27-20020a630e1b000000b0052cbd854927sm3687505pgl.18.2023.05.22.00.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:01:58 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Glauber Costa <glommer@parallels.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v2 4/4] sock: Remove redundant cond of memcg pressure
Date:   Mon, 22 May 2023 15:01:22 +0800
Message-Id: <20230522070122.6727-5-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230522070122.6727-1-wuyun.abel@bytedance.com>
References: <20230522070122.6727-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now with the preivous patch, __sk_mem_raise_allocated() considers
the memory pressure of both global and the socket's memcg on a func-
wide level, making the condition of memcg's pressure in question
redundant.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 net/core/sock.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 7641d64293af..baccbb58a11a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3029,9 +3029,14 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (sk_has_memory_pressure(sk)) {
 		u64 alloc;
 
-		if (!sk_under_memory_pressure(sk))
+		if (!sk_under_global_memory_pressure(sk))
 			return 1;
 		alloc = sk_sockets_allocated_read_positive(sk);
+		/*
+		 * If under global pressure, allow the sockets that are below
+		 * average memory usage to raise, trying to be fair among all
+		 * the sockets under global constrains.
+		 */
 		if (sk_prot_mem_limits(sk, 2) > alloc *
 		    sk_mem_pages(sk->sk_wmem_queued +
 				 atomic_read(&sk->sk_rmem_alloc) +
-- 
2.37.3

