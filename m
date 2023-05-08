Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638AD6FA427
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjEHJzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjEHJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:55:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E382ABE2;
        Mon,  8 May 2023 02:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683539746; x=1715075746;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=WTX1dz7lHf4L+q8fzbM1rRR3mOShmgZOjskHSySl7QI=;
  b=QME4RNf0BNSE6SzV8Xf3CyGjrDUt3YxJllz6VJurxALe1JrkBX1qvbGj
   BRxIrD6NZ9FU71ThbaCUEMOj+jOmfcQF4c/bjwI8Z47VMka5eY3/0vAY5
   7B+FSoItRVvSYzkIdUl3BMemMFb4ZGz4bdBxXFEWjaVbpz8AiMWhnGm+k
   sAQL1wNMVXJ1iHD95Yd9Ded1dNnPqhspESqJbyXlM5G4eCAG2rcFBiE5D
   /xV2sHW6Gc0LsW7sCIzIwoQh4Fejt3GJfobF7yrF88SFV5qn3M8JPyeIN
   rykvu1CVRF9E3w2JZ6vaf0fype3HNUgvwDbOGyAUu+YHWPZ+g+5RH8zni
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="338826299"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="338826299"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 02:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="842634466"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="842634466"
Received: from cciobanu-mobl1.ger.corp.intel.com ([10.249.37.159])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 02:55:41 -0700
Date:   Mon, 8 May 2023 12:55:38 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>, Johan Hovold <johan@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] serial: 8250: omap: Fix freeing of resources on
 failed register
In-Reply-To: <20230508082014.23083-2-tony@atomide.com>
Message-ID: <9ea78388-86f-736b-e46-b3bc6223ddbe@linux.intel.com>
References: <20230508082014.23083-1-tony@atomide.com> <20230508082014.23083-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-543991086-1683538786=:1790"
Content-ID: <16ee339f-7443-12e0-5159-93dbbb6ea79@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-543991086-1683538786=:1790
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <e92d2f17-9e4c-c55c-9e41-e213b929c4d0@linux.intel.com>

On Mon, 8 May 2023, Tony Lindgren wrote:

> If serial8250_register_8250_port() fails, the SoC can hang as the
> deferred PMQoS work will still run as is not flushed and removed.
> 
> Fixes: 61929cf0169d ("tty: serial: Add 8250-core based omap driver")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1532,7 +1532,9 @@ static int omap8250_probe(struct platform_device *pdev)
>  err:
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_put_sync(&pdev->dev);
> +	flush_work(&priv->qos_work);
>  	pm_runtime_disable(&pdev->dev);
> +	cpu_latency_qos_remove_request(&priv->pm_qos_request);
>  	return ret;

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

An unrelated comment to the patch itself, there seems to be somewhat 
handwavy and possibly wrong calculation for the pm qos latency. First of 
all, I think it would want something based on port->frame_time, and I'm 
far from convinced that 64 is right as it matches FIFO size which doesn't 
feel correct for a wakeup related time.

-- 
 i.
--8323329-543991086-1683538786=:1790--
