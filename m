Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39DA6B2290
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCILTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCILR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:17:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106CD2B2A1;
        Thu,  9 Mar 2023 03:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678360477; x=1709896477;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=gGJCaea3OiQnGVlsDUONFuKf0FqAHM8Mq6tZMgr0ZjY=;
  b=iuv3SWcwLzFCmvNfULe4UVGHxMwzIyDT2BPdnTNqcQbE2gH5xnzOcp0D
   CgkhSUrLkvnWSoUW9U/mZkuacKxG0vgTbZLR7VYdaswI0XCUggNRZfGa1
   vkvU+fSbqtATPL0Fh5vQB9T16fF97KpJGf3jNQg2ufSPuPMnLCubUSlnK
   HExGS8/tRXQi1yP9Gqk53nB+JHjcwKENNcz17P5gARqpwESV6ukfUsx01
   /z1JrxqRD35NYw+CdPYTWEXGEQj6gk7uJKFymv721iUmtczLpvxRyn/UZ
   lmkvFAhZpbdOeELYz2ipud/GZVl/m2rIJfDGNcl+EjHJLgNTxUoBEGuhf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="338757252"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="338757252"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 03:14:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="801144314"
X-IronPort-AV: E=Sophos;i="5.98,246,1673942400"; 
   d="scan'208";a="801144314"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.145])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 03:14:34 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: constify struct hwmon_chip_info info member harder
In-Reply-To: <e0579cbe-cbd6-46cf-b425-234cfed4ff00@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230309082841.400118-1-jani.nikula@intel.com>
 <e0579cbe-cbd6-46cf-b425-234cfed4ff00@roeck-us.net>
Date:   Thu, 09 Mar 2023 13:14:28 +0200
Message-ID: <87h6uu9nxn.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Mar 2023, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Mar 09, 2023 at 10:28:41AM +0200, Jani Nikula wrote:
>> Let the struct hwmon_chip_info info member be a pointer to a const array
>> of const pointers, rather than mutable array of const pointers.
>> 
>> Cc: Jean Delvare <jdelvare@suse.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: linux-hwmon@vger.kernel.org
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> ---
>>  include/linux/hwmon.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>> index c1b62384b6ee..492dd27a5dd8 100644
>> --- a/include/linux/hwmon.h
>> +++ b/include/linux/hwmon.h
>> @@ -430,7 +430,7 @@ struct hwmon_channel_info {
>>   */
>>  struct hwmon_chip_info {
>>  	const struct hwmon_ops *ops;
>> -	const struct hwmon_channel_info **info;
>> +	const struct hwmon_channel_info * const *info;
>
> As pointed out by 0-day, you's also have to change each
> instance where this is is assigned to another variable.

Ah, sorry, I had THERMAL_OF=n.

BR,
Jani.


>
> Guenter
>
>>  };
>>  
>>  /* hwmon_device_register() is deprecated */
>> -- 
>> 2.39.1
>> 

-- 
Jani Nikula, Intel Open Source Graphics Center
