Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE28565D846
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbjADQNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjADQMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:12:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85E163C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672848766; x=1704384766;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5u1MnWbPdDkdU0lePvDGFz3o3hj2dJI39QEDkTF/5Ww=;
  b=HyG/M1gBifp0AfOmJwtMF6fx/NKuH0TjuLO9GcsKBV0kOJfbBbFf3YLZ
   RBZkIJW2foc3uGOwp/01x9jetMdOwIp2aF29duwg0fAq5or11EwWosSvm
   x6zSgz5+fRbHTTKdRJgeaTM5KZQeZ7qW+RHPI7L6gAosDS3PJBHfulxGV
   wNisYaqLUpkkKI4i9jFpZj+IfbCwsuQToVfLbxZqoBJrr6JV8krVV+bgx
   j2N+xzWzkz+gvn2Cn0kE8l61MC4v6NpESmkEfmpQS50N3dRWytKBGFMYB
   e7lNNICzz+0dAx4TB1vJOu7obVdNxNWZejUm7s+4hL7397fPGrBX+ImfB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="386402221"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="386402221"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:12:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762722855"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="762722855"
Received: from hlgentry-mobl2.amr.corp.intel.com (HELO [10.212.74.62]) ([10.212.74.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:12:44 -0800
Message-ID: <151a05a5-fc56-e005-e572-d031e6de0bb1@linux.intel.com>
Date:   Wed, 4 Jan 2023 08:15:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/5] ASoC: Intel: bytcht_cx2072x: Replace open coded
 acpi_dev_put()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20230102203037.16120-1-andriy.shevchenko@linux.intel.com>
 <731b2d59-22f1-a456-bcfc-040a1adccce0@linux.intel.com>
 <Y7VVCc7TjY3YsJoV@smile.fi.intel.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Y7VVCc7TjY3YsJoV@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/23 04:29, Andy Shevchenko wrote:
> On Tue, Jan 03, 2023 at 09:08:20AM -0600, Pierre-Louis Bossart wrote:
>> On 1/2/23 14:30, Andy Shevchenko wrote:
>>> Instead of calling put_device(&adev->dev) where adev is a pointer
>>> to an ACPI device, use specific call, i.e. acpi_dev_put().
>>>
>>> Also move it out of the conditional to make it more visible in case
>>> some other code will be added which may use that pointer. We need
>>> to keep a reference as long as we use the pointer.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Answering for the series: we should make the change across all Intel
>> machine drivers. I see at least four cases that were missed
>>
>> bytcr_rt5640.c:         put_device(&adev->dev);
>> bytcr_rt5651.c:         put_device(&adev->dev);
>> bytcr_wm5102.c: put_device(&adev->dev);
>> sof_es8336.c:           put_device(&adev->dev);
> 
> Aren't they (they all problematic, btw) covered by the fixes series
> https://lore.kernel.org/r/20230102203014.16041-1-andriy.shevchenko@linux.intel.com?

They are indeed, but if you group AMD-related patches with Intel ones,
it's only human for reviewers to skip the thread entirely, even more so
when catching up with email on January 3 :-)

For this series

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


