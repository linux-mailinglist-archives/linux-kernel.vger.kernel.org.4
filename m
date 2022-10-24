Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983C9609EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiJXKMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiJXKLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:11:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401E9FD03
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666606305; x=1698142305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q3EbVoHrvdRaDt4kUmz08IawMO1qoICyiLDHhEURsEo=;
  b=VKey8xWCTfXuBRbRQIK+xoEk/fsS5vGA836Bcpz0B23x4+KJI/wWyJ53
   424ckwhHFee4VTdR/49MBTNASYj8udpcxJ5R56iwgk9rcoS2cxh46xMEd
   Hzq8hl94CW8vjMx4XoxJkgDD/3haLEdRIQal7NUFdNXTDzfoZ9hpQyWww
   RqnzPe25ZOSZ7fJcidw+zSZs+wnk1iHKPCHlF5fFjTmDH/4s0irWgOMV1
   WnuuaNAQCiQCQeGUvS33BIY6aMaqaQN/5pICPP7xzbFx9dQuXNQvtf+M0
   VrHV+oWVZAWKUyARKAWVHK76HngmSfqmLKp1KhNIByzsMuuyOfJuM5FrR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="306113660"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="306113660"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 03:11:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="756525391"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="756525391"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 03:11:37 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C465A2021B;
        Mon, 24 Oct 2022 13:11:34 +0300 (EEST)
Date:   Mon, 24 Oct 2022 10:11:34 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] linux/container_of.h: Warn about loss of constness
Message-ID: <Y1Zk1qrfzVOn/k87@paasikivi.fi.intel.com>
References: <20221024082610.74990-1-sakari.ailus@linux.intel.com>
 <Y1ZQSEMLkybFCadS@kroah.com>
 <1b02ad7256564b5ca8a43df60f8d7a45@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b02ad7256564b5ca8a43df60f8d7a45@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Mon, Oct 24, 2022 at 08:59:29AM +0000, David Laight wrote:
> From: Greg Kroah-Hartman
> > Sent: 24 October 2022 09:44
> ...
> > > + * WARNING: as container_of() casts the given struct to another, also the
> > 
> > No need for "also" here (sorry for the grammar nit.)
> > 
> > > + * possible const qualifier of @ptr is lost unless it is also specified in
> > > + * @type. This is not a problem if the containing object is not const. Use with
> > > + * care.
> > 
> > I do not think these last two sentences you added here are needed
> > either.
> 
> It is all TL;DR :-)
> 
> Even just:
> 
> NOTE: any const qualifier of @ptr is lost.
> 
> Is probably more than enough.

Fine for me, but I'd prefer to keep the WARNING, making this:

	WARNING: any const qualifier of @ptr is lost.

-- 
Sakari Ailus
