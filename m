Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F208E696DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjBNTW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjBNTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:22:54 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2817A9D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676402573; x=1707938573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MwWMU+rMHLjigK24HlxQlmHYNQyOiL5KfCQk3L4iDY0=;
  b=cLnzU/yVPLfiV7ZqxYNdO0n2BBbMJzWPeViM7nqIy5Bmy9YIia234w/t
   /JkMkvvJRfjU3YSx9oAgirZxxBI9Kwwja+i8M5pP7xvhIEv2E6UoA7Ugf
   knjRNP4lkrNlNxJ0oCXLTUKLqe2rjAzan/ES4a7bL98wLVy3Wyc9GHB9h
   H5Mp/zPlU9h0JHlg6gGRMxV5aKPuBckNAy61R3UUCnyBrUdrI1+Umltrt
   xOk7TnPEo+ZsS6x4ld8/pOKoVj32aaU0WSMwTo1WBHHffQEEfGrpPwckl
   luLhpY1e9Rdqy4PJ5TVZV/Lx8AMxbr0yuMKjyYvSN2n5AkVjaqfgDVYR6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="314893716"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="314893716"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:22:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="778485242"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="778485242"
Received: from parthgup-mobl2.amr.corp.intel.com (HELO [10.209.175.23]) ([10.209.175.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:22:52 -0800
Message-ID: <37fbb1d4-60f1-5cba-180a-ba51922fdca8@linux.intel.com>
Date:   Tue, 14 Feb 2023 07:33:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V2 6/8] soundwire: amd: add runtime pm ops for AMD
 soundwire manager driver
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-7-Vijendar.Mukunda@amd.com>
 <383a8166-bc60-8557-e76b-f6287c967598@linux.intel.com>
 <65ec1f29-2ad2-acd6-feff-7d1d6f40ef8b@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <65ec1f29-2ad2-acd6-feff-7d1d6f40ef8b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>> +/* AMD pm_runtime quirk definitions */
>>> +
>>> +/*
>>> + * Force the clock to stop(ClockStopMode0) when suspend callback
>>> + * is invoked.
>>> + */
>>> +#define AMD_SDW_CLK_STOP_MODE		1
>>> +
>>> +/*
>>> + * Stop the bus when runtime suspend/system level suspend callback
>>> + * is invoked. If set, a complete bus reset and re-enumeration will
>>> + * be performed when the bus restarts.
>>> + */
>>> +#define AMD_SDW_POWER_OFF_MODE		2
>> You need to clarify this mode, can you deal with device in-band wakes if
>> the power is off?
> On the Current platform, in-band wakes are not supported if the power is off.

Humm, that's an important clarification.

Does this mean your link0 will never use the POWER_OFF_MODE since it
includes support for headset codecs and you want the ability to detect
jacks status changes?

Or is this more like CLK_STOP_MODE is used in runtime pm and POWER_OFF
in system suspend?
