Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E776E69832D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjBOSVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBOSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:21:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4E8172E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676485241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xYWSHS/XxBcZqVN/owpps0Q6DeySq2ilnkGdny+O+xs=;
        b=ewS/mA4Dirn/tWoizdU2qqckKTw3CKhn5Hh29YiVoagJQCay1Fk+tVPrDLzYg39xrANz8C
        zLqHfzi041yfbWtgb1cwaRvKIqrj+BmmD7FgfO+8lbTHvDYijGdOHmtJoqQ4YkNzFCdXdc
        RR0vIWCp1U0I6GjhS+PQszgYjXM/YJ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-ySbKgoBTPdaTNWSoIyKL-g-1; Wed, 15 Feb 2023 13:20:39 -0500
X-MC-Unique: ySbKgoBTPdaTNWSoIyKL-g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD7638027EB;
        Wed, 15 Feb 2023 18:20:38 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-194-191.brq.redhat.com [10.40.194.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9162E492B0E;
        Wed, 15 Feb 2023 18:20:36 +0000 (UTC)
Date:   Wed, 15 Feb 2023 19:20:34 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Jiri Kosina <jikos@kernel.org>, Hanno Zulla <kontakt@hanno.de>,
        Hanno Zulla <abos@hanno.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] HID: use spinlocks to safely schedule led workers
