Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262E671632C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjE3OIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjE3OIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:08:20 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DEA102
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:08:15 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230530140811epoutp02a8bda060b35dbef773438f13f4f64558~j8QWFqfSE1775217752epoutp02e
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:08:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230530140811epoutp02a8bda060b35dbef773438f13f4f64558~j8QWFqfSE1775217752epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685455691;
        bh=rf7tS+NmbGO9udzvDmUCm45lU4H36ni9hxNLjBRtmEM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=T8bMg/u8/WTujNzCZbPlPIPWzwKog8V11ho4CK2svhP+qEvaSwR7diDD3NO7ZvOgA
         dgW8/CWbxTBM3dj4TJ7rVv6QAwJQsdN+UXKo1cVWzTz8kVJgbLJ9vu5q67+kO1YKGe
         8+uleTHQRDcjSN4vedgvC9/NFv2qaF5gusM8HmiU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230530140810epcas2p1497def228476a69cef70c83ef2563581~j8QVHsNzf2501025010epcas2p1_;
        Tue, 30 May 2023 14:08:10 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QVvPP5fhlz4x9Pv; Tue, 30 May
        2023 14:08:09 +0000 (GMT)
X-AuditID: b6c32a48-c3ff87000000acbc-2a-6476034932ae
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.8A.44220.94306746; Tue, 30 May 2023 23:08:09 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] scsi: ufs: core: Do not open code SZ_x
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230530075033.11006-1-avri.altman@wdc.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230530140809epcms2p3aff4826012218b0e937e02aa3e30bec2@epcms2p3>
Date:   Tue, 30 May 2023 23:08:09 +0900
X-CMS-MailID: 20230530140809epcms2p3aff4826012218b0e937e02aa3e30bec2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTQteTuSzFoOujjsXLn1fZLF4e0rR4
        dPsZo8WqiXkWl3fNYbPovr6DzWL58X9MDuweDw5tZvH4+PQWi0ffllWMHp83yXm0H+hmCmCN
        yrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpCSaEs
        MacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd
        cWDuS6aCvSIV+74fZGtgPCbQxcjJISFgIrH6eCNLFyMHh5DADkaJ6ZEgJq+AoMTfHcIgprCA
        tcS9z+ogxUICShJdC7cyg9jCAgYS66bvAbPZBPQkpvy+w9jFyMUhIjCJUWLj0mlsIAlmgTqJ
        3XP+sEFs4pWY0f6UBcKWlti+fCsjiM0pYClx+8V0Zoi4hsSPZb1QtqjEzdVv2WHs98fmM0LY
        IhKt985C1QhKPPi5GyouKdF6ZivUrnqJ1ven2EEOkhCYwCjReOwP1CB9iWsdG8GO4BXwlbh7
        5jtYnEVAVeLlsmdQQ10kPk6bwwTxgLzE9rdzmEEBwSygKbF+lz6IKSGgLHHkFgtEBZ9Ex+G/
        7DAvNmz8jZW9Y94TJghbTeLRgi2sExiVZyECehaSXbMQdi1gZF7FKJZaUJybnlpsVGACj9nk
        /NxNjODEqOWxg3H22w96hxiZOBgPMUpwMCuJ8NomFqcI8aYkVlalFuXHF5XmpBYfYjQF+nIi
        s5Rocj4wNeeVxBuaWBqYmJkZmhuZGpgrifN+7FBOERJITyxJzU5NLUgtgulj4uCUamBqM/LQ
        O3Vw6ccdc324be+k2KaXTNgX+zvVy+ztJf1lMV9MRQ7+XePxmGXu3aO7TifXnJD4v/tJSVzT
        83U7pXZ9uSF1QvPtlfaGiSGpT8z2NX/MLGt1i6i36NP+bMt57VjVdd0ZPxepF2d5+C/XvrzL
        cKfH4g0//+pf+NL8bE9F5OmZ+iXZDauXbVvN4zVDcu8Uvv486f39V5PO1wbOfJr/9tKOwEt+
        t5sOzi9ZdthxtcSD/Fb1nzwGy586T8jafKRDYSLH5+N7T/ct7fLW8DskqqgmLfV0pzVj0I1l
        K1Zefll831ljztKL6SutF9w+xn+ZKdtlZalcwvG85hdRXuEvGn4m3jvAFrrwkMCbHaxcj5VY
        ijMSDbWYi4oTARhRSPEVBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230530075120epcas2p10917546a2e01da2a17c34b7460f85eef
