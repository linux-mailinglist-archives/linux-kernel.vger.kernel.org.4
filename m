Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A366E67C17F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjAZAZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjAZAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:25:21 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CE45B5A2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:25:17 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kt14so1152599ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xFaiipMBU1uJ4zwdWo9cgaJvki2ZRxBo3KW9cfRmv9M=;
        b=Hl3DKwSwgR3I3r/InzwE1XijXClvUl/vlUPGr7XyMto0Hv/eyGxl245Rj0wRXoG1PK
         y0Fj2t47C3UaWp+qgUzD0ADkVsG5J3ymNKZTTaWCQ/G0h14t62pMGk4C1CCxEc3yrQRJ
         auzigJh4gN1w6c+hicWDOe05041AJ+vP/7DcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFaiipMBU1uJ4zwdWo9cgaJvki2ZRxBo3KW9cfRmv9M=;
        b=eE9wtGBuEvso+uepKVE64uP4doe7eaAFqz7UnAiG6Xr4ASXX14Z4oXrs2+tk9pBJcl
         +3O/+/qirYMIW/R22TMPjCqySPNwNwi+vi9rcoZdP5TgbUHDAOB4bJQ3h8NqBEbGqlHK
         b1dixZIq0NnE+jBodl2E9s1jW8KTwQIP9RAblB2KusACMaWaz5lQ1leS+0+a+ODNnZvH
         YYL0tifedXzqc3vr8ZUDoLYp229mcjhpdeVfr4elPR/QlLJsESEBw0RE7mxECOqrVshc
         hprY6eRtpHJuLK1Yp0VnZHS6reTPVhUZTQYuTlHEcb8/qjV2GmZqxw0Sli2FjJV5R52Q
         PO1A==
X-Gm-Message-State: AFqh2ko6LwgyQM+f+ba1p/NbeFSBZPNNRJHDNOf0t2BkGQbO4w8aDlxt
        F9MPjxuz5J6YABiC05YbKOd1Lw==
X-Google-Smtp-Source: AMrXdXtAbpyosNUXc10O3CRqSFTkmLTWSb4hPrjbitpAVff524BGeizRpPaCJt8+hbiFiuKS8ObZig==
X-Received: by 2002:a17:907:6f18:b0:84d:4e4f:1f85 with SMTP id sy24-20020a1709076f1800b0084d4e4f1f85mr35195658ejc.59.1674692715965;
        Wed, 25 Jan 2023 16:25:15 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id jy12-20020a170907762c00b008784e808553sm555707ejc.6.2023.01.25.16.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 16:25:15 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Subject: [PATCH 0/5] HID: manually unregister leds on device removal to prevent UAFs
Date:   Thu, 26 Jan 2023 00:24:53 +0000
Message-Id: <20230125-hid-unregister-leds-v1-0-9a5192dcef16@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFXI0WMC/x2NSwrDMAwFrxK0rsB2PyG9SsnCHyUWpG6RklIIu
 XvtLod5w9tBSZgU7t0OQh9WfpUK9tRBzL7MhJwqgzPubKy7YuaEWxGaWVcSXCgpXmKYbr0ZBrIJ
 ahm8EgbxJebWPn2bNvEWmvj7v3uMx/EDqjNKDX4AAAA=
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <kontakt@hanno.de>,
        Carlo Caione <carlo@endlessm.com>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Sven Eckelmann <sven@narfation.org>
Cc:     linux-leds@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674692715; l=8938;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=QdIkage8duwd9pwha6zu89n0T8tDTVZRBDxoP9kF9Mw=;
 b=fXzHwN750DnttJAeCO91BYVF2+9g4c/zKjp62LHyu93bNaic87TmNnvH3RVlkdCZaqknn5MIW1FG
 2n8lM66QAOCDnfCOIAR8TSfyFf0ngp502PN2XMF+eqbMF1H9YGg2
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a recurring pattern is present in multiple hid devices in the
Linux tree, where the LED controller of a device schedules a work_struct
to interact with the hardware.
The work_struct is embedded in the device structure and thus, is freed
at device removal.

The issue is that a LED worker may be scheduled by a timer concurrently
with device removal, causing the work_struct to be accessed after having
been freed.
I was able to trigger the issue in hid-bigbenff.c and hid-asus.c 
where the work_structs may be scheduled by the LED controller
while the device is disconnecting, triggering use-after-frees.
I can attach the reproducer, but it's very simple USB configuration, 
using the /dev/raw-gadget interface with some more USB interactions 
to manage LEDs configuration and pass checks in asus_kbd_init() 
and asus_kbd_get_functions() in case of hid-asus.c.
I triggered the issue by connecting a device and immediately 
disconnecting it, so that the remove function runs before the LED one
which remains pending.

