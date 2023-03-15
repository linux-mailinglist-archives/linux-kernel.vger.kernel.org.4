Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562226BB3D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjCONFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCONFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:05:22 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5733822A1B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:05:20 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230315130517epoutp04451dfc66bb09794f031d5429030cfba3~MmXu_zyu31065610656epoutp04l
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:05:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230315130517epoutp04451dfc66bb09794f031d5429030cfba3~MmXu_zyu31065610656epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678885517;
        bh=CdNz5fiQaPzuXrwBBnUFCcYw8zrKdIVuoe6hUXfIMkQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VuSFeGyI61Ja7E7yNlbpaziHrtcob0SzGdbPEZbyNcrhVFXuI43EQCB/xwzzb28qY
         wS3l1rpprPv0iU5tJKlHSFuxR4GGMctdKd0ujv/XiG2z6/LZShT2IcdNh614gVhQO+
         9dnBIhUXhmERTmg3mtA39uHhOiadQbjDc0XYNHyE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230315130516epcas1p32e37961cb1efbc0fdcde066eef456e4d~MmXuDy0qL0778707787epcas1p3r;
        Wed, 15 Mar 2023 13:05:16 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.247]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Pc9bw1byrz4x9Pt; Wed, 15 Mar
        2023 13:05:16 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.B5.12562.C82C1146; Wed, 15 Mar 2023 22:05:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230315130515epcas1p40823f20da586c1b5813b41e66e754309~MmXsWkrI13158631586epcas1p4q;
        Wed, 15 Mar 2023 13:05:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230315130515epsmtrp1688eacdc57c924f96ab3ae57ba75da84~MmXsVvJ5j1840718407epsmtrp1U;
        Wed, 15 Mar 2023 13:05:15 +0000 (GMT)
