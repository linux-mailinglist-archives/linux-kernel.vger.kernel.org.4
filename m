Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5EE5B3E8F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiIISHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiIISHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FE5E3D66;
        Fri,  9 Sep 2022 11:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8565620AA;
        Fri,  9 Sep 2022 18:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65F3C433D6;
        Fri,  9 Sep 2022 18:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662746866;
        bh=+u+FJQpP4ebPfFxqZGhMD/vKMxEpCxpDdfM0kbOkIaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtlSBokxiXQaXlqPfFUFfyBM2kMuS3cEWySA/IUN7UtFANjU+1sK8WuznVyc+gWtM
         MfC5/vBfoOr6IGVmnKwbhY2y73V1GOR/vBhNkjtfoBir0nma+i81m510PuwdVFyzEa
         2r6cEeXLyeCaRmi0/kXjDbtyouQBrFurbvThVTCo=
Date:   Fri, 9 Sep 2022 20:07:43 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: rndis: Avoid dereference before NULL check
Message-ID: <YxuA7yTtUmYdDD9A@kroah.com>
References: <20220908175615.5095-1-jilin@nvidia.com>
 <YxrRPxeh/iCeCW4R@kroah.com>
 <4242e47a94bf7ffe989ca2c6ed48e862ce3b3013.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4242e47a94bf7ffe989ca2c6ed48e862ce3b3013.camel@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:43:14PM +0000, Jim Lin wrote:
> On Fri, 2022-09-09 at 07:38 +0200, Greg KH wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Fri, Sep 09, 2022 at 01:56:15AM +0800, Jim Lin wrote:
> > > NULL check is performed after params->dev is dereferenced in
> > > dev_get_stats.
> > 
> > I do not understand this statement.
> > 
> > > Fixed by adding a NULL check before dereferencing params->dev and
> > > removing subsequent NULL checks for it.
> > > 
> > > Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> > > Signed-off-by: Jim Lin <jilin@nvidia.com>
> > > ---
> > >  drivers/usb/gadget/function/rndis.c | 37 ++++++++++++-------------
> > > ----
> > >  1 file changed, 15 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/function/rndis.c
> > > b/drivers/usb/gadget/function/rndis.c
> > > index 64de9f1b874c..d2f18f34c8e5 100644
> > > --- a/drivers/usb/gadget/function/rndis.c
> > > +++ b/drivers/usb/gadget/function/rndis.c
> > > @@ -198,6 +198,9 @@ static int gen_ndis_query_resp(struct
> > > rndis_params *params, u32 OID, u8 *buf,
> > >       outbuf = (__le32 *)&resp[1];
> > >       resp->InformationBufferOffset = cpu_to_le32(16);
> > > 
> > > +     if (!params->dev)
> > > +             return -ENODEV;
> > > +
> > 
> > As Sergey points out, this check is useless and the ones below should
> > also be removed.
> > 
> > But, why make this check at all, how did you trigger a problem with
> > the
> > current code?
> > 
> > Are you using this driver?  If so, why?  It is totally broken (as per
> > the specification) and we really really need to just delete it from
> > the
> > tree to prevent anyone else from ever using it.
> > 
> > thanks,
> > 
> > greg k-h
> Thanks for review, please ignore this patch.
> Issue was triggered by our internal tool (probably not smart enough,
> and cause false alarm).

Ah, so that means I HAVE to reject it as you did not properly follow the
requirements when you use tools like this.  Please read
Documentation/process/researcher-guidelines.rst for how to do this
properly.

That is now a requirement to make it so that we are not the ones doing
the debugging of random tools like we just had to do here...

You owe me 3 patch reviews now :)

thanks,

greg k-h
