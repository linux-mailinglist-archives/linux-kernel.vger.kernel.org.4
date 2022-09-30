Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FA35F0C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiI3Nm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiI3Nm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:42:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E77A13199F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664545375; x=1696081375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j9Azp0LY6MOpjs+1ZdSjiW2WelSy0gG2nxktoO78hdk=;
  b=jWzWVUbKnlQf9nGjrOHqJDh4hMW8S+N5cpTZuXu2iZgxQUYZbUeTcZJE
   1fY8BTDuC4v0WrlGVeU94JCPYgkJXe81qwZxNa9RJ9seNppaFAMOQ1jmV
   J8KCso2z4aNhdDR+R3TsZAX0uqj/qDDGcr9E/BbWeMZtquK7joPK6yQOM
   eU0c99bzin7sOq8c6Y5SgQiJmCggNITwQtOLZ4w5CXg0A+TTNt/ZDcFkF
   ou6Ex03w6qXxqN6W5cyuD8i3q5uUkDw6Kvyp+PMNfeSj7dos7TDNlpcG4
   m9OQ1N1cVFfGbDwI0J9OPCZfqL+DvPj6fRkCl6cWEpgAnL2h4s+wzbIbd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="328575482"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="328575482"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 06:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="726864753"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="726864753"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 30 Sep 2022 06:42:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oeGHw-000WpE-2P;
        Fri, 30 Sep 2022 16:42:48 +0300
Date:   Fri, 30 Sep 2022 16:42:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH] printf: Emit "SUCCESS" if NULL is passed for %pe
Message-ID: <YzbyWL7rZhLUOjTR@smile.fi.intel.com>
References: <20220930111050.1296018-1-u.kleine-koenig@pengutronix.de>
 <YzbdmJvcPiYAIalt@alley>
 <20220930132424.wnnrs4bpwiuukclk@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930132424.wnnrs4bpwiuukclk@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 03:24:24PM +0200, Uwe Kleine-König wrote:
> On Fri, Sep 30, 2022 at 02:14:16PM +0200, Petr Mladek wrote:
> > On Fri 2022-09-30 13:10:50, Uwe Kleine-König wrote:

...

> > If get_bla() returns NULL then it means a super fault. It means
> > that get_bla() failed and did not know why.
> 
> OK, I think we agree that a function that might return an error pointer
> shouldn't return NULL with the semantic "This is also an error."

But it neither means "success".

-- 
With Best Regards,
Andy Shevchenko


