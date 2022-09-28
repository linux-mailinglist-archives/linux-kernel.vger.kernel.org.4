Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95665ED807
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiI1Ijz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiI1IjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72335A0279
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664354363; x=1695890363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Nh8zVkI764C79JD/zOGUpjoTiHdV4xPlRb3vpHlIbd4=;
  b=R3TMPCjr9CUyH3KBzXsdx19JE2bvGJaVMzFXGVY+oJ8EYO2C8ip0fmsD
   S1j5dPhIOslbUe3HIGIdFFmff3rw2sc5PgN/76E6bJI/4j88pZHSZgbTM
   wC6pf3aETcumgGbHhREC47ojiVIc9IB5qrbjqy4M4inXxOB1MphSY9ayY
   yOo/d9jyKSQhUvQu57EUgK/4UkRk491IfRZSNA16uAeU5cpr9+aFZ9lTV
   o+Dk4gsVJ+JzbPStVmRqUhusAB3xqf1X1ulQldsBvOwPIq8KBqVCGISUq
   +suvpSxjYMmeDPrida7UkelU6W2CGvq2RLcoNhX96ILl6YOZwW76vw9O4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="288701789"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="288701789"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:39:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="617131356"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="617131356"
Received: from morank-mobl3.ger.corp.intel.com (HELO [10.251.211.7]) ([10.251.211.7])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:39:17 -0700
Message-ID: <9cb844a7-6eac-0085-3c8c-32004a22c849@linux.intel.com>
Date:   Wed, 28 Sep 2022 10:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: soc-pcm: fix fe and be race when accessing
 substream->runtime
Content-Language: en-US
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Yanmin Zhang <yanmin_zhang@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Zhang Yanmin <yanmin.zhang@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ramesh Babu <ramesh.babu@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dean Jenkins <Dean_Jenkins@mentor.com>,
        Mark Brown <broonie@kernel.org>,
        Ramesh Babu B <ramesh.babu.b@intel.com>,
        xiao jin <jin.xiao@intel.com>
References: <1664210154-11552-1-git-send-email-erosca@de.adit-jv.com>
 <bdf56f23-1019-b4c8-a11a-3934db432cf1@linux.intel.com>
 <20220927123043.GB4547@lxhi-065>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220927123043.GB4547@lxhi-065>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/22 14:30, Eugeniu Rosca wrote:
> Hi Pierre,
> 
> On Di, Sep 27, 2022 at 09:51:46 +0200, Pierre-Louis Bossart wrote:
>> On 9/26/22 18:35, Eugeniu Rosca wrote:
>>> From: xiao jin <jin.xiao@intel.com>
>>>
>>> After start of fe and be, fe might go to close without triggering
>>> STOP, and substream->runtime is freed. However, be is still at
>>> START state and its substream->runtime still points to the
>>> freed runtime.
>>>
>>> Later on, FE is opened/started again, and triggers STOP.
>>> snd_pcm_do_stop => dpcm_fe_dai_trigger
>>>                 => dpcm_fe_dai_do_trigger
>>>                 => dpcm_be_dai_trigger
>>>                 => dpcm_do_trigger
>>>                 => soc_pcm_trigger
>>>                 => skl_platform_pcm_trigger
>>> skl_platform_pcm_trigger accesses the freed old runtime data and
>>> kernel panic.
>>>
>>> The patch fixes it by assigning be_substream->runtime in
>>> dpcm_be_dai_startup when be's state is START.
>>
>> Can I ask on which kernel this patch was validated and on what platform?
> 
> As shared with Czarek in https://lore.kernel.org/alsa-devel/20220927110022.GA3802@lxhi-065/ ,
> this patch was originally extracted from the out-of-tree Intel Apollo
> Lake v4.1 KNL releases, hence it was validated on Intel ref.boards.
> 
> No re-testing/re-validation has been performed on the latest vanilla.

There's no way to predict how a patch for a kernel 4.1 - released 7
years ago - would behave with a new kernel. If it's not tested it cannot
be merged.

> One of the goals behind submitting the patch is getting in touch
> with the original authors, as well as the members of alsa-devel,
> to assess if the patch is still relevant.

The only thing we could do is have more clarity on the test case and try
to reproduce it.

>>
>> We've done a lot of work since last year on DPCM states, 
> 
> Could you please feedback if the work on the DPCM states is
> pre- or post-v5.10?

It doesn't matter for this discussion on the upstream kernel. But yes
it's post v5.10.

> 
>> and I wonder
>> the problem mentioned above actually exists on recent kernels.
>>
>> Specifically, if the FE is closed, I don't get how the BE is not closed
>> as well. And if this problem is found on a recent kernel, then it should
>> be seen in the AVS driver as well, no?
> 
> It is totally conceivable (if not very likely) that the mainline
> advancements in the sound subsystem make this patch obsolete.
> 
> I would be happy if that's the final outcome of our discussion
> (since this will allow dropping the patch in our downstream kernel).
> 
> Best Regards,
> Eugeniu
