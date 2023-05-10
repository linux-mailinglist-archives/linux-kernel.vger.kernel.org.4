Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01356FDC15
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjEJLAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEJLAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05251A6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683716397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klTkQpAcV6SKZuTTTJDC6BVd45oo5jRxo9X6P15ri5s=;
        b=OR4x0acGuLB8mpYtH8rKsHbBl/XD2FM3UfdguUXnoYhsaLOPJ1Juml3VM5KK3V6y4JfJDD
        kFizteTLjqe3fShjpBPGwUo3wPqevg6YuUl3dFl3jqMzu6JVAW2ZT8FCKx8we2p7PtWit6
        k/KS9xo480rUC0Sy5aIiQd2ErhsR430=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256--oW2oDl4PRC5-sHYHtWKbg-1; Wed, 10 May 2023 06:59:56 -0400
X-MC-Unique: -oW2oDl4PRC5-sHYHtWKbg-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-ba6386e6f7aso1645165276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683716395; x=1686308395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klTkQpAcV6SKZuTTTJDC6BVd45oo5jRxo9X6P15ri5s=;
        b=HIPt4TiAPj6sMMAnpVR9mtS4sltHRxw8d9Qy1fd7LXfAvIgNsi1BCQs8oZJIEinXgP
         84sP4QKDO3f4AZ+uYmmxrxoPab7ZfWFGKiLa4qe8fAhqGCRyXUEzXpoyKj/eg2BVSbdb
         sLSMDxrIrLE9yBvpaFOEwhyCUVh7w8jn64uowaiKZHaxee+zbtZTj4ss9UO0Lan+HDcd
         9hSKCh4KwTGWe7pF0HjOA61mvnb+2bbuxWJnwp6lUQBEVL5wshcGroU5NKeeBpewzSTd
         uadwBeubX4LQPs2XKHQJFjzUoIYjuXiYy6ohfALZ+eLnJ5dxhBoihziVYZH/hN1ob4dU
         pmyg==
X-Gm-Message-State: AC+VfDz6fUhLUO/x6CP4VNj/CoqDpbzUmbux6B8euBN4+MCpZoYJmfeH
        NbNrmGfpeTuZ8EAAJ46GvvDXJowbVVf//Ma1VK0yG3WWuRYNKhPwBXixji2PVa+KTQf4tETSJpp
        tDkIW2Fu45fu8x7ZhM6TC+BKyzG45eABDx7RmUryQ
X-Received: by 2002:a25:2413:0:b0:b9a:25c4:9d2f with SMTP id k19-20020a252413000000b00b9a25c49d2fmr17103009ybk.51.1683716394857;
        Wed, 10 May 2023 03:59:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5zDkLJ/xyScXESn1a/sP+lVMUwHakOms5GTDowbEv0gHexX0oaalh2EcUj4sg8A7EFOYZx1LjanzdW/FgnrZM=
X-Received: by 2002:a25:2413:0:b0:b9a:25c4:9d2f with SMTP id
 k19-20020a252413000000b00b9a25c49d2fmr17102988ybk.51.1683716394496; Wed, 10
 May 2023 03:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230125-hid-unregister-leds-v1-0-9a5192dcef16@diag.uniroma1.it> <288ed0da-8903-7dda-eb4e-f17037031e68@molgen.mpg.de>
In-Reply-To: <288ed0da-8903-7dda-eb4e-f17037031e68@molgen.mpg.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 10 May 2023 12:59:43 +0200
Message-ID: <CAO-hwJLmuB0=TiK6RcPKh4uFcX+A5bU9rivQ-K6Y7bzZKA6n4w@mail.gmail.com>
Subject: Re: [PATCH 0/5] HID: manually unregister leds on device removal to
 prevent UAFs
To:     Donald Buczek <buczek@molgen.mpg.de>
Cc:     Pietro Borrello <borrello@diag.uniroma1.it>,
        Jiri Kosina <jikos@kernel.org>, Hanno Zulla <kontakt@hanno.de>,
        Carlo Caione <carlo@endlessm.com>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Sven Eckelmann <sven@narfation.org>,
        linux-leds@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 12:21=E2=80=AFPM Donald Buczek <buczek@molgen.mpg.d=
