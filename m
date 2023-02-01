Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0231D68699F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjBAPKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjBAPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:09:44 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2018969532;
        Wed,  1 Feb 2023 07:08:26 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hx15so32760401ejc.11;
        Wed, 01 Feb 2023 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmKlyMMJ/xEGlFGd5Gxv5AeF+U+6+mZ4G3QkqKY1mdM=;
        b=c6azTpWkKQffBEe2MAEiXW7H64r7G8RxpP6AOHcPVZdNMYkjx+JYt3ZJrwoey7Bhi4
         3U5CZt8416awlbOmwyyXDpO4v9virbiJVJJ6QAT0nXMsCHWYFUBDwFiZipY6eNuE4zWB
         ZRQrhMcnthZ5uwrMZCRpHftZzckhjKVjf1N1UrgJcg4ZitsN+YtuToG35yrOwioAWtNw
         EPhjUTGd2kUwpjHBOlh5TAL1SbRX6ezF05RUFgd0l9zrrRWxU1sJvo7LM9lQTOWCljrx
         LnLmy+g4GWsbSBU9Ph/CEfX9TR82hOo4TOwOX4YqqT39urmQ0JKYNLdFMEdiCthvc3O3
         oSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmKlyMMJ/xEGlFGd5Gxv5AeF+U+6+mZ4G3QkqKY1mdM=;
        b=bvSnPIkDHLQVHQCV7IgZAS5qdkO4qWHmUMU/EF5PJXOFvjJ037CUodOFfhWf+XFNjp
         bpEloCSGfIXal9sNlTIEAJoI2w12J7OkTMv9u1dJcNwblTgEnGpH2kPleu2D7CM2khLc
         S49nIM/P6tJnDGQcpQ7s4uwk3lDllV0TioUpb2rR5EZK9lPhONssPbUzv+glbIhr6u1V
         GBkeqkZSQpAOdBwgL3jowiG4RVrG/Et84313cqXIvCivQ3ERfpvDzlEngp0tSzgKP/5o
         CguCdV+RYRLdgijNc0uvpbO03gCQ74/+Ee7h7o5RUv2LpRAMP+NILHAIWMRbY1GAqoVz
         ItnA==
X-Gm-Message-State: AO0yUKXITv0377hAamF7toC9r3bGX3VVPUZxUh8hbb0AeBT132tfSFDv
        y7wLON/TPLZqhMzAmU84i17uDa9XmUKZEw==
X-Google-Smtp-Source: AK7set9o7bnLBWO3PrP3ZVOPyFD+6VHKWOsSXhFB/KKBL4fqEFYK1zi+/nI0i5kRuuXtNUxcHtnUWQ==
X-Received: by 2002:a17:906:fc13:b0:87f:d08:1064 with SMTP id ov19-20020a170906fc1300b0087f0d081064mr6012611ejb.6.1675264104460;
        Wed, 01 Feb 2023 07:08:24 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id qc26-20020a170906d8ba00b008787e94c5ccsm9585774ejb.184.2023.02.01.07.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:08:24 -0800 (PST)
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
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 07/13] RDMA/rxe: Rename kfree_rcu() to kfree_rcu_mightsleep()
Date:   Wed,  1 Feb 2023 16:08:13 +0100
Message-Id: <20230201150815.409582-8-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201150815.409582-1-urezki@gmail.com>
References: <20230201150815.409582-1-urezki@gmail.com>
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

Please check the RXE driver in a way that a single argument can
be used. Briefly looking at it and rcu_head should be embed to
free an obj over RCU-core. The context might be atomic.

Cc: Bob Pearson <rpearsonhpe@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index f50620f5a0a1..e2fa061f19b3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -276,7 +276,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 		pool->cleanup(elem);
 
 	if (pool->type == RXE_TYPE_MR)
-		kfree_rcu(elem->obj);
+		kfree_rcu_mightsleep(elem->obj);
 
 	atomic_dec(&pool->num_elem);
 
-- 
2.30.2

