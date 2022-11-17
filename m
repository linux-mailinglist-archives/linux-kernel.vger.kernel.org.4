Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A948D62DFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiKQP0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbiKQP0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:26:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0D91038;
        Thu, 17 Nov 2022 07:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668698607; x=1700234607;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i5U2I/Je0lxjUKBPeid0EVndcscZ2WmO/V+wNe8oICY=;
  b=ihkBMFRyXFF+M1ObtTMPg1zSAgCb3vRtLSU3YmOuXoQLSTJWnsQ7gD59
   R0K9hoeJ4JEgqHfVs7oTNazth9Yu04LgK23qYrjjWzBKrGZvv71iW/UpM
   XLPO2uKtggnUC3yTxZpXypFLUAm0M+PZUfRHRETm9aJuiiNu0jftp9oXL
   zrNHtQKu33Xul1FmdE2LMkvmJx2mXX7LLWe+488i4g22mKHdiHIYJy8Dd
   B3cZ4W6/FtDxfrSksMY9yVKOdbbsE/PSU37CHuW/xUEoETSPLeK7ltJff
   bDVWHa8Ws221eSJwow7ONH3ZEgF2TPdvOEjUb9Stlbig0ccsZ79CexleZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="399165799"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="399165799"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 07:23:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="617646063"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="617646063"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.99])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 07:23:22 -0800
Message-ID: <e0685dab-fe66-11f5-237c-f1da59e6ef5a@intel.com>
Date:   Thu, 17 Nov 2022 17:23:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V1] mmc: core: Wait for 1ms after enabling the clocks post
 voltage switch
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
References: <20221117094859.20582-1-quic_sartgarg@quicinc.com>
 <CAPDyKFqLjKOUwbAY5KXWK7g2xcWBQLW09nYoeVCxarfJPGNrTg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFqLjKOUwbAY5KXWK7g2xcWBQLW09nYoeVCxarfJPGNrTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/22 13:07, Ulf Hansson wrote:
> On Thu, 17 Nov 2022 at 10:49, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>>
>> As per spec we should wait for 1ms after providing the SD clock to the
>> card again as part of voltage switch sequence but there seems to be a
>> violation here. Clocks are getting gated before 1ms as part of
>> sdhci_set_ios function where we try to reset SD Clock Enable by
>> resetting SDHCI_CLOCK_CARD_EN bit in SDHCI_CLOCK_CONTROL register
>> leading to voltage switch failures for specific SD cards.
>> Below ftraces also confirms the above understanding :
>>
>> 9.511367: mmc_host_set_uhs_voltage: mmc1 called
>> 9.511369: mmc_set_ios: mmc1: clock 0Hz busmode 2 powermode 2 cs 0
>> Vdd 18 width 1 timing 0
>> 9.511370: sdhci_set_ios: mmc1 called
>> 9.511370: sdhci_set_ios: mmc1 setting clock ios->clock: 0 host->clock:
>> 400000
>> 9.511372: sdhci_msm_set_clock: mmc1 clock: 0
>> 9.511394: sdhci_set_ios: mmc1 gating clocks by writing
>> ~SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
>> 9.511413: sdhci_msm_set_clock: mmc1 clock: 0
>> 9.511423: mmc_set_signal_voltage: mmc1 called
>> 9.533816: mmc_set_ios: mmc1: clock 400000Hz busmode 2 powermode 2 cs 0
>> Vdd 18 width 1 timing 0
>> 9.533820: sdhci_set_ios: mmc1 called
>> 9.533822: sdhci_set_ios: mmc1 setting clock ios->clock: 400000
>> host->clock: 0
>> 9.533826: sdhci_msm_set_clock: mmc1 clock: 400000
>> 9.533925: sdhci_enable_clk: mmc1 Enabling clocks by writing
>> SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
>> 9.533950: sdhci_set_ios: mmc1 gating clocks by writing
>> ~SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
>> 9.533973: sdhci_msm_set_clock: mmc1 clock: 400000
>> 9.534043: sdhci_enable_clk: mmc1 Enabling clocks by writing
>> SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
>> 9.534045: mmc_host_set_uhs_voltage: mmc1 Done
>>
>> Wait for 1ms after enabling the clock post voltage switch to make sure
>> clock is kept alive for alteast 1ms as per spec.
>>
>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> 
> I don't know the exact behaviour of sdhci around this, so I will defer
> to Adrian's input for that.

sdhci_set_ios() seems to be mucking around with the clock way
more than necessary.  I'll go over it and see what can be done.

> 
> However, let me point out that in mmc_set_uhs_voltage() we are trying
> to take the 1ms into account. More precisely, after
> mmc_host_set_uhs_voltage() has been called to switch the voltage to
> 1.8V and to re-enable the clock, mmc_set_uhs_voltage() does a
> "mmc_delay(1)" and then it calls the ->card_busy() ops to check that
> card doesn't signal busy by holding DAT0 low.
> 
> I understand that the code in mmc_set_uhs_voltage(), expects the host
> to be rather dumb from the HW perspective, which may not always be the
> case. Although, I would rather avoid introducing new host flags, along
> what you propose in the $subject patch. If this can't be managed in
> sdhci, without some new help from the mmc core, I would rather suggest
> that we introduce a new host callback that can be used to replace the
> entire part in mmc_host_set_uhs_voltage() (or something along those
> lines).
> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/core/core.c  | 4 ++++
>>  drivers/mmc/host/sdhci.c | 3 +++
>>  include/linux/mmc/host.h | 1 +
>>  3 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index a1efda85c6f2..d63e00aab6cb 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1181,6 +1181,8 @@ int mmc_host_set_uhs_voltage(struct mmc_host *host)
>>         host->ios.clock = 0;
>>         mmc_set_ios(host);
>>
>> +       host->doing_signal_voltage_switch = true;
>> +
>>         if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180))
>>                 return -EAGAIN;
>>
>> @@ -1189,6 +1191,8 @@ int mmc_host_set_uhs_voltage(struct mmc_host *host)
>>         host->ios.clock = clock;
>>         mmc_set_ios(host);
>>
>> +       host->doing_signal_voltage_switch = false;
>> +
>>         return 0;
>>  }
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index fb6e9a81f198..ac7c254eef4b 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2312,6 +2312,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                 host->ops->set_clock(host, ios->clock);
>>                 host->clock = ios->clock;
>>
>> +               if (mmc->doing_signal_voltage_switch)
>> +                       usleep_range(1000, 1250);
>> +
>>                 if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
>>                     host->clock) {
>>                         host->timeout_clk = mmc->actual_clock ?
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 8fdd3cf971a3..06c88cd7a8bf 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -521,6 +521,7 @@ struct mmc_host {
>>         bool                    hsq_enabled;
>>
>>         u32                     err_stats[MMC_ERR_MAX];
>> +       bool                    doing_signal_voltage_switch;
>>         unsigned long           private[] ____cacheline_aligned;
>>  };
>>
>> --
>> 2.17.1
>>

