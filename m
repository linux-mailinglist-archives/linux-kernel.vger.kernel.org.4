Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7A960089A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJQIRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJQIRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:17:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D5826572
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665994649; x=1697530649;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=Xwrds9D7DJmMRINmBlj40CklFAut4f2dqk22W3MhfaU=;
  b=P6euhbqeCic6yFCocI0n9Itcy6WnObVvcrPV7PXBGVWqmDPKijykh0MF
   d0+v4/koPMgiqDylhrIBKRioMeWZpG1vSGwou3L2BXtJ72VG2Yd/qS4CA
   q78nQDk6cv8lASUicOVoWflKGjVAqCiR+1Xv4o6UsPt2UeRWENOqDXpM8
   Xg60IuaTpB872Nfkl28tCNYT//6o3zcwz9KX2MuFHRKC+nmqVTOL1Z8I+
   c7M5IIbQmCRsjSHo3VtHAPYgXUvYoPZZT/PHSqLh549pH3KvU0w6dEvkI
   p5lJtQ0HmkynFX2sM28DvHEAJEZJAia/gpF90VoabSkbbxYpNYMSWQhKY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="286129864"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="286129864"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 01:17:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="770682384"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="770682384"
Received: from ggeogheg-mobl.ger.corp.intel.com (HELO [10.213.233.137]) ([10.213.233.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 01:17:26 -0700
Message-ID: <4cad6411-86af-dca5-09c7-92a4c5b5f7d3@linux.intel.com>
Date:   Mon, 17 Oct 2022 09:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [Intel-gfx] alderlake crashes (random memory corruption?) with
 6.0 i915 / ucode related
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
References: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
 <e4f7b16e-5b6f-1b2c-5f88-fc4a129ae28f@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <e4f7b16e-5b6f-1b2c-5f88-fc4a129ae28f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



+ Jani and Ville for the intel_bios.c warn - no idea if that is relevant.

Hi,

On 15/10/2022 15:25, Hans de Goede wrote:
> Hi,
> 
> On 10/13/22 22:33, Hans de Goede wrote:
>> Hi All,
>>
>> Yesterday I got a new Lenovo ThinkPad X1 yoga gen 7 laptop, since I plan
>> to make this my new day to day laptop I have copied over the entire
>> rootfs, /home, etc. from my current laptop to avoid having to tweak
>> everything to my liking again.
>>
>> This meant I had an initramfs generated for the other laptop. Which should
>> be fine since both are Intel machines and the old 5.19.y initramfs-es
>> worked fine. But 6.0.0 crashed with what seems like random memory
>> corruption (list integrity checks failing) until I regenerated the initrd ...
>>
>> Comparing the old vs regenerated initrds showed no relevant differences,
>> which made me think this is a CPU ucode issue (which is pre-fixed
>> to the initrd for early microcode loading).
>>
>> After some tests I have the following obeservations with 6.0.0:
>>
>> 1. The least stable is the old initrd (so with the wrong
>> ucode prefixed) this crashes before ever reaching gdm.
>> I believe that this is caused by late microcode loading
>> kicking in in this case (I though that was being removed?)
>> and doing load microcode loading on the i7-1260P with its
>> mix of P + E cores seems to seriously mess things up.
>>
>> 2. Slightly more stable, lasting at least a few minutes
>> before crashing is using dis_ucode_ldr
>>
>> 3. Using nomodeset seems to stabilize things even with
>> the old initrd with the wrong microcode prefixed
>>
>> 4. 5.19, with an old initrd and with normal modesetting
>> enabled works fine, so in a way this is a 6.0.0 regression
>>
>> 5. Using 6.0 with the new initrd with the new microcode
>> seems mostly stable, although sometimes this seems to
>> hang very early during boot, esp. if a previous boot
>> crashed and I have not run this for a long time yet.
>>
>> 6. After crashes it seems to be necessary to powercycle
>> the machine to get things back in working condition.
>>
>>
>> With 6.0 the following WARN triggers:
>> drivers/gpu/drm/i915/display/intel_bios.c:477:
>>
>>          drm_WARN(&i915->drm, min_size == 0,
>>                   "Block %d min_size is zero\n", section_id);
>>
>> Since nomodeset helps this might be quite relevant, in 5.19.13
>> this does not happen, but I'm not sure if 5.19 has this check
>> at all.
>>
>>
>> There is a 2022/10/07 BIOS update which includes a CPU microcode
>> update available from Lenovo, I have not applied this yet in case
>> people want to investigate this further first.
> 
> A quick update on this, the microcode being in the initrd or not
> seems to be a bit of a red herring. Yesterday the machine crashed
> twice at boot with 6.0.0 with an initrd which did correctly have
> the alderlake microcode cpio archive prefixed.
> 
> Where as with 5.19 it boots correctly everytime. I will try to
> make some time to git bisect this sometime next week. I expect
> this is an i915 issue though since 6.0.0 with nomodeset on
> the cmdline does seem to boot successfully every time.

Maybe try with KASAN to see if it catches something before random list 
corruption starts happening?

Regards,

Tvrtko
