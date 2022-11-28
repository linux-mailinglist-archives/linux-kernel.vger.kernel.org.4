Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795063A8C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiK1MyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiK1MyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:54:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD5315A2C;
        Mon, 28 Nov 2022 04:53:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D02086116A;
        Mon, 28 Nov 2022 12:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3EFC433C1;
        Mon, 28 Nov 2022 12:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669640038;
        bh=5YMBgBHbiI5ucnZji8ODGK5VNaLR2nVSSk6RpRVsnoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLukV95y/MQTlIeDozB/IqPe5U+RcumxuUoLvGRJ4Ao/Gt5Di9mFB/3CsksOQP9P7
         tv8T8r+xaJ8FGD35Y+D8bkiD8+pt5T5eytBmxFQ7qtiVOcd+nu47hOKmMf2dlOybm1
         sC2OKF6uww9aS5pu+f37nDdL+bpYW1guo4YL9QrydShC/0hKMFuufwSnU6DUPrFJ1A
         MXTOcR8GN9rdL6uZgsR/8eGDA62KFLdNcdkY3aBd6A1P8fx2+b79PhexQw8DyWoNYR
         M11ybe/0kDzNSfBLrUMEMDgoJQRRP1rtC4U7enUKIxYff8E4IvdmhRqDCAzQjL97xJ
         ky8VS/UvHfVfg==
Date:   Mon, 28 Nov 2022 18:23:41 +0530
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
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/16] ufs: core: Probe for ext_iid support
Message-ID: <20221128125341.GB62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <7cb284c2ba6f4065f9c84a91f4bf100a26c73383.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cb284c2ba6f4065f9c84a91f4bf100a26c73383.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:15PM -0800, Asutosh Das wrote:
> Task Tag is limited to 8 bits and this restricts the number
> of active IOs to 255.
> In Multi-circular queue mode, this may not be enough.
> The specification provides EXT_IID which can be used to increase
> the number of IOs if the UFS device and UFSHC support it.
> This patch adds support to probe for ext_iid support in
> ufs device and UFSHC.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

