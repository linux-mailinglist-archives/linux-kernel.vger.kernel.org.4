Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7545067F732
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbjA1KkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjA1KkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:40:18 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49F7643D;
        Sat, 28 Jan 2023 02:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674902395; bh=Y+8/fOapSSmWLEqg7lJpPnADv5hXIKr7UJtI9ZjvAFw=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=XIkh+hL8vbalP7MRdL/ZgaZpjd2pQ/iG9Qd+TQ/VsdiMWHQPbmKvPzgf0CgNYQdSt
         wNBH8aPDPOBddzN1/7mOHvJ50H1TUmt4nj4cFVkgGgSaQBHcFGVm3kMzpVIp7VzJFo
         27l2eqCU/RGvmkPrRveaD5hi+s8nUX5gnt5uAX+o=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 28 Jan 2023 11:39:55 +0100 (CET)
X-EA-Auth: 52l/H8g2NG2HneUKl+/V3mX4LOB9amfBJ2uIMcfD2pL8zpPZriS/JRNd3NsdHCPbnQElAYsYvzFR+pHxWdPk8KRkJkpOlbWm
Date:   Sat, 28 Jan 2023 16:09:51 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH 2/2] scsi: megaraid_sas: Use max helper for comparison and
 assignment
Message-ID: <bf5884a7bd7c1c92497664eb793c99051b81d67a.1674900575.git.drv@mailo.com>
References: <cover.1674900575.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674900575.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code using max() helper macro for logical evaluation and value
assignment.
Proposed change is identified using minmax.cocci semantic patch script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 7fa472ab0b94..4ca9b04e1962 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5993,10 +5993,7 @@ megasas_alloc_irq_vectors(struct megasas_instance *instance)
 			instance->msix_vectors - instance->iopoll_q_count,
 			i, instance->iopoll_q_count);
 
-	if (i > 0)
-		instance->msix_vectors = i;
-	else
-		instance->msix_vectors = 0;
+	instance->msix_vectors = max(i, 0);
 
 	if (instance->smp_affinity_enable)
 		megasas_set_high_iops_queue_affinity_and_hint(instance);
-- 
2.34.1



