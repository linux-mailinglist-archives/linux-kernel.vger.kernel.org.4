Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B94D5EACA5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiIZQfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIZQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:34:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2311231F7;
        Mon, 26 Sep 2022 08:23:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1C5560EB3;
        Mon, 26 Sep 2022 15:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD9FC433D6;
        Mon, 26 Sep 2022 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664205753;
        bh=tkGz0mI9ZHcofL7MH+Yxpbi6SOdY1vDNXy/DjtkXg0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTIJ0csWO6A2vM46JkA8NI7As/FWmSJBQKaueBJ9I1wIekJ1EahrWwLWvu8/nwMEI
         BbXOOgT7T7aInKq5ut09ucby663j7EMdvJJXZTwfCKh9ROBKyEk/q9ttIGUapc1ILF
         sDu01TCipn8ngQOMvn8nbIKm9K20ZzXxEERkVf/YmigRICn2VGn2Ro7F5YhwjBaNek
         7PGOgTy4PngC9nz1jLQNAn7IJInWrVDbuCt5dx7HI6zem0jsd/DOD5pS2NX3YYBqBD
         bi83HB1mmiKr+6izA7BrLnIazi+aBO0L17jGEXM78DVqIjmDemakAOI8SdFVysP1q1
         KY3PFWaQ8OTRw==
Date:   Mon, 26 Sep 2022 20:52:22 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        quic_cang@quicinc.com, quic_nitirawa@quicinc.com,
        quic_rampraka@quicinc.com, quic_richardp@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        bvanassche@acm.org, avri.altman@wdc.com, beanhuo@micron.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 06/16] ufs: core: mcq: Calculate queue depth
Message-ID: <20220926152222.GG101994@thinkpad>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <e0a5115eac57ee19df10bae2e3411cbbc7943303.1663894792.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0a5115eac57ee19df10bae2e3411cbbc7943303.1663894792.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:05:13PM -0700, Asutosh Das wrote:
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
>  drivers/ufs/core/ufs-mcq.c     | 34 ++++++++++++++++++++++++++++++++++
>  drivers/ufs/core/ufshcd-priv.h |  9 +++++++++
>  drivers/ufs/core/ufshcd.c      | 10 ++++++++--
>  drivers/ufs/host/ufs-qcom.c    |  8 ++++++++
>  include/ufs/ufs.h              |  2 ++
>  include/ufs/ufshcd.h           |  2 ++
>  include/ufs/ufshci.h           |  1 +
>  7 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index e5cc7ab..e52066e 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -17,6 +17,8 @@
>  #define UFS_MCQ_MIN_READ_QUEUES 0
>  #define UFS_MCQ_MIN_POLL_QUEUES 0
>  
> +#define MCQ_CFG_MAC_OFFSET	8
> +#define MCQ_CFG_MAC_MASK	UFS_MASK(0x1ff, MCQ_CFG_MAC_OFFSET)

Define 0x1ff

