Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA9C6BBBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjCOSTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjCOSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:31 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7CE5D47A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:30 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x8so2127437qvr.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YdMRWrceqxooe4gtO91XUx2+IJg5yOZzB8eltDBQHc=;
        b=Y6dmHBBxuRL29N0TD32sk5Q46SZkvb+Cz7joxJNYQa7VcRhTrhsl+leDpu6VzvnEPD
         nP4GzafsDqwcbrFtRQrR0TIEqr/isk3MbcwjMbp7p2wI58NJmBzfsFfLMoIzrSJ0hxf1
         ucc4ysYK0e6PziMi8ddBKUqNJVFM9vedX72fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YdMRWrceqxooe4gtO91XUx2+IJg5yOZzB8eltDBQHc=;
        b=hOxz/dMsJV2CSfCoKuHqS13FwL7iBr7NUv0Cb9de8rXLqlutiPkU3ywxWsMuGvFFRG
         4mJs4q1FqekFJRAbdpR2hf+EcyESjGpkvrG/nmfHtL99PuS121WzR/SNgwd6GRw3gb+P
         TV8oIQSZly2jAOhHp3Go/Of7Ja4b/XFZHsgCHSd7Pu3Zy3pyl2JmCpdONWg2RgKeu5e3
         jajFCqdtFpwH2+Ve/3yjT7iWWQS0ZfbWA8nHgfMW+5uyfI3TMVjQgH/MhxjnYO25tuCK
         qm2qAF1rPc/RzGa+NiRgySuqWbr26CYSQhl30+9EWYKEcrw8imnO+yuvs0WG35fyCSzW
         mBeA==
X-Gm-Message-State: AO0yUKV0uP6iLiyGmJmRMvDzXorDYVxFpF2nkOSUXtuu1ryioGCgTBZU
        W0qKJ3+6kWylRQBltdzEHRE1n9i7FmN/nGd+PoU=
X-Google-Smtp-Source: AK7set9PE5fzyQ5HDKzDk0cfTIIJsoYEhrVRDv/k57BSsbdK82f6cjhirtHedRE1n6Irj9gvwdmQdg==
X-Received: by 2002:a05:6214:1d01:b0:577:5ffe:e0d8 with SMTP id e1-20020a0562141d0100b005775ffee0d8mr34099870qvd.24.1678904369778;
        Wed, 15 Mar 2023 11:19:29 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/14] net/sysctl: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed, 15 Mar 2023 18:18:52 +0000
Message-Id: <20230315181902.4177819-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kfree_rcu() and kvfree_rcu() macros' single-argument forms are
deprecated.  Therefore switch to the new kfree_rcu_mightsleep() and
kvfree_rcu_mightsleep() variants. The goal is to avoid accidental use
of the single-argument forms, which can introduce functionality bugs in
atomic contexts and latency bugs in non-atomic contexts.

Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/core/sysctl_net_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 74842b453407..782273bb93c2 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -177,7 +177,7 @@ static int rps_sock_flow_sysctl(struct ctl_table *table, int write,
 			if (orig_sock_table) {
 				static_branch_dec(&rps_needed);
 				static_branch_dec(&rfs_needed);
-				kvfree_rcu(orig_sock_table);
+				kvfree_rcu_mightsleep(orig_sock_table);
 			}
 		}
 	}
@@ -215,7 +215,7 @@ static int flow_limit_cpu_sysctl(struct ctl_table *table, int write,
 				     lockdep_is_held(&flow_limit_update_mutex));
 			if (cur && !cpumask_test_cpu(i, mask)) {
 				RCU_INIT_POINTER(sd->flow_limit, NULL);
-				kfree_rcu(cur);
+				kfree_rcu_mightsleep(cur);
 			} else if (!cur && cpumask_test_cpu(i, mask)) {
 				cur = kzalloc_node(len, GFP_KERNEL,
 						   cpu_to_node(i));
-- 
2.40.0.rc1.284.g88254d51c5-goog

