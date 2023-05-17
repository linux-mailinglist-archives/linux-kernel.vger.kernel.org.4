Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987B5706E01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjEQQVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEQQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:21:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A4DE66;
        Wed, 17 May 2023 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684340452; x=1715876452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TJJjxZv/+YTJMh3VqRy+st8hbyyXa/vAr7VoctwQbvw=;
  b=KiIPepszxpUvCBIONHQKwZVbs7cSwTD3lsEUWlHbzioq83QW1UKXOIX6
   SBUE9GVb+g8qHtcRVM7Z2/x3XYVlh+upHjWWOnwZ0AbmNZJBaQtX/cmaV
   +Z2AdDcIF4KXQ34a4WlLF5XMEFgJAmEHHqbWQoHOy8tC1GS6aB3/VoEX5
   TVhP5pXmuuj09MggEP7rj1Gp4Gfll8G7LAeyXzLnPi4nobb0OmqfYD7C7
   RN6PiwU3eC53LxBfd6RKtnvKGE8mZ2mGBXJfhaMmpBl7RmeANBJxhwfgy
   GTOkqxLN4wF9wCRw4CWnjjaGWsc4xNjakp4u4dNm/mGwtvQMELRh+oVKW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="354106510"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="354106510"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 09:19:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="766838897"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="766838897"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 17 May 2023 09:19:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pzJsC-0008TH-1n;
        Wed, 17 May 2023 19:19:32 +0300
Date:   Wed, 17 May 2023 19:19:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: printk-formats: Clarify %*pb format parameters
Message-ID: <ZGT+lJasWhZ0TPRi@smile.fi.intel.com>
References: <20230516-printk-bitmap-v1-1-d5f810192a10@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516-printk-bitmap-v1-1-d5f810192a10@fairphone.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 08:52:43AM +0200, Luca Weiss wrote:
> Since it's rather unusual for printk formats to require two parameters,

I don't think this is "unusual". The %*... is very well described in the
printf(3) (the meaning of *). It applies here for %*p... as well.

> expand the documentation to clearly mention that in the printk format
> for bitmaps.
> 
> As an extra example, for example from include/net/bluetooth/hci_core.h
> we have a bitmap DECLARE_BITMAP(dev_flags, __HCI_NUM_FLAGS);
> This can be printed with ("%*pb", __HCI_NUM_FLAGS, hdev->dev_flags)

I think this change is not needed. But try to convince PRINTK maintainers.
Maybe they will be okay with it if it covers all %*p... cases (like %*ph).

-- 
With Best Regards,
Andy Shevchenko


