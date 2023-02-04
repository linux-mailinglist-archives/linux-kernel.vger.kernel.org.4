Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1B468A7C5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 03:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjBDCVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 21:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjBDCVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 21:21:10 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741971CAFA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 18:21:08 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id ll10so3987425qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 18:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+Rvn1JkfUTqQUprG3LidZWtpE2Owjne4mF5ZG2WHZQ=;
        b=HxpEjUaIgXZu4UXq0hMXQMd9KfFVD9LWbiToWocN96/h5IO9U7eTTnXtxRpzpUiggi
         0Y8pChI5LH+FwY2ndyfBUlbsctjREJs9G3oOUUxMaENd1bxQoXEABtuMMIw2DpPf5eZY
         2/P6jvWZpgUjLx6SJNWfl/FB/6Y6gQM7F6zns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+Rvn1JkfUTqQUprG3LidZWtpE2Owjne4mF5ZG2WHZQ=;
        b=gGvoVwHPQSm7cIQoP0AzMaROz8Ov7xArco5o74kynM87B1dB4otmIlsLItvTF2sS3K
         EBQ3LZPWxGhtwatq8sZTC0i0o3cZTvELOkWyppeZ15bAriGCC+b6rdL4euJto4IzT3Zu
         KminWW09i1nk6IP47sLgq3U3iWbaTIc70EABN3LFnjBj9L1kV74P80UmsXa+/JeK6mAU
         Tv+c2Xaq+oG+roCELrM8pVgFitY6lPygVurL2/90CqImiw2/zHiFj1r8bCOd8IjgCa08
         V3ZTQ0H9WXQbmYCfsHVHwfAibezFQtNVBcLh+LR1+0BYMDW6uHDgQKTSaCYl//bhd/Ai
         y06A==
X-Gm-Message-State: AO0yUKUd7Whe2uPiR3TM8kGyD11gJ+Js565CLb/OSo8NJRIp6tAfxQTA
        A7t46/1VQg491sIQPDbV98xSPehWBYWsNZat
X-Google-Smtp-Source: AK7set+pZFXne3CvWwywDjMU82pRMhzTejMzmm5xQQS2AojsdM9jO+Em6XDs4qW6zE6LjdoXrM3cVw==
X-Received: by 2002:a05:6214:300c:b0:56a:d22b:5821 with SMTP id ke12-20020a056214300c00b0056ad22b5821mr4739456qvb.22.1675477266824;
        Fri, 03 Feb 2023 18:21:06 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id n2-20020a05620a294200b006f9ddaaf01esm3056951qkp.102.2023.02.03.18.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 18:21:05 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Qiang Zhang <Qiang1.zhang@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
Date:   Sat,  4 Feb 2023 02:20:50 +0000
Message-Id: <20230204022051.2737724-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
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

Recent discussion triggered due to a patch linked below, from Qiang,
shed light on the need to accelerate from QS reporting paths.

Update the comments to capture this piece of knowledge.

Link: https://lore.kernel.org/all/20230118073014.2020743-1-qiang1.zhang@intel.com/
Cc: Qiang Zhang <Qiang1.zhang@intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/rcu/tree.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 93eb03f8ed99..713eb6ca6902 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1983,7 +1983,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	} else {
 		/*
 		 * This GP can't end until cpu checks in, so all of our
-		 * callbacks can be processed during the next GP.
+		 * callbacks can be processed during the next GP. Do
+		 * the acceleration from here otherwise there may be extra
+		 * grace period delays, as any accelerations from rcu_core()
+		 * or note_gp_changes() may happen only after the GP after the
+		 * current one has already started. Further, rcu_core()
+		 * only accelerates if RCU is idle (no GP in progress).
 		 *
 		 * NOCB kthreads have their own way to deal with that...
 		 */
@@ -1993,6 +1998,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 			/*
 			 * ...but NOCB kthreads may miss or delay callbacks acceleration
 			 * if in the middle of a (de-)offloading process.
+			 *
+			 * Such missed acceleration may cause the callbacks to
+			 * be stranded until RCU is fully de-offloaded, as
+			 * acceleration from rcu_core() and note_gp_changes()
+			 * cannot happen for fully/partially offloaded mode due
+			 * to ordering dependency between rnp lock and nocb_lock.
 			 */
 			needacc = true;
 		}
-- 
2.39.1.519.gcb327c4b5f-goog

