Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F4164AEAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 05:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiLMEkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 23:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiLMEkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 23:40:35 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2A01E703
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 20:40:31 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so2260935pjd.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 20:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PvAuNHdyTYVPB3vrsfzCI7cTfJlHkjbbq4SSgg1PDaI=;
        b=dKsekFiEKxARrlA3SN/WkeGhTMYcxFkia9Pk9vcx2R9Guf6lTzCNhlk1IQ1NklobIE
         gE45FJ55u51KAt5K7DO2DFgaaGvNByDwqzO8jW8/LfxgQTXc9R4rHH/i5ogIXTBrYMcu
         ZE3wF33elduQzDE0urGMsqW/yMrUdFRoISZmwJi3KeOSmyFtCQYJyWGieRjrSUEyuxiD
         V9Q74VD0zzqbyu1XgahfNmSHq+rWG01loIzk0Dbf08c6+nrbWQ2bhD6AZTF6PwExU3TO
         xXf8mSBeFfQrPJivyu3Dz+2yScarJJt2OZY1p6vo+dgN47Hx0uq7+ccB8/95TwGCf1b+
         MfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvAuNHdyTYVPB3vrsfzCI7cTfJlHkjbbq4SSgg1PDaI=;
        b=WUO25jkFaMZG/R4lP0aBs/kZF1WXWK/PRYpN9nKSOBa38wFGodPmbQTbvdlUeWpF6x
         KH9MA7WDu6FQAaxL5fEi3WML7Vt00PTnfaPiMvfgSI0ev+tRTw9lW63Dxq467FS8wAlN
         Nr2OQZ3HBFNlMSFQLLcj8B6xvhPhKt4EP7K32uG/4d97iAkfn7ZX3cDbfqkEalpgaijy
         bAPb79kWADsw3nZDR+jzo8PMeoB+SWWLEPs9BBrv7wXgng2vAbevriejbSo5/5+mr5hD
         J0gMh8UNfSDWaNVDfUgj7EBJQiNdcvyEWK5yaGKoSItp/dEe5rLLPK3i+5iXboHTniVC
         DeWA==
X-Gm-Message-State: ANoB5pnJx/bIixHMkj0ZWQYN0oOoj25qwmNtzyiNQwMX7RqqH5XeGvoS
        gYHuqSpYOCeof6vFPqHrkoGiH6WDtrE=
X-Google-Smtp-Source: AA0mqf6oiYJeYsf7ZRREZDl7lAA5808CqNV3DZumbsi78C6oGQZS8dGRgzJ2Z88CFJy7Isdh/eqK2w==
X-Received: by 2002:a17:90b:1003:b0:219:b04c:db39 with SMTP id gm3-20020a17090b100300b00219b04cdb39mr19116045pjb.4.1670906430637;
        Mon, 12 Dec 2022 20:40:30 -0800 (PST)
Received: from den-workstation.fareast.nevint.com ([140.206.46.75])
        by smtp.gmail.com with ESMTPSA id t6-20020a6549c6000000b00478a3079b7esm5823950pgs.19.2022.12.12.20.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 20:40:30 -0800 (PST)
From:   Richard Clark <richard.xnu.clark@gmail.com>
To:     jiangshanlai@gmail.com, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Richard Clark <richard.xnu.clark@gmail.com>
Subject: [PATCH] workqueue: Add a new flag to spot the potential UAF error
Date:   Tue, 13 Dec 2022 12:39:36 +0800
Message-Id: <20221213043936.6345-1-richard.xnu.clark@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Currently if the user queues a new work item unintentionally
into a wq after the destroy_workqueue(wq), the work still can
be queued and scheduled without any noticeable kernel message
before the end of a RCU grace period.

As a debug-aid facility, this commit adds a new flag
__WQ_DESTROYING to spot that issue by triggering a kernel WARN
message.

Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
---
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a0143dd24430..ac551b8ee7d9 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -335,6 +335,7 @@ enum {
 	 */
 	WQ_POWER_EFFICIENT	= 1 << 7,
 
+	__WQ_DESTROYING		= 1 << 15, /* internal: workqueue is destroying */
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 39060a5d0905..30dc6869b3fd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1433,9 +1433,13 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	lockdep_assert_irqs_disabled();
 
 
-	/* if draining, only works from the same workqueue are allowed */
-	if (unlikely(wq->flags & __WQ_DRAINING) &&
-	    WARN_ON_ONCE(!is_chained_work(wq)))
+	/*
+	 * For a draining wq, only works from the same workqueue are
+	 * allowed. The __WQ_DESTROYING helps to spot the issue that
+	 * queues a new work item to a wq after destroy_workqueue(wq).
+	 */
+	if (unlikely(wq->flags & (__WQ_DESTROYING | __WQ_DRAINING)
+		&& WARN_ON_ONCE(!is_chained_work(wq))))
 		return;
 	rcu_read_lock();
 retry:
@@ -4414,6 +4418,11 @@ void destroy_workqueue(struct workqueue_struct *wq)
 	 */
 	workqueue_sysfs_unregister(wq);
 
+	/* mark the workqueue destruction is in progress */
+	mutex_lock(&wq->mutex);
+	wq->flags |= __WQ_DESTROYING;
+	mutex_unlock(&wq->mutex);
+
 	/* drain it before proceeding with destruction */
 	drain_workqueue(wq);
 
-- 
2.37.2

