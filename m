Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EE063C3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiK2P1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiK2P1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:27:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465C1D4C;
        Tue, 29 Nov 2022 07:27:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E61615F6;
        Tue, 29 Nov 2022 15:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C8FC433D6;
        Tue, 29 Nov 2022 15:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669735630;
        bh=05TN/ChYDsZNJQMqNeZeVjm48CGMgr/zwbKgDJxJOfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WO0ik+5QqM1KtqV5MV3NWG/JLhOv1JfbJ9/uP6h8+w4gS7gxYmbQ0oJMikVEK+VSf
         LVxYbTawRmhLu+pfSw9gu8qCKiQVhhtxp+jlVG1KXrORGDTRcTjEW2x0tPjzJra3vi
         ZPvceIl0GN544j8w9psdOs1KVFzXH1DQt7AOi4P8vC0SBpHaMS46A2I9A2gvAfwb+T
         /3pjI8qEak4UNRDbs2fkPir0KpHRKDY9pKEMTUjaWFKY9mK8QlHFNIG1VMkLHUZOg3
         FRqtNxNLdqeiK+Gd94f5fdiwygbkWYgmpH3Gf8lwVaAZZ9EmheEQ4eBwSgyLz7qJtx
         pdTXRia5RvkEg==
Date:   Tue, 29 Nov 2022 20:56:56 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_cang@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        eddie.huang@mediatek.com, daejun7.park@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, beanhuo@micron.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 04/16] ufs: core: Defer adding host to scsi if mcq is
 supported
Message-ID: <20221129152656.GD4931@workstation>
References: <cover.1669684648.git.quic_asutoshd@quicinc.com>
 <cc28100c0e3037bb07eeaa24d48f64d4b6198c2e.1669684648.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc28100c0e3037bb07eeaa24d48f64d4b6198c2e.1669684648.git.quic_asutoshd@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 05:20:45PM -0800, Asutosh Das wrote:
> If MCQ support is present, enabling it after MCQ support
> has been configured would require reallocating tags and memory.
> It would also free up the already allocated memory in
> Single Doorbell Mode. So defer invoking scsi_add_host() until
> MCQ is configured.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ufs/core/ufshcd.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index eca15b0..3c2220c 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -92,6 +92,11 @@
>  /* UFSHC 4.0 compliant HC support this mode, refer param_set_mcq_mode() */
>  static bool use_mcq_mode = true;
>  
> +static bool is_mcq_supported(struct ufs_hba *hba)
> +{
> +        return hba->mcq_sup && use_mcq_mode;
> +}
> +
>  static int param_set_mcq_mode(const char *val, const struct kernel_param *kp)
>  {
>  	int ret;
> @@ -8227,6 +8232,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
>  	int ret;
>  	unsigned long flags;
>  	ktime_t start = ktime_get();
> +	struct Scsi_Host *host = hba->host;
>  
>  	hba->ufshcd_state = UFSHCD_STATE_RESET;
>  
> @@ -8261,6 +8267,14 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
>  		ret = ufshcd_device_params_init(hba);
>  		if (ret)
>  			goto out;
> +
> +		if (is_mcq_supported(hba)) {
> +			ret = scsi_add_host(host, hba->dev);
> +			if (ret) {
> +				dev_err(hba->dev, "scsi_add_host failed\n");
> +				goto out;
> +			}
> +		}
>  	}
>  
>  	ufshcd_tune_unipro_params(hba);
> @@ -9857,10 +9871,12 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>  		hba->is_irq_enabled = true;
>  	}
>  
> -	err = scsi_add_host(host, hba->dev);
> -	if (err) {
> -		dev_err(hba->dev, "scsi_add_host failed\n");
> -		goto out_disable;
> +	if (!is_mcq_supported(hba)) {
> +		err = scsi_add_host(host, hba->dev);
> +		if (err) {
> +			dev_err(hba->dev, "scsi_add_host failed\n");
> +			goto out_disable;
> +		}
>  	}
>  
>  	hba->tmf_tag_set = (struct blk_mq_tag_set) {
> -- 
> 2.7.4
> 
