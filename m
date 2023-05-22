Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E304770CAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjEVU3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjEVU2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:28:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A31FC1;
        Mon, 22 May 2023 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684787317; x=1716323317;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=06gJ26y6/+tD6/04ZXWm0S0iHd38ABjCkIpWuxdpj2I=;
  b=ZDput84lpdBIbtTsj4gT1C/H+hDay1S7TF+P42Sy2uarqkukD7YNgQLj
   ziNjf5054ZZirRy1a7jUPUpxg67PT4pBz7PENOl874h2gUuDVT9D45lni
   JhOMK/Jl9kpRww2RgXjZG1p23nM77Y6SJ8EnIeYlEsRtQl1ZYCBIn3r+L
   xrAx0GdsmW2YyjqwRzLhH0vh9vgGn4aXK8nv3ZiZVtTzjOM2pEv3KiO9r
   jcAUppNtb/+t40xXfEI/wsjKo9taDJ8nxk978wd03yN9huSr5L+Gmu1cE
   TF/FZr0y/eXnGpD6r5H4Z3D2yKWtBVk/CSrRnyoOhOHwJtIukGV6n+6QI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="333396978"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="333396978"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 13:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="827824711"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="827824711"
Received: from avelapox-mobl.amr.corp.intel.com ([10.212.71.122])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 13:28:36 -0700
Message-ID: <58928aec02be483e8a188fcc6e53d805a24534aa.camel@linux.intel.com>
Subject: Re: [PATCH next] ASoC: SOF: Intel: hda-dai: Fix locking in
 hda_ipc4_pre_trigger()
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rander Wang <rander.wang@intel.com>,
        Jyri Sarha <jyri.sarha@intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     error27@gmail.com, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org
Date:   Mon, 22 May 2023 13:28:30 -0700
In-Reply-To: <20230519064404.1659637-1-harshit.m.mogalapalli@oracle.com>
References: <20230519064404.1659637-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-18 at 23:44 -0700, Harshit Mogalapalli wrote:
> hda_ipc4_pre_trigger() has two issues:
>  1. In the default case, we are returning without unlocking the
> mutex.
>  2. In case SNDRV_PCM_TRIGGER_STOP: when ret is less than zero it
> goes
>     to out, unlocks but returns zero instead of a negative value.
> 
> Fix this by changing the final return value to 'ret' instead of zero,
> and initialize 'ret' to zero in the start of the function.
> 
> Fixes: 225f37b578a9 ("ASoC: SOF: ipc4-pcm: reset all pipelines during
> FE DAI hw_free")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Only compile tested. This is found using static anlysis with Smatch.
> ---
Thanks for this fix. LGTM.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

