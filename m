Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557BB660B57
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjAGBPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGBPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:15:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6108D1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673054110; x=1704590110;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A1l9nLxqa/QgP6et14ncprz/Qiq1w5jVWtdRAUx+0/E=;
  b=EdJCl53BsWiAKK285EvkAFYhbzINpL24v8jjLBe5Y2GYmIRG08ZwrSaE
   1Sir7hsXXygtD3/hRhmihq3HLK+Xa81Zt0cUsHOo2TpIxZVMha/+MmJQV
   OBv90UfBp8u0OQg2qlaC6Rfj4KeHo7E6X3ztM/fyWFKs2iKeGAzCx+kD9
   Bguy35un2s/ENhOwJIuNbg4HIQPjGR64AiRe9deU1ouEsVviJ5N12o1F0
   UQ5EfTmALXgrTT4E0RovyQ+tk4adTJLBIX5YwSmXDN1dLfXBLcyuTKUV6
   t+a4lrZlbhc6/BSNYkTbe/F6yOIbS5LF9r8j643rC4L/oX3Xk7RAvWty8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="322671666"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="322671666"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:15:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="649474201"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="649474201"
Received: from apbaezbo-mobl2.amr.corp.intel.com (HELO [10.212.60.153]) ([10.212.60.153])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:15:07 -0800
Message-ID: <fe30d88f-fe03-f77b-7f34-2b8a063214b9@linux.intel.com>
Date:   Fri, 6 Jan 2023 19:15:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC] Sound support for Huawei line of AMD laptops using ACP and
 ES8336 codec
Content-Language: en-US
To:     Marian Postevca <posteuca@mutex.one>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        syed sabakareem <Syed.SabaKareem@amd.com>,
        "Chehab, Mauro" <mauro.chehab@intel.com>,
        David Yang <yangxiaohua@everest-semi.com>
References: <871qo7fqjp.fsf@mutex.one>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <871qo7fqjp.fsf@mutex.one>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> I have a Huawei Matebook 14 AMD 2021 laptop for which the sound isn't
> supported on Linux. On further investigation in Windows and ACPI tables
> I could determine that this particular SKU has an ES8336 codec connected
> to the CPU ACP module.
> The CPU of my laptop is an AMD Ryzen 5 5500U which seems to be codenamed
> Lucienne and is a derivation of the Renoir family.
> Acording to lspci the ACP is revision 1:
> 
> 03:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD] Raven/Raven2/FireFlight/Renoir Audio Processor [1022:15e2] (rev 01)
> 	Subsystem: Device [1e83:3e4d]
> 	Kernel driver in use: snd_rn_pci_acp3x
> 	Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x, snd_pci_acp5x,
> 	snd_pci_acp6x, snd_acp_pci, snd_rpl_pci_acp6x,
> 	snd_sof_amd_renoir
> 
> I have written a machine driver for this platform and managed to make
> the sound and internal microphone work. I am looking to integrate this
> support but there are some issues with the current implementation of ACP
> support.
> 
> As far as I can tell there are 4 directions I could take to add support:
> 
> 1. A standalone machine driver in sound/soc/amd that uses the platform
>   drivers from sound/soc/amd/raven/
> 
> 2. An embedded driver in sound/soc/amd/acp/acp-legacy-mach.c
> 
> 3. A standalone machine driver in sound/soc/amd that uses the platform
>   drivers from sound/soc/amd/renoir
> 
> 4. Use the SOF infrastructure

The main issue with this codec is the mind-blowing proliferation of
configurations and quirks.
I can't comment on AMD-specific stuff, but would recommend you take a
look at the GitHub PR we've been reviewing to extract as much
information as possible from ACPI _DSM tables (as done by the Windows
driver). see https://github.com/thesofproject/linux/pull/4112 (credits
to Mauro Chehab for fixing and testing on real hardware and David Yang
for providing the DSM information and comments).
