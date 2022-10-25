Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F088760C591
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiJYHmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJYHmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:42:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA25125006;
        Tue, 25 Oct 2022 00:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4B41617AE;
        Tue, 25 Oct 2022 07:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D72C433C1;
        Tue, 25 Oct 2022 07:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666683739;
        bh=zxG5HvFqvSy/jj2wpG+6bL8WmIEHT5MAz/zH7+6erTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eXx/kyVDR12odMvbC16zp2HK7cndAMplDsjGUTK7pW3MMfI1vNOqSMg5L9AG1bvjK
         /15cQrJHaBpniMZoBaSLWq5pXv6GwozpZaxcJjfF9mQxYIOKaoiD8dOP7h0kHA7Kjo
         Ylvma8OiLqgLAgnRz9b+0WHtnLLfdbWnahnyB/QM=
Date:   Tue, 25 Oct 2022 09:43:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: fwnode: fix fwnode_irq_get_byname() kerneldoc
Message-ID: <Y1eTj2v1cioIMwsV@kroah.com>
References: <Y1dzCCMCDswQFVvO@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
 <Y1eGwtqbOhXCGoaM@paasikivi.fi.intel.com>
 <cd6eb645-4663-40a6-c238-7c82123db1a4@gmail.com>
 <CANhJrGPzg9-14OhscgCv6P_9kUG8Nx3mZLEq41aSJ45qh6eaKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANhJrGPzg9-14OhscgCv6P_9kUG8Nx3mZLEq41aSJ45qh6eaKg@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:17:21AM +0300, Matti Vaittinen wrote:
> ti 25. lokak. 2022 klo 10.06 Matti Vaittinen
> (mazziesaccount@gmail.com) kirjoitti:
> >
> > Hi Sakari,
> >
> > On 10/25/22 09:48, Sakari Ailus wrote:
> > > Moi,
> > >
> > > On Tue, Oct 25, 2022 at 08:24:24AM +0300, Matti Vaittinen wrote:
> > >> The fwnode_irq_get_byname() may return zero on device-tree mapping
> > >> error. Fix documentation to reflect this as current documentation
> > >> suggests check:
> > >>
> > >> if (ret < 0)
> > >> is enough to detect the errors. This is not the case.
> > >>
> > >> Add zero as a return value indicating error.
> > >>
> > >> Fixes: ca0acb511c21 ("device property: Add fwnode_irq_get_byname")
> > >> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > >> ---
> > >>   drivers/base/property.c | 2 +-
> > >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/base/property.c b/drivers/base/property.c
> > >> index 4d6278a84868..df437d10aa08 100644
> > >> --- a/drivers/base/property.c
> > >> +++ b/drivers/base/property.c
> > >> @@ -960,7 +960,7 @@ EXPORT_SYMBOL(fwnode_irq_get);
> > >>    * string.
> > >>    *
> > >>    * Return:
> > >> - * Linux IRQ number on success, or negative errno otherwise.
> > >> + * Linux IRQ number on success, zero or negative errno otherwise.
> > >
> > > I wonder if it would be possible instead to always return a negative error
> > > code on error. Returning zero on error is really unconventional and can be
> > > expected to be a source of bugs.
> >
> > Agree, and I did also consider just adding:
> >
> > if (!ret)
> >         return -EINVAL; (or another feasible errno)
> >
> > return ret;
> >
> > at the end of the fwnode_irq_get_byname().
> >
> > However, such a functional change would require auditing the existing
> > callers which I have no time right now.
> 
> Oh. I just did grep the callers. It seems to me that there are only a
> handful of callers in 6.1-rc2. Auditing those does not seem like a big
> task after all. So I guess I can check them if changing the return
> value is preferred.

Yes, please do so.

thanks,

greg k-h
