Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7E73634D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjFTFx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFTFxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:53:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D510120;
        Mon, 19 Jun 2023 22:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687240402; x=1718776402;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=31mkOCWHFD3hCu7SNljzP23o0+I3E0meSjoSwQOPXjE=;
  b=BO2ebbz4rQvjn+bWESEGtQ7ox+/Sncc3Lt87F9q8czAa5H0RFqI1/m7i
   5730h2VEmCSskF/jwHOgwWN85+vCKLOeEaemSrX3kWiWXLWt/PkWSYfPP
   Lxk4rvusoXEOekQYQBNN+FZHWdPzKcPrR4Ar/hHuP1HeKzABASabHGZRT
   RuwJ81lun/CTyjiIHG8/uN/zzdp1CiE1QlcMSSfGcIhwv14Cxf7rtARCo
   eqFiPrRmNRdE0EPmyb9+7A+NZNTE0HYBZGB1W7O8YOu/s3znL9JvrtsY3
   nVBfnnI52T7FcM1wy30cSztH3rWOvsvKpwVIf3xoMHsX/lMv1ZamOHC3h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="446149743"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="446149743"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 22:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="803820937"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="803820937"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.49])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 22:53:19 -0700
Message-ID: <2281960c-33a3-3741-852e-ecd7ffd4fcbc@intel.com>
Date:   Tue, 20 Jun 2023 08:53:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH V2 2/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8
 support for express card
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Chevron Li <chevron_li@126.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com, chevron.li@bayhubtech.com
References: <20230615095012.30856-1-chevron_li@126.com>
 <20230615095012.30856-2-chevron_li@126.com>
 <4763f802-6d14-635e-6e7d-e0fc68af3453@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <4763f802-6d14-635e-6e7d-e0fc68af3453@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/23 08:50, Adrian Hunter wrote:
> On 15/06/23 12:50, Chevron Li wrote:
>> From: Chevron Li <chevron.li@bayhubtech.com>
>>
>> Add Bayhub new chip GG8 support for SD express card.
>> This patch depends on patch 1/2.
>>
>> Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Sorry, forgot about the issue further below which causes
the patch not to apply.  Please fix that, and then you can
add:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
>> ---
>> Change in V1:
>> 1.Implement the SD express card callback routine.
>> 2.Add SD express card support for Bayhub GG8 chip.
>>
>> Change in V2:
>> 1.updated some typo in patch and modified title.
>> 2.updated patch format according to reviewer's comments.
>> 3.updated the logical to try UHSI when express card initializatio failed.
>> ---
>>  drivers/mmc/host/sdhci-pci-o2micro.c | 65 +++++++++++++++++++++++++++-
>>  drivers/mmc/host/sdhci.h             |  3 ++
>>  2 files changed, 67 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
>> index 539bbafb3ff7..ad5502f3aa95 100644
>> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
>> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
>> @@ -21,6 +21,7 @@
>>   * O2Micro device registers
>>   */
>>  
>> +#define O2_SD_PCIE_SWITCH	0x54
>>  #define O2_SD_MISC_REG5		0x64
>>  #define O2_SD_LD0_CTRL		0x68
>>  #define O2_SD_DEV_CTRL		0x88
>> @@ -631,6 +632,67 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
>>  	sdhci_o2_enable_clk(host, clk);
>>  }
>>  
>> +static int sdhci_pci_o2_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
>> +	struct sdhci_pci_chip *chip = slot->chip;
>> +	u8 scratch8;
>> +	u16 scratch16;
>> +	int ret;
>> +
>> +	/* Disable clock */
>> +	sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
>> +
>> +	/* Set VDD2 voltage*/
>> +	scratch8 = sdhci_readb(host, SDHCI_POWER_CONTROL);
>> +	scratch8 &= 0x0F;
>> +	if (host->mmc->ios.timing == MMC_TIMING_SD_EXP_1_2V &&
>> +	    host->mmc->caps2 & MMC_CAP2_SD_EXP_1_2V) {
>> +		scratch8 |= SDHCI_VDD2_POWER_ON | SDHCI_VDD2_POWER_120;
>> +	} else {
>> +		scratch8 |= SDHCI_VDD2_POWER_ON | SDHCI_VDD2_POWER_180;
>> +	}
>> +
>> +	sdhci_writeb(host, scratch8, SDHCI_POWER_CONTROL);
>> +
>> +	/* UnLock WP */
>> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch8);
>> +	scratch8 &= 0x7f;
>> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
>> +
>> +	/* Wait for express card clkreqn assert */
>> +	ret = read_poll_timeout(sdhci_readb, scratch8, !(scratch8 & BIT(0)),
>> +				1, 30000, false, host, O2_SD_EXP_INT_REG);
>> +
>> +	if (!ret) {
>> +		/* Switch to PCIe mode */
>> +		scratch16 = sdhci_readw(host, O2_SD_PCIE_SWITCH);
>> +		scratch16 |= BIT(8);
>> +		sdhci_writew(host, scratch16, O2_SD_PCIE_SWITCH);
>> +	} else {
>> +		/* Power off VDD2 voltage*/
>> +		scratch8 = sdhci_readb(host, SDHCI_POWER_CONTROL);
>> +		scratch8 &= 0x0F;
>> +		sdhci_writeb(host, scratch8, SDHCI_POWER_CONTROL);
>> +
>> +		/* Keep mode as UHSI */
>> +		pci_read_config_word(chip->pdev, O2_SD_PARA_SET_REG1, &scratch16);
>> +		scratch16 &= ~BIT(11);
>> +		pci_write_config_word(chip->pdev, O2_SD_PARA_SET_REG1, scratch16);
>> +
>> +		host->mmc->ios.timing = MMC_TIMING_LEGACY;
>> +		pr_info("%s: Express card initialization failed, falling back to Legacy\n",
>> +			mmc_hostname(host->mmc));
>> +	}
>> +	/* Lock WP */
>> +	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch8);
>> +	scratch8 |= 0x80;
>> +	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
>> +
>> +	return 0;
>> +}
>> +
>>  static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>>  {
>>  	struct sdhci_pci_chip *chip;
>> @@ -703,10 +765,11 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>>  	case PCI_DEVICE_ID_O2_GG8_9861:
>>  	case PCI_DEVICE_ID_O2_GG8_9862:
>>  	case PCI_DEVICE_ID_O2_GG8_9863:
>> -		host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>> +		host->mmc->caps2 |= MMC_CAP2_NO_SDIO | MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
>>  		host->mmc->caps |= MMC_CAP_HW_RESET;
>>  		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>>  		slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
>> +		host->mmc_host_ops.init_sd_express = sdhci_pci_o2_init_sd_express;
>>  		break;
>>  	default:
>>  		break;
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index f4f2085c274c..d09640840171 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -99,6 +99,9 @@
>>  #define  SDHCI_POWER_180	0x0A
>>  #define  SDHCI_POWER_300	0x0C
>>  #define  SDHCI_POWER_330	0x0E
>> +#define  SDHCI_VDD2_POWER_ON	0x10
>> +#define  SDHCI_VDD2_POWER_180	0xA0
>> +#define  SDHCI_VDD2_POWER_120	0x80

Doesn't apply.  These definitions are already
in "next" branch of:

	git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git

>>  
>>  #define SDHCI_BLOCK_GAP_CONTROL	0x2A
>>  
> 

