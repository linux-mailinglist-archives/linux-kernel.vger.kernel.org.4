Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7260013A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJPQXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJPQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:41 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A981C3D5A4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:38 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f8so5415345qkg.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O99Qgvv8EMn7R2VX8zNwhW7077dknEew8817iqFh+Z0=;
        b=A0iw44OIXFnSt6q7ohniyWUHk+cUylfjjbIh1F4lTWAyPpei5ZY5NInt+6TUjLZyqT
         GQbzNAYDP5YQDIpkg/1CC+ISYld8+pJRCj4CzKCHI2txJCFmFKE+xXPXb70gbpfpxqM8
         D7wxzReb589Z93lS7ZQ4saIztNiFghiEs2suw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O99Qgvv8EMn7R2VX8zNwhW7077dknEew8817iqFh+Z0=;
        b=F4Y93wUf0KCAwQXnJeUJ2vzkrIp9VcS9aOik/GriATLZ0XkKb34CRM+DnFLKAKOQee
         MgWOxH3CY+Us4uXmwdqDgfatLrPyqtmugFh+6Ac4JNaV1vv//jDE8LRka8NAw72W3Xek
         2c4hTDLP/YAI0yUtnNNyD0Dts76R3pE87jpKnDbH9BiM22Gwabfy6S70qMVWZ66tertf
         7urIP5M9XHBPbf1RJJeR5+aCuUvpEZJKvPHW+V5muIGSR84Swq5jcXoqoVpU5VBuPoAL
         4BH0tn93UY5LwPqC9JGzSlMbF5RsyB2kh4Otyl8g5rlcN/sLUnosTA94x/W7fPj3ZUzf
         FL0Q==
X-Gm-Message-State: ACrzQf3z0gcmWQF+YO6Oo/MpWmJVNiEdpMe7PWXjobOtUfXeKMQeTDs5
        iJtwwZtieler0Kw+LAoQ/VaLIMOd5FpfHA==
X-Google-Smtp-Source: AMsMyM48rMeAqPyhvvqc03I7NgSbQD6HEVxx9lyonu1ZvxbY6qOShApcYXaNgcs3NNddejTreTKgYg==
X-Received: by 2002:a05:620a:191d:b0:6ee:e3cf:b2db with SMTP id bj29-20020a05620a191d00b006eee3cfb2dbmr1245456qkb.633.1665937417334;
        Sun, 16 Oct 2022 09:23:37 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org, Vineeth Pillai <vineeth@bitbyteword.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v9 04/13] rcu: shrinker for lazy rcu
Date:   Sun, 16 Oct 2022 16:22:56 +0000
Message-Id: <20221016162305.2489629-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
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
index 717c0591c037..dc014a0b97b7 100644
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
2.38.0.413.g74048e4d9e-goog

