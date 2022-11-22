Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C8633ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiKVOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbiKVOW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:22:57 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9E0233B9;
        Tue, 22 Nov 2022 06:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669126968; x=1700662968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=anvBuD5NPMnjzRUn27ft+ooMlMPJfViRRrtuuCSkQA4=;
  b=KwmdUpRT7tgi8lPjW2z8MgjwebYSpZqQcdcwRBfpaC5e7hnUTL1hMSmt
   WhkJZFjpfHtRUFp29QCi1cVRoBIWBqQLyg2LkZqhmN7BtjlIxmc5edFXZ
   6tjShq0rB1x/BfsII7j+38pBM8Xj1tPwQrvb6jXSTPb8gGjm2+YYCRe0j
   FaduKF9YT5dusCl76TjwKfYjSyuzLU3aP4xog4gT4n6rJS0zTCcSe5i13
   Ak45+C0fSJuiGKMuLyNpY+cDfYtednbZFJuJuzA/EEx2O5URrxLt1P1Rb
   v8oH5xcdjAHQbjNULZGC1RCnuQsrD49dNRf8XffDiUs4WelVpMniubuUd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="375967859"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="375967859"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 06:22:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="970487277"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="970487277"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 22 Nov 2022 06:22:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxUAW-00FrVb-17;
        Tue, 22 Nov 2022 16:22:36 +0200
Date:   Tue, 22 Nov 2022 16:22:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        djrscally@gmail.com, heikki.krogerus@linux.intel.com,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH v2] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
Message-ID: <Y3zbK4ngD8xZBqsf@smile.fi.intel.com>
References: <20221122120039.760773-1-yangyingliang@huawei.com>
 <Y3zGjLsDmVv0ErVR@smile.fi.intel.com>
 <75602dce-0780-e51a-c8c9-d1820ddf3e2b@huawei.com>
 <Y3zLwj/G/E3kZsJE@smile.fi.intel.com>
 <26c0d10a-5dd8-6cea-57b3-eea63099baa1@huawei.com>
 <Y3zXjpY2/Le/3J9q@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3zXjpY2/Le/3J9q@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 04:07:10PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 22, 2022 at 09:41:28PM +0800, Yang Yingliang wrote:
> > On 2022/11/22 21:16, Andy Shevchenko wrote:
> > > On Tue, Nov 22, 2022 at 09:12:41PM +0800, Yang Yingliang wrote:
> > > > On 2022/11/22 20:54, Andy Shevchenko wrote:
> > > > > On Tue, Nov 22, 2022 at 08:00:39PM +0800, Yang Yingliang wrote:

...

> > > > > It seems too complicated for the simple fix.
> > > > > 
> > > > > As I said, just drop const qualifier and add fwnode_handle_get() in the 'else'
> > > > > branch. This will allow you to drop if (prev) at the end.
> > > > fwnode is const, fwnode_handle_get doesn't accept this type.
> > > I'm talking about parent.
> > You suggested this:
> > 
> > "Instead you might consider to replace
> > 
> > 	parent = fwnode;
> > 
> > by
> > 
> > 	parent = fwnode_handle_get(fwnode);"
> > 
> > 
> > It has compile warning:
> > drivers/base/property.c: In function ‘fwnode_graph_get_next_endpoint’:
> > drivers/base/property.c:1004:30: warning: passing argument 1 of ‘fwnode_handle_get’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
> >    parent = fwnode_handle_get(fwnode);
> >                               ^~~~~~
> > drivers/base/property.c:809:63: note: expected ‘struct fwnode_handle *’ but argument is of type ‘const struct fwnode_handle *’
> >  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
> > 
> > ~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> 
> I see what you mean. Thank you for clarification.
> 
> So, it seems a bit twisted.
> 
> If prev == NULL, can the
> 
>         ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, NULL);
> 
> return NULL?
> 
> If no, we may move this case directly to the 'else' branch and return from there.

Answering to my own question: unfortunately it's the case when we have no
endpoints for the fwnode, but might have for the secondary one.

Okay, let's proceed with your slightly modified version 2 (label) for now.

-- 
With Best Regards,
Andy Shevchenko


