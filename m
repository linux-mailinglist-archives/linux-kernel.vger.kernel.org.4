Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64D56EDFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjDYKID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjDYKIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:08:01 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F30767AA6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sAEbn
        5ai39i4LztPVMYZ63TjvWXNipzPOAbsckNPCDE=; b=XSco1xOgUxY/QVM/LQYid
        aG06AUor8d8asqsikFhhn/ENmzXKSlFtVDlEF9aVyHP7Fl3v4thD/XKy4kI7ehIx
        MBIFaxQaO6WRrkeOemofJwH94jwBjk6cNr61PZUubQlMrEyBBxboTdxDggT8nYKW
        efeUBF3CHSF9R15rUI+DmY=
Received: from fedora.. (unknown [123.52.27.102])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3_3NZpUdkfHEaAA--.44629S2;
        Tue, 25 Apr 2023 18:03:07 +0800 (CST)
From:   zhaomzhao@126.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: [PATCH v1] sched/fair: fix inconsistency in update_task_scan_period
Date:   Tue, 25 Apr 2023 06:02:04 -0400
Message-Id: <20230425100204.2032009-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_3NZpUdkfHEaAA--.44629S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW7tryrtrW7AF13CrWxZwb_yoW8Kr1xpa
        yFyF18AF47Jw18Ww45u347XrWfW3yrtw12qa1xAasIvFn0gryYvF1qgw17u34UCry8Kr4U
        Z3WayrW3Gw1vvF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNyCXUUUUU=
X-Originating-IP: [123.52.27.102]
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbimh5cd1pEK1AA5wAAst
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

During calculate numa_scan_period diff, the actual code
and the comment are inconsistent. The comment says it is
using shared faults ratio, but code uses private faults
ratio. This patch fixes it.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..73cc83128072 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2362,7 +2362,7 @@ static void update_task_scan_period(struct task_struct *p,
 			unsigned long shared, unsigned long private)
 {
 	unsigned int period_slot;
-	int lr_ratio, ps_ratio;
+	int lr_ratio, sp_ratio;
 	int diff;
 
 	unsigned long remote = p->numa_faults_locality[0];
@@ -2393,24 +2393,24 @@ static void update_task_scan_period(struct task_struct *p,
 	 */
 	period_slot = DIV_ROUND_UP(p->numa_scan_period, NUMA_PERIOD_SLOTS);
 	lr_ratio = (local * NUMA_PERIOD_SLOTS) / (local + remote);
-	ps_ratio = (private * NUMA_PERIOD_SLOTS) / (private + shared);
+	sp_ratio = (shared * NUMA_PERIOD_SLOTS) / (private + shared);
 
-	if (ps_ratio >= NUMA_PERIOD_THRESHOLD) {
+	if (lr_ratio >= NUMA_PERIOD_THRESHOLD) {
 		/*
 		 * Most memory accesses are local. There is no need to
 		 * do fast NUMA scanning, since memory is already local.
 		 */
-		int slot = ps_ratio - NUMA_PERIOD_THRESHOLD;
+		int slot = lr_ratio - NUMA_PERIOD_THRESHOLD;
 		if (!slot)
 			slot = 1;
 		diff = slot * period_slot;
-	} else if (lr_ratio >= NUMA_PERIOD_THRESHOLD) {
+	} else if (sp_ratio >= NUMA_PERIOD_THRESHOLD) {
 		/*
 		 * Most memory accesses are shared with other tasks.
 		 * There is no point in continuing fast NUMA scanning,
 		 * since other tasks may just move the memory elsewhere.
 		 */
-		int slot = lr_ratio - NUMA_PERIOD_THRESHOLD;
+		int slot = sp_ratio - NUMA_PERIOD_THRESHOLD;
 		if (!slot)
 			slot = 1;
 		diff = slot * period_slot;
@@ -2420,7 +2420,7 @@ static void update_task_scan_period(struct task_struct *p,
 		 * yet they are not on the local NUMA node. Speed up
 		 * NUMA scanning to get the memory moved over.
 		 */
-		int ratio = max(lr_ratio, ps_ratio);
+		int ratio = max(lr_ratio, sp_ratio);
 		diff = -(NUMA_PERIOD_THRESHOLD - ratio) * period_slot;
 	}
 
-- 
2.38.1

