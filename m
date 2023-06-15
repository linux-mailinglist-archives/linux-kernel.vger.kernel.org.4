Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2F6731E23
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjFOQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbjFOQrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:47:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE7B2686
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686847605; x=1718383605;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=peYeLn9BGLKhNAB74de+wNh8KFc+idh7Mo+rg1C/Ax4=;
  b=Sp7siHi2Af5uJBP/b7+k9tmp/8W1yUaoeLDwGsWs5lG+ypQ9pGV3aM4b
   XWaV9toi13NhI1ORWdmG3a+c4JFcNgrSL1wVNtunI4L9Je3qySMBTDK+R
   5V7cpUVawkqT7+YFXJrjQiwczXeFdD+qM+Ev10NB/XBEIJZxORgaeOoBt
   xuzmucSiNLl9/VUw/TKDzTomD1ivP4JvjTA8HCMdBwt4whOTSL00NvxHu
   fMDPE5157ByrRAvw8XQ9Yg5eKDuvqPcUqLU+jFmAgqT01Ru0FaMlBy+5E
   UkA5PfSYCYpqoTqW8VVztmPUvMVhHxSUhPArr4+4eYYEx5WWBS/O7P6cd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387506770"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="387506770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:46:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="857040464"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="857040464"
Received: from mrejmak-mobl.ger.corp.intel.com (HELO [10.252.36.104]) ([10.252.36.104])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:46:26 -0700
Message-ID: <9eca7ccc-7955-43d3-178a-998d0f430a4c@linux.intel.com>
Date:   Thu, 15 Jun 2023 18:46:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] soundwire: stream: Make master_list ordered to
 prevent deadlocks
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230615141208.679011-1-rf@opensource.cirrus.com>
 <20230615141208.679011-2-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230615141208.679011-2-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/23 16:12, Richard Fitzgerald wrote:
> Always add buses to the stream->master_list in a fixed order.
> The unique bus->id is used to order the adding of buses to the
> list.
> 
> This prevents lockdep asserts and possible deadlocks on streams
> that have multiple buses.
> 
> sdw_acquire_bus_lock() takes bus_lock in the order that buses
> are listed in stream->master_list. do_bank_switch() takes all
> the msg_lock in the same order.
> 
> To prevent a lockdep assert, and a possible real deadlock, the
> relative order of taking these mutexes must always be the same.
> 
> For example, if a stream takes the mutexes in the order
> (bus0, bus1) lockdep will assert if another stream takes them
> in the order (bus1, bus0).
> 
> More complex relative ordering will also assert, for example
> if two streams take (bus0, bus1) and (bus1, bus2), then a third
> stream takes (bus2, bus0).
> 
> Previously sdw_stream_add_master() simply added the given bus
> to the end of the list, requiring the caller to guarantee that
> buses are added in a fixed order. This isn't reasonable or
> necessary - it's an internal implementation detail that should
> not be exposed by the API. It doesn't really make sense when
> there could be multiple independent calling drivers, to say
> "you must add your buses in the same order as a different driver,
> that you don't know about, added them".

Makes sense to me. The other way to look at this is that the notion of
'stream' and dailink are virtually synonyms, and 'sdw_stream_add_master'
is called from each DAI of a dailink, hence in a fixed order. But
nothing really defines how dailinks include the dais, and in a
hypothetical case with multiple controllers, each with multiple links,
there would be an ambiguity anyways so using the ida-allocated bus->id
is a good solution indeed.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
