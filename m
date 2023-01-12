Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2532667956
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbjALPbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240378AbjALP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:29:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CBAB4B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673536992; x=1705072992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xDmwjywJLhxTesfoaedLfKxuHBE4U5Qc/GEUQvlSwl0=;
  b=J0WV3ra87et1E6aAEm0yK/I8VCNYzKU299kkG1jKk60clL7I8tHjbyh2
   Ui4vp7SNMSclsb0U6M6wDSLEDPL2WVe3JmQUKeQvV3B9X9YIPM5nRByxf
   kWrfNBXzyWRfSew9TGUkQRhRJsiC1GJpyA5qQ3VLyVGj6v0eP5miX+OJh
   RGsqrw46WMwEXPhmq+YtcRh2pFVdYTOVJFVyvT357NhApRVKWMDjd1p5t
   KQsmvZaguf42qIXqJK40GwjGx0/lYIhIq9GjZv8Xlqk8ViudgQ+bsbcHq
   cCXCKc+c0dUC6MqUkGVINtvHn0xzYOSheVgfZqgFzMx8o2oL3aiLSGdlS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388212570"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="388212570"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:57:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="607816928"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="607816928"
Received: from jbetan3x-mobl1.amr.corp.intel.com (HELO [10.209.143.163]) ([10.209.143.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:57:11 -0800
Message-ID: <5d7659af-ffd0-4948-4c38-68815f4ca17f@linux.intel.com>
Date:   Thu, 12 Jan 2023 08:47:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 14/19] soundwire: amd: add runtime pm ops for AMD master
 driver
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
 <20230111090222.2016499-15-Vijendar.Mukunda@amd.com>
 <1af8aa6a-9896-4d35-48de-f084fd16ebc7@linux.intel.com>
 <216b288d-16d3-5806-86fb-fc6ba83b757a@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <216b288d-16d3-5806-86fb-fc6ba83b757a@amd.com>
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



>>> +static int __maybe_unused amd_suspend_runtime(struct device *dev)
>>> +{
>>> +	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(dev);
>>> +	struct sdw_bus *bus = &ctrl->bus;
>>> +	int ret;
>>> +
>>> +	if (bus->prop.hw_disabled || !ctrl->startup_done) {
>> do you have a case where the startup is not done? This was an
>> Intel-specific thing.
> We have included startup_done flag in probe_work to check whether Manager
> has started. In case if manager init sequence fails, then there is no need
> to apply any PM ops.

Not following, sorry.

We introduced the .startup callback for intel because of a power
dependency where we could not access and initialize the registers at the
.probe time for the master driver.

Do you have a similar dependency, and if not why not remove this flag?


