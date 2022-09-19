Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BDD5BCDB7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiISN4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiISN4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:56:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA942A72E;
        Mon, 19 Sep 2022 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663595779; x=1695131779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=E5STyERfxj0TBuka255qoUOiDV525ZkzMTuV18YJ7zc=;
  b=aSgD5imNQPaWvPIBXYgM/If77AnE94J7TEKsmOdzTX3Lg7lC/7diU9pp
   dWBoP6rGpUlS/v7xgHaa86GooZr9ydcdTVhWTCkDncn7i42oxPmXoy09x
   FbZxKCbNpr6eGIVFXIN6E7xpqdklVi63mxNnmKw0U1JyG0MFgNCrXiyEg
   CPILqO5Stz4p6cXQulBwRMRfX+EMcY+IssHG7yOV37xo+nMq+iWze+8ak
   g8LgMN/G/kFmhc/szglH8wCFVTglgsKqhOrj5aM/hn09tNHRj7Vnnaz9N
   Dv4hA3OmugBLv/lEk7kycyo+JWtHIU5TtB4BY9Q5SjswhAa0Ep2kzFJo3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279786173"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="279786173"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 06:56:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="744123230"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 19 Sep 2022 06:56:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oaHFu-004ZyF-05;
        Mon, 19 Sep 2022 16:56:14 +0300
Date:   Mon, 19 Sep 2022 16:56:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
        Alex Williamson <alex.williamson@hp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennert Buytenhek <buytenh@arista.com>
Subject: Re: [PATCH v2 1/1] serial: 8250: Turn IER bits on only after irq has
 been set up
Message-ID: <YySZ8M5OQqAaaT1b@smile.fi.intel.com>
References: <20220916133804.15196-1-ilpo.jarvinen@linux.intel.com>
 <YySX8E3PjAvRr/ld@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YySX8E3PjAvRr/ld@smile.fi.intel.com>
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andriy.shevchenko@linux.intel.com>) id 1oZDWL-003IJw-18;
 Fri, 16 Sep 2022 18:44:49 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 06:36:16PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 16, 2022 at 04:38:04PM +0300, Ilpo Järvinen wrote:

Side note:

$ git grep -n -w setup_irq -- drivers/tty/
drivers/tty/serial/8250/8250_core.c:382:        .setup_irq      = univ8250_setup_irq,
drivers/tty/serial/8250/8250_port.c:2341:       retval = up->ops->setup_irq(up);

which rises a question of whether we need the setup_irq member in the
respective structure.

-- 
With Best Regards,
Andy Shevchenko


