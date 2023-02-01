Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A69686443
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjBAK2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBAK2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:28:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A8E4683;
        Wed,  1 Feb 2023 02:27:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52E9261757;
        Wed,  1 Feb 2023 10:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D47C4339E;
        Wed,  1 Feb 2023 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675247276;
        bh=Zgeq1cLeqnv2FV5fbn2e26/TPr0F1TegeFxIqyZ5c2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEIiChRfk3g/6HYCxmuax10BZVudMxnJC4ndp/VKm4gXNGlgmUJ4vPWTNFGQHttoz
         sZKFl3zMo85DDzIRhutUA4ovOX9QiI0fEFlv7mJ0/jNWXqora1lb0I5k+LHJ3bahhL
         j0dnRi85T+lAPFsQoE334msDtXdvB4f5kqbYTsmTnYwZQI3VHo0etlSI2foQADJgFq
         yrR8Kn4DUmN3aeG8TYAotfHxzPd9a1yDDI4WL70Usi5QHn3oi4VvIWACymZCIJ9YLq
         zIngXYaonZPhbbourPxm3zPxUyMD0YtRHhJgW0aEzKFofxnSboc0Jb4tipTTN3fDlf
         aJFYnOJMGjxbA==
Date:   Wed, 1 Feb 2023 15:57:48 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Limit DMA alignment check
Message-ID: <20230201102748.GA62808@thinkpad>
References: <20230201034917.1902330-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201034917.1902330-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 07:49:17PM -0800, Bjorn Andersson wrote:
> The three DMA memory regions allocated for the host memory space is
> documented to require alignment of 128, 1024 and 1024 respectively, but
> the returned address is checked for PAGE_SIZE alignment.
> 
> In the case these allocations are serviced by e.g. the Arm SMMU, the
> size and alignment will be determined by its supported page sizes. In
> most cases SZ_4K and a few larger sizes are available.
> 
> In the typical configuration this does not cause problems, but in the
> event that the system PAGE_SIZE is increased beyond 4k, it's no longer
> reasonable to expect that the allocation will be PAGE_SIZE aligned.
> 
> Limit the DMA alignment check to the actual alignment requirements
> written in the comments in the code, to avoid the UFS core refusing to
> initialize with such configuration.

Isn't dma_alloc_coherent() supposed to return PAGE_SIZE aligned dma and cpu
addresses? I suppose that could be reason for checking against PAGE_SIZE.

> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

But it doesn't hurt to check for the actual alignment.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/ufs/core/ufshcd.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index ec732e4bbbf4..d7f3f1ba9d12 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -3724,12 +3724,9 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>  
>  	/*
>  	 * UFSHCI requires UTP command descriptor to be 128 byte aligned.
> -	 * make sure hba->ucdl_dma_addr is aligned to PAGE_SIZE
> -	 * if hba->ucdl_dma_addr is aligned to PAGE_SIZE, then it will
> -	 * be aligned to 128 bytes as well
>  	 */
>  	if (!hba->ucdl_base_addr ||
> -	    WARN_ON(hba->ucdl_dma_addr & (PAGE_SIZE - 1))) {
> +	    WARN_ON(hba->ucdl_dma_addr & (128 - 1))) {
>  		dev_err(hba->dev,
>  			"Command Descriptor Memory allocation failed\n");
>  		goto out;
> @@ -3745,7 +3742,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>  						   &hba->utrdl_dma_addr,
>  						   GFP_KERNEL);
>  	if (!hba->utrdl_base_addr ||
> -	    WARN_ON(hba->utrdl_dma_addr & (PAGE_SIZE - 1))) {
> +	    WARN_ON(hba->utrdl_dma_addr & (1024 - 1))) {
>  		dev_err(hba->dev,
>  			"Transfer Descriptor Memory allocation failed\n");
>  		goto out;
> @@ -3769,7 +3766,7 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>  						    &hba->utmrdl_dma_addr,
>  						    GFP_KERNEL);
>  	if (!hba->utmrdl_base_addr ||
> -	    WARN_ON(hba->utmrdl_dma_addr & (PAGE_SIZE - 1))) {
> +	    WARN_ON(hba->utmrdl_dma_addr & (1024 - 1))) {
>  		dev_err(hba->dev,
>  		"Task Management Descriptor Memory allocation failed\n");
>  		goto out;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