One nitpick below. But even without addressing that, this patch looks good to
me.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/ufs/core/ufshcd.c | 31 +++++++++++++++++++++++++++++++
>  include/ufs/ufs.h         |  4 ++++
>  include/ufs/ufshcd.h      |  4 ++++
>  include/ufs/ufshci.h      |  7 +++++++
>  4 files changed, 46 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index c9d7b78..66b797f 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2258,6 +2258,10 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
>  	if (err)
>  		dev_err(hba->dev, "crypto setup failed\n");
>  
> +	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
> +	hba->ext_iid_sup = FIELD_GET(MASK_EXT_IID_SUPPORT,
> +				     hba->mcq_capabilities);
> +
>  	return err;
>  }
>  
> @@ -7663,6 +7667,30 @@ static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
>  	}
>  }
>  
> +static void ufshcd_ext_iid_probe(struct ufs_hba *hba, u8 *desc_buf)
> +{
> +	struct ufs_dev_info *dev_info = &hba->dev_info;
> +	u32 ext_ufs_feature;
> +	u32 ext_iid_en = 0;

Given that scsi_host_alloc() uses kzalloc(), there is no need to explicitly set
the b_ext_iid_en to 0 in case of failure.

Thanks,
Mani

> +	int err;
> +
> +	/* Only UFS-4.0 and above may support EXT_IID */
> +	if (dev_info->wspecversion < 0x400)
> +		goto out;
> +
> +	ext_ufs_feature = ufs_get_ext_ufs_feature(hba, desc_buf);
> +	if (!(ext_ufs_feature & UFS_DEV_EXT_IID_SUP))
> +		goto out;
> +
> +	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +				      QUERY_ATTR_IDN_EXT_IID_EN, 0, 0, &ext_iid_en);
> +	if (err)
> +		dev_err(hba->dev, "failed reading bEXTIIDEn. err = %d\n", err);
> +
> +out:
> +	dev_info->b_ext_iid_en = ext_iid_en;
> +}
> +
>  void ufshcd_fixup_dev_quirks(struct ufs_hba *hba,
>  			     const struct ufs_dev_quirk *fixups)
>  {
> @@ -7761,6 +7789,9 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
>  
>  	ufshcd_temp_notif_probe(hba, desc_buf);
>  
> +	if (hba->ext_iid_sup)
> +		ufshcd_ext_iid_probe(hba, desc_buf);
> +
>  	/*
>  	 * ufshcd_read_string_desc returns size of the string
>  	 * reset the error value
> diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
> index 1bba3fe..ba2a1d8 100644
> --- a/include/ufs/ufs.h
> +++ b/include/ufs/ufs.h
> @@ -165,6 +165,7 @@ enum attr_idn {
>  	QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE       = 0x1D,
>  	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
>  	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
> +	QUERY_ATTR_IDN_EXT_IID_EN		= 0x2A,
>  };
>  
>  /* Descriptor idn for Query requests */
> @@ -352,6 +353,7 @@ enum {
>  	UFS_DEV_EXT_TEMP_NOTIF		= BIT(6),
>  	UFS_DEV_HPB_SUPPORT		= BIT(7),
>  	UFS_DEV_WRITE_BOOSTER_SUP	= BIT(8),
> +	UFS_DEV_EXT_IID_SUP		= BIT(16),
>  };
>  #define UFS_DEV_HPB_SUPPORT_VERSION		0x310
>  
> @@ -601,6 +603,8 @@ struct ufs_dev_info {
>  
>  	bool	b_rpm_dev_flush_capable;
>  	u8	b_presrv_uspc_en;
> +	/* UFS EXT_IID Enable */
> +	bool	b_ext_iid_en;
>  };
>  
>  /*
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 5cf81df..aec37cb9 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -747,6 +747,7 @@ struct ufs_hba_monitor {
>   * @outstanding_lock: Protects @outstanding_reqs.
>   * @outstanding_reqs: Bits representing outstanding transfer requests
>   * @capabilities: UFS Controller Capabilities
> + * @mcq_capabilities: UFS Multi Circular Queue capabilities
>   * @nutrs: Transfer Request Queue depth supported by controller
>   * @nutmrs: Task Management Queue depth supported by controller
>   * @reserved_slot: Used to submit device commands. Protected by @dev_cmd.lock.
> @@ -830,6 +831,7 @@ struct ufs_hba_monitor {
>   *	device
>   * @complete_put: whether or not to call ufshcd_rpm_put() from inside
>   *	ufshcd_resume_complete()
> + * @ext_iid_sup: is EXT_IID is supported by UFSHC
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -871,6 +873,7 @@ struct ufs_hba {
>  
>  	u32 capabilities;
>  	int nutrs;
> +	u32 mcq_capabilities;
>  	int nutmrs;
>  	u32 reserved_slot;
>  	u32 ufs_version;
> @@ -978,6 +981,7 @@ struct ufs_hba {
>  #endif
>  	u32 luns_avail;
>  	bool complete_put;
> +	bool ext_iid_sup;
>  };
>  
>  /* Returns true if clocks can be gated. Otherwise false */
> diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
> index f525566..4d4da06 100644
> --- a/include/ufs/ufshci.h
> +++ b/include/ufs/ufshci.h
> @@ -22,6 +22,7 @@ enum {
>  /* UFSHCI Registers */
>  enum {
>  	REG_CONTROLLER_CAPABILITIES		= 0x00,
> +	REG_MCQCAP				= 0x04,
>  	REG_UFS_VERSION				= 0x08,
>  	REG_CONTROLLER_DEV_ID			= 0x10,
>  	REG_CONTROLLER_PROD_ID			= 0x14,
> @@ -68,6 +69,12 @@ enum {
>  	MASK_OUT_OF_ORDER_DATA_DELIVERY_SUPPORT	= 0x02000000,
>  	MASK_UIC_DME_TEST_MODE_SUPPORT		= 0x04000000,
>  	MASK_CRYPTO_SUPPORT			= 0x10000000,
> +	MASK_MCQ_SUPPORT			= 0x40000000,
> +};
> +
> +/* MCQ capability mask */
> +enum {
> +	MASK_EXT_IID_SUPPORT = 0x00000400,
>  };
>  
>  #define UFS_MASK(mask, offset)		((mask) << (offset))
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
