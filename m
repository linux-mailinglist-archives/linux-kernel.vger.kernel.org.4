Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C01D6B0AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjCHOXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCHOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:23:35 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9532BB3E20
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678285413; x=1709821413;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xwerx2xXUaxAefu4ArBHqTpEi/j/Yfjg8iwscA9h5+0=;
  b=Mc3TSdHgtEdspjWZS3ZdgrBDmUAxX0OEi2cBSYSxxsgMlYw4poeL5LQ5
   DiIcepNSW2pEHHjFarGBjbuzM+mCbGBoFqRYItjmZ9Cg+zUdPAyyu5VCb
   F7cQu1+TlcDHA4RBe0N5NyA+6dNR0bJInppa0mOJK1zsrrtmZStKfSVw5
   /s+lX8UaMl/y7GMU/Ep9bdzJrNBKk3oA44ywy8lfdsK91RR7zqO5q/Olw
   HC1lDhr8vHmeUOViUtYJ8E0UukINTSKqVW2z8abLmdguwbpOdh8DsWd3t
   6W0onrLiweNKez1SZzx4DJEu4H4kMpZ+vBfjNadUVmleBPoIbHh5oF6xy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422432633"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="422432633"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 06:23:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="800768131"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="800768131"
Received: from vkhatavx-mobl.amr.corp.intel.com (HELO [10.255.34.124]) ([10.255.34.124])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 06:23:28 -0800
Message-ID: <dfb09d78-0620-e535-08b6-894554201ead@linux.intel.com>
Date:   Wed, 8 Mar 2023 08:23:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V6 8/8] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, claudiu.beznea@microchip.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
 <20230307133135.545952-9-Vijendar.Mukunda@amd.com>
 <4330af6a-ce97-53ed-f675-6d3d0ac8f32f@linux.intel.com>
 <d5a75826-d762-27fc-5820-6826debdecd9@amd.com>
 <9399110b-bbba-f96e-85ef-a317e8f4d518@linux.intel.com>
 <4cbbff8a-c596-e9cc-a6cf-6f8b66607505@amd.com>
 <85aba51e-1feb-5eb0-2e21-b714e217f9e4@linux.intel.com>
 <2e629a29-093e-46e9-2329-0d5afc916ee4@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <2e629a29-093e-46e9-2329-0d5afc916ee4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> device_for_each_child() will invoke amd_resume_child_device() function callback
>>> for each device which will try to resume the child device in this case.
>>> By definition, device_for_each_child() Iterate over @parent's child devices,
>>> and invokes the callback for each. We check the return of amd_resume_child_device()
>>> each time.
>>> If it returns anything other than 0, we break out and return that value.
>>>
>>> In current scenario, As AMP codec is not in runtime suspend state,
>>> pm_request_resume() will return a value as 1. This will break the
>>> sequence for resuming rest of the child devices(JACK codec in our case).
>> Well, yes, now that makes sense, thanks for the details.
>>
>> I think the reason why we didn't see the problem with the Intel code is
>> that both amplifiers are on the same dailink, so they are by
>> construction either both suspended or both active. We never had
>> different types of devices on the same link.
>>
>> I would however suggest this simpler alternative, where only negative
>> return values are returned:
>>
>> ret = pm_request_resume(dev);
>> if (ret < 0) {
>> 	dev_err(dev, "pm_request_resume failed: %d\n", ret);
>>         return ret;
>> }
>> return 0;
>>
>> this would work just fine, no?
>> No, As explained, pm_request_resume() return value is 1 for active device.
>>> As mentioned in an earlier thread, there are two possible solutions.
>>> 1. check pm runtime suspend state and return 0 if it is not suspended
>>> 2. simply always return 0 for amd_resume_child_device() function callback.
>>>
>>> We opted first one as solution.
>> My suggestion looks like your option 2. It's cleaner IMHO.
> To use option 2, we need to respin the patch series.
> Is it okay if we fix it as supplement patch?

I would vote for re-spinning a new version and ask others to review.
