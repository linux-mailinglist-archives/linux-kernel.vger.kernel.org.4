Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF8D5F3B86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJDCmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJDCmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:25 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4171522BDA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:42:24 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s18so7476207qtx.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wmtVxTPmJaCCAkKQFdXG/Mbs71LbC7ntCNZnJNheJVM=;
        b=Xf+SycYD/cBC2O4IDY3yhjRgdyQmPVNkPi4XK2EaV+Fig29aKdqvqjWvI5RMCVty3b
         qb/xONn8my2ytZj/Yett/Lt9p0s2q3IWeEBh4c/rxvDXq9G9w54tVnj8ykYJ5TwO7R9Q
         FeUfiIrC9idXBgydDnuCXfYrETRvTnRTkHAeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wmtVxTPmJaCCAkKQFdXG/Mbs71LbC7ntCNZnJNheJVM=;
        b=Sxc1H1GwFYhPaTYgIF3/6K6Zu1yDW9SB1aSj0aPOFBNyINYaEQLVEdIIN5oJG/n+nJ
         dlO6kXxL4ZkHYx6Q5yUwvF9Z+cgN/Tfq1duK0YlkYnEtmAVYhq/An4VkkWuv38Ixxju9
         J7X2okZ2pRo2zAKmie0nbvEij0dnUr+GRxlPZU2UrFcAhnqAoDWbcLSzA48LmHwCIN1K
         X2d6mMsk5fOuFO3ygzd9ynHJhZrqismC5wdX8rILaQjSZTple4mqbS1DpXQXjOtOCsCJ
         4qMnxVQka5lirNjhZEYsJMGXhZYVWnk8O1fnu8qNP0HUuY99YpgbPA9YP+nUNSGNvscl
         /OIg==
X-Gm-Message-State: ACrzQf36nSK7qK3X4rNTfcoNN64m2WrjjyZmwekkbUauRn/g7yw3RwsU
        7EUAfB8HY21MGmqvdi9Yzjh4hQ==
X-Google-Smtp-Source: AMsMyM5b1d0STqSSFfB56pIGe2xqsq0N8k7J3PdI/L7zb7WhjubbPbH0n6QHA9TbA2gHvrWbSFD1hw==
X-Received: by 2002:ac8:5953:0:b0:35b:ab1a:ff09 with SMTP id 19-20020ac85953000000b0035bab1aff09mr17995134qtz.144.1664851343390;
        Mon, 03 Oct 2022 19:42:23 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:22 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v7 05/11] rcuscale: Add laziness and kfree tests
Date:   Tue,  4 Oct 2022 02:41:51 +0000
Message-Id: <20221004024157.2470238-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
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
2.38.0.rc1.362.ged0d419d3c-goog

