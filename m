Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0C66A73F8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCATDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCATDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:03:09 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996E3198F;
        Wed,  1 Mar 2023 11:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677697377; bh=cTE8O833aYzAtBzmtxia0kjyJ2tDBqNX7A/BHU+wHwQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=BIQIMvga/8fS4XjGDpbz4I4R2+p+wh1CXF5dzOTcm97N6LPluhA+h1tuUW3BI4vvt
         iu0dcW2Dka+XhRJnmKoCN84HWW/ySOa1W0MOh0Fw8AYwTrArLjsyXiUvXpvxibdelW
         7ChoapauReauPRGwBY59+6HzRhkU3LfCayEm2oJg=
Received: by b221-1.in.mailobj.net [192.168.90.21] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Wed,  1 Mar 2023 20:02:57 +0100 (CET)
X-EA-Auth: mg8m6pH8EMjB4QW7phrieOJq9PfSRl+dJ/cux7gVD/qyIimpW6+4I5isYtHXYDV/QYVNB1fMXbU5Qh57s8jR9A==
Date:   Thu, 2 Mar 2023 00:32:45 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH RESEND] scsi: libfc: Use refcount_* APIs for reference count
 management
Message-ID: <Y/+hVSSFgeV+yPhY@ubun2204.myguest.virtualbox.org>
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
      Resending the patch for review and feedback.


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



