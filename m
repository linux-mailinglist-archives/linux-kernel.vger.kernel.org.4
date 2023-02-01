Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F40686D85
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjBAR7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBAR7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:59:45 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E777E4C0F1;
        Wed,  1 Feb 2023 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675274385; x=1706810385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fSSmRj8Su784FKIaxCReilXY880KYgI8cMhPH/Q3QoE=;
  b=O5yPWuFGC7cXDNITjNSE2xCexmnExp3AN35olW1PyC5V43EmCXrPaVvY
   aJKj6yrFtvLFTXoBR3gIbc6eNZP3rMu5UFeBs8AC7gVGuWN0MmFQwS07V
   pQinMIHeckzOcqGiSTamhiI1qb9HIhANZNZzKS4RrpJDD94+fsuWUjhsN
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Feb 2023 09:59:44 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 09:59:44 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 09:59:43 -0800
Date:   Wed, 1 Feb 2023 09:59:43 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Bean Huo" <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Jinyoung Choi" <j-young.choi@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mani@kernel.org>
Subject: Re: [PATCH] scsi: ufs: core: Limit DMA alignment check
Message-ID: <20230201175943.GB14334@asutoshd-linux1.qualcomm.com>
References: <20230201034917.1902330-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20230201034917.1902330-1-quic_bjorande@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31 2023 at 19:49 -0800, Bjorn Andersson wrote:
>The three DMA memory regions allocated for the host memory space is
>documented to require alignment of 128, 1024 and 1024 respectively, but
>the returned address is checked for PAGE_SIZE alignment.
>
>In the case these allocations are serviced by e.g. the Arm SMMU, the
>size and alignment will be determined by its supported page sizes. In
>most cases SZ_4K and a few larger sizes are available.
>
>In the typical configuration this does not cause problems, but in the
>event that the system PAGE_SIZE is increased beyond 4k, it's no longer
>reasonable to expect that the allocation will be PAGE_SIZE aligned.
>
>Limit the DMA alignment check to the actual alignment requirements
>written in the comments in the code, to avoid the UFS core refusing to
>initialize with such configuration.
>
>Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Asutosh Das <quic_asutoshd@quicinc.com>

>---
> drivers/ufs/core/ufshcd.c | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>index ec732e4bbbf4..d7f3f1ba9d12 100644
>--- a/drivers/ufs/core/ufshcd.c
>+++ b/drivers/ufs/core/ufshcd.c
>@@ -3724,12 +3724,9 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>
> 	/*
> 	 * UFSHCI requires UTP command descriptor to be 128 byte aligned.
>-	 * make sure hba->ucdl_dma_addr is aligned to PAGE_SIZE
>-	 * if hba->ucdl_dma_addr is aligned to PAGE_SIZE, then it will
>-	 * be aligned to 128 bytes as well
> 	 */
> 	if (!hba->ucdl_base_addr ||
>-	    WARN_ON(hba->ucdl_dma_addr & (PAGE_SIZE - 1))) {
>+	    WARN_ON(hba->ucdl_dma_addr & (128 - 1))) {
> 		dev_err(hba->dev,
> 			"Command Descriptor Memory allocation failed\n");
> 		goto out;
>@@ -3745,7 +3742,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
> 						   &hba->utrdl_dma_addr,
> 						   GFP_KERNEL);
> 	if (!hba->utrdl_base_addr ||
>-	    WARN_ON(hba->utrdl_dma_addr & (PAGE_SIZE - 1))) {
>+	    WARN_ON(hba->utrdl_dma_addr & (1024 - 1))) {
> 		dev_err(hba->dev,
> 			"Transfer Descriptor Memory allocation failed\n");
> 		goto out;
>@@ -3769,7 +3766,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
> 						    &hba->utmrdl_dma_addr,
> 						    GFP_KERNEL);
> 	if (!hba->utmrdl_base_addr ||
>-	    WARN_ON(hba->utmrdl_dma_addr & (PAGE_SIZE - 1))) {
>+	    WARN_ON(hba->utmrdl_dma_addr & (1024 - 1))) {
> 		dev_err(hba->dev,
> 		"Task Management Descriptor Memory allocation failed\n");
> 		goto out;
>-- 
>2.25.1
>
