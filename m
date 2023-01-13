Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EBC6698CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbjAMNjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241828AbjAMNil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:38:41 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB3B10C1;
        Fri, 13 Jan 2023 05:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673616810; x=1705152810;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SIimS6dlFX7jkCJ504BScuOul7TISPli5vt+Yekfd2g=;
  b=JWqMAXaI3NY0NUrLwAfgHteNbeUosSi9422ea7XNGO4HvafBN6G8IUci
   Tz6SonHdvmmseG03Df+B1a1WhRVd+UnYs92xoGf5LWwl9bkc0E1eSlZjZ
   2GN2u06a+fWZD1aobmavS2IK0OxZYunczGFlq/k+pa4DfZ5IUAurveZrO
   mWQbglwK1ZQ1n/PinYgWdUUKZcbZZRuNFfmN00+rgrqQholH08WjiDaKo
   yA+8l2oj1yg2W7krbwHY2M1CjWjxAqfi9SplyZ+mLA9PslisIFrRspMYD
   a8toEbJPgomuMgcKIkd8nb2JnUE6gPuWgkPd3ME+soWR1XwxuzBzDIKrW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="351224602"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="351224602"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 05:33:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="903572429"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="903572429"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jan 2023 05:33:23 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Won Chung <wonchung@google.com>, linux-block@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        linux-usb@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v2 06/16] driver core: make struct device_type.devnode()
 take a const *
In-Reply-To: <20230111113018.459199-7-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
 <20230111113018.459199-7-gregkh@linuxfoundation.org>
Date:   Fri, 13 Jan 2023 15:33:16 +0200
Message-ID: <877cxqsgo3.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> The devnode() callback in struct device_type should not be modifying the
> device that is passed into it, so mark it as a const * and propagate the
> function signature changes out into all relevant subsystems that use
> this callback.

For the intel-th bit:
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Thanks,
--
Alex
