Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3769B730928
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbjFNU1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjFNU11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:27:27 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C5D2116
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:27:25 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-39ce0ab782fso2668241b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686774445; x=1689366445;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wCUDP5YpW2e47GeuQaojWbzYMA9cKbBIXgknngPRz+M=;
        b=6TvYLq+MZFyIhiwidHr3ul6zMdvaLauy1lVpTmwa5uYot76Sz975rwx8g+Xxx/Q+aB
         S0qBekTbbBWmeN40efbYRu5g78kbN1XvGOM6T1ZWNRBYXG1UW8MwfQPRI4MZebY6hw8c
         1dhmf4xNhw0ecjTDldGdyY4E0uc0pIRFEHPT/+HUItE4ZtfyH6lP/VmIFzj8a3NGNt0D
         SoooUhU3fMJfaElBMe747VqYSISX1NCLeYTQViqu62BwC17B5MpTweIxBR0Zm2pJvvIW
         gdpN2ajs2rFs7HPAdcyg58IobJnaXES8DjguA5TfvDUb77kLMa7+gNsMNXEchaJcFRDl
         0gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686774445; x=1689366445;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCUDP5YpW2e47GeuQaojWbzYMA9cKbBIXgknngPRz+M=;
        b=IPN/T97+18uUgXcoHNEHUL9fJMzwvARc2NfCAI0gKl6wc07eqeVW8UYiqxEeQhbnbG
         8Jrz9rqzJakfsWtUX6cAaKRVpfDChGHaCRHnWKSkJzveMHKFNrsKohZgniRQmIIvrc4X
         aAWZSfrMjfe8/qf2moruAN3H0Hzms00D9FFIwnqI1AczMlhFNi/O+zGWu21wu2A4PXig
         Qhbv5nW//r8NwWePkF6jFK5pbCpivIjlOP9aM09BVH7Rr+meRMPk1V7nTi14nL7Q93JF
         ep8Er0kiwLoi7zDwb96/gxdCZb9QonmFIgTbHsqUpW2MAqEs0YW7BoKsr6EEpxvMgv7M
         lF+g==
X-Gm-Message-State: AC+VfDxOQ8EOdo0PeW5qRofdaG9GMrQVa1SCLw6u9JUe2FTsfd5wN3uX
        DvsSTbNEvj+SLoolDwDLUsayXVi27Httm3Pr2RZ1eQ==
X-Google-Smtp-Source: ACHHUZ48OyKCkJsPbov9rpzIzbgfbI8O7LPtxIwwZFc8jHKzgjRrUxUGEtrkeOHV/mHxmJM/pOWjgST/Esg07ywERzw=
X-Received: by 2002:a05:6808:aa6:b0:398:5d57:3d08 with SMTP id
 r6-20020a0568080aa600b003985d573d08mr11477349oij.37.1686774444974; Wed, 14
 Jun 2023 13:27:24 -0700 (PDT)
MIME-Version: 1.0
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 14 Jun 2023 16:26:49 -0400
Message-ID: <CADyq12w_c=pq5sph9Ne+nshz2haeYK-kGYVwQTUqSb3W_kzrdA@mail.gmail.com>
Subject: thunderbolt: resume from hibernation CPUs racing in tb_ring_start
To:     Takashi Iwai <tiwai@suse.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Matthias Kaehlcke <mka@google.com>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On ChromeOS we're running a 5.15 kernel patched up to 6.4-rc6 w.r.t to
drivers/thunderbolt code and we're seeing a similar issue to the one
discussed in https://lore.kernel.org/lkml/20230421140725.495-1-mario.limonciello@amd.com/T/#
/ https://bugzilla.kernel.org/show_bug.cgi?id=217343 where when
resuming from hibernation you'll see warnings along the lines of

[  126.292769] thunderbolt 0000:00:0d.3: interrupt for RX ring 0 is
already enabled

The thing that's odd is it appears three CPUs are racing through this code path:

