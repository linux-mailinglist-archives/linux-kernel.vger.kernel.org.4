Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8A69ACEB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBQNsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjBQNsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:48:16 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F21E6ABF6;
        Fri, 17 Feb 2023 05:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676641667; x=1708177667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YkkIrcqm6mJhImZ3KMLTfPPDD73LnOLWafj7JBsc3kI=;
  b=LwIlhWIk2Wc2XvMWWEcxvTNGMHmtEoBzVOSCU+G7WfoFOXtrWLK4v04i
   /+SBbc8RcW6Ef/ihb/Z4fH5Y8r45IY6sPTdYuq0jM7qFKPR1xNbpUkYzV
   zctmrG2Eo5f47YFFqBd/cn0weLeVX+EmOAkxd4ti12kpSWUux+2LUuYyn
   Ukc8UKaBk/SF7irG3zVTRpwibgYgHf/cX9PQ65uqoxMWP9DDyTMG36PgU
   BM3shHSZGPxr9cnCEvQA8w2HcdIZHJOYmY9o58Fo4EWp9TwDZ55ys4O84
   N7eorrhhWrUWjMPvKiu+J4LRvDukOoUEnedDZq1gfRjlQsK8dOakQ7rTC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="359438416"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="359438416"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 05:47:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="670547268"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="670547268"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2023 05:47:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pT15S-008EKk-0e;
        Fri, 17 Feb 2023 15:47:42 +0200
Date:   Fri, 17 Feb 2023 15:47:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Kaehn <kaehndan@gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Clarify description of returned
 value in some functions
Message-ID: <Y++FfYfiE1mLceNk@smile.fi.intel.com>
References: <20230217133344.79278-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217133344.79278-1-andriy.shevchenko@linux.intel.com>
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

On Fri, Feb 17, 2023 at 03:33:44PM +0200, Andy Shevchenko wrote:
> Some of the functions do not provide Return: section on absence of which
> kernel-doc complains. Besides that several functions return the fwnode
> handle with incremented reference count. Add a respective note to make sure
> that the caller decrements it when it's not needed anymore.
> 
> While at it, unify the style of the Return: sections.
> 
> Reported-by: Daniel Kaehn <kaehndan@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> 
> v2: rephrased the note, added tag, removed unrelated change
>     (all requested by Sakari)

I just realized I have forgotten to bump the version.
I will wait for other comments, and will issue a v3 if needed.

-- 
With Best Regards,
Andy Shevchenko


