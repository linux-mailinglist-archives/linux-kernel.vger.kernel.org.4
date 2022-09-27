Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5D85EC03F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiI0LAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiI0LAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:00:40 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB7F27B06
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:00:30 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id C361E520359;
        Tue, 27 Sep 2022 13:00:27 +0200 (CEST)
Received: from lxhi-065 (10.72.94.21) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Tue, 27 Sep
 2022 13:00:27 +0200
Date:   Tue, 27 Sep 2022 13:00:22 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Yanmin Zhang <yanmin_zhang@linux.intel.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Zhang Yanmin <yanmin.zhang@intel.com>,
        Ramesh Babu <ramesh.babu@intel.com>,
        Dean Jenkins <Dean_Jenkins@mentor.com>,
        Ramesh Babu B <ramesh.babu.b@intel.com>,
        xiao jin <jin.xiao@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [PATCH] ASoC: soc-pcm: fix fe and be race when accessing
 substream->runtime
Message-ID: <20220927110022.GA3802@lxhi-065>
References: <1664210154-11552-1-git-send-email-erosca@de.adit-jv.com>
 <2f5a510b-082a-60e2-5770-58be086b5fc8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f5a510b-082a-60e2-5770-58be086b5fc8@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.94.21]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Czarek,

On Di, Sep 27, 2022 at 09:50:05 +0200, Cezary Rojewski wrote:
> On 2022-09-26 6:35 PM, Eugeniu Rosca wrote:
> >From: xiao jin <jin.xiao@intel.com>
> >
> >After start of fe and be, fe might go to close without triggering
> >STOP, and substream->runtime is freed. However, be is still at
> >START state and its substream->runtime still points to the
> >freed runtime.
> >
> >Later on, FE is opened/started again, and triggers STOP.
> >snd_pcm_do_stop => dpcm_fe_dai_trigger
> >                 => dpcm_fe_dai_do_trigger
> >                 => dpcm_be_dai_trigger
> >                 => dpcm_do_trigger
> >                 => soc_pcm_trigger
> >                 => skl_platform_pcm_trigger
> >skl_platform_pcm_trigger accesses the freed old runtime data and
> >kernel panic.
> >
> >The patch fixes it by assigning be_substream->runtime in
> >dpcm_be_dai_startup when be's state is START.
> >
> >Signed-off-by: xiao jin <jin.xiao@intel.com>
> >Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>
> >Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> 
> Hello,
> 
> The change seems to be driven by the skylake-driver problem. 

Agreed, based on the author/co-signer's e-mail and the call stack.

> With all due
> respect, why not ping owners of the driver first? There are some crucial CCs
> missing.

Some feedback already provided by Pierre-Louis Bossart (many thanks).
Cc-ing more Intel contributors in the sound subsystem.

> 
> I'd like to know more about the scenario you guys reproduced the problem in.

This patch was originally identified in the Intel Apollo Lake v4.1 KNLs.
Given that the change itself is in the core sound subsystem, our internal
assessment was that the patch might potentially be relevant/helpful
on other HW platforms.

Our intention is to confirm or invalidate this assumption with the
original developers of the patch, as well as with the audio maintainers
and the members of the alsa-devel ML.

> Configuration details and kernel base would be good to know too. Since our
> CI did not detect problem of such sort, if the problem actually exists, we
> would like to append a test or two to cover it later on.

If there is no evidence that the patch is fixing a real-life issue
occurring in the latest vanilla, I agree to drop the patch.

So far, I do not possess this evidence myself.

> Regards,
> Czarek

Best regards,
Eugeniu
