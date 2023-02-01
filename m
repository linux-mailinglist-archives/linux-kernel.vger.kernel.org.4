Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6739D6869A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjBAPLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjBAPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:10:28 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280404ED8;
        Wed,  1 Feb 2023 07:09:58 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so52337941ejc.4;
        Wed, 01 Feb 2023 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tXjIjq2OSXfc4jMxvXeb0r5u9dXZ/7er9tkJEls7xtk=;
        b=dtAAXAU6c2GAjbfjuGt79DK/CapzQBC0LdPCjOljsN234iuNoqxq+8rLsfL4+e/xEc
         HHFxJiHO4FLJHKUjjwLXg8itxMnrV1A1tPgmsn6Inmo6jycPqiBchRgNFPEHCKsrNagm
         bGI720X9uAaxXmY9AxKu+3t37E39DghKxenJf0lnWnFNgwS6aAegPpZtj5yv2pLpb4pQ
         /dIWhNeT+qZQEaxLyN6n2jiYGoxisBbjwV2yoX7MELz4Fzliy8IylETDwklv8aWRvBig
         yHqWk1FAvEZRpw6bfDSk7uukFjh8QwAh27xxtPmineQ5fZ80bTCxBK2xq8f9ZyrNEWld
         JVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXjIjq2OSXfc4jMxvXeb0r5u9dXZ/7er9tkJEls7xtk=;
        b=4vSF9SCjqtNJxIj5peijHXYBDftG+BYomOK4RLvL5uLTEjBOvTADI05hRugXDekm5B
         ZIuVmi90zpXnN2wezQYB4CULrL+oWf/k5BbZa3p8ZByfOmc4rK3gIo68hrD6klUVO3VC
         IqkTS5QPVFAIkZQ+FXp8RAXkzUlWpmIIJOmhE2xi+Qh/EFwBrxHgIAAygO4jfNXlnIaJ
         aDYacbIJdLMn/2VZcLKGu2ZLMhQwQ8xfW7+0YDU5Bd/BAMdPZytKQNSCJrJ1bseRKC9o
         SEwOkc8JnfoKtTDmcy/zMybJEDxjk9v13Pzow6gYQ6pqiLrtd9nsyUyqX2F6pT7zKAcI
         TV6w==
X-Gm-Message-State: AO0yUKUOobXbMvfHrQT5KNK52b4p+fDz7ntdVi+YxR2ISFFi0pEWMi7W
        AF0MkmxTtvdCCOBL6GCyKQdLi6tHOXHKbw==
X-Google-Smtp-Source: AK7set9NagWTJRR6IBaJEIwzZB9394Yll23Xgp1gsuKczn/h8X+3M896XTd8cIA3GlK1wC6+VPn7Aw==
X-Received: by 2002:a17:907:1c27:b0:84c:e9c4:5751 with SMTP id nc39-20020a1709071c2700b0084ce9c45751mr2617987ejc.74.1675264196706;
        Wed, 01 Feb 2023 07:09:56 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id fe15-20020a1709072a4f00b008845c668408sm6627147ejc.169.2023.02.01.07.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:09:56 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: [PATCH 10/13] ipvs: Rename kfree_rcu() to kfree_rcu_mightsleep()
Date:   Wed,  1 Feb 2023 16:09:51 +0100
Message-Id: <20230201150954.409693-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kfree_rcu()'s single argument name is deprecated therefore
rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
underline that it is for sleepable contexts.

Cc: Julian Anastasov <ja@ssi.bg>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jiri Wiesner <jwiesner@suse.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 net/netfilter/ipvs/ip_vs_est.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
index ce2a1549b304..a39baf6d1367 100644
--- a/net/netfilter/ipvs/ip_vs_est.c
+++ b/net/netfilter/ipvs/ip_vs_est.c
@@ -549,7 +549,7 @@ void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
 	__set_bit(row, kd->avail);
 	if (!kd->tick_len[row]) {
 		RCU_INIT_POINTER(kd->ticks[row], NULL);
-		kfree_rcu(td);
+		kfree_rcu_mightsleep(td);
 	}
 	kd->est_count--;
 	if (kd->est_count) {
-- 
2.30.2

