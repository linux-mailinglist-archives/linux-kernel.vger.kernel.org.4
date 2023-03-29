Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FDD6CEE9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjC2QFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjC2QEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:04:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2DE4C16;
        Wed, 29 Mar 2023 09:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDF39B82380;
        Wed, 29 Mar 2023 16:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE73C433A1;
        Wed, 29 Mar 2023 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680105733;
        bh=qp5qTHymeNKXf/igbwuWFINn/OHqxS5wqWdXe8S1EME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mM1UAcjeDDMImv5k9KeshViE+mnte2MLkwfhDMuMk3mam4OB+U+s9icDSTJiY6tj2
         mpV0By8nybN+Dgd8/UsXyNaX0vKIF6Wsj1oYa1nO7Ro+o3qlvIQ6RmJP0DQBtpP2Vm
         lINjK5j4VPanlu31F6MfIammRNoXjwvehMtGoBzrQPEQMKVN2HJjL/Go+QZeE+JOA3
         BCfSnQzEC4MnFn0lZJ3KjD6gofBMB+dceLNEydiTGDxuzL4Bk0Tus2PSqy3dsyVrDv
         GcLelC4UmxcmsywSnqEBIBbrM36mqdisHzvvceK86rBfsbDqZxqwPAgzhp18r48E2m
         VsKkc1l1zbseA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/4] rcu/nocb: Fix shrinker race against callback enqueuer
Date:   Wed, 29 Mar 2023 18:02:01 +0200
Message-Id: <20230329160203.191380-3-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329160203.191380-1-frederic@kernel.org>
References: <20230329160203.191380-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shrinker resets the lazy callbacks counter in order to trigger the
pending lazy queue flush though the rcuog kthread. The counter reset is
protected by the ->nocb_lock against concurrent accesses...except
for one of them. Here is a list of existing synchronized readers/writer:

1) The first lazy enqueuer (incrementing ->lazy_len to 1) does so under
   ->nocb_lock and ->nocb_bypass_lock.

2) The further lazy enqueuers (incrementing ->lazy_len above 1) do so
   under ->nocb_bypass_lock _only_.

3) The lazy flush checks and resets to 0 under ->nocb_lock and
	->nocb_bypass_lock.

The shrinker protects its ->lazy_len reset against cases 1) and 3) but
not against 2). As such, setting ->lazy_len to 0 under the ->nocb_lock
may be cancelled right away by an overwrite from an enqueuer, leading
rcuog to ignore the flush.

To avoid that, use the proper bypass flush API which takes care of all
those details.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 1a86883902ce..c321fce2af8e 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1364,7 +1364,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			continue;
 
 		rcu_nocb_lock_irqsave(rdp, flags);
-		WRITE_ONCE(rdp->lazy_len, 0);
+		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp, false);
 		sc->nr_to_scan -= _count;
-- 
2.34.1

