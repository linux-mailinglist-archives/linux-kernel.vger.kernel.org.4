Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635464ED62
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiLPPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiLPPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:04:54 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB624A590
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:04:53 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id fc4so6714169ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPdL7N2yNp0Dv2g7YQriWRNOrf3hAQ6mJKCq49X+ThM=;
        b=XANKMONu3ZH0X17deKP9vTgUBNMh7KMlbqJBrBxPYqgB5sOo1GByUKyxqqdWT/np9l
         oJTJrLDUGGKj0jSFQ3zdiTl/yJx9OYBHUtUdz7EA3Qh9hAuPYP+j9Y/Af4YkpfwAqIPz
         jlyFdMtuIu2h4bNFBmn0vZMIRXMF3bbn5GeMBv7FCRUZMGxF0Who/Ea5rvp71Mq81rEF
         VBc1rHwHxbYw4rnF+9LUyzGItWz/vPR1n0C7qqP17k4sqZJBvBTsYn9BSWAc9UCa7Ff4
         OnehsFy6ySRnF1guE712crCrc6z7F4WYyur+8uhyAL+cfAl30IcXnalpMvlEn0rbP75l
         fpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPdL7N2yNp0Dv2g7YQriWRNOrf3hAQ6mJKCq49X+ThM=;
        b=C+YLxwH+GtCuRHKtBuP/0DWjnws//qRIKiaSylC2AQNF9rDMuGZ6/cceNy5wjKsK8c
         FD9G/QN3I0Epklfe+5DShwMmpVUYJkEPbZ7hMmZ/u2CZrMeVM5cYNz16XRGQ4jLOqrT1
         7odvHwdEfSvRSeB++dd9NdphGy3sVudpzQCnnRogKUm9t0Zd/fWc3Fa72bmSIpMAA9v6
         Au4vrtQ7JbTNXVDqtfnCMpB1eDEbfvxhX9xpBvMTCs1Ind/q4pyId6ed2GacKV4Rv1RZ
         XWR0m7tFpalKMHy6ZA44KbWvDyeRwh1ieWRaj9bPDwLnJMf909dl601R7J7JCns0GxrQ
         7J9A==
X-Gm-Message-State: ANoB5pmuTD7ztiQZ282Hd5yedE2Xnya1Md/eC1+Jdqz8hta7Lr3G+uJU
        CclNiMWC4Rgm7ybLcw8rG36AqL3GIhXAvjdZ
X-Google-Smtp-Source: AA0mqf5YOIeC81lY3ncW+Aq27+b7SVJLQ/CH8StcB1fZCkuNnYwV5V69wfte5psoZkonPpSnkFs6Eg==
X-Received: by 2002:a17:906:d147:b0:7c1:22a9:ba8b with SMTP id br7-20020a170906d14700b007c122a9ba8bmr26316346ejb.50.1671203091682;
        Fri, 16 Dec 2022 07:04:51 -0800 (PST)
Received: from localhost.localdomain (p200300d9973eac0005dbc67c2510e9a9.dip0.t-ipconnect.de. [2003:d9:973e:ac00:5db:c67c:2510:e9a9])
        by smtp.googlemail.com with ESMTPSA id z1-20020a1709063a0100b00780982d77d1sm929456eje.154.2022.12.16.07.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:04:51 -0800 (PST)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     1vier1@web.de, Manfred Spraul <manfred@colorfullife.com>,
        "Sun, Jiebin" <jiebin.sun@intel.com>
Subject: [PATCH 1/3] :lib/percpu_counter: percpu_counter_add_batch() overflow/underflow
Date:   Fri, 16 Dec 2022 16:04:39 +0100
Message-Id: <20221216150441.200533-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221216150155.200389-1-manfred@colorfullife.com>
References: <20221216150155.200389-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an interrupt happens between __this_cpu_read(*fbc->counters) and
this_cpu_add(*fbc->counters, amount), and that interrupt modifies
the per_cpu_counter, then the this_cpu_add() after the interrupt
returns may under/overflow.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: "Sun, Jiebin" <jiebin.sun@intel.com>
---
 lib/percpu_counter.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 42f729c8e56c..dba56c5c1837 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -73,28 +73,33 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
 EXPORT_SYMBOL(percpu_counter_set);
 
 /*
- * This function is both preempt and irq safe. The former is due to explicit
- * preemption disable. The latter is guaranteed by the fact that the slow path
- * is explicitly protected by an irq-safe spinlock whereas the fast patch uses
- * this_cpu_add which is irq-safe by definition. Hence there is no need muck
- * with irq state before calling this one
+ * local_irq_save() is needed to make the function irq safe:
+ * - The slow path would be ok as protected by an irq-safe spinlock.
+ * - this_cpu_add would be ok as it is irq-safe by definition.
+ * But:
+ * The decision slow path/fast path and the actual update must be atomic, too.
+ * Otherwise a call in process context could check the current values and
+ * decide that the fast path can be used. If now an interrupt occurs before
+ * the this_cpu_add(), and the interrupt updates this_cpu(*fbc->counters),
+ * then the this_cpu_add() that is executed after the interrupt has completed
+ * can produce values larger than "batch" or even overflows.
  */
 void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 {
 	s64 count;
+	unsigned long flags;
 
-	preempt_disable();
+	local_irq_save(flags);
 	count = __this_cpu_read(*fbc->counters) + amount;
 	if (abs(count) >= batch) {
-		unsigned long flags;
-		raw_spin_lock_irqsave(&fbc->lock, flags);
+		raw_spin_lock(&fbc->lock);
 		fbc->count += count;
 		__this_cpu_sub(*fbc->counters, count - amount);
-		raw_spin_unlock_irqrestore(&fbc->lock, flags);
+		raw_spin_unlock(&fbc->lock);
 	} else {
 		this_cpu_add(*fbc->counters, amount);
 	}
-	preempt_enable();
+	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(percpu_counter_add_batch);
 
-- 
2.38.1