More drivers have the same pattern (hid-lg-g15.c, hid-playstation.c,
hid-sony.c) but I wasn't able to properly pass the right descriptors
to trigger the led configurations needed to trigger the workers.
Some other drivers manually unregister at removal (hid-corsair.c,
hid-gt683r.c, hid-lenovo.c) since they do not use the managed
interface, which is safe, to my understanding.
Also, a similar pattern is present with callbacks which schedule
a worker originating from input_ff_create_memless() (e.g.,
in hid-bigbenff.c) but in these cases, I wasn't able to trigger
the race condition with the event handling to schedule the worker
during device removal. However, I have no experience with the USB
protocol and I'm not able to say that they cannot be triggered.

I am currently wondering if this is due to some emulation of the
/dev/raw-gadget interface or if it's effectively an issue with how each
device manages resource removal.
But I wonder why syzkaller didn't find any crash while fuzzing the
interface with upstream-usb.config, as they seem pretty
straightforward to trigger.
Configuring the kernel with CONFIG_DEBUG_OBJECTS, it emits
a warning in debug_check_no_obj_freed, which makes it clear that
device removal is freeing resources in use.
KASAN detects them as use-after-free.

I am attaching multiple patches for all the drivers I suspect the bug
is present.
The proposed patches unregister the LED controllers before removing the
device itself.

I attach the (partial for brevity) ODEBUG dumps:

```hid-bigbenff.c
[   37.803135][ T1170] usb 1-1: USB disconnect, device number 2
[   37.827979][ T1170] ODEBUG: free active (active state 0) object
type: work_struct hint: bigben_worker+0x0/0x860
[   37.829634][ T1170] WARNING: CPU: 0 PID: 1170 at
lib/debugobjects.c:505 debug_check_no_obj_freed+0x43a/0x630
[   37.830904][ T1170] Modules linked in:
[   37.831413][ T1170] CPU: 0 PID: 1170 Comm: kworker/0:3 Not tainted
6.1.0-rc4-dirty #43
[   37.832465][ T1170] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   37.833751][ T1170] Workqueue: usb_hub_wq hub_event
[   37.834409][ T1170] RIP: 0010:debug_check_no_obj_freed+0x43a/0x630
[   37.835218][ T1170] Code: 48 89 ef e8 28 82 58 ff 49 8b 14 24 4c 8b
45 00 48 c7 c7 40 5f 09 87 48 c7 c6 60 5b 09 87 89 d9 4d 89 f9 31 c0
e8 46 25 ef fe <0f> 0b 4c 8b 64 24 20 48 ba 00 00 00 00 00 fc ff df ff
05 4f 7c 17
[   37.837667][ T1170] RSP: 0018:ffffc900006fee60 EFLAGS: 00010246
[   37.838503][ T1170] RAX: 0d2d19ffcded3d00 RBX: 0000000000000000
RCX: ffff888117fc9b00
[   37.839519][ T1170] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 0000000000000000
[   37.840570][ T1170] RBP: ffffffff86e88380 R08: ffffffff8130793b
R09: fffff520000dfd85
[   37.841618][ T1170] R10: fffff520000dfd85 R11: 0000000000000000
R12: ffffffff87095fb8
[   37.842649][ T1170] R13: ffff888117770ad8 R14: ffff888117770acc
R15: ffffffff852b7420
[   37.843728][ T1170] FS:  0000000000000000(0000)
GS:ffff8881f6600000(0000) knlGS:0000000000000000
[   37.844877][ T1170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.845749][ T1170] CR2: 00007f992eaab380 CR3: 000000011834b000
CR4: 00000000001006f0
[   37.846794][ T1170] Call Trace:
[   37.847245][ T1170]  <TASK>
[   37.847643][ T1170]  slab_free_freelist_hook+0x89/0x160
[   37.848409][ T1170]  ? devres_release_all+0x262/0x350
[   37.849156][ T1170]  __kmem_cache_free+0x71/0x110
[   37.849829][ T1170]  devres_release_all+0x262/0x350
[   37.850478][ T1170]  ? devres_release+0x90/0x90
[   37.851118][ T1170]  device_release_driver_internal+0x5e5/0x8a0
[   37.851944][ T1170]  bus_remove_device+0x2ea/0x400
[   37.852611][ T1170]  device_del+0x64f/0xb40
[   37.853212][ T1170]  ? kill_device+0x150/0x150
[   37.853831][ T1170]  ? print_irqtrace_events+0x1f0/0x1f0
[   37.854564][ T1170]  hid_destroy_device+0x66/0x100
[   37.855226][ T1170]  usbhid_disconnect+0x9a/0xc0
[   37.855887][ T1170]  usb_unbind_interface+0x1e1/0x890
```

