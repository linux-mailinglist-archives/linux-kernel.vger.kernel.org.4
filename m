Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2690F6369A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiKWTLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbiKWTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:11:06 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C4AF3E;
        Wed, 23 Nov 2022 11:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669230666; x=1700766666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UpgDZcJBD2TG3aGeiM4wHYb6Senoz7cbHl4LBwq7iIw=;
  b=S8CDd1+5WF/L4dV4u2k33KrUad2KOmCAL8Eg99Y9ZbiQpGVa6zeZnd7V
   7sSNDisHOvsbvJ+ZH/Iw8Ngmt05Gt1npIfvz0OivpL4Zo0yFyc6ibIbHt
   9BbovJl37F9EuwtqlDScjT97H8bhA1Cq4gDfMuN4E1XzjAaWNNSrp32sP
   +0cteBJfq0KexPMoT2a5KgwS7QmporkuveXvAazYg5zgBXixNx1XFZbt7
   TeevwJ6hXgGkDXeWI+sHx8K8VovTIaSMgHJjZY6x2ypZsZrEQnyIYnMfn
   VYMJthRehzes2ijPdbK08COLVq+nSX/Lvfk5qnJbrDhUse5NR1f7BGyOs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="376286104"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="376286104"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 11:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="887064707"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="887064707"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 23 Nov 2022 11:11:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxv99-00GPwu-08;
        Wed, 23 Nov 2022 21:10:59 +0200
Date:   Wed, 23 Nov 2022 21:10:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 1/4] media: ipu3-cio2: Don't dereference fwnode handle
Message-ID: <Y35wQuIbiCxyaOyp@smile.fi.intel.com>
References: <20221121152704.30180-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121152704.30180-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dunno what happened to my previous reply to this. Okay, trying again...

+ Cc: Petr, Sergey

On Mon, Nov 21, 2022 at 05:27:01PM +0200, Andy Shevchenko wrote:
> Use acpi_fwnode_handle() instead of dereferencing an fwnode handle directly,
> which is a better coding practice.

It appears that this series depends on fd070e8ceb90 ("test_printf: Refactor
fwnode_pointer() to make it more readable") which is in PRINTK tree.

Sakari, Mauro, if you are okay to route this via that tree, can we get your
tags for that? Otherwise we need to postpone this till v6.2-rc1 (but I would
like to decrease the chances to appear a new user of the to be removed API).

Note, that Greg Acked v1 of the swnode patches (which are the same in v2).

-- 
With Best Regards,
Andy Shevchenko


