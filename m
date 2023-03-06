Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A962E6ABF72
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCFM2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCFM2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:28:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 959BD1FE8;
        Mon,  6 Mar 2023 04:28:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0E0013D5;
        Mon,  6 Mar 2023 04:28:47 -0800 (PST)
Received: from e126130.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA5A33F67D;
        Mon,  6 Mar 2023 04:28:02 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     douglas.raillard@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org (open list:TRACING),
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH] rcu: Fix rcu_torture_read ftrace event
Date:   Mon,  6 Mar 2023 12:27:43 +0000
Message-Id: <20230306122744.236790-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Fix the rcutorturename field so that its size is correctly reported in
the text format embedded in trace.dat files. As it stands, it is
reported as being of size 1:

    field:char rcutorturename[8];   offset:8;       size:1; signed:0;

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 include/trace/events/rcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 90b2fb0292cb..012fa0d171b2 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -768,7 +768,7 @@ TRACE_EVENT_RCU(rcu_torture_read,
 	TP_ARGS(rcutorturename, rhp, secs, c_old, c),
 
 	TP_STRUCT__entry(
-		__field(char, rcutorturename[RCUTORTURENAME_LEN])
+		__array(char, rcutorturename, RCUTORTURENAME_LEN)
 		__field(struct rcu_head *, rhp)
 		__field(unsigned long, secs)
 		__field(unsigned long, c_old)
-- 
2.25.1

