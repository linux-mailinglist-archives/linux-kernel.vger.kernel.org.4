Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BBC642859
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiLEMW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiLEMWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:22:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB13B11802;
        Mon,  5 Dec 2022 04:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670242965; x=1701778965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lcxVp1A+yBTRM/AOTd0nAsYWpVQXLhD464zMr8HvkrY=;
  b=GQ9d+0A+edlCGuTZ6Rn7v1w7z8+iZ/qGF7pvoT1Q5L5+RMr5n1CWZfUT
   WvtvUCRqaTWqkXoLXyW6XyBfBaZ34c0Du4IT4oYVnRGjoG4wpqZ7V5wI2
   q8WuLVlCXz6uaz/r0wmhjFHkwx5bydrz9LigJpcwr4V68pyGfI0mPq+qM
   yLJbkDGDHJMJkdubcRpU7ZD4BrzUeC0UIC+C98mvu4zEKUnmOCxi6rdXn
   2/umY2BTMtVJuLT0J2oW02le3DgZCcVbFBnQ4IXPSNQgfGe+U4/LirYVn
   ZKtbuqS9GYdqjaPIc+7twW1sjttuunoCuhoQyBtLtBeczBRk6FoMEYT+y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="343327236"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="343327236"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 04:22:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="639465380"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="639465380"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2022 04:22:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2AUZ-004rjI-3D;
        Mon, 05 Dec 2022 14:22:40 +0200
Date:   Mon, 5 Dec 2022 14:22:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [RESEND PATCH] soc: fsl: qe: request pins non-exclusively
Message-ID: <Y43ij5rwNLOaztch@smile.fi.intel.com>
References: <Y4wnGgMLOr04RwvU@google.com>
 <81a7715b-559f-4c5c-bdb6-1aa00d409155@app.fastmail.com>
 <Y40zZ8fkE9d1zbbV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y40zZ8fkE9d1zbbV@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 03:55:19PM -0800, Dmitry Torokhov wrote:
> On Sun, Dec 04, 2022 at 01:10:19PM +0100, Arnd Bergmann wrote:
> > On Sun, Dec 4, 2022, at 05:50, Dmitry Torokhov wrote:
> > >
> > > SoC team, the problematic patch has been in next for a while and it
> > > would be great to get the fix in to make sure the driver is not broken
> > > in 6.2. Thanks!
> > 
> > I have no problem taking thsi patch, but I get a merge conflict that
> > I'm not sure how to resolve:
> > 
> > 
> > @@@ -186,23 -182,27 +180,43 @@@ struct qe_pin *qe_pin_request(struct de
> >         if (WARN_ON(!gc)) {
> >                 err = -ENODEV;
> >                 goto err0;
> > ++<<<<<<< HEAD
> >  +      }
> >  +      qe_pin->gpiod = gpiod;
> >  +      qe_pin->controller = gpiochip_get_data(gc);
> >  +      /*
> >  +       * FIXME: this gets the local offset on the gpio_chip so that the driver
> >  +       * can manipulate pin control settings through its custom API. The real
> >  +       * solution is to create a real pin control driver for this.
> >  +       */
> >  +      qe_pin->num = gpio_chip_hwgpio(gpiod);
> >  +
> >  +      if (!of_device_is_compatible(gc->of_node, "fsl,mpc8323-qe-pario-bank")) {
> >  +              pr_debug("%s: tried to get a non-qe pin\n", __func__);
> >  +              gpiod_put(gpiod);
> > ++=======
> > +       } else if (!fwnode_device_is_compatible(gc->fwnode,
> > +                                               "fsl,mpc8323-qe-pario-bank")) {
> > +               dev_dbg(dev, "%s: tried to get a non-qe pin\n", __func__);
> > ++>>>>>>> soc: fsl: qe: request pins non-exclusively
> >                 err = -EINVAL;
> > -               goto err0;
> > +       } else {
> > +               qe_pin->controller = gpiochip_get_data(gc);
> > +               /*
> > +                * FIXME: this gets the local offset on the gpio_chip so that
> > +                * the driver can manipulate pin control settings through its
> > +                * custom API. The real solution is to create a real pin control
> > +                * driver for this.
> > +                */
> > +               qe_pin->num = desc_to_gpio(gpiod) - gc->base;
> >         }
> > 
> > Could you rebase the patch on top of the soc/driver branch in the
> > soc tree and send the updated version?
> 
> I see, it conflicts with:
> 
> 	c9eb6e546a23 soc: fsl: qe: Switch to use fwnode instead of of_node
> 
> that is in next but not in soc/driver tree/branch.

That's due to no reaction on the patch [1] from Freescale maintainers (*).
Either soc subsystem can pull this [2] or your patch can go via
pin control subsystem.

*) Note, there is not Arnd's name nor soc mailing list in the MAINTAINERS
   regarding those files, so I had had no idea about the correct route of
   the change.

[1]: https://lore.kernel.org/lkml/20221005152947.71696-1-andriy.shevchenko@linux.intel.com/
[2]: https://lore.kernel.org/linux-gpio/Y3YY%2Fm0F%2FRh0jUc7@black.fi.intel.com/

-- 
With Best Regards,
Andy Shevchenko


