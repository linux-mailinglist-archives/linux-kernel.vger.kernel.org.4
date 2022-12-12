Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A70649F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiLLMuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiLLMt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:49:56 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D297F1107;
        Mon, 12 Dec 2022 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670849394; x=1702385394;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=17A8u7UINSK9mVy2bf6dgep4EzLuH0vbmZm+/lj3kjo=;
  b=NRki/BxvUK71QX+MpF7dWgaz2RyUpQeVINWBQu8Hps5b1sYTk/60TFoT
   OE3susG9BmPkbmHze4j2RghVWvqMSO2jg0X3YOzEJROQrcx/FETzTVBiv
   5yOcwip3FDJ5sWIBBmx6UduLO5LYXaYR94ct/cciuDjc9w0FGse+2jwK5
   XB7LNd2M+ZTj5JJ+B+iXQ/KTWNUakN20mwFdGpzmSDKPi0j1SsfLF2vLI
   NPsUh8uJpp96YeLHUyOr6NNJ8CJk5Avw8wJs3yNTeEBUFcQ+crQxoEiAX
   2L4qMqo7BelaGRGWG0RK6xc1E9JFSL0M/GDCERTKwCU+GPh5l3/9dLk7v
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="305486344"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="305486344"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 04:49:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="716784636"
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="716784636"
Received: from rnowicki-mobl.ger.corp.intel.com ([10.249.39.121])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 04:49:51 -0800
Date:   Mon, 12 Dec 2022 14:49:48 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
In-Reply-To: <Y5bToLirsgA5NK/j@atomide.com>
Message-ID: <ced9e9ea-317e-f2a2-d42f-97c2cd39f11b@linux.intel.com>
References: <20221207124305.49943-1-tony@atomide.com> <7f105ff9-cdc3-f98e-2557-812361faa94@linux.intel.com> <Y5G5Udw6FAEFdAYi@atomide.com> <3c87186b-336f-6884-a2c-6ee3c9d70@linux.intel.com> <Y5HG2okzlqX+xfWv@atomide.com> <Y5bToLirsgA5NK/j@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1000174910-1670849393=:1743"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1000174910-1670849393=:1743
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 12 Dec 2022, Tony Lindgren wrote:

> Hi Ilpo,
> 
> * Tony Lindgren <tony@atomide.com> [221208 11:13]:
> > * Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [221208 10:48]:
> > > With the other patch on top of this, yes, I did see uninitialized 
> > > port->port_dev already in serial_core_add_one_port()->uart_configure_port().
> > > While that could be solved by removing the pm_runtime_*() calls from 
> > > there, I think it's a generic problem because after 
> > > serial_core_add_one_port() the port can have anything happening on it, no?
> > 
> > OK. Sounds like it should get sorted out by moving the call to
> > serial_core_add_one_port() to happen after the devices are created.
> 
> Can you give a try with the patch below and see if it works for you?

This one worked, yes.

-- 
 i.

--8323329-1000174910-1670849393=:1743--
