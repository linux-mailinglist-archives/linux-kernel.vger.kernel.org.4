Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF356E1D57
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjDNHg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjDNHgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:36:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B12265BD;
        Fri, 14 Apr 2023 00:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681457794; x=1712993794;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=j9H4XhOqaXRXw7mwZWQX3WnpgTOtPmDyR6IZ2uVoQVM=;
  b=Bjzoy4lyTBJM0PRSE1SxTEx0gTL4JoUDxb7WyeuGeIxaSLHLXa4v6eRS
   vjEy+cLhjtNX7Yzt1N/UD6T3u/CP0MHmwUu+YEahRspR1ahahLcbjphA/
   IAcBI80xK7HAEspcWvDh3xTF5dfE8PZ2jHScH6LTvFqhsE0yoGVSLQwHe
   N6YP71EkO1MVZgnXUWe34TEQchRfFDjW4TQK640AJ/huvNPz0zPcafA5+
   VfAE2WASMV0rMBkrbn31+zWkk28lOJlHp4sf3/ayBsxaBtCmsFovo/WUL
   SCW0o6S/uCy7A9eTSlxOvsP6aCo8F4hXv4LfP5fDxT7r9FUi8rO4ntx9J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="324757843"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="324757843"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 00:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="689701419"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="689701419"
Received: from smiokx-mobl.amr.corp.intel.com ([10.252.57.49])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 00:35:37 -0700
Date:   Fri, 14 Apr 2023 10:35:31 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Clear port->pm on port specific driver
 unbind
In-Reply-To: <20230414054726.GE36234@atomide.com>
Message-ID: <63b333cb-13c7-db58-9cf-697aa1c4c48a@linux.intel.com>
References: <20230413070342.36155-1-tony@atomide.com> <ZDgoi2mFYYqswAhu@smile.fi.intel.com> <20230414054726.GE36234@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-247702714-1681457540=:2245"
Content-ID: <bec8ce6c-2b31-205e-fc33-26d78b2fa6f5@linux.intel.com>
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

--8323329-247702714-1681457540=:2245
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <aa47b96e-d18e-caab-48ca-6d84cbb3da@linux.intel.com>

On Fri, 14 Apr 2023, Tony Lindgren wrote:

> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [230413 16:06]:
> > On Thu, Apr 13, 2023 at 10:03:41AM +0300, Tony Lindgren wrote:
> > > Let's fix the issue by clearing port->pm in serial8250_unregister_port().
> > 
> > Sounds to me like a fix that needs a Fixes tag.
> 
> Maybe commit c161afe9759d ("8250: allow platforms to override PM hook.").
> 
> That's a bit unclear though as the hardware specific functions were
> available at that point as they were passed in platform data. This can
> be seen with git blame c161afe9759d drivers/serial/8250.c. To me it seems
> the port->pm became potentially invalid if a serial port device driver
> started implementing PM runtime?
> 
> Maybe just tagging it with Cc: stable is better if no obvious Fixes tag
> can be figured out.

I'd just put that c161afe9759d there. It seems quite harmless even if it 
would be unnecessary before some driver commit which is much harder to 
pinpoint (and it would likely turn out old enough to not matter anyway 
for the kernels stable cares about).

I forgot to give this earlier:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.
--8323329-247702714-1681457540=:2245--
