Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE90A6BBD83
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjCOTpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjCOTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:44:47 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC750311D4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:44:35 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c18so17507935qte.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K8lekfNTHeJ4C0iv99fjGghn93IIX905cIt06EpTfQ=;
        b=cKuWC+aHDyxATa6HN+YqE2E5Okxl3eR7i8zhoQiYjbzAOf2vN+cKz3FWTds5n8vFyZ
         4FHsCNQavFITJZv8en/rMnQhzx8Bu1Ufn4X/caDxoFZldJHM/1+37+83SF2L6Q6HM4me
         bh0PyPNf3ZJ5AH49Aq7N5gzNJEuxy5pZTENp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3K8lekfNTHeJ4C0iv99fjGghn93IIX905cIt06EpTfQ=;
        b=PuoMuObrcNYjjQGdIN/5wTDIDzp22wL6bGUK4g4Zb3/GW9Q/KcyaNOe6XmxpO7cyEN
         iZ+Ttoxjr6x/aqrvnz0zVm5Sm04sXWnl3RD82oof/lcDQKNJ6FoQ50JGG18vRHYf+SZp
         IxerqY6Gp9zhgJpG8sH7neSEzomakket3xDx5MQbeWU43ukGLBY9bnUMSuTCJGuPGnpj
         X9GvMsRe4fVXGrpY/vhwx0Rw6lHKtbVJipGiadaOgO4YJBi5xhgzpi6oy9Yd7obat166
         9NQcyK4AuMcjxghlenpWBAgdcutDQqicHqaVV6rSXtDLEjaH2mgQeS7GT6qCYCVjlGWp
         z7KQ==
X-Gm-Message-State: AO0yUKU+v0jk9NKS/s/hwp4PVhK2OVSUXLYa0nJtl7iJyJ6UfUM5CIVf
        txtq5z0ckSKiB6m/xHrXZBax1zeHmB/e2iFqXlM=
X-Google-Smtp-Source: AK7set+LT+EegIShwTd4ywC4A9b7O5vXSYEk4EuLY9iyTgGFwjNnq/dG6dMyVv6nragGJ8LRGB3skQ==
X-Received: by 2002:a05:622a:30d:b0:3bf:c407:10ca with SMTP id q13-20020a05622a030d00b003bfc40710camr1981909qtw.10.1678909474756;
        Wed, 15 Mar 2023 12:44:34 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id c15-20020ac8660f000000b003b86b088755sm4346666qtp.15.2023.03.15.12.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:44:34 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
Subject: [PATCH 6/9] rcu: Permit start_poll_synchronize_rcu_expedited() to be invoked early
Date:   Wed, 15 Mar 2023 19:43:46 +0000
Message-Id: <20230315194349.10798-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315194349.10798-1-joel@joelfernandes.org>
References: <20230315194349.10798-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

According to the commit log of the patch that added it to the kernel,
start_poll_synchronize_rcu_expedited() can be invoked very early, as
in long before rcu_init() has been invoked.  But before rcu_init(),
the rcu_data structure's ->mynode field has not yet been initialized.
This means that the start_poll_synchronize_rcu_expedited() function's
attempt to set the CPU's leaf rcu_node structure's ->exp_seq_poll_rq
field will result in a segmentation fault.

This commit therefore causes start_poll_synchronize_rcu_expedited() to
set ->exp_seq_poll_rq only after rcu_init() has initialized all CPUs'
rcu_data structures' ->mynode fields.  It also removes the check from
the rcu_init() function so that start_poll_synchronize_rcu_expedited(
is unconditionally invoked.  Yes, this might result in an unnecessary
boot-time grace period, but this is down in the noise.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c     | 5 ++---
 kernel/rcu/tree_exp.h | 5 +++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e80e8f128c57..90d54571126a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4942,9 +4942,8 @@ void __init rcu_init(void)
 	else
 		qovld_calc = qovld;
 
-	// Kick-start any polled grace periods that started early.
-	if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
-		(void)start_poll_synchronize_rcu_expedited();
+	// Kick-start in case any polled grace periods started early.
+	(void)start_poll_synchronize_rcu_expedited();
 
 	rcu_test_sync_prims();
 }
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 7cc4856da081..5343f32e7d67 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -1066,9 +1066,10 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
 	if (rcu_init_invoked())
 		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	if (!poll_state_synchronize_rcu(s)) {
-		rnp->exp_seq_poll_rq = s;
-		if (rcu_init_invoked())
+		if (rcu_init_invoked()) {
+			rnp->exp_seq_poll_rq = s;
 			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
+		}
 	}
 	if (rcu_init_invoked())
 		raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
-- 
2.40.0.rc1.284.g88254d51c5-goog

