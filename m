Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40251633D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiKVNRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbiKVNQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:16:56 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21BCE49;
        Tue, 22 Nov 2022 05:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669123016; x=1700659016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jt1CUqgeOpQd7tpbxtZzW4+aRWARSRwhtrbZwOcfz0g=;
  b=KggZqIB1aPpeh8Ce21B0xjnMyKJHZHSjZTT07QpawjrSkj2wHH5KIfPO
   EOTbJxJFE1jh92PRfw9vgfnOutgvtxm2Px9RN0AtKFA7o2n2EoZZLmErZ
   PjM9vbbGG73qv7ahIXTYHiOmT1gl5WL7QC2FyOCTNwK0tfN2YI0sW5TI9
   MTz5uF4G24+cNspAwHfEIcwzB+KkeNIjkXXO4WPp1KT5AWQYHWZDwp2Ql
   c7qhXqED/8YtPI1bgy6JLyHJUkr1GgR6SRwizYND9qyc7pfsmH1OhPGSK
   jZggTYa1EnVJ4Dh5+vONTKr4XTEP0Y1TUgDbX+2/vZRa7npi7lFE46G1Z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="375954199"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="375954199"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 05:16:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="730389472"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="730389472"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2022 05:16:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxT8t-00FqKL-0H;
        Tue, 22 Nov 2022 15:16:51 +0200
Date:   Tue, 22 Nov 2022 15:16:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        djrscally@gmail.com, heikki.krogerus@linux.intel.com,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH v2] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Message-ID: <Y3zLwj/G/E3kZsJE@smile.fi.intel.com>
References: <20221122120039.760773-1-yangyingliang@huawei.com>
 <Y3zGjLsDmVv0ErVR@smile.fi.intel.com>
 <75602dce-0780-e51a-c8c9-d1820ddf3e2b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75602dce-0780-e51a-c8c9-d1820ddf3e2b@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 09:12:41PM +0800, Yang Yingliang wrote:
> On 2022/11/22 20:54, Andy Shevchenko wrote:
> > On Tue, Nov 22, 2022 at 08:00:39PM +0800, Yang Yingliang wrote:

...

> > It seems too complicated for the simple fix.
> > 
> > As I said, just drop const qualifier and add fwnode_handle_get() in the 'else'
> > branch. This will allow you to drop if (prev) at the end.
> 
> fwnode is const, fwnode_handle_get doesn't accept this type.

I'm talking about parent.

-- 
With Best Regards,
Andy Shevchenko


