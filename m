Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A5563AC02
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiK1PPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiK1PPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:15:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7F215A28;
        Mon, 28 Nov 2022 07:15:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98DEA6120E;
        Mon, 28 Nov 2022 15:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1086DC433D6;
        Mon, 28 Nov 2022 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669648528;
        bh=CRL43+ms13b5UY7OkmaNi+nHnj84SwWm3RzHI1Fvat8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8Zri5P0om1ReFiP38SaN9LWG4RbaHa4+6XeBs6lzP1d+3acMecyrSh4zWwZgLLj2
         3p9uyjBhWYGgn7LekmONAPtMPp0JWEBbdcSiEez5xXMnqOPmgH2bFPvxLwXz/EW1PV
         d0NrPV94BholxIgwn6tmWAMXSLp7RngAtL3RkjDzDiQURy/JmweImw9hQYXHBOvXDk
         3Q6RhcQ1oTlIBMkTtHHnS+bQxu1CmVYPW62ujE14J2CX2Cn5Qqw8ESEBw/bkefs9Cg
         IIRTR04sJkaRZ2wcEZRrHzCu2qHPDZk70chojkmNsz9kmwyQ548GpZ+KnXVFuVOXqP
         U0SQBmIUu1/HA==
Date:   Mon, 28 Nov 2022 20:45:12 +0530
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
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 07/16] ufs: core: mcq: Calculate queue depth
Message-ID: <20221128151512.GF62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <ae139f730dcec6462f9218856bf974eda4a29e1d.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae139f730dcec6462f9218856bf974eda4a29e1d.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:20PM -0800, Asutosh Das wrote:
> The ufs device defines the supported queuedepth by
> bqueuedepth which has a max value of 256.
> The HC defines MAC (Max Active Commands) that define
> the max number of commands that in flight to the ufs
> device.
> Calculate and configure the nutrs based on both these
> values.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> ---
>  drivers/ufs/core/ufs-mcq.c     | 32 ++++++++++++++++++++++++++++++++
>  drivers/ufs/core/ufshcd-priv.h |  9 +++++++++
>  drivers/ufs/core/ufshcd.c      | 17 ++++++++++++++++-
>  drivers/ufs/host/ufs-qcom.c    |  8 ++++++++
>  include/ufs/ufs.h              |  2 ++
>  include/ufs/ufshcd.h           |  2 ++
>  include/ufs/ufshci.h           |  1 +
>  7 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 4aaa6aa..e95f748 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -18,6 +18,8 @@
>  #define UFS_MCQ_NUM_DEV_CMD_QUEUES 1
>  #define UFS_MCQ_MIN_POLL_QUEUES 0
>  
> +#define MAX_DEV_CMD_ENTRIES	2
> +#define MCQ_CFG_MAC_MASK	GENMASK(16, 8)
>  #define MCQ_QCFGPTR_MASK	GENMASK(7, 0)
>  #define MCQ_QCFGPTR_UNIT	0x200
>  #define MCQ_SQATTR_OFFSET(c) \
> @@ -88,6 +90,36 @@ static const struct ufshcd_res_info ufs_res_info[RES_MAX] = {
>  	{.name = "mcq_vs",},
>  };
>  
> +/**
> + * ufshcd_mcq_decide_queue_depth - decide the queue depth
> + * @hba - per adapter instance
> + *

Kernel doc should define the return value also.

> + * MAC - Max. Active Command of the Host Controller (HC)
> + * HC wouldn't send more than this commands to the device.
> + * It is mandatory to implement get_hba_mac() to enable MCQ mode.
> + * Calculates and adjusts the queue depth based on the depth
> + * supported by the HC and ufs device.
> + */
> +int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba)
> +{
> +	int mac;
> +
> +	/* Mandatory to implement get_hba_mac() */
> +	mac = ufshcd_mcq_vops_get_hba_mac(hba);
> +	if (mac < 0) {
> +		dev_err(hba->dev, "Failed to get mac, err=%d\n", mac);
> +		return mac;
> +	}
> +
> +	WARN_ON(!hba->dev_info.bqueuedepth);

Instead of panic, you could just print and return an error.

> +	/*
> +	 * max. value of bqueuedepth = 256, mac is host dependent.
> +	 * It is mandatory for UFS device to define bQueueDepth if
> +	 * shared queuing architecture is enabled.
> +	 */
> +	return min_t(int, mac, hba->dev_info.bqueuedepth);
> +}
> +
>  static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
>  {
>  	struct platform_device *pdev = to_platform_device(hba->dev);
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index 9368ba2..9f40fa5 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -62,6 +62,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>  	enum flag_idn idn, u8 index, bool *flag_res);
>  void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
>  int ufshcd_mcq_init(struct ufs_hba *hba);
> +int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
>  
>  #define SD_ASCII_STD true
>  #define SD_RAW false
> @@ -227,6 +228,14 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
>  		hba->vops->config_scaling_param(hba, p, data);
>  }
>  
> +static inline int ufshcd_mcq_vops_get_hba_mac(struct ufs_hba *hba)

