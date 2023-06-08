Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7997274F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjFHCUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjFHCUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:20:35 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A299F2700
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 19:20:33 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75ec7e8e826so8257485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 19:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1686190833; x=1688782833;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wgAKWYRphfE40AO6G5Ox5YqR+/zOjxjNsnTDKSarlqc=;
        b=M8Dv0hu600i7YmJ/+yfxrIDNMx+FvIKheWRycoqzaPCH61QBb8+4jOS1DDZYmnNGqz
         HmK61sD5P3DIp1mUGYTbYeXGxVLl4HCwj4WmUo9F3dKWlR5djfL6lVOJRajt1eHN00tD
         V+mbu6TIgnq406ET2ZuTyePS42DCUj8Siy1dLS6dKC7wUTps2kAxkOCuol4LugK/E9zW
         4VxFKMwU+UKsAngkVKpXRZZXPDNEGdq1K92AEnJJ4PBmSxNSx4vAyFoPON3vXqpNTvpT
         jwibI2uLhWKohEmrM2OkRqvMdIVY9hTxWCgP1w0GmmGcbeZSNbD5hFf6gDKYlaP3BjB3
         /BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686190833; x=1688782833;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgAKWYRphfE40AO6G5Ox5YqR+/zOjxjNsnTDKSarlqc=;
        b=K8e7PfkPRNScN+i3mbV9O7IhJtBiQ14CKyIP7Lsr8yi/xBv3MJPlqN7fWTZDOeVX5/
         MgInIVfPJt2QOzV4ehXz24XgYcrlbHVXXfKjSXyAWitXy6W9U7lB9cDNJ86Z+1xsIFQC
         mrUqoRrXRsld8irl3XEwlv5AzfaC+I0+O/SEhYFRYhQZQjoYDrvTnS1E71PdKwr6uhtC
         AAM0SlUjr0SJpnSf4SR2vGITX6R30P0oa2nE6cjDfLRmBI3HPq65X/TuQrjAmmCodMmk
         kSkAbs7bL7x/Ir5nz96E08fEckHMPKuHEOXHrUw0oTKW3YDonWwTWcdyezHLYVYt6YzN
         8hWA==
X-Gm-Message-State: AC+VfDzcuDfVztTN1B7aLMQLze5/T5/eRBnebvhIqp7sIsqz1O9oX1Nq
        Sl4P8396X6nrB70VliQ9fQmSjXfCDhjrKSKcZb4qXruRfcn966y8
X-Google-Smtp-Source: ACHHUZ454YIZroJ0rU7Nb/ERr7hoNtv0f64Cg0/vJlKQt3UNvWQJmm6mhk1B7CsKw7TaV4US2tTU1i5aao96an+CEs4=
X-Received: by 2002:a05:620a:4484:b0:75e:c23f:82ef with SMTP id
 x4-20020a05620a448400b0075ec23f82efmr5006642qkp.67.1686190832685; Wed, 07 Jun
 2023 19:20:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:240c:b0:5b5:2ae6:3385 with HTTP; Wed, 7 Jun 2023
 19:20:31 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Wed, 7 Jun 2023 22:20:31 -0400
Message-ID: <CADyTPExB2kYOOwkO0JqGhKaYVDqO9uS9WCw0J=MCTdVhcGOogA@mail.gmail.com>
Subject: PROBLEM: kernel NULL pointer dereference when yanking ftdi usb-serial
 during BREAK
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just hit an oops when unplugging my usb serial adapter.  So naturally,
I tried it again, and found if I use minicom to send BREAK and then
quickly yank the cable, I can reliably cause this oops every single
time.

Originally I noticed the problem on 6.1.7, but tried again on 6.4-rc5
and the exact same problem occurs.

Let me know if you need any more info!

Thanks,
  Nick

