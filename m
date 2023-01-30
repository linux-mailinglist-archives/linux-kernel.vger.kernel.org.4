Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF55680EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbjA3NQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbjA3NQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:16:21 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24F12078;
        Mon, 30 Jan 2023 05:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675084579; x=1706620579;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mGIh1VywtFW4GVPUJhdZz7u6BYBjRFe0fz9VBVJlPNk=;
  b=bYivS/zYLDa4Z1R1EX6oeq4ti6JWiLLXzVarwJTf9HRjcy+D/QBTlofS
   w8yoXD20a4XYRoDGNhjrS0XiRN6yCF6MeWzZdTHTC8/j9+2U0O7vxwnHr
   P/evx7yRBvLAyU3xrpG36aRsqvSHC08eoXEeEFuJbJFLWxHbfBOy9K+mO
   APd1o04e6+mYM27XviclDS1u3AF8ekwxDz8jYiTygsCwbjDVqb9KDZel/
   Nk+IkpFJnBGXVQe5oe9iRQ/rlSboKx6oMYN5Tet57XkaM1KSoHCZLmEpI
   frk31+RaZK8L9zvQD+XdEHVMFiBR4g8T7M5+jELN1S5XpKVRWFHbcQo5C
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328828623"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="328828623"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 05:16:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="992899074"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="992899074"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.33.106])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 05:16:15 -0800
Message-ID: <db9641da-088f-8c69-f3b9-64c12d9621cb@intel.com>
Date:   Mon, 30 Jan 2023 15:16:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V6 14/24] mmc: sdhci-uhs2: add set_ios()
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-15-victor.shih@genesyslogic.com.tw>
 <fcd88dd6-4538-cb35-a4e8-750bef1a6c08@intel.com>
 <CAK00qKB7byDgsRtRFVxFzDZAtrqTM7wny7q+zGqnY+M+sNAfUw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAK00qKB7byDgsRtRFVxFzDZAtrqTM7wny7q+zGqnY+M+sNAfUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/23 12:58, Victor Shih wrote:
