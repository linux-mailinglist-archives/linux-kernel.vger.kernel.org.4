Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C9D637E10
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiKXRLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKXRLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:11:48 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01F97045D;
        Thu, 24 Nov 2022 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669309907; x=1700845907;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=SzEcIx3hDi1g5hKgrs6KebSSMfDVAH+Lkjvr9r0e0k8=;
  b=f15Ot7wtu/yFAeNtFkkzOL+UZ1+dJd+cugGcsgechUAku11RrwZ2f8/O
   1/nHShgrI0sA0DeGtkcfX5YcCQhrS6DAH7RgaxqBJDkGkEzIjifIkVdqz
   hvdbUVuPeRu08kLTK+7202Zl745eePJZeSi4oEOW4D+6E5XknaEeyXs3N
   yxQEmUuAA6G9ZlezyX1YLSoneBl1c//8YsjCYUVSD5Crtazoop7eezPcm
   MJXAjdiCI5dmn/7rFy8KIm+dEAylBEpEMhWiSHjk3ScPSJ+LXmgM9URjs
   Mu9PvYv404mJON9LHV7/AFXdhA67Ep+bOvFuac4sHpzBmqqkXc3tv7d8L
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="311975034"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="311975034"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 09:11:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="784693980"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="784693980"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.33.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 09:11:44 -0800
Message-ID: <13838815-93f3-094b-aca6-c5c0df799854@intel.com>
Date:   Thu, 24 Nov 2022 19:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V1] mmc: core: Wait for 1ms after enabling the clocks post
 voltage switch
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
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
 <e0685dab-fe66-11f5-237c-f1da59e6ef5a@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <e0685dab-fe66-11f5-237c-f1da59e6ef5a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/22 17:23, Adrian Hunter wrote:
> On 17/11/22 13:07, Ulf Hansson wrote:
>> On Thu, 17 Nov 2022 at 10:49, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>>>
>>> As per spec we should wait for 1ms after providing the SD clock to the
>>> card again as part of voltage switch sequence but there seems to be a
>>> violation here. Clocks are getting gated before 1ms as part of
>>> sdhci_set_ios function where we try to reset SD Clock Enable by
>>> resetting SDHCI_CLOCK_CARD_EN bit in SDHCI_CLOCK_CONTROL register
>>> leading to voltage switch failures for specific SD cards.
>>> Below ftraces also confirms the above understanding :
>>>
>>> 9.511367: mmc_host_set_uhs_voltage: mmc1 called
>>> 9.511369: mmc_set_ios: mmc1: clock 0Hz busmode 2 powermode 2 cs 0
>>> Vdd 18 width 1 timing 0
>>> 9.511370: sdhci_set_ios: mmc1 called
>>> 9.511370: sdhci_set_ios: mmc1 setting clock ios->clock: 0 host->clock:
>>> 400000
>>> 9.511372: sdhci_msm_set_clock: mmc1 clock: 0
>>> 9.511394: sdhci_set_ios: mmc1 gating clocks by writing
>>> ~SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
>>> 9.511413: sdhci_msm_set_clock: mmc1 clock: 0
>>> 9.511423: mmc_set_signal_voltage: mmc1 called
>>> 9.533816: mmc_set_ios: mmc1: clock 400000Hz busmode 2 powermode 2 cs 0
>>> Vdd 18 width 1 timing 0
>>> 9.533820: sdhci_set_ios: mmc1 called
>>> 9.533822: sdhci_set_ios: mmc1 setting clock ios->clock: 400000
>>> host->clock: 0
>>> 9.533826: sdhci_msm_set_clock: mmc1 clock: 400000
>>> 9.533925: sdhci_enable_clk: mmc1 Enabling clocks by writing
>>> SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
>>> 9.533950: sdhci_set_ios: mmc1 gating clocks by writing
>>> ~SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
>>> 9.533973: sdhci_msm_set_clock: mmc1 clock: 400000
>>> 9.534043: sdhci_enable_clk: mmc1 Enabling clocks by writing
>>> SDHCI_CLOCK_CARD_EN to SDHCI_CLOCK_CONTROL register
>>> 9.534045: mmc_host_set_uhs_voltage: mmc1 Done
>>>
>>> Wait for 1ms after enabling the clock post voltage switch to make sure
>>> clock is kept alive for alteast 1ms as per spec.
>>>
>>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>>
>> I don't know the exact behaviour of sdhci around this, so I will defer
>> to Adrian's input for that.
> 
> sdhci_set_ios() seems to be mucking around with the clock way
> more than necessary.  I'll go over it and see what can be done.

I have now sent some patches:

  https://lore.kernel.org/linux-mmc/20221124170649.63851-1-adrian.hunter@intel.com/T/#t

> 
>>
>> However, let me point out that in mmc_set_uhs_voltage() we are trying
>> to take the 1ms into account. More precisely, after
>> mmc_host_set_uhs_voltage() has been called to switch the voltage to
>> 1.8V and to re-enable the clock, mmc_set_uhs_voltage() does a
>> "mmc_delay(1)" and then it calls the ->card_busy() ops to check that
>> card doesn't signal busy by holding DAT0 low.
>>
>> I understand that the code in mmc_set_uhs_voltage(), expects the host
>> to be rather dumb from the HW perspective, which may not always be the
>> case. Although, I would rather avoid introducing new host flags, along
>> what you propose in the $subject patch. If this can't be managed in
>> sdhci, without some new help from the mmc core, I would rather suggest
>> that we introduce a new host callback that can be used to replace the
>> entire part in mmc_host_set_uhs_voltage() (or something along those
>> lines).
>>
>> Kind regards
>> Uffe
>>
>>> ---
>>>  drivers/mmc/core/core.c  | 4 ++++
>>>  drivers/mmc/host/sdhci.c | 3 +++
>>>  include/linux/mmc/host.h | 1 +
>>>  3 files changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index a1efda85c6f2..d63e00aab6cb 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1181,6 +1181,8 @@ int mmc_host_set_uhs_voltage(struct mmc_host *host)
>>>         host->ios.clock = 0;
>>>         mmc_set_ios(host);
>>>
>>> +       host->doing_signal_voltage_switch = true;
>>> +
>>>         if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180))
>>>                 return -EAGAIN;
>>>
>>> @@ -1189,6 +1191,8 @@ int mmc_host_set_uhs_voltage(struct mmc_host *host)
>>>         host->ios.clock = clock;
>>>         mmc_set_ios(host);
>>>
>>> +       host->doing_signal_voltage_switch = false;
>>> +
>>>         return 0;
>>>  }
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index fb6e9a81f198..ac7c254eef4b 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2312,6 +2312,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>                 host->ops->set_clock(host, ios->clock);
>>>                 host->clock = ios->clock;
>>>
>>> +               if (mmc->doing_signal_voltage_switch)
>>> +                       usleep_range(1000, 1250);
>>> +
>>>                 if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
>>>                     host->clock) {
>>>                         host->timeout_clk = mmc->actual_clock ?
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index 8fdd3cf971a3..06c88cd7a8bf 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -521,6 +521,7 @@ struct mmc_host {
>>>         bool                    hsq_enabled;
>>>
>>>         u32                     err_stats[MMC_ERR_MAX];
>>> +       bool                    doing_signal_voltage_switch;
>>>         unsigned long           private[] ____cacheline_aligned;
>>>  };
>>>
>>> --
>>> 2.17.1
>>>
> 

