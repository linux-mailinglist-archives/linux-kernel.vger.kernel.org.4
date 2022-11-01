Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AFC615054
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiKARPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiKARPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:15:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B333B62C9;
        Tue,  1 Nov 2022 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322879; x=1698858879;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ajAbidJi2iCZHMDGn96RwX55MkxppfpL67BgxERIR50=;
  b=lTjACX/mvsEwQDr7Cjl9eItovDL1eUZ1ryHqI5BzD33jHSp196WkP/2f
   9rsQk/essWABIGNplVLpvPOAwUtWa3W+8CrksLJp1WdljRAEXxuisioZB
   Cumhy31ns8x6UKztfOAqUKrXZdSkZY9DL9isl0ucks3um+CcuEvKjYxRV
   MPnKpxcyiN3IodkrEz+hqv4uP3WeBMeyaE58O6pryDpAPo4Qk8BPMIip6
   6qs8wYby/wgOZnEiBQApbxoblGhGr2uRjy0fj0K0cOI4tIBX09gkkC5ZY
   BY0jtFZFMfmg0k3tfMij/aHxLyPkyGxo+gqxpWTHECXQAA+c3egwguGoX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="296624474"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="296624474"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:14:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="665220106"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="665220106"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:14:35 -0700
Message-ID: <e889d37c-8034-7e0f-70aa-1ac07bce32da@intel.com>
Date:   Tue, 1 Nov 2022 19:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 16/26] mmc: sdhci-uhs2: add detect_init() to detect the
 interface
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-17-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-17-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 14:06, Victor Shih wrote:
> Sdhci_uhs2_do_detect_init() is a sdhci version of mmc's uhs2_detect_init
> operation. After detected, the host's UHS-II capabilities will be set up
> here and interrupts will also be enabled.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 146 ++++++++++++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index b535a47dc55a..9ceae552c323 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -409,12 +409,158 @@ int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>   *                                                                           *
>  \*****************************************************************************/
>  
> +static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
> +{
> +	/* 100ms */
> +	int timeout = 100000;
> +	u32 val;
> +
> +	udelay(200); /* wait for 200us before check */
> +
> +	if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_IF_DETECT),
> +				     100, timeout, true, host, SDHCI_PRESENT_STATE)) {
> +		pr_warn("%s: not detect UHS2 interface in 200us.\n", mmc_hostname(host->mmc));
> +		sdhci_dumpregs(host);
> +		return -EIO;
> +	}
> +
> +	/* Enable UHS2 error interrupts */
> +	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
> +				  SDHCI_UHS2_ERR_INT_STATUS_MASK);
> +
> +	/* 150ms */
> +	timeout = 150000;
> +	if (read_poll_timeout_atomic(sdhci_readl, val, (val & SDHCI_UHS2_LANE_SYNC),
> +				     100, timeout, true, host, SDHCI_PRESENT_STATE)) {
> +		pr_warn("%s: UHS2 Lane sync fail in 150ms.\n", mmc_hostname(host->mmc));
> +		sdhci_dumpregs(host);
> +		return -EIO;
> +	}
> +
> +	DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initialized.\n",
> +	    mmc_hostname(host->mmc));
> +	return 0;
> +}
> +
> +static int sdhci_uhs2_init(struct sdhci_host *host)
> +{
> +	u16 caps_ptr = 0;
> +	u32 caps_gen = 0;
> +	u32 caps_phy = 0;
> +	u32 caps_tran[2] = {0, 0};
> +	struct mmc_host *mmc = host->mmc;
> +
> +	caps_ptr = sdhci_readw(host, SDHCI_UHS2_HOST_CAPS_PTR);
> +	if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
> +		pr_err("%s: SDHCI_UHS2_HOST_CAPS_PTR(%d) is wrong.\n",
> +		       mmc_hostname(mmc), caps_ptr);
> +		return -ENODEV;
> +	}
> +	caps_gen = sdhci_readl(host,
> +			       caps_ptr + SDHCI_UHS2_HOST_CAPS_GEN_OFFSET);

Please wrap at 100 columns not 80, here and elsewhere.

> +	caps_phy = sdhci_readl(host,
> +			       caps_ptr + SDHCI_UHS2_HOST_CAPS_PHY_OFFSET);
> +	caps_tran[0] = sdhci_readl(host,
> +				   caps_ptr + SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET);
> +	caps_tran[1] = sdhci_readl(host,
> +				   caps_ptr
> +					+ SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET);
> +
> +	/* General Caps */
> +	mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK;
> +	mmc->uhs2_caps.gap = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK) >>
> +			     SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT;
> +	mmc->uhs2_caps.n_lanes = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK)
> +			>> SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT;
> +	mmc->uhs2_caps.addr64 =
> +		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64) ? 1 : 0;
> +	mmc->uhs2_caps.card_type =
> +		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK) >>
> +		SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT;
> +
> +	/* PHY Caps */
> +	mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK;
> +	mmc->uhs2_caps.speed_range =
> +		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK)
> +		>> SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT;
> +	mmc->uhs2_caps.n_lss_sync =
> +		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK)
> +		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT;
> +	mmc->uhs2_caps.n_lss_dir =
> +		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK)
> +		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT;
> +	if (mmc->uhs2_caps.n_lss_sync == 0)
> +		mmc->uhs2_caps.n_lss_sync = 16 << 2;
> +	else
> +		mmc->uhs2_caps.n_lss_sync <<= 2;
> +	if (mmc->uhs2_caps.n_lss_dir == 0)
> +		mmc->uhs2_caps.n_lss_dir = 16 << 3;
> +	else
> +		mmc->uhs2_caps.n_lss_dir <<= 3;
> +
> +	/* LINK/TRAN Caps */
> +	mmc->uhs2_caps.link_rev =
> +		caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK;
> +	mmc->uhs2_caps.n_fcu =
> +		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK)
> +		>> SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT;
> +	if (mmc->uhs2_caps.n_fcu == 0)
> +		mmc->uhs2_caps.n_fcu = 256;
> +	mmc->uhs2_caps.host_type =
> +		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK)
> +		>> SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT;
> +	mmc->uhs2_caps.maxblk_len =
> +		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK)
> +		>> SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT;
> +	mmc->uhs2_caps.n_data_gap =
> +		caps_tran[1] & SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK;
> +
> +	return 0;
> +}
> +
> +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int ret = -EIO;
> +
> +	DBG("%s: begin UHS2 init.\n", __func__);
> +
> +	if (sdhci_uhs2_interface_detect(host)) {
> +		pr_warn("%s: cannot detect UHS2 interface.\n",
> +			mmc_hostname(host->mmc));
> +		goto out;
> +	}
> +
> +	if (sdhci_uhs2_init(host)) {
> +		pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
> +		goto out;
> +	}
> +
> +	/* Init complete, do soft reset and enable UHS2 error irqs. */
> +	host->ops->uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> +	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
> +				  SDHCI_UHS2_ERR_INT_STATUS_MASK);
> +	/*
> +	 * !!! SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared

!!! is a little dramatic, what about just N.B.

> +	 * by SDHCI_UHS2_SW_RESET_SD
> +	 */
> +	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +
> +	ret = 0;
> +out:
> +	return ret;
> +}
> +
>  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  {
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  		sdhci_uhs2_start_signal_voltage_switch;
>  	host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
>  
> +	if (!host->mmc_host_ops.uhs2_detect_init)
> +		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;

As mentioned before ->uhs2_detect_init() is never called.

> +
>  	return 0;
>  }
>  

