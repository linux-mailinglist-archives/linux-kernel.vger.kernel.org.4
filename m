Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08C263AB5E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiK1OnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiK1Omw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:42:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E134D2E3;
        Mon, 28 Nov 2022 06:42:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19626611D3;
        Mon, 28 Nov 2022 14:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C937BC433C1;
        Mon, 28 Nov 2022 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669646558;
        bh=Vaqy0ljqy+6FwKwyXsEKERVsCLsDS1+87nejAbRnZ4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDNyihVbCj3VD1RtEKcdsPLgOX3bVqN1n+Bn0vD6U/fobkRuhCiK3G7MnbzXR+kmU
         Wu1aK+UaUIGFbxVvszLCeTDdAcpZGTo7wMd+lMiPwelfoDYXchP7qmSsKurp+5tvTl
         n8ER6shLBpk/CkP3UFzxb6Y0oCb5CpKo+SZXy9uZ26iWTgCHObZmjhiY60SjmS7Thv
         4m+Lzyd+Z0kILEZlRo177qxBPyuBpNj3B8CwqtKg3nZ/QjEKGSY7QFPSpowUXJSQ+1
         jgdwb6ARFkVb7vbCVSy1s5CQUHa49OUyLDVvxVIHa+YSf0/vTBDYiBM0CqFeQF8sZk
         2cWNiR0IGZe2Q==
Date:   Mon, 28 Nov 2022 20:12:22 +0530
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
Subject: Re: [PATCH v5 04/16] ufs: core: Defer adding host to scsi if mcq is
 supported
Message-ID: <20221128144222.GD62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <b75e35e1c23b428a6c55396c0fcda5ea22b4e33e.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b75e35e1c23b428a6c55396c0fcda5ea22b4e33e.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:17PM -0800, Asutosh Das wrote:
> If MCQ support is present, enabling it after MCQ support
> has been configured would require reallocating tags and memory.
> It would also free up the already allocated memory in
> Single Doorbell Mode. So defer invoking scsi_add_host() until
> MCQ is configured.

Why cannot we do it for non MCQ case as well?

Thanks,
Mani

> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> ---
>  drivers/ufs/core/ufshcd.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 08be8ad..42c49ce 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8208,6 +8208,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
>  	int ret;
>  	unsigned long flags;
>  	ktime_t start = ktime_get();
> +	struct Scsi_Host *host = hba->host;
>  
>  	hba->ufshcd_state = UFSHCD_STATE_RESET;
>  
> @@ -8242,6 +8243,14 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
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
> @@ -9838,10 +9847,12 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
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

-- 
மணிவண்ணன் சதாசிவம்
