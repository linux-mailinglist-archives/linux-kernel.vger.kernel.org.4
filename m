Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB825F7581
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJGIuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJGIuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:50:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178992656F;
        Fri,  7 Oct 2022 01:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665132601; x=1696668601;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CNNiQJ0jvcJk580eA851dG+WgC8+tA465upvwZmefVk=;
  b=luOLotz+Gi8L6n68r6YDy8ARb0G+zDjVaSwuVgAyL9ySxlsbciGnvbOP
   sn6aiwjAr7bF4r4Ut6ttCBnkB6UmcQjfqg2Toems3yHJYEKKqhNgFPcPo
   xJw6Mz4Ui64SBHS90dHwHXv79jGC2+Mdn++ytl/nhFu7NPq07jIlM6hAw
   C4VDkcIwkhkeqNnfFUfUxWBLCk3BFainqP2g6Kps9eOdPmMxAU77Q1x9W
   xTZp639JUi5rVLpuoASkQUsjhHqhvauLSz+QwFsojmoQV/7Lxc3NpFsJs
   6K6AxrZqfgWPyrjqrOhpsXE5HcEDdC3zH17e8+HxPkk8wGSxVc8wiZhke
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="286914342"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="286914342"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 01:50:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="714204628"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="714204628"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.18]) ([10.99.241.18])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 01:49:58 -0700
Message-ID: <6730eda1-7a7a-3660-ebe4-e9e42de421a3@linux.intel.com>
Date:   Fri, 7 Oct 2022 10:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/4] ALSA: hda: Rework snd_hdac_stream_reset() to use
 macros
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>, Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Mohan Kumar D <mkumard@nvidia.com>
References: <20220818141517.109280-1-amadeuszx.slawinski@linux.intel.com>
 <20220818141517.109280-3-amadeuszx.slawinski@linux.intel.com>
 <657d2418-0c3e-296f-8f4a-dc10ced2dffe@nvidia.com>
 <87a66av4gk.wl-tiwai@suse.de>
 <86947512-33c8-4e22-5329-a41735c6b1ef@nvidia.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <86947512-33c8-4e22-5329-a41735c6b1ef@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/2022 10:45 AM, Jon Hunter wrote:
