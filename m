Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351706C92B3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 07:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCZFwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 01:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjCZFwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 01:52:13 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922335FD2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 22:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1dlb05qC1Np6VuLvDRnihXwqBP9eENNSLwWKReaC1EU=;
  b=QP12dvnzbU3TrxmksXnvsOEAUtebWmf66ldEk0EGiGuYMIBls/c7qdkc
   MyxwtXF2H3FyY/bogDxNlUpoGDp1p1iVIUb0A0DH4XzatlidDBkgOgT5j
   qMt43dIsvGh/r8J7akMT2AkI7CATJXq4OoMXo/JxK+c54BavMf0awjyoG
   Q=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,292,1673910000"; 
   d="scan'208";a="51262119"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 07:51:52 +0200
Date:   Sun, 26 Mar 2023 07:51:50 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumitra Sharma <sumitraartsy@gmail.com>
cc:     Greg KH <gregkh@linuxfoundation.org>, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] staging: greybus: Inline
 pwm_chip_to_gb_pwm_chip()
In-Reply-To: <20230326052420.GA179105@sumitra.com>
Message-ID: <alpine.DEB.2.22.394.2303260751290.3294@hadrien>
References: <cover.1679732179.git.sumitraartsy@gmail.com> <f1ef1b643840e74f211264dda0c590f8458618f6.1679732179.git.sumitraartsy@gmail.com> <ZB63EVLK6/29UUi0@kroah.com> <20230326052420.GA179105@sumitra.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Mar 2023, Sumitra Sharma wrote:

> On Sat, Mar 25, 2023 at 09:55:45AM +0100, Greg KH wrote:
> > On Sat, Mar 25, 2023 at 01:31:10AM -0700, Sumitra Sharma wrote:
> > > Convert 'pwm_chip_to_gb_pwm_chip' from a macro to a static
> > > inline function, to make the relevant types apparent in the
> > > definition and to benefit from the type checking performed by
> > > the compiler at call sites.
> > >
> > > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > > ---
> > >  drivers/staging/greybus/pwm.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
> > > index 3fda172239d2..88da1d796f13 100644
> > > --- a/drivers/staging/greybus/pwm.c
> > > +++ b/drivers/staging/greybus/pwm.c
> > > @@ -21,9 +21,11 @@ struct gb_pwm_chip {
> > >  	struct pwm_chip		chip;
> > >  	struct pwm_chip		*pwm;
> > >  };
> > > -#define pwm_chip_to_gb_pwm_chip(chip) \
> > > -	container_of(chip, struct gb_pwm_chip, chip)
> > >
> > > +static inline struct gb_pwm_chip *pwm_chip_to_gb_pwm_chip(struct pwm_chip *chip)
> > > +{
> > > +	return container_of(chip, struct gb_pwm_chip, chip);
> > > +}
> > >
> > >  static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
> > >  {
> > > --
> > > 2.25.1
> > >
> > >
> >
> > This patch didn't apply due to changes made in my tree by a patch from
> > someone else before yours.  Can you rebase it and resend?
> >
>
> Hi greg,
>
> I am confused, will that be a totally new patch or a new version(v4 in
> this case)?

New version.

julia

>
> Regards,
>
> Sumitra
>
> > thanks,
> >
> > greg k-h
>
>