References: <20230530075033.11006-1-avri.altman@wdc.com>
        <CGME20230530075120epcas2p10917546a2e01da2a17c34b7460f85eef@epcms2p3>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avri,

>A tad cleanup - No functional change.
>
>Signed-off-by: Avri Altman <avri.altman@wdc.com>
>---
> drivers/ufs/core/ufshcd.c | 8 ++++----
> include/ufs/ufshci.h      | 2 +-
> 2 files changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>index fdf5073c7c6c..1f206bd453cf 100644
>--- a/drivers/ufs/core/ufshcd.c
>+++ b/drivers/ufs/core/ufshcd.c
>@@ -2519,7 +2519,7 @@ static void ufshcd_sgl_to_prdt(struct ufs_hba *hba, struct ufshcd_lrb *lrbp, int
> 			 * 11b to indicate Dword granularity. A value of '3'
> 			 * indicates 4 bytes, '7' indicates 8 bytes, etc."
> 			 */
>-			WARN_ONCE(len > 256 * 1024, "len = %#x\n", len);
>+			WARN_ONCE(len > SZ_256K, "len = %#x\n", len);
> 			prd->size = cpu_to_le32(len - 1);
> 			prd->addr = cpu_to_le64(sg->dma_address);
> 			prd->reserved = 0;
>@@ -3765,7 +3765,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
> 
> 	/*
> 	 * Allocate memory for UTP Transfer descriptors
>-	 * UFSHCI requires 1024 byte alignment of UTRD
>+	 * UFSHCI requires 1KB alignment of UTRD
> 	 */
> 	utrdl_size = (sizeof(struct utp_transfer_req_desc) * hba->nutrs);
> 	hba->utrdl_base_addr = dmam_alloc_coherent(hba->dev,
>@@ -3773,7 +3773,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
> 						   &hba->utrdl_dma_addr,
> 						   GFP_KERNEL);
> 	if (!hba->utrdl_base_addr ||
>-	    WARN_ON(hba->utrdl_dma_addr & (1024 - 1))) {
>+	    WARN_ON(hba->utrdl_dma_addr & (SZ_1K - 1))) {

How about changing the UTMRD part inside ufshcd_memory_alloc() as well?

Best Regards,
Keoseong

> 		dev_err(hba->dev,
> 			"Transfer Descriptor Memory allocation failed\n");
> 		goto out;
>@@ -8760,7 +8760,7 @@ static const struct scsi_host_template ufshcd_driver_template = {
> 	.cmd_per_lun		= UFSHCD_CMD_PER_LUN,
> 	.can_queue		= UFSHCD_CAN_QUEUE,
> 	.max_segment_size	= PRDT_DATA_BYTE_COUNT_MAX,
>-	.max_sectors		= (1 << 20) / SECTOR_SIZE, /* 1 MiB */
>+	.max_sectors		= SZ_1M / SECTOR_SIZE,
> 	.max_host_blocked	= 1,
> 	.track_queue_depth	= 1,
> 	.skip_settle_delay	= 1,
>diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
>index 11424bb03814..db2d5db5c88e 100644
>--- a/include/ufs/ufshci.h
>+++ b/include/ufs/ufshci.h
>@@ -453,7 +453,7 @@ enum {
> };
> 
> /* The maximum length of the data byte count field in the PRDT is 256KB */
>-#define PRDT_DATA_BYTE_COUNT_MAX	(256 * 1024)
>+#define PRDT_DATA_BYTE_COUNT_MAX	SZ_256K
> /* The granularity of the data byte count field in the PRDT is 32-bit */
> #define PRDT_DATA_BYTE_COUNT_PAD	4
> 
>-- 
>2.40.0
>
