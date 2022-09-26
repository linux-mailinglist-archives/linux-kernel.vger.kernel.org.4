Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381945EAB72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbiIZPor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbiIZPoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:44:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4436A1D0C9;
        Mon, 26 Sep 2022 07:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2F9AB80AC0;
        Mon, 26 Sep 2022 14:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F470C433D6;
        Mon, 26 Sep 2022 14:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664202463;
        bh=6XhwjXcZLlj11shsoIVoitYifkIL8KJ18fK8qdwwJaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6BO0l+twKh0uOwzbNup4x8XNE5qQ3DVeM7zC8zziatoxj7iovnihxWrTl72tT+YX
         g1yl5O3LK3Tau44JkbBBXNDCn6X2cSB9yu+qJVu269GvQIfGuu9tCJZFtoDmMylnkf
         IIRYOTKBv9aMeyWR9G0qvdpv/PQvcf/LspKLCZZLJEWLL89scU/VjfGmWIDGwhVVTa
         PljFRM3zMuEgs26zt98cYvBItT640NVZPhMwlYjf3E+T6N/LJaAS3sd9DxOsRnh4F9
         3ADscsCVxm9M7aGzjRbBA3unk5xVg0Digff9Nz86F4RF8vmUz+euOET4pFOB5v5mN5
         7YXCFbXTWve0A==
Date:   Mon, 26 Sep 2022 19:57:34 +0530
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
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1 02/16] ufs: core: Introduce Multi-circular queue
 capability
Message-ID: <20220926142734.GD101994@thinkpad>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
 <fa3d70c1642c64ce75461f630eabe84b3b974d4e.1663894792.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa3d70c1642c64ce75461f630eabe84b3b974d4e.1663894792.git.quic_asutoshd@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:05:09PM -0700, Asutosh Das wrote:
> Adds support to check for MCQ capability in the UFSHC.
> This capability can be used by host drivers to control
> MCQ enablement.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> ---
>  drivers/ufs/core/ufshcd.c |  5 +++++
>  include/ufs/ufshcd.h      | 13 +++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 4b9ae83..24661fc 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -89,6 +89,7 @@
>  #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
>  
>  #define EXT_IID_CAP_SHIFT 10
> +#define MCQ_SUPP_SHIFT 30
>  #define ufshcd_toggle_vreg(_dev, _vreg, _on)				\
>  	({                                                              \
>  		int _ret;                                               \
> @@ -2240,6 +2241,10 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
>  	if (err)
>  		dev_err(hba->dev, "crypto setup failed\n");
>  
> +	hba->mcq_sup = (hba->capabilities & MASK_MCQ_SUPPORT) >> MCQ_SUPP_SHIFT;

Again, if you use FIELD_* macro, addtional *_SHIFT macro is not needed.

> +	if (!hba->mcq_sup)
> +		return err;

Since this is not an error case, you can return 0 explicitly.

> +
>  	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
>  	hba->ext_iid_sup = (hba->mcq_capabilities & MASK_EXT_IID_SUPPORT) >>
>  		EXT_IID_CAP_SHIFT;
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index da1eb8a..da7ec0c 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -660,6 +660,12 @@ enum ufshcd_caps {
>  	 * notification if it is supported by the UFS device.
>  	 */
>  	UFSHCD_CAP_TEMP_NOTIF				= 1 << 11,
> +
> +	/*
> +	 * This capability allows the host controller driver to turn on/off
> +	 * MCQ mode. MCQ mode may be used to increase performance.
> +	 */
> +	UFSHCD_CAP_MCQ_EN				= 1 << 12,
>  };
>  
>  struct ufs_hba_variant_params {
> @@ -820,6 +826,7 @@ struct ufs_hba_monitor {
>   * @complete_put: whether or not to call ufshcd_rpm_put() from inside
>   *	ufshcd_resume_complete()
>   * @ext_iid_sup: is EXT_IID is supported by UFSHC
> + * @mcq_sup: is mcq supported by UFSHC
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -969,8 +976,14 @@ struct ufs_hba {
>  	u32 luns_avail;
>  	bool complete_put;
>  	bool ext_iid_sup;
> +	bool mcq_sup;
>  };
>  
> +static inline bool is_mcq_supported(struct ufs_hba *hba)

No inline please. Compiler is the best judge.

Thanks,
Mani

> +{
> +	return hba->mcq_sup && (hba->caps & UFSHCD_CAP_MCQ_EN);
> +}
> +
>  /* Returns true if clocks can be gated. Otherwise false */
>  static inline bool ufshcd_is_clkgating_allowed(struct ufs_hba *hba)
>  {
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
