Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2485F633CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiKVMzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiKVMyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:54:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7788D61525;
        Tue, 22 Nov 2022 04:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669121680; x=1700657680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LXor6RHYDRJcstefbO+GkJ6HY6sh3L0UmFktIRyR5r8=;
  b=iC2ed3lOU2K48scJ1kigS0NBYxgwPY+l6gMSJEoM9IhNTQ9jiXkM3G2z
   BSYRhHKk8W+VBa5nW/u7JgX1LdiDXN5vYXvXfqSx3gbM2yH+eu1iugpAc
   3QQ3aybuXDbptwGUmoaFDeoYGxSGRbPy0H1vVh4ZOYcS/L0ROyzEfRQB9
   IDPg6WW+gduZVn9uzrI/3LYugojfhyhIo2evip/I5yba2B1l7o/aZDxcu
   ku/ywH92j23PKwdf5MHwwQkEezy+y68BxxE7EDYPcTYDbIq/dSgBJkBXP
   rPbuE3r2vt2hGmlUFLPtJHfS/gCPC4mc3wKCZ/9tMTVwM8dZdLzMrup5g
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="313836642"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="313836642"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 04:54:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="970461205"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="970461205"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 22 Nov 2022 04:54:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxSnM-00FprD-1f;
        Tue, 22 Nov 2022 14:54:36 +0200
Date:   Tue, 22 Nov 2022 14:54:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        djrscally@gmail.com, heikki.krogerus@linux.intel.com,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH v2] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Message-ID: <Y3zGjLsDmVv0ErVR@smile.fi.intel.com>
References: <20221122120039.760773-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122120039.760773-1-yangyingliang@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:00:39PM +0800, Yang Yingliang wrote:
> The 'parent' returned by fwnode_graph_get_port_parent()
> with refcount incremented when 'prev' is not null, it

NULL

> needs be put when finish using it.
> 
> Because the parent is const, introduce a new variable to
> store the returned fwnode, then put it before returning
> from fwnode_graph_get_next_endpoint().

...

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
> -	if (ep)
> +	if (ep) {
> +		fwnode_handle_put(port_parent);
>  		return ep;
> +	}
>  
> -	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
> +	ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
> +	fwnode_handle_put(port_parent);
> +	return ep;

It seems too complicated for the simple fix.

As I said, just drop const qualifier and add fwnode_handle_get() in the 'else'
branch. This will allow you to drop if (prev) at the end.

-- 
With Best Regards,
Andy Shevchenko


