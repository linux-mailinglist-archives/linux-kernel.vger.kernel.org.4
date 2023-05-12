Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D84700502
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbjELKOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbjELKOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:14:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F351BE1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683886417; x=1715422417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NzqTguvFSjV2kCOcUZD87BdAd11HK9QDEusrkoTQGlo=;
  b=XpZXa9Dz72XUjEvOL3zM0Wn4o5FGjFSBvSyUh+xiFNRhksVnNYmdA4mX
   riJ1BcStEdu8C20UhoE4vLCazdc2f2Q6lunEan7Iafsl6RRqn3fQkGS1p
   fA3XHesxw2+2dmn7FURJ4QFyGxn/ZnVtjSWW6HzWDepqIdmiRebEsi1uR
   036ZZpcUECko9aBBf743sXFqnZiEMcl45jB3G4hqL3UawYDLjPcETe2kF
   YW/vXWZel6N3YZMK9GfUNtsR+WvoUxZEIq25SQ9UWWV/A8y16TUQ/vNEJ
   +JQ0T7/iBNclGqAELG2M7fStZeUE9rhq4rB3DDPvwFiOY182UIbrrl5Qz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="416386434"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="416386434"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="824309039"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="824309039"
Received: from nhanph1x-mobl.amr.corp.intel.com (HELO [10.249.38.84]) ([10.249.38.84])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 03:12:55 -0700
Message-ID: <12e47cb1-0744-6470-d79b-af1aeea86f9a@linux.intel.com>
Date:   Fri, 12 May 2023 13:13:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH] ASoC: SOF: Simplify the calculation of variables
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        pierre-louis.bossart@linux.intel.com
Cc:     lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230512064225.75358-1-jiapeng.chong@linux.alibaba.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230512064225.75358-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/05/2023 09:42, Jiapeng Chong wrote:
> ./sound/soc/sof/pcm.c:372:27-29: WARNING !A || A && B is equivalent to !A || B.

This is correct.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4938
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  sound/soc/sof/pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
> index 567db32173a8..d14e7fd2c2ee 100644
> --- a/sound/soc/sof/pcm.c
> +++ b/sound/soc/sof/pcm.c
> @@ -369,7 +369,7 @@ static int sof_pcm_trigger(struct snd_soc_component *component,
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  	case SNDRV_PCM_TRIGGER_STOP:
>  		/* invoke platform trigger to stop DMA even if pcm_ops isn't set or if it failed */
> -		if (!pcm_ops || (pcm_ops && !pcm_ops->platform_stop_during_hw_free))
> +		if (!pcm_ops || !pcm_ops->platform_stop_during_hw_free)
>  			snd_sof_pcm_platform_trigger(sdev, substream, cmd);
>  		break;
>  	default:

-- 
Péter