>  #define MCQ_QCFGPTR_MASK	GENMASK(7, 0)
>  #define MCQ_QCFGPTR_UNIT	0x200
>  #define MCQ_SQATTR_OFFSET(c) \
> @@ -107,6 +109,38 @@ static const struct ufshcd_res_info_t ufshcd_res_info[RES_MAX] = {
>  	{.name = "mcq_vs", .resource = NULL, .base = NULL},
>  };
>  
> +/**
> + * ufshcd_mcq_decide_queue_depth - decide the queue depth

ufshcd_mcq_calc_queue_depth - Calculate MCQ queue depth

> + * @hba - per adapter instance
> + *
> + * MAC - Max. Active Command of the Host Controller (HC)
> + * HC wouldn't send more than this commands to the device.
> + * The default MAC is 32, but the max. value may vary with
> + * vendor implementation.
> + * Calculates and adjusts the queue depth based on the depth
> + * supported by the HC and ufs device.
> + */
> +u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba)
> +{
> +	u32 qd, val;
> +	int mac;
> +
> +	mac = ufshcd_mcq_vops_get_hba_mac(hba);
> +	if (mac < 0) {
> +		val = ufshcd_readl(hba, REG_UFS_MCQ_CFG);
> +		mac = (val & MCQ_CFG_MAC_MASK) >> MCQ_CFG_MAC_OFFSET;
> +	}
> +
> +	/*  MAC is a 0 based value. */
> +	mac += 1;
> +	/* max. value of bqueuedepth = 256, mac is host dependent */
> +	qd = min_t(u32, mac, hba->dev_info.bqueuedepth);
> +	if (!qd)
> +		qd = mac;
> +
> +	return qd;
> +}
> +
>  static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
>  {
>  	struct platform_device *pdev = to_platform_device(hba->dev);
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index cf6bdd8e..6d16beb 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -51,6 +51,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
>  	enum flag_idn idn, u8 index, bool *flag_res);
>  void ufshcd_auto_hibern8_update(struct ufs_hba *hba, u32 ahit);
>  int ufshcd_mcq_init(struct ufs_hba *hba);
> +u32 ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
>  
>  #define SD_ASCII_STD true
>  #define SD_RAW false
> @@ -216,6 +217,14 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
>  		hba->vops->config_scaling_param(hba, p, data);
>  }
>  
> +static inline int ufshcd_mcq_vops_get_hba_mac(struct ufs_hba *hba)

No inline

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
> index f4bb402..a71b57e 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7759,6 +7759,7 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
>  	/* getting Specification Version in big endian format */
>  	dev_info->wspecversion = desc_buf[DEVICE_DESC_PARAM_SPEC_VER] << 8 |
>  				      desc_buf[DEVICE_DESC_PARAM_SPEC_VER + 1];
> +	dev_info->bqueuedepth = desc_buf[DEVICE_DESC_PARAM_Q_DPTH];
>  	b_ufs_feature_sup = desc_buf[DEVICE_DESC_PARAM_UFS_FEAT];
>  
>  	model_index = desc_buf[DEVICE_DESC_PARAM_PRDCT_NAME];
> @@ -8175,10 +8176,15 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
>  static int ufshcd_config_mcq(struct ufs_hba *hba)
>  {
>  	int ret;
> +	int old_nutrs = hba->nutrs;
>  
> +	hba->nutrs = ufshcd_mcq_decide_queue_depth(hba);
>  	ret = ufshcd_mcq_init(hba);
> -
> -	return ret;
> +	if (ret) {
> +		hba->nutrs = old_nutrs;
> +		return ret;
> +	}

Newline

> +	return 0;
>  }
>  
>  /**
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 473fad8..643a915 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -25,6 +25,7 @@
>  #define UFS_QCOM_DEFAULT_DBG_PRINT_EN	\
>  	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
>  
> +#define	MAX_SUPP_MAC	63

Just use a single space after #define to align with other definitions.

>  enum {
>  	TSTBUS_UAWM,
>  	TSTBUS_UARM,
> @@ -1424,6 +1425,12 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
>  }
>  #endif
>  
> +static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
> +{
> +	/* Default is 32, but Qualcomm HC supports upto 64 */

Hmm, then this should come from ufshcd, no?

Thanks,
Mani

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
> index 54d742a..630a0eb 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -293,6 +293,7 @@ struct ufs_pwr_mode_info {
>   * @config_scaling_param: called to configure clock scaling parameters
>   * @program_key: program or evict an inline encryption key
>   * @event_notify: called to notify important events
> + * @get_hba_mac: called to get vendor specific mac value
>   */
>  struct ufs_hba_variant_ops {
>  	const char *name;
> @@ -331,6 +332,7 @@ struct ufs_hba_variant_ops {
>  			       const union ufs_crypto_cfg_entry *cfg, int slot);
>  	void	(*event_notify)(struct ufs_hba *hba,
>  				enum ufs_event_type evt, void *data);
> +	int	(*get_hba_mac)(struct ufs_hba *hba);
>  };
>  
>  /* clock gating state  */
> diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
> index ef5c3a8..ca7db49d 100644
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