> Hi, Adrian
> 
> On Fri, Jan 6, 2023 at 5:28 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 13/12/22 11:00, Victor Shih wrote:
>>> This is a sdhci version of mmc's set_ios operation.
>>> It covers both UHS-I and UHS-II.
>>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>>> ---
>>>  drivers/mmc/host/sdhci-uhs2.c | 96 +++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci-uhs2.h |  1 +
>>>  drivers/mmc/host/sdhci.c      | 53 +++++++++++--------
>>>  drivers/mmc/host/sdhci.h      |  2 +
>>>  4 files changed, 131 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>>> index 00b1b69b49ea..3d52d35a91a5 100644
>>> --- a/drivers/mmc/host/sdhci-uhs2.c
>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>>> @@ -213,6 +213,68 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
>>>
>>> +/**
>>> + * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable register
>>> + * @host:    SDHCI host
>>> + * @clear:   bit-wise clear mask
>>> + * @set:     bit-wise set mask
>>> + *
>>> + * Set/unset bits in UHS-II Error Interrupt Status Enable register
>>> + */
>>> +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
>>> +{
>>> +     u32 ier;
>>> +
>>> +     ier = sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE);
>>> +     ier &= ~clear;
>>> +     ier |= set;
>>> +     sdhci_writel(host, ier, SDHCI_UHS2_INT_STATUS_ENABLE);
>>> +     sdhci_writel(host, ier, SDHCI_UHS2_INT_SIGNAL_ENABLE);
>>> +}
>>> +EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
>>> +
>>> +static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>> +{
>>> +     struct sdhci_host *host = mmc_priv(mmc);
>>> +     u8 cmd_res, dead_lock;
>>> +     u16 ctrl_2;
>>> +
>>> +     /* UHS2 Timeout Control */
>>> +     sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
>>> +
>>> +     /* change to use calculate value */
>>> +     cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
>>> +
>>> +     sdhci_uhs2_clear_set_irqs(host,
>>> +                               SDHCI_UHS2_INT_CMD_TIMEOUT |
>>> +                               SDHCI_UHS2_INT_DEADLOCK_TIMEOUT,
>>> +                               0);
>>> +     sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
>>> +     sdhci_uhs2_clear_set_irqs(host, 0,
>>> +                               SDHCI_UHS2_INT_CMD_TIMEOUT |
>>> +                               SDHCI_UHS2_INT_DEADLOCK_TIMEOUT);
>>> +
>>> +     /* UHS2 timing */
>>
>> Please extend comment to include:
>>
>>         Note, UHS2 timing is disabled when powering off
>>
>>> +     ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> +     if (ios->timing == MMC_TIMING_SD_UHS2)
>>> +             ctrl_2 |= SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
>>> +     else
>>> +             ctrl_2 &= ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
>>> +     sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>> +
>>> +     if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
>>> +             sdhci_enable_preset_value(host, true);
>>> +
>>> +     if (host->ops->set_power)
>>> +             host->ops->set_power(host, ios->power_mode, ios->vdd);
>>> +     else
>>> +             sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
>>
>> sdhci_set_ios_common() already set the power.  Are both needed?
>>
>>> +     udelay(100);
>>
>> Please add a comment for why this delay is here.
>>
>>> +
>>> +     host->timing = ios->timing;
>>
>> Please move this up to where the timing change is.
>>
> 
> The ios->timing was changed in sd_uhs2_power_up function and not
> modified in this function(__sdhci_uhs2_set_ios), therefore would you
> want me to move this to the sd_uhs2_power_up function?

No

> 
> As I know the ios->timing is used in sdhci_set_clock function, setting
> the host->timing before call the sdhci_set_clock function ensures that
> the host->timing used in sdhci_set_clock function is the most recent
> value. What do you think about this?

I just meant move it below the timing chunk i.e.

	/* UHS2 timing. Note, UHS2 timing is disabled when powering off */
	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
	if (ios->timing == MMC_TIMING_SD_UHS2)
		ctrl_2 |= SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
	else
		ctrl_2 &= ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
	host->timing = ios->timing;

> 
>>> +     sdhci_set_clock(host, host->clock);
>>> +}
>>> +
>>>  /*****************************************************************************\
>>>   *                                                                           *
>>>   * MMC callbacks                                                             *
>>> @@ -234,6 +296,39 @@ static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
>>>       return sdhci_start_signal_voltage_switch(mmc, ios);
>>>  }
>>>
>>> +int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>
>> Should be static
>>
>>> +{
>>> +     struct sdhci_host *host = mmc_priv(mmc);
>>> +
>>> +     if (!(host->version >= SDHCI_SPEC_400) ||
>>> +         !(host->mmc->flags & MMC_UHS2_SUPPORT &&
>>> +           host->mmc->caps2 & MMC_CAP2_SD_UHS2)) {
>>
>> This can be just:
>>
>>         if (!sdhci_uhs2_mode(host)) {
>>
>> Not sure if this is actually possible?
>>
>>> +             sdhci_set_ios(mmc, ios);
>>> +             return 0;
>>> +     }
>>> +
>>> +     if (ios->power_mode == MMC_POWER_UNDEFINED)
>>> +             return 0;
>>> +
>>> +     if (host->flags & SDHCI_DEVICE_DEAD) {
>>> +             if (!IS_ERR(mmc->supply.vmmc) &&
>>> +                 ios->power_mode == MMC_POWER_OFF)
>>> +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>>> +             if (!IS_ERR_OR_NULL(mmc->supply.vmmc2) &&
>>> +                 ios->power_mode == MMC_POWER_OFF)
>>> +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
>>
>> This can be just:
>>
>>                 if (ios->power_mode == MMC_POWER_OFF) {
>>                         mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>>                         mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
>>                 }
>>
>>> +             return -1;
>>> +     }
>>> +
>>> +     host->timing = ios->timing;
>>
>> __sdhci_uhs2_set_ios() does this so it is not needed here.
>>
>>> +
>>> +     sdhci_set_ios_common(mmc, ios);
>>> +
>>> +     __sdhci_uhs2_set_ios(mmc, ios);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>  /*****************************************************************************\
>>>   *                                                                           *
>>>   * Driver init/exit                                                          *
>>> @@ -244,6 +339,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>>>  {
>>>       host->mmc_host_ops.start_signal_voltage_switch =
>>>               sdhci_uhs2_start_signal_voltage_switch;
>>> +     host->mmc_host_ops.uhs2_set_ios = sdhci_uhs2_set_ios;
>>>
>>>       return 0;
>>>  }
>>> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
>>> index a58ef19c08aa..184fee80253c 100644
>>> --- a/drivers/mmc/host/sdhci-uhs2.h
>>> +++ b/drivers/mmc/host/sdhci-uhs2.h
>>> @@ -178,5 +178,6 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host);
>>>  bool sdhci_uhs2_mode(struct sdhci_host *host);
>>>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>>>  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
>>> +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
>>>
>>>  #endif /* __SDHCI_UHS2_H */
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 99633a3ef549..49bbdc155b2b 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -47,8 +47,6 @@
>>>  static unsigned int debug_quirks = 0;
>>>  static unsigned int debug_quirks2;
>>>
>>> -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
>>> -
>>>  static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
>>>
>>>  void sdhci_dumpregs(struct sdhci_host *host)
>>> @@ -1877,6 +1875,9 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>>>       case MMC_TIMING_MMC_HS400:
>>>               preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
>>>               break;
>>> +     case MMC_TIMING_SD_UHS2:
>>> +             preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
>>> +             break;
>>>       default:
>>>               pr_warn("%s: Invalid UHS-I mode selected\n",
>>>                       mmc_hostname(host->mmc));
>>> @@ -2325,24 +2326,9 @@ static bool sdhci_presetable_values_change(struct sdhci_host *host, struct mmc_i
>>>              (sdhci_preset_needed(host, ios->timing) || host->drv_type != ios->drv_type);
>>>  }
>>>
>>> -void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>> +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
>>>  {
>>>       struct sdhci_host *host = mmc_priv(mmc);
>>> -     bool reinit_uhs = host->reinit_uhs;
>>> -     bool turning_on_clk = false;
>>> -     u8 ctrl;
>>> -
>>> -     host->reinit_uhs = false;
>>> -
>>> -     if (ios->power_mode == MMC_POWER_UNDEFINED)
>>> -             return;
>>> -
>>> -     if (host->flags & SDHCI_DEVICE_DEAD) {
>>> -             if (!IS_ERR(mmc->supply.vmmc) &&
>>> -                 ios->power_mode == MMC_POWER_OFF)
>>> -                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>>> -             return;
>>> -     }
>>>
>>>       /*
>>>        * Reset the chip on each power off.
>>> @@ -2359,8 +2345,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>               sdhci_enable_preset_value(host, false);
>>>
>>>       if (!ios->clock || ios->clock != host->clock) {
>>> -             turning_on_clk = ios->clock && !host->clock;
>>> -
>>>               host->ops->set_clock(host, ios->clock);
>>>               host->clock = ios->clock;
>>>
>>> @@ -2381,6 +2365,32 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>               host->ops->set_power(host, ios->power_mode, ios->vdd);
>>>       else
>>>               sdhci_set_power(host, ios->power_mode, ios->vdd);
>>> +}
>>> +EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
>>> +
>>> +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>> +{
>>> +     struct sdhci_host *host = mmc_priv(mmc);
>>> +     bool reinit_uhs = host->reinit_uhs;
>>> +     bool turning_on_clk = false;
>>> +     u8 ctrl;
>>> +
>>> +     host->reinit_uhs = false;
>>> +
>>> +     if (ios->power_mode == MMC_POWER_UNDEFINED)
>>> +             return;
>>> +
>>> +     if (host->flags & SDHCI_DEVICE_DEAD) {
>>> +             if (!IS_ERR(mmc->supply.vmmc) &&
>>> +                 ios->power_mode == MMC_POWER_OFF)
>>> +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>>> +             return;
>>> +     }
>>> +
>>> +     sdhci_set_ios_common(mmc, ios);
>>> +
>>> +     if (!ios->clock || ios->clock != host->clock)
>>> +             turning_on_clk = ios->clock && !host->clock;
>>>
>>>       if (host->ops->platform_send_init_74_clocks)
>>>               host->ops->platform_send_init_74_clocks(host, ios->power_mode);
>>> @@ -2959,7 +2969,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
>>>
>>> -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>>> +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>>>  {
>>>       /* Host Controller v3.00 defines preset value registers */
>>>       if (host->version < SDHCI_SPEC_300)
>>> @@ -2987,6 +2997,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>>>               host->preset_enabled = enable;
>>>       }
>>>  }
>>> +EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
>>>
>>>  static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
>>>                               int err)
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index df7fa0c0ebf8..c2f989dc2361 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -850,6 +850,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
>>>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>>>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>>>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>>> +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
>>> +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
>>>  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>>>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>>                                     struct mmc_ios *ios);
>>
> 
> Thanks, Victor Shih

