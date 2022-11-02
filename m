Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5FD616155
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKBLBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiKBLBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:01:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541029361;
        Wed,  2 Nov 2022 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667386897; x=1698922897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d5QvCOMsjMBr33OdD5oCaZxykkRV0ETIs7RVP9U9RZc=;
  b=UquZEJQ7H6BK2r+Bsm7LS5BcgU58r4roA2OV50tbrv9S88Sc2gqjL2Iz
   d3zNyRMFJQlg2TqHVi4GxqEy0mbYoTdsPnYj9c8L+FCUTJNpy+b3nHFDX
   rkpmg2HHNtDg4W9ByQkbzTLWbwHFBa4N/T4/mpmciQIk8rat08gcGDMOa
   jXbwh7+INY+JLEfY6OKYLYWKc/40zb8xAYZzxSz108RQymJAWBytQlDXx
   LEHaYjpzmFrO85zmIoJshh8hgnuLN1pi+AOYMoQAEXF6GTSmqUCAjDRl2
   GwvFiVsYGhEUIDfy0nSVz+6wFWiLB/+6K7JvaXK3KDIXmso7HLuI8jqzi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="336054732"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="336054732"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 04:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="634222033"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="634222033"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 02 Nov 2022 04:01:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqBUx-0068pG-1t;
        Wed, 02 Nov 2022 13:01:31 +0200
Date:   Wed, 2 Nov 2022 13:01:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 0/2] gpiolib: more cleanups to get rid of of_node
Message-ID: <Y2JOCyWZfWnWZWHv@smile.fi.intel.com>
References: <20221005152947.71696-1-andriy.shevchenko@linux.intel.com>
 <Y1LsjgEHXz621by6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1LsjgEHXz621by6@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 10:01:34PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 05, 2022 at 06:29:45PM +0300, Andy Shevchenko wrote:
> > One more user outside of GPIO library and pin control folders needs
> > to be updated to use fwnode instead of of_node. To make this easier
> > introduce a helper in property.h and convert the user.
> > 
> > Note, the helper will be useful not only for the current users,
> > but any future ones that want to replace of_device_is_compatible()
> > with analogous fwnode API.
> > 
> > Changelog v2:
> > - placed new helper correctly in the property.h
> 
> Any comments on the series?

I'm going to apply this to my branch with Sakari's tag since there is no answer
from PPC maintainers for a month.

-- 
With Best Regards,
Andy Shevchenko


