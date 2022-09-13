Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F2D5B7933
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiIMSLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiIMSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:11:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E717436B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:18:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b75so7150118pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PvnL+9cGl2OZT8JmDVYUgH6KLMONpy7QbVIbld3HZFU=;
        b=j3yjGxUKh7EVbd/drrPml3FFgsu3DnYW8P+O2OaGRYDdqd3l137D7BK70Pf8P/24UP
         dMxhOL4B8tYRjki/wGriHL4u6ehhm1PYBVxBrikecmI28KWGeL3EKHS1ypANQtFIbLkw
         VHRWxMT6SLNe3SMd1Y0HnS7hfmk4PsDowqW7SeQQ5hL0L9TIbEwgfjVEtakLkWHUgFoL
         QzFAhlbH5vidkGrl3jzkrO4f3KtmEauIsGmMl+jrDuTLSXmDxQPTZvKxuGPrl0C4XtOJ
         7ktOc3rR1MdJjhdOt4h2PGiB6FmW5ETm00zr9btBRywo3X9QSB2dh72Wwm7CxdJvFjM6
         NWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PvnL+9cGl2OZT8JmDVYUgH6KLMONpy7QbVIbld3HZFU=;
        b=Q/V/ymo0p3w3cxbE5G25XLtGkkfMLFXCw2Kw8XrrnPnPUQVMkD1rk5ApkrFEx87Vfc
         ZWL5UXP7kXKSZl79+sSpFB7okQQAB1Swn8ukILWDfBsnRwfn7tkW0fpmugxeCwacpsTu
         RuL2YYsLMzuwFSosehKuRtpUbdYcYR0I2yG4vAjXPIWwZKIzVX236BLYsNeTYWyWR1ld
         g5kISgdQTCt69H0YOc77G8JFY5PIDuq2zU/IP8QOVj+dO3Ir+uWBcrul6m3GZLbK0NdW
         DNag+rL9ObQ5iqnpm4682L4kZcsE8y0mTmJShI+gIgoAeDFhOpKUL/LQU1wpZCmthZz0
         Q9iw==
X-Gm-Message-State: ACgBeo0M9kfnNPIj5GtpJ+OjL/UDdQp2HfT6GRqy5xpOhc1uvyMbehfB
        VeidU+c3QMMQR7pRXdGkzJZ28xVMBeBX5Q==
X-Google-Smtp-Source: AA6agR6B/WSFLIxR901//HPrAt3VSA3sOqUTNRD0eNW0Z+2tGsFw55Mv/bRaEXkKYDPo2/O0ISVF0g==
X-Received: by 2002:a05:6a00:21d1:b0:542:b916:c48f with SMTP id t17-20020a056a0021d100b00542b916c48fmr13625403pfj.56.1663089482159;
        Tue, 13 Sep 2022 10:18:02 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id z27-20020aa79e5b000000b0053e5b905843sm796474pfq.203.2022.09.13.10.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 10:18:01 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, Nadav Amit <namit@vmware.com>
Subject: [PATCH 2/3] vmw_balloon: exit if initalization fails
Date:   Tue, 13 Sep 2022 02:43:05 -0700
Message-Id: <20220913094306.317734-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913094306.317734-1-namit@vmware.com>
References: <20220913094306.317734-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

In certain VMware hypervisor variants the balloon might not be
supported. In such cases initialization would fail, but resources would
keep being unnecessarily wasted. The balloon driver would retry
reinitialization every second for no reason.

Initialize the balloon once during init, before starting the worker. If
initialization fails, put out a message and fail gracefully.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/misc/vmw_balloon.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 7fa91983c567..762442b9ece8 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1416,7 +1416,7 @@ static void vmballoon_pop(struct vmballoon *b)
  * is not  empty) and then restarting protocol. This operation normally
  * happens when host responds with VMW_BALLOON_ERROR_RESET to a command.
  */
-static void vmballoon_reset(struct vmballoon *b)
+static int vmballoon_reset(struct vmballoon *b)
 {
 	int error;
 
@@ -1427,11 +1427,13 @@ static void vmballoon_reset(struct vmballoon *b)
 	/* free all pages, skipping monitor unlock */
 	vmballoon_pop(b);
 
-	if (vmballoon_send_start(b, VMW_BALLOON_CAPABILITIES))
+	error = vmballoon_send_start(b, VMW_BALLOON_CAPABILITIES);
+	if (error)
 		goto unlock;
 
 	if ((b->capabilities & VMW_BALLOON_BATCHED_CMDS) != 0) {
-		if (vmballoon_init_batching(b)) {
+		error = vmballoon_init_batching(b);
+		if (error) {
 			/*
 			 * We failed to initialize batching, inform the monitor
 			 * about it by sending a null capability.
@@ -1448,8 +1450,7 @@ static void vmballoon_reset(struct vmballoon *b)
 	vmballoon_stats_gen_inc(b, VMW_BALLOON_STAT_RESET);
 	WRITE_ONCE(b->reset_required, false);
 
-	error = vmballoon_vmci_init(b);
-	if (error)
+	if (vmballoon_vmci_init(b))
 		pr_err_once("failed to initialize vmci doorbell\n");
 
 	if (vmballoon_send_guest_id(b))
@@ -1457,6 +1458,7 @@ static void vmballoon_reset(struct vmballoon *b)
 
 unlock:
 	up_write(&b->conf_sem);
+	return error;
 }
 
 /**
@@ -1879,6 +1881,23 @@ static int __init vmballoon_init(void)
 	if (x86_hyper_type != X86_HYPER_VMWARE)
 		return -ENODEV;
 
+	INIT_LIST_HEAD(&balloon.huge_pages);
+	spin_lock_init(&balloon.comm_lock);
+	init_rwsem(&balloon.conf_sem);
+	balloon.vmci_doorbell = VMCI_INVALID_HANDLE;
+	balloon.batch_page = NULL;
+	balloon.page = NULL;
+	balloon.reset_required = true;
+
+	/*
+	 * Reset the balloon to check that it is indeed supported.
+	 */
+	error = vmballoon_reset(&balloon);
+	if (error) {
+		pr_err("memory ballooning is disabled");
+		goto fail;
+	}
+
 	INIT_DELAYED_WORK(&balloon.dwork, vmballoon_work);
 
 	error = vmballoon_register_shrinker(&balloon);
@@ -1892,14 +1911,6 @@ static int __init vmballoon_init(void)
 	balloon_devinfo_init(&balloon.b_dev_info);
 	vmballoon_compaction_init(&balloon);
 
-	INIT_LIST_HEAD(&balloon.huge_pages);
-	spin_lock_init(&balloon.comm_lock);
-	init_rwsem(&balloon.conf_sem);
-	balloon.vmci_doorbell = VMCI_INVALID_HANDLE;
-	balloon.batch_page = NULL;
-	balloon.page = NULL;
-	balloon.reset_required = true;
-
 	queue_delayed_work(system_freezable_wq, &balloon.dwork, 0);
 
 	vmballoon_debugfs_init(&balloon);
-- 
2.25.1

