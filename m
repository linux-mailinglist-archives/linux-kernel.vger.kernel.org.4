Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0255F5EAAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiIZPYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbiIZPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607AC5D115;
        Mon, 26 Sep 2022 07:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 738BF60DD6;
        Mon, 26 Sep 2022 14:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1049FC43150;
        Mon, 26 Sep 2022 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201342;
        bh=rqkp6bJXgU7Uu/k1ZisPoN8JNAGp0zmSPs5x+aM9Irs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvAZDPSk/ijQh8WSq5yeRncXQBYeASs3IoqT6uEwHeA3LHD8MOj27K+Jt4sXD4Hsh
         TJ9ygtRTbdGmqnGVPqBWY3tNCy0tx4qExVdDpetDLYGKXT8vT6697RYuqHDNCIPdzR
         L+8iQZYEQ1CQaWn6tXCQw+2wL9UBVtGvJcE+xHfIwX/lkiQaP5xP94Spmu/ED/GN+0
         8pBKDTuoEpmxPHr9RRnS8dmY95bUUu4+rnQsgVRJoqiSYu98AOrKE94jE0ddKjHnv+
         3sOg5TU2FjKDP2Re0X+kIzTX3E3vBAEU+xs2h0zsBu0+TC32N4JF3meZTQ/Or86Po1
         Lc4OR56MHPGdg==
Date:   Mon, 26 Sep 2022 19:38:53 +0530
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 01/16] ufs: core: Probe for ext_iid support
Message-ID: <20220926140853.GC101994@thinkpad>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <ff7cdcdef82f6c9d709e2b6ed5d91e255327b780.1663894792.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff7cdcdef82f6c9d709e2b6ed5d91e255327b780.1663894792.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:05:08PM -0700, Asutosh Das wrote:
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
> ---
>  drivers/ufs/core/ufshcd.c | 32 ++++++++++++++++++++++++++++++++
>  include/ufs/ufs.h         |  4 ++++
>  include/ufs/ufshcd.h      |  4 ++++
>  include/ufs/ufshci.h      |  7 +++++++
>  4 files changed, 47 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index f4f8ded..4b9ae83 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -88,6 +88,7 @@
>  /* Polling time to wait for fDeviceInit */
>  #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
>  
> +#define EXT_IID_CAP_SHIFT 10
>  #define ufshcd_toggle_vreg(_dev, _vreg, _on)				\
>  	({                                                              \
>  		int _ret;                                               \
> @@ -2239,6 +2240,10 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
>  	if (err)
>  		dev_err(hba->dev, "crypto setup failed\n");
>  
> +	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
> +	hba->ext_iid_sup = (hba->mcq_capabilities & MASK_EXT_IID_SUPPORT) >>
> +		EXT_IID_CAP_SHIFT;
> +

Can you use FIELD_* macros for the field manipulations throughout the series?
This will avoid the use of additional _SHIFT macros.

>  	return err;
>  }
>  
> @@ -7664,6 +7669,30 @@ static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
>  	}
>  }
>  
> +static void ufshcd_ext_iid_probe(struct ufs_hba *hba, u8 *desc_buf)

ufshcd_device_ext_iid_probe?

> +{
> +	struct ufs_dev_info *dev_info = &hba->dev_info;
> +	u32 ext_ufs_feature;
> +	u32 ext_iid_en = 0;
> +	int err;
> +
> +	if (dev_info->wspecversion < 0x400)
> +		goto out;
> +
> +	ext_ufs_feature = get_unaligned_be32(desc_buf + DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
> +

No need of a newline

Thanks,
Mani

> +	if (!(ext_ufs_feature & UFS_DEV_EXT_IID_SUP))
> +		goto out;
> +
> +	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +				      QUERY_ATTR_IDN_EXT_IID_EN, 0, 0, &ext_iid_en);
> +	if (err)
> +		dev_err(hba->dev, "failed reading bEXTIIDEn. err = %d\n", err);
> +
> +out:
> +	dev_info->b_ext_iid_en = !!ext_iid_en;
> +}
> +
>  void ufshcd_fixup_dev_quirks(struct ufs_hba *hba,
>  			     const struct ufs_dev_quirk *fixups)
>  {
> @@ -7762,6 +7791,9 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
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
> index 7fe1a92..da1eb8a 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -737,6 +737,7 @@ struct ufs_hba_monitor {
>   * @outstanding_lock: Protects @outstanding_reqs.
>   * @outstanding_reqs: Bits representing outstanding transfer requests
>   * @capabilities: UFS Controller Capabilities
> + * @mcq_capabilities: UFS Multi Command Queue capabilities
>   * @nutrs: Transfer Request Queue depth supported by controller
>   * @nutmrs: Task Management Queue depth supported by controller
>   * @reserved_slot: Used to submit device commands. Protected by @dev_cmd.lock.
> @@ -818,6 +819,7 @@ struct ufs_hba_monitor {
>   *	device
>   * @complete_put: whether or not to call ufshcd_rpm_put() from inside
>   *	ufshcd_resume_complete()
> + * @ext_iid_sup: is EXT_IID is supported by UFSHC
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -859,6 +861,7 @@ struct ufs_hba {
>  
>  	u32 capabilities;
>  	int nutrs;
> +	u32 mcq_capabilities;
>  	int nutmrs;
>  	u32 reserved_slot;
>  	u32 ufs_version;
> @@ -965,6 +968,7 @@ struct ufs_hba {
>  #endif
>  	u32 luns_avail;
>  	bool complete_put;
> +	bool ext_iid_sup;
>  };
>  
>  /* Returns true if clocks can be gated. Otherwise false */
> diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
> index f81aa95..ef5c3a8 100644
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
