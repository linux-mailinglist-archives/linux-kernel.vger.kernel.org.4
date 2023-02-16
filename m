Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF32B699BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjBPSJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBPSJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:09:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F920505EF;
        Thu, 16 Feb 2023 10:09:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFFD6B82951;
        Thu, 16 Feb 2023 18:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B637DC433EF;
        Thu, 16 Feb 2023 18:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676570978;
        bh=+xuubCp2Rx1XoCEdNTTDzZVEfgaBakoROySMizGjRfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dR1lDboKKrEpmWb2alNSAoRNzF5Afx++H8TxQfBA0bOrAz+TH9nUN8Hc4XlLFZ9/p
         ctmZxunS4qSc86VNMFWgcVRbadJI0LKtS5aSE8bGHFxxdjhVm/71vqvacaLXmw294b
         yQOa4U2n0IZrUSbu4gi0ehv8U1+SgP59VRIxyCOL0AKXujCtF5flK4H2mZXNccprtF
         +iht4qWPlJCrJXqXzKtDQZdh3ARnhE6ow/xEanaL46INMM9mB1e862E9poFvTrAEjW
         9bGHpx076xESxTE+wK1G9FVKLeVXm5oIa8M4vzoDT2agvq7M0xCMQ4vT537AnKylkO
         VCx4geBi+dTsQ==
Date:   Thu, 16 Feb 2023 23:39:22 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, bvanassche@acm.org, avri.altman@wdc.com,
        mani@kernel.org, beanhuo@micron.com, linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] ufs: mcq: fix incorrectly set queue depth
Message-ID: <20230216180922.GA7015@thinkpad>
References: <8840cea4a57b46dabce18acc39afc50ab826330f.1676567593.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8840cea4a57b46dabce18acc39afc50ab826330f.1676567593.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 09:13:46AM -0800, Asutosh Das wrote:
> ufshcd_config_mcq() may change the can_queue value.
> The current code invokes scsi_add_host() before ufshcd_config_mcq().
> So the tags are limited to the old can_queue value.
> 
> Fix this by invoking scsi_add_host() after ufshcd_config_mcq().
> 
> Fixes: 2468da61ea09 ("scsi: ufs: core: mcq: Configure operation and runtime interface")
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> 
> ----
> v1 -> v2:
>   - Added Fixes tag
>   - Reworked to handle success case first
> ---
>  drivers/ufs/core/ufshcd.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 3b3cf78d3b10..3891183897f0 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8530,7 +8530,9 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
>  			return ret;
>  		if (is_mcq_supported(hba) && !hba->scsi_host_added) {
>  			ret = ufshcd_alloc_mcq(hba);
> -			if (ret) {
> +			if (!ret) {
> +				ufshcd_config_mcq(hba);
> +			} else {
>  				/* Continue with SDB mode */
>  				use_mcq_mode = false;
>  				dev_err(hba->dev, "MCQ mode is disabled, err=%d\n",
> @@ -8542,10 +8544,10 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
>  				return ret;
>  			}
>  			hba->scsi_host_added = true;
> -		}
> -		/* MCQ may be disabled if ufshcd_alloc_mcq() fails */
> -		if (is_mcq_supported(hba) && use_mcq_mode)
> +		} else if (is_mcq_supported(hba)) {
> +			/* UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH is set */
>  			ufshcd_config_mcq(hba);
> +		}
>  	}
>  
>  	ufshcd_tune_unipro_params(hba);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
