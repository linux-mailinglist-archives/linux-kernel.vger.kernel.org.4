Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59D863C3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiK2PZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiK2PZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:25:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7A81A39E;
        Tue, 29 Nov 2022 07:25:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BB7AB816D5;
        Tue, 29 Nov 2022 15:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D365BC433D6;
        Tue, 29 Nov 2022 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669735525;
        bh=DL/Ixu/1iVGLfgLb7D4QTrvlMRvEou/vbYz5K603i/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lvCeeR/JuiwQgdls8+t4gI4b4XpquUZ0nHteQw3Fyu8oi4uIopKbaEzyYoEYays/j
         w1+9reJ4QC5dbV1UAondpxNljrLTG2she79V4NRZ+KbAX5KTi6oTaiIvUCJdcacINe
         EQnYWzsPyzK0P7RtbD/hIGfPtH/3RGkrZDNVSXN2QIma6b8LWNv2nPOOEEXoldG3C5
         WKkl9Dlz1dzYXwHLCribxVNM24JVDvlgl8p9aXsyHGCgiO2PNETDS87AYRp8N7JOkm
         QbCL6L56r3vQmXEzICVD4TlGnACuIsATl3YCzDf2A4KuZaNykJp6S3rGmi7pz0fTS5
         FuNsw4sidoTDA==
Date:   Tue, 29 Nov 2022 20:55:11 +0530
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
Subject: Re: [PATCH v6 02/16] ufs: core: Probe for ext_iid support
Message-ID: <20221129152511.GC4931@workstation>
References: <cover.1669684648.git.quic_asutoshd@quicinc.com>
 <9a6baa667f561eaa8883d56a13805fc90ace3c3f.1669684648.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a6baa667f561eaa8883d56a13805fc90ace3c3f.1669684648.git.quic_asutoshd@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 05:20:43PM -0800, Asutosh Das wrote:
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

Here also, my tag is missed:

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

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
> index 6ea22b5..595fd3c 100644
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
> @@ -7687,6 +7691,30 @@ static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
>  	}
>  }
>  
> +static void ufshcd_ext_iid_probe(struct ufs_hba *hba, u8 *desc_buf)
> +{
> +	struct ufs_dev_info *dev_info = &hba->dev_info;
> +	u32 ext_ufs_feature;
> +	u32 ext_iid_en = 0;
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
> @@ -7785,6 +7813,9 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
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