e> wrote:
>
> Is this series in a queue somewhere?

Yes, but not in that form.

>
>
> Seems rather important and I don't find progress.

Well, there has been a v4 that has been merged already.

>
> Also, should be cc: stable@vger.kernel.org , right?

The fixes are already backported to stable, because Pietro added the
"fixes" tags which is a trigger for them to backport stuff.

>
> CVE-2023-25012

You have no idea how much I hate CVEs and how they are used as a way
to force an answer to an email or to force code inclusion...

Cheers,
Benjamin

>
> Best
>
>   Donald
>
> On 1/26/23 1:24 AM, Pietro Borrello wrote:
> > I noticed a recurring pattern is present in multiple hid devices in the
> > Linux tree, where the LED controller of a device schedules a work_struc=
t
> > to interact with the hardware.
> > The work_struct is embedded in the device structure and thus, is freed
> > at device removal.
> >
> > The issue is that a LED worker may be scheduled by a timer concurrently
> > with device removal, causing the work_struct to be accessed after havin=
g
> > been freed.
> > I was able to trigger the issue in hid-bigbenff.c and hid-asus.c
> > where the work_structs may be scheduled by the LED controller
> > while the device is disconnecting, triggering use-after-frees.
> > I can attach the reproducer, but it's very simple USB configuration,
> > using the /dev/raw-gadget interface with some more USB interactions
> > to manage LEDs configuration and pass checks in asus_kbd_init()
> > and asus_kbd_get_functions() in case of hid-asus.c.
> > I triggered the issue by connecting a device and immediately
> > disconnecting it, so that the remove function runs before the LED one
> > which remains pending.
> >
> > More drivers have the same pattern (hid-lg-g15.c, hid-playstation.c,
> > hid-sony.c) but I wasn't able to properly pass the right descriptors
> > to trigger the led configurations needed to trigger the workers.
> > Some other drivers manually unregister at removal (hid-corsair.c,
> > hid-gt683r.c, hid-lenovo.c) since they do not use the managed
> > interface, which is safe, to my understanding.
> > Also, a similar pattern is present with callbacks which schedule
> > a worker originating from input_ff_create_memless() (e.g.,
> > in hid-bigbenff.c) but in these cases, I wasn't able to trigger
> > the race condition with the event handling to schedule the worker
> > during device removal. However, I have no experience with the USB
> > protocol and I'm not able to say that they cannot be triggered.
> >
> > I am currently wondering if this is due to some emulation of the
> > /dev/raw-gadget interface or if it's effectively an issue with how each
> > device manages resource removal.
> > But I wonder why syzkaller didn't find any crash while fuzzing the
> > interface with upstream-usb.config, as they seem pretty
> > straightforward to trigger.
> > Configuring the kernel with CONFIG_DEBUG_OBJECTS, it emits
> > a warning in debug_check_no_obj_freed, which makes it clear that
> > device removal is freeing resources in use.
> > KASAN detects them as use-after-free.
> >
> > I am attaching multiple patches for all the drivers I suspect the bug
> > is present.
> > The proposed patches unregister the LED controllers before removing the
> > device itself.
> >
> > I attach the (partial for brevity) ODEBUG dumps:
> >
> > ```hid-bigbenff.c
> > [   37.803135][ T1170] usb 1-1: USB disconnect, device number 2
> > [   37.827979][ T1170] ODEBUG: free active (active state 0) object
> > type: work_struct hint: bigben_worker+0x0/0x860
> > [   37.829634][ T1170] WARNING: CPU: 0 PID: 1170 at
> > lib/debugobjects.c:505 debug_check_no_obj_freed+0x43a/0x630
> > [   37.830904][ T1170] Modules linked in:
> > [   37.831413][ T1170] CPU: 0 PID: 1170 Comm: kworker/0:3 Not tainted
> > 6.1.0-rc4-dirty #43
> > [   37.832465][ T1170] Hardware name: QEMU Standard PC (i440FX + PIIX,
> > 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> > [   37.833751][ T1170] Workqueue: usb_hub_wq hub_event
> > [   37.834409][ T1170] RIP: 0010:debug_check_no_obj_freed+0x43a/0x630
> > [   37.835218][ T1170] Code: 48 89 ef e8 28 82 58 ff 49 8b 14 24 4c 8b
> > 45 00 48 c7 c7 40 5f 09 87 48 c7 c6 60 5b 09 87 89 d9 4d 89 f9 31 c0
> > e8 46 25 ef fe <0f> 0b 4c 8b 64 24 20 48 ba 00 00 00 00 00 fc ff df ff
> > 05 4f 7c 17
> > [   37.837667][ T1170] RSP: 0018:ffffc900006fee60 EFLAGS: 00010246
> > [   37.838503][ T1170] RAX: 0d2d19ffcded3d00 RBX: 0000000000000000
> > RCX: ffff888117fc9b00
> > [   37.839519][ T1170] RDX: 0000000000000000 RSI: 0000000000000000
> > RDI: 0000000000000000
> > [   37.840570][ T1170] RBP: ffffffff86e88380 R08: ffffffff8130793b
> > R09: fffff520000dfd85
> > [   37.841618][ T1170] R10: fffff520000dfd85 R11: 0000000000000000
> > R12: ffffffff87095fb8
> > [   37.842649][ T1170] R13: ffff888117770ad8 R14: ffff888117770acc
> > R15: ffffffff852b7420
> > [   37.843728][ T1170] FS:  0000000000000000(0000)
> > GS:ffff8881f6600000(0000) knlGS:0000000000000000
> > [   37.844877][ T1170] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [   37.845749][ T1170] CR2: 00007f992eaab380 CR3: 000000011834b000
> > CR4: 00000000001006f0
> > [   37.846794][ T1170] Call Trace:
> > [   37.847245][ T1170]  <TASK>
> > [   37.847643][ T1170]  slab_free_freelist_hook+0x89/0x160
> > [   37.848409][ T1170]  ? devres_release_all+0x262/0x350
> > [   37.849156][ T1170]  __kmem_cache_free+0x71/0x110
> > [   37.849829][ T1170]  devres_release_all+0x262/0x350
> > [   37.850478][ T1170]  ? devres_release+0x90/0x90
> > [   37.851118][ T1170]  device_release_driver_internal+0x5e5/0x8a0
> > [   37.851944][ T1170]  bus_remove_device+0x2ea/0x400
> > [   37.852611][ T1170]  device_del+0x64f/0xb40
> > [   37.853212][ T1170]  ? kill_device+0x150/0x150
> > [   37.853831][ T1170]  ? print_irqtrace_events+0x1f0/0x1f0
> > [   37.854564][ T1170]  hid_destroy_device+0x66/0x100
> > [   37.855226][ T1170]  usbhid_disconnect+0x9a/0xc0
> > [   37.855887][ T1170]  usb_unbind_interface+0x1e1/0x890
> > ```
> >
> > ``` hid-asus.c
> > [   77.409878][ T1169] usb 1-1: USB disconnect, device number 2
> > [   77.423606][ T1169] ODEBUG: free active (active state 0) object
> > type: work_struct hint: asus_kbd_backlight_work+0x0/0x2c0
> > [   77.425222][ T1169] WARNING: CPU: 0 PID: 1169 at
> > lib/debugobjects.c:505 debug_check_no_obj_freed+0x43a/0x630
> > [   77.426599][ T1169] Modules linked in:
> > [   77.427322][ T1169] CPU: 0 PID: 1169 Comm: kworker/0:3 Not tainted
> > 6.1.0-rc4-dirty #43
> > [   77.428404][ T1169] Hardware name: QEMU Standard PC (i440FX + PIIX,
> > 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> > [   77.429644][ T1169] Workqueue: usb_hub_wq hub_event
> > [   77.430296][ T1169] RIP: 0010:debug_check_no_obj_freed+0x43a/0x630
> > [   77.431142][ T1169] Code: 48 89 ef e8 28 82 58 ff 49 8b 14 24 4c 8b
> > 45 00 48 c7 c7 40 5f 09 87 48 c7 c6 60 5b 09 87 89 d9 4d 89 f9 31 c0
> > e8 46 25 ef fe <0f> 0b 4c 8b 64 24 20 48 ba 00 00 00 00 00 fc ff df ff
> > 05 4f 7c 17
> > [   77.433691][ T1169] RSP: 0018:ffffc9000069ee60 EFLAGS: 00010246
> > [   77.434470][ T1169] RAX: b85d2b40c12d7600 RBX: 0000000000000000
> > RCX: ffff888117a78000
> > [   77.435507][ T1169] RDX: 0000000000000000 RSI: 0000000080000000
> > RDI: 0000000000000000
> > [   77.436521][ T1169] RBP: ffffffff86e88380 R08: ffffffff8130793b
> > R09: ffffed103ecc4ed6
> > [   77.437582][ T1169] R10: ffffed103ecc4ed6 R11: 0000000000000000
> > R12: ffffffff87095fb8
> > [   77.438593][ T1169] R13: ffff88810e348fe0 R14: ffff88810e348fd4
> > R15: ffffffff852b5780
> > [   77.439667][ T1169] FS:  0000000000000000(0000)
> > GS:ffff8881f6600000(0000) knlGS:0000000000000000
> > [   77.440842][ T1169] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [   77.441688][ T1169] CR2: 00007ffc05495ff0 CR3: 000000010cdf0000
> > CR4: 00000000001006f0
> > [   77.442720][ T1169] Call Trace:
> > [   77.443167][ T1169]  <TASK>
> > [   77.443555][ T1169]  slab_free_freelist_hook+0x89/0x160
> > [   77.444302][ T1169]  ? devres_release_all+0x262/0x350
> > [   77.444990][ T1169]  __kmem_cache_free+0x71/0x110
> > [   77.445638][ T1169]  devres_release_all+0x262/0x350
> > [   77.446309][ T1169]  ? devres_release+0x90/0x90
> > [   77.446978][ T1169]  device_release_driver_internal+0x5e5/0x8a0
> > [   77.447748][ T1169]  bus_remove_device+0x2ea/0x400
> > [   77.448421][ T1169]  device_del+0x64f/0xb40
> > [   77.448976][ T1169]  ? kill_device+0x150/0x150
> > [   77.449577][ T1169]  ? print_irqtrace_events+0x1f0/0x1f0
> > [   77.450307][ T1169]  hid_destroy_device+0x66/0x100
> > [   77.450938][ T1169]  usbhid_disconnect+0x9a/0xc0
> > ```
> >
> > To: Jiri Kosina <jikos@kernel.org>
> > To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > To: Hanno Zulla <kontakt@hanno.de>
> > To: Carlo Caione <carlo@endlessm.com>
> > To: Pavel Machek <pavel@ucw.cz>
> > To: Lee Jones <lee@kernel.org>
> > To: Roderick Colenbrander <roderick.colenbrander@sony.com>
> > To: Sven Eckelmann <sven@narfation.org>
> > Cc: linux-leds@vger.kernel.org
> > Cc: Cristiano Giuffrida <c.giuffrida@vu.nl>
> > Cc: "Bos, H.J." <h.j.bos@vu.nl>
> > Cc: Jakob Koschel <jkl820.git@gmail.com>
> > Cc: linux-input@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Jiri Kosina <jkosina@suse.cz>
> > Cc: Roderick Colenbrander <roderick@gaikai.com>
> > Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> >
> > ---
> > Pietro Borrello (5):
> >       HID: bigben_remove: manually unregister leds
> >       HID: asus_remove: manually unregister led
> >       HID: dualsense_remove: manually unregister leds
> >       HID: dualshock4_remove: manually unregister leds
> >       HID: sony_remove: manually unregister leds
> >
> >  drivers/hid/hid-asus.c        | 1 +
> >  drivers/hid/hid-bigbenff.c    | 5 +++++
> >  drivers/hid/hid-playstation.c | 8 ++++++++
> >  drivers/hid/hid-sony.c        | 8 ++++++++
> >  4 files changed, 22 insertions(+)
> > ---
> > base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
> > change-id: 20230125-hid-unregister-leds-4cbf67099e1d
> >
> > Best regards,
> >
>
>
> --
> Donald Buczek
> buczek@molgen.mpg.de
> Tel: +49 30 8413 1433
>

