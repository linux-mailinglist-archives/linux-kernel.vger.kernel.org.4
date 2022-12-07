Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD886455E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLGI6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiLGI6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:58:35 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A583AC40;
        Wed,  7 Dec 2022 00:58:34 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id z17so9511086qki.11;
        Wed, 07 Dec 2022 00:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pleAcNei+fQZB0zmkXiJ8AfFaLRxspIhoeV2rVgFZ7Q=;
        b=2ZY+nh8rz+FGSRpOpKz4viVzf86dGn3b8nZyVbZnbaENew6q8g1hiEIt6XE9idYnAm
         K7LpqiA2j3qH2ktTi3jtNgAZ2QMfX0ZnZqrvKrHnsLHj+kEZsx3DOwuaDaD7WmLXN8DK
         l8ehwMabssOguzfloEiD8SyhLsA4AN2M4Oii0+szQ3cYygDg+0G5W9mL37shF/SIOO4E
         hQI3BE6Xc63xXffV/AY2CFwZW5HYDixAr2Jt/R5YF0pfq5326G1bZiUSfc5iwLhvqPuN
         33uWK2LK2iCHv0gOpgUSLUs14Jy70LPJ0mxzzCC6iTDKMi+jlC62LUw9Po2O3KADgx5U
         9qyg==
X-Gm-Message-State: ANoB5pla/vZt6loh5xbQCIbrxQsvAcpdRYXlfBoeO3KsQgHlFEOil/LV
        AB+V+E/zD2+dlWT0wjh492uZsf6WHj12l6FRm4Q=
X-Google-Smtp-Source: AA0mqf53TKybKEpgvhuuUjEXyzo+u+xXdLtr+p5Gh4slnCI9X2C7Vxuk86LOAwCI6Q1qtMmobnFGdYT+IGX/3wg/2jQ=
X-Received: by 2002:a05:620a:51ca:b0:6ec:fa04:d97c with SMTP id
 cx10-20020a05620a51ca00b006ecfa04d97cmr61679069qkb.764.1670403513756; Wed, 07
 Dec 2022 00:58:33 -0800 (PST)
MIME-Version: 1.0
References: <2262737.ElGaqSPkdT@kreacher>
In-Reply-To: <2262737.ElGaqSPkdT@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Dec 2022 09:58:22 +0100
Message-ID: <CAJZ5v0jBo-_XnN2m0jeVdeTi7kjr6C3OSzc1NEJgav0srD0JGQ@mail.gmail.com>
Subject: Re: [Regression] Logitech BT mouse unusable after commit 532223c8ac57
 (still in 6.1-rc8)
To:     Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>
Cc:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 3:58 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Bastien, Jiri,
>
> Commit 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all the Logitech
> Bluetooth devices") caused my Logitech Bluetooth mouse to become unusable.
>
> Appended is the change I need to make it work again (note that adding the
> device ID to unhandled_hidpp_devices[] doesn't help, so there must be some
> significant enough difference in how the two cases are handled in the stack).
>
> Here's what I get in the log without the patch below:
>
> [   36.710574] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [   36.710592] Bluetooth: HIDP socket layer initialized
> [   36.724644] hid-generic 0005:046D:B016.0001: unknown main item tag 0x0
> [   36.725860] input: Bluetooth Mouse M336/M337/M535 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input14
> [   36.728036] input: Bluetooth Mouse M336/M337/M535 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input15
> [   36.728823] input: Bluetooth Mouse M336/M337/M535 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input18
> [   36.731550] hid-generic 0005:046D:B016.0001: input,hidraw0: BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on 9c:b6:d0:96:8e:c8
> [   36.833039] logitech-hidpp-device 0005:046D:B016.0001: unknown main item tag 0x0
> [   36.999064] logitech-hidpp-device 0005:046D:B016.0001: Device not connected
>
> and here's what I get with it:
>
> [   43.642546] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [   43.642559] Bluetooth: HIDP socket layer initialized
> [   43.652898] hid-generic 0005:046D:B016.0001: unknown main item tag 0x0
> [   43.653833] input: Bluetooth Mouse M336/M337/M535 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input14
> [   43.655025] input: Bluetooth Mouse M336/M337/M535 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input15
> [   43.655400] input: Bluetooth Mouse M336/M337/M535 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:1/0005:046D:B016.0001/input/input18
> [   43.657521] hid-generic 0005:046D:B016.0001: input,hidraw0: BLUETOOTH HID v12.03 Mouse [Bluetooth Mouse M336/M337/M535] on 9c:b6:d0:96:8e:c8
>
> The only difference seems to be that in the former case the logitech-hidpp
> driver tries to bind to the device, but I guess that is expected.  However,
> when the device ID is added to unhandled_hidpp_devices[], the messages look
> exactly like in the "good" case, but the mouse still doesn't work.

Here's what happens.

- The logitech-hidpp driver is modular and is not present initially,
so hid-generic probes first (successfully).

- logitech-hidpp is loaded which causes the device to be reporobed due
to __hid_bus_driver_added().

- Because the ->match() callback in hid-generic returns 0 for the
device now, it is unbound from the device.

- The probing of logitech-hidpp fails (due to an error in ->probe()).

- The probing of hid-generic fails due to the failing ->match().

So in order for unhandled_hidpp_devices[] in logitech-hidpp to work
with hid-generic, __check_hid_generic() needs to be amended with a
change to run the ->match() callback of the "specific" driver being
tried.

I have a working patch for this that will be sent shortly.

Thanks!
