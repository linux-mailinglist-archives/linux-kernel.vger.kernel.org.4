Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351935BCE11
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiISOHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiISOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:07:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D67231ED3;
        Mon, 19 Sep 2022 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663596467; x=1695132467;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=x+yyT+5VldaQAOebpTGHl+NUKCO2rBUvs7E2S7CcYD4=;
  b=mBMQjLDz7AJpBvAG8RHguYScoOyEsyen279oApNcZlfd1ywz1v/8oUJw
   nXX3Y8XwQdnZcAy10y0QgmsQD4vCV+5ZumnUpsnDNVSY8S/DhTi0ZtryX
   84TsPKxLCe3bQEloSnVGtwYUs8SScS4Y7w16DQPSx+mh04IiPk9EnX7vE
   ADkqqzknWFzvFLUOnS0tNv2TPhn/lqEZErYEbg0Vyxt/exqrq/XOh4Miq
   ljN2eWfTA8E3HUQjhVNOFn6X+6LfEKsCV2bWWCxsRnYH6hfQA459241/R
   nkFyJEnYxk9ZQsZjCJkKAb0m/+c0YPJ+376rk+u/4f/SzxqYfdNgzpUJT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="298134895"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="298134895"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 07:07:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="707578965"
Received: from iswiersz-mobl1.ger.corp.intel.com ([10.252.33.172])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 07:07:07 -0700
Date:   Mon, 19 Sep 2022 17:06:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Lennert Buytenhek <buytenh@wantstofly.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
        Alex Williamson <alex.williamson@hp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lennert Buytenhek <buytenh@arista.com>
Subject: Re: [PATCH v2 1/1] serial: 8250: Turn IER bits on only after irq
 has been set up
In-Reply-To: <YySaixqlQjkMYPUB@smile.fi.intel.com>
Message-ID: <f55fafa9-c957-f7ee-ea49-475ba5f96d9@linux.intel.com>
References: <20220916133804.15196-1-ilpo.jarvinen@linux.intel.com> <YySX8E3PjAvRr/ld@smile.fi.intel.com> <YySZ8M5OQqAaaT1b@smile.fi.intel.com> <YySaixqlQjkMYPUB@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-34262818-1663596326=:1603"
Content-ID: <6781d2c6-317b-9088-727e-72bcc5ce61be@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-34262818-1663596326=:1603
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <3b6a1468-8636-e0bd-c6-b2e242ebf6b@linux.intel.com>

On Mon, 19 Sep 2022, Andy Shevchenko wrote:

> On Fri, Sep 16, 2022 at 06:44:49PM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 16, 2022 at 06:36:16PM +0300, Andy Shevchenko wrote:
> > > On Fri, Sep 16, 2022 at 04:38:04PM +0300, Ilpo Järvinen wrote:
> > 
> > Side note:
> > 
> > $ git grep -n -w setup_irq -- drivers/tty/
> > drivers/tty/serial/8250/8250_core.c:382:        .setup_irq      = univ8250_setup_irq,
> > drivers/tty/serial/8250/8250_port.c:2341:       retval = up->ops->setup_irq(up);
> > 
> > which rises a question of whether we need the setup_irq member in the
> > respective structure.
> 
> And to be confident, the files that include linux/serial_8250.h and have
> setup_irq word in them (recursive `git grep`) in entire source tree:
> 
> drivers/tty/serial/8250/8250_core.c
> drivers/tty/serial/8250/8250_port.c
> include/linux/serial_8250.h

Thanks. I know about it already.

The whole struct uart_8250_ops seems useless indirection layer (and 
IIRC the results of my history dig, it was added w/o any justification). 
It's on my kill list already :-) but I'll wait a bit with the cleanups to 
avoid -linus vs -next conflicts.

-- 
 i.
--8323329-34262818-1663596326=:1603--
