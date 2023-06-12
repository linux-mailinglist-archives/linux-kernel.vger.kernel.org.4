Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB29272D130
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbjFLU5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbjFLU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:56:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B331E54
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:52:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B02A62150
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF844C433D2;
        Mon, 12 Jun 2023 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686603037;
        bh=+6bWbNlMMY6DSoL9TFRSEX0OALiJJGb4tKRRiWQ49+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bItv31sJeirjsOFKBsE1dogUy5MHsWfB0+vvt2xRVGFKCPiCIXIgwpCMg7WjwxvzB
         2eKvPoQ3X4RbxTdwdexd1N1i7GefSZNsPqf5yOBe/qtqeD3Trgli4BrYVR8fMdboi/
         sWe/SED+XUtjw2EhHbM0rdMjqU9+gi9eMvIfamtECeAaxkEPx73mlhyIXGxWKP7G77
         2azpPIoNEy42mvgL97b7Zom19DDqX8hpYT40t6dYatHUdBUOqUjr7AlbW+Bpz/LRZd
         Vp527MQpZNNVIDVBYYHBiY0BahikGz8PMwyXBJS/0/dePSlAQj/8OyUdGg4eV3y9tJ
         kLoWBlT1ceTfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6C1BBCE09E7; Mon, 12 Jun 2023 13:50:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, jgross@suse.com, vschneid@redhat.com,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, imran.f.khan@oracle.com,
        kernel-team@meta.com, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH csd-lock 1/2] smp: Reduce logging due to dump_stack of CSD waiters
Date:   Mon, 12 Jun 2023 13:50:35 -0700
Message-Id: <20230612205036.292542-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3ee27fe5-cbea-46b6-adb0-48c4dde92b4f@paulmck-laptop>
References: <3ee27fe5-cbea-46b6-adb0-48c4dde92b4f@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imran Khan <imran.f.khan@oracle.com>

If a waiter is waiting for CSD lock, its call stack will not change
between first and subsequent hang detection for the same CSD lock.
Therefore, do dump_stack only for first-time detection for a given waiter.

This avoids excessive logging on systems with hundreds of CPUs where
repetitive dump_stack from hundreds of CPUs would otherwise flood the
console.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index ab3e5dad6cfe..b7ccba677a0a 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -248,7 +248,8 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 			arch_send_call_function_single_ipi(cpu);
 		}
 	}
-	dump_stack();
+	if (firsttime)
+		dump_stack();
 	*ts1 = ts2;
 
 	return false;
-- 
2.40.1

