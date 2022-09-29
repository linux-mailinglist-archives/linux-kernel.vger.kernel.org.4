Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BB85EF423
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiI2LTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiI2LTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:19:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B0014AD69;
        Thu, 29 Sep 2022 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664450357; x=1695986357;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Whifblvle5Uq5hTKfSa28zbbpyf+/wOvfOuC9En91aQ=;
  b=dWoYWeOfZPC5ztJOc26+L7kfGRRqAimIeLDvW4Sp12lEpVaxq3WqdH58
   zZzqAXw8qWgNn7RbfymKngYlu5Kb//wnVxt3a/KfaHp8+C4DJu9G+fU5n
   fjAEUzrZtzXSltez513T2CU/O5cYfoHHZE8q3J3QZhOjN/mWL4arVJ/xe
   wJv8VzLMnROOpT07vgdWB3pR/vyS+W4QzoJrfDchnFiWwVvkHGHAPTYZa
   kB06ESLCUJqkONgkj6q/UuUmpLwyd/3qIGTUutdXDHqZCUo+8S5kVzg+f
   Qo48gyL7yjEB5CTHwVhE3M7sN20NTLlr98P6B8nMAHWxcRp13ZHUrTkJd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="363708788"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="363708788"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 04:19:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="951091159"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="951091159"
Received: from pramona-mobl1.ger.corp.intel.com ([10.252.60.139])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 04:19:10 -0700
Date:   Thu, 29 Sep 2022 14:19:06 +0300 (EEST)
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
In-Reply-To: <AS8PR04MB84044F397918A3475B5D8D1D92579@AS8PR04MB8404.eurprd04.prod.outlook.com>
Message-ID: <39c68295-947-2353-d9b-3bd654c38c7@linux.intel.com>
References: <20220929085318.5268-1-sherry.sun@nxp.com> <1265873d-28f9-d39c-5cce-858dbed1e8e8@linux.intel.com> <AS8PR04MB84044F397918A3475B5D8D1D92579@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022, Sherry Sun wrote:

> > > This reverts commit 60f361722ad2ae5ee667d0b0545d40c42f754daf.
> > >
> > > commit 60f361722ad2 ("serial: fsl_lpuart: Reset prior to
> > > registration") causes the lpuart console cannot work any more. Since
> > > the console is registered in the uart_add_one_port(), the driver
> > > cannot identify the console port before call uart_add_one_port(),
> > > which causes all the uart ports including the console port will be global
> > reset.
> > > So need to revert this patch to avoid breaking the lpuart console.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  drivers/tty/serial/fsl_lpuart.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > b/drivers/tty/serial/fsl_lpuart.c index 67fa113f77d4..7da46557fcb3
> > > 100644
> > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > @@ -2722,10 +2722,6 @@ static int lpuart_probe(struct platform_device
> > *pdev)
> > >  		handler = lpuart_int;
> > >  	}
> > >
> > > -	ret = lpuart_global_reset(sport);
> > > -	if (ret)
> > > -		goto failed_reset;
> > > -
> > 
> > So the problem with this being so early is uart_console() in
> > lpuart_global_reset() that doesn't detect a console because sport->cons is
> > not yet assigned? Couldn't that be worked around differently?
> > 
> > Or is there something else in addition to that I'm missing?
> > 
> Hi Ilpo,
> 
> Yes, the root cause of the console cannot work after apply the commit 
> 60f361722ad2 ("serial: fsl_lpuart: Reset prior to registration") is 
> lpuart_global_reset() cannot identify the console port, so reset all 
> uart ports. 

This didn't answer my question. Is the main cause just lacking the ->cons
from sport at this point which, I guess, could be just assigned from 
lpuart_reg similar to what uart_add_one_port() does before calling to 
reset?

-- 
 i.

> Actually I've been thinking about any other workaround all afternoon, 
 seems no other good options to me till now. And after a further check, I 
 think the original patch is not needed, as uart_add_one_port() won't open 
 the tty device, it should be safe to global reset the non-console ports 
 after uart_add_one_port().
> 
> Best Regards
> Sherry
> 

