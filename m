Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B99570B5D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjEVHF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjEVHFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:05:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070991FC0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:02:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-25345ca8748so4721626a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684738915; x=1687330915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1oOKoVyoIUj8JPcN8+63Cdo8i/cPI1zhOYlcZa0hSM=;
        b=enaay0xaoWLn/utKosxoWRmovCC2iDOPsViPWAcSu4/JYlpa61g+2mofypwr36XV6P
         5J3FltcUkPLQkIl0AZJuYxAJtrS6Ks0D8MuZLcveqzNcyyAJqnubyinFllJt+2ys+NkJ
         68YlViqxi2UvNOTwFFXFpMSMLyiRimLE2iWipptXmQyAZXdKBmKATAFkFEQgja08ESC7
         2bKN4+w6r38j+xphjcn508J/X8RhzgKuNcSOUxWHrnOH3iClosHDqVgE0Fl8TVP7ywoO
         W8xflpGtFM3isY8piNeZ98x693UPRt6aX4eeOCZnFll7sC9O0u1+a2pAmnLNHXwULg9U
         pJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738915; x=1687330915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1oOKoVyoIUj8JPcN8+63Cdo8i/cPI1zhOYlcZa0hSM=;
        b=R7WQFwWcuS5cmBFz6wLXaA+WW4chfu9Hm8PviGUUd7TzxZiC6GwXn59InlBH0I4NM1
         KtVYaWfL76xXFAxnGnTPeRM8m/u0nmv9ddmmzYLWiymAWG+NZrfVL+M7OOPf5BYEn0Qn
         giTfNcf5ADrDbDCEpS1H5JjqRNXGx8L6IW1jcP8fqRnRztgnjYrY+mrwvwWkSUAmx9pf
         zYtOF3VTbqer2LIpM2Jc3zgsU7XCwAWghFBJy5QP7P0/y3l5AjzcgQl1rx1fNT51yBGL
         sHjdUuv63uulu9xbRX4zkdJoXc7n060OVAte774Juso6hsheJo+c5x2XPc/VVqOlSttx
         nVZQ==
X-Gm-Message-State: AC+VfDywZwGyNDDekHtkrUgt2w6KkgXWUvJKb4H6i3dVo9RYM+u9I8fj
        Mv/klHMDKpdtGQrNfN2Ju+/CYg==
X-Google-Smtp-Source: ACHHUZ4o2D5U9H7O9EVzembFmHB5vNmURPTxvA+5i11/ATadoYPSFYWcOfJ9V/84ql5EYbtBEo1FuA==
X-Received: by 2002:a17:90b:1d0c:b0:255:67e3:98a with SMTP id on12-20020a17090b1d0c00b0025567e3098amr2054678pjb.11.1684738915145;
        Mon, 22 May 2023 00:01:55 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d27-20020a630e1b000000b0052cbd854927sm3687505pgl.18.2023.05.22.00.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:01:54 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Glauber Costa <glommer@parallels.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v2 3/4] sock: Consider memcg pressure when raising sockmem
Date:   Mon, 22 May 2023 15:01:21 +0800
Message-Id: <20230522070122.6727-4-wuyun.abel@bytedance.com>
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

For now __sk_mem_raise_allocated() mainly considers global socket
memory pressure and allows to raise if no global pressure observed,
including the sockets whose memcgs are in pressure, which might
result in longer memcg memstall.

So take net-memcg's pressure into consideration when allocating
socket memory to alleviate long tail latencies.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 net/core/sock.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 801df091e37a..7641d64293af 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2977,21 +2977,30 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
 	bool memcg_charge = mem_cgroup_sockets_enabled && sk->sk_memcg;
 	struct proto *prot = sk->sk_prot;
-	bool charged = true;
+	bool charged = true, pressured = false;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
-	if (memcg_charge &&
-	    !(charged = mem_cgroup_charge_skmem(sk->sk_memcg, amt,
-						gfp_memcg_charge())))
-		goto suppress_allocation;
+
+	if (memcg_charge) {
+		charged = mem_cgroup_charge_skmem(sk->sk_memcg, amt,
+						  gfp_memcg_charge());
+		if (!charged)
+			goto suppress_allocation;
+		if (mem_cgroup_under_socket_pressure(sk->sk_memcg))
+			pressured = true;
+	}
 
 	/* Under limit. */
-	if (allocated <= sk_prot_mem_limits(sk, 0)) {
+	if (allocated <= sk_prot_mem_limits(sk, 0))
 		sk_leave_memory_pressure(sk);
+	else
+		pressured = true;
+
+	/* No pressure observed in global/memcg. */
+	if (!pressured)
 		return 1;
-	}
 
 	/* Under pressure. */
 	if (allocated > sk_prot_mem_limits(sk, 1))
-- 
2.37.3

