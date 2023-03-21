Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C2D6C3CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCUVaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCUVaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:30:08 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186C8F979
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6cymCq67neIvjclKAQVSM89ndPJUvh28PAk/YB/rfjw=;
  b=NFw1sv41L1xnnreazv7MPu80BpOVRHu9WK2Gyo2APJjw7PcQfshkXoAa
   iOzUsep2ULzZ+Y4qOox61+0luC8Wf3mSKgcYSnaAhd0OlbWjIxZGwAWKz
   m4myrltdbGVbC1vegXHFEMLZQtEMvnIGosBaIJqvqm9r+4ZW/zndeSOe3
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,279,1673910000"; 
   d="scan'208";a="50856107"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 22:29:25 +0100
Date:   Tue, 21 Mar 2023 22:29:25 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Alex Elder <elder@ieee.org>
cc:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: greybus: use inline function for macros
In-Reply-To: <5efa6e6d-8573-31de-639a-d15b2e9deca0@ieee.org>
Message-ID: <alpine.DEB.2.22.394.2303212218500.2919@hadrien>
References: <20230321183456.10385-1-eng.mennamahmoud.mm@gmail.com> <2e869677-2693-6419-ea25-f0cc2efcf3dd@ieee.org> <alpine.DEB.2.22.394.2303212140480.2919@hadrien> <5efa6e6d-8573-31de-639a-d15b2e9deca0@ieee.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2023, Alex Elder wrote:

> On 3/21/23 3:43 PM, Julia Lawall wrote:
> >
> >
> > On Tue, 21 Mar 2023, Alex Elder wrote:
> >
> > > On 3/21/23 1:34 PM, Menna Mahmoud wrote:
> > > > Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> > > > static inline function.
> > > >
> > > > It is not great to have macros that use the `container_of` macro,
> > > > because from looking at the definition one cannot tell what type
> > > > it applies to.
> > > >
> > > > One can get the same benefit from an efficiency point of view
> > > > by making an inline function.
> > > >
> > > > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > > Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> > >
> > > I'm sorry if this conflicts with what others have said.
> > >
> > > But the use of a macro (with a container_of() right-hand
> > > side) to get at the structure containing a field pointer
> > > is a widely-used idiom throughout the kernel.
> > >
> > > What you propose achieves the same result but I would
> > > lean toward keeping it as a macro, mainly because it
> > > is so common.
> >
> > Common is not necessarily good.  Macros are less safe and less
> > informative.
>
> I do agree that the inline function is better, and
> is functionally equivalent (while being explicit
> with types and avoiding any macro expansion funny
> business).
>
> Do you think we should make changes like this throughout
> the kernel (along the lines of the flexible array fixes,
> to make things safer)?  I don't think it's a terrible idea,
> but it's likely a big undertaking and I predict push-back.

I agree that it's not a terrible idea and that it's a big undertaking.
The code would be a little safer if people had the habit of making
functions, as it avoids the risk of parameterizing over the field name in
the third argument.  But the impact is probably lesser than for the
flexible array fixes.  But if we have the chance to clean up the staging
code, at least, then why not.

There do seem to be more than 100 definitions like:

#define to_dove_clk(hw) container_of(hw, struct dove_clk, hw)

where we have to hope that at all of the usage sites the argument is
called hw.  Probably anything else would cause a compiler error, but still
it looks strange.

julia

>
> Bottom line on this is that I don't think the proposed
> change is wrong, but there is value in consistently
> adhering to conventions.
>
> Others can comment; I have no real objection.
>
> 					-Alex
>
> >
> > julia
> >
> >
> > >
> > > 					-Alex
> > > > ---
> > > > changes in v2:
> > > > 	-send patch as a single patch.
> > > > 	-edit the name of struct object.
> > > > 	-edit commit message.
> > > > ---
> > > >    drivers/staging/greybus/gbphy.h | 10 ++++++++--
> > > >    1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/greybus/gbphy.h
> > > > b/drivers/staging/greybus/gbphy.h
> > > > index d4a225b76338..e7ba232bada1 100644
> > > > --- a/drivers/staging/greybus/gbphy.h
> > > > +++ b/drivers/staging/greybus/gbphy.h
> > > > @@ -15,7 +15,10 @@ struct gbphy_device {
> > > >    	struct list_head list;
> > > >    	struct device dev;
> > > >    };
> > > > -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> > > > +static inline struct gbphy_device *to_gbphy_dev(const struct device
> > > > *_dev)
> > > > +{
> > > > +	return container_of(_dev, struct gbphy_device, dev);
> > > > +}
> > > >      static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
> > > >    {
> > > > @@ -43,7 +46,10 @@ struct gbphy_driver {
> > > >      	struct device_driver driver;
> > > >    };
> > > > -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
> > > > +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver
> > > > *drv)
> > > > +{
> > > > +	return container_of(drv, struct gbphy_driver, driver);
> > > > +}
> > > >      int gb_gbphy_register_driver(struct gbphy_driver *driver,
> > > >    			     struct module *owner, const char
> > > > *mod_name);
> > >
> > >
>
>