Again, no inline please.

> +{
> +	if (hba->vops && hba->vops->get_hba_mac)
> +		return hba->vops->get_hba_mac(hba);
> +
> +	return -EOPNOTSUPP;
> +}
> +
>  extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
>  
>  /**
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 0c4cd8f..ae065da 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7783,6 +7783,7 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
>  	/* getting Specification Version in big endian format */
>  	dev_info->wspecversion = desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 8 |
>  				      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
> +	dev_info->bqueuedepth = desc_buf[DEVICE_DESC_PARAM_Q_DPTH];
>  	b_ufs_feature_sup = desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
>  
>  	model_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
> @@ -8198,7 +8199,21 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
>  
>  static int ufshcd_alloc_mcq(struct ufs_hba *hba)
>  {
> -	return ufshcd_mcq_init(hba);
> +	int ret;
> +	int old_nutrs = hba->nutrs;
> +
> +	ret = ufshcd_mcq_decide_queue_depth(hba);
> +	if (ret < 0)
> +		return ret;
> +
> +	hba->nutrs = ret;
> +	ret = ufshcd_mcq_init(hba);
> +	if (ret) {
> +		hba->nutrs = old_nutrs;
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  /**
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 8ad1415..7bd3c37 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -25,6 +25,7 @@
>  #define UFS_QCOM_DEFAULT_DBG_PRINT_EN	\
>  	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
>  
> +#define MAX_SUPP_MAC 64

Similar definitions are part of ufs-qcom.h.

Thanks,
Mani

>  enum {
>  	TSTBUS_UAWM,
>  	TSTBUS_UARM,
> @@ -1424,6 +1425,12 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
>  }
>  #endif
>  
> +static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
> +{
> +	/* Qualcomm HC supports up to 64 */
> +	return MAX_SUPP_MAC;
> +}
> +
>  /*
>   * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
>   *
> @@ -1447,6 +1454,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
>  	.device_reset		= ufs_qcom_device_reset,
>  	.config_scaling_param = ufs_qcom_config_scaling_param,
>  	.program_key		= ufs_qcom_ice_program_key,
> +	.get_hba_mac		= ufs_qcom_get_hba_mac,
>  };
>  
>  /**
> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
> index ba2a1d8..5112418 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -591,6 +591,8 @@ struct ufs_dev_info {
>  	u8	*model;
>  	u16	wspecversion;
>  	u32	clk_gating_wait_us;
> +	/* Stores the depth of queue in UFS device */
> +	u8	bqueuedepth;
>  
>  	/* UFS HPB related flag */
>  	bool	hpb_enabled;
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 7bf7599..e03b310 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
>   * @config_scaling_param: called to configure clock scaling parameters
>   * @program_key: program or evict an inline encryption key
>   * @event_notify: called to notify important events
> + * @get_hba_mac: called to get vendor specific mac value, mandatory for mcq mode
>   */
>  struct ufs_hba_variant_ops {
>  	const char *name;
> @@ -335,6 +336,7 @@ struct ufs_hba_variant_ops {
>  			       const union ufs_crypto_cfg_entry *cfg, int slot);
>  	void	(*event_notify)(struct ufs_hba *hba,
>  				enum ufs_event_type evt, void *data);
> +	int	(*get_hba_mac)(struct ufs_hba *hba);
>  };
>  
>  /* clock gating state  */
> diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
> index 4d4da06..67fcebd 100644
> --- a/include/ufs/ufshci.h
> +++ b/include/ufs/ufshci.h
> @@ -57,6 +57,7 @@ enum {
>  	REG_UFS_CCAP				= 0x100,
>  	REG_UFS_CRYPTOCAP			= 0x104,
>  
> +	REG_UFS_MCQ_CFG				= 0x380,
>  	UFSHCI_CRYPTO_REG_SPACE_SIZE		= 0x400,
>  };
>  
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
