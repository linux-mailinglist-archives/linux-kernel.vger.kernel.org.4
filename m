Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD66763C3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiK2PeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiK2PeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:34:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C68563B8F;
        Tue, 29 Nov 2022 07:34:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03817617AA;
        Tue, 29 Nov 2022 15:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AA1C433D6;
        Tue, 29 Nov 2022 15:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669736043;
        bh=YC+NskolvPnhTCXVEmTw3WPjtpIt80RCysC8fjQcvGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDXnXKlT5zxxaF7VBN2YgjcxYTMayOPM/+vVmYz1Xwd+m36eBbqYfbJw8CLD6fhb6
         hXdVfJ5dwPBhXoGDrQ+kdGwIkjRJW3VuQOC9nJorris+AIlgJY4i6awIzkCcj5LhKi
         tLtkiJLpW0TWfWFvhy3SjgM8cyKntRH5UWL4VAl+1pcLWBpFG+OkS9RDdoLCz/6ccj
         Uhve6rSxZrqO/r2a9AupXmGqJHkRPYcdG35ABliYEN2D/YKIgHxbLBHUGCzFQRDkZ4
         9eSW9Y17qyNVesSXU7fFK9A1KxQVp3YusHh7Oitmsa0lWMSch2O5GpYmqN3hRgTEj7
         sukPnOw7HgG5g==
Date:   Tue, 29 Nov 2022 21:03:48 +0530
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 07/16] ufs: core: mcq: Calculate queue depth
Message-ID: <20221129153348.GG4931@workstation>
References: <cover.1669684648.git.quic_asutoshd@quicinc.com>
 <219a71d08f1b528779ec6a1334de8b8dd5182db6.1669684648.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <219a71d08f1b528779ec6a1334de8b8dd5182db6.1669684648.git.quic_asutoshd@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 05:20:48PM -0800, Asutosh Das wrote:
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

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/ufs/core/ufs-mcq.c     | 35 +++++++++++++++++++++++++++++++++++
>  drivers/ufs/core/ufshcd-priv.h |  9 +++++++++
>  drivers/ufs/core/ufshcd.c      | 17 ++++++++++++++++-
>  drivers/ufs/host/ufs-qcom.c    |  7 +++++++
>  drivers/ufs/host/ufs-qcom.h    |  1 +
>  include/ufs/ufs.h              |  2 ++
>  include/ufs/ufshcd.h           |  2 ++
>  include/ufs/ufshci.h           |  1 +
>  8 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index d6807e3..6f66bd7 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -19,6 +19,9 @@
>  #define UFS_MCQ_NUM_DEV_CMD_QUEUES 1
>  #define UFS_MCQ_MIN_POLL_QUEUES 0
>  
> +#define MAX_DEV_CMD_ENTRIES	2
> +#define MCQ_CFG_MAC_MASK	GENMASK(16, 8)
> +
>  static int rw_queue_count_set(const char *val, const struct kernel_param *kp)
>  {
>  	return param_set_uint_minmax(val, kp, UFS_MCQ_MIN_RW_QUEUES,
> @@ -67,6 +70,38 @@ module_param_cb(poll_queues, &poll_queue_count_ops, &poll_queues, 0644);
>  MODULE_PARM_DESC(poll_queues,
>  		 "Number of poll queues used for r/w. Default value is 1");
>  
> +/**
> + * ufshcd_mcq_decide_queue_depth - decide the queue depth
> + * @hba - per adapter instance
> + *
> + * Returns queue-depth on success, non-zero on error
> + *
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
> +	WARN_ON_ONCE(!hba->dev_info.bqueuedepth);
> +	/*
> +	 * max. value of bqueuedepth = 256, mac is host dependent.
> +	 * It is mandatory for UFS device to define bQueueDepth if
> +	 * shared queuing architecture is enabled.
> +	 */
> +	return min_t(int, mac, hba->dev_info.bqueuedepth);
> +}
> +
>  static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
>  {
>  	int i;
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index 74cb17b9..da974a9 100644
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
> @@ -235,6 +236,14 @@ static inline int ufshcd_vops_mcq_config_resource(struct ufs_hba *hba)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int ufshcd_mcq_vops_get_hba_mac(struct ufs_hba *hba)
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
> index 9b78814..e17159a 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7807,6 +7807,7 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
>  	/* getting Specification Version in big endian format */
>  	dev_info->wspecversion = desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 8 |
>  				      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
> +	dev_info->bqueuedepth = desc_buf[DEVICE_DESC_PARAM_Q_DPTH];
>  	b_ufs_feature_sup = desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
>  
>  	model_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
> @@ -8222,7 +8223,21 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
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
> index 6bea541..ad7cde2 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1526,6 +1526,12 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
>  	return ret;
>  }
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
> @@ -1550,6 +1556,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
>  	.config_scaling_param = ufs_qcom_config_scaling_param,
>  	.program_key		= ufs_qcom_ice_program_key,
>  	.mcq_config_resource	= ufs_qcom_mcq_config_resource,
> +	.get_hba_mac		= ufs_qcom_get_hba_mac,
>  };
>  
>  /**
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 44466a3..f86e532 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -16,6 +16,7 @@
>  #define HBRN8_POLL_TOUT_MS      100
>  #define DEFAULT_CLK_RATE_HZ     1000000
>  #define BUS_VECTOR_NAME_LEN     32
> +#define MAX_SUPP_MAC		64
>  
>  #define UFS_HW_VER_MAJOR_SHFT	(28)
>  #define UFS_HW_VER_MAJOR_MASK	(0x000F << UFS_HW_VER_MAJOR_SHFT)
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
> index 0e21a6a..9d7829a 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -298,6 +298,7 @@ struct ufs_pwr_mode_info {
>   * @program_key: program or evict an inline encryption key
>   * @event_notify: called to notify important events
>   * @mcq_config_resource: called to configure MCQ platform resources
> + * @get_hba_mac: called to get vendor specific mac value, mandatory for mcq mode
>   */
>  struct ufs_hba_variant_ops {
>  	const char *name;
> @@ -337,6 +338,7 @@ struct ufs_hba_variant_ops {
>  	void	(*event_notify)(struct ufs_hba *hba,
>  				enum ufs_event_type evt, void *data);
>  	int	(*mcq_config_resource)(struct ufs_hba *hba);
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
