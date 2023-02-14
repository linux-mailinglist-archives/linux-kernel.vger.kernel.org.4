Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C68F696DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjBNTXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBNTWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:22:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55BE1717E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676402574; x=1707938574;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YaJ0/vzyPE93lfO9brhHqKXTla+RNyrMuB6BfPzFkHk=;
  b=nbEUKl5TYwyetZ3V/TmX7OjwE/krKpZIOCTum2UeNm2V0+X5wDTLg5rm
   SUbottrXOAT6ZXp5frK5a9LAroQmnazEcISClvcFI4D0yFEBhrmaEZByh
   UW3ORcL5s4KWB+JtB/P+gmjwvx5yJnbDWoOy16o4MYWUbh1zEstCUNS40
   Er8i5kX2XZQNZAmMe9Quhs4raZMh2WvWqQaCTVBFnVelxdjdWvw7aZJ32
   4FZgMfTx0D7jHhqyujF9krFQIMJMOewlfqMNtRLDgPsiTU0u5isUuBYa8
   VgNKvCXxbXV7XKBS029nWvfDdf5gJK8NZLq5QEsbC5UP/4hxfx/SWPWPP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="314893724"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="314893724"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:22:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="778485245"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="778485245"
Received: from parthgup-mobl2.amr.corp.intel.com (HELO [10.209.175.23]) ([10.209.175.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:22:53 -0800
Message-ID: <e32e9508-9c91-b8ab-c862-b861aca8c02c@linux.intel.com>
Date:   Tue, 14 Feb 2023 07:35:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V2 7/8] soundwire: amd: handle soundwire wake enable
 interrupt
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
 <20230213094031.2231058-8-Vijendar.Mukunda@amd.com>
 <cd70a91c-231e-1bca-b0ac-4041cba0daad@linux.intel.com>
 <586a9f58-f660-1ac0-0506-91362b25f75d@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <586a9f58-f660-1ac0-0506-91362b25f75d@amd.com>
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



>>>  static void amd_sdw_irq_thread(struct work_struct *work)
>>>  {
>>>  	struct amd_sdw_manager *amd_manager =
>>> @@ -945,6 +952,9 @@ static void amd_sdw_irq_thread(struct work_struct *work)
>>>  	status_change_0to7 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
>>>  	dev_dbg(amd_manager->dev, "%s [SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
>>>  		__func__, amd_manager->instance, status_change_0to7, status_change_8to11);
>>> +	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
>>> +		return amd_sdw_process_wake_event(amd_manager);
>>> +
>> it's not clear what 8to11 might have to do with the wake enable?
>>
>> Can't you have a wake for devices 1..7?
> It can wake any device from 1..11 .
> SoundWire Wake interrupt status bit is part of 8to11 register.

You probably want to explain what status_change_0to7 and
status_change_8to11 actually control, it's not very intuitive for me to
see device 1 interrupt being handled in status_change_8to11?
