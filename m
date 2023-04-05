Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20946D83F6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjDEQo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjDEQow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:44:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C1E10FA;
        Wed,  5 Apr 2023 09:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 438006263A;
        Wed,  5 Apr 2023 16:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8678C433D2;
        Wed,  5 Apr 2023 16:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680713090;
        bh=m/iAEV0ikYlqTgKl+JEswqP5UlbqIZYlrv78hBvG1fw=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=WV0lzHWRtTaZI8sRbOQCjT6qzICyIJuI7OudtRYvEqIXoUaAJvmM74tkspJHJoMqA
         1AYBZu+E9L/XylTww+H5Yed72/2SVlcjlatxFVWGKXFnEDcnsyhDYw1x8LNa8J0YK4
         fPTUS9b2DT1rrHgweZbSJ/D/zdS11ammmmqm0jwcUOZ6oiLkD2HIv6w1BKNlTQQ7GO
         dTfANG3k+3D4v61RROf/abK3LBJL1g8cmJcomwITvOldI9PPjkAuLfJtGRQmxk+1FT
         +rqYw/ylo5Scs7KkXADes7zZFGgSZ8UGq+4bQ/iF5JamrC2599poQbtsuq5reW5jo5
         eOHNkkszcHG3Q==
Received: by mail-ed1-f52.google.com with SMTP id eh3so142580326edb.11;
        Wed, 05 Apr 2023 09:44:50 -0700 (PDT)
X-Gm-Message-State: AAQBX9fSh1W3TybJg8jX/2+T5wFL5fhTfvCE+UydHttwSrOHu3azuStD
        FfoBz3/Cj2Lv0y/Ezw4/pVxmU6LEQvT3oPvllcU=
X-Google-Smtp-Source: AKy350YhHVNlM9NlxEoGRGdWg9VZMOKaU0pTCqe6SN6WzX7x8l7ccLpcwDdFDb4I98F0QDUjQfwIw7c/3FPLYCd+os8=
X-Received: by 2002:a17:907:8a07:b0:924:32b2:e3d1 with SMTP id
 sc7-20020a1709078a0700b0092432b2e3d1mr1968732ejc.3.1680713088788; Wed, 05 Apr
 2023 09:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220520171134.31415-1-eajames@linux.ibm.com> <bc6564dc-3bfd-298b-43a8-b5a629f4631f@linux.ibm.com>
In-Reply-To: <bc6564dc-3bfd-298b-43a8-b5a629f4631f@linux.ibm.com>
Reply-To: lee@kernel.org
From:   Lee Jones <lee@kernel.org>
Date:   Wed, 5 Apr 2023 17:44:37 +0100
X-Gmail-Original-Message-ID: <CAPxw_W_10Z173z+s4DYDc6A1raVff2B8EhOWxg9AVgoqj-eS+A@mail.gmail.com>
Message-ID: <CAPxw_W_10Z173z+s4DYDc6A1raVff2B8EhOWxg9AVgoqj-eS+A@mail.gmail.com>
Subject: Re: [PATCH] leds: Ensure hardware blinking turns off when requested
To:     Eddie James <eajames@linux.ibm.com>
Cc:     pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for any chaos this may cause, I'm replying from Gmail since
this doesn't appear to be in my inbox.

On Wed, 5 Apr 2023 at 17:26, Eddie James <eajames@linux.ibm.com> wrote:
>
>
> On 5/20/22 12:11, Eddie James wrote:
> > If an LED is blinking through the hardware and the trigger is deactivated,
> > the driver will set the brightness to 0 to disable blinking. However, if
> > the LED driver doesn't support non-blocking operations, the request for
> > setting brightness to 0 will get queued. Then if a user requests a new
> > non-zero brightness before the request for 0 brightness is executed, the
> > LED blinking will not get disabled since the brightness will simply be
> > updated.
> > Fix this by flushing the workqueue before updating the requested
> > brightness.
>
>
> I just realized this never made it anywhere. Pavel, any thoughts?

Submit a [RESEND] please.

Also, please ensure you re-run get_maintainer.pl before doing so.

> > Fixes: 4d71a4a12b13 ("leds: Add support for setting brightness in a synchronous way")
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > ---
> >   drivers/leds/led-class.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> > index 6a8ea94834fa..861a1cb5df5b 100644
> > --- a/drivers/leds/led-class.c
> > +++ b/drivers/leds/led-class.c
> > @@ -55,6 +55,8 @@ static ssize_t brightness_store(struct device *dev,
> >
> >       if (state == LED_OFF)
> >               led_trigger_remove(led_cdev);
> > +     /* flush out any request to disable blinking */
> > +     flush_work(&led_cdev->set_brightness_work);
> >       led_set_brightness(led_cdev, state);
> >       flush_work(&led_cdev->set_brightness_work);
> >
