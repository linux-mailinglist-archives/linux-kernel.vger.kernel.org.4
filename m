Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08495E6F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIVWBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIVWB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:01:29 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE349F8F9F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:01:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id b23so7293448qtr.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zIWTRfnvBQN5vTCxbMIC47LGFoMDr9nrugSvdFV6LqQ=;
        b=gUN22foRH9YYHKT9UteEYRTA+owayfilXutUXe3Zk13WvNcaCda8c21NFVdilPC1jx
         N+5tQb1HODwuk6YQWLhWfrrTSgo+5nDRdpPNNSZDNu4MMOany9YsQdKeKyDWdyUo/5p5
         m5cscoZ65fgawWZwXKCUNz5m+EZKuCholMDXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zIWTRfnvBQN5vTCxbMIC47LGFoMDr9nrugSvdFV6LqQ=;
        b=VXbraio3C+/isgdmzwBj0JTxDJ/0TdQFLqzdTqSJ2zwkJFGbChZqQ5tFXLkzZsy4ka
         2bkjCoRaxkn8yGyhOjW+Ti+tAClTQrnO5KdHFfyCULlLbOdNz6f2U24R1ks4LYnpz6bO
         wJXejJqPz6JhEoWmfMV75zwq4recaCPGu5jBlWra68omm/rKGEzmMhbHJ8/sBRHc31pF
         U+S59CxHcmJOBR/EQUt21tlcawRxIzZuq6BM+dSVjf4KyxsmbuA7cZyy+5Lek9N8ULbc
         /6vDUhEr0AMSZ6DdimIcKYSW8VDFlVbfdR/wJLlklNO1aiUFNX8BmVWSvOpVi/QmskVk
         IKHA==
X-Gm-Message-State: ACrzQf3/60qhL09lOi47fRZTBWaJqxrX9gC/cQAO46GnCJcDz6dZHYw5
        uZ0W9/Cfjin+8pBf2xipUxEU2A==
X-Google-Smtp-Source: AMsMyM4bB5yLNsDEX8+uaXcyDCoP0jgWLZBaeOJw2x0V4bRfyYrRh6IHLLk/Er3Lp8Yj5rrWanyR8Q==
X-Received: by 2002:a05:622a:1909:b0:344:9f41:9477 with SMTP id w9-20020a05622a190900b003449f419477mr4599043qtc.619.1663884088046;
        Thu, 22 Sep 2022 15:01:28 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id z12-20020ac87f8c000000b0035ba7012724sm4465833qtj.70.2022.09.22.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:01:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v6 2/4] rcu: shrinker for lazy rcu
Date:   Thu, 22 Sep 2022 22:01:02 +0000
Message-Id: <20220922220104.2446868-3-joel@joelfernandes.org>
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

From: Vineeth Pillai <vineeth@bitbyteword.org>

The shrinker is used to speed up the free'ing of memory potentially held
by RCU lazy callbacks. RCU kernel module test cases show this to be
effective. Test is introduced in a later patch.

Signed-off-by: Vineeth Pillai <vineeth@bitbyteword.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 661c685aba3f..1a182b9c4f6c 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1332,6 +1332,55 @@ int rcu_nocb_cpu_offload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
+static unsigned long
+lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+		count +=  READ_ONCE(rdp->lazy_len);
+	}
+
+	return count ? count : SHRINK_EMPTY;
+}
+
+static unsigned long
+lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long flags;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		int _count = READ_ONCE(rdp->lazy_len);
+
+		if (_count == 0)
+			continue;
+		rcu_nocb_lock_irqsave(rdp, flags);
+		WRITE_ONCE(rdp->lazy_len, 0);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+		wake_nocb_gp(rdp, false);
+		sc->nr_to_scan -= _count;
+		count += _count;
+		if (sc->nr_to_scan <= 0)
+			break;
+	}
+	return count ? count : SHRINK_STOP;
+}
+
+static struct shrinker lazy_rcu_shrinker = {
+	.count_objects = lazy_rcu_shrink_count,
+	.scan_objects = lazy_rcu_shrink_scan,
+	.batch = 0,
+	.seeks = DEFAULT_SEEKS,
+};
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
@@ -1362,6 +1411,9 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
+	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
+		pr_err("Failed to register lazy_rcu shrinker!\n");
+
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.37.3.998.g577e59143f-goog

