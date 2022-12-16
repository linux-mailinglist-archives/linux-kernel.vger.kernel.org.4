Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0C464EC16
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiLPN3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLPN3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:29:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F298033C15;
        Fri, 16 Dec 2022 05:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671197350; x=1702733350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ck07sGHhJMBFToGDd7ByR/xpbpDEAMLEdbCNKaJc0oI=;
  b=KrNpCi0OkPWWJLNhDKPbPEirg9CTsbrRKNGFhE4j6Sp8+T9g8XOJdN6Q
   8tAU9b/h+cN0/Lz1ofnaaDfhisk6tg861i8DDBk9J3sqhZ5ej/PEFEjcZ
   XsuoMOidorSLtiZk9petO5ytblH4f0s1meRSS3SHSOP4BWkC+VIxHOd+m
   Vn2TjX0MCoAT/GuF7NEyJXzwi+U4GEsxv/pW/2BpfM90owmRJmUyTGL60
   2mmbBKQaQ4ZZT4u4fCc4VcXl46QMHpR7rS/v/q7QtT9b3vGeKzbQ4kLEr
   wAgQSrD3SGBjZdi4esxUpHHVFhu6dvUHaHCXItnl2/ap5EY4olGH45tK9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="298636420"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="298636420"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 05:29:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="651947209"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="651947209"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 16 Dec 2022 05:29:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p6Alr-00As4v-06;
        Fri, 16 Dec 2022 15:29:03 +0200
Date:   Fri, 16 Dec 2022 15:29:02 +0200
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
Message-ID: <Y5xynsu2/89iMuqF@smile.fi.intel.com>
References: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
 <20221216052656.2098100-3-kumaravel.thiagarajan@microchip.com>
 <Y5tciHzsEGU67h1Z@smile.fi.intel.com>
 <PH7PR11MB5958DF2284FDC67FA7018E9B9BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y5wrnzLMv5SCWPkn@smile.fi.intel.com>
 <PH7PR11MB5958956CB3DFD8E9B4A122379BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y5w8o0vK7wuoX+yh@smile.fi.intel.com>
 <PH7PR11MB595883AB9234881B2CF362549BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB595883AB9234881B2CF362549BE69@PH7PR11MB5958.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 10:31:38AM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Friday, December 16, 2022 3:09 PM
> > To: Tharunkumar Pasumarthi - I67821
> > <Tharunkumar.Pasumarthi@microchip.com>
> > Subject: Re: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
> > quad-uart support
> > 
> > > From this sequence, it seemed like, kernel takes care of freeing irq
> > > and calling pci_free_irq_vectors is not required.
> > 
> > Technically you are correct, but... read this discussion, and pay attention to
> > what Christoph said there:
> > 
> > https://lore.kernel.org/linux-serial/0250c46e-da6c-71f3-50ae-
> > b7c17fd0bd2c@siemens.com/
> 
> Okay, got it. Will use pci_free_irq_vectors.  Also, do you suggest using
> pci_enable_device instead of pcim_enable_device (to maintain consistency of
> using non managed APIs throughout driver)?

Up to you. I don't see any issues with devm_ and pcim_ APIs, you can get my
opinion from the very same discussion and also another which tried to pursue
pcim_alloc_irq_vectors().

-- 
With Best Regards,
Andy Shevchenko


