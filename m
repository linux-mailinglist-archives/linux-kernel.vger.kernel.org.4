Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC6D63C3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiK2PcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiK2PcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:32:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D414019C3F;
        Tue, 29 Nov 2022 07:32:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 658BBB8167B;
        Tue, 29 Nov 2022 15:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76867C433C1;
        Tue, 29 Nov 2022 15:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669735938;
        bh=Rc/mRTNstPtUeWMK/dPadAbKK5S4ec+XTGd/LMZwaVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rODzPmENKbsIdVTT5nOcyjNgoWDpnfshrP39HUCHC6iI7Qdvupf+78Ys2tvu3aD/T
         yZsRznxz1RoZKAwlUB9S6ph1x23puSQNxQ5c43e6d4i2v8OHfIEfhzT5EWrrzRc9IQ
         02Wxf8HJgdXmCqN35ESpCObms7+qJpAS+j3WV/nA5qGQU06gKSAxBm3GYwOXzs5MRs
         ZCXXxzpT3CDB1arb6HFJ7rzLUgPJQAzjvmo8aj1xOso33sJBJhHQ7IjI0HrGUiQSz9
         epXAvh1ExxV1CRjcW7xij2jpjiU5k45iQSzZPvH/arg1SDjfWTOLI50a0NpGzRCC9v
         DR5uHJt+w8UIg==
Date:   Tue, 29 Nov 2022 21:02:03 +0530
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
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/16] ufs: core: mcq: Configure resource regions
Message-ID: <20221129153203.GF4931@workstation>
References: <cover.1669684648.git.quic_asutoshd@quicinc.com>
 <63d8921f95c3ee2678bf8b580f0bd12e93b38cde.1669684648.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d8921f95c3ee2678bf8b580f0bd12e93b38cde.1669684648.git.quic_asutoshd@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 05:20:47PM -0800, Asutosh Das wrote:
> Define the mcq resources and add support to ioremap
> the resource regions.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

