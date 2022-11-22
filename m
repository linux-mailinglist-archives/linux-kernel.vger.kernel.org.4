Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81D5633CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiKVM5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiKVM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:57:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F29261525;
        Tue, 22 Nov 2022 04:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669121820; x=1700657820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bw+r1DSCYkFhbBWOtjbrNGoQItpY9lgjbz2Tr2cJfGA=;
  b=mZ7tAyZ9XwoT2MonfDoTgCT1orl4+wFPt9gBWnjdZh04IpsubwThwdRe
   fieTU9Em6+h6wieBuC22p/jiIrmL3mTUlyIcyEmYr//wedVVaXXf8fV4g
   gZFuOdz7tfXgz7CytGsFQa/FQTC2wPz6SJW0WHB3WR+ruFZn4tpxZqRGj
   SMssir1plSsAwTCGTomd/hW+ca5IPaTdlQEyT1kEDOpmsyy1QLNZDEVL9
   zrGeQx9WmntrT9/wHWo0yN3pQX2J/jdD7LzxsgXz+pzK9QCS3VJh/0Ao0
   sCPAFr3d/ATq4/Q80VWIX1/7lHfFlu72JQ3L0yBju0CtX/q8I6AI+99Wb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="314956218"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="314956218"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 04:56:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672474226"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="672474226"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 04:56:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxSpb-00Fpss-2q;
        Tue, 22 Nov 2022 14:56:55 +0200
Date:   Tue, 22 Nov 2022 14:56:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        djrscally@gmail.com, heikki.krogerus@linux.intel.com,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH v2] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Message-ID: <Y3zHF8rdguSaavo1@smile.fi.intel.com>
References: <20221122120039.760773-1-yangyingliang@huawei.com>
 <Y3zGjLsDmVv0ErVR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3zGjLsDmVv0ErVR@smile.fi.intel.com>
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

On Tue, Nov 22, 2022 at 02:54:36PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 22, 2022 at 08:00:39PM +0800, Yang Yingliang wrote:

One more thing below.

...

> >  fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
> >  			       struct fwnode_handle *prev)
> >  {
> > +	struct fwnode_handle *ep, *port_parent = NULL;
> >  	const struct fwnode_handle *parent;
> > -	struct fwnode_handle *ep;
> >  
> >  	/*
> >  	 * If this function is in a loop and the previous iteration returned
> >  	 * an endpoint from fwnode->secondary, then we need to use the secondary
> >  	 * as parent rather than @fwnode.
> >  	 */
> > -	if (prev)
> > -		parent = fwnode_graph_get_port_parent(prev);
> > -	else
> > +	if (prev) {
> > +		port_parent = fwnode_graph_get_port_parent(prev);
> > +		parent = port_parent;
> > +	} else {
> >  		parent = fwnode;
> > +	}
> >  	if (IS_ERR_OR_NULL(parent))
> >  		return NULL;
> >  
> >  	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
> > -	if (ep)

> > +	if (ep) {
> > +		fwnode_handle_put(port_parent);
> >  		return ep;
> > +	}

	if (ep)
		goto out;

> > -	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
> > +	ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);

out:

> > +	fwnode_handle_put(port_parent);
> > +	return ep;
> 
> It seems too complicated for the simple fix.
> 
> As I said, just drop const qualifier and add fwnode_handle_get() in the 'else'
> branch. This will allow you to drop if (prev) at the end.

-- 
With Best Regards,
Andy Shevchenko


