Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA9D63698D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiKWTHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbiKWTHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:07:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA679B3BB;
        Wed, 23 Nov 2022 11:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669230431; x=1700766431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P3l14ldbjd9fRCNARR/e27TOv38gfA22m+r0osc22xg=;
  b=Usl3+QlgpEJLHBQQ7xP6nUrjz+I8F0eFUs+CwJo4ZuKabzcmsbOcmKhV
   RNnR/hJ6wpkCCKFLxZvFEQKTwx5QwKDEGlH2k6WphgccIjug1PXzzqWqy
   YbY3xLhFQq+dpERSlv3uGBbYD06dXCsTCKgRPO6ZmZ+CqsZ+5oStSJsCL
   ZisrD8UZfVyMY7yiBSzA3qElORsrg6Vg7aaU34mdogKaIyKoetYx3Tur4
   9fVx52/RlH2L4oEg4b6SPw0Y/a6A+jplnGFkaR6AcXGh5a8AW/MxQwiJh
   67pcG539vlKFKjfbIcvTrvKVGh6HQ5r696hBoS4hvlq7S3f1WR1oQecTR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="341028546"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="341028546"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 11:07:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="730885267"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="730885267"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2022 11:07:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxv5N-00GPrn-2P;
        Wed, 23 Nov 2022 21:07:05 +0200
Date:   Wed, 23 Nov 2022 21:07:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>
Subject: Re: [PATCH v1 3/4] software node: Switch property entry test to new
 API
Message-ID: <Y35vWSXmmKp987KD@smile.fi.intel.com>
References: <20221118185617.33908-1-andriy.shevchenko@linux.intel.com>
 <20221118185617.33908-3-andriy.shevchenko@linux.intel.com>
 <Y35uJNWfEdpPSo69@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y35uJNWfEdpPSo69@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 08:01:56PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Nov 18, 2022 at 08:56:16PM +0200, Andy Shevchenko wrote:
> > Switch property entry test to use software_node_register_node_group() API.
> > The current one is going to be removed soon.

> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thank you! I hope this stays for v2 (which had been on mailing lists for
a few days).

-- 
With Best Regards,
Andy Shevchenko


