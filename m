Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB5873A3C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjFVO4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFVO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:56:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCC3E57
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687445778; x=1718981778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SYkzbXvmS5hB7ALkD5UFMNT0dFYHO6Uf2dKrxzoX73k=;
  b=k1wV5dUa8RTKy2MV+ZGIuzSch5Z/HMchdR09QpIfj3UhYODUyLq4GQDM
   aesJ0iPzWbWRtbNuJstPZtZuQHZx/WhIiCGe+xqlguHvPDnEcQNnmgdzc
   FfUrDGm1XaoWwrV77mGKu8mu63bBR4dpPrrXEG+VZqUaWO2GhED42ukqB
   OvZpK9S1y+WsXJ8m+r9ksJ+th4d0pBmZH2S4y7pBQKxa7I5TxPA25ZKZp
   TGDCVet4eJYsqWbYbIaCVBsIETO0QRao3/kb7KUXEqu0ZReZPBqezL4GD
   /9Yfoiv6nYyKJqXzOg9UL/pBjQU4tsqNVtu7sJwURuyxJxPrZ4XjoO+L8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="363950048"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="363950048"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 07:56:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="714934767"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="714934767"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2023 07:56:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qCLjM-005n7y-00;
        Thu, 22 Jun 2023 17:56:16 +0300
Date:   Thu, 22 Jun 2023 17:56:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: ipaq-micro: Use %*ph for printing hexdump of
 a small buffer
Message-ID: <ZJRhD8QoqMtg8reI@smile.fi.intel.com>
References: <20230612212007.3621-1-andriy.shevchenko@linux.intel.com>
 <20230621171040.GK10378@google.com>
 <ZJQ/L7+hpCLi7grQ@smile.fi.intel.com>
 <20230622140058.GW10378@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622140058.GW10378@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 03:00:58PM +0100, Lee Jones wrote:
> On Thu, 22 Jun 2023, Andy Shevchenko wrote:
> > On Wed, Jun 21, 2023 at 06:10:40PM +0100, Lee Jones wrote:
> > > On Tue, 13 Jun 2023, Andy Shevchenko wrote:
> > > > The kernel already has a helper to print a hexdump of a small
> > > > buffer via pointer extension. Use that instead of open coded
> > > > variant.
> > > 
> > > That's not all you're doing is it?
> > > 
> > > Nice try.  2 patches please.
> > 
> > I'm not sure it's possible to split to two clean patches that don't overlap
> > each other like by 70%. Can you elaborate a bit more on your vision on this?
> 
> What does the 'break' have to do with changing print format?

Ah, indeed! Thank you for spotting this. Yes, 2 patches.

-- 
With Best Regards,
Andy Shevchenko