``` hid-asus.c
[   77.409878][ T1169] usb 1-1: USB disconnect, device number 2
[   77.423606][ T1169] ODEBUG: free active (active state 0) object
type: work_struct hint: asus_kbd_backlight_work+0x0/0x2c0
[   77.425222][ T1169] WARNING: CPU: 0 PID: 1169 at
lib/debugobjects.c:505 debug_check_no_obj_freed+0x43a/0x630
[   77.426599][ T1169] Modules linked in:
[   77.427322][ T1169] CPU: 0 PID: 1169 Comm: kworker/0:3 Not tainted
6.1.0-rc4-dirty #43
[   77.428404][ T1169] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   77.429644][ T1169] Workqueue: usb_hub_wq hub_event
[   77.430296][ T1169] RIP: 0010:debug_check_no_obj_freed+0x43a/0x630
[   77.431142][ T1169] Code: 48 89 ef e8 28 82 58 ff 49 8b 14 24 4c 8b
45 00 48 c7 c7 40 5f 09 87 48 c7 c6 60 5b 09 87 89 d9 4d 89 f9 31 c0
e8 46 25 ef fe <0f> 0b 4c 8b 64 24 20 48 ba 00 00 00 00 00 fc ff df ff
05 4f 7c 17
[   77.433691][ T1169] RSP: 0018:ffffc9000069ee60 EFLAGS: 00010246
[   77.434470][ T1169] RAX: b85d2b40c12d7600 RBX: 0000000000000000
RCX: ffff888117a78000
[   77.435507][ T1169] RDX: 0000000000000000 RSI: 0000000080000000
RDI: 0000000000000000
[   77.436521][ T1169] RBP: ffffffff86e88380 R08: ffffffff8130793b
R09: ffffed103ecc4ed6
[   77.437582][ T1169] R10: ffffed103ecc4ed6 R11: 0000000000000000
R12: ffffffff87095fb8
[   77.438593][ T1169] R13: ffff88810e348fe0 R14: ffff88810e348fd4
R15: ffffffff852b5780
[   77.439667][ T1169] FS:  0000000000000000(0000)
GS:ffff8881f6600000(0000) knlGS:0000000000000000
[   77.440842][ T1169] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   77.441688][ T1169] CR2: 00007ffc05495ff0 CR3: 000000010cdf0000
CR4: 00000000001006f0
[   77.442720][ T1169] Call Trace:
[   77.443167][ T1169]  <TASK>
[   77.443555][ T1169]  slab_free_freelist_hook+0x89/0x160
[   77.444302][ T1169]  ? devres_release_all+0x262/0x350
[   77.444990][ T1169]  __kmem_cache_free+0x71/0x110
[   77.445638][ T1169]  devres_release_all+0x262/0x350
[   77.446309][ T1169]  ? devres_release+0x90/0x90
[   77.446978][ T1169]  device_release_driver_internal+0x5e5/0x8a0
[   77.447748][ T1169]  bus_remove_device+0x2ea/0x400
[   77.448421][ T1169]  device_del+0x64f/0xb40
[   77.448976][ T1169]  ? kill_device+0x150/0x150
[   77.449577][ T1169]  ? print_irqtrace_events+0x1f0/0x1f0
[   77.450307][ T1169]  hid_destroy_device+0x66/0x100
[   77.450938][ T1169]  usbhid_disconnect+0x9a/0xc0
```

To: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Hanno Zulla <kontakt@hanno.de>
To: Carlo Caione <carlo@endlessm.com>
To: Pavel Machek <pavel@ucw.cz>
To: Lee Jones <lee@kernel.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>
To: Sven Eckelmann <sven@narfation.org>
Cc: linux-leds@vger.kernel.org
Cc: Cristiano Giuffrida <c.giuffrida@vu.nl>
Cc: "Bos, H.J." <h.j.bos@vu.nl>
Cc: Jakob Koschel <jkl820.git@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Roderick Colenbrander <roderick@gaikai.com>
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>

---
Pietro Borrello (5):
      HID: bigben_remove: manually unregister leds
      HID: asus_remove: manually unregister led
      HID: dualsense_remove: manually unregister leds
      HID: dualshock4_remove: manually unregister leds
      HID: sony_remove: manually unregister leds

 drivers/hid/hid-asus.c        | 1 +
 drivers/hid/hid-bigbenff.c    | 5 +++++
 drivers/hid/hid-playstation.c | 8 ++++++++
 drivers/hid/hid-sony.c        | 8 ++++++++
 4 files changed, 22 insertions(+)
---
base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
change-id: 20230125-hid-unregister-leds-4cbf67099e1d

Best regards,
-- 
Pietro Borrello <borrello@diag.uniroma1.it>
