Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B9965F5C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbjAEV2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbjAEV2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:28:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E93263F5B;
        Thu,  5 Jan 2023 13:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672954099; x=1704490099;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=IzjCshA6Xqlo3HOEujdHfAHwdRRVshRkwM23YYcLu4E=;
  b=bxk6IP/MRY5cGYo067r8nDU3QDP3ml/mvXQXic2t9aICaNoLp69lyH3s
   tBIVKIzJazlSEKZiQmhVRGMUmsAPIruI8dSQRr4biTV8R2cfHI+OoRoA2
   shMAizfbE2xQUVVxGhHmhZwtmiPtzSotwAd2qfo/a9auSR6skIWv+O8+B
   g5Y4ewcOqC4LMgmiv5mifldnRhQMmYsbmbHzSmYkjt7AL2F7ai/uXGX9Q
   2XC7JG9EfdOvKF2d0ewOKNfm3vwBbmgtyQyq+y/rZyc/k78Dbsy45G86x
   RWVR7YppdeNKDKHi5oIy/OA0sdRdHGw2d+Op83lblsc/EvSfjWHF+NyKe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="408583321"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="408583321"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:28:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="744403290"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="744403290"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.42.126])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:28:15 -0800
Message-ID: <5f42c505-7c32-1027-d9a5-6fff7655eee6@intel.com>
Date:   Thu, 5 Jan 2023 23:28:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 15/24] mmc: sdhci-uhs2: add detect_init() to detect the
 interface
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-16-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221213090047.3805-16-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/22 11:00, Victor Shih wrote:
> Sdhci_uhs2_do_detect_init() is a sdhci version of mmc's uhs2_detect_init
> operation. After detected, the host's UHS-II capabilities will be set up
> here and interrupts will also be enabled.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 117 ++++++++++++++++++++++++++++++++++
>  1 file changed, 117 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 3d52d35a91a5..52587025d5e3 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -335,6 +335,123 @@ int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
> +	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
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
> +	caps_ptr = sdhci_readw(host, SDHCI_UHS2_CAPS_PTR);
> +	if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
> +		pr_err("%s: SDHCI_UHS2_CAPS_PTR(%d) is wrong.\n",
> +		       mmc_hostname(mmc), caps_ptr);
> +		return -ENODEV;
> +	}
> +	caps_gen = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_OFFSET);
> +	caps_phy = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_PHY_OFFSET);
> +	caps_tran[0] = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_TRAN_OFFSET);
> +	caps_tran[1] = sdhci_readl(host, caps_ptr + SDHCI_UHS2_CAPS_TRAN_1_OFFSET);
> +
> +	/* General Caps */
> +	mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_CAPS_DAP_MASK;
> +	mmc->uhs2_caps.gap = FIELD_GET(SDHCI_UHS2_CAPS_GAP_MASK, caps_gen);
> +	mmc->uhs2_caps.n_lanes = FIELD_GET(SDHCI_UHS2_CAPS_LANE_MASK, caps_gen);
> +	mmc->uhs2_caps.addr64 =	(caps_gen & SDHCI_UHS2_CAPS_ADDR_64) ? 1 : 0;
> +	mmc->uhs2_caps.card_type = FIELD_GET(SDHCI_UHS2_CAPS_DEV_TYPE_MASK, caps_gen);
> +
> +	/* PHY Caps */
> +	mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_CAPS_PHY_REV_MASK;
> +	mmc->uhs2_caps.speed_range = FIELD_GET(SDHCI_UHS2_CAPS_PHY_RANGE_MASK, caps_phy);
> +	mmc->uhs2_caps.n_lss_sync = FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LSS_SYN_MASK, caps_phy);
> +	mmc->uhs2_caps.n_lss_dir = FIELD_GET(SDHCI_UHS2_CAPS_PHY_N_LSS_DIR_MASK, caps_phy);
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
> +	mmc->uhs2_caps.link_rev = caps_tran[0] & SDHCI_UHS2_CAPS_TRAN_LINK_REV_MASK;
> +	mmc->uhs2_caps.n_fcu = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_N_FCU_MASK, caps_tran[0]);
> +	if (mmc->uhs2_caps.n_fcu == 0)
> +		mmc->uhs2_caps.n_fcu = 256;
> +	mmc->uhs2_caps.host_type = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_HOST_TYPE_MASK, caps_tran[0]);
> +	mmc->uhs2_caps.maxblk_len = FIELD_GET(SDHCI_UHS2_CAPS_TRAN_BLK_LEN_MASK, caps_tran[0]);
> +	mmc->uhs2_caps.n_data_gap = caps_tran[1] & SDHCI_UHS2_CAPS_TRAN_1_N_DATA_GAP_MASK;
> +
> +	return 0;
> +}
> +
> +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int ret = -EIO;
> +
> +	DBG("Begin do uhs2 detect init.\n");
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

host->ops->uhs2_reset -> sdhci_uhs2_reset

> +	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
> +	/*
> +	 * N.B SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
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

