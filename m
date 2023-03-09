Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF846B2B31
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCIQvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCIQuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:50:52 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D741CFEF01;
        Thu,  9 Mar 2023 08:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678380080; x=1709916080;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=LpKKxWLJd/2/HZY+u/kidQL3j7csPh9OlT1rlldT9go=;
  b=W2nIRKWE1Sfy4KbLeGTet9BC7enfkNhQboYsqaJQdI9+w1h2NyGoHujr
   sgBizH9ahTXQLYvv4onRVN2LgJ4PfxJx32NzZTH7QVytbs+joWu3Wj89p
   MMK9Gkqz6AXW1taKNF0A166i70ZfHuYSNXqlMTdIlWBxyUqzZ3JbmPxn7
   sTzKEjxV7EIxwQEZqwHJOyyZFiUZBNMHBkP1tHDX4VCA9Yn21090FPMq2
   Pu+2wksmW6hvxa6W3xNPMjbrT264iU8fDkBTXhtp+SrkTefxcfnzOzhf1
   CKH17ji1bR9LbueK0vgJ70BD6Wbh02+y7z/OkGypHDt641jk6dCDIl9sL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="320346106"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="320346106"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 08:41:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="851563693"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="851563693"
Received: from msobrero-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.58.113])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 08:41:18 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: constify struct hwmon_chip_info info member harder
In-Reply-To: <2f0a6217-3747-4493-90e6-8fb129cb6a34@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230309082841.400118-1-jani.nikula@intel.com>
 <e0579cbe-cbd6-46cf-b425-234cfed4ff00@roeck-us.net>
 <87h6uu9nxn.fsf@intel.com>
 <2f0a6217-3747-4493-90e6-8fb129cb6a34@roeck-us.net>
Date:   Thu, 09 Mar 2023 18:41:11 +0200
Message-ID: <87zg8l98t4.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Mar 2023, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Mar 09, 2023 at 01:14:28PM +0200, Jani Nikula wrote:
>> On Thu, 09 Mar 2023, Guenter Roeck <linux@roeck-us.net> wrote:
>> > On Thu, Mar 09, 2023 at 10:28:41AM +0200, Jani Nikula wrote:
>> >> Let the struct hwmon_chip_info info member be a pointer to a const array
>> >> of const pointers, rather than mutable array of const pointers.
>> >> 
>> >> Cc: Jean Delvare <jdelvare@suse.com>
>> >> Cc: Guenter Roeck <linux@roeck-us.net>
>> >> Cc: linux-hwmon@vger.kernel.org
>> >> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> >> ---
>> >>  include/linux/hwmon.h | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> 
>> >> diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
>> >> index c1b62384b6ee..492dd27a5dd8 100644
>> >> --- a/include/linux/hwmon.h
>> >> +++ b/include/linux/hwmon.h
>> >> @@ -430,7 +430,7 @@ struct hwmon_channel_info {
>> >>   */
>> >>  struct hwmon_chip_info {
>> >>  	const struct hwmon_ops *ops;
>> >> -	const struct hwmon_channel_info **info;
>> >> +	const struct hwmon_channel_info * const *info;
>> >
>> > As pointed out by 0-day, you's also have to change each
>> > instance where this is is assigned to another variable.
>> 
>> Ah, sorry, I had THERMAL_OF=n.
>> 
>
> You also didn't test compile drivers/hwmon/hwmon.c.
> I had wondered about that, and 0-day now confirmed it.

I most certainly did. And as I looked into why I didn't see the failure
0-day hits I noticed THERMAL_OF=n like I said.

BR,
Jani.

>
> Guenter
>
>> BR,
>> Jani.
>> 
>> 
>> >
>> > Guenter
>> >
>> >>  };
>> >>  
>> >>  /* hwmon_device_register() is deprecated */
>> >> -- 
>> >> 2.39.1
>> >> 
>> 
>> -- 
>> Jani Nikula, Intel Open Source Graphics Center

-- 
Jani Nikula, Intel Open Source Graphics Center
