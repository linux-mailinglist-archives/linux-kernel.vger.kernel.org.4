Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4963C3A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiK2PY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiK2PYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:24:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C28E1A39E;
        Tue, 29 Nov 2022 07:24:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D436BB816B3;
        Tue, 29 Nov 2022 15:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B37DC433D6;
        Tue, 29 Nov 2022 15:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669735459;
        bh=fUNDpswr6ncGgmCbAdi4PH0ZdGn/ge2EcUFBHR24Xhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tgcvgcHFo5SrSHfn0bp1OlaJK8HpVGGnz5UXuzI8/4x2Ejj4uT4SR0sf1Lk9O7c2O
         SuVius4Rw9AZJiXes3CPQWrdXTFKjV7rWrwImKNEJT8qdc0Q/CJCHkIxTElJ2lyt9Z
         Zed8H9bWUIahe2keem9+EhFg2zeBYHoqx7sWoe+s1xXT+0VqymXQc9Ima1EOhVM1rL
         goWieKouBFU//hHDVNodTnjI+Vq+rk9/kHFSNN49UgdaI7a+RhOdUNAGPTBgQeDyac
         0RpB/2HUVPUoFvN+BHvUzzKnQZY3Z19und0PRD4N0LuDb8TnZdk1zhD3zKjQKwAHr5
         Xsynv0pBHMsJw==
Date:   Tue, 29 Nov 2022 20:54:04 +0530
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
Subject: Re: [PATCH v6 01/16] ufs: core: Optimize duplicate code to read
 extended feature
Message-ID: <20221129152404.GB4931@workstation>
References: <cover.1669684648.git.quic_asutoshd@quicinc.com>
 <773db7d025539dd1413281128416e36f324f8ac0.1669684648.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773db7d025539dd1413281128416e36f324f8ac0.1669684648.git.quic_asutoshd@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 05:20:42PM -0800, Asutosh Das wrote:
> The code to parse the extended feature is duplicated twice
> in the ufs core. Replace the duplicated code with a
> function.
> 
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Looks like you missed my tag. But anyhow:

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/ufs/core/ufshcd.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 2dbe249..6ea22b5 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -215,6 +215,17 @@ ufs_get_desired_pm_lvl_for_dev_link_state(enum ufs_dev_pwr_mode dev_state,
>  	return UFS_PM_LVL_0;
>  }
>  
> +static unsigned int ufs_get_ext_ufs_feature(struct ufs_hba *hba,
> +					    const u8 *desc_buf)
> +{
> +	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
> +	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
> +		return 0;
> +
> +	return get_unaligned_be32(desc_buf +
> +				  DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
> +}
> +
>  static const struct ufs_dev_quirk ufs_fixups[] = {
>  	/* UFS cards deviations table */
>  	{ .wmanufacturerid = UFS_VENDOR_MICRON,
> @@ -7608,13 +7619,7 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
>  	     (hba->dev_quirks & UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES)))
>  		goto wb_disabled;
>  
> -	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
> -	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
> -		goto wb_disabled;
> -
> -	ext_ufs_feature = get_unaligned_be32(desc_buf +
> -					DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
> -
> +	ext_ufs_feature = ufs_get_ext_ufs_feature(hba, desc_buf);
>  	if (!(ext_ufs_feature & UFS_DEV_WRITE_BOOSTER_SUP))
>  		goto wb_disabled;
>  
> @@ -7668,7 +7673,7 @@ static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
>  	if (!(hba->caps & UFSHCD_CAP_TEMP_NOTIF) || dev_info->wspecversion < 0x300)
>  		return;
>  
> -	ext_ufs_feature = get_unaligned_be32(desc_buf + DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
> +	ext_ufs_feature = ufs_get_ext_ufs_feature(hba, desc_buf);
>  
>  	if (ext_ufs_feature & UFS_DEV_LOW_TEMP_NOTIF)
>  		mask |= MASK_EE_TOO_LOW_TEMP;
> -- 
> 2.7.4
> 
