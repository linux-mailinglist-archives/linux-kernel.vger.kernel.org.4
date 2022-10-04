Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55DA5F3F89
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJDJ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJDJ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FE01A819;
        Tue,  4 Oct 2022 02:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664875526; x=1696411526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v8zXOAKfLGDO5B2+X5l8nfSTc8z+YjVlJ+kS4JfN4A0=;
  b=JAkLeorWiBzOoFQGMxoQ00NW/jOEMgfGzhDIvXMYVrcRDmtvjUnx6Hw2
   87mFdFgOnopB+VDlRcpn38cz5yOQOtoXIgGPc2AIzsy8j0elXKHf9plgu
   cG1Lj3/MiIwN7RdCz7RsM/ONrtdb+95UcEDJ6twXh372MuxDwAS8VLRYA
   5epQS2JTJPKJx/Jlrq/aKBo2uOSTHkj7sDOZeVDjQdr0LQbds8//ytwTr
   4ktsrVEk7zPqxbr3F9MuVeMCpdZv74LaI89ele44cd1Mg3kHNt2ReGXpE
   4fgbi5VTdLpUPrtkTyjs2rteafDSUj7QbxgaeaVJpvS4Y6BVCw07UUjo/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="286056509"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="286056509"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:25:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="712944863"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="712944863"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:25:22 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 2FAEE20274;
        Tue,  4 Oct 2022 12:15:06 +0300 (EEST)
Date:   Tue, 4 Oct 2022 09:15:06 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
Message-ID: <Yzv5muXp8KA4dm+d@paasikivi.fi.intel.com>
References: <20220928105746.51208-2-andriy.shevchenko@linux.intel.com>
 <YzQqcFZtJn90URrJ@kroah.com>
 <Yzb9nXSxvgJ+Mj6z@paasikivi.fi.intel.com>
 <YzcAh/xtqQM1Qin4@kroah.com>
 <YzrBO2m/b1MHuKny@paasikivi.fi.intel.com>
 <Yzr6r5XtmPXCoQx7@kroah.com>
 <YzsLDUhjDCCVRy2G@kroah.com>
 <YztBWlmdgylsntgM@paasikivi.fi.intel.com>
 <Yzvm6XF0Ar35XZvT@kroah.com>
 <YzvrVoJ3BBhZmaZT@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzvrVoJ3BBhZmaZT@smile.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy, Greg,

On Tue, Oct 04, 2022 at 11:14:14AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 04, 2022 at 09:55:21AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Oct 03, 2022 at 08:08:58PM +0000, Sakari Ailus wrote:
> > > On Mon, Oct 03, 2022 at 06:17:17PM +0200, Greg Kroah-Hartman wrote:
> 
> ...
> 
> > > #define kobj_to_dev(kobj)						\
> > > 	(_Generic((kobj),						\
> > > 		  const struct kobject *: __kobj_to_dev_const,		\
> > > 		  struct kobject *: __kobj_to_dev)(kobj))
> > 
> > Ah, doh!  I had the (kobj) part in the wrong place, thanks for that
> > fix...
> > 
> > Ok, this looks better, let me see how well the build breaks with some of
> > these changes
> 
> I believe I can rewrite my patch like this and then it will be much nicer since
> we may constify all the rest without calling __dev_fwnode_const() directly.
> 
> Are you agree?

Sounds good to me, thanks!

-- 
Sakari Ailus
