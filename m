Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76AC6B164E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjCHXNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCHXMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:12:49 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED16A2F6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:12:41 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z11so337192pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678317160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nYgUfU5eUuS244oNJIEgy02v0P9DMsR50rggjkoPoJQ=;
        b=V+OpMeSSrLWwiixcwV41uEs2XW1WHel6ThlTfqxqcxxAeT6b2BtMilA69I0nqGK8OR
         ILY/pl5y1QuabBjU0pgPUXSgtZTvt1UqV6J/GDOFjjCoA1gJYoUd4tSQoXTdmBvHWj3M
         q+2YHxaj8jJVs4XmX5beRPpw6QZ7rVhbVkQGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678317160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYgUfU5eUuS244oNJIEgy02v0P9DMsR50rggjkoPoJQ=;
        b=Q35kqGtGM5HfZPVz+nOjMI0s5v8kL+XDLMlCPWPkQ5r/uD3fRGEU7cRR2+h3GCXEGy
         A/ZtwvMqpZ9zR/VgMDwZsPHLEZRr+Eee034lckGeSizzzFlxkugihPBeXfOlCM+oDcMH
         +gLa4KDyX4iECvsxh0oXLtQy4G9Kyw6/gujq7fKMZkFPwby7VQ7/zLzEaqtLYrvYRBsW
         OXYzVk6mbdiK1qlvUkimKOu3MVnybm0pe6eFWcq9KzMT4SK8aOL/wwmwZPiITl/MvWrH
         HU9ljG4g2Eqb+z+v/s/l23WTnH124PDnjIy/ZAv/sVNho+XhirvprJAexsnw71iNxSEs
         cKRg==
X-Gm-Message-State: AO0yUKUFcu0acETHVGBCN9Im44DOdm6PI5cEkBfxPlcS8kRzOeiRZcvz
        acL3qWCBq2NU6uEnHOtv9is8ByynLzcd7l3zmfz+Uw==
X-Google-Smtp-Source: AK7set8HLYU9etiH2bLNDPQ71cQWIwY3IsBjBkqN8vKHuqBY2H13Y8giPQANChIE1uE18+ObwyPjnA==
X-Received: by 2002:a62:170e:0:b0:5dc:6dec:e992 with SMTP id 14-20020a62170e000000b005dc6dece992mr15832467pfx.1.1678317159887;
        Wed, 08 Mar 2023 15:12:39 -0800 (PST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id g5-20020aa78745000000b0058a3d8eab6asm9871591pfo.134.2023.03.08.15.12.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 15:12:39 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id i10so117126plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:12:39 -0800 (PST)
X-Received: by 2002:a17:903:26d6:b0:19b:fe3:c948 with SMTP id
 jg22-20020a17090326d600b0019b0fe3c948mr7460103plb.12.1678317158600; Wed, 08
 Mar 2023 15:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20221101-instal-v1-0-d13d1331c4b5@chromium.org>
 <Y6z55cXTt5yXjIZj@pendragon.ideasonboard.com> <CANiDSCvbQ7uMgoxDsXDOphjANNZ2EuoV-Dra+wtT9LLL6USstQ@mail.gmail.com>
 <CANiDSCveK6QRbYM==XN9jggy8DHfS3QJawDWpFLy0jcmmHeduA@mail.gmail.com> <1298c83f-695a-4356-aa2e-22b0e6629610@rowland.harvard.edu>
In-Reply-To: <1298c83f-695a-4356-aa2e-22b0e6629610@rowland.harvard.edu>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 9 Mar 2023 00:12:27 +0100
X-Gmail-Original-Message-ID: <CANiDSCtfPO+O=uLTAAiLDrmvcRigi1weAih_+et5iwFy5Joamw@mail.gmail.com>
Message-ID: <CANiDSCtfPO+O=uLTAAiLDrmvcRigi1weAih_+et5iwFy5Joamw@mail.gmail.com>
Subject: Re: [PATCH RESEND] media: uvcvideo: Disable autosuspend for Insta360 Link
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yunke Cao <yunkec@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan

On Thu, 9 Mar 2023 at 00:02, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Mar 08, 2023 at 11:43:09PM +0100, Ricardo Ribalda wrote:
> > On Wed, 1 Mar 2023 at 10:04, Ricardo Ribalda <ribalda@chromium.org> wrote:
> > >
> > > Hi Laurent
> > >
> > > We are back to this issue.
> > >
> > >
> > > On Thu, 29 Dec 2022 at 03:22, Laurent Pinchart
> > > <laurent.pinchart@ideasonboard.com> wrote:
> > > >
> > > > Hi Ricardo,
> > > >
> > > > Thank you for the patch.
> > > >
> > > > On Fri, Dec 02, 2022 at 05:48:52PM +0100, Ricardo Ribalda wrote:
> > > > > When the device suspends, it keeps power-cycling.
> > > > >
> > > > > The user notices it because the LED constanct oscillate between
> > > > > blue (ready) and no LED (off).
>
> > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > ---
> > > > > media: uvcvideo: Disable autosuspend for Insta360
> > > > >
> > > > > The device does not handle properly the USB suspend and makes it barely usable.
> > > >
> > > > Isn't this best handled with a quirk in the USB core ? Autosuspend is a
> > > > device feature, not an interface feature, so if the USB sound driver is
> > > > loaded but uvcvideo isn't, the kernel may still attempt to autosuspend
> > > > the device.
> > > >
> > >
> > > Seems like USB_QUIRK_NO_AUTOSUSPEND was gone for a long time
> > >
> > > https://lore.kernel.org/lkml/20071115064457.GU19218@kroah.com/
> > >
> > > under the assumption that autosuspend was off by default and user
> > > space should only enable autosuspend on the devices that support it
> > > (if I understand it correctly).
> > >
> > > There are two other quirks still available: USB_QUIRK_RESET_RESUME and
> > > USB_QUIRK_DISCONNECT_SUSPEND, but they do not seem to work for this
> > > device (Yunke, thanks for looking into this)
> > >
> > > If we are explicitly enabling autosuspend on the driver, shouldn't we
> > > make sure that the device supports it?
> > >
> >
> > Alan, Greg, any idea about what is the best way to proceed here from a
> > USB perspective?
>
> How is autosuspend getting enabled for this device?  It is disabled by
> default for non-hub USB devices.

It is enabled on the driver via usb_enable_autosuspend()
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_driver.c#n2211

>
> If the uvcvideo or USB sound driver is enabling autosuspend, the driver
> should be fixed.  Perhaps by adding a quirk bit for this purpose.

This is what I tried with this patch :). Laurent, could you please
take a second look to it?
Thanks!


>
> If userspace is enabling autosuspend, then any misbehavior isn't the
> kernel's fault.  :-)
>
> Alan Stern



-- 
Ricardo Ribalda
