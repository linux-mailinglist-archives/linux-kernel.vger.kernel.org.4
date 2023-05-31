Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A39717640
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjEaFfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjEaFfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:35:03 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC8D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 22:34:59 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230531053456epoutp03d815c8d33b765eb034fb1833a94f3af2~kI5f-rAYu2723327233epoutp03g
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:34:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230531053456epoutp03d815c8d33b765eb034fb1833a94f3af2~kI5f-rAYu2723327233epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685511296;
        bh=+16vfJ5Bn8xEGxuXks11ltd3vz3tHtDb38SE44PJeBY=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=sSVh/ztd42YqrpKTnNZqZAMLL8pc+aMAyzRm6P6smJB0a3Z8KiV0zdEiJEzRTCLj4
         bVJbvcjKr1wk238SMX/qHLWwLty99xG760dNW+CtqlIRkxk1ZUDW/B3KSLBhbMWXux
         jsLn2/chp9nYP5UJoDJ0HmZfkTtGjNij+4BTFoMs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230531053455epcas2p1e66a20c7aefd62da1db7c3aafb6bc474~kI5fu9Syo2585125851epcas2p1X;
        Wed, 31 May 2023 05:34:55 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QWHyl1VcPz4x9QG; Wed, 31 May
        2023 05:34:55 +0000 (GMT)
X-AuditID: b6c32a47-157fd70000001ce0-e5-6476dc7fb544
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.B0.07392.F7CD6746; Wed, 31 May 2023 14:34:55 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2] scsi: ufs: core: Do not open code SZ_x
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230531051713.2080-1-avri.altman@wdc.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230531053454epcms2p3f1905b079d3b624cf4e8d7c536690ed8@epcms2p3>
Date:   Wed, 31 May 2023 14:34:54 +0900
X-CMS-MailID: 20230531053454epcms2p3f1905b079d3b624cf4e8d7c536690ed8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmhW79nbIUg12XOSxe/rzKZnHwYSeL
        xctDmhaPbj9jtFg1Mc/i8q45bBbd13ewWSw//o/JYunWm4wOnB4PDm1m8Wg5uZ/F4/v6DjaP
        j09vsXj0bVnF6PF5k5xH+4FupgD2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sL
        cyWFvMTcVFslF58AXbfMHKDDlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6
        xYm5xaV56Xp5qSVWhgYGRqZAhQnZGf93tDIXLJWoeN88ma2B8bxwFyMnh4SAicTl7c/ZQWwh
        gR2MEl87NLoYOTh4BQQl/u4AKxEWsJPoebGKBaJESaJr4VZmiLiBxLrpe8BsNgE9iSm/7zB2
        MXJxiAhMYpTYuHQaG4jDLHCcUeJ40zVGiGW8EjPan7JA2NIS25dvBYtzClhI/Hm6mg0iriHx
        Y1kvM4QtKnFz9Vt2GPv9sflQc0QkWu+dhaoRlHjwczdUXFKi9cxWqDn1Eq3vT7GDHCEhMIFR
        ovHYH6hB+hLXOjayQHzpK9G3yRMkzCKgKvFm/h12kLCEgIvEhGciIGFmAXmJ7W/nMIOEmQU0
        Jdbv0oeoUJY4cosFooJPouPwX3aYBxs2/sbK3jHvCROErSbxaMEW1gmMyrMQAT0Lya5ZCLsW
        MDKvYhRLLSjOTU8tNiowhkdtcn7uJkZwCtVy38E44+0HvUOMTByMhxglOJiVRHhtE4tThHhT
        EiurUovy44tKc1KLDzGaAj05kVlKNDkfmMTzSuINTSwNTMzMDM2NTA3MlcR5pW1PJgsJpCeW
        pGanphakFsH0MXFwSjUwbVrKOX3f5BmWtXtOpzM3v92ZmTk/Jajkjvoz7rtyLp9+ps1Zznrn
        sf2j1H/zreZ9naL+3n7NtD83FtcL+fw86LBhBftO90WJn8LmNHDF5rpIC8XwvtRcMcl8hu/f
        rIi04tbdq46UzM6YbxWz2Z75te6XEsG2ozu/+jsc+1d6ViR4WZyBfDNHhfL3G//Zl7P82vhf
        bFfjB4WILRLuem1sl98e6z83oUfu0d/6VY+dD6WviLKub3XfNivm+Ykd0770zhB4Y+vmsOlm
        8q759dIrdJbwiYo9eLCcy6Ku18iy2nWDIVf1imPntOf22/nU83P1XzO1//H9YQhrT+fmxK4b
        D43+PFwb+2DfjClnHJ8K/1RiKc5INNRiLipOBACXsrIEKgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230531051800epcas2p4479389ea7e7da9a60180cbac0e865450
References: <20230531051713.2080-1-avri.altman@wdc.com>
        <CGME20230531051800epcas2p4479389ea7e7da9a60180cbac0e865450@epcms2p3>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>v1 -> v2: Attend UTMRD as well
>
>A tad cleanup - No functional change.
>
>Signed-off-by: Avri Altman <avri.altman@wdc.com>
>Reviewed-by: Bean Huo <beanhuo@micron.com>
>Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>

Reviewed-by: Keoseong Park <keosung.park@samsung.com>

Best Regards,
Keoseong

>---
> drivers/ufs/core/ufshcd.c | 10 +++++-----
> include/ufs/ufshci.h      |  2 +-
> 2 files changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>index fdf5073c7c6c..10a10f8f0bd1 100644
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
> 		dev_err(hba->dev,
> 			"Transfer Descriptor Memory allocation failed\n");
> 		goto out;
>@@ -3797,7 +3797,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
> 						    &hba->utmrdl_dma_addr,
> 						    GFP_KERNEL);
> 	if (!hba->utmrdl_base_addr ||
>-	    WARN_ON(hba->utmrdl_dma_addr & (1024 - 1))) {
>+	    WARN_ON(hba->utmrdl_dma_addr & (SZ_1K - 1))) {
> 		dev_err(hba->dev,
> 		"Task Management Descriptor Memory allocation failed\n");
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
