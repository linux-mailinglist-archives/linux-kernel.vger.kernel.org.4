Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD105EFA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiI2Q1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiI2Q0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:26:40 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE4EFA0F3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:25:37 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id 72D6F5201DA;
        Thu, 29 Sep 2022 18:25:34 +0200 (CEST)
Received: from lxhi-065 (10.72.94.4) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Thu, 29 Sep
 2022 18:25:33 +0200
Date:   Thu, 29 Sep 2022 18:25:29 +0200
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
Message-ID: <20220929162529.GA7982@lxhi-065>
References: <1664210154-11552-1-git-send-email-erosca@de.adit-jv.com>
 <2f5a510b-082a-60e2-5770-58be086b5fc8@intel.com>
 <20220927110022.GA3802@lxhi-065>
 <21ffd91e-8089-0a57-bdb6-d73246079398@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <21ffd91e-8089-0a57-bdb6-d73246079398@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.94.4]
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

Thank you for your friendly feedback.

On Mi, Sep 28, 2022 at 04:24:43 +0200, Cezary Rojewski wrote:
> On 2022-09-27 1:00 PM, Eugeniu Rosca wrote:
> >Hello Czarek,
> 
> ...
> 
> >>I'd like to know more about the scenario you guys reproduced the problem in.
> >
> >This patch was originally identified in the Intel Apollo Lake v4.1 KNLs.
> >Given that the change itself is in the core sound subsystem, our internal
> >assessment was that the patch might potentially be relevant/helpful
> >on other HW platforms.
> >
> >Our intention is to confirm or invalidate this assumption with the
> >original developers of the patch, as well as with the audio maintainers
> >and the members of the alsa-devel ML.
> >
> >>Configuration details and kernel base would be good to know too. Since our
> >>CI did not detect problem of such sort, if the problem actually exists, we
> >>would like to append a test or two to cover it later on.
> >
> >If there is no evidence that the patch is fixing a real-life issue
> >occurring in the latest vanilla, I agree to drop the patch.
> >
> >So far, I do not possess this evidence myself.
> 
> 
> I've spent some time to locate the change. Found it and it seems obsolete.
> Some tags are missing in the revision of yours and the original date does
> not match either - it's Apr 2018 for the original. Won't be mentioning the
> tags as some engineers no longer bear @intel.com.
> 
> soc-pcm and skylake-driver valuable bits from those trees are already part
> of the upstream. Most of what is left was later proven obsolete or redundant
> by my or Pierre's engineers. There seems to be no patch missing except for
> few fixes from the recent SKL/KBL up-revs for our clients. Nothing APL
> specific.

Thanks for this thorough check. That also gives us enough confidence
to drop the patch in some of our downstream kernels.

> 
> Following kernels related to APL are maintained by the IPG team from
> software perspective:
> 	4.1.42, 4.1.49, 4.4, 4.9, 4.14, 4.19
> 
> Multiple OSes. And then there are flavors for kernels/OS both. It's quite
> likely kernel base of yours fits into one of these buckets or at least have
> had changes ported from one of them.

Good to know and yes, you are right w.r.t. the origin of the patch.

> 
> TLDR: I agree here with my colleagues - if you believe the change is
> necessary, a proof e.g.: in form of reproduction steps, is needed. Otherwise
> it's no-go. Happy to hop on a call should you need any additional
> information.

That's a very kind attitude and we will definitely share any empirical
evidence if it turns out the patch is really contributing with healing
of any future runtime issues.

> 
> Regards,
> Czarek

Best Regards
Eugeniu
