Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24716E9E05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjDTVlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjDTVlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:41:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1348110D9;
        Thu, 20 Apr 2023 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682026903; x=1713562903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HALc4FVe9LgqdT5G1DSgR3blWubsBzZEXzOIkoeKVlE=;
  b=FrRYzEnD8kRflJXtWuDTBv9OqpQpV6m43Y19Q1f6eV0g48nHkKFXESEk
   KVhZU9ORWzhRhd1hbdaqTYnpmP7kJw7dMg3fJq6/lZ5RxXG4+2MIB2Rtn
   h8PNIiebEBD28+NGPPH7XqtuUgd15p184K5Tw1WuUn3kBJ0f3KqBEli+4
   2UkTr1UxUXgLAU2fS4I3bpHuewnO4xWsy9k3yjqfjWo9oD5efSZHy1h2S
   /cAWekfdDUI6eFTGH5FG1apdW3Z6bmptASZqBtHb4dvEeF3N59AeVRmno
   iOv7VRZLzE4tS02wfoilIv/QvoJZARCSHm3i1JI/8lxT57p3f84qmmcW6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="334725957"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="334725957"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 14:41:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="803487020"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="803487020"
Received: from mprabhug-mobl.amr.corp.intel.com (HELO [10.209.102.50]) ([10.209.102.50])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 14:41:40 -0700
Message-ID: <37dfe2e3-6431-b16e-2f19-811e5b0da0fd@linux.intel.com>
Date:   Thu, 20 Apr 2023 16:13:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 5/6] soudnwire: master: protect concurrecnt check for
 bus->md
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Patrick Lai <quic_plai@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-6-krzysztof.kozlowski@linaro.org>
 <7ee41bcb-8656-49ec-40b6-15072c080d08@linux.intel.com>
 <beaec77b-9a61-6afd-59fa-fa726cae7a54@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <beaec77b-9a61-6afd-59fa-fa726cae7a54@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/23 12:27, Krzysztof Kozlowski wrote:
> On 20/04/2023 18:42, Pierre-Louis Bossart wrote:
>> typos in commit title...
>>
>> On 4/20/23 05:16, Krzysztof Kozlowski wrote:
>>> The Soundwire master controllers might want to check for bus->md
>>
>> Apologies for being pedantic but 'manager' and 'controller' are
>> different concepts in SoundWire, see DisCo spec.
>> It's not a 1:1 mapping, a controller can rely on M managers
> 
> I wrote master, not manager. For the Qualcomm case one controller is one
> master, but in general I try to avoid the master/slave terminology.

The Soundwire 1.2.1 spec moved away from master/slave and uses
manager/peripheral. It's the same concepts, just different terms. At
some point we'll update the code, it's just been too busy in 2022/2023
to do this replacement. It doesn't hurt to use the new terms.

>>> initialization to avoid race between early interrupt and finish of
>>> sdw_bus_master_add()/sdw_master_device_add().  Such early interrupt can
>>> happen if Soundwire devices are not powered off during their probe.
>>>
>>> Add a store release barrier, so the Soundwire controllers can safely
>>> check it in concurrent (e.g. in interrupt) way.
>>
>> Can you elaborate on the race condition? I am not following what breaks,
>> and what entity generates the 'early interrupt'.
> 
> The condition is explained in next patch. If you think it's better, I
> can squash it with next.
> 
> If the condition is still not clear, drop a note in next patch, so I
> will elaborate there.

will do.

>> I am specifically concerned about adding this in common code without any
>> matching smp_load_acquire() - which is only added in the following patch
>> for the Qualcomm manager only, but not added for Intel/AMD managers. Is
>> this not a problem?
> 
> Shouldn't be. The barrier just won't be effective for these drivers, but
> that should not be a problem, because I also did not add to these
> checking bus->md in a concurrent path.
> 
> Basically the barrier here is necessary because I want to check bus->md
> in Qualcomm master interrupt handler.

I really don't have any understanding or background on what this does.

Is there actually a precedent for this? I mean, dealing with the
device/driver model is already complicated, if now we have to be careful
on when the device pointer is stored it adds a whole new element of
complexity or skillset required to understand the bus operation.

Re-looking at the code, the 'md' variable is allocated in
sdw_master_device_add(), initialized with all kinds of values, used by
device_register() so presumably when you store the value it's stored
somewhere consistent, no?
