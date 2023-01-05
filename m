Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4395565E1A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjAEAec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbjAEAdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:33:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03D44FCE1;
        Wed,  4 Jan 2023 16:28:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1588B81981;
        Thu,  5 Jan 2023 00:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853ADC433EF;
        Thu,  5 Jan 2023 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878534;
        bh=hSjmp4sjEzmbSkEIAKK15jlSiwyoY8kTt04q71SUIS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxB50AKWzaKZck5WKGmkQazuHQjc3Pq7OsWtL5qJIgNzr82Uw2OxINzwK5Ul5aRJw
         rXaDsrSEswOINrHJ8n8UlCq8syqqYaPtG0Yzu9GytOqWvLqnNJh871dLWAM/WYll2U
         YdHF63iVu165rSaXWEsdC3xFcjDJ7onWUcWSwVZs4EYRBm18VtmXknMOPIH8t/pHM+
         vdy3XqodLcfDPInFdCB8YHWwPysgaZuwATa5fXeBzr1XEbPAf4lj+YOFTpCE4MzoHs
         Qf1I5cOp3L52eM36o4bMu86YdnItDR7YrS+tlbi8ZQCNn3C0Uku7/UA/veX6VcH+Vo
         aVK3xCe4xUJNA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 435AB5C05CA; Wed,  4 Jan 2023 16:28:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/9] srcu: Release early_srcu resources when no longer in use
Date:   Wed,  4 Jan 2023 16:28:45 -0800
Message-Id: <20230105002853.1769401-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

Kernels built with the CONFIG_TREE_SRCU Kconfig option set and then
booted with rcupdate.rcu_self_test=1 and srcutree.convert_to_big=1 will
test Tree SRCU during early boot.  The early_srcu structure's srcu_node
array will be allocated when init_srcu_struct_fields() is invoked,
but after the test completes this early_srcu structure will not be used.

This commit therefore invokes cleanup_srcu_struct() to free that srcu_node
structure.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index f5e6a2f95a2a0..a5b4abbee6439 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -586,6 +586,7 @@ static int rcu_verify_early_boot_tests(void)
 		early_boot_test_counter++;
 		srcu_barrier(&early_srcu);
 		WARN_ON_ONCE(!poll_state_synchronize_srcu(&early_srcu, early_srcu_cookie));
+		cleanup_srcu_struct(&early_srcu);
 	}
 	if (rcu_self_test_counter != early_boot_test_counter) {
 		WARN_ON(1);
-- 
2.31.1.189.g2e36527f23

