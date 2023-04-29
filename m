Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E8A6F2259
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 04:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbjD2CAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 22:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347434AbjD2B7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 21:59:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16008469A;
        Fri, 28 Apr 2023 18:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ACAA61C30;
        Sat, 29 Apr 2023 01:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94862C433EF;
        Sat, 29 Apr 2023 01:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682733559;
        bh=OU6c1TPuGPZuBbKgCP2iz/IdtmI8ALFFeo0Kvdv/Xfk=;
        h=From:To:Cc:Subject:Date:From;
        b=HZgF8dE5wcta/aLPnSGdns/dYgLgTEXzxPsvaaJfEfk/0LvamE3+6fYJ0QFB8s85n
         k5uDVui74cPBl78fdSnpcNCI0hUZbNGenxb7vy/iVpVa3wR93B2R3y1s2PYiN3DEf0
         T5uiWheBI5zRD916HfGusi4bfSkMy2zYC31ob2U1IVuQMPK6C0mz+zuSZTpl7mWKSS
         pyGv9vVFggm6db06zMlpYJNumz26sWMAgopDEKMsV+pxx0leV1m7GDdQscblN8172e
         6DBt6k+8TzQWadTjDKa+kIyUYaPyZrdvcztEnNIPNQ1NN+41zpI+0wFSK+9i8/cRDD
         ityAvX3kjAgug==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sasha Levin <sashal@kernel.org>, dave@stgolabs.net,
        josh@joshtriplett.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/2] refscale: Move shutdown from wait_event() to wait_event_idle()
Date:   Fri, 28 Apr 2023 21:59:15 -0400
Message-Id: <20230429015916.3027420-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 6bc6e6b27524304aadb9c04611ddb1c84dd7617a ]

The ref_scale_shutdown() kthread/function uses wait_event() to wait for
the refscale test to complete.  However, although the read-side tests
are normally extremely fast, there is no law against specifying a very
large value for the refscale.loops module parameter or against having
a slow read-side primitive.  Either way, this might well trigger the
hung-task timeout.

This commit therefore replaces those wait_event() calls with calls to
wait_event_idle(), which do not trigger the hung-task timeout.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/refscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 952595c678b37..4e419ca6d6114 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -625,7 +625,7 @@ ref_scale_cleanup(void)
 static int
 ref_scale_shutdown(void *arg)
 {
-	wait_event(shutdown_wq, shutdown_start);
+	wait_event_idle(shutdown_wq, shutdown_start);
 
 	smp_mb(); // Wake before output.
 	ref_scale_cleanup();
-- 
2.39.2

