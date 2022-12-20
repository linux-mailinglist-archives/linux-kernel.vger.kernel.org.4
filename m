Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24A7651A02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 05:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiLTEcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 23:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiLTEcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 23:32:01 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B08ADEBB;
        Mon, 19 Dec 2022 20:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671510650; bh=Pd2bhe+fKKozvBANvXUmkTJyESzS/Vjprnau3vi1WbQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=Qyw1LczV8K7epGRqriU7yiO/8uiTwMnVaG3CGjHfR5J2zrr4K8ybkck6WkH2xiDod
         B1Sv2XNz+2MLdYUwkig2dulsI7orc8eX/jzJwieyMU3pnvKEZJR6FnPZC1aeGN7ywa
         ZhOHNujjynnENwTxQX83KWtezroa3yY78uF1gTiE=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 20 Dec 2022 05:30:50 +0100 (CET)
X-EA-Auth: 7lru7OgZVr6328tJ8hGVK2ZkgJxij7z3PBMvOd+w5u+OJBQcOhDXFlhtYbJGQRyNGMX8wfda81tJSaBGkDiKCdwDz9eHxWXL
Date:   Tue, 20 Dec 2022 10:00:45 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: [PATCH] scsi: libfc: Use refcount_* APIs for reference count
 management
Message-ID: <Y6E6dVcdHk2zK+/1@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic_t API based object reference counter management is prone to
counter value overflows, object use-after-free issues and to return
puzzling values. The improved refcount_t APIs are designed to address
these known issues with atomic_t reference counter management. This
white paper [1] has detailed reasons for moving from atomic_t to
refcount_t APIs. Hence replace the atomic_* based implementation by its
refcount_* based equivalent.
The issue is identified using atomic_as_refcounter.cocci Coccinelle
semantic patch script.

	[1] https://arxiv.org/pdf/1710.06175.pdf

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Note: The proposal is compile tested only.

 drivers/scsi/libfc/fc_exch.c | 10 +++++-----
 include/scsi/libfc.h         |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/libfc/fc_exch.c b/drivers/scsi/libfc/fc_exch.c
index 1d91c457527f..1c49fddb65e3 100644
--- a/drivers/scsi/libfc/fc_exch.c
+++ b/drivers/scsi/libfc/fc_exch.c
@@ -246,7 +246,7 @@ static const char *fc_exch_rctl_name(unsigned int op)
  */
 static inline void fc_exch_hold(struct fc_exch *ep)
 {
-	atomic_inc(&ep->ex_refcnt);
+	refcount_inc(&ep->ex_refcnt);
 }

 /**
@@ -312,7 +312,7 @@ static void fc_exch_release(struct fc_exch *ep)
 {
 	struct fc_exch_mgr *mp;

-	if (atomic_dec_and_test(&ep->ex_refcnt)) {
+	if (refcount_dec_and_test(&ep->ex_refcnt)) {
 		mp = ep->em;
 		if (ep->destructor)
 			ep->destructor(&ep->seq, ep->arg);
@@ -329,7 +329,7 @@ static inline void fc_exch_timer_cancel(struct fc_exch *ep)
 {
 	if (cancel_delayed_work(&ep->timeout_work)) {
 		FC_EXCH_DBG(ep, "Exchange timer canceled\n");
-		atomic_dec(&ep->ex_refcnt); /* drop hold for timer */
+		refcount_dec(&ep->ex_refcnt); /* drop hold for timer */
 	}
 }

@@ -1897,7 +1897,7 @@ static void fc_exch_reset(struct fc_exch *ep)
 	ep->state |= FC_EX_RST_CLEANUP;
 	fc_exch_timer_cancel(ep);
 	if (ep->esb_stat & ESB_ST_REC_QUAL)
-		atomic_dec(&ep->ex_refcnt);	/* drop hold for rec_qual */
+		refcount_dec(&ep->ex_refcnt);	/* drop hold for rec_qual */
 	ep->esb_stat &= ~ESB_ST_REC_QUAL;
 	sp = &ep->seq;
 	rc = fc_exch_done_locked(ep);
@@ -2332,7 +2332,7 @@ static void fc_exch_els_rrq(struct fc_frame *fp)
 	 */
 	if (ep->esb_stat & ESB_ST_REC_QUAL) {
 		ep->esb_stat &= ~ESB_ST_REC_QUAL;
-		atomic_dec(&ep->ex_refcnt);	/* drop hold for rec qual */
+		refcount_dec(&ep->ex_refcnt);	/* drop hold for rec qual */
 	}
 	if (ep->esb_stat & ESB_ST_COMPLETE)
 		fc_exch_timer_cancel(ep);
diff --git a/include/scsi/libfc.h b/include/scsi/libfc.h
index 6e29e1719db1..ce65149b300c 100644
--- a/include/scsi/libfc.h
+++ b/include/scsi/libfc.h
@@ -432,7 +432,7 @@ struct fc_seq {
  */
 struct fc_exch {
 	spinlock_t	    ex_lock;
-	atomic_t	    ex_refcnt;
+	refcount_t	    ex_refcnt;
 	enum fc_class	    class;
 	struct fc_exch_mgr  *em;
 	struct fc_exch_pool *pool;
--
2.34.1



