Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B36B5E6F40
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiIVWBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiIVWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:01:31 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122DF101965
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:01:30 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i3so7212069qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=B0XQyn7nJk8icZHRVUAbtruFw6kr1vhii64N8EO85w4=;
        b=obIE1rAS1C/o65gwmG1qn02DAb4k8F+UbmURCeF7jPGY33vwjXFpzfF0PxhbdTO54u
         TrDjjXL49ljYT810xWc+ZhPZEn7SGlMWqJRHp1O+GELXMgOLvS8YV3PFN8Tk8f9JKV8l
         wTnLcS7hd9U2nnBDQPmq8rOf173B8D1qpBPuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B0XQyn7nJk8icZHRVUAbtruFw6kr1vhii64N8EO85w4=;
        b=lcsAwmVI181N/9W4NecY2FTP/geQSGMCwLSxCQp65Up2DUBM0tB/oZdR+tj7lFDnwg
         bvhA9+iviMb6xRXG8gr2CGOgx4YcdLuWPnf9NG3ZGrqpGBfDtPA19lH0MmxWlfwArP30
         nUjrL8RJLLQTbJiHswdEFZN2XZ50WcWLJcWkRRMWF96ZgMzlYNzjzJYtBdIjtk+fKr+O
         PJ17fbUddROOX5JNuu0Vu1bxLxNUYpYOUR7gr7pTKaIScTZ05YeivMt4ujRK16L1S6b6
         nwr4uYI3PLEtfnYkc+T2AhvD3FVqwyigURqOrSPeGRtn8Nt7vO+7Z+cohqqRR20VqpDF
         AQAg==
X-Gm-Message-State: ACrzQf1vudvFwqswov0wuqt9sNJ1CYjhuOlapbzgITSVL/Nmlh+d/cFZ
        850Pf2UhGFBbv0LKyeEe125ScQ==
X-Google-Smtp-Source: AMsMyM5W580IcuarDtexq6SFQIE5t986Srjk7Qxuc5IvNhVy43mWq/MX6UE31zpWmmABFdgkEWT0yg==
X-Received: by 2002:a05:620a:4081:b0:6ce:6253:b90c with SMTP id f1-20020a05620a408100b006ce6253b90cmr3745912qko.172.1663884089154;
        Thu, 22 Sep 2022 15:01:29 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id z12-20020ac87f8c000000b0035ba7012724sm4465833qtj.70.2022.09.22.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:01:28 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v6 3/4] rcuscale: Add laziness and kfree tests
Date:   Thu, 22 Sep 2022 22:01:03 +0000
Message-Id: <20220922220104.2446868-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220922220104.2446868-1-joel@joelfernandes.org>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add 2 tests to rcuscale, first one is a startup test to check whether
we are not too lazy or too hard working. Two, emulate kfree_rcu() itself
to use call_rcu() and check memory pressure. In my testing, the new
call_rcu() does well to keep memory pressure under control, similar
to kfree_rcu().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuscale.c | 65 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 3ef02d4a8108..027b7c1e7613 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -95,6 +95,7 @@ torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
 torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
+torture_param(int, kfree_by_call_rcu, 0, "Use call_rcu() to emulate kfree_rcu()?");
 
 static char *scale_type = "rcu";
 module_param(scale_type, charp, 0444);
@@ -659,6 +660,14 @@ struct kfree_obj {
 	struct rcu_head rh;
 };
 
+/* Used if doing RCU-kfree'ing via call_rcu(). */
+static void kfree_call_rcu(struct rcu_head *rh)
+{
+	struct kfree_obj *obj = container_of(rh, struct kfree_obj, rh);
+
+	kfree(obj);
+}
+
 static int
 kfree_scale_thread(void *arg)
 {
@@ -696,6 +705,11 @@ kfree_scale_thread(void *arg)
 			if (!alloc_ptr)
 				return -ENOMEM;
 
+			if (kfree_by_call_rcu) {
+				call_rcu(&(alloc_ptr->rh), kfree_call_rcu);
+				continue;
+			}
+
 			// By default kfree_rcu_test_single and kfree_rcu_test_double are
 			// initialized to false. If both have the same value (false or true)
 			// both are randomly tested, otherwise only the one with value true
@@ -767,11 +781,58 @@ kfree_scale_shutdown(void *arg)
 	return -EINVAL;
 }
 
+// Used if doing RCU-kfree'ing via call_rcu().
+static unsigned long jiffies_at_lazy_cb;
+static struct rcu_head lazy_test1_rh;
+static int rcu_lazy_test1_cb_called;
+static void call_rcu_lazy_test1(struct rcu_head *rh)
+{
+	jiffies_at_lazy_cb = jiffies;
+	WRITE_ONCE(rcu_lazy_test1_cb_called, 1);
+}
+
 static int __init
 kfree_scale_init(void)
 {
 	long i;
 	int firsterr = 0;
+	unsigned long orig_jif, jif_start;
+
+	// Also, do a quick self-test to ensure laziness is as much as
+	// expected.
+	if (kfree_by_call_rcu && !IS_ENABLED(CONFIG_RCU_LAZY)) {
+		pr_alert("CONFIG_RCU_LAZY is disabled, falling back to kfree_rcu() "
+			 "for delayed RCU kfree'ing\n");
+		kfree_by_call_rcu = 0;
+	}
+
+	if (kfree_by_call_rcu) {
+		/* do a test to check the timeout. */
+		orig_jif = rcu_lazy_get_jiffies_till_flush();
+
+		rcu_lazy_set_jiffies_till_flush(2 * HZ);
+		rcu_barrier();
+
+		jif_start = jiffies;
+		jiffies_at_lazy_cb = 0;
+		call_rcu(&lazy_test1_rh, call_rcu_lazy_test1);
+
+		smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
+
+		rcu_lazy_set_jiffies_till_flush(orig_jif);
+
+		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
+			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
+			WARN_ON_ONCE(1);
+			return -1;
+		}
+
+		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
+			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
+			WARN_ON_ONCE(1);
+			return -1;
+		}
+	}
 
 	kfree_nrealthreads = compute_real(kfree_nthreads);
 	/* Start up the kthreads. */
@@ -784,7 +845,9 @@ kfree_scale_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
-	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
+	pr_alert("kfree object size=%zu, kfree_by_call_rcu=%d\n",
+			kfree_mult * sizeof(struct kfree_obj),
+			kfree_by_call_rcu);
 
 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
 			       GFP_KERNEL);
-- 
2.37.3.998.g577e59143f-goog

