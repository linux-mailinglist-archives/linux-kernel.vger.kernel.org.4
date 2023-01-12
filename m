Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C67F66794E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240223AbjALPbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjALPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:30:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E843B4BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673536993; x=1705072993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TN1PtohmiBBHyfdy4nNcbruYWz6XfuHSrNsflFeJG/8=;
  b=IUC4Bv6qknADE+tGu+ykvh1eDzxjsle5DWC4MmVg/4FMtaM4NMafgSA7
   g4A4nGF0XTQ2T7sLXqMIktAksODGFJqUBUo6OEn/KSlM8MMOoha5iNDyF
   TPP4YnrXs0s8odG4lpwRtDFF9KGspJyA3ZCkE8RRMbLxBkRAvVC4YqXR9
   DVyS+nnQtbXKq1tSTAV5jZyS2hStzksYYFgNH4/hSJlosQzfLygp0DPg2
   gRKaoxqdrLBT0Ttn0htht00Q+SXDxPhIj+otLsMa2ZbTTkWSgKs4hsrYh
   5Jrtjoy/Hr2jjCOVE5LkZiMP/9dV5y1qCgJcRBHbg05qq0+OjuQoLxMaw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388212577"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="388212577"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:57:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="607816938"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="607816938"
Received: from jbetan3x-mobl1.amr.corp.intel.com (HELO [10.209.143.163]) ([10.209.143.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:57:13 -0800
Message-ID: <9edd31f6-1208-64fd-bdde-afb72699a1f5@linux.intel.com>
Date:   Thu, 12 Jan 2023 08:50:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 17/19] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-18-Vijendar.Mukunda@amd.com>
 <a76043ad-c212-f625-8d0e-ef9460a078a5@linux.intel.com>
 <8bc313ad-aaad-8d4e-b851-d08229dd5d55@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <8bc313ad-aaad-8d4e-b851-d08229dd5d55@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +static int __maybe_unused amd_pm_prepare(struct device *dev)
>>> +{
>>> +	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
>>> +	struct sdw_bus *bus = &ctrl->bus;
>>> +	int ret;
>>> +
>>> +	if (bus->prop.hw_disabled || !ctrl->startup_done) {
>>> +		dev_dbg(bus->dev, "SoundWire master %d is disabled or not-started, ignoring\n",
>>> +			bus->link_id);
>>> +		return 0;
>>> +	}
>>> +	ret = device_for_each_child(bus->dev, NULL, amd_resume_child_device);
>>> +	if (ret < 0)
>>> +		dev_err(dev, "%s: amd_resume_child_device failed: %d\n", __func__, ret);
>>> +	if (pm_runtime_suspended(dev) && ctrl->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
>>> +		ret = pm_request_resume(dev);
>>> +		if (ret < 0) {
>>> +			dev_err(bus->dev, "pm_request_resume failed: %d\n", ret);
>>> +			return 0;
>>> +		}
>>> +	}
>>> +	return 0;
>>> +}
>> This seems to be inspired by the Intel code, but is this necessary here?
> No It's not inspired by intel code. Initially, we haven't included
> pm_prepare callback. We have observed issues without
> pm_prepare callback.
>> For Intel, we saw cases where we had to pm_resume before doing a system
>> suspend, otherwise the hardware was in a bad state.
>>
>> Do you actually need to do so, or is is possible to do a system suspend
>> when the clock is stopped.
>>
>> And in the case where the bus is in 'power-off' mode, do you actually
>> need to resume at all?
> Our platform supports different power modes. To support all
> combinations, we have included pm_prepare callback.

>> do you actually need to stop the clock before powering-off? This seems
>> counter intuitive and not so useful?
> Yes, as per our design, we need to stop the clock
> before powering off.

It'd be good to add comments capturing these points, that would be
useful for new contributors and reviewers to know this is intentional
and required by the hardware programming sequences.
