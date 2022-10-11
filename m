Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2829C5FBA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJKSCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJKSCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:14 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F3469198
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:12 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x13so6473876qkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpiCXsolqqIKZHL/Ss07v3/tpY+Ag29mBvL3dckuR0g=;
        b=k8mW7A2UBn9X2gqXI9kY6Bj692gXkqEiwh+M/8pp0p11XGTMvOmG+k787fJlN7R9sO
         TLUNZe/nUChql+iXv2/jzUz01hNPhQ5KqZHvYybQH836sj81k/bcWTydyTqLw84ybcJc
         XWZTwdtSveGOCPNoIKt+oJH+Lfe/u9osgy3tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpiCXsolqqIKZHL/Ss07v3/tpY+Ag29mBvL3dckuR0g=;
        b=lRDyHrC9iZo5QUhycJpm2wLOBAZxVH9r7ZyGD9NuEz28ARGynSOeHi2j5JWUh/H4El
         mgAmg3RMvntPdxvrlvaXSV3euM4PEIa6njC/fXPTg3Y+2JgjLU1JruQqTsXdCx1uZ4UN
         Y96kptiuY8DViBCkeCej48byOCGGtuDp/fjQHC6VOJPXO1RQQqfrPLx7qrMDrD0h1nDi
         +yYzbejPx43D34xquKce457BDEO+Kyh9peDZadnQ4360NcDDOgNQhN31upEOcb+Ya6Tu
         RiiRU5bVVIqSuZgLtPLlL6GXE/Vr1BiItCxZHl0/7799+vkeH24uFwkDTo7XFOw/F872
         givA==
X-Gm-Message-State: ACrzQf3BTryQ4fuHt8tPAxe4vL0aRprxO1i6LdsbEm8U/DiDFZzDUr3z
        6toizNkuH8l7GFSQc3WUTmrWQw==
X-Google-Smtp-Source: AMsMyM5b/B7e5zozdGXJFbFhAuqfTF62sNkqEDie8RB53fZ0beOtJKsKFATmGOOYMmfdHd8jkSxwvA==
X-Received: by 2002:a05:620a:2018:b0:6ee:a96:3c9e with SMTP id c24-20020a05620a201800b006ee0a963c9emr5789815qka.18.1665511331587;
        Tue, 11 Oct 2022 11:02:11 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:11 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com, Vineeth Pillai <vineeth@bitbyteword.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v8 04/13] rcu: shrinker for lazy rcu
Date:   Tue, 11 Oct 2022 18:01:33 +0000
Message-Id: <20221011180142.2742289-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
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
index 5ce66f9f4a98..f69eeaa97ba6 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1312,6 +1312,55 @@ int rcu_nocb_cpu_offload(int cpu)
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
@@ -1342,6 +1391,9 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
+	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
+		pr_err("Failed to register lazy_rcu shrinker!\n");
+
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.38.0.rc1.362.ged0d419d3c-goog

