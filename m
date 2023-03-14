Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C796B9C31
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCNQw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCNQw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:52:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1724A7297
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678812745; x=1710348745;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oNi4BX+iKjrFr9Qkqgho/ks/S4QSnsTm6ASF6mIQHk4=;
  b=cFfYPpII0rXX+rftRAXnBzBzinLClmLLrCeBZBny/nZsLSkPh7iPRIPq
   YCKhurbRvvMeKKrHPuTTxhsZxZa8xQ/iFHl4qj4F0HqbQt5XPlOeKKFlr
   7GDDX4YNLd59LhFPLEsaUQT+smbAmIylC+fx+gjr44U2Vp0Mk3/E7WoGC
   9PInw0np/lpFpdwjz3aI2mPoo6DnfT5z5R+UriwRl6ukHFDsZPSDZOSma
   JBDb6Xf8+RBfA2mNlQUD0WmfVP9pK9DFDW9av+UyjDLvQC9xVFbDi4P1j
   HH4r2drNbUaQvAw5s/NcEkaEe4QiYzG0xZ4s4ZBhN+YD7fc2Iraq3i8Aj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317879560"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317879560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="672417494"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="672417494"
Received: from hsaquing-mobl.amr.corp.intel.com (HELO [10.255.35.31]) ([10.255.35.31])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:52:24 -0700
Message-ID: <5e26ef3e-1319-25cd-f7d5-245eaea66769@linux.intel.com>
Date:   Tue, 14 Mar 2023 11:52:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH] ASoC: soc-compress: Inherit atomicity from DAI link for
 Compress FE
Content-Language: en-US
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
        linux-kernel@vger.kernel.org, paul.olaru@nxp.com
References: <20230314153409.1805280-1-daniel.baluta@oss.nxp.com>
 <6d9d09aa-d83e-e811-1d43-34780ea05d4d@linux.intel.com>
 <CAEnQRZAj-FW-fCWsyupUDAH4Z2kTf0RL1acivyDHszMuU-75pg@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAEnQRZAj-FW-fCWsyupUDAH4Z2kTf0RL1acivyDHszMuU-75pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/23 11:37, Daniel Baluta wrote:
> On Tue, Mar 14, 2023 at 6:14 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>
>>
>> On 3/14/23 10:34, Daniel Baluta wrote:
>>> From: Daniel Baluta <daniel.baluta@nxp.com>
>>>
>>> After commit bbf7d3b1c4f40 ("ASoC: soc-pcm: align BE 'atomicity' with
>>> that of the FE") BE and FE atomicity must match.
>>>
>>> In the case of Compress PCM there is a mismatch in atomicity between FE
>>> and BE and we get errors like this:
>>>
>>> [   36.434566]  sai1-wm8960-hifi: dpcm_be_connect: FE is atomic but BE
>>> is nonatomic, invalid configuration
>>
>> Not clear on the 'FE is atomic' in the case of a compressed stream,
>> which has to be handled with some sort of IPC, i.e. be nonatomic.
>>
> 
> 'FE is atomic' in this message is printed because this is the default value
> of nonatomic field when PCM struct associated for a Compress PCM
> struct is allocated.
> 
> No one changes 'nonatomic' field for Compress FE until my current patch.
> 
>> Also not sure why the FE is not set as nonatomic by the SOF parts?
>> If it's needed for PCM, why wouldn't it be needed for compressed data?
> 
> FE is not touched for SOF parts. Only BE is set to nonatomic by SOF.

Where do you see the BE being changed by SOF?

> 
> See: sound/soc/topology.c
> 
> »       /* Set nonatomic property for FE dai links as their trigger
> action involves IPC's */
> »       if (!link->no_pcm) {
> »       »       link->nonatomic = true;
> »       »       return 0;
> »       }

that's a FE property, not BE.

> FE for PCM is modified by sound/soc/soc-pcm.c
> 
> int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
> »       pcm->nonatomic = rtd->dai_link->nonatomic;
> 
> So, I guess people assumed that is enough to use RTD dai link to set
> pcm->noatomic field
> and didn't look at it in SOF.

Ah yes, now I see your point now. You still had a logical inversion
above but you're correct here.

> When FE for Compress PCM is created, we don't use soc_new_pcm but instead
> we use snd_pcm_new_internal which doesn't inherit the nonatomic field
> of the rtd->dai_link
> as Normal PCM does inside soc_pcm_new.
> 
> So, my patch makes sure we inherit the nonatomic field from
> rtd->dai_link also for Compress PCM
> similar with what already happens for Normal PCM.
> 
> tl;dr: when creating a Normal PCM pcm->nonatomic is inherited from RTD
> DAI link. when creating a
> Compress PCM pcm->nonatomic field is not set. This patch makes sure
> that for Compres PCM
> we also inherit nonatomic from RTD DAI link.

That makes sense. It's quite likely that the compress PCM should be
nonatomic by default, not sure how it can work otherwise.