[  126.292076] ------------[ cut here ]------------
[  126.292077] thunderbolt 0000:00:0d.2: interrupt for TX ring 0 is
already enabled
[  126.292080] proc_thermal_pci 0000:00:04.0: PM:
pci_pm_thaw_noirq+0x0/0x7c returned 0 after 606 usecs
[  126.292086] ------------[ cut here ]------------
[  126.292087] thunderbolt 0000:00:0d.3: interrupt for TX ring 0 is
already enabled
[  126.292089] WARNING: CPU: 6 PID: 7879 at
drivers/thunderbolt/nhi.c:138 ring_interrupt_active+0x1cd/0x225
[  126.292092] Modules linked in:
[  126.292091] WARNING: CPU: 0 PID: 175 at
drivers/thunderbolt/nhi.c:138 ring_interrupt_active+0x1cd/0x225
[  126.292157] CPU: 0 PID: 175 Comm: kworker/u24:2 Tainted: G     U
        5.15.116-19568-g766d8095041b #24
fdadcb2517d1d37363ad385ffddbc1ad5dc72550
[  126.292158]  lzo_rle zram joydev
[  126.292159] Hardware name: Google Anahera/Anahera, BIOS
Google_Anahera.14505.143.0 06/22/2022
[  126.292159]
[  126.292160] Workqueue: events_unbound async_run_entry_fn
[  126.292160] CPU: 6 PID: 7879 Comm: kworker/u24:13 Tainted: G     U
          5.15.116-19568-g766d8095041b #24
