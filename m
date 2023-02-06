Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BE368BBDF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjBFLli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjBFLle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:41:34 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E2C65B0;
        Mon,  6 Feb 2023 03:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675683693; x=1707219693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rAwgKYBPGk0QzlYFoRspv9OXHXIL5K6iZ1/300XtFMM=;
  b=f052frIl+KNoSqAaXdtHu9WNIBenaoE1ReYJcC+sg+1cTkfi701uIVEB
   XzF12GjwZcQY3UsoN08kjqLszWXwYF9xCiGWcNbb2WS6iRCv2NoKDaeNs
   tKNjVDId0NTKFHLGm+YtNeO5h1JD7DxC3m00u7YVYXybcPNbyHfCflDAi
   ffm7HjyuYwl9LQhU2QUL75rxZjp1z6AruqsKMK01soZfhLWaOTYspgVSC
   3MNKt3Ag+Sh4m+v+vlwNj7Z98p9eHft9YDCV74LhrlFFGzmBuKTwIDUYx
   k3Tx/JYvBtFaY0L6EC+3opfDP9k6LQH4TNLNT/wi4N0gUzEffcdkQuEQ7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="327817719"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327817719"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 03:41:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="840328319"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="840328319"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 06 Feb 2023 03:41:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pOzsA-0039To-21;
        Mon, 06 Feb 2023 13:41:22 +0200
Date:   Mon, 6 Feb 2023 13:41:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk, lukas@wunner.de,
        cang1@live.co.uk, matthew.gerlach@linux.intel.com, deller@gmx.de,
        phil.edworthy@renesas.com, geert+renesas@glider.be,
        marpagan@redhat.com, u.kleine-koenig@pengutronix.de,
        etremblay@distech-controls.com, wander@redhat.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v11 tty-next 1/4] serial: 8250_pci: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Message-ID: <Y+DnYrc03wyY74hv@smile.fi.intel.com>
References: <20230204053138.2520105-1-kumaravel.thiagarajan@microchip.com>
 <20230204053138.2520105-2-kumaravel.thiagarajan@microchip.com>
 <Y+DnLV6Zfdy2Bz8S@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+DnLV6Zfdy2Bz8S@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 01:40:30PM +0200, Andy Shevchenko wrote:
> On Sat, Feb 04, 2023 at 11:01:35AM +0530, Kumaravel Thiagarajan wrote:

> Ah, of course, you missed
> 
> #include "8250_pcilib.h"
> 
> here.

That said, please make sure before sending v12 that you have it compiled with
`make W=1 ...`.

-- 
With Best Regards,
Andy Shevchenko


