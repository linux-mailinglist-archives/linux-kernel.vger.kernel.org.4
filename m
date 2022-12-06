Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2303644314
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiLFMYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLFMYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:24:06 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC5C28E27;
        Tue,  6 Dec 2022 04:24:02 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vv4so5801123ejc.2;
        Tue, 06 Dec 2022 04:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OzQf6O96kQU/9b9Rxkvx78FK/If7e44i6Ub9+L4DsqA=;
        b=o7v93TF1sVonrEY7ulPfEf8o94p95sAJIVR6eq03qcEidh/Ysbh+du4MLAQa43Gx1H
         vVfNybv3GvG2C1mLya3T1JzIPLVPP6Ea7rtx1hJKyvzRivXNShVyTwjpmrLgir7GBv6K
         tPo6ixyK8PGA6OJbxPslhm0GgB5HyiPSXYG6AvUzIbBpP1ZGtB1weJxkElGoq4EmbkCb
         ETVFbW4pJnFtbpUxwtpG2iG/7JVv/+oOHvSm4oPljt0dUz/xIT2Gz0VS7zawGcyDLfoX
         ipQB23vWXyZ3uzLjHrw9Yfrl6flLF4VVj7M7fco/5TajYr5/GOUpExuGJ/6aiTfsDU3j
         sMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzQf6O96kQU/9b9Rxkvx78FK/If7e44i6Ub9+L4DsqA=;
        b=jJXvrHr1p/dGGhXuqSib8EfZ6jyH1sI0xgm9ciUkoVOxffzz6VuVRMSPEJOQpBb2t7
         R5Z78DhHTEKOSGJO3FDhLyOohEyq3nvz5bJBzznmKUvT4+TUpqIxrv/mRM6arnZPqt3/
         8P0BvPVDMB7SLSc4I3tNRBssCH+9QbdLkz7188F26yx2rBCTGdLjVQLtytrgVm7IjVRg
         nZ9VCW+gP+uExca5A76IZ7c6LCqcKc3pwKBSw5FPQ0IB9hOOXYjhiffyC61HBGZb+82m
         3l9hUTveDo4pOO2t4uyjpoSQ4QC+NPGgDIECZcF6Yy1KxcjoMUd+LRAZWhbFNZzYjvX8
         7Epw==
X-Gm-Message-State: ANoB5pl3Yy1+ydLErNGWxn+/JAT0ZZiUUuJsUM1s/4304n2/EtYwrlDC
        r9Ip0c1cjt9u8PEAjuBG2dRI9H7bA6Sv9g==
X-Google-Smtp-Source: AA0mqf4Fj8flcXvcahLIBRyzVHaT/Lk2p8V4XzlXZ+yb867KGf8678OhofDidLo+QYXnX7JuO+Q6QA==
X-Received: by 2002:a17:906:258d:b0:7c0:aea3:a9a8 with SMTP id m13-20020a170906258d00b007c0aea3a9a8mr19412181ejb.718.1670329440532;
        Tue, 06 Dec 2022 04:24:00 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id dy25-20020a05640231f900b004643f1524f3sm920681edb.44.2022.12.06.04.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 04:24:00 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/1] rcu/kvfree: Add runtime sleep check for single argument
Date:   Tue,  6 Dec 2022 13:23:57 +0100
Message-Id: <20221206122357.309982-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single argument can be invoked only from a sleepable
context. There is already a might_sleep() check to mitigate
such cases. The problem is that it requires a kernel to
be built with a CONFIG_DEBUG_ATOMIC_SLEEP option.

In order to improve an extra runtime_assert_can_sleep()
function is introduced by this patch. It is a run-time
checking. Please note it only covers PREEMPT kernels.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d155f2594317..bb798f07e768 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3232,6 +3232,19 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	return true;
 }
 
+static void
+runtime_assert_can_sleep(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return;
+
+	if (preemptible())
+		return;
+
+	WARN_ONCE(1, "in_atomic(): %d, irqs_disabled(): %d, pid: %d, name: %s\n",
+		in_atomic(), irqs_disabled(), current->pid, current->comm);
+}
+
 /*
  * Queue a request for lazy invocation of the appropriate free routine
  * after a grace period.  Please note that three paths are maintained,
@@ -3257,8 +3270,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	 * only. For other places please embed an rcu_head to
 	 * your data.
 	 */
-	if (!head)
+	if (!head) {
+		runtime_assert_can_sleep();
 		might_sleep();
+	}
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
-- 
2.30.2

