Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641FA667952
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjALPcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbjALPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:30:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24B7DFB5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673536993; x=1705072993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1ogKDa+gohWwir6wzjgRx7czWlYG4KY4+uuLFASZ8fs=;
  b=MZ8ZbP9aEqB1aC2yE4wylcIdIYSxwI1xQq2ZX8U2eRZu1M+lRaXHZCur
   S4U8TUlRzJM/m4NOubjXUUF3H+uK5IlAeWcO/JpMQsXJlRtD+gXr2nvg0
   wIovlqcIDxa9dwpEdk1ux8dDDF+saMH9G3vjm7BYPVOR0BLD1K5VDMtsQ
   kCvMosJy/X3qGJhw/GEPMJ4xr0WD04pS66eJe4FNbDzoNd5rnZ7Vl4xMY
   DNqd+CCr641bXLifb1jZEX6SSCTHiPJ1aCTCfjFPj/rNERr85QXFI14s8
   IfSpB3rzao3SuDuE+b/BBT87E2iQla8invLF6qBWecZkv/FDLoFtm8JIm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388212586"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="388212586"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:57:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="607816940"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="607816940"
Received: from jbetan3x-mobl1.amr.corp.intel.com (HELO [10.209.143.163]) ([10.209.143.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:57:14 -0800
Message-ID: <5a34e6f7-eaf1-8128-81e4-81f65541d9a8@linux.intel.com>
Date:   Thu, 12 Jan 2023 08:54:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mario.Limonciello@amd.com,
        arungopal.kondaveeti@amd.com,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-20-Vijendar.Mukunda@amd.com>
 <c7f018e3-c8be-6819-0ece-244bfb943c62@linux.intel.com>
 <0aaf3fa5-bcf1-ec06-8f78-c61e8809398e@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <0aaf3fa5-bcf1-ec06-8f78-c61e8809398e@amd.com>
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



On 1/12/23 05:02, Mukunda,Vijendar wrote:
> On 11/01/23 21:32, Pierre-Louis Bossart wrote:
>> On 1/11/23 03:02, Vijendar Mukunda wrote:
>>> To avoid ACP entering into D3 state during slave enumeration and
>>> initialization on two soundwire controller instances for multiple codecs,
>>> increase the runtime suspend delay to 3 seconds.
>> You have a parent PCI device and a set of child devices for each
>> manager. The parent PCI device cannot suspend before all its children
>> are also suspended, so shouldn't the delay be modified at the manager level?
>>
>> Not getting what this delay is and how this would deal with a lengthy
>> enumeration/initialization process.
> Yes agreed. Until Child devices are suspended, parent device will
> be in D0 state. We will rephrase the commit message.
> 
> Machine driver node will be created by ACP PCI driver.
> We have added delay in machine driver to make sure
> two manager instances completes codec enumeration and
> peripheral initialization before registering the sound card.
> Without adding delay in machine driver will result early card
> registration before codec initialization is completed. Manager
> will enter in to bad state due to codec read/write failures.
> We are intended to keep the ACP in D0 state, till sound card
> is created and jack controls are initialized. To handle, at manager
> level increased runtime suspend delay.

This doesn't look too good. You should not assume any timing
dependencies in the machine driver probe. I made that mistake in earlier
versions and we had to revisit all this to make sure drivers could be
bound/unbound at any time.
