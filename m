Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D23645BD8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiLGOBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiLGOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:00:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C425CD25;
        Wed,  7 Dec 2022 06:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670421623; x=1701957623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KEhTL3vrjhKTd4wINrdASIf1vXJvXtSZmJuHUaW4uZo=;
  b=Mor1s7NP950cy/iGdx/951RKhBSbZQEv1O86ctNXIGo3TNQbfXOM7PXi
   3cJAe8BF2mju8vCxKBatbmMGqpFkjUW98E/WGnxC73x677BnGA8ja2KWR
   BYZ+D+HPTMY6ZhOSIcM6AOS2OnnYrWeLjNou4OCxnpY1qRLpVB3Pv4BAn
   uJwUVVAk4mYNppASvks1Q+WXqDqi65JG1A9lzqdWnezXbBqLS9i1XpB8x
   3Bf+O99T7ASVp50QXkmovx9xTE/vWlXfzCBS2baa24DZOtDQB5YT79Rt9
   4H5ra2QhSjIM+SkIlQrlMGX0JcR7j/UVdSdq/+z4W+YCvxv9sUOVHr5kV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="343925694"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="343925694"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 06:00:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="679141757"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="679141757"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 06:00:17 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 6F6922029D;
        Wed,  7 Dec 2022 16:00:15 +0200 (EET)
Date:   Wed, 7 Dec 2022 14:00:15 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 1/4] media: ipu3-cio2: Don't dereference fwnode handle
Message-ID: <Y5Ccbzl9pCuiZIKh@paasikivi.fi.intel.com>
References: <20221121152704.30180-1-andriy.shevchenko@linux.intel.com>
 <Y35wQuIbiCxyaOyp@smile.fi.intel.com>
 <Y5BWuXjipZcMXlan@paasikivi.fi.intel.com>
 <Y5BiiAwukaVrIvpF@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5BiiAwukaVrIvpF@smile.fi.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 11:53:12AM +0200, Andy Shevchenko wrote:
> On Wed, Dec 07, 2022 at 09:02:49AM +0000, Sakari Ailus wrote:
> > On Wed, Nov 23, 2022 at 09:10:58PM +0200, Andy Shevchenko wrote:
> > > Dunno what happened to my previous reply to this. Okay, trying again...
> > > 
> > > + Cc: Petr, Sergey
> > > 
> > > On Mon, Nov 21, 2022 at 05:27:01PM +0200, Andy Shevchenko wrote:
> > > > Use acpi_fwnode_handle() instead of dereferencing an fwnode handle directly,
> > > > which is a better coding practice.
> > > 
> > > It appears that this series depends on fd070e8ceb90 ("test_printf: Refactor
> > > fwnode_pointer() to make it more readable") which is in PRINTK tree.
> > > 
> > > Sakari, Mauro, if you are okay to route this via that tree, can we get your
> > > tags for that? Otherwise we need to postpone this till v6.2-rc1 (but I would
> > > like to decrease the chances to appear a new user of the to be removed API).
> > > 
> > > Note, that Greg Acked v1 of the swnode patches (which are the same in v2).
> > 
> > Sorry for the late reply. Feel free to do that if it's not too late, with:
> > 
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

I intended to add this applies to the set.

> 
> Thank you!
> I think it's a bit late for printk tree to consume this. If it's the case
> (Petr?) then I will submit a new version after v6.2-rc1 is out.
> 
> > I don't think the linkelihood for having a new user for this API is high.

-- 
Sakari Ailus
