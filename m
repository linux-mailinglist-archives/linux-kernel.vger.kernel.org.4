Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA565D6CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjADPDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjADPDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:03:06 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB868A466
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 07:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1672844561; bh=Gxx8p8mpsg9J44j8zqgcHN1uUXlyWdyKyrs6bhfzWxk=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=nCKXozbQ901kZvOchjH1D10FPAwM2IqGb1fn/ViN2k6hDV7thbPOMh5+U6HXTJeYt
         utDnNsTZQ1VxPgBpobrmh1MM4nU76m2Juy1w532D2O+D2UqfJuf2lGn7u7AJWNKrc3
         LII0El9YhNLXA3D4jg80tp7lrgOs1MusTJa+oTqY=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed,  4 Jan 2023 16:02:41 +0100 (CET)
X-EA-Auth: ns1gYKoffHkdcXKgpzCMeK7t42qdBucUa46mVRkBNVeaeO+9qZ2eFPZ/rjcUQzgTjV+E5JIKm/U0moGyItmS6KukCk/RJckR
Date:   Wed, 4 Jan 2023 20:32:35 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Alex Elder <elder@ieee.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] staging: greybus: Replace zero-length array by
 DECLARE_FLEX_ARRAY() helper
Message-ID: <Y7WVC1mpIWdoi+IS@qemulion>
References: <Y7T5MYfANf2xVsEx@qemulion>
 <f943d3ca-7cf7-cb4d-5dc7-1e45015ba213@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f943d3ca-7cf7-cb4d-5dc7-1e45015ba213@ieee.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 07:33:57AM -0600, Alex Elder wrote:
> On 1/3/23 9:57 PM, Deepak R Varma wrote:
> > The code currently uses C90 standard extension based zero length array
> > struct which is now deprecated and the new C99 standard extension of
> > flexible array declarations are to be used instead. Also, the macro
> > DECLARE_FLEX_ARRAY() allows to use single flexible array member in a
> > structure. Refer to these links [1], [2] for details.
>
> Thank you for citing some references in your commit, it's
> a good and helpful practice.  This might have been another
> helpful one:
>
> https://lore.kernel.org/lkml/20210827163015.3141722-2-keescook@chromium.org/

Hello Alex,
Thank you so much for the feedback. I will include the additional reference and
send in a v2.

>
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://lkml.kernel.org/r/YxKY6O2hmdwNh8r8@work
>
> FYI, Linux mailing lists hosted by kernel.org are normally
> cited using "lore.kernel.org" now, e.g.:
>   https://lore.kernel.org/lkml/YxKY6O2hmdwNh8r8@work
> Your patch is fine, this is just so you can consider this
> in the future.

Sure, I will. This is very helpful to know.

>
> > Issue identified using Coccinelle flexible_array.cocci semantic patch.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
>
> Looks good to me.

Appreciate your time for the review and comments. I will include the reviewed by
tag in my v2.

Regards,
./drv

>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
> > ---
> >   drivers/staging/greybus/usb.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
> > index 8e9d9d59a357..b7badf87a3f0 100644
> > --- a/drivers/staging/greybus/usb.c
> > +++ b/drivers/staging/greybus/usb.c
> > @@ -27,7 +27,7 @@ struct gb_usb_hub_control_request {
> >   };
> >
> >   struct gb_usb_hub_control_response {
> > -	u8 buf[0];
> > +	DECLARE_FLEX_ARRAY(u8, buf);
> >   };
> >
> >   struct gb_usb_device {
> > --
> > 2.34.1
> >
> >
> >
>


