Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D36B88E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 04:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCNDN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 23:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCNDNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 23:13:45 -0400
Received: from out-36.mta0.migadu.com (out-36.mta0.migadu.com [IPv6:2001:41d0:1004:224b::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC3113DEE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:13:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678763618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xtue6tgmt/ETmVgm+Gz/X49IfXkoIX4RFUArbKPcTC4=;
        b=cPQJDMxvCTUTD9I3fo3Yt8sMAIh2mC8D/K5EXTVmwvBA2n87l/xM1e58L3t1p6M23PPsGs
        pxEW5RCzXvzMG8BG20pbSww2MEh/GLTwvyRaP0gDIaeWbpjLriRZmKvzu+43VVQ2HhpoB8
        T/w59ccRqqfm9fWDUXyj535CxTnWTw8=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] sched/rt: Reset sysctl_sched_rr_timeslice when it non-positive
Date:   Tue, 14 Mar 2023 11:13:23 +0800
Message-Id: <20230314031323.3638994-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sysctl_sched_rr_timeslice was set a non-positive number, only
sched_rr_timeslice was reset to default, This behavior should let
users know.

So reset sysctl_sched_rr_timeslice at the same time when it
non-positive.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 kernel/sched/rt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0a11f44adee5..0723a6297f96 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -3036,9 +3036,12 @@ static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 	 * Also, writing zero resets the timeslice to default:
 	 */
 	if (!ret && write) {
-		sched_rr_timeslice =
-			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
-			msecs_to_jiffies(sysctl_sched_rr_timeslice);
+		if (sysctl_sched_rr_timeslice > 0)
+			sched_rr_timeslice = msecs_to_jiffies(sysctl_sched_rr_timeslice);
+		else {
+			sched_rr_timeslice = RR_TIMESLICE;
+			sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
+		}
 	}
 	mutex_unlock(&mutex);
 
-- 
2.25.1

