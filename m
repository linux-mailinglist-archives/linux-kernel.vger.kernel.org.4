Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766D75F0C16
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiI3M72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiI3M7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:59:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC617C204;
        Fri, 30 Sep 2022 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664542754; x=1696078754;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aGb+VH6pr8odLrfr0RoPw5oUpFWoUrgu1R8DknSYFIw=;
  b=PMJ4OoyCEFsNpRDTsYSDv4Q3t4Ma0xa0Y7lY6S5HCc5/mBfIuHqocpDA
   IVCeAK/ax0tuh1H1WSZ+AvBCvMuiYigTg3W7ghaWJJhPyWgLbnHXd3cIq
   K55A6vduamfhjwTGilEBmTGYrpGfMgeiy3D7p60mFOF0Sm9E7o82oq1Rq
   wmwXtoO63hJiqLUZmIqmRWZ8wRO+JgKapwa57HjQel3BMZZQvwecm1Hcn
   mummpvz3aThsVYr/tnaf9VW8HqnfJDTzeUzF/k3ECK4GVa4fuuNgF/smy
   tufGwBtX6uzMrYWM9pEl4m3omIhjizFc5OsEkFVwGdJQmJ03UqMz8gM7p
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303094755"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="303094755"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 05:59:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="748221566"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="748221566"
Received: from hbetts-mobl1.ger.corp.intel.com ([10.249.34.100])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 05:59:02 -0700
Date:   Fri, 30 Sep 2022 15:59:00 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sherry Sun <sherry.sun@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] Revert "serial: fsl_lpuart: Reset prior to
 registration"
In-Reply-To: <AS8PR04MB8404FAD25C9881FAD2754FB192569@AS8PR04MB8404.eurprd04.prod.outlook.com>
Message-ID: <b4779edd-200-c7df-4bde-7f434fdefa@linux.intel.com>
References: <20220929085318.5268-1-sherry.sun@nxp.com> <1265873d-28f9-d39c-5cce-858dbed1e8e8@linux.intel.com> <AS8PR04MB84044F397918A3475B5D8D1D92579@AS8PR04MB8404.eurprd04.prod.outlook.com> <39c68295-947-2353-d9b-3bd654c38c7@linux.intel.com>
 <AS8PR04MB8404FAD25C9881FAD2754FB192569@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022, Sherry Sun wrote:
> > On Thu, 29 Sep 2022, Sherry Sun wrote:
> > 
> > > > > This reverts commit 60f361722ad2ae5ee667d0b0545d40c42f754daf.
> > > > >
> > > > > commit 60f361722ad2 ("serial: fsl_lpuart: Reset prior to
> > > > > registration") causes the lpuart console cannot work any more.
> > > > > Since the console is registered in the uart_add_one_port(), the
> > > > > driver cannot identify the console port before call
> > > > > uart_add_one_port(), which causes all the uart ports including the
> > > > > console port will be global
> > > > reset.
> > > > > So need to revert this patch to avoid breaking the lpuart console.
> > > > >
> > > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > > ---
> > > > >  drivers/tty/serial/fsl_lpuart.c | 10 +++++-----
> > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > > > b/drivers/tty/serial/fsl_lpuart.c index 67fa113f77d4..7da46557fcb3
> > > > > 100644
> > > > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > > > @@ -2722,10 +2722,6 @@ static int lpuart_probe(struct
> > > > > platform_device
> > > > *pdev)
> > > > >  		handler = lpuart_int;
> > > > >  	}
> > > > >
> > > > > -	ret = lpuart_global_reset(sport);
> > > > > -	if (ret)
> > > > > -		goto failed_reset;
> > > > > -
> > > >
> > > > So the problem with this being so early is uart_console() in
> > > > lpuart_global_reset() that doesn't detect a console because
> > > > sport->cons is not yet assigned? Couldn't that be worked around
> > differently?
> > > >
> > > > Or is there something else in addition to that I'm missing?
> > > >
> > > Hi Ilpo,
> > >
> > > Yes, the root cause of the console cannot work after apply the commit
> > > 60f361722ad2 ("serial: fsl_lpuart: Reset prior to registration") is
> > > lpuart_global_reset() cannot identify the console port, so reset all
> > > uart ports.
> > 
> > This didn't answer my question. Is the main cause just lacking the ->cons
> > from sport at this point which, I guess, could be just assigned from lpuart_reg
> > similar to what uart_add_one_port() does before calling to reset?
> > 
> 
> Hi Ilpo,
> 
> Actually not only the (port)->cons need to be assigned, but also to get the right (port)->cons->index.
> 23 #define uart_console(port) \
> 24     ((port)->cons && (port)->cons->index == (port)->line)
> 
> The (port)->cons is assigned in uart_add_one_port(), quite simple.
> 3076     uport->cons = drv->cons;
> 
> But the (port)->cons->index is not that easy to get in lpuart driver, 
> now the value is assigned by calling register_console() from 
> uart_configure_port(). 

I've some skepticism to this claim. I now played with 8250 myself and 
confirmed it does have non-NULL ->cons for the console ports before 
to calls to uart_add_one_port() and index is setup up correctly for cons
too!

The reason for the cons being setup is this being done in 
univ8250_console_setup():

	/* link port to console */
	port->cons = co;

(which I think could be easily be done in lpuart_console_setup() too).

-- 
 i.

