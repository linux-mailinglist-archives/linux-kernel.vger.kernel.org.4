Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B207631E54
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiKUK1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKUK1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:27:34 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FCCD2DB;
        Mon, 21 Nov 2022 02:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669026453; x=1700562453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zUduJFx7fPH4TbiSjc6PXvIFdqg44hdPA7ahefyvelk=;
  b=KnJGkvNfxYYAHI1DuLM/YvYfwWOyd8Z68YvDCbFcq+ahO52WgMbL2H0K
   RY1e97P3mGZ4XWqBVKEFsfK6F70rdoGKXfZunokb6mUrdcxVQeRwflLHx
   6J8mBtFZE3MsR1sLDI9QZx+3LOSP1ytsOMew/IFJkhKf1gODfnsDkMBwT
   X55e1Z7Hp6NMP+PtlC8cGjXYw6bjAzfolhexhLTKrhw70GZxflZ0afOfM
   ZxmZDJBwGzpCRMLX6mGft/OdXp+COwS/QmlLfkymNMvuoTY1Xl9GGtRiB
   NfrMEc2jXP7rM6HQppkKf1sEieU55s8Ume51p6CsovDDTJ+osQn8sg8RZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="293915935"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="293915935"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 02:27:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="643269647"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="643269647"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2022 02:27:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ox41P-00FDXm-1q;
        Mon, 21 Nov 2022 12:27:27 +0200
Date:   Mon, 21 Nov 2022 12:27:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Dan Scally <dan.scally@ideasonboard.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
Subject: Re: [PATCH v1 2/4] media: ipu3-cio2: Convert to use
 software_node_register_node_group()
Message-ID: <Y3tSj20qwJZ23VAY@smile.fi.intel.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
 <20221118185617.33908-2-andriy.shevchenko@linux.intel.com>
 <2c69ae41-7920-1438-8bfc-8581aad0ee00@ideasonboard.com>
 <93eb74bf-58c4-1a77-af2f-3a0df4404acf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93eb74bf-58c4-1a77-af2f-3a0df4404acf@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:22:17AM +0100, Hans de Goede wrote:
> On 11/21/22 11:19, Dan Scally wrote:
> > On 18/11/2022 18:56, Andy Shevchenko wrote:
> >> The currently used software_node_register_nodes() is going to
> >> be removed. Prepare driver by switchich to new API.

> > Also looks good to me:
> > 
> > Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

Thank you!

> Any chance you can also give this series a test run on an IPU3 device to
> ensure that it does not cause regressions ?

Yes, it would be really appreciated!

-- 
With Best Regards,
Andy Shevchenko