> 
> On 05/10/2022 13:29, Takashi Iwai wrote:
> 
> ...
> 
>>> HDA playback is failing on -next for various Tegra boards. Bisect is
>>> point to this commit and reverting it fixes the problem. I was a bit
>>> puzzled why this change is causing a problem, but looking closer there
>>> is a difference between the previous code that was calling
>>> snd_hdac_stream_readb() and the new code that is calling
>>> snd_hdac_stream_readb_poll(). The function snd_hdac_stream_readb()
>>> calls snd_hdac_aligned_mmio() is see if the device has an aligned MMIO
>>> which Tegra does and then would call snd_hdac_aligned_read(). However,
>>> now the code always call readb() and this is breaking Tegra.
>>>
>>> So it is either necessary to update snd_hdac_stream_readb_poll() to
>>> handle this or revert this change.
>>
>> Does the patch below work?
>>
>>
>> thanks,
>>
>> Takashi
>>
>> -- 8< --
>> --- a/include/sound/hdaudio.h
>> +++ b/include/sound/hdaudio.h
>> @@ -592,8 +592,8 @@ int snd_hdac_get_stream_stripe_ctl(struct hdac_bus 
>> *bus,
>>   #define snd_hdac_stream_readb(dev, reg) \
>>       snd_hdac_reg_readb((dev)->bus, (dev)->sd_addr + AZX_REG_ ## reg)
>>   #define snd_hdac_stream_readb_poll(dev, reg, val, cond, delay_us, 
>> timeout_us) \
>> -    readb_poll_timeout((dev)->sd_addr + AZX_REG_ ## reg, val, cond, \
>> -               delay_us, timeout_us)
>> +    read_poll_timeout(snd_hdac_reg_readb, val, cond, delay_us, 
>> timeout_us,\
>> +              false, (dev)->bus, (dev)->sd_addr + AZX_REG_ ## reg)
>>   #define snd_hdac_stream_readl_poll(dev, reg, val, cond, delay_us, 
>> timeout_us) \
>>       readl_poll_timeout((dev)->sd_addr + AZX_REG_ ## reg, val, cond, \
>>                  delay_us, timeout_us)
> 
> 
> So looking at this a bit more I see ...
> 
> [  199.422773] bad: scheduling from the idle thread!
> [  199.427610] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D  
> C         6.0.0-rc7-next-20220930-00007-gd6ae4ed0a78f-dirty #23
> [  199.438880] Hardware name: NVIDIA Jetson Nano Developer Kit (DT)
> [  199.444899] Call trace:
> [  199.447357]  dump_backtrace.part.7+0xe8/0xf8
> [  199.451680]  show_stack+0x14/0x38
> [  199.455024]  dump_stack_lvl+0x64/0x7c
> [  199.458715]  dump_stack+0x14/0x2c
> [  199.462067]  dequeue_task_idle+0x2c/0x58
> [  199.466038]  dequeue_task+0x38/0x98
> [  199.469565]  __schedule+0x4a4/0x6d8
> [  199.473104]  schedule+0x58/0xc0
> [  199.476292]  schedule_hrtimeout_range_clock+0x98/0x108
> [  199.481472]  schedule_hrtimeout_range+0x10/0x18
> [  199.486039]  usleep_range_state+0x7c/0xb0
> [  199.490084]  snd_hdac_stream_reset+0xe8/0x328 [snd_hda_core]
> [  199.495913]  snd_hdac_stream_sync+0xe4/0x190 [snd_hda_core]
> [  199.501627]  azx_pcm_trigger+0x1d8/0x250 [snd_hda_codec]
> [  199.507109]  snd_pcm_do_stop+0x54/0x70
> [  199.510904]  snd_pcm_action_single+0x44/0xa0
> [  199.515215]  snd_pcm_drain_done+0x20/0x28
> [  199.519267]  snd_pcm_update_state+0x114/0x128
> [  199.523670]  snd_pcm_update_hw_ptr0+0x22c/0x3a0
> [  199.528246]  snd_pcm_period_elapsed_under_stream_lock+0x44/0x88
> [  199.534216]  snd_pcm_period_elapsed+0x24/0x48
> [  199.538617]  stream_update+0x3c/0x50 [snd_hda_codec]
> [  199.543737]  snd_hdac_bus_handle_stream_irq+0xe8/0x150 [snd_hda_core]
> [  199.550320]  azx_interrupt+0xb4/0x1b0 [snd_hda_codec]
> [  199.555524]  __handle_irq_event_percpu+0x74/0x140
> [  199.560281]  handle_irq_event_percpu+0x14/0x48
> [  199.564772]  handle_irq_event+0x44/0x88
> [  199.568653]  handle_fasteoi_irq+0xa8/0x130
> [  199.572788]  generic_handle_domain_irq+0x28/0x40
> [  199.577452]  gic_handle_irq+0x9c/0xb8
> [  199.581168]  call_on_irq_stack+0x2c/0x40
> [  199.585129]  do_interrupt_handler+0x7c/0x80
> [  199.589355]  el1_interrupt+0x34/0x68
> [  199.592969]  el1h_64_irq_handler+0x14/0x20
> [  199.597107]  el1h_64_irq+0x64/0x68
> [  199.600540]  cpuidle_enter_state+0x130/0x2f8
> [  199.604853]  cpuidle_enter+0x38/0x50
> [  199.608463]  call_cpuidle+0x18/0x38
> [  199.611991]  do_idle+0x1f8/0x248
> [  199.615259]  cpu_startup_entry+0x20/0x28
> [  199.619224]  kernel_init+0x0/0x128
> [  199.622669]  arch_post_acpi_subsys_init+0x0/0x8
> [  199.627240]  start_kernel+0x630/0x668
> [  199.630933]  __primary_switched+0xb4/0xbc
> 
> 
> If I change your patch to be read_poll_timeout_atomic, then it works \o/
> 
> Can we make that update?
> 
> Jon
> 

Yes, it makes sense, as it uses udelay instead of usleep, same as 
original code.

I've send patch which updates the macros. It passed validation on our side.

Thanks for report!

Amadeusz
