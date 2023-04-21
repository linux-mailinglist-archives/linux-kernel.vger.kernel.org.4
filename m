Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5729E6EA1FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjDUCvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjDUCvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:51:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF996A4B;
        Thu, 20 Apr 2023 19:51:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso2391515b3a.3;
        Thu, 20 Apr 2023 19:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045473; x=1684637473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmaMAKRoH6NBJdRRp6jUqykqTsJRakI7Ct89GV+DOWM=;
        b=fyAXCpyzGql2Wiskio6/QvXSwDZANZf0aIFTTvDyv6iBT8ihou/1lc/E6vC3XoW1jN
         8RMPaUOGEXxnKfWrLjFPhgwSkfcz6tYV57+iXnIHOScYfYIYV9UmvaZ9hw/hImSrP2qg
         GXuZ1ipRmDeb+uUAVZkDAcEIHtubeaEFky5VRoAeVHfaQuGfDPrXTX0NQDfDWIWAfr5s
         72ukvBfhXHbmcCI/7hLEfRTkYcH8+aApWnPD8gBqKRSEmJYRloXlDCIvGs+l77Jppl8t
         G8NDgfDTh14VTU5Q52df3MKfV+WmAycbjoBCuxkdbWWgBYzDa/vBoDh05MBCxTgszo8e
         1J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045473; x=1684637473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmaMAKRoH6NBJdRRp6jUqykqTsJRakI7Ct89GV+DOWM=;
        b=GA2w5gniAXUOEs0Q1Un6kp+RsR9b5mfKjMwpK5uAnO3Ly1aFP1xT5eAtBz1WBtVbmf
         OY9X9HLYDDOh7uNyLQaIkhvM1UXkA50g1p7XfarQbIUPPORbYAQa9bUh7VCLUn7z8GOm
         EKPtGFjOeRtKsC513vAOs5UrNbQU9js+4RdZg4BEMc1zb9CEefEqIapWYi++uqHSmvHP
         vEu0p8USHy0jZ7Iz5h5XQItIDXzt8asK0bEf77v5mJ6JD1Jqghft4Sjhzi30GPTcGfgu
         idU7rLEXJ4wQ2Ms8qlDoJzFhhzUNdEr1dWhPOdqH52zg7oZwW38JtAtLBQLtT46aCM9H
         x+XA==
X-Gm-Message-State: AAQBX9fqndA+8FPPQbOUg2FguRFncFZoAEZXNpmugwyyYSeZYjIAVZcC
        c0H1bsU9BH2ddZmTxHNMKCg=
X-Google-Smtp-Source: AKy350aGNEX0ieLVrb97DAciHF84hDmwzVzOAiLs9ow4+zVE2O7X3YuGt+MX59GgCIEAxZs11O1Fmg==
X-Received: by 2002:a05:6a00:1796:b0:634:7ba3:d140 with SMTP id s22-20020a056a00179600b006347ba3d140mr4929709pfg.15.1682045473354;
        Thu, 20 Apr 2023 19:51:13 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id o70-20020a62cd49000000b0062dcf5c01f9sm1916148pfg.36.2023.04.20.19.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:51:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 12/22] scsi: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:36 -1000
Message-Id: <20230421025046.4008499-13-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421025046.4008499-1-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BACKGROUND
==========

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary.

WHAT TO LOOK FOR
================

The conversions are from

  alloc_workqueue(WQ_UNBOUND | flags, 1, args..)

to

  alloc_ordered_workqueue(flags, args...)

which don't cause any functional changes. If you know that fully ordered
execution is not ncessary, please let me know. I'll drop the conversion and
instead add a comment noting the fact to reduce confusion while conversion
is in progress.

If you aren't fully sure, it's completely fine to let the conversion
through. The behavior will stay exactly the same and we can always
reconsider later.

As there are follow-up workqueue core changes, I'd really appreciate if the
patch can be routed through the workqueue tree w/ your acks. Thanks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/NCR5380.c  |  5 ++---
 drivers/scsi/hosts.c    | 12 ++++++------
 drivers/scsi/libiscsi.c |  5 ++---
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index ca85bddb582b..b18dd4591492 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -415,9 +415,8 @@ static int NCR5380_init(struct Scsi_Host *instance, int flags)
 	hostdata->flags = flags;
 
 	INIT_WORK(&hostdata->main_task, NCR5380_main);
-	hostdata->work_q = alloc_workqueue("ncr5380_%d",
-	                        WQ_UNBOUND | WQ_MEM_RECLAIM,
-	                        1, instance->host_no);
+	hostdata->work_q = alloc_ordered_workqueue("ncr5380_%d",
+	                        WQ_MEM_RECLAIM, instance->host_no);
 	if (!hostdata->work_q)
 		return -ENOMEM;
 
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 9b6fbbe15d92..30bf9f49ca6c 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -294,9 +294,9 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	if (shost->transportt->create_work_queue) {
 		snprintf(shost->work_q_name, sizeof(shost->work_q_name),
 			 "scsi_wq_%d", shost->host_no);
-		shost->work_q = alloc_workqueue("%s",
-			WQ_SYSFS | __WQ_LEGACY | WQ_MEM_RECLAIM | WQ_UNBOUND,
-			1, shost->work_q_name);
+		shost->work_q = alloc_ordered_workqueue("%s",
+			WQ_SYSFS | __WQ_LEGACY | WQ_MEM_RECLAIM,
+			shost->work_q_name);
 
 		if (!shost->work_q) {
 			error = -EINVAL;
@@ -510,9 +510,9 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 		goto fail;
 	}
 
-	shost->tmf_work_q = alloc_workqueue("scsi_tmf_%d",
-					WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS,
-					   1, shost->host_no);
+	shost->tmf_work_q = alloc_ordered_workqueue("scsi_tmf_%d",
+						    WQ_MEM_RECLAIM | WQ_SYSFS,
+						    shost->host_no);
 	if (!shost->tmf_work_q) {
 		shost_printk(KERN_WARNING, shost,
 			     "failed to create tmf workq\n");
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 127f3d7f19dc..d0eba590dc69 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -2907,9 +2907,8 @@ struct Scsi_Host *iscsi_host_alloc(struct scsi_host_template *sht,
 	ihost = shost_priv(shost);
 
 	if (xmit_can_sleep) {
-		ihost->workq = alloc_workqueue("iscsi_q_%d",
-			WQ_SYSFS | __WQ_LEGACY | WQ_MEM_RECLAIM | WQ_UNBOUND,
-			1, shost->host_no);
+		ihost->workq = alloc_ordered_workqueue("iscsi_q_%d",
+			WQ_SYSFS | __WQ_LEGACY | WQ_MEM_RECLAIM, shost->host_no);
 		if (!ihost->workq)
 			goto free_host;
 	}
-- 
2.40.0

