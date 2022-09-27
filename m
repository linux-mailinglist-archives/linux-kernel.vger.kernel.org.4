Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23865ECF04
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiI0U4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiI0U4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:56:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536741B34A0;
        Tue, 27 Sep 2022 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664312194; x=1695848194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p6QjeJOm29/PJ5sSFT/tJnSgJbIezHA9AkofLr8V7Fs=;
  b=PV9H88srQVWx5Vc6OjpqnKBQjjXu+7FydE5GjRdKn6UxzmDQvsPQM+ao
   //lqOh3EyFq50Zl4l8IviC+rvPg2Dvhn1KNlO6vbgz8qOBCXa441m4tZ1
   HGxbuYppE/SnJOTUGmAiddJ2cckPkSynPztVEGp3vXZaNldEjDbar+KzR
   2bSyUllp/Pppn38yW4ILpdZceLt+7OHWeLhdyyPCXyTV2ZkELNgHeRdp1
   lSZdWCwJmAya6o8KovWuUrRpO3YmUEwUwDM8HzSQs8ymbCl0R99VbdPAu
   5f99m0Y1a5AMhAsKQpTlTLFZa+ZHUwRfAYpVqFDyQjeKs6zEHY0z2K2Ul
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301407745"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="301407745"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 13:56:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="747183199"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="747183199"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 13:56:31 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 93C1620165;
        Tue, 27 Sep 2022 23:56:28 +0300 (EEST)
Date:   Tue, 27 Sep 2022 20:56:28 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
Message-ID: <YzNjfAvqSRu5VTiy@paasikivi.fi.intel.com>
References: <20220927142822.4095-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927142822.4095-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for the set.

On Tue, Sep 27, 2022 at 05:28:17PM +0300, Andy Shevchenko wrote:
> It's not fully correct to take a const parameter pointer to a struct
> and return a non-const pointer to a member of that struct.

I guess you could go as far as saying it's not at all correct. :-)

> 
> Instead, introduce a const version of the dev_fwnode() API which takes
> and returns const pointers and use it where it's applicable.
> 
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Fixes: aade55c86033 ("device property: Add const qualifier to device_get_match_data() parameter")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For the set:

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus
