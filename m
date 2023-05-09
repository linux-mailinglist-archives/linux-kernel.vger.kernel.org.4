Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733AE6FBCAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjEIBu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjEIBuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:50:52 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBCEA5F3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 18:50:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51b603bb360so4798245a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683597041; x=1686189041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNyRxdWCADhD9rUKa2TrMn4tF/rgjlUTD8AJ6N7yTPI=;
        b=rBOB2kT81esTLEMd+gDqzUt84C67pQDXt/JWeZFo0f8IHt9KsY/WzZ6a112t8trmzd
         EuzBz5nZX9viQThMm+m7ZNmLqo10/MGU1PxDfRcnOoI1U49Do/egyLicMs1mkA68bLCE
         habdUM3yEPZ8Qw/fITzRdmec5qQ+WNoER2A1WWyxqPWl/iPkt+fXyLi9xbOsV4Upyi3u
         afdBEyRDazd7wbUqlnW9M/o9fleryQRG2thqB0jHrfrvibbV2zqD8byrPiOzZ5YqTFPO
         IPhNDhA/tI6J4ouzjIGUJDZU3QajxjldnoyLZffyDtbh4F5kRC3AMdEv2B4dGRmCtCwz
         bC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683597041; x=1686189041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iNyRxdWCADhD9rUKa2TrMn4tF/rgjlUTD8AJ6N7yTPI=;
        b=UyRgqKdS0MT3+0ZEodr+QU7nrF1Cweyjl4yrKdfsw08kbW4LRCVNC+hzial+1lTJEc
         qxJCbvFh7W+fa+YU8eExfD5PRVFVsqd8F4zL1zyUQp+V5PpDBgHNxxkONvc5JDelm9jj
         QLOGXc0c5RQpIw9IZnUZP/orhTZ6epF7yn6aKo91QtOHeswiOHtE8of/nn3tKFqzw5fu
         huzu3T/x6y5d/Lyn2eL+UjZYmvEcVVeybVoTfMvbLklq9kHQPg8yxu3YxW0t4vmHBXo7
         McEIJmLVcVRsxAqwlf9CmyK7qXVeH6C4cpmcVcGvgZ2EBhGAi0Yh0HQGH298wHt5y4x9
         vX9A==
X-Gm-Message-State: AC+VfDyuZLGjFH4n4AvEVdLWrelUqeteNfPRMo67BNcRUZLcVuf5+QMg
        irWAmu6jUvkQI+KMRn5zLB0=
X-Google-Smtp-Source: ACHHUZ7nldx8UeT/R4azQMvNmEw7AIvCa83fBwYQtaNq8RV+v9QFejd53ePEVKYVGY1AcFYXmQiTgA==
X-Received: by 2002:a05:6a21:32a0:b0:ff:f2c3:c103 with SMTP id yt32-20020a056a2132a000b000fff2c3c103mr10292465pzb.18.1683597041398;
        Mon, 08 May 2023 18:50:41 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p36-20020a634f64000000b0050f56964426sm145085pgl.54.2023.05.08.18.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:50:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Subject: [PATCH 03/13] dm integrity: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Mon,  8 May 2023 15:50:22 -1000
Message-Id: <20230509015032.3768622-4-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509015032.3768622-1-tj@kernel.org>
References: <20230509015032.3768622-1-tj@kernel.org>
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
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
---
 drivers/md/dm-integrity.c | 4 ++--
 drivers/md/dm.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 31838b13ea54..63ec502fcb12 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4268,10 +4268,10 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 	}
 
 	/*
-	 * If this workqueue were percpu, it would cause bio reordering
+	 * If this workqueue weren't ordered, it would cause bio reordering
 	 * and reduced performance.
 	 */
-	ic->wait_wq = alloc_workqueue("dm-integrity-wait", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+	ic->wait_wq = alloc_ordered_workqueue("dm-integrity-wait", WQ_MEM_RECLAIM);
 	if (!ic->wait_wq) {
 		ti->error = "Cannot allocate workqueue";
 		r = -ENOMEM;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3b694ba3a106..9599d76cc9a9 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -207,7 +207,7 @@ static int __init local_init(void)
 	if (r)
 		return r;
 
-	deferred_remove_workqueue = alloc_workqueue("kdmremove", WQ_UNBOUND, 1);
+	deferred_remove_workqueue = alloc_ordered_workqueue("kdmremove", 0);
 	if (!deferred_remove_workqueue) {
 		r = -ENOMEM;
 		goto out_uevent_exit;
-- 
2.40.1

