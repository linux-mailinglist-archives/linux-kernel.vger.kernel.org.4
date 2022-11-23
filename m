Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6C763603E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbiKWNn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbiKWNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:43:41 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709AA8E09B;
        Wed, 23 Nov 2022 05:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669210327; x=1700746327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nANvhtrFdqCwCwxA6/+CX0ExEjOjpCpyBs81wpazx0E=;
  b=Kfgqx84DNrxl9TaZUtHhTfvqNiKtVT9oE40P2pkuAOMe9WcsT4iMtiwF
   0xlrA87sdp1r1NvBjoFFgCiB2AyBpjKGlhddvZcPnSpmRkfoCPvbITNcx
   2G+msKHpZzdJmpOSI3wv4v6YFEjLTC2lcTgGA8BVMfQsEtzrQak5PF61M
   GPtr4io3aOtr7DmEG8No8gHdH8ii72r3fo7kcumlA+tIbrDE8rDMgNqM3
   d6AgjcvDYUP6SC0qtx6ot8BqvponSwCaqXq4c5FXPApR3t8BEoXSi81yU
   /snvnIfDZqhyYtvbG+dx5JAovoRhO6gwdqFS8SZBQe4uWG1465aA4EOKa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="340944976"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="340944976"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 05:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="641797490"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="641797490"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2022 05:32:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxpr5-00GIjM-2x;
        Wed, 23 Nov 2022 15:31:59 +0200
Date:   Wed, 23 Nov 2022 15:31:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        djrscally@gmail.com, heikki.krogerus@linux.intel.com,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH v3] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Message-ID: <Y34gz4UXN7il3b49@smile.fi.intel.com>
References: <20221123022542.2999510-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123022542.2999510-1-yangyingliang@huawei.com>
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

On Wed, Nov 23, 2022 at 10:25:42AM +0800, Yang Yingliang wrote:
> The 'parent' returned by fwnode_graph_get_port_parent()
> with refcount incremented when 'prev' is not NULL, it
> needs be put when finish using it.
> 
> Because the parent is const, introduce a new variable to
> store the returned fwnode, then put it before returning
> from fwnode_graph_get_next_endpoint().

To me this looks good enough. Not sure if Dan has a chance (time) to look at
this, though. And maybe even test...

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: b5b41ab6b0c1 ("device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2 -> v3:
>   Add a out label.
> 
> v1 -> v2:
>   Introduce a new variable to store the returned fwnode.
> ---
>  drivers/base/property.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 2a5a37fcd998..7f338cb4fb7b 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -989,26 +989,32 @@ struct fwnode_handle *
>  fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
>  			       struct fwnode_handle *prev)
>  {
> +	struct fwnode_handle *ep, *port_parent = NULL;
>  	const struct fwnode_handle *parent;
> -	struct fwnode_handle *ep;
>  
>  	/*
>  	 * If this function is in a loop and the previous iteration returned
>  	 * an endpoint from fwnode->secondary, then we need to use the secondary
>  	 * as parent rather than @fwnode.
>  	 */
> -	if (prev)
> -		parent = fwnode_graph_get_port_parent(prev);
> -	else
> +	if (prev) {
> +		port_parent = fwnode_graph_get_port_parent(prev);
> +		parent = port_parent;
> +	} else {
>  		parent = fwnode;
> +	}
>  	if (IS_ERR_OR_NULL(parent))
>  		return NULL;
>  
>  	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
>  	if (ep)
> -		return ep;
> +		goto out_put_port_parent;
> +
> +	ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
>  
> -	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
> +out_put_port_parent:
> +	fwnode_handle_put(port_parent);
> +	return ep;
>  }
>  EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
>  
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


