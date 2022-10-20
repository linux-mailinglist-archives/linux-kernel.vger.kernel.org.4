Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192016069DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJTUtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJTUtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:49:05 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C05220FAA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:48:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j4so1726116lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pde/YVIGQyAGr7I3iY/Mrwr8ImRplZawt3v7070KQUw=;
        b=UBl+267Ybny7wRXre1ac+k1WGTFn7JQDcgSFN5FgR378L8w25uVkZ5ZQIDtsWaM6d1
         XjLP1ycnVBi4JfEkGHHlAkXqBa+l0/NM4e1L9NRwUpv/JIgrU2I8MOpIFjUPzunv7Jrp
         yG/H46qL2k+xwWUnr0ukHQvoYbVDDVuZCYPTo//c2zwG1zJpHQ1DhOuWRWwu0zsbLS3A
         xDA9uKmcKGM2MgAFDmMFVxWk9hvm3MOte+q5jhpN7MCx0cpl4Q2EUAQjPvFBIGD+O9nY
         QQQPbvk69/vuSnnEebhlmyEKfR59Pg+/4sjQQQ4SdFGPbBr6e31iY/DFjGCmuHHFRMOu
         is7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pde/YVIGQyAGr7I3iY/Mrwr8ImRplZawt3v7070KQUw=;
        b=HW0K/JOUUU3+zThSgHpb9yFhZxXypaVuuzOxBGNSJ5QseG1Irj96v6VUk+fmBFLDqf
         BYJO/1L1pQVbo1tSiP+ulKTCGfnofbfcvZ9NcKW9eDUduHpyXRNdoUMuYR8uThw/HGRI
         W8kWrnRpoFHyJPvuVpMAUTvrtv52QztmCetkAs47iHOkzsdQovLtjoS21m1VhqL9cFoA
         FHmeJiEBmR3g0n6zUFkShq4fqVtIEyGtDuE0YiOkERKo/vZVI2uGgkWnRyD3rxNNZvXv
         x2uWTA/f9oYp0w89mizye2laKtdNzU+131RBVjzO8Zar+ei//SSAT/zXZQwCWm3J/TxV
         Hlrg==
X-Gm-Message-State: ACrzQf1LZ6dLNM2ZmodRI4vc6uHme7L8JRIhh/RNdTOxTv3GUbHDJkm0
        e/tZ1CGHveuicZHGNQbzQ8QDlgqEXEyYWGJhLxT5Cw==
X-Google-Smtp-Source: AMsMyM40u6r9Yansmp6L3OnnzLd6/4SGJnpedp4RIWKn5XCb73f0u4+C0i9/YuWa2w2by9PvzvFZhAgl0nYpBCvFi7w=
X-Received: by 2002:ac2:5dc5:0:b0:4a6:3193:582 with SMTP id
 x5-20020ac25dc5000000b004a631930582mr1943975lfq.236.1666298919344; Thu, 20
 Oct 2022 13:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221020161401.941927-1-svv@google.com> <d2085225eb652a885b9c2b5700175ab820a35a35.camel@hadess.net>
In-Reply-To: <d2085225eb652a885b9c2b5700175ab820a35a35.camel@hadess.net>
From:   Siarhei Vishniakou <svv@google.com>
Date:   Thu, 20 Oct 2022 13:48:27 -0700
Message-ID: <CAKF84v2Ohcy2MH=0tjiMr6oHWtZd9r3mGF6Ve5MinkivSaudpA@mail.gmail.com>
Subject: Re: [PATCH] Add rumble support to latest xbox controllers
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Android Framework Input <android-framework-input@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bastien,

I prefer to keep the various names in the commit message, just so that
it's easier to find the commit later when searching for the patch.
I found that various teams refer to various controllers in a different way.
Happy to rename the variables in the code, though.

How about something like:
USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708
USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1708_FIRMWARE_2021
USB_DEVICE_ID_MS_XBOX_CONTROLLER_MODEL_1914
?

I tested this on an Android device, with a simple rumble test app that I wrote.
A better way would probably be to write some EV_FF events to
/dev/input/eventX node.
You could try the "python-evdev" module, which provides a sample rumble script:
https://python-evdev.readthedocs.io/en/latest/tutorial.html#injecting-an-ff-event-into-first-ff-capable-device-found
I haven't tried that since there's no python on Android.

Here's the list of controllers where this could also work:

Controller VID PID Classic/BLE
Xbox One S 0x045E 0x02E0 Classic
Xbox One S 0x045E 0x02FD Classic
Xbox One S 0x045E 0x0B20 BLE
Xbox Elite Series 2 0x045E 0x0B05 Classic
Xbox Elite Series 2 0x045E 0x0B22 BLE
Xbox Series S|X 0x045E 0x0B13 BLE


On Thu, Oct 20, 2022 at 10:33 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Thu, 2022-10-20 at 09:14 -0700, Siarhei Vishniakou wrote:
> > Currently, rumble is only supported via bluetooth on a single xbox
> > controller, called 'model 1708'. On the back of the device, it's
> > named
> > 'wireless controller for xbox one'. However, in 2021, Microsoft
> > released
> > a firmware update for this controller. As part of this update, the
> > HID
> > descriptor of the device changed. The product ID was also changed
> > from
> > 0x02fd to 0x0b20. On this controller, rumble was supported via
> > hid-microsoft, which matched against the old product id (0x02fd). As
> > a
> > result, the firmware update broke rumble support on this controller.
> >
> > The hid-microsoft driver actually supports rumble on the new
> > firmware,
> > as well. So simply adding new product id is sufficient to bring back
> > this support.
> >
> > After discussing further with the xbox team, it was pointed out that
> > other xbox controllers, such as xbox elite, should also be possible
> > to
> > support in a similar way. However, I could only verify this on 2
> > controllers so far.
> >
> > In this patch, add rumble support for the following 2 controllers:
> > 1. 'wireless controller for xbox one', model 1708, after applying the
> >    most recent firmware update as of 2022-10-20.
> > 2. 'xbox wireless controller', model 1914. This is also sometimes
> >    referred to as 'xbox series S|X'.
>
> This is a good summary of the different models:
> https://en.wikipedia.org/wiki/Xbox_Wireless_Controller#Summary
>
> You can remove the mention of the other names it might have, or the
> names at the back of the joypad, and use the model numbers instead.
>
> I think I have a model of each one of the devices in the list (except
> 1797 and 1537 IIRC), so I could test this if needed. Do you have a good
> test case for the various forces of rumble that would exercise both
> motors?
