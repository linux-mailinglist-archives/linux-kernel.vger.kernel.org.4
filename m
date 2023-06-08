Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB0072833F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjFHPJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjFHPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:09:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168A32D59
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686236971; x=1717772971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gLEq3vi4ShR5o0t/JrKR4zfOv7ndOd96flRBabiHYaw=;
  b=jGoXrlky67sgZcgAZEjEyXuGvU2a3SI9hKedTgf9V9uaQLvchWljLq4r
   fz+rwUsJ+KZ9vb+dxdSRBMss66QH4o3In0QKvzxDgwBlj3KoXfmNJ9xRK
   4zEzHPZ8vWsD7TXtecJJtwiOUDRJI/ObOeMhxQMJ81ObumodmR2UbbuUk
   qw2b5KJ1JyA/nMcy0TYpYstWHyytgxcIomraJw7Q3ppAnBlNPfpJa4wKy
   ixWfELWaLKgQsmtiKXZuUQJtL3pHLr5UoxmB8SNU0rSq+FZNwkJP+CL62
   RWkaTy4wDWLhQEcGxoe81xbQMUzVYDF9j7gIUjWY/YvUzvlX3Es83omXO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="443700529"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="443700529"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 08:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="799842560"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="799842560"
Received: from svuppala-mobl.amr.corp.intel.com (HELO [10.212.207.249]) ([10.212.207.249])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 08:09:29 -0700
Message-ID: <e07d507e-57bf-a2b7-2ab1-f5f45ff5399b@linux.intel.com>
Date:   Thu, 8 Jun 2023 08:24:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] soundwire: extend parameters of
 new_peripheral_assigned() callback
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bard.liao@intel.com
References: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
 <20230531033736.792464-4-yung-chuan.liao@linux.intel.com>
 <ZIF+G1mbis/lb8Po@matsya>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <ZIF+G1mbis/lb8Po@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> -static void generic_new_peripheral_assigned(struct sdw_bus *bus, int dev_num)
>> +static void generic_new_peripheral_assigned(struct sdw_bus *bus,
>> +					    struct sdw_slave *slave,
>> +					    int dev_num)
>>  {
>>  	struct sdw_cdns *cdns = bus_to_cdns(bus);
>>  	struct sdw_intel *sdw = cdns_to_intel(cdns);
>> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
>> index 8a7541ac735e..41a856bedf1e 100644
>> --- a/include/linux/soundwire/sdw.h
>> +++ b/include/linux/soundwire/sdw.h
>> @@ -861,7 +861,9 @@ struct sdw_master_ops {
>>  	int (*pre_bank_switch)(struct sdw_bus *bus);
>>  	int (*post_bank_switch)(struct sdw_bus *bus);
>>  	u32 (*read_ping_status)(struct sdw_bus *bus);
>> -	void (*new_peripheral_assigned)(struct sdw_bus *bus, int dev_num);
>> +	void (*new_peripheral_assigned)(struct sdw_bus *bus,
>> +					struct sdw_slave *slave,
> 
> maybe better, drop the bus and pass slave (which contains bus)

I kept it for consistency, all callbacks for sdw_master_ops start with
the bus parameter.
