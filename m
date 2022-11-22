Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A555633E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiKVOJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiKVOJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:09:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5E17A9F;
        Tue, 22 Nov 2022 06:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669126072; x=1700662072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IHxOYkLfkkrc/bieTDxjR1LwY2YqYpBSUyTZJebUioA=;
  b=e8CNtRp6BK33OSW+orrY3o3KRW3cwtsq6MFQtWr8zRvq9LiKdWk6od4k
   uQRdedepGL1LPLOiDcQdBcwxrNvx7mK2EDe8FzunFUqcBX0gjcpYlHWnh
   eQpDVVU0/HRg/k4Lrhdhr0WlZZGlYuPoCRgrwUy/+lDo+P57kWUEz6PxY
   /YVgTr2nrFEBtyjPrtV2tt9ilEKWey/IT0yMxt5jQsO3tj3x067UsgjRM
   Ih5saFeRAg3h28KhA9Vn0XpzCyns9xFqcT3GPROPVskq8GZwcY2G7klPX
   hcuuM+n1v4w//GKSHVsCgRFiwMcuJxDDoHu7BiLZp5y42cRbgKiS0w8WD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="313851205"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="313851205"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 06:07:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="619223198"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="619223198"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 22 Nov 2022 06:07:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxTva-00FrCW-31;
        Tue, 22 Nov 2022 16:07:10 +0200
Date:   Tue, 22 Nov 2022 16:07:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        djrscally@gmail.com, heikki.krogerus@linux.intel.com,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH v2] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Message-ID: <Y3zXjpY2/Le/3J9q@smile.fi.intel.com>
References: <20221122120039.760773-1-yangyingliang@huawei.com>
 <Y3zGjLsDmVv0ErVR@smile.fi.intel.com>
 <75602dce-0780-e51a-c8c9-d1820ddf3e2b@huawei.com>
 <Y3zLwj/G/E3kZsJE@smile.fi.intel.com>
 <26c0d10a-5dd8-6cea-57b3-eea63099baa1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26c0d10a-5dd8-6cea-57b3-eea63099baa1@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 09:41:28PM +0800, Yang Yingliang wrote:
> On 2022/11/22 21:16, Andy Shevchenko wrote:
> > On Tue, Nov 22, 2022 at 09:12:41PM +0800, Yang Yingliang wrote:
> > > On 2022/11/22 20:54, Andy Shevchenko wrote:
> > > > On Tue, Nov 22, 2022 at 08:00:39PM +0800, Yang Yingliang wrote:

...

> > > > It seems too complicated for the simple fix.
> > > > 
> > > > As I said, just drop const qualifier and add fwnode_handle_get() in the 'else'
> > > > branch. This will allow you to drop if (prev) at the end.
> > > fwnode is const, fwnode_handle_get doesn't accept this type.
> > I'm talking about parent.
> You suggested this:
> 
> "Instead you might consider to replace
> 
> 	parent = fwnode;
> 
> by
> 
> 	parent = fwnode_handle_get(fwnode);"
> 
> 
> It has compile warning:
> drivers/base/property.c: In function ‘fwnode_graph_get_next_endpoint’:
> drivers/base/property.c:1004:30: warning: passing argument 1 of ‘fwnode_handle_get’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>    parent = fwnode_handle_get(fwnode);
>                               ^~~~~~
> drivers/base/property.c:809:63: note: expected ‘struct fwnode_handle *’ but argument is of type ‘const struct fwnode_handle *’
>  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
> 
> ~~~~~~~~~~~~~~~~~~~~~~^~~~~~

I see what you mean. Thank you for clarification.

So, it seems a bit twisted.

If prev == NULL, can the

        ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, NULL);

return NULL?

If no, we may move this case directly to the 'else' branch and return from there.

-- 
With Best Regards,
Andy Shevchenko


