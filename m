Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40BF70D971
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbjEWJrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjEWJra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:47:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EDB130
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:47:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d2c865e4eso3772268b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684835248; x=1687427248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJNRFp1URkkAv14Fvh/BUBB9PNFK79930mw7UGuUDQY=;
        b=U4Qt34Z6pN6W4AL25USGqBadP06Vqhmo9JSJfVQCZc70CiJ7M0OKga9craqFE0GnI8
         NLMJIANE63+DHnEOMIxX7DO2qCdEbewRVqGS/O5pO5br4bfTrc3uDxLszVxc0OgolxnV
         aTa3JwnkdYOcbk3XEh+RIbsrLWwrH+lxONrUG5XwpcLq7ppOwFzilXmbro7u+yhFVsMP
         EN7fQjzet+Sv/Ubmgtxp0XjM+pbLUo9GrvYaHYWEq6DDhhD4nRGmFih1fAPFp9SgP5jG
         tRmJMdYXzqa4ezGKi45YbtXY94ukxpsPSM9JKp5hSByxj0OnJRYdhlAJFFui19XBhUR6
         1qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835248; x=1687427248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJNRFp1URkkAv14Fvh/BUBB9PNFK79930mw7UGuUDQY=;
        b=hW6dRd/mOd4RyxpNiooF/LZ2bnnHjWk8by+2jvzbWuKPodQENA8FlLewZjcB3Kr6MU
         NSUBwmJ6SVNrq2ZoXfmHGBOUpyXuBRPgskoWmntBUTIOxZDgKiYtILdWi6uXa+ydctTH
         BTGVePVPnurlQMfCBywy4G6k9BjBLl9615CJBy9yZWbdYXP1aSm+iQ3wzj+tr1sCcR3/
         O/9MEIC1INWd6zzQYgg3BxxonPYabtnVdMBgj6W0Li8XWXEUXY5xvDe6GqUo6akrVBbJ
         tZq08e5qz7k+ZNQz73hdp68SU/ZFWis93U9QLJtGY8PFc0PntJCVmVrr0iBzm8Vlo4te
         J/xQ==
X-Gm-Message-State: AC+VfDz6eG2q1gGfE1rJjJn1gJnEOapHsQp3GAj05tPArThQZT478bN6
        wQaEYcn08g0Ymn3Jfuc13iEPSg==
X-Google-Smtp-Source: ACHHUZ5B4JuSyG1yjWcuVZ88SwoM2AMIukUX5pAMUXBebemZ2uyfglRo+Cw4QPlOctY7/9Er7B2+Rw==
X-Received: by 2002:a05:6a20:3d09:b0:10a:cbe6:69f0 with SMTP id y9-20020a056a203d0900b0010acbe669f0mr11156449pzi.10.1684835248601;
        Tue, 23 May 2023 02:47:28 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79116000000b0063b898b3502sm5457216pfh.153.2023.05.23.02.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:47:28 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v3 5/5] sock: Remove redundant cond of memcg pressure
Date:   Tue, 23 May 2023 17:46:52 +0800
Message-Id: <20230523094652.49411-6-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230523094652.49411-1-wuyun.abel@bytedance.com>
References: <20230523094652.49411-1-wuyun.abel@bytedance.com>
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

Now with the previous patch, __sk_mem_raise_allocated() considers
the memory pressure of both global and the socket's memcg on a func-
wide level, making the condition of memcg's pressure in question
redundant.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 net/core/sock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index b899e0b9feda..b2deffb81c86 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3029,9 +3029,15 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (sk_has_memory_pressure(sk)) {
 		u64 alloc;
 
-		if (!sk_under_memory_pressure(sk))
+		if (!sk_under_global_memory_pressure(sk))
 			return 1;
+
 		alloc = sk_sockets_allocated_read_positive(sk);
+
+		/* If under global pressure, allow the sockets that are below
+		 * average memory usage to raise, trying to be fair among all
+		 * the sockets under global constrains.
+		 */
 		if (sk_prot_mem_limits(sk, 2) > alloc *
 		    sk_mem_pages(sk->sk_wmem_queued +
 				 atomic_read(&sk->sk_rmem_alloc) +
-- 
2.37.3