[   41.834144] ftdi_sio 1-1:1.0: FTDI USB Serial Device converter detected
[   41.834178] usb 1-1: Detected FT232R
[   41.834307] usb 1-1: FTDI USB Serial Device converter now attached to ttyUSB0
[   49.238361] usb 1-1: USB disconnect, device number 6
[   49.238592] ftdi_sio ttyUSB0: error from flowcontrol urb
[   49.238734] ftdi_sio ttyUSB0: FTDI USB Serial Device converter now
disconnected from ttyUSB0
[   49.238760] ftdi_sio 1-1:1.0: device disconnected
[   49.274543] BUG: kernel NULL pointer dereference, address: 000000000000000c
[   49.274550] #PF: supervisor read access in kernel mode
[   49.274553] #PF: error_code(0x0000) - not-present page
[   49.274555] PGD 0 P4D 0
[   49.274560] Oops: 0000 [#1] PREEMPT SMP
[   49.274564] CPU: 3 PID: 3247 Comm: minicom Not tainted 6.4.0-rc5 #20
[   49.274568] Hardware name: LENOVO 20CMCTO1WW/20CMCTO1WW, BIOS
N10ET42W (1.21 ) 02/26/2016
[   49.274572] RIP: 0010:ftdi_break_ctl+0x14/0x7b [ftdi_sio]
[   49.274584] Code: c0 e8 64 63 6a d3 ba 06 00 00 00 31 f6 48 89 df
5b e9 5c fd ff ff 55 85 f6 89 f5 53 48 8b 9f 58 02 00 00 48 8b 83 48
03 00 00 <44> 8b 40 0c 74 06 66 41 81 c8 00 40 48 8b 13 45 0f b7 c0 b9
40 00
[   49.274588] RSP: 0018:ffffb016009b3e28 EFLAGS: 00010246
[   49.274591] RAX: 0000000000000000 RBX: ffffa3f944575800 RCX: 0000000000000000
[   49.274593] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa3f940d8c400
[   49.274595] RBP: 0000000000000000 R08: ffffa3fa65d9b840 R09: 0000000000000001
[   49.274597] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000fa
[   49.274599] R13: ffffa3f940d8c400 R14: 0000000000000000 R15: 0000000000000000
[   49.274602] FS:  00007f0ffcedc740(0000) GS:ffffa3fa65d80000(0000)
knlGS:0000000000000000
[   49.274605] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.274607] CR2: 000000000000000c CR3: 000000010c981004 CR4: 00000000003706e0
[   49.274610] Call Trace:
[   49.274613]  <TASK>
[   49.274614]  ? __die_body+0x15/0x53
[   49.274620]  ? page_fault_oops+0x2e8/0x31c
[   49.274625]  ? psi_group_change+0x237/0x298
[   49.274631]  ? get_sd_balance_interval+0xf/0x39
[   49.274637]  ? newidle_balance+0x25f/0x2c6
[   49.274641]  ? exc_page_fault+0x14b/0x4b8
[   49.274647]  ? asm_exc_page_fault+0x22/0x30
[   49.274653]  ? ftdi_break_ctl+0x14/0x7b [ftdi_sio]
[   49.274661]  serial_break+0x1c/0x1f [usbserial]
[   49.274672]  send_break+0x7f/0xa6
[   49.274678]  tty_ioctl+0x46e/0x6b3
[   49.274683]  ? vfs_write+0x15d/0x188
[   49.274688]  vfs_ioctl+0x16/0x23
[   49.274692]  __do_sys_ioctl+0x52/0x74
[   49.274698]  do_syscall_64+0x7f/0x9f
[   49.274702]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   49.274708] RIP: 0033:0x7f0ffcfdec7b
[   49.274711] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24
10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28
00 00
[   49.274713] RSP: 002b:00007ffc18ab3a00 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   49.274717] RAX: ffffffffffffffda RBX: 00005562830d74bc RCX: 00007f0ffcfdec7b
[   49.274719] RDX: 0000000000000000 RSI: 0000000000005409 RDI: 0000000000000003
[   49.274721] RBP: 0000556284ef1d60 R08: 00007f0ffd076440 R09: 0000000000000064
[   49.274723] R10: 00007f0ffcee7450 R11: 0000000000000246 R12: 00005562830e9130
[   49.274726] R13: 00007ffc18ab3ad0 R14: 00005562830d6ee8 R15: 0000000000000004
[   49.274728]  </TASK>
[   49.274730] Modules linked in: ftdi_sio usbserial ccm nfs lockd
grace bridge stp llc xt_state iptable_filter iptable_mangle
xt_MASQUERADE xt_mark iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ip_tables x_tables snd_hda_codec_hdmi squashfs loop
nls_iso8859_1 nls_cp437 vfat fat ext4 crc16 mbcache jbd2 iwlmvm i915
mac80211 snd_ctl_led libarc4 snd_hda_codec_realtek
snd_hda_codec_generic i2c_algo_bit drm_buddy drm_display_helper
uvcvideo iwlwifi drivetemp videobuf2_vmalloc drm_kms_helper
snd_hda_intel coretemp videobuf2_memops uvc snd_intel_dspcfg
videobuf2_v4l2 syscopyarea x86_pkg_temp_thermal sysfillrect
snd_hda_codec thinkpad_acpi sysimgblt cec videodev nvram snd_hda_core
cfg80211 kvm_intel ttm ledtrig_audio snd_pcm videobuf2_common
platform_profile jc42 regmap_i2c kvm irqbypass mc rfkill hwmon thermal
drm intel_gtt ac snd_timer agpgart battery snd video soundcore wmi
evdev efivarfs rtsx_pci_sdmmc mmc_core sha512_ssse3 e1000e rtsx_pci
ptp mfd_core pps_core ipv6 sunrpc
[   49.274823] CR2: 000000000000000c
[   49.274825] ---[ end trace 0000000000000000 ]---
[   49.274827] RIP: 0010:ftdi_break_ctl+0x14/0x7b [ftdi_sio]
[   49.274835] Code: c0 e8 64 63 6a d3 ba 06 00 00 00 31 f6 48 89 df
5b e9 5c fd ff ff 55 85 f6 89 f5 53 48 8b 9f 58 02 00 00 48 8b 83 48
03 00 00 <44> 8b 40 0c 74 06 66 41 81 c8 00 40 48 8b 13 45 0f b7 c0 b9
40 00
[   49.274838] RSP: 0018:ffffb016009b3e28 EFLAGS: 00010246
[   49.274841] RAX: 0000000000000000 RBX: ffffa3f944575800 RCX: 0000000000000000
[   49.274843] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffa3f940d8c400
[   49.274845] RBP: 0000000000000000 R08: ffffa3fa65d9b840 R09: 0000000000000001
[   49.274847] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000fa
[   49.274849] R13: ffffa3f940d8c400 R14: 0000000000000000 R15: 0000000000000000
[   49.274851] FS:  00007f0ffcedc740(0000) GS:ffffa3fa65d80000(0000)
knlGS:0000000000000000
[   49.274853] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.274855] CR2: 000000000000000c CR3: 000000010c981004 CR4: 00000000003706e0
[   49.274858] note: minicom[3247] exited with irqs disabled
