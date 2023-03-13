Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535B16B8625
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCMXhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCMXhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:37:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF3B6A2F6;
        Mon, 13 Mar 2023 16:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678750638; x=1710286638;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zu+DHst9j7pl3e5sS9axS5eHMyPoWj1GoWfHZ60PNC4=;
  b=Q4wZV0bWgwVgPxc0jeSNezro7W5x2wsajyk+sUWYI9GKOAQXyRwAF2xm
   zFFySTibifufnP0bv2PBy9iMyvWTBXXwcCLKZQFWx8/5PYQ03IuD3TPG3
   s4GZTDWlEoIDpIjszpZBwvAIy0szAznERoqknWYYhdxCXmxDHzMysHSSH
   m3Mt8wBoP5nedG1Nx5xBsg5f0u3h9NHgEoSQw5mVgrOE6gZLnMdbWHCbc
   6do9BbyKiucAFx7o8uIKrUfnnEONA0lzZNSV/CNG/hYKbAHy/QypgzeSn
   qRF9TajD5andyXmtLZCOvaUumVZ/ERBi4UeO0ATwQx8bTM4kgsdFtVkOo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334762382"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="334762382"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 16:37:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="924695871"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="924695871"
Received: from wopr.jf.intel.com ([10.54.75.136])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 16:37:17 -0700
Message-ID: <c5f67e5c49aee0ce48545a79b7295c7af779347f.camel@linux.intel.com>
Subject: Re: [PATCH v2] Fix buffer overrun in HID-SENSOR name string
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     Andi Shyti <andi.shyti@kernel.org>,
        Todd Brandt <todd.e.brandt@intel.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, jikos@kernel.org, p.jungkamp@gmx.net
Date:   Mon, 13 Mar 2023 16:37:17 -0700
In-Reply-To: <20230313230712.6xboy3w5ocrvj3vn@intel.intel>
References: <20230313220653.3996-1-todd.e.brandt@intel.com>
         <20230313230712.6xboy3w5ocrvj3vn@intel.intel>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-14 at 00:07 +0100, Andi Shyti wrote:
> Hi Todd,
> 
> On Mon, Mar 13, 2023 at 03:06:53PM -0700, Todd Brandt wrote:
> > On some platforms there are some platform devices created with
> > invalid names. For example: "HID-SENSOR-INT-020b?.39.auto" instead
> > of "HID-SENSOR-INT-020b.39.auto"
> > 
> > This string include some invalid characters, hence it will fail to
> > properly load the driver which will handle this custom sensor. Also
> > it is a problem for some user space tools, which parse the device
> > names from ftrace and dmesg.
> > 
> > This is because the string, real_usage, is not NULL terminated and
> > printed with %s to form device name.
> > 
> > To address this, we initialize the real_usage string with 0s.
> > 
> > Philipp Jungkamp created this fix, I'm simply submitting it. I've
> > verified it fixes bugzilla issue 217169
> > 
> > Reported-and-tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217169
> > Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
> 
> Why is not Philip in the SoB list?
> 
Oh, sorry, I got feedback and assumed it needed more work on the
changelog. I also forgot to copy over Phillip's SoB line so this one is
probably worse than the original. The original was just fine, please
ignore this one.

> Anyway the original patch made it to stable, so:
> 
> Fixes: 98c062e82451 ("HID: hid-sensor-custom: Allow more custom iio
> sensors")
> Cc: stable@vger.kernel.org
> 
> and with those you can add:
> 
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> 
> Andi