My comment about the organization of struct members apply to this patch
and others also. But it is not a big deal and can be cleaned up later.
So,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/ufs/core/ufs-mcq.c     |   3 ++
>  drivers/ufs/core/ufshcd-priv.h |   8 ++++
>  drivers/ufs/host/ufs-qcom.c    | 103 +++++++++++++++++++++++++++++++++++++++++
>  include/ufs/ufshcd.h           |  30 ++++++++++++
>  4 files changed, 144 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index bf08ec5..d6807e3 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -119,7 +119,10 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
>  	int ret;
>  
>  	ret = ufshcd_mcq_config_nr_queues(hba);
> +	if (ret)
> +		return ret;
>  
> +	ret = ufshcd_vops_mcq_config_resource(hba);
>  	return ret;
>  }
>  
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index 9368ba2..74cb17b9 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -227,6 +227,14 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
>  		hba->vops->config_scaling_param(hba, p, data);
>  }
>  
> +static inline int ufshcd_vops_mcq_config_resource(struct ufs_hba *hba)
> +{
> +	if (hba->vops && hba->vops->mcq_config_resource)
> +		hba->vops->mcq_config_resource(hba);
> +
> +	return -EOPNOTSUPP;
> +}
> +
>  extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
>  
>  /**
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 8ad1415..6bea541 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -25,6 +25,12 @@
>  #define UFS_QCOM_DEFAULT_DBG_PRINT_EN	\
>  	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
>  
> +#define MCQ_QCFGPTR_MASK	GENMASK(7, 0)
> +#define MCQ_QCFGPTR_UNIT	0x200
> +#define MCQ_SQATTR_OFFSET(c) \
> +	((((c) >> 16) & MCQ_QCFGPTR_MASK) * MCQ_QCFGPTR_UNIT)
> +#define MCQ_QCFG_SIZE	0x40
> +
>  enum {
>  	TSTBUS_UAWM,
>  	TSTBUS_UARM,
> @@ -1424,6 +1430,102 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
>  }
>  #endif
>  
> +/* Resources */
> +static const struct ufshcd_res_info ufs_res_info[RES_MAX] = {
> +	{.name = "ufs_mem",},
> +	{.name = "mcq",},
> +	/* Submission Queue DAO */
> +	{.name = "mcq_sqd",},
> +	/* Submission Queue Interrupt Status */
> +	{.name = "mcq_sqis",},
> +	/* Completion Queue DAO */
> +	{.name = "mcq_cqd",},
> +	/* Completion Queue Interrupt Status */
> +	{.name = "mcq_cqis",},
> +	/* MCQ vendor specific */
> +	{.name = "mcq_vs",},
> +};
> +
> +static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
> +{
> +	struct platform_device *pdev = to_platform_device(hba->dev);
> +	struct ufshcd_res_info *res;
> +	struct resource *res_mem, *res_mcq;
> +	int i, ret = 0;
> +
> +	memcpy(hba->res, ufs_res_info, sizeof(ufs_res_info));
> +
> +	for (i = 0; i < RES_MAX; i++) {
> +		res = &hba->res[i];
> +		res->resource = platform_get_resource_byname(pdev,
> +							     IORESOURCE_MEM,
> +							     res->name);
> +		if (!res->resource) {
> +			dev_info(hba->dev, "Resource %s not provided\n", res->name);
> +			if (i == RES_UFS)
> +				return -ENOMEM;
> +			continue;
> +		} else if (i == RES_UFS) {
> +			res_mem = res->resource;
> +			res->base = hba->mmio_base;
> +			continue;
> +		}
> +
> +		res->base = devm_ioremap_resource(hba->dev, res->resource);
> +		if (IS_ERR(res->base)) {
> +			dev_err(hba->dev, "Failed to map res %s, err=%d\n",
> +					 res->name, (int)PTR_ERR(res->base));
> +			res->base = NULL;
> +			ret = PTR_ERR(res->base);
> +			return ret;
> +		}
> +	}
> +
> +	/* MCQ resource provided in DT */
> +	res = &hba->res[RES_MCQ];
> +	/* Bail if MCQ resource is provided */
> +	if (res->base)
> +		goto out;
> +
> +	/* Explicitly allocate MCQ resource from ufs_mem */
> +	res_mcq = devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
> +	if (!res_mcq) {
> +		dev_err(hba->dev, "Failed to allocate MCQ resource\n");
> +		return ret;
> +	}
> +
> +	res_mcq->start = res_mem->start +
> +			 MCQ_SQATTR_OFFSET(hba->mcq_capabilities);
> +	res_mcq->end = res_mcq->start + hba->nr_hw_queues * MCQ_QCFG_SIZE - 1;
> +	res_mcq->flags = res_mem->flags;
> +	res_mcq->name = "mcq";
> +
> +	ret = insert_resource(&iomem_resource, res_mcq);
> +	if (ret) {
> +		dev_err(hba->dev, "Failed to insert MCQ resource, err=%d\n",
> +			ret);
> +		goto insert_res_err;
> +	}
> +
> +	res->base = devm_ioremap_resource(hba->dev, res_mcq);
> +	if (IS_ERR(res->base)) {
> +		dev_err(hba->dev, "MCQ registers mapping failed, err=%d\n",
> +			(int)PTR_ERR(res->base));
> +		ret = PTR_ERR(res->base);
> +		goto ioremap_err;
> +	}
> +
> +out:
> +	hba->mcq_base = res->base;
> +	return 0;
> +ioremap_err:
> +	res->base = NULL;
> +	remove_resource(res_mcq);
> +insert_res_err:
> +	devm_kfree(hba->dev, res_mcq);
> +	return ret;
> +}
> +
>  /*
>   * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
>   *
> @@ -1447,6 +1549,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
>  	.device_reset		= ufs_qcom_device_reset,
>  	.config_scaling_param = ufs_qcom_config_scaling_param,
>  	.program_key		= ufs_qcom_ice_program_key,
> +	.mcq_config_resource	= ufs_qcom_mcq_config_resource,
>  };
>  
>  /**
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 146b613..0e21a6a 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
>   * @config_scaling_param: called to configure clock scaling parameters
>   * @program_key: program or evict an inline encryption key
>   * @event_notify: called to notify important events
> + * @mcq_config_resource: called to configure MCQ platform resources
>   */
>  struct ufs_hba_variant_ops {
>  	const char *name;
> @@ -335,6 +336,7 @@ struct ufs_hba_variant_ops {
>  			       const union ufs_crypto_cfg_entry *cfg, int slot);
>  	void	(*event_notify)(struct ufs_hba *hba,
>  				enum ufs_event_type evt, void *data);
> +	int	(*mcq_config_resource)(struct ufs_hba *hba);
>  };
>  
>  /* clock gating state  */
> @@ -724,6 +726,30 @@ struct ufs_hba_monitor {
>  };
>  
>  /**
> + * struct ufshcd_res_info_t - MCQ related resource regions
> + *
> + * @name: resource name
> + * @resource: pointer to resource region
> + * @base: register base address
> + */
> +struct ufshcd_res_info {
> +	const char *name;
> +	struct resource *resource;
> +	void __iomem *base;
> +};
> +
> +enum ufshcd_res {
> +	RES_UFS,
> +	RES_MCQ,
> +	RES_MCQ_SQD,
> +	RES_MCQ_SQIS,
> +	RES_MCQ_CQD,
> +	RES_MCQ_CQIS,
> +	RES_MCQ_VS,
> +	RES_MAX,
> +};
> +
> +/**
>   * struct ufs_hba - per adapter private structure
>   * @mmio_base: UFSHCI base register address
>   * @ucdl_base_addr: UFS Command Descriptor base address
> @@ -835,6 +861,8 @@ struct ufs_hba_monitor {
>   *	ufshcd_resume_complete()
>   * @ext_iid_sup: is EXT_IID is supported by UFSHC
>   * @mcq_sup: is mcq supported by UFSHC
> + * @res: array of resource info of MCQ registers
> + * @mcq_base: Multi circular queue registers base address
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -988,6 +1016,8 @@ struct ufs_hba {
>  	bool complete_put;
>  	bool ext_iid_sup;
>  	bool mcq_sup;
> +	struct ufshcd_res_info res[RES_MAX];
> +	void __iomem *mcq_base;
>  };
>  
>  /* Returns true if clocks can be gated. Otherwise false */
> -- 
> 2.7.4
> 
