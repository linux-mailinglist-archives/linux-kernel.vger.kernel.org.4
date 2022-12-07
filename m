Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677E86455FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiLGJDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLGJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:03:09 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063BD25E9C;
        Wed,  7 Dec 2022 01:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670403787; x=1701939787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pr/OH7Q9TSvuKwwlnfT5ZBrKKBEWTJiWy1nLbYSZAf0=;
  b=mjLqczw/PKybsE7SI/Zb/SsFq9iOdkPijvFtoXO3eoBKcWB/SvRrJAEz
   80pT4px43c5NPomXdt9D7wn+D9W05Pva4duwCwOkoyNKiDxz72tHmn+85
   3PbedHYj1PFr67UiXvg2YyP/CofZ2AuLQly44xik7N5ag9oWOvn2HzC+k
   vAsgjTmd3ocrGf8yKcFS3xJNHQbKL1S15JiAXDrpgcDZ7GgOm5CxSXI5q
   YVOiGk8LFMlYHgUWBghNA8jwIuxXclPqE2m4OaVHxWX+lqyTaKPa0XEk9
   aO0Jdg8nfQWb7EFnA1cm4FtYuGvJK/7q7BNpXaaF4VgaMsRBikNudCsot
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="316857085"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="316857085"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 01:03:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="820891129"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="820891129"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 01:02:52 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 532FE2029D;
        Wed,  7 Dec 2022 11:02:49 +0200 (EET)
Date:   Wed, 7 Dec 2022 09:02:49 +0000
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
Message-ID: <Y5BWuXjipZcMXlan@paasikivi.fi.intel.com>
References: <20221121152704.30180-1-andriy.shevchenko@linux.intel.com>
 <Y35wQuIbiCxyaOyp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y35wQuIbiCxyaOyp@smile.fi.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Nov 23, 2022 at 09:10:58PM +0200, Andy Shevchenko wrote:
> Dunno what happened to my previous reply to this. Okay, trying again...
> 
> + Cc: Petr, Sergey
> 
> On Mon, Nov 21, 2022 at 05:27:01PM +0200, Andy Shevchenko wrote:
> > Use acpi_fwnode_handle() instead of dereferencing an fwnode handle directly,
> > which is a better coding practice.
> 
> It appears that this series depends on fd070e8ceb90 ("test_printf: Refactor
> fwnode_pointer() to make it more readable") which is in PRINTK tree.
> 
> Sakari, Mauro, if you are okay to route this via that tree, can we get your
> tags for that? Otherwise we need to postpone this till v6.2-rc1 (but I would
> like to decrease the chances to appear a new user of the to be removed API).
> 
> Note, that Greg Acked v1 of the swnode patches (which are the same in v2).

Sorry for the late reply. Feel free to do that if it's not too late, with:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

I don't think the linkelihood for having a new user for this API is high.

-- 
Kind regards,

Sakari Ailus
