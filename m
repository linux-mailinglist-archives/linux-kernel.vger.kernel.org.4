Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263C86B9AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCNQPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCNQPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:15:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DC295BCB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678810488; x=1710346488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V6U675NRIIcVCoUxfsyJbXikofxVtHsIk28ldvKqnEI=;
  b=lXJe/Kwt+mXLI+NnQV1HXOHW/QEEZNEbrEQ6lvt6MsVLK1KXz6DvZ3DJ
   SvR6hZ/xiPosNo/jrr7BS3TkYLlws+16/onsYC7go/ZDbobI8iFFBDDke
   ij5vnty0Ei7DoMQ2H4hlgOXq3oP6Mtys+9DuGZK0PjdE90oNwR44fOj7p
   Z/pZUSdzpxZPj0lK1naSJ6q7Tc6Bddpnn9m94nT91d1CUbfhJFUawH9vJ
   utlznfGTeDPtfLRYfpm+4DmG5zKEAG+VyhBDntcW/a83Bf95sjllRaXWX
   xGLDJ41IrmiZS4cia0EaOWJrHf3dNJ1+OrVzzi6bieEM48xDIxQ527bj1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="339015238"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="339015238"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="802922318"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="802922318"
Received: from hsaquing-mobl.amr.corp.intel.com (HELO [10.255.35.31]) ([10.255.35.31])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:14:47 -0700
Message-ID: <6d9d09aa-d83e-e811-1d43-34780ea05d4d@linux.intel.com>
Date:   Tue, 14 Mar 2023 11:14:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH] ASoC: soc-compress: Inherit atomicity from DAI link for
 Compress FE
Content-Language: en-US
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org,
        daniel.baluta@gmail.com, paul.olaru@nxp.com
References: <20230314153409.1805280-1-daniel.baluta@oss.nxp.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230314153409.1805280-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/23 10:34, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> After commit bbf7d3b1c4f40 ("ASoC: soc-pcm: align BE 'atomicity' with
> that of the FE") BE and FE atomicity must match.
> 
> In the case of Compress PCM there is a mismatch in atomicity between FE
> and BE and we get errors like this:
> 
> [   36.434566]  sai1-wm8960-hifi: dpcm_be_connect: FE is atomic but BE
> is nonatomic, invalid configuration

Not clear on the 'FE is atomic' in the case of a compressed stream,
which has to be handled with some sort of IPC, i.e. be nonatomic.

Also not sure why the FE is not set as nonatomic by the SOF parts?
If it's needed for PCM, why wouldn't it be needed for compressed data?

> [   36.444278]  PCM Deep Buffer: ASoC: can't connect SAI1.OUT
> 
> In order to fix this we must inherit the atomicity from DAI link
> associated with current PCM Compress FE.
> 
> Fixes: bbf7d3b1c4f4 ("ASoC: soc-pcm: align BE 'atomicity' with that of the FE")
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/soc-compress.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index e7aa6f360cab..d649b0cf4744 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -622,6 +622,9 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>  			return ret;
>  		}
>  
> +		/* inherit atomicity from DAI link */
> +		be_pcm->nonatomic = rtd->dai_link->nonatomic;
> +
>  		rtd->pcm = be_pcm;
>  		rtd->fe_compr = 1;
>  		if (rtd->dai_link->dpcm_playback)
