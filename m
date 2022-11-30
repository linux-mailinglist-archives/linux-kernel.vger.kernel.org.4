Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621F863CF29
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiK3GTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiK3GTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:19:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1654530F70;
        Tue, 29 Nov 2022 22:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669789146; x=1701325146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JYrA/k2tWWAw2kY6vd9Z+khRGZifgFIqAi4dqbTa+b4=;
  b=S9lMMyQJAWPPmCLl6bnGhtqPB9wQVNm6IKyWsOpPsGfC011gtx2tHsqL
   YWd0BmlHboVfPAJ/4/jBIQl2pCBpGUfgN2JE4mAdsQH453Gf2ichSqRNI
   WSgHYdsW1TqqoFzYMqAGiWnsxVvWCcXMIm32x22tg+wIdDH2z+xJxWh9i
   0xGB52LJfBEzJuY+8poy6XMQGTCpL+v+eSOSYZuocoVA8oSXEuRK2H/Xz
   Z3a7c4gVDsDBRyQtVdSJPlMIATE22Ec3DQ6OdiOFB7Z1yHe9qslnDwfg6
   hnigJBUpIUVWt3d3oVfYU3DczV9/taof2YhLPq1QQx8TfzYuRavGMf7c8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="314008937"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="314008937"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 22:19:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="646209844"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="646209844"
Received: from tuomaspe-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.53.75])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 22:18:59 -0800
Message-ID: <6099c99e-f0a7-2be3-52bf-a99b5a3596c7@intel.com>
Date:   Wed, 30 Nov 2022 08:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 1/1] mmc: sdhci: Fixed too many logs being printed during
 tuning
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
References: <20221111084214.14822-1-wenchao.chen666@gmail.com>
 <20221111084214.14822-2-wenchao.chen666@gmail.com>
 <59fc95ec-c0db-4011-eca3-3d101f0bc908@intel.com>
 <CA+Da2qwdtUdCcv+HhNArGoriVtOmx+GGML4Avkk5QSdm8+XXTQ@mail.gmail.com>
 <8433ae30-2633-1f32-ef11-2168c9cfea80@intel.com>
 <CA+Da2qwBmApEZ6ejGBTjftsytkeNZbHZ-0oQDWa5TD8Qp3CYHA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CA+Da2qwBmApEZ6ejGBTjftsytkeNZbHZ-0oQDWa5TD8Qp3CYHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/22 05:11, Wenchao Chen wrote:
> On Fri, Nov 18, 2022 at 11:57 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 18/11/22 11:25, Wenchao Chen wrote:
>>> On Thu, Nov 17, 2022 at 12:00 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 11/11/22 10:42, Wenchao Chen wrote:
>>>>> From: Wenchao Chen <wenchao.chen@unisoc.com>
>>>>>
>>>>> During the HS200 tuning process, too many tuning errors are printed in
>>>>> the log.
>>>>>
>>>>> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
>>>>> ---
>>>>>  drivers/mmc/host/sdhci.c | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>> index fef03de85b99..a503b54305eb 100644
>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>> @@ -3401,6 +3401,10 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>>>>               if (host->pending_reset)
>>>>>                       return;
>>>>>
>>>>> +             command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
>>>>> +             if (command == MMC_SEND_TUNING_BLOCK || command == MMC_SEND_TUNING_BLOCK_HS200)
>>>>> +                     return;
>>>>
>>>> Normally we wouldn't get here even if a request got an error because
>>>> then we either reset the data circuit which should stop further
>>>> interrupts, or set host->pending_reset.
>>>>
>>>> Can you elaborate on what is going wrong?
>>>>
>>> Hi  adrian
>>> 1. In the process of tuning, not all tuning values are good, some
>>> tuning values may cause errors, and these errors print too many logs.
>>>     Of course, we reset the cmdline or dataline on error.
>>> 2. use host->pending_reset = true
>>> static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>>> {
>>> ...
>>> if (sdhci_needs_reset(host, mrq))
>>> host->pending_reset = true;
>>> ...
>>> }
>>>
>>> But intmask = 0x00200000
>>> static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>> {
>>> ...
>>> if (!host->data) {
>>> struct mmc_command *data_cmd = host->data_cmd;
>>>
>>> if (data_cmd && (data_cmd->flags & MMC_RSP_BUSY)) {
>>> if (intmask & SDHCI_INT_DATA_TIMEOUT) { //#define
>>> SDHCI_INT_DATA_TIMEOUT 0x00100000
>>> host->data_cmd = NULL;
>>> data_cmd->error = -ETIMEDOUT;
>>> sdhci_err_stats_inc(host, CMD_TIMEOUT);
>>> __sdhci_finish_mrq(host, data_cmd->mrq);//<=
>>> return;
>>> }
>>> if (intmask & SDHCI_INT_DATA_END) {    //#define  SDHCI_INT_DATA_END 0x00000002
>>>
>>> host->data_cmd = NULL;
>>> /*
>>> * Some cards handle busy-end interrupt
>>> * before the command completed, so make
>>> * sure we do things in the proper order.
>>> */
>>> if (host->cmd == data_cmd)
>>> return;
>>>
>>> __sdhci_finish_mrq(host, data_cmd->mrq);//<=
>>> return;
>>> }
>>> }
>>> ...
>>> if (host->pending_reset)
>>> return;
>>>
>>> pr_err("%s: Got data interrupt 0x%08x even though no data operation
>>> was in progress.\n",
>>>        mmc_hostname(host->mmc), (unsigned)intmask);
>>> sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
>>> sdhci_dumpregs(host);
>>>
>>> return;
>>> }
>>> ...
>>> }
>>
>> Not really following that I'm sorry.
>>
>> Are you saying you get a data interrupt after he data circuit is reset?
>>
> 
> No. During the tuning process, sdhci_data_irq does not skip printing
> because the interrupt state is 0x00200000 (DATA CRC ERROR).

Sorry I am still confused.  Which driver is this?  I was assuming
you were using mmc_send_tuning() because the only interrupt enabled
for regular SDHCI tuning is SDHCI_INT_DATA_AVAIL (0x00000020).

So are you saying you are getting status 0x00200000 even though the
mask is 0x00000020 ?

> 
>>>
>>>>> +
>>>>>               pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
>>>>>                      mmc_hostname(host->mmc), (unsigned)intmask);
>>>>>               sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
>>>>
>>

