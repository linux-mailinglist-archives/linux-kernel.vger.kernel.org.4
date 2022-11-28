Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54E363AAE3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiK1O3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbiK1O3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:29:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676A720F5D;
        Mon, 28 Nov 2022 06:29:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00EF6611D1;
        Mon, 28 Nov 2022 14:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2C4C433D6;
        Mon, 28 Nov 2022 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669645759;
        bh=p6P+Usk+fx7WFz5pI3uzrFQy/vvCPkHrwJgNphkmKrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJYgucy+3wQ4DiHXcbfACdNAYxeHo5CMMUhCtPkq6phwywQwagEFAuMTf6BtwvDfi
         5HCzZIZpKYFA/PUKYNbzLueeoNdjPw772VIjLV3rAVMsd2z0Uf6c1akE6jCAgRD09N
         FNbKygozUbuHmX4dW1FXYadAmfnAVzIokIF3ncOxFRhAJqmJoG5e5CTQh8gJ0jI0JR
         UkPRdoE4fA7wCpPVVNJ0Gi0AyiWhYJQI0bQdFSIGakxFdGKXkuWwvHSQ+bFZYnp/39
         2wNvnlm4jn0P9iMZvJeOfFvqAOqXuf27u9LpB8M302mF67o+z1UnI3+C9zAArtTEs0
         C03H++3H9taPg==
Date:   Mon, 28 Nov 2022 19:59:04 +0530
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
Subject: Re: [PATCH v5 03/16] ufs: core: Introduce Multi-circular queue
 capability
Message-ID: <20221128142904.GC62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <1a84dab482956b19cb513dc46e9689e07316e357.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a84dab482956b19cb513dc46e9689e07316e357.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:16PM -0800, Asutosh Das wrote:
> Add support to check for MCQ capability in the UFSHC.
> Add a module parameter to disable MCQ if needed.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

Couple of nitpicks below, with those addressed:

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

> ---
>  drivers/ufs/core/ufshcd.c | 31 +++++++++++++++++++++++++++++++
>  include/ufs/ufshcd.h      |  2 ++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 66b797f..08be8ad 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -89,6 +89,33 @@
>  /* Polling time to wait for fDeviceInit */
>  #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
>  
> +/* UFSHC 4.0 compliant HC support this mode, refer param_set_mcq_mode() */
> +static bool use_mcq_mode = true;
> +
> +static inline bool is_mcq_supported(struct ufs_hba *hba)

Please get rid of inline keyword and let the compiler handle it.

> +{
> +	return hba->mcq_sup && use_mcq_mode;
> +}
> +
> +static int param_set_mcq_mode(const char *val, const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	ret = param_set_bool(val, kp);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops mcq_mode_ops = {
> +	.set = param_set_mcq_mode,
> +	.get = param_get_bool,
> +};
> +
> +module_param_cb(use_mcq_mode, &mcq_mode_ops, &use_mcq_mode, 0644);
> +MODULE_PARM_DESC(mcq_mode, "Control MCQ mode for UFSHCI 4.0 controllers");

Is it ok to mention only 4.0? What about future revisions?

Thanks,
Mani
> +
>  #define ufshcd_toggle_vreg(_dev, _vreg, _on)				\
>  	({                                                              \
>  		int _ret;                                               \
> @@ -2258,6 +2285,10 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
>  	if (err)
>  		dev_err(hba->dev, "crypto setup failed\n");
>  
> +	hba->mcq_sup = FIELD_GET(MASK_MCQ_SUPPORT, hba->capabilities);
> +	if (!hba->mcq_sup)
> +		return err;
> +
>  	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
>  	hba->ext_iid_sup = FIELD_GET(MASK_EXT_IID_SUPPORT,
>  				     hba->mcq_capabilities);
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index aec37cb9..70c0f9f 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -832,6 +832,7 @@ struct ufs_hba_monitor {
>   * @complete_put: whether or not to call ufshcd_rpm_put() from inside
>   *	ufshcd_resume_complete()
>   * @ext_iid_sup: is EXT_IID is supported by UFSHC
> + * @mcq_sup: is mcq supported by UFSHC
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -982,6 +983,7 @@ struct ufs_hba {
>  	u32 luns_avail;
>  	bool complete_put;
>  	bool ext_iid_sup;
> +	bool mcq_sup;
>  };
>  
>  /* Returns true if clocks can be gated. Otherwise false */
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
