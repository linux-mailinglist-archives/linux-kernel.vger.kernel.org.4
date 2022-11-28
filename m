Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB17063A822
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiK1MW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiK1MWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:22:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904A5DFE8;
        Mon, 28 Nov 2022 04:20:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A5CFB80D84;
        Mon, 28 Nov 2022 12:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42ECBC433C1;
        Mon, 28 Nov 2022 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669638034;
        bh=hwHxJwIUXRDcNgQfpP18T9DGPQgJ8ElV6U1yC2ecy1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRSu7lJaA0D7yuu98WzjVmoyeD+bzYRaqqkKWoM5K7ty7v/Bgs6+sTZYQjPKpFF3/
         mOECZOqRWaioKrgZe5qOpyiDZ0AyjCYukBgDmEuh3W5cnX0fBK0vcB4nIOpDEbUssH
         R6JooCa0PvTyW6fWLlCdtlXw1Ar45JoRIKmcbVOW6h7Y0s34dRalpQWbVBDdZo1SCr
         8jHjQ2rVwlvGOYQtld90wCKjnau3Bm+rhewLjyGN1sdJHzCj0mjhg+dqFfzlyOumEQ
         AsqsknUj9+imZeI+LXEr1wDUtwJdYUZlQlDe6lDCWv1F27PVBiWmpvNAR5CLT0z2+I
         mTmLwiDzSAuKA==
Date:   Mon, 28 Nov 2022 17:50:18 +0530
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
Subject: Re: [PATCH v5 01/16] ufs: core: Optimize duplicate code to read
 extended feature
Message-ID: <20221128122018.GA62721@thinkpad>
References: <cover.1669176158.git.quic_asutoshd@quicinc.com>
 <b95fdf1a9b7d716049e286f84b94513dc30527ed.1669176158.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b95fdf1a9b7d716049e286f84b94513dc30527ed.1669176158.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:10:14PM -0800, Asutosh Das wrote:
> The code to parse the extended feature is duplicated twice
> in the ufs core. Replace the duplicated code with a
> function.
> 
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ufs/core/ufshcd.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 768cb49..c9d7b78 100644
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
> @@ -7584,13 +7595,7 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
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
> @@ -7644,7 +7649,7 @@ static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
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

-- 
மணிவண்ணன் சதாசிவம்
