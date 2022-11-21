Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BE4631E21
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiKUKWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiKUKWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:22:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C0C8CFCC;
        Mon, 21 Nov 2022 02:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669026129; x=1700562129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CP/wPfSfloLH5MiYOy1CNLvk0kSlR8rUScjvf2mrt1U=;
  b=QfHKl/HPGGixxNaooW0SVkozkYEj6wckWMiuKVZ6Hnw/JIcV12dDCYom
   G3K4M5mwWMJV1XHFu5YUhofah/uw3ZvyDpwZtATaebV0AIT29sPTCUxIe
   vREQfakfqlx+f3hjV6Xo+EarYGh3pvVZa/cW+vSZbhKRS9ll4RhsPRR/H
   2gAFIwtU140PZUbYkrFQsfVNyuH80cmfHyletVbITjKNnQW4g9e91zhRq
   yBtI1gGVdnlwTyXYd71PjTIG+ff4DOb8DJg7Bpt2jVEGEuLwUb1mwUsBG
   Exifg1LUMDVgMq+RFyhku9G6shcCKGtswTP3aHc8kUuI7kVitBZEugc/S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="340382872"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="340382872"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 02:22:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="704510653"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="704510653"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 21 Nov 2022 02:22:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ox3wD-00FDQ5-1b;
        Mon, 21 Nov 2022 12:22:05 +0200
Date:   Mon, 21 Nov 2022 12:22:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        djrscally@gmail.com, heikki.krogerus@linux.intel.com,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Message-ID: <Y3tRTTI6nn2JAd+E@smile.fi.intel.com>
References: <20221121064049.1173345-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121064049.1173345-1-yangyingliang@huawei.com>
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

On Mon, Nov 21, 2022 at 02:40:49PM +0800, Yang Yingliang wrote:
> The 'parent' returned by fwnode_graph_get_port_parent() with refcount
> incremented when prev is not null, it needs be put when finish using
> it.

...

>  	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
> -	if (ep)
> +	if (ep) {
> +		if (prev)
> +			fwnode_handle_put((struct fwnode_handle *)parent);

Instead of castings, drop the const qualifier in the definition block.

>  		return ep;
> +	}

But, the point is that this is a very tricky code and your commit message
lacks of analysis. Can you extend it and show that every case is covered
correctly?

> -	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
> +	ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
> +	if (prev)

Instead you might consider to replace

	parent = fwnode;

by

	parent = fwnode_handle_get(fwnode);

but please double check that each branch has proper reference counting.

> +		fwnode_handle_put((struct fwnode_handle *)parent);
> +	return ep;

-- 
With Best Regards,
Andy Shevchenko


