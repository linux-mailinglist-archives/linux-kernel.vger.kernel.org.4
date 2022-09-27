Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA32B5EC2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiI0MbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiI0Mas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:30:48 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7DDDF38F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:30:45 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id 17EAA520214;
        Tue, 27 Sep 2022 14:30:44 +0200 (CEST)
Received: from lxhi-065 (10.72.94.21) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Tue, 27 Sep
 2022 14:30:43 +0200
Date:   Tue, 27 Sep 2022 14:30:43 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH] ASoC: soc-pcm: fix fe and be race when accessing
 substream->runtime
Message-ID: <20220927123043.GB4547@lxhi-065>
References: <1664210154-11552-1-git-send-email-erosca@de.adit-jv.com>
 <bdf56f23-1019-b4c8-a11a-3934db432cf1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bdf56f23-1019-b4c8-a11a-3934db432cf1@linux.intel.com>
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

Hi Pierre,

On Di, Sep 27, 2022 at 09:51:46 +0200, Pierre-Louis Bossart wrote:
> On 9/26/22 18:35, Eugeniu Rosca wrote:
> > From: xiao jin <jin.xiao@intel.com>
> > 
> > After start of fe and be, fe might go to close without triggering
> > STOP, and substream->runtime is freed. However, be is still at
> > START state and its substream->runtime still points to the
> > freed runtime.
> > 
> > Later on, FE is opened/started again, and triggers STOP.
> > snd_pcm_do_stop => dpcm_fe_dai_trigger
> >                 => dpcm_fe_dai_do_trigger
> >                 => dpcm_be_dai_trigger
> >                 => dpcm_do_trigger
> >                 => soc_pcm_trigger
> >                 => skl_platform_pcm_trigger
> > skl_platform_pcm_trigger accesses the freed old runtime data and
> > kernel panic.
> > 
> > The patch fixes it by assigning be_substream->runtime in
> > dpcm_be_dai_startup when be's state is START.
> 
> Can I ask on which kernel this patch was validated and on what platform?

As shared with Czarek in https://lore.kernel.org/alsa-devel/20220927110022.GA3802@lxhi-065/ ,
this patch was originally extracted from the out-of-tree Intel Apollo
Lake v4.1 KNL releases, hence it was validated on Intel ref.boards.

No re-testing/re-validation has been performed on the latest vanilla.

One of the goals behind submitting the patch is getting in touch
with the original authors, as well as the members of alsa-devel,
to assess if the patch is still relevant.

> 
> We've done a lot of work since last year on DPCM states, 

Could you please feedback if the work on the DPCM states is
pre- or post-v5.10?


> and I wonder
> the problem mentioned above actually exists on recent kernels.
> 
> Specifically, if the FE is closed, I don't get how the BE is not closed
> as well. And if this problem is found on a recent kernel, then it should
> be seen in the AVS driver as well, no?

It is totally conceivable (if not very likely) that the mainline
advancements in the sound subsystem make this patch obsolete.

I would be happy if that's the final outcome of our discussion
(since this will allow dropping the patch in our downstream kernel).

Best Regards,
Eugeniu
