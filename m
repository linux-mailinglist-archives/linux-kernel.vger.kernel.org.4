Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10197395C8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjFVDWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVDW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:22:29 -0400
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C45601A4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 20:22:26 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id 7B1201100E9C09;
        Thu, 22 Jun 2023 11:22:23 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 22 Jun 2023 11:22:23 +0800
Date:   Thu, 22 Jun 2023 11:22:17 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   tiozhang <tiozhang@didiglobal.com>
To:     <tj@kernel.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <fuyuanli@didiglobal.com>, <zwp10758@gmail.com>,
        <zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>,
        <tiozhang@didiglobal.com>
Subject: [PATCH v3] sched/isolation: add a workqueue parameter onto isolcpus
 to constrain unbound CPUs
Message-ID: <20230622032133.GA29012@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: tj@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, fuyuanli@didiglobal.com,
        zwp10758@gmail.com, zyhtheonly@gmail.com, zyhtheonly@yeah.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZJNizvI-7A2hFDoM@slm.duckdns.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motivation of doing this is to better improve boot times for devices when
we want to prevent our workqueue works from running on some specific CPUs,
i,e, some CPUs are busy with interrupts.

Also remove HK_FLAG_WQ from nohz_full to prevent nohz_full overriding
workqueue's cpu config.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: tiozhang <tiozhang@didiglobal.com>
---
 kernel/sched/isolation.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc..5cd67c51622e 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -181,8 +181,8 @@ static int __init housekeeping_nohz_full_setup(char *str)
 {
 	unsigned long flags;
 
-	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
-		HK_FLAG_MISC | HK_FLAG_KTHREAD;
+	flags = HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC
+		| HK_FLAG_KTHREAD;
 
 	return housekeeping_setup(str, flags);
 }
@@ -208,6 +208,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
 			continue;
 		}
 
+		if (!strncmp(str, "workqueue,", 10)) {
+			str += 10;
+			flags |= HK_FLAG_WQ;
+			continue;
+		}
+
 		if (!strncmp(str, "managed_irq,", 12)) {
 			str += 12;
 			flags |= HK_FLAG_MANAGED_IRQ;
-- 
2.17.1

