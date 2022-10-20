Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD16062F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJTO0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiJTO02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:26:28 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549A31AFA8A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:26:25 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1olWUx-000601-0e; Thu, 20 Oct 2022 16:26:15 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH][RESEND] clocksource: downgrade messages about skipping watchdog check under load
Date:   Thu, 20 Oct 2022 16:26:09 +0200
Message-Id: <841757364754f8d0a8834982ca16da10a6a44d72.1666275945.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Since commit c86ff8c55b8a ("clocksource: Avoid accidental unstable marking of clocksources")
the watchdog check is skipped if two consecutive watchdog reads are too far
apart.

This might happen, for example, when the system is under heavy load, so it
isn't a totally unexpected condition.

Since some systems are prone to producing significant number of these
messages when the system is constantly under heavy load downgrade their log
level to "debug" to avoid filling the kernel log in such case.

These messages can then still be enabled via dyndbg mechanism in case
someone really needs to see them.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 kernel/time/clocksource.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cee5da1e54c41..ff99b25bc1aec 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -236,8 +236,8 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 					      watchdog->shift);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
 			if (nretries > 1 || nretries >= max_cswd_read_retries) {
-				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
-					smp_processor_id(), watchdog->name, nretries);
+				pr_debug("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
+					 smp_processor_id(), watchdog->name, nretries);
 			}
 			return WD_READ_SUCCESS;
 		}
@@ -262,10 +262,10 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 	return WD_READ_UNSTABLE;
 
 skip_test:
-	pr_info("timekeeping watchdog on CPU%d: %s wd-wd read-back delay of %lldns\n",
-		smp_processor_id(), watchdog->name, wd_seq_delay);
-	pr_info("wd-%s-wd read-back delay of %lldns, clock-skew test skipped!\n",
-		cs->name, wd_delay);
+	pr_debug("timekeeping watchdog on CPU%d: %s wd-wd read-back delay of %lldns\n",
+		 smp_processor_id(), watchdog->name, wd_seq_delay);
+	pr_debug("wd-%s-wd read-back delay of %lldns, clock-skew test skipped!\n",
+		 cs->name, wd_delay);
 	return WD_READ_SKIP;
 }
 
