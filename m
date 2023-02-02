Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7796882BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjBBPgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjBBPfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:35:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06695485AC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675352104; x=1706888104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hU+Gt/5Yu9M/7rlNN+qDySQonUycDkbqLPa/l+PoyVE=;
  b=XLKF5jGkzYmwjfKC63NEtle1L0RH6qkHH1ioLJNTxds/YvPjKwcxfy8i
   plObl+dV9kwDZk6dFGKWc6ryy6cnXKAQ/aDxka2IuM2P7uzXW2oLzejzG
   yCgtMlb4an/v50B28RgUsaXyoI2161Z4RNsg2qsX7UgcFQsq1JQklyWAs
   Ryl0xE8ecWimVi57oxwKIajjVjr1D/bt5cDNJ5iyg368bC6VF4HDYhla5
   OvuQhH5hGIPRQcbymbdpY5+B8fydqYCcIljo0L6J/+Zyoe/N3sSHUJm5i
   +wL6/74fzMOj+pEJcfIhgxCfzuuT2C+Q8XvkKZEDhJl83/3SYdNAPnm+L
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="393056460"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="393056460"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 07:31:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="667317636"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="667317636"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 02 Feb 2023 07:31:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pNbYV-001EcV-0b;
        Thu, 02 Feb 2023 17:31:19 +0200
Date:   Thu, 2 Feb 2023 17:31:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] mei: Move uuid_le_cmp() to its only user
Message-ID: <Y9vXRk3ctpl0+p37@smile.fi.intel.com>
References: <20230202145412.87569-1-andriy.shevchenko@linux.intel.com>
 <20230202151759.GA28861@lst.de>
 <Y9vVENZEjg1e43LT@smile.fi.intel.com>
 <20230202152234.GA28999@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202152234.GA28999@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:22:34PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 02, 2023 at 05:21:52PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 02, 2023 at 04:17:59PM +0100, Christoph Hellwig wrote:
> > > On Thu, Feb 02, 2023 at 04:54:12PM +0200, Andy Shevchenko wrote:
> > > > There is only a single user of uuid_le_cmp() API, let's make it private
> > > > to that user.
> > > 
> > > Any reason this code can't just use guid_t and guid_equal?
> > 
> > It's part of ABI, while guid_* are for the internal use.
> > 
> > Eventually they may switch to the internal types, but it's up to MEI.
> 
> How can a type name be part of a binary interface?

If I'm not mistaken there is a difference between simple __u8[16] and
struct { __u8[16] } due to alignment. But data wise it's the same, of
course. That said, it depends on how this type is being used in the
any of ABI.

From the API perspective the guid_* are not visible to uAPI.

-- 
With Best Regards,
Andy Shevchenko


