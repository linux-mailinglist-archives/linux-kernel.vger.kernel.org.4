Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0227874D96E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjGJPCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjGJPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:02:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3466D129
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689001329; x=1720537329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jW7QgjkMskZ22inEb7BiFGwKkbe+S2Six+Vio423N9E=;
  b=PRkjcS6s/0+ubyFkao//4U71/8O2RhAcPdKv72AK4wZDmi1lbxsOvd3b
   oizQVAqwStS2gwhMcFVWmdhIXbdn8Ugdc5KliVs46r3h8pf9vlgmlYpdG
   gyVGIaPCZ+nciWZaY79C2qcSSCmAbTjRbgBbyJE8uwBbaxVirma87Rouu
   2Sftm4FrAYTuVi2cY4gzlGOalWLtyaZVBviMpG58x1gJvDBdo5PdCQd/Z
   kCie4lFr+PDT9ECNEI+sVykD8P6ewh0ePuLBHS5U5huRhkFCkew5QvTad
   +zYFBcm6fhm1vYLSp/dlX4qRXoOQYVejx1PtmnjA3mfhTdIxWaVrr5P/4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="428060136"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="428060136"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 08:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="720724781"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="720724781"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2023 08:01:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qIsOZ-001aJL-1l;
        Mon, 10 Jul 2023 18:01:47 +0300
Date:   Mon, 10 Jul 2023 18:01:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] regmap: spi: Use spi_message_init_with_transfers()
Message-ID: <ZKwdW0l8NlDx9Rnb@smile.fi.intel.com>
References: <20230710142335.66598-1-andriy.shevchenko@linux.intel.com>
 <17de613f-c417-440e-95c6-3cf65607dc99@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17de613f-c417-440e-95c6-3cf65607dc99@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:38:55PM +0100, Mark Brown wrote:
> On Mon, Jul 10, 2023 at 05:23:35PM +0300, Andy Shevchenko wrote:

...

> > -	spi_message_init(&async->m);
> > -	spi_message_add_tail(&async->t[0], &async->m);
> > -	if (val)
> > -		spi_message_add_tail(&async->t[1], &async->m);
> > +	spi_message_init_with_transfers(&async->m, async->t, val ? 2 : 1);
> 
> I'm not sure this is a legibility win.

Fair enough. Since it's not an inlined call, ion x86_64 it gives +64 bytes
to the code.

Let's drop it.

-- 
With Best Regards,
Andy Shevchenko


