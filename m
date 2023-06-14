Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E83D7304A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjFNQNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjFNQNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:13:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E5A1FE2;
        Wed, 14 Jun 2023 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686759232; x=1718295232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o5uQWnqbwzaqb8LixYVI9Hou4OwCL2loJHaPencrplE=;
  b=fngjgK4Vop4JInyKacVRtrHgFifJbBM565hlxZzIHAw/fqMm4s3qOARw
   tJp8TBtMdu2PvmlHMQWkU6yaqClGFQGWuD9uX7CZvILeH4Pubmlu6OaMM
   cU0Wr9YN2kjRrVZQaWczSK3R3Uy9oie6gQ/r3otKNFYOwgK5C+Gihm2/e
   UvbfHuzUvKrk9dj7x4JechCKkh1J/ce2q0tARK5Pkji6PJ2+QS8PFfv13
   fUTTbqDEzlAhT+F3ArQ9vPJefG1aC7KE/kteBmXPLi/M2MUKt3t8/ys1X
   nite7Kp50nflWwjus9oL5PwjjZSa9VpVQLgJkJhcyfuWq/h6vDLQObSze
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="358658082"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="358658082"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="662449589"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="662449589"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 14 Jun 2023 09:08:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9T3A-003jgN-1P;
        Wed, 14 Jun 2023 19:08:48 +0300
Date:   Wed, 14 Jun 2023 19:08:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_lpss: Fix missing check for return value of
 pci_get_slot()
Message-ID: <ZInmEJJjLEwCiOBU@smile.fi.intel.com>
References: <20230614153226.117768-1-cymi20@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614153226.117768-1-cymi20@fudan.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 08:32:26AM -0700, Chenyuan Mi wrote:
> The pci_get_slot() function may return NULL, which may
> cause null pointer deference, and most other callsites of
> pci_get_slot() do Null check. Add Null check for return
> value of pci_get_slot().
> 
> Found by our static analysis tool.

...

>  	dma_dev = pci_get_slot(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
> +	if (!dma_dev)
> +		return -ENODEV;

This adds (almost) a dead code. The function 0 must be present in accordance
with the PCI specification (even earliest version of it state that).
If pci_get_slot() returns a NULL, in this case it means that something, much
bigger issue, happens and this check won't help us to do anything anyway.

-- 
With Best Regards,
Andy Shevchenko


