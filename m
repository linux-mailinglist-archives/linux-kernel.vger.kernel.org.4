Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CD2686BAA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjBAQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjBAQ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:28:50 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686E5CD21;
        Wed,  1 Feb 2023 08:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675268924; x=1706804924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cTWKNRgpzfZZ1xcjd6kf3kLvV7hexbb7CfgOchz/JkM=;
  b=vLtY+TkPTS3PmbLRIHVz/mxi9hoBTFgynEj1CXNXNftuNoTZ/PvRrXB8
   CS9UWfSFczlS4E390h4z1KNF6IUYladZdRvEoxNiXyqde4Hqr3+5qW+7W
   +PneM3DFw3SAIGBPbMi7apm3zbUcNa7YQgeWW9XZmG/ZLZXFzKTGVZwwj
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Feb 2023 08:28:43 -0800
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 08:28:43 -0800
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 08:28:43 -0800
Date:   Wed, 1 Feb 2023 08:28:41 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: core: Limit DMA alignment check
Message-ID: <20230201162841.GA2238350@hu-bjorande-lv.qualcomm.com>
References: <20230201034917.1902330-1-quic_bjorande@quicinc.com>
 <20230201102748.GA62808@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201102748.GA62808@thinkpad>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 03:57:48PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jan 31, 2023 at 07:49:17PM -0800, Bjorn Andersson wrote:
> > The three DMA memory regions allocated for the host memory space is
> > documented to require alignment of 128, 1024 and 1024 respectively, but
> > the returned address is checked for PAGE_SIZE alignment.
> > 
> > In the case these allocations are serviced by e.g. the Arm SMMU, the
> > size and alignment will be determined by its supported page sizes. In
> > most cases SZ_4K and a few larger sizes are available.
> > 
> > In the typical configuration this does not cause problems, but in the
> > event that the system PAGE_SIZE is increased beyond 4k, it's no longer
> > reasonable to expect that the allocation will be PAGE_SIZE aligned.
> > 
> > Limit the DMA alignment check to the actual alignment requirements
> > written in the comments in the code, to avoid the UFS core refusing to
> > initialize with such configuration.
> 
> Isn't dma_alloc_coherent() supposed to return PAGE_SIZE aligned dma and cpu
> addresses? I suppose that could be reason for checking against PAGE_SIZE.
> 

If the allocating device has associated dma_mem, the requested size will
be rounded up to the next order and you will get an allocation which is
sized and aligned to that.
Given the three allocations on my device is 98304, 1024 and 640. The
latter two would only be aligned to 1kb if this code path is taken...


But in our case, the comment for __iommu_dma_alloc_noncontiguous() seems
to give us the reason for the issue.

/*
 * If size is less than PAGE_SIZE, then a full CPU page will be allocated,
 * but an IOMMU which supports smaller pages might not map the whole thing.
 */

Our iommu reports supporting mapping of 4kb pages.

> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> But it doesn't hurt to check for the actual alignment.
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 

Thanks,
Bjorn

> Thanks,
> Mani
> 
> > ---
> >  drivers/ufs/core/ufshcd.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index ec732e4bbbf4..d7f3f1ba9d12 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > @@ -3724,12 +3724,9 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
> >  
> >  	/*
> >  	 * UFSHCI requires UTP command descriptor to be 128 byte aligned.
> > -	 * make sure hba->ucdl_dma_addr is aligned to PAGE_SIZE
> > -	 * if hba->ucdl_dma_addr is aligned to PAGE_SIZE, then it will
> > -	 * be aligned to 128 bytes as well
> >  	 */
> >  	if (!hba->ucdl_base_addr ||
> > -	    WARN_ON(hba->ucdl_dma_addr & (PAGE_SIZE - 1))) {
> > +	    WARN_ON(hba->ucdl_dma_addr & (128 - 1))) {
> >  		dev_err(hba->dev,
> >  			"Command Descriptor Memory allocation failed\n");
> >  		goto out;
> > @@ -3745,7 +3742,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
> >  						   &hba->utrdl_dma_addr,
> >  						   GFP_KERNEL);
> >  	if (!hba->utrdl_base_addr ||
> > -	    WARN_ON(hba->utrdl_dma_addr & (PAGE_SIZE - 1))) {
> > +	    WARN_ON(hba->utrdl_dma_addr & (1024 - 1))) {
> >  		dev_err(hba->dev,
> >  			"Transfer Descriptor Memory allocation failed\n");
> >  		goto out;
> > @@ -3769,7 +3766,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
> >  						    &hba->utmrdl_dma_addr,
> >  						    GFP_KERNEL);
> >  	if (!hba->utmrdl_base_addr ||
> > -	    WARN_ON(hba->utmrdl_dma_addr & (PAGE_SIZE - 1))) {
> > +	    WARN_ON(hba->utmrdl_dma_addr & (1024 - 1))) {
> >  		dev_err(hba->dev,
> >  		"Task Management Descriptor Memory allocation failed\n");
> >  		goto out;
> > -- 
> > 2.25.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
