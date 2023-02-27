Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C0A6A4B52
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjB0Tl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0Tl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:41:27 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1A327D59
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677526866; x=1709062866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wCFnF2gzwXlFH5IRtpyapY9jGTWsCFYXSJ90EedowJo=;
  b=RsPa+scvbrUETTAVQm8eqoNk8Z1TE/E2vsZJ7aVDPjsYSMlfbdWrX+e+
   hQreJagjFQojR3uyGXMYOYRYWBnaRGNJ6F+x9+W/0AsPHUaNuX0TJ2zqU
   37BpgFWbwyzK7INqPnGCIUhnIlTHC8QOKkRG4WnXoDdEGhpyIdCmrPDGW
   FSBMcvdmksXCXjIYzY4CHExIs7t8oOwIX0B1A9rGKjWguVjdS3Pamz36U
   43+S0xqQ8OmK8wfN8ce2kcHWKTkhhyle9zA8Hl0HYSCZUAhIi54ai0czg
   dCNwItnWUc2/jYEWVKsJgckclDSf8E35OuHFpeV8n1iyxZCyJbk9Gd4co
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313622850"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="313622850"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 11:41:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="783512734"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="783512734"
Received: from jaidenno-mobl.amr.corp.intel.com (HELO [10.212.85.4]) ([10.212.85.4])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 11:40:58 -0800
Message-ID: <3a6d02a6-0b1d-6e9e-2f14-337373edec48@linux.intel.com>
Date:   Mon, 27 Feb 2023 14:40:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH V4 8/8] soundwire: amd: add pm_prepare callback and pm ops
 support
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        amadeuszx.slawinski@linux.intel.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
 <20230227154801.50319-9-Vijendar.Mukunda@amd.com>
 <82c7303b-131e-0633-2c08-5b4b414ad941@linux.intel.com>
 <acd3a560-1218-9f1d-06ec-19e4d3d4e2c9@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <acd3a560-1218-9f1d-06ec-19e4d3d4e2c9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/23 13:42, Mukunda,Vijendar wrote:
> On 27/02/23 22:37, Pierre-Louis Bossart wrote:
>>
>> On 2/27/23 10:48, Vijendar Mukunda wrote:
>>> Add pm_prepare callback and System level pm ops support for
>>> AMD SoundWire manager driver.
>>>
>>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
>> seems like you missed my comments in
>> https://lore.kernel.org/alsa-devel/7d32d552-6ca0-3c40-11ce-c8d727cadc05@linux.intel.com/
> you missed my mail in reply thread. That's why we couldn't
> get a chance to check your review comments.

I don't see a reply be it in my local mail client or lore?
