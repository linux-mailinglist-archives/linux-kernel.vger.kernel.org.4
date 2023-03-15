Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BCE6BBD67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjCOTj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjCOTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:39:13 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CE12BC6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:39:12 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id y3so17388537qvn.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kodpLrQnSozwTishADT/eFOoqfGUIFhFbZ2Rg+LiOA=;
        b=WByS267g9t6NJ1kyG9/EnjmxtgTNYbezAKGqyr8CaaBwqZINFEuA/ntWN6H+6kcZlm
         0y0pivfDEqSC6+oWTYuc4+m0Ve4R+syrQBMCVHz35BK+o7Fx/qDMRs/tpQIZtjbMvVYM
         Z/STPa8OKdawLzzW22yLDCHQE1elXduZpbeGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kodpLrQnSozwTishADT/eFOoqfGUIFhFbZ2Rg+LiOA=;
        b=3ob0NbFjgs5R2Vq+PceAaX5BCewJ0jJdoxOqy+CYfetsVL9HgZ8Pj3328Jqqcr4W6T
         S7XfeLScLBhNBvOOB6zNS3L0FGoboI/MDKCB3eQjzNcu/Zn2REchqz/xrldQyFXXGIF3
         OBkqj/QjeB2DcUJANEG+M6UUygwIL/7957qmWWnXuz1YQ5AUSf2FKKPcN6JkKPvhe5kd
         6DnQ6A1XrbUHc5kCxM1HXmvynalwSoYjMxNUsNuyuMYFNzyhgNXn/IJS2AhbGhC0UaBj
         WLJR5fOOzWQ+2nIePfVWFX3hKlflJ3286JwKJb/mzIuR1a0iYcd44QIFC8E5XpCtweRy
         yuuQ==
X-Gm-Message-State: AO0yUKULTpoWKF4lVkfqYn7sbkc4eQ/K4MKBwKLFGS5jcNnPqJwM9UZa
        o9uHuR/15q8xuLOwNrua4zKR3BgPAIVbcb37wAc=
X-Google-Smtp-Source: AK7set9xcFD5mrNuQbfScTwldN49ZVEM6uEf3ek4PJRMRU82tR8zA3YA+oKG8/u9a34gp1BqcGUv3g==
X-Received: by 2002:a05:6214:20a7:b0:56e:fb4c:c1c4 with SMTP id 7-20020a05621420a700b0056efb4cc1c4mr32374960qvd.14.1678909151167;
        Wed, 15 Mar 2023 12:39:11 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b00745af48838bsm4347227qko.5.2023.03.15.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:39:10 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 1/6] srcu: Add comments for srcu_size_state
Date:   Wed, 15 Mar 2023 19:38:46 +0000
Message-Id: <20230315193851.8598-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
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

From: Pingfan Liu <kernelfans@gmail.com>

The SRCU_SIZE_* names are not self-explanatory, so this commit therefore
adds comments to the definitions.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: rcu@vger.kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/srcutree.h | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 558057b517b7..a6910805f9c5 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -92,16 +92,29 @@ struct srcu_struct {
 	struct lockdep_map dep_map;
 };
 
-/* Values for size state variable (->srcu_size_state). */
-#define SRCU_SIZE_SMALL		0
-#define SRCU_SIZE_ALLOC		1
-#define SRCU_SIZE_WAIT_BARRIER	2
-#define SRCU_SIZE_WAIT_CALL	3
-#define SRCU_SIZE_WAIT_CBS1	4
-#define SRCU_SIZE_WAIT_CBS2	5
-#define SRCU_SIZE_WAIT_CBS3	6
-#define SRCU_SIZE_WAIT_CBS4	7
-#define SRCU_SIZE_BIG		8
+// Values for size state variable (->srcu_size_state).  Once the state
+// has been set to SRCU_SIZE_ALLOC, the grace-period code advances through
+// this state machine one step per grace period until the SRCU_SIZE_BIG state
+// is reached.  Otherwise, the state machine remains in the SRCU_SIZE_SMALL
+// state indefinitely.
+#define SRCU_SIZE_SMALL		0	// No srcu_node combining tree, ->node == NULL
+#define SRCU_SIZE_ALLOC		1	// An srcu_node tree is being allocated, initialized,
+					//  and then referenced by ->node.  It will not be used.
+#define SRCU_SIZE_WAIT_BARRIER	2	// The srcu_node tree starts being used by everything
+					//  except call_srcu(), especially by srcu_barrier().
+					//  By the end of this state, all CPUs and threads
+					//  are aware of this tree's existence.
+#define SRCU_SIZE_WAIT_CALL	3	// The srcu_node tree starts being used by call_srcu().
+					//  By the end of this state, all of the call_srcu()
+					//  invocations that were running on a non-boot CPU
+					//  and using the boot CPU's callback queue will have
+					//  completed.
+#define SRCU_SIZE_WAIT_CBS1	4	// Don't trust the ->srcu_have_cbs[] grace-period
+#define SRCU_SIZE_WAIT_CBS2	5	//  sequence elements or the ->srcu_data_have_cbs[]
+#define SRCU_SIZE_WAIT_CBS3	6	//  CPU-bitmask elements until all four elements of
+#define SRCU_SIZE_WAIT_CBS4	7	//  each array have been initialized.
+#define SRCU_SIZE_BIG		8	// The srcu_node combining tree is fully initialized
+					//  and all aspects of it are being put to use.
 
 /* Values for state variable (bottom bits of ->srcu_gp_seq). */
 #define SRCU_STATE_IDLE		0
-- 
2.40.0.rc1.284.g88254d51c5-goog

