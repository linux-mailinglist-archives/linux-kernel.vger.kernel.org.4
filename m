Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64DA6660B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjAKQhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbjAKQgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:36:23 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC39BFD0C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454982; x=1704990982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/lWO9em8bpuZCH9dItRfGVyYoxvw1jBBMDLOYUCca7U=;
  b=GbqtcVpx8c6dpw3LkSC/BpdXPFBhW0J41D6eTpFI/07DQoEWCCxsuH7U
   AQKcPAFloJoRikCE5CmRoUwT2ZZtUq64zB3RquHQ7U+SSnjXDrXw5PC5f
   azRHO6ZqLLuZk5MH87zARr3j4tbXRzXWWEsCPzAyN15HMCc2dkZ0gMRMb
   t77p7DpOsLrQqxKlHTmXIXpG8zTQhv695U5IwO4CyH2uwjSda5Lrhv4Pt
   y0iSrv/KuzXTp/+5nTD0kkQdwzn+s+jBJeqXNvD1gstGk4rNiLuOWL2R7
   jY9j06u0n1CBjPe3Qf3YDHvOHe4YBqm0c4iBgl8++pxHVp0zwZrnDwOzS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324704310"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324704310"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408856"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607408856"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208]) ([10.212.110.208])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:49 -0800
Message-ID: <c7f018e3-c8be-6819-0ece-244bfb943c62@linux.intel.com>
Date:   Wed, 11 Jan 2023 10:02:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mario.Limonciello@amd.com,
        arungopal.kondaveeti@amd.com,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-20-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-20-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/23 03:02, Vijendar Mukunda wrote:
> To avoid ACP entering into D3 state during slave enumeration and
> initialization on two soundwire controller instances for multiple codecs,
> increase the runtime suspend delay to 3 seconds.

You have a parent PCI device and a set of child devices for each
manager. The parent PCI device cannot suspend before all its children
are also suspended, so shouldn't the delay be modified at the manager level?

Not getting what this delay is and how this would deal with a lengthy
enumeration/initialization process.

> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/ps/acp63.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
> index 833d0b5aa73d..6c8849f2bcec 100644
> --- a/sound/soc/amd/ps/acp63.h
> +++ b/sound/soc/amd/ps/acp63.h
> @@ -51,7 +51,7 @@
>  #define MIN_BUFFER MAX_BUFFER
>  
>  /* time in ms for runtime suspend delay */
> -#define ACP_SUSPEND_DELAY_MS	2000
> +#define ACP_SUSPEND_DELAY_MS	3000
>  
>  #define ACP63_DMIC_ADDR		2
>  #define ACP63_PDM_MODE_DEVS		3
