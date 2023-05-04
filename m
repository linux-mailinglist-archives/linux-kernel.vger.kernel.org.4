Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF9F6F6DE6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjEDOmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjEDOmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:42:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EAE3592
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683211331; x=1714747331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JZtArQ8TvPv7mtuLAG+ic+CHQLAPbY90gaientxZsTY=;
  b=c99ZMMHPghkOXRkIyQ8XAURsVQLU7/VQyWlkXgk+ogjoU6Z1w/Nus1Nv
   JE1+olOywB7Er0KMlmfb4kHgQWQEOQfXwGcA89DxIzgUlMeK+TT8n9PAU
   0lQYFNYoOYeqvEIt1jPIHOk0DlA11H26LVlZgvH/qvOY6CIN1LOhfBhQ+
   pIdYzi8k660zSJ8xuvU6L6Obf101kV4JWrkdfvvr/rGemZytXxYTIptar
   lMkio9PHzVzS0IIAOY+I8ik1YYBCchlk8+4nd1upEwDjoOnYeXxddiArx
   MHwB+DAOZvaPI5SuWdhmzWCRSCrAR1nqmCuXDd+FW4DDLtNSsJDkVW/8+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="333349347"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="333349347"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 07:41:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="808748776"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="808748776"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 04 May 2023 07:41:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pua94-0095su-0d;
        Thu, 04 May 2023 17:41:22 +0300
Date:   Thu, 4 May 2023 17:41:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] list.h: Fix parentheses around macro pointer
 parameter use
Message-ID: <ZFPEEVvHTw2uukun@smile.fi.intel.com>
References: <20230504012914.1797355-1-mathieu.desnoyers@efficios.com>
 <20230504012914.1797355-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504012914.1797355-2-mathieu.desnoyers@efficios.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 09:29:12PM -0400, Mathieu Desnoyers wrote:
> Add missing parentheses around use of macro argument "pos" in those
> patterns to ensure operator precedence behaves as expected:
> 
> - typeof(*pos)
> - pos->member
> 
> Remove useless parentheses around use of macro parameter (head) in the
> following pattern:
> 
> - list_is_head(pos, (head))
> 
> Because comma is the lowest priority operator already, so the extra pair
> of parentheses is redundant.
> 
> This corrects the following usage pattern where operator precedence is
> unexpected:
> 
>   LIST_HEAD(testlist);
> 
>   struct test {
>           struct list_head node;
>           int a;
>   };
> 
>   // pos->member issue
>   void f(void)
>   {
>           struct test *t1;
>           struct test **t2 = &t1;

I'm not against the patch, but I'm in doubt, looking into this example, it's useful.
Any real use case like above in the Linux kernel, please?

>           list_for_each_entry((*t2), &testlist, node) {   /* works */
>                   //...
>           }
>           list_for_each_entry(*t2, &testlist, node) {     /* broken */
>                   //...
>           }
>   }

-- 
With Best Regards,
Andy Shevchenko