fdadcb2517d1d37363ad385ffddbc1ad5dc72550
[  126.292162]
[  126.292162] RIP: 0010:ring_interrupt_active+0x1cd/0x225
[  126.292163] Hardware name: Google Anahera/Anahera, BIOS
Google_Anahera.14505.143.0 06/22/2022
[  126.292163] Code: 0f 44 ce 45 8b 46 14 48 c7 c6 98 a9 75 82 49 c7
c1 9f ee 72 82 84 db 4c 0f 45 ce 48 c7 c7 3e d8 6f 82 48 89 c6 e8 96
cb 53 ff <0f> 0b 49 8c
[  126.292164] Workqueue: events_unbound async_run_entry_fn
[  126.292164] RSP: 0000:ffffc90000777d18 EFLAGS: 00010046
[  126.292166]
[  126.292166] RAX: c7428cb6704ffd00 RBX: 0000000000000001 RCX: ffffffff82a5eff8
[  126.292166] RIP: 0010:ring_interrupt_active+0x1cd/0x225
[  126.292167] RDX: c7428cb6704ffd00 RSI: 0000000000000086 RDI: 0000000000000001
[  126.292168] RBP: ffffc90000777d48 R08: 000000000000070c R09: ffffffff83167704
[  126.292169] R10: 0000000200000000 R11: ffffffffffffffff R12: 0000000000038200
[  126.292168] Code: 0f 44 ce 45 8b 46 14 48 c7 c6 98 a9 75 82 49 c7
c1 9f ee 72 82 84 db 4c 0f 45 ce 48 c7 c7 3e d8 6f 82 48 89 c6 e8 96
cb 53 ff <0f> 0b 49 8c
[  126.292169] R13: 0000000000001001 R14: ffff888103348600 R15: 0000000000000001
[  126.292170] RSP: 0000:ffffc9000ca17d18 EFLAGS: 00010046
[  126.292170] FS:  0000000000000000(0000) GS:ffff88846f800000(0000)
knlGS:0000000000000000
[  126.292171]
[  126.292171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  126.292171] RAX: d9637f716c437500 RBX: 0000000000000001 RCX: ffffffff82a5eff8
[  126.292172] CR2: 00005b6c529532b8 CR3: 0000000286340000 CR4: 0000000000752ef0
[  126.292172] RDX: d9637f716c437500 RSI: 0000000000000086 RDI: 0000000000000001
[  126.292173] PKRU: 55555554
[  126.292173] Call Trace:
[  126.292174] RBP: ffffc9000ca17d48 R08: 0000000000000709 R09: ffffffff8316761c
[  126.292175]  <TASK>
[  126.292175] R10: 0000000200000000 R11: ffffffffffffffff R12: 0000000000038200
[  126.292176] R13: 0000000000001001 R14: ffff8881016a4840 R15: 0000000000000001
[  126.292176] FS:  0000000000000000(0000) GS:ffff88846f980000(0000)
knlGS:0000000000000000
[  126.292176]  ? __warn+0xa3/0x131
[  126.292178] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  126.292178]  ? ring_interrupt_active+0x1cd/0x225
[  126.292179] CR2: 0000000000000000 CR3: 0000000002a0c000 CR4: 0000000000752ee0
[  126.292180] PKRU: 55555554
[  126.292179]  ? report_bug+0x97/0xfa
[  126.292180] Call Trace:
[  126.292182]  <TASK>
[  126.292181]  ? handle_bug+0x41/0x66
[  126.292183]  ? exc_invalid_op+0x1b/0x4b
[  126.292183]  ? asm_exc_invalid_op+0x16/0x20
[  126.292183]  ? __warn+0xa3/0x131
[  126.292185]  ? ring_interrupt_active+0x1cd/0x225
[  126.292186]  ? ring_interrupt_active+0x1cd/0x225
[  126.292186]  ? ring_interrupt_active+0x1cd/0x225
[  126.292187]  tb_ring_start+0x1ba/0x1d7
[  126.292187]  ? report_bug+0x97/0xfa
[  126.292188]  tb_ctl_start+0x18/0x49
[  126.292189]  tb_domain_thaw_noirq+0x2a/0x5e
[  126.292189]  ? handle_bug+0x41/0x66
[  126.292190]  ? pci_pm_freeze_noirq+0xb8/0xb8
[  126.292191]  ? exc_invalid_op+0x1b/0x4b
[  126.292192]  dpm_run_callback+0x3c/0x12d
[  126.292192]  ? asm_exc_invalid_op+0x16/0x20
[  126.292193]  device_resume_noirq+0x10e/0x1dc
[  126.292194]  ? ring_interrupt_active+0x1cd/0x225
[  126.292194]  async_resume_noirq+0x1f/0x5b
[  126.292195]  ? ring_interrupt_active+0x1cd/0x225
[  126.292195]  async_run_entry_fn+0x2b/0xc4
[  126.292196]  tb_ring_start+0x1ba/0x1d7
[  126.292197]  process_one_work+0x1b7/0x469
[  126.292198]  worker_thread+0x11a/0x288
[  126.292198]  tb_ctl_start+0x18/0x49
[  126.292199]  kthread+0x13a/0x152
[  126.292200]  tb_domain_thaw_noirq+0x2a/0x5e
[  126.292201]  ? process_one_work+0x469/0x469
[  126.292202]  ? kthread_blkcg+0x31/0x31
[  126.292201]  ? pci_pm_freeze_noirq+0xb8/0xb8
[  126.292202]  ret_from_fork+0x1f/0x30
[  126.292203]  dpm_run_callback+0x3c/0x12d
[  126.292205]  </TASK>
[  126.292205]  device_resume_noirq+0x10e/0x1dc
[  126.292206] ---[ end trace 349544d25453a0c7 ]---
[  126.292206]  async_resume_noirq+0x1f/0x5b
[  126.292208]  async_run_entry_fn+0x2b/0xc4
[  126.292209]  process_one_work+0x1b7/0x469
[  126.292210]  worker_thread+0x11a/0x288
[  126.292212]  kthread+0x13a/0x152
[  126.292213]  ? process_one_work+0x469/0x469
[  126.292214]  ? kthread_blkcg+0x31/0x31
[  126.292215]  ret_from_fork+0x1f/0x30
[  126.292218]  </TASK>
[  126.292218] ---[ end trace 349544d25453a0c8 ]---
[  126.292225] ------------[ cut here ]------------
[  126.292226] thunderbolt 0000:00:0d.2: interrupt for RX ring 0 is
already enabled
[  126.292231] WARNING: CPU: 2 PID: 7879 at
drivers/thunderbolt/nhi.c:138 ring_interrupt_active+0x1cd/0x225
[  126.292233] Modules linked in: snd_seq_dummy snd_seq snd_seq_device
bridge stp llc tun vhost_vsock vhost vhost_iotlb
vmw_vsock_virtio_transport_common vsockg
[  126.292253]  videobuf2_memops btintel cdc_ether usbnet btmtk
videobuf2_common btbcm snd_intel_sdw_acpi kfifo_buf mei_hdcp
cros_ec_typec industrialio snd_socv
[  126.292261] CPU: 2 PID: 7879 Comm: kworker/u24:13 Tainted: G     U
W         5.15.116-19568-g766d8095041b #24
fdadcb2517d1d37363ad385ffddbc1ad5dc72550
[  126.292263] Hardware name: Google Anahera/Anahera, BIOS
Google_Anahera.14505.143.0 06/22/2022
[  126.292264] Workqueue: events_unbound async_run_entry_fn
[  126.292266] RIP: 0010:ring_interrupt_active+0x1cd/0x225
[  126.292267] Code: 0f 44 ce 45 8b 46 14 48 c7 c6 98 a9 75 82 49 c7
c1 9f ee 72 82 84 db 4c 0f 45 ce 48 c7 c7 3e d8 6f 82 48 89 c6 e8 96
cb 53 ff <0f> 0b 49 8c
[  126.292268] RSP: 0000:ffffc9000ca17d18 EFLAGS: 00010046
[  126.292269] RAX: d9637f716c437500 RBX: 0000000000000001 RCX: ffffffff82a5eff8
[  126.292270] RDX: d9637f716c437500 RSI: 0000000000000086 RDI: 0000000000000001
[  126.292270] RBP: ffffc9000ca17d48 R08: 000000000000081a R09: ffffffff8316a02c
[  126.292271] R10: 0000000200000000 R11: ffffffffffffffff R12: 0000000000038200
[  126.292272] R13: 0000000000001001 R14: ffff8881016a4780 R15: 0000000000001000
[  126.292272] FS:  0000000000000000(0000) GS:ffff88846f880000(0000)
knlGS:0000000000000000
[  126.292273] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  126.292274] CR2: 0000000000000000 CR3: 0000000002a0c000 CR4: 0000000000752ee0
[  126.292274] PKRU: 55555554
[  126.292275] Call Trace:
[  126.292275]  <TASK>
[  126.292276]  ? __warn+0xa3/0x131
[  126.292278]  ? ring_interrupt_active+0x1cd/0x225
[  126.292279]  ? report_bug+0x97/0xfa
[  126.292281]  ? handle_bug+0x41/0x66
[  126.292281]  ? exc_invalid_op+0x1b/0x4b
[  126.292282]  ? asm_exc_invalid_op+0x16/0x20
[  126.292284]  ? ring_interrupt_active+0x1cd/0x225
[  126.292284]  ? ring_interrupt_active+0x1cd/0x225
[  126.292285]  tb_ring_start+0x1ba/0x1d7
[  126.292286]  tb_ctl_start+0x21/0x49
[  126.292287]  tb_domain_thaw_noirq+0x2a/0x5e
[  126.292288]  ? pci_pm_freeze_noirq+0xb8/0xb8
[  126.292289]  dpm_run_callback+0x3c/0x12d
[  126.292290]  device_resume_noirq+0x10e/0x1dc
[  126.292291]  async_resume_noirq+0x1f/0x5b
[  126.292292]  async_run_entry_fn+0x2b/0xc4
[  126.292293]  process_one_work+0x1b7/0x469
[  126.292295]  worker_thread+0x11a/0x288
[  126.292295]  kthread+0x13a/0x152
[  126.292296]  ? process_one_work+0x469/0x469
[  126.292297]  ? kthread_blkcg+0x31/0x31
[  126.292298]  ret_from_fork+0x1f/0x30
[  126.292301]  </TASK>
[  126.292302] ---[ end trace 349544d25453a0c9 ]---
[  126.292306] thunderbolt 0000:00:0d.2: PM:
pci_pm_thaw_noirq+0x0/0x7c returned 0 after 825 usecs
[  126.292311] pcieport 0000:00:07.0: PM: calling
pci_pm_thaw_noirq+0x0/0x7c @ 9, parent: pci0000:00
[  126.292320] i915 0000:00:02.0: PM: calling
pci_pm_thaw_noirq+0x0/0x7c @ 7909, parent: pci0000:00
[  126.292768] ------------[ cut here ]------------
[  126.292769] thunderbolt 0000:00:0d.3: interrupt for RX ring 0 is
already enabled
[  126.292777] WARNING: CPU: 6 PID: 175 at
drivers/thunderbolt/nhi.c:138 ring_interrupt_active+0x1cd/0x225
[  126.292779] Modules linked in: snd_seq_dummy snd_seq snd_seq_device
bridge stp llc tun vhost_vsock vhost vhost_iotlb
vmw_vsock_virtio_transport_common vsockg
[  126.292798]  videobuf2_memops btintel cdc_ether usbnet btmtk
videobuf2_common btbcm snd_intel_sdw_acpi kfifo_buf mei_hdcp
cros_ec_typec industrialio snd_socv
[  126.292807] CPU: 6 PID: 175 Comm: kworker/u24:2 Tainted: G     U  W
        5.15.116-19568-g766d8095041b #24
