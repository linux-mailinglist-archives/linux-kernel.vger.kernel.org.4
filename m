Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E596124B1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 19:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJ2Ref (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 13:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJ2Reb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 13:34:31 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FF3D7C;
        Sat, 29 Oct 2022 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gqjvVIWAB0oapWcgghjNtAYXtMW4JBKKZXBEyHZ/CnE=;
  b=l5V0nP+O7hU5hocOYpeD0hGW0G01Hp0ITBxLWz/jXZGP0vl66HLcSeq/
   lADTEbu9fFNdM6JmRB5DxbVU7xh58uzpVi060pXs/a6dllgemJ8tOEJvj
   tXNmDh3uHrXMrBuMDdxFEPnPInbNzXIjzlOkrvkJewAWCnqA+o6Bp0cS1
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,224,1661810400"; 
   d="scan'208";a="72171888"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 19:34:26 +0200
Date:   Sat, 29 Oct 2022 19:34:26 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deepak R Varma <drv@mailo.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Use ARRAY_SIZE() to get argument count
In-Reply-To: <Y11b0oCmle2pbRel@ubunlion>
Message-ID: <alpine.DEB.2.22.394.2210291931590.2917@hadrien>
References: <Y1vZXUi0Bjiub8HZ@ubunlion> <Y1zXIjCe3LGwApWD@kroah.com> <Y11b0oCmle2pbRel@ubunlion>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Oct 2022, Deepak R Varma wrote:

> On Sat, Oct 29, 2022 at 09:32:50AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Oct 28, 2022 at 07:00:05PM +0530, Deepak R Varma wrote:
> > > The ARRAY_SIZE(foo) macro should be preferred over sizeof operator
> > > based computation such as sizeof(foo)/sizeof(foo[0]) for finding
> > > number of elements in an array. Issue identified using coccicheck.
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > >  drivers/staging/fbtft/fbtft.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
> > > index 2c2b5f1c1df3..5506a473be91 100644
> > > --- a/drivers/staging/fbtft/fbtft.h
> > > +++ b/drivers/staging/fbtft/fbtft.h
> > > @@ -231,7 +231,7 @@ struct fbtft_par {
> > >  	bool polarity;
> > >  };
> > >
> > > -#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
> > > +#define NUMARGS(...)  ARRAY_SIZE(((int[]){ __VA_ARGS__ }))
> >
> > Please please please test-build your patches before sending them out.
> > To not do so just wastes reviewer resources :(
>
> Hello Greg,
> I did build the .ko files by making the driver/staging/fbtft/ path. I verified
> .o and .ko files were built.
>
> I did a make clean just now and was again able to rebuild without any errors.
> Please see the attached log file.
>
> Is there something wrong with the way I am firing the build?

The change is in the definition of a macro.  The compiler won't help you
in this case unless the macro is actually used in code that is compiled.
Find the uses and check for any nearby ifdefs.  For file foo.c you can
also do make foo.i to see the result of reducing ifdef and expanding
macros.  Then you can see if the code you changed is actually included in
the build.

julia
