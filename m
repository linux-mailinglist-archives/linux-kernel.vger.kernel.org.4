Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F7961234A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiJ2N3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2N3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:29:14 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36452BE1C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 06:29:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id w10so5787689qvr.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCeOrmF4sULE5fXDGGQt+e1Jnohk08bl1WSeFsgJlgA=;
        b=xMvWDbz0oeAQAIrRFyo+vUr+dMPxopQnuakIKzTkv+acMn9+1gxGF0ASPykFKV99ek
         8Z5q3vjtUY2jrsiRp1+jE80bVJrfMz8D6Yn228v7hFV0EQ/KmdTZqIzO5kqUDNyY1dFN
         h9IjdWjbLI2WPORr7k2EjnRc+RXKIeLDc+FmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCeOrmF4sULE5fXDGGQt+e1Jnohk08bl1WSeFsgJlgA=;
        b=ut0R42fohP7MSs1h1TSkNHPCgk8sIH1/OBlm9mPcaqwc5/W0sOlyo0UYWBR04+9FXT
         mS/fVRz/iUvNO1BTKl32rNiAgLtOmM9pmlSNMpyM7Fv+uZwJVveGI1J9t3Ea7pHWjJY1
         SNSv2fbb4tetSJ0qbYhN1T0pFyq5QmDZIkxioJJhkbK4w3c+XwZWL2JA+hzU8Umh+82N
         d6nBkECajRIoNocRlP87x8RRR94OynjNSlmVWIebju7XeTYm4Rj6z2pFDZwKm0zEok5Q
         Mv7qhtEr3X0ya+aRiFIvHiwaRZkcxXQMIQLTUZDhKzwoEB3P9MabDeSdAT7xkeANY115
         jHiA==
X-Gm-Message-State: ACrzQf0E+fpITnJK6BeEus+qjIBR/4xfMWn+QnVgZ/ZTeyd8fSPMn8P3
        C5QYAKO4ukRvmjNFhZV1IzHDVdoIcE7AKQ==
X-Google-Smtp-Source: AMsMyM7eNySHwa1HVwzxGmBhrU8qjaZvi462BJFkCrr+ifBczzJRKwji6Emu9gxLigdXcXLb6C3m6A==
X-Received: by 2002:a05:6214:29e7:b0:4bb:db99:c393 with SMTP id jv7-20020a05621429e700b004bbdb99c393mr360121qvb.12.1667050152789;
        Sat, 29 Oct 2022 06:29:12 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id m22-20020a05620a291600b006f926a0572asm1085843qkp.27.2022.10.29.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 06:29:11 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org, urezki@gmail.com,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Date:   Sat, 29 Oct 2022 13:28:56 +0000
Message-Id: <20221029132856.3752018-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
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

On ChromeOS, I am (almost) always seeing the optimization trigger.
Tested boot up and trace_printk'ing how often it triggers.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 591187b6352e..3e4c50b9fd33 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
 
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
+ * @rdp: The rdp of the CPU that this kfree_rcu corresponds to.
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
  * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
@@ -2964,6 +2965,8 @@ struct kfree_rcu_cpu {
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
+	struct rcu_data *rdp;
+	unsigned long last_gp_seq;
 	bool initialized;
 	int count;
 
@@ -3167,6 +3170,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 			mod_delayed_work(system_wq, &krcp->monitor_work, delay);
 		return;
 	}
+	krcp->last_gp_seq = krcp->rdp->gp_seq;
 	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
 }
 
@@ -3217,7 +3221,17 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			//
+			// NOTE about gp_seq wrap: In case of gp_seq overflow,
+			// it is possible for rdp->gp_seq to be less than
+			// krcp->last_gp_seq even though a GP might be over. In
+			// this rare case, we would just have one extra GP.
+			if (krcp->last_gp_seq &&
+			    rcu_seq_completed_gp(krcp->last_gp_seq, krcp->rdp->gp_seq)) {
+				queue_work(system_wq, &krwp->rcu_work.work);
+			} else {
+				queue_rcu_work(system_wq, &krwp->rcu_work);
+			}
 		}
 	}
 
@@ -4802,6 +4816,8 @@ static void __init kfree_rcu_batch_init(void)
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
+		krcp->rdp = per_cpu_ptr(&rcu_data, cpu);
+		krcp->last_gp_seq = 0;
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
-- 
2.38.1.273.g43a17bfeac-goog