fdadcb2517d1d37363ad385ffddbc1ad5dc72550
[  126.292809] Hardware name: Google Anahera/Anahera, BIOS
Google_Anahera.14505.143.0 06/22/2022
[  126.292810] Workqueue: events_unbound async_run_entry_fn
[  126.292811] RIP: 0010:ring_interrupt_active+0x1cd/0x225
[  126.292812] Code: 0f 44 ce 45 8b 46 14 48 c7 c6 98 a9 75 82 49 c7
c1 9f ee 72 82 84 db 4c 0f 45 ce 48 c7 c7 3e d8 6f 82 48 89 c6 e8 96
cb 53 ff <0f> 0b 49 8c
[  126.292814] RSP: 0000:ffffc90000777d18 EFLAGS: 00010046
[  126.292815] RAX: c7428cb6704ffd00 RBX: 0000000000000001 RCX: ffffffff82a5eff8
[  126.292815] RDX: c7428cb6704ffd00 RSI: 0000000000000086 RDI: 0000000000000001
[  126.292816] RBP: ffffc90000777d48 R08: 000000000000084b R09: ffffffff8316b08c
[  126.292817] R10: 0000000200000000 R11: ffffffffffffffff R12: 0000000000038200
[  126.292818] R13: 0000000000001001 R14: ffff888103348e40 R15: 0000000000001000
[  126.292818] FS:  0000000000000000(0000) GS:ffff88846f980000(0000)
knlGS:0000000000000000
[  126.292819] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  126.292820] CR2: 0000000000000000 CR3: 0000000002a0c000 CR4: 0000000000752ee0
[  126.292821] PKRU: 55555554
[  126.292822] Call Trace:
[  126.292822]  <TASK>
[  126.292823]  ? __warn+0xa3/0x131
[  126.292825]  ? ring_interrupt_active+0x1cd/0x225
[  126.292826]  ? report_bug+0x97/0xfa
[  126.292828]  ? handle_bug+0x41/0x66
[  126.292829]  ? exc_invalid_op+0x1b/0x4b
[  126.292830]  ? asm_exc_invalid_op+0x16/0x20
[  126.292831]  ? ring_interrupt_active+0x1cd/0x225
[  126.292832]  ? ring_interrupt_active+0x1cd/0x225
[  126.292833]  tb_ring_start+0x1ba/0x1d7
[  126.292834]  tb_ctl_start+0x21/0x49
[  126.292836]  tb_domain_thaw_noirq+0x2a/0x5e
[  126.292837]  ? pci_pm_freeze_noirq+0xb8/0xb8
[  126.292838]  dpm_run_callback+0x3c/0x12d
[  126.292840]  device_resume_noirq+0x10e/0x1dc
[  126.292841]  async_resume_noirq+0x1f/0x5b
[  126.292842]  async_run_entry_fn+0x2b/0xc4
[  126.292843]  process_one_work+0x1b7/0x469
[  126.292844]  worker_thread+0x11a/0x288
[  126.292845]  kthread+0x13a/0x152
[  126.292847]  ? process_one_work+0x469/0x469
[  126.292847]  ? kthread_blkcg+0x31/0x31
[  126.292849]  ret_from_fork+0x1f/0x30
[  126.292851]  </TASK>
[  126.292851] ---[ end trace 349544d25453a0ca ]---
