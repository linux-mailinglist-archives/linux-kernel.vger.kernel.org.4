Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D186B7CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCMP5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjCMP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:57:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D03C60AA3;
        Mon, 13 Mar 2023 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678723025; x=1710259025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bhZXbithujdLtqxNAm3SueY2A8MqOJML2S4jsjIKIBs=;
  b=VSzYb6BHZKSJXz/GglIP0sT1DBzQqUrcHy+FjGRoHBU6sz+0jXJBedA9
   ZZeCRMmxvvboZAPzHhQbclSCz7PMAaGmWMGGbpcFTyoQY7Vy47nQY9boZ
   J24QwVvJF3EKo2Lcr+2kKMKU1nBo23malyjnYlGS1r6nBX6dOoEHxcaEy
   /XodtlC+k4Ml4p3i9ThICBoEZTckm3ogA+lsSHvq6SV1fUzM7OGnMAmUb
   sHAI4qEfjb4Yk0oKZA2ZQ2kBE0ZT0NmTSQtbIi2KSpZ8THsEhGZFJSAgb
   nK8ozBlCmo8Y5s1BhHsU8euCcNbQJmIcCI8QgueDo1hcE+NBX6M0FQSyT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="338732978"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="338732978"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 08:57:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="671947978"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="671947978"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2023 08:57:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pbkXk-002iMJ-1n;
        Mon, 13 Mar 2023 17:57:00 +0200
Date:   Mon, 13 Mar 2023 17:57:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 1/1] media: i2c: imx290: Make use of
 get_unaligned_le24(), put_unaligned_le24()
Message-ID: <ZA9HzLXYvi+mDgsw@smile.fi.intel.com>
References: <20230209221205.46573-1-andriy.shevchenko@linux.intel.com>
 <Y+V1Hds/yCjABDnL@pendragon.ideasonboard.com>
 <Y+Z5mAhQk6zEFHOz@smile.fi.intel.com>
 <ZAtnKLKEZXCw/Ezy@smile.fi.intel.com>
 <ZA8J5/vElpjrRD4N@valkosipuli.retiisi.eu>
 <ZA8Qk8CmBNvsDUMv@smile.fi.intel.com>
 <ZA8jKpSR+p8e6Uel@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA8jKpSR+p8e6Uel@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 03:20:42PM +0200, Sakari Ailus wrote:
> On Mon, Mar 13, 2023 at 02:01:23PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 13, 2023 at 01:32:55PM +0200, Sakari Ailus wrote:
> > > On Fri, Mar 10, 2023 at 07:21:44PM +0200, Andy Shevchenko wrote:

...

> > > Yes. These are in my tree now.
> > 
> > Which is...?
> > 
> > I don't see anything on https://git.linuxtv.org/sailus/media_tree.git/.
> 
> This is a bit opportunistic since we don't have rc1 in the media tree yet.
> 
> I'll push it once we do.

Ah, thank you!

-- 
With Best Regards,
Andy Shevchenko