Message-ID: <20230215182034.gpiwzc24vyke4btb@mail.corp.redhat.com>
References: <20230125-hid-unregister-leds-v4-0-7860c5763c38@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-hid-unregister-leds-v4-0-7860c5763c38@diag.uniroma1.it>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12 2023, Pietro Borrello wrote:
> I noticed a recurring pattern is present in multiple hid devices in the
> Linux tree, where the LED controller of a device schedules a work_struct
> to interact with the hardware.
> The work_struct is embedded in the device structure and thus, is freed
> at device removal.
> 
> The issue is that a LED worker may be scheduled by a timer concurrently
> with device removal, causing the work_struct to be accessed after having
> been freed.
> I was able to trigger the issue in hid-bigbenff.c and hid-asus.c 
> where the work_structs may be scheduled by the LED controller
> while the device is disconnecting, triggering use-after-frees.
> I can attach the reproducer, but it's very simple USB configuration, 
> using the /dev/raw-gadget interface with some more USB interactions 
> to manage LEDs configuration and pass checks in asus_kbd_init() 
> and asus_kbd_get_functions() in case of hid-asus.c.
> I triggered the issue by connecting a device and immediately 
> disconnecting it, so that the remove function runs before the LED one
> which remains pending.
> 
> I am attaching multiple patches for asus and bigben drivers. 
> The proposed patches introduce safe wrappers to schedule the workers
> safely with several spinlocks checks.
> 
> I attach the (partial for brevity) ODEBUG dumps:
> 
> ```hid-bigbenff.c
> [   37.803135][ T1170] usb 1-1: USB disconnect, device number 2
> [   37.827979][ T1170] ODEBUG: free active (active state 0) object
> type: work_struct hint: bigben_worker+0x0/0x860
> [   37.829634][ T1170] WARNING: CPU: 0 PID: 1170 at
> lib/debugobjects.c:505 debug_check_no_obj_freed+0x43a/0x630
> [   37.830904][ T1170] Modules linked in:
> [   37.831413][ T1170] CPU: 0 PID: 1170 Comm: kworker/0:3 Not tainted
> 6.1.0-rc4-dirty #43
> [   37.832465][ T1170] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [   37.833751][ T1170] Workqueue: usb_hub_wq hub_event
> [   37.834409][ T1170] RIP: 0010:debug_check_no_obj_freed+0x43a/0x630
> [   37.835218][ T1170] Code: 48 89 ef e8 28 82 58 ff 49 8b 14 24 4c 8b
> 45 00 48 c7 c7 40 5f 09 87 48 c7 c6 60 5b 09 87 89 d9 4d 89 f9 31 c0
> e8 46 25 ef fe <0f> 0b 4c 8b 64 24 20 48 ba 00 00 00 00 00 fc ff df ff
> 05 4f 7c 17
> [   37.837667][ T1170] RSP: 0018:ffffc900006fee60 EFLAGS: 00010246
> [   37.838503][ T1170] RAX: 0d2d19ffcded3d00 RBX: 0000000000000000
> RCX: ffff888117fc9b00
> [   37.839519][ T1170] RDX: 0000000000000000 RSI: 0000000000000000
> RDI: 0000000000000000
> [   37.840570][ T1170] RBP: ffffffff86e88380 R08: ffffffff8130793b
> R09: fffff520000dfd85
> [   37.841618][ T1170] R10: fffff520000dfd85 R11: 0000000000000000
> R12: ffffffff87095fb8
> [   37.842649][ T1170] R13: ffff888117770ad8 R14: ffff888117770acc
> R15: ffffffff852b7420
> [   37.843728][ T1170] FS:  0000000000000000(0000)
> GS:ffff8881f6600000(0000) knlGS:0000000000000000
> [   37.844877][ T1170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   37.845749][ T1170] CR2: 00007f992eaab380 CR3: 000000011834b000
> CR4: 00000000001006f0
> [   37.846794][ T1170] Call Trace:
> [   37.847245][ T1170]  <TASK>
> [   37.847643][ T1170]  slab_free_freelist_hook+0x89/0x160
> [   37.848409][ T1170]  ? devres_release_all+0x262/0x350
> [   37.849156][ T1170]  __kmem_cache_free+0x71/0x110
> [   37.849829][ T1170]  devres_release_all+0x262/0x350
> [   37.850478][ T1170]  ? devres_release+0x90/0x90
> [   37.851118][ T1170]  device_release_driver_internal+0x5e5/0x8a0
> [   37.851944][ T1170]  bus_remove_device+0x2ea/0x400
> [   37.852611][ T1170]  device_del+0x64f/0xb40
> [   37.853212][ T1170]  ? kill_device+0x150/0x150
> [   37.853831][ T1170]  ? print_irqtrace_events+0x1f0/0x1f0
> [   37.854564][ T1170]  hid_destroy_device+0x66/0x100
> [   37.855226][ T1170]  usbhid_disconnect+0x9a/0xc0
> [   37.855887][ T1170]  usb_unbind_interface+0x1e1/0x890
> ```
> 
> ``` hid-asus.c
> [   77.409878][ T1169] usb 1-1: USB disconnect, device number 2
> [   77.423606][ T1169] ODEBUG: free active (active state 0) object
> type: work_struct hint: asus_kbd_backlight_work+0x0/0x2c0
> [   77.425222][ T1169] WARNING: CPU: 0 PID: 1169 at
> lib/debugobjects.c:505 debug_check_no_obj_freed+0x43a/0x630
> [   77.426599][ T1169] Modules linked in:
> [   77.427322][ T1169] CPU: 0 PID: 1169 Comm: kworker/0:3 Not tainted
> 6.1.0-rc4-dirty #43
> [   77.428404][ T1169] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [   77.429644][ T1169] Workqueue: usb_hub_wq hub_event
> [   77.430296][ T1169] RIP: 0010:debug_check_no_obj_freed+0x43a/0x630
> [   77.431142][ T1169] Code: 48 89 ef e8 28 82 58 ff 49 8b 14 24 4c 8b
> 45 00 48 c7 c7 40 5f 09 87 48 c7 c6 60 5b 09 87 89 d9 4d 89 f9 31 c0
> e8 46 25 ef fe <0f> 0b 4c 8b 64 24 20 48 ba 00 00 00 00 00 fc ff df ff
> 05 4f 7c 17
> [   77.433691][ T1169] RSP: 0018:ffffc9000069ee60 EFLAGS: 00010246
> [   77.434470][ T1169] RAX: b85d2b40c12d7600 RBX: 0000000000000000
> RCX: ffff888117a78000
> [   77.435507][ T1169] RDX: 0000000000000000 RSI: 0000000080000000
> RDI: 0000000000000000
> [   77.436521][ T1169] RBP: ffffffff86e88380 R08: ffffffff8130793b
> R09: ffffed103ecc4ed6
> [   77.437582][ T1169] R10: ffffed103ecc4ed6 R11: 0000000000000000
> R12: ffffffff87095fb8
> [   77.438593][ T1169] R13: ffff88810e348fe0 R14: ffff88810e348fd4
> R15: ffffffff852b5780
> [   77.439667][ T1169] FS:  0000000000000000(0000)
> GS:ffff8881f6600000(0000) knlGS:0000000000000000
> [   77.440842][ T1169] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   77.441688][ T1169] CR2: 00007ffc05495ff0 CR3: 000000010cdf0000
> CR4: 00000000001006f0
> [   77.442720][ T1169] Call Trace:
> [   77.443167][ T1169]  <TASK>
> [   77.443555][ T1169]  slab_free_freelist_hook+0x89/0x160
> [   77.444302][ T1169]  ? devres_release_all+0x262/0x350
> [   77.444990][ T1169]  __kmem_cache_free+0x71/0x110
> [   77.445638][ T1169]  devres_release_all+0x262/0x350
> [   77.446309][ T1169]  ? devres_release+0x90/0x90
> [   77.446978][ T1169]  device_release_driver_internal+0x5e5/0x8a0
> [   77.447748][ T1169]  bus_remove_device+0x2ea/0x400
> [   77.448421][ T1169]  device_del+0x64f/0xb40
> [   77.448976][ T1169]  ? kill_device+0x150/0x150
> [   77.449577][ T1169]  ? print_irqtrace_events+0x1f0/0x1f0
> [   77.450307][ T1169]  hid_destroy_device+0x66/0x100
> [   77.450938][ T1169]  usbhid_disconnect+0x9a/0xc0
> ```
> 
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> ---
> Changes in v4:
> - Split patches that add spinlock wrt the patches that check scheduling
> - Smaller locked regions
> - Link to v3: https://lore.kernel.org/r/20230125-hid-unregister-leds-v3-0-0a52ac225e00@diag.uniroma1.it
> 
> Changes in v3:
> - use spinlocks to prevent workers scheduling
> - drop patches on sony & playstation hid drivers
> - Link to v2: https://lore.kernel.org/r/20230125-hid-unregister-leds-v2-0-689cc62fc878@diag.uniroma1.it
> 
> Changes in v2:
> - dualshock4: Clarify UAF
> - dualsense:  Clarify UAF
> - dualsense:  Unregister multicolor led controller
> - Link to v1: https://lore.kernel.org/r/20230125-hid-unregister-leds-v1-0-9a5192dcef16@diag.uniroma1.it
> 
> ---
> Pietro Borrello (5):
>       HID: bigben: use spinlock to protect concurrent accesses
>       HID: bigben_worker() remove unneeded check on report_field
>       HID: bigben: use spinlock to safely schedule workers
>       HID: asus: use spinlock to protect concurrent accesses
>       HID: asus: use spinlock to safely schedule workers
> 
>  drivers/hid/hid-asus.c     | 37 +++++++++++++++++++++----
>  drivers/hid/hid-bigbenff.c | 68 +++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 93 insertions(+), 12 deletions(-)

And patches 1-3 applied to hid/hid.git branch for-6.3/bigben

Cheers,
Benjamin

> ---
> base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
> change-id: 20230125-hid-unregister-leds-4cbf67099e1d
> 
> Best regards,
> -- 
> Pietro Borrello <borrello@diag.uniroma1.it>
> 

