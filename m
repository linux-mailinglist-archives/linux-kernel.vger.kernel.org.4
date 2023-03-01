Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43A66A6806
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCAHN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCAHN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:13:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0DF10267;
        Tue, 28 Feb 2023 23:13:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B0E6122C;
        Wed,  1 Mar 2023 07:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF839C433EF;
        Wed,  1 Mar 2023 07:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677654833;
        bh=VVjtIw697MHFtpFrNzPIOtIoEgOIJZddjFWia0e2YOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQh5G3TsD9+m7NKc2gLstYDmY+ly7VLc3LvgNlJavLbx6Bxw4FSG6ksAujPmJ1RiR
         lIjIc0FAeZBztU0Wi9DyHdaTUm6EXn1YnYWa4GPuX9PHOZjXi1HET7mpbEyKfJKdoT
         uw70lHntFfHjWczzJEwkVbI2kSQT7P44o6pAA2cgnYEozeRNu9MEr75cX6I/+emYUq
         8lsU8XiSJ1HKRJqvdw3VAZtZmG0Jmzw8UESHu/YWoKy61Jj1/fwlcASgzpoeq/ALPx
         Tow4DXnAOnoiMv78I6j6ybosnv9fbli4St2vEFMA4ssJwkdIT4pYV+paSzf32boAZm
         I40b8HH2NOfXQ==
Date:   Wed, 1 Mar 2023 12:43:43 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
Subject: Re: [PATCH v3 3/6] scsi: ufs: core: Fix mcq nr_hw_queues
Message-ID: <20230301071343.GC5409@thinkpad>
References: <20230223152757.13606-1-powen.kao@mediatek.com>
 <20230223152757.13606-4-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230223152757.13606-4-powen.kao@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 11:27:53PM +0800, Po-Wen Kao wrote:
> Since MAXQ is 0 based value, add one to obtain number of hardware queue.
> 
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/ufs/core/ufs-mcq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index a39746b2a8be..f9af658b4ba2 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -150,7 +150,8 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
>  	u32 hba_maxq, rem, tot_queues;
>  	struct Scsi_Host *host = hba->host;
>  
> -	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities);
> +	/* maxq is 0 based value */
> +	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities) + 1 ;
>  
>  	tot_queues = UFS_MCQ_NUM_DEV_CMD_QUEUES + read_queues + poll_queues +
>  			rw_queues;
> -- 
> 2.18.0
> 

-- 
மணிவண்ணன் சதாசிவம்
