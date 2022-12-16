Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3BC64E8BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 10:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiLPJi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 04:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiLPJix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 04:38:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E297046675;
        Fri, 16 Dec 2022 01:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671183531; x=1702719531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IY7vY5n7yGY6h3AEjtKjdblFwlLaoZs4ETO5gdM+BpY=;
  b=f7TLxXs3AMrOkx212uMp/tP3nfpRNF0AJjhE+moEWW27bFst/YXIcNPh
   xRi56h5GzOlT0N3THalVO8Htm32U4c3CA/891abvpAWOxqsLlIc6GqQOu
   318E6H5KVtaKfJeJicexYHpfrugEob4QOIhT5lgyjQo0DSHOehwKjbdLm
   vMw0FIGm4l+tGB5bEoulH0QPCTzLn33qaV+bGcIKsttYeFZyqjfhajT2d
   gtjootIvLbhJ3f7bInWFu2xzSR3bsXnPLKgID7zoyk7er+VFn+quM7An3
   0ufr/yrGjYGSGWmJWCmQ9aoPE5p47Eh9TvGcLHj/PtlvCPHkZK3p+782q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="317626649"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="317626649"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 01:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="895172654"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="895172654"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 16 Dec 2022 01:38:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p67Ay-00Am6T-0S;
        Fri, 16 Dec 2022 11:38:44 +0200
Date:   Fri, 16 Dec 2022 11:38:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     Kumaravel.Thiagarajan@microchip.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        macro@orcam.me.uk, cang1@live.co.uk, colin.i.king@gmail.com,
        phil.edworthy@renesas.com, biju.das.jz@bp.renesas.com,
        geert+renesas@glider.be, lukas@wunner.de,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Message-ID: <Y5w8o0vK7wuoX+yh@smile.fi.intel.com>
References: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
 <20221216052656.2098100-3-kumaravel.thiagarajan@microchip.com>
 <Y5tciHzsEGU67h1Z@smile.fi.intel.com>
 <PH7PR11MB5958DF2284FDC67FA7018E9B9BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y5wrnzLMv5SCWPkn@smile.fi.intel.com>
 <PH7PR11MB5958956CB3DFD8E9B4A122379BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB5958956CB3DFD8E9B4A122379BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 09:30:42AM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Friday, December 16, 2022 1:56 PM

...

> > > > > +             pci_iounmap(pdev, priv->membase);
> > > >
> > > > Here is inconsistency on how you interpret pci_*() calls when
> > > > pcim_enable_device() has been used. I.e. for IRQ you don't
> > > > deallocate resources explicitly (yes, it's done automatically
> > > > anyway), but you explicitly call pci_iounmap(). Choose a single approach
> > for all of them.
> > >
> > > AFAIK call to pci_iounmap cannot be avoided since pci_ioremap_bar is not
> > 'managed' API.
> > > You suggest calling pci_free_irq_vectors (even though it is not mandatory)?
> > 
> > Why is it not mandatory?
> 
> Following is the reason why I felt calling pci_free_irq_vectors is not
> mandatory.  Correct me if my understanding is wrong.
> 
> Following is the Callback Sequence (from 6.1 kernel) that gets executed upon
> calling pci_alloc_irq_vectors:
> pci_alloc_irq_vectors =>
>  pci_alloc_irq_vectors_affinity =>
> __pci_enable_msi_range =>
>  pci_setup_msi_context =>
>  pcim_setup_msi_release =>
> 
> devm_add_action(&dev->dev, pcim_msi_release, dev);
> 
> Inside pcim_msi_release: (called since pcim_enable_device is used)
> pci_free_irq_vectors(dev);
> 
> From this sequence, it seemed like, kernel takes care of freeing irq and
> calling pci_free_irq_vectors is not required.

Technically you are correct, but... read this discussion, and pay attention to
what Christoph said there:

https://lore.kernel.org/linux-serial/0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com/

-- 
With Best Regards,
Andy Shevchenko


