Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8399E6132EA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJaJky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJaJkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:40:51 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D40AC76C;
        Mon, 31 Oct 2022 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667209231; bh=a+WIKnAu+RfBS8xAhnVFlou+k5sPVUzbUASFir5UywE=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=J7YIHtucgVQs5XeLE3fSzmebQwMd8kG6DGIl9rmq7sn2M2iDrc19+nmrDu+XICLcR
         vkXaUFI1j6kjEuy+hHZ6uS52c5bK8pw1y99axzVfrxl1mFhy/+9G6kfyNGzwCokGO4
         caD4WhkrggM9CzT3IFUv5iPOXGg8mSs8QyKXgqtU=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Mon, 31 Oct 2022 10:40:31 +0100 (CET)
X-EA-Auth: lAZr++KF+w2MI+M5dywmZDcNBi/iIf9moMfunGMLSjl93wm+/oWRBqiQq+UbqyamMAImkSTlHW5vtcAUZmY1a3CI3ZtFIbPW
Date:   Mon, 31 Oct 2022 15:10:27 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Use ARRAY_SIZE() to get argument count
Message-ID: <Y1+YC5OuycA5hLFx@ubunlion>
References: <Y1vZXUi0Bjiub8HZ@ubunlion>
 <Y1zXIjCe3LGwApWD@kroah.com>
 <Y11b0oCmle2pbRel@ubunlion>
 <alpine.DEB.2.22.394.2210291931590.2917@hadrien>
 <Y191LI7zKVRA5LEb@ubunlion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y191LI7zKVRA5LEb@ubunlion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 12:41:40PM +0530, Deepak Varma wrote:
> On Sat, Oct 29, 2022 at 07:34:26PM +0200, Julia Lawall wrote:
> >
> >
> > On Sat, 29 Oct 2022, Deepak R Varma wrote:
> >
> > > On Sat, Oct 29, 2022 at 09:32:50AM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, Oct 28, 2022 at 07:00:05PM +0530, Deepak R Varma wrote:
> > > > > The ARRAY_SIZE(foo) macro should be preferred over sizeof operator
> > > > > based computation such as sizeof(foo)/sizeof(foo[0]) for finding
> > > > > number of elements in an array. Issue identified using coccicheck.
> > > > >
> > > > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > > > ---
> > > > >  drivers/staging/fbtft/fbtft.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
> > > > > index 2c2b5f1c1df3..5506a473be91 100644
> > > > > --- a/drivers/staging/fbtft/fbtft.h
> > > > > +++ b/drivers/staging/fbtft/fbtft.h
> > > > > @@ -231,7 +231,7 @@ struct fbtft_par {
> > > > >  	bool polarity;
> > > > >  };
> > > > >
> > > > > -#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
> > > > > +#define NUMARGS(...)  ARRAY_SIZE(((int[]){ __VA_ARGS__ }))
> > > >
> > > > Please please please test-build your patches before sending them out.
> > > > To not do so just wastes reviewer resources :(
> > >
> > > Hello Greg,
> > > I did build the .ko files by making the driver/staging/fbtft/ path. I verified
> > > .o and .ko files were built.
> > >
> > > I did a make clean just now and was again able to rebuild without any errors.
> > > Please see the attached log file.
> > >
> > > Is there something wrong with the way I am firing the build?
> >
> > The change is in the definition of a macro.  The compiler won't help you
> > in this case unless the macro is actually used in code that is compiled.
> > Find the uses and check for any nearby ifdefs.  For file foo.c you can
> > also do make foo.i to see the result of reducing ifdef and expanding
> > macros.  Then you can see if the code you changed is actually included in
> > the build.
>
> Okay. This is helpful. I understand. Looking into the file where the macro
> expansion is reported to be failed.

Hi Julia,
I could see the macro expansions in the .i files for the fbtft-core.c and
fb_hx8353d.c file. I am not sure why it built successfully on my x86 though. The
error in Kerbel bot seems to be specific to ARM arch. I will try that later
today. I am on the right track to the build error triage?

Also, while reviewing the macro expansion, I saw change in the computation that
seems odd to me. In the denominator of the expanded macro, there is a "+
((int)...." computation that I am not sure if is result of ARRAY_SIZE. I have
attached the old anf the new .i file diff for your review. If you get a change
could you help me understand why this additional computation is added to the
denominator?

Thank you,
./drv
>
> Thank you,
> ./drv
>
> >
> > julia
> >
>
>
>