X-AuditID: b6c32a36-bfdff70000023112-60-6411c28cc785
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.6F.31821.A82C1146; Wed, 15 Mar 2023 22:05:14 +0900 (KST)
Received: from VDBS1328.vd.sec.samsung.net (unknown [168.219.243.40]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230315130514epsmtip2870080addf61c3dce6a693bb222ea5c5~MmXsJ1WEx1910919109epsmtip2v;
        Wed, 15 Mar 2023 13:05:14 +0000 (GMT)
From:   Jungseung Lee <js07.lee@samsung.com>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bw365.lee@samsung.com, yw85.kim@samsung.com,
        huijin.park@samsung.com
Cc:     Jungseung Lee <js07.lee@samsung.com>
Subject: [PATCH] workqueue: Introduce show_freeze_workqueues_busy
Date:   Wed, 15 Mar 2023 21:45:57 +0900
Message-Id: <1678884357-38253-1-git-send-email-js07.lee@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmgW7PIcEUg85mLosTaxYxWXRcdLGY
        unY3k8Wjm79ZLWZN2ctkcXnXHDaLz71HGC3unjrKZjH3y1Rmi1/LjzJadHy+yebA7bFz1l12
        j8V7XjJ5bFrVyebRt2UVo8eK1d/ZPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1
        MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6T0mhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5Ra
        kJJTYFagV5yYW1yal66Xl1piZWhgYGQKVJiQnXHj92m2gl3iFT27L7A1MO4V7mLk5JAQMJHY
        eHcHcxcjF4eQwA5GibmXLzKCJIQEPjFK3FvLDGF/ZpR4cdwXpmH13SY2iIZdjBJzPt6F6v7F
        KDF5zgImkCo2AS2JG783sYIkRAQ2MUks2LSBHSTBLKAh8fvATRYQW1jAUeLE8bVgcRYBVYl1
        V3eBNfMKuEjcvDKJCWKdnMTNc51gGyQErrFL7Pt0FijBAeS4SDxZGw9RIyzx6vgWdghbSuJl
        fxuUXS6xoW8aE0RvC6PEou1v2SASxhLv3oL8xgF0kKbE+l36EGFFiZ2/5zJC3Mkn8e5rDyvE
        Kl6JjjYhiBIliTcPWlggbAmJC497WSFsD4kJ95ayQEIrVmL2mpfsExhlZyEsWMDIuIpRLLWg
        ODc9tdiwwAgeScn5uZsYwSlOy2wH46S3H/QOMTJxMB5ilOBgVhLhDWcRSBHiTUmsrEotyo8v
        Ks1JLT7EaAoMr4nMUqLJ+cAkm1cSb2hiaWBiZmRiYWxpbKYkzituezJZSCA9sSQ1OzW1ILUI
        po+Jg1OqgWnV99Pzvjxic3qtZrzOQUY4Xbl9dsmRo4/UTopnb93eYlPY2TTjJ5/wOQa+L8dZ
        7otuzQtm+TZT5ZJH6hOGhToyK7kn8JzhNclmkJ/xxqLzpN39f1ymFyckxjvf+fju7fviWGG3
        HzKJTa1qZe8t15xL0LF5UdG+bZWtb/yBZQUT0jQ2pTr+02w7nbbAs3jhYt437NPfnGcw8RBY
        wtVYtCJ/+R+HWZ8cN0fsd79onpRzmy18Z6Fw1eutiXfnT8spO76cpdT5l1VtbNZ8yynfroeY
        rufYmstjlHziIPf8zX8OmOT9O93at16pe5K8XntwQF/IhDutsVXhorWzv2ubFQbrab3f2Vc2
        4c46zenR/EosxRmJhlrMRcWJANkoBRf6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSvG7XIcEUg98NlhYn1ixisui46GIx
        de1uJotHN3+zWsyaspfJ4vKuOWwWn3uPMFrcPXWUzWLul6nMFr+WH2W06Ph8k82B22PnrLvs
        Hov3vGTy2LSqk82jb8sqRo8Vq7+ze3zeJBfAFsVlk5Kak1mWWqRvl8CVceP3abaCXeIVPbsv
        sDUw7hXuYuTkkBAwkVh9t4mti5GLQ0hgB6PE3i/T2SASEhKPdn5h6WLkALKFJQ4fLoao+cEo
        0dr3hRGkhk1AS+LG702sIAkRgT1MEgd+nGUCSTALaEj8PnCTBcQWFnCUOHF8LTuIzSKgKrHu
        6i6wGl4BF4mbVyYxQSyTk7h5rpN5AiPPAkaGVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5
        uZsYwWGnpbWDcc+qD3qHGJk4GA8xSnAwK4nwhrMIpAjxpiRWVqUW5ccXleakFh9ilOZgURLn
        vdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAtHmap/iM1q05bMWd53/1NaZ5b/ble9MZVyOhv/mS
        wWxlpvCt186lHjt5qVBm5+yyPbqzrb3a1QW6PKfZK/a//Nrsxv65gnH5ouKWJxvfPMj+G5k2
        4/OZw10flWe9t7unLr/A10n3QbL5rvTNs9ws+5ff4ktvYPj1aBW35eQJei5bVBivZ0kua048
        N3mF85HTTX9CFq9aKj91+ZNS71m3neexVi0r57lhxBwgxjY9/MPL93IyuXXJbYs4zpjsM+aL
        s8g5Oyn/jfbcnb0TLjkxhm/+fWPN3werhFazqX9zDzKu/n3d4n+i5LedB9yufjls87NZ5vnF
        xI6dkfeCD6cq7U7OXbWMaeuFLHfD96p7u5VYijMSDbWYi4oTAbLKIVaqAgAA
X-CMS-MailID: 20230315130515epcas1p40823f20da586c1b5813b41e66e754309
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230315130515epcas1p40823f20da586c1b5813b41e66e754309
References: <CGME20230315130515epcas1p40823f20da586c1b5813b41e66e754309@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently show_all_workqueue() is called if freeze fails at the time of
freeze the workqueues, which shows the status of all workqueues and
of all worker pools. In this cases we may only need to dump state of
only workqueues that are freezable and busy.

This patch defines show_freeze_workqueues_busy, which uses
show_one_workqueue, a granular function that shows the state of
individual workqueues, so that dump only the state of freezable
workqueues at that time.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 include/linux/workqueue.h |  1 +
 kernel/power/process.c    |  2 +-
 kernel/workqueue.c        | 25 ++++++++++++++++++++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 0a10f8e..3d68631 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -472,6 +472,7 @@ extern unsigned int work_busy(struct work_struct *work);
 extern __printf(1, 2) void set_worker_desc(const char *fmt, ...);
 extern void print_worker_info(const char *log_lvl, struct task_struct *task);
 extern void show_all_workqueues(void);
+extern void show_freeze_workqueues_busy(void);
 extern void show_one_workqueue(struct workqueue_struct *wq);
 extern void wq_worker_comm(char *buf, size_t size, struct task_struct *task);
 
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 6c1c7e5..590550f 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -93,7 +93,7 @@ static int try_to_freeze_tasks(bool user_only)
 		       todo - wq_busy, wq_busy);
 
 		if (wq_busy)
-			show_all_workqueues();
+			show_freeze_workqueues_busy();
 
 		if (!wakeup || pm_debug_messages_on) {
 			read_lock(&tasklist_lock);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index de42827..087eedb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5043,7 +5043,7 @@ static void show_one_worker_pool(struct worker_pool *pool)
 /**
  * show_all_workqueues - dump workqueue state
  *
- * Called from a sysrq handler or try_to_freeze_tasks() and prints out
+ * Called from a sysrq handler and prints out
  * all busy workqueues and pools.
  */
 void show_all_workqueues(void)
@@ -5065,6 +5065,29 @@ void show_all_workqueues(void)
 	rcu_read_unlock();
 }
 
+/**
+ * show_freeze_workqueues_busy - dump freezable workqueue state
+ *
+ * Called from try_to_freeze_tasks() and prints out
+ * all freezable workqueues still busy.
+ */
+void show_freeze_workqueues_busy(void)
+{
+	struct workqueue_struct *wq;
+
+	rcu_read_lock();
+
+	pr_info("Showing freezable workqueues still busy:\n");
+
+	list_for_each_entry_rcu(wq, &workqueues, list) {
+		if (!(wq->flags & WQ_FREEZABLE))
+			continue;
+		show_one_workqueue(wq);
+	}
+
+	rcu_read_unlock();
+}
+
 /* used to show worker information through /proc/PID/{comm,stat,status} */
 void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
 {
-- 
2.7.4

