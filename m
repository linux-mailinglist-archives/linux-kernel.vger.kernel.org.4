Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9414C666305
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjAKSrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjAKSrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:47:47 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F8E3C727;
        Wed, 11 Jan 2023 10:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673462856; bh=jopGRroUzLR4tIlqsfXJiaUefPtk1/CDxZDkEHglVwI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=bmEem5USpbJZI5DkvWTiaHiU3SWR8vvmliR2hbKL+uXKkbSl6uhMI/otwTW1cRPdB
         DxWgJk6+bntH4t4s7UWJuwTtFQAqlNzTK2vj/JCKoSXLzFtONf94n5vrzvQJtD6GuI
         haXjY8+F0x51uHKovMUcgFQGF6nLfixnEuVOxFrk=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed, 11 Jan 2023 19:47:31 +0100 (CET)
X-EA-Auth: sME8AV4L7mHKGVO2EY/d0CLsKyWhtWFXdco2VEzHxLa+vDKwbgQivgHsMLs+dDkIdDhqk4I+68aGalNmD9TArn+bLadrCNj7
Date:   Thu, 12 Jan 2023 00:17:27 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH] scsi: megaraid_sas: Use a variable for repeated mem_size
 computation
Message-ID: <Y78EP0Fznl8h4XVs@ubun2204.myguest.virtualbox.org>
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

Use a variable to upfront compute memory size to be allocated,
instead of repeatedly computing it at different instructions.
The reduced instruction length also allows to tidy up the code.
Issue identified using the array_size_dup Coccinelle semantic
patch.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index fe70f8f11435..efb25af80664 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -5287,6 +5287,7 @@ int
 megasas_alloc_fusion_context(struct megasas_instance *instance)
 {
 	struct fusion_context *fusion;
+	size_t sz;
 
 	instance->ctrl_context = kzalloc(sizeof(struct fusion_context),
 					 GFP_KERNEL);
@@ -5298,15 +5299,13 @@ megasas_alloc_fusion_context(struct megasas_instance *instance)
 
 	fusion = instance->ctrl_context;
 
-	fusion->log_to_span_pages = get_order(MAX_LOGICAL_DRIVES_EXT *
-					      sizeof(LD_SPAN_INFO));
+	sz = array_size(MAX_LOGICAL_DRIVES_EXT, sizeof(LD_SPAN_INFO));
+	fusion->log_to_span_pages = get_order(sz);
 	fusion->log_to_span =
 		(PLD_SPAN_INFO)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 						fusion->log_to_span_pages);
 	if (!fusion->log_to_span) {
-		fusion->log_to_span =
-			vzalloc(array_size(MAX_LOGICAL_DRIVES_EXT,
-					   sizeof(LD_SPAN_INFO)));
+		fusion->log_to_span = vzalloc(sz);
 		if (!fusion->log_to_span) {
 			dev_err(&instance->pdev->dev, "Failed from %s %d\n",
 				__func__, __LINE__);
@@ -5314,15 +5313,13 @@ megasas_alloc_fusion_context(struct megasas_instance *instance)
 		}
 	}
 
-	fusion->load_balance_info_pages = get_order(MAX_LOGICAL_DRIVES_EXT *
-		sizeof(struct LD_LOAD_BALANCE_INFO));
+	sz = array_size(MAX_LOGICAL_DRIVES_EXT, sizeof(struct LD_LOAD_BALANCE_INFO));
+	fusion->load_balance_info_pages = get_order(sz);
 	fusion->load_balance_info =
 		(struct LD_LOAD_BALANCE_INFO *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 		fusion->load_balance_info_pages);
 	if (!fusion->load_balance_info) {
-		fusion->load_balance_info =
-			vzalloc(array_size(MAX_LOGICAL_DRIVES_EXT,
-					   sizeof(struct LD_LOAD_BALANCE_INFO)));
+		fusion->load_balance_info = vzalloc(sz);
 		if (!fusion->load_balance_info)
 			dev_err(&instance->pdev->dev, "Failed to allocate load_balance_info, "
 				"continuing without Load Balance support\n");
-- 
2.34.1



