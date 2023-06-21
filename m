Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E71C738357
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjFUL4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjFUL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:56:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF51704
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687348566; x=1718884566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7QBHZaWGpgML3bccn9yBAWgsyF73qca2uv8Bv8Cwr00=;
  b=aTRVgq9nBm8uX0TQuRRIO6A1Gs9XlY0+NEVhKOMsC6o8PFwy8WXJ0sf/
   BagwD85eTQVwAGgq4ZB26HZOdbJrKAmCHpZE+bp4CWw+NZmuUdb6oiHbC
   o/KyQXl0exwYl1pVqYv6wXBYCS1WMzEOK3ZXjr1JXJcI2okLoGddHk9QO
   pBAJ2M9bUjBcu5bvDVNFPuwW1YVekw4HZA2/APJabcTSpAczyjNG/GOe5
   J4S+3j7RvSy/Ol3GbnMCKlBh9qusvNPdkS0nkdad2MKmP+yGLMMcEvU9y
   h7vbEQ3qeCQ5xty7IsromufOdZBR0w621tfB27VR4Q8xX5IyMHPMxkDMO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="349880691"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="349880691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 04:56:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="714451259"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="714451259"
Received: from taoki-mobl1.gar.corp.intel.com (HELO [10.254.114.157]) ([10.254.114.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 04:56:04 -0700
Message-ID: <e098e8a9-533b-319e-ea0c-24af28714471@linux.intel.com>
Date:   Wed, 21 Jun 2023 13:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] soundwire: introduce SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com
References: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
 <20230531033736.792464-3-yung-chuan.liao@linux.intel.com>
 <ZIF94vZHzeGXfyin@matsya>
 <6c75e986-29a4-d97c-3862-d20397f8b8b4@linux.intel.com>
 <ZJLYQCwvvIwEj47H@matsya>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZJLYQCwvvIwEj47H@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> This seems to be a consequence of Intel hardware decisions, so I guess
>>> best suited place for this is Intel controller, do we really want to
>>> have this in core logic?
>>
>> It's a valid objection.
>>
>> The reason why I added the alternate strategies in the core logic is
>> that the IDA and hybrid approach are just software-based with no
>> specific hardware dependencies. If QCOM or AMD wanted to use the
>> strategies contributed and tested by Intel, it'd be a two-line change on
>> their side.
>>
>> That said, it's likely that at some point *someone* will want to
>> constrain the device number allocation further, be it with ACPI/DT
>> properties or reading hardware registers. The device number is a
>> de-facto priority given the way we scan the PING frames, so some systems
>> may want to give a higher priority to a specific peripherals.
>>
>> This would push us to add a master ops callback to control the device
>> number allocation. It's a bit invasive but that would give the ultimate
>> flexibility. Reuse between vendors could be possible if 'generic'
>> callbacks were part of a library to pick from.
>>
>> I don't really have any objections if this vendor-specific callback was
>> preferred, it may be a bit early to add this but long-term it's probably
>> what makes more sense.
>>
>> I'll go with the flow on suggested recommendations.
> 
> Thanks, if it all one of the other two controller start using this, it
> would make sense to move it to core then, for now would be better to
> have this in specific driver

The code is much cleaner indeed that way.

I still have to work on a race condition if the codec driver probe
happens *after* the enumeration. In that case, the properties needed to
decide which allocation to use are not initialized yet.

We may need to either force the codec to re-enumerate with a ForceReset,
or to switch the device number. In theory the latter is straightforward
but there can be additional races if there are interrupts thrown just
before the device number change happens.
