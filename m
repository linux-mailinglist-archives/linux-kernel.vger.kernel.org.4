Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41925743210
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 03:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjF3BBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 21:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjF3BBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 21:01:32 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0015E2D4C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 18:01:27 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-78f6a9800c9so459914241.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 18:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1688086887; x=1690678887;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xOVrvxcmCSBzNPiQV7BByJXToAaCG952qVeGfWGAUAQ=;
        b=pWiplI3CUSSd74PeUeohSx/ZQeDss57n/4Go5PxNSaJ7OMxAtjChwGGSBhU3hvxAGg
         iwBRn/WevuZ3xabVZh/7x51qtdJ/3lSgG6rpaHaoHcK4+eSiGU3XNz/k9FEiGBqMEZDE
         Qe48egp5KWwWyj8MFT8BxuHmRaUIsCdavQDg1Ruq9ydP5ybUpdfXzmCcSSucj10Sgx3M
         KDfDl0jYcbUrnYELm69uynJHtMuQ9dKSwMGgywut5G2NgVqp1DOu3u6/8+JmKuxMl7HP
         Q09S1Q9W+R2yajET3uWaly/5DCq5XtqXrSuBuCYL60GSFQcOxmj0Cy44gJJz5FVd+YoP
         V7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688086887; x=1690678887;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xOVrvxcmCSBzNPiQV7BByJXToAaCG952qVeGfWGAUAQ=;
        b=hhnyw7B83+r0emF7WPBrH6CBvJmfK82LH9XQDcvH+3kR/ejHWVnvFggEG3Ujfp4+6A
         hz8OQuupnkAeIMysFm+5De5Q9p53KaX1IRLJ/ckeGOmIOZJRwMoNFxcAYejRaIu1QoFw
         R5YwEkpo13lcUyPvybfTrgurAbjmcof84LPqF/ruKE9oOAY0tYg58sd5jlWcw9ywrDk/
         L7Ns1rDJjlKrFhpR/yGF1Dz3s0OIwXmcOBFrmAfMP73fRDsoa3XsrKNqgfgQDHyeWeLJ
         kGr1qW3LX2TRRGSNgjw89pwahhFFqOx4gZqAlr6Jh0CdWXo/d+x+P++DQ9w/ThAGAbzS
         nnsA==
X-Gm-Message-State: ABy/qLaqfporABw/LkPln6K08Y4WqEWAQs2Pa5GNsJje9EIt5TetsxxZ
        uQWaTqeadueHi/U583yqDjNQPhJ2Ms5h/aFBDDK7EkYkjFsGdFgo
X-Google-Smtp-Source: APBJJlFn4IkcoxsPvSyRWPCloVvLbH7lwe6Vf2WjM0iwR3P55qkZYyFu2zNfEkSeswEHVhLZc1Px+P5l2vJvX+aItws=
X-Received: by 2002:a67:fa19:0:b0:443:6052:43a7 with SMTP id
 i25-20020a67fa19000000b00443605243a7mr1152098vsq.32.1688086886415; Thu, 29
 Jun 2023 18:01:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:239a:0:b0:794:1113:bb24 with HTTP; Thu, 29 Jun 2023
 18:01:25 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Thu, 29 Jun 2023 21:01:25 -0400
Message-ID: <CADyTPEwW3MThhM_h95Dkhcrvi+McEirgzA9ofww7865fgY5+=Q@mail.gmail.com>
Subject: PROBLEM: zswap+z3fold kernel crashes under memory pressure
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
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

With 6.4.0, I noticed my system hanging "randomly", eventually
identifying it as being related to memory pressure and ultimately
finding out it is caused by enabling zswap+z3fold.  As this seemed
to be a new problem I thought it was a regression but apparently not
-- I can reproduce the exact same problem all the way back with Linux
5.4 (I did not test any earlier versions).  So as far as I can tell
this configuration has simply never worked reliably.

There is no similar failure if I use zbud instead of z3fold.

I reproduce the problem with the following program which triggers the
failure 100% of the time in just a matter of seconds:

  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>

  #define CHUNKSZ (1024ul*1024*100)

  int main(void)
  {
  	unsigned long long total = 0;
  	void *p;
  	
  	while (1) {
  		p = malloc(CHUNKSZ);
  		memset(p, 0x5a, CHUNKSZ);

  		printf("alloced %llu\n", (total += CHUNKSZ));
  	}
  }

When it dies there are a bunch of WARNING messages printed, but only
at higher log levels.  With low console log level (1) there is no
indication of any problem except that the system has simply stopped
responding to just about everything (doesn't even respond to ping).
"Just about", because the system does respond to magic sysrq.

Console output at dmesg -n8 follows.

Let me know if you need any more info!

Thanks,
  Nick

[  203.693643] oom[2022]: segfault at 8 ip 00000000f7ddb508 sp
00000000ffe635b8 error 6 in libc.so.6[f7d5e000+151000] likely on CPU 0
(core 0, socket 0)
[  203.709663] Code: 00 83 fa 20 77 1c 0f 11 07 0f 11 44 17 f0 c3 0f
1f 00 0f 11 47 e0 0f 11 47 f0 c3 0f 1f 80 00 00 00 00 3b 15 6a 2e 12
00 77 68 <0f> 11 07 0f 11 47 10 48 01 d7 48 83 fa 40 76 d8 0f 11 40 20
0f 11
[  203.821596] ------------[ cut here ]------------
[  203.822180] WARNING: CPU: 0 PID: 2022 at mm/z3fold.c:741
do_compact_page+0x69/0x980
[  203.822180] Modules linked in: sha1_generic cts rpcsec_gss_krb5
auth_rpcgss oid_registry snd_emu10k1 snd_hwdep snd_util_mem
snd_ac97_codec ac97_bus snd_pcm firewire_ohci drivetemp snd_timer
firewire_core k8temp crc_itu_t emu10k1_gp pata_amd i2c_nforce2
snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device ns558 snd
gameport soundcore floppy
[  203.822180] CPU: 0 PID: 2022 Comm: oom Not tainted 6.4.0 #1
[  203.822180] Hardware name: ASUSTek Computer Inc.
K8N-E-Deluxe/'K8N-E-Deluxe', BIOS 1012.007 01/18/2006
[  203.822180] RIP: 0010:do_compact_page+0x69/0x980
[  203.822180] Code: 2b 0d 43 8e a7 00 45 31 e4 48 01 d1 48 c1 e9 0c
48 c1 e1 06 48 03 0d 1e 8e a7 00 ff 05 98 09 e0 00 40 84 f6 0f 84 89
02 00 00 <0f> 0b 48 0f ba 71 28 02 0f 83 9f 03 00 00 ff 05 7b 09 e0 00
48 8b
[  203.822180] RSP: 0018:ffffaa18c02a3a90 EFLAGS: 00010002
[  203.822180] RAX: 0000000000000002 RBX: ffff8d83c4ed3000 RCX: ffffe1a5c013b4c0
[  203.822180] RDX: ffff8d8444ed3000 RSI: 0000000000000001 RDI: ffff8d83c4ed3000
[  203.822180] RBP: ffff8d83c359a938 R08: ffffe1a5c0000000 R09: ffffffff80000000
[  203.822180] R10: 0000000074a00000 R11: ffffe1a5c0529b88 R12: 0000000000000000
[  203.822180] R13: ffff8d83c353ec00 R14: 03ffffffffffffff R15: ffff8d83c19a5700
[  203.822180] FS:  00000000f7f112c0(0000) GS:ffffffff9c635000(0000)
knlGS:0000000000000000
[  203.822180] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  203.822180] CR2: 00000000f77976ac CR3: 0000000003a9d000 CR4: 00000000000006f0
[  203.822180] Call Trace:
[  203.822180]  <TASK>
[  203.822180]  ? __warn+0x61/0xe0
[  203.822180]  ? do_compact_page+0x69/0x980
[  203.822180]  ? report_bug+0x150/0x190
[  203.822180]  ? handle_bug+0x3c/0x60
[  203.822180]  ? exc_invalid_op+0x1f/0x90
[  203.822180]  ? __switch_to_asm+0x2a/0x50
[  203.822180]  ? asm_exc_invalid_op+0x16/0x20
[  203.822180]  ? do_compact_page+0x69/0x980
[  203.822180]  ? free_pcppages_bulk+0x115/0x170
[  203.822180]  zswap_free_entry+0x7b/0xc0
[  203.822180]  zswap_frontswap_invalidate_page+0x65/0xa0
[  203.822180]  __frontswap_invalidate_page+0x36/0x60
[  203.822180]  swapcache_free_entries+0x19e/0x2d0
[  203.822180]  free_swap_slot+0x99/0xb0
[  203.822180]  __swap_entry_free+0x6c/0x90
[  203.822180]  free_swap_and_cache+0x3b/0xe0
[  203.822180]  unmap_page_range+0x303/0xbb0
[  203.822180]  unmap_vmas+0x8e/0xb0
[  203.822180]  exit_mmap+0x95/0x1b0
[  203.822180]  mmput+0x18/0xc0
[  203.822180]  do_exit+0x263/0x970
[  203.822180]  do_group_exit+0x23/0x70
[  203.822180]  get_signal+0x8ad/0x8b0
[  203.822180]  arch_do_signal_or_restart+0x23/0x260
[  203.822180]  ? __bad_area_nosemaphore.constprop.0+0x112/0x230
[  203.822180]  ? exc_page_fault+0x36f/0x590
[  203.822180]  exit_to_user_mode_prepare+0xab/0x110
[  203.822180]  irqentry_exit_to_user_mode+0x5/0x10
[  203.822180]  asm_exc_page_fault+0x22/0x30
[  203.822180] RIP: 0033:0xf7ddb508
[  203.822180] Code: Unable to access opcode bytes at 0xf7ddb4de.
[  203.822180] RSP: 002b:00000000ffe635b8 EFLAGS: 00010202
[  203.822180] RAX: 0000000000000000 RBX: 00000000ffe636d4 RCX: 0000000000000000
[  203.822180] RDX: 0000000006400000 RSI: 000000000000005a RDI: 0000000000000000
[  203.822180] RBP: 00000000ffe635d0 R08: ffffffffffffffff R09: 0000000000000000
[  203.822180] R10: 0000000000000022 R11: 000000005786c000 R12: 0000000000000000
[  203.822180] R13: 00000000565f8165 R14: 00000000f7f44000 R15: 00000000565faecc
[  203.822180]  </TASK>
[  203.822180] ---[ end trace 0000000000000000 ]---
[  204.141429] ------------[ cut here ]------------
[  204.146048] WARNING: CPU: 0 PID: 2022 at mm/z3fold.c:741
do_compact_page+0x69/0x980
[  204.153709] Modules linked in: sha1_generic cts rpcsec_gss_krb5
auth_rpcgss oid_registry snd_emu10k1 snd_hwdep snd_util_mem
snd_ac97_codec ac97_bus snd_pcm firewire_ohci drivetemp snd_timer
firewire_core k8temp crc_itu_t emu10k1_gp pata_amd i2c_nforce2
snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device ns558 snd
gameport soundcore floppy
[  204.183834] CPU: 0 PID: 2022 Comm: oom Tainted: G        W          6.4.0 #1
[  204.190879] Hardware name: ASUSTek Computer Inc.
K8N-E-Deluxe/'K8N-E-Deluxe', BIOS 1012.007 01/18/2006
[  204.200187] RIP: 0010:do_compact_page+0x69/0x980
[  204.204807] Code: 2b 0d 43 8e a7 00 45 31 e4 48 01 d1 48 c1 e9 0c
48 c1 e1 06 48 03 0d 1e 8e a7 00 ff 05 98 09 e0 00 40 84 f6 0f 84 89
02 00 00 <0f> 0b 48 0f ba 71 28 02 0f 83 9f 03 00 00 ff 05 7b 09 e0 00
48 8b
[  204.223553] RSP: 0018:ffffaa18c02a3a90 EFLAGS: 00010202
[  204.228779] RAX: 0000000000000002 RBX: ffff8d83c3482000 RCX: ffffe1a5c00d2080
[  204.235912] RDX: ffff8d8443482000 RSI: 0000000000000001 RDI: ffff8d83c3482000
[  204.243043] RBP: ffff8d83c359a938 R08: ffffe1a5c0000000 R09: ffffffff80000000
[  204.250185] R10: ffff8d83c214bc80 R11: ffff8d83c10423c0 R12: 0000000000000000
[  204.257318] R13: ffff8d83c353ec00 R14: 03ffffffffffffff R15: ffff8d83c19a5700
[  204.264451] FS:  00000000f7f112c0(0000) GS:ffffffff9c635000(0000)
knlGS:0000000000000000
[  204.272536] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  204.278282] CR2: 00000000f77976ac CR3: 0000000003a9d000 CR4: 00000000000006f0
[  204.285416] Call Trace:
[  204.287869]  <TASK>
[  204.289974]  ? __warn+0x61/0xe0
[  204.293120]  ? do_compact_page+0x69/0x980
[  204.297134]  ? report_bug+0x150/0x190
[  204.300800]  ? handle_bug+0x3c/0x60
[  204.304291]  ? exc_invalid_op+0x1f/0x90
[  204.308132]  ? __switch_to_asm+0x2a/0x50
[  204.312056]  ? asm_exc_invalid_op+0x16/0x20
[  204.316243]  ? do_compact_page+0x69/0x980
[  204.320255]  ? clear_shadow_from_swap_cache+0x15c/0x1b0
[  204.325481]  zswap_free_entry+0x7b/0xc0
[  204.329330]  zswap_frontswap_invalidate_page+0x65/0xa0
[  204.334477]  __frontswap_invalidate_page+0x36/0x60
[  204.339271]  swapcache_free_entries+0x19e/0x2d0
[  204.343812]  free_swap_slot+0x99/0xb0
[  204.347486]  __swap_entry_free+0x6c/0x90
[  204.351412]  free_swap_and_cache+0x3b/0xe0
[  204.355521]  unmap_page_range+0x303/0xbb0
[  204.359542]  unmap_vmas+0x8e/0xb0
[  204.362870]  exit_mmap+0x95/0x1b0
[  204.366198]  mmput+0x18/0xc0
[  204.369084]  do_exit+0x263/0x970
[  204.372316]  do_group_exit+0x23/0x70
[  204.375895]  get_signal+0x8ad/0x8b0
[  204.379388]  arch_do_signal_or_restart+0x23/0x260
[  204.384095]  ? __bad_area_nosemaphore.constprop.0+0x112/0x230
[  204.389849]  ? exc_page_fault+0x36f/0x590
[  204.393862]  exit_to_user_mode_prepare+0xab/0x110
[  204.398576]  irqentry_exit_to_user_mode+0x5/0x10
[  204.403195]  asm_exc_page_fault+0x22/0x30
[  204.407207] RIP: 0033:0xf7ddb508
[  204.410441] Code: Unable to access opcode bytes at 0xf7ddb4de.
[  204.416273] RSP: 002b:00000000ffe635b8 EFLAGS: 00010202
[  204.421499] RAX: 0000000000000000 RBX: 00000000ffe636d4 RCX: 0000000000000000
[  204.428632] RDX: 0000000006400000 RSI: 000000000000005a RDI: 0000000000000000
[  204.435765] RBP: 00000000ffe635d0 R08: ffffffffffffffff R09: 0000000000000000
[  204.442896] R10: 0000000000000022 R11: 000000005786c000 R12: 0000000000000000
[  204.450029] R13: 00000000565f8165 R14: 00000000f7f44000 R15: 00000000565faecc
[  204.457164]  </TASK>
[  204.459355] ---[ end trace 0000000000000000 ]---
[  204.463991] ------------[ cut here ]------------
[  204.468612] WARNING: CPU: 0 PID: 2022 at mm/z3fold.c:741
do_compact_page+0x69/0x980
[  204.476272] Modules linked in: sha1_generic cts rpcsec_gss_krb5
auth_rpcgss oid_registry snd_emu10k1 snd_hwdep snd_util_mem
snd_ac97_codec ac97_bus snd_pcm firewire_ohci drivetemp snd_timer
firewire_core k8temp crc_itu_t emu10k1_gp pata_amd i2c_nforce2
snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device ns558 snd
gameport soundcore floppy
[  204.506399] CPU: 0 PID: 2022 Comm: oom Tainted: G        W          6.4.0 #1
[  204.513444] Hardware name: ASUSTek Computer Inc.
K8N-E-Deluxe/'K8N-E-Deluxe', BIOS 1012.007 01/18/2006
[  204.522744] RIP: 0010:do_compact_page+0x69/0x980
[  204.527362] Code: 2b 0d 43 8e a7 00 45 31 e4 48 01 d1 48 c1 e9 0c
48 c1 e1 06 48 03 0d 1e 8e a7 00 ff 05 98 09 e0 00 40 84 f6 0f 84 89
02 00 00 <0f> 0b 48 0f ba 71 28 02 0f 83 9f 03 00 00 ff 05 7b 09 e0 00
48 8b
[  204.546108] RSP: 0018:ffffaa18c02a3a90 EFLAGS: 00010202
[  204.551335] RAX: 0000000000000002 RBX: ffff8d83c3be7000 RCX: ffffe1a5c00ef9c0
[  204.558468] RDX: ffff8d8443be7000 RSI: 0000000000000001 RDI: ffff8d83c3be7000
[  204.565599] RBP: ffff8d83c359a938 R08: ffffe1a5c0000000 R09: ffffffff80000000
[  204.572733] R10: ffffffffffffffc0 R11: ffff8d83c10423c0 R12: 0000000000000000
[  204.579866] R13: ffff8d83c353ec00 R14: 03ffffffffffffff R15: ffff8d83c19a5700
[  204.586998] FS:  00000000f7f112c0(0000) GS:ffffffff9c635000(0000)
knlGS:0000000000000000
[  204.595085] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  204.600831] CR2: 00000000f77976ac CR3: 0000000003a9d000 CR4: 00000000000006f0
[  204.607962] Call Trace:
[  204.610417]  <TASK>
[  204.612521]  ? __warn+0x61/0xe0
[  204.615667]  ? do_compact_page+0x69/0x980
[  204.619681]  ? report_bug+0x150/0x190
[  204.623347]  ? handle_bug+0x3c/0x60
[  204.626838]  ? exc_invalid_op+0x1f/0x90
[  204.630678]  ? __switch_to_asm+0x2a/0x50
[  204.634605]  ? asm_exc_invalid_op+0x16/0x20
[  204.638798]  ? do_compact_page+0x69/0x980
[  204.642813]  ? queue_work_on+0x1a/0x30
[  204.646574]  zswap_free_entry+0x7b/0xc0
[  204.650420]  zswap_frontswap_invalidate_page+0x65/0xa0
[  204.655561]  __frontswap_invalidate_page+0x36/0x60
[  204.660361]  swapcache_free_entries+0x19e/0x2d0
[  204.664894]  free_swap_slot+0x99/0xb0
[  204.668561]  __swap_entry_free+0x6c/0x90
[  204.672496]  free_swap_and_cache+0x3b/0xe0
[  204.676602]  unmap_page_range+0x303/0xbb0
[  204.680617]  unmap_vmas+0x8e/0xb0
[  204.683945]  exit_mmap+0x95/0x1b0
[  204.687273]  mmput+0x18/0xc0
[  204.690157]  do_exit+0x263/0x970
[  204.693390]  do_group_exit+0x23/0x70
[  204.696970]  get_signal+0x8ad/0x8b0
[  204.700463]  arch_do_signal_or_restart+0x23/0x260
[  204.705168]  ? __bad_area_nosemaphore.constprop.0+0x112/0x230
[  204.710915]  ? exc_page_fault+0x36f/0x590
[  204.714936]  exit_to_user_mode_prepare+0xab/0x110
[  204.719650]  irqentry_exit_to_user_mode+0x5/0x10
[  204.724269]  asm_exc_page_fault+0x22/0x30
[  204.728282] RIP: 0033:0xf7ddb508
[  204.731514] Code: Unable to access opcode bytes at 0xf7ddb4de.
[  204.737348] RSP: 002b:00000000ffe635b8 EFLAGS: 00010202
[  204.742573] RAX: 0000000000000000 RBX: 00000000ffe636d4 RCX: 0000000000000000
[  204.749706] RDX: 0000000006400000 RSI: 000000000000005a RDI: 0000000000000000
[  204.756839] RBP: 00000000ffe635d0 R08: ffffffffffffffff R09: 0000000000000000
[  204.763970] R10: 0000000000000022 R11: 000000005786c000 R12: 0000000000000000
[  204.771103] R13: 00000000565f8165 R14: 00000000f7f44000 R15: 00000000565faecc
[  204.778237]  </TASK>
[  204.780429] ---[ end trace 0000000000000000 ]---
[  204.785058] ------------[ cut here ]------------
[  204.789676] WARNING: CPU: 0 PID: 2022 at mm/z3fold.c:741
do_compact_page+0x69/0x980
[  204.797329] Modules linked in: sha1_generic cts rpcsec_gss_krb5
auth_rpcgss oid_registry snd_emu10k1 snd_hwdep snd_util_mem
snd_ac97_codec ac97_bus snd_pcm firewire_ohci drivetemp snd_timer
firewire_core k8temp crc_itu_t emu10k1_gp pata_amd i2c_nforce2
snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device ns558 snd
gameport soundcore floppy
[  204.827454] CPU: 0 PID: 2022 Comm: oom Tainted: G        W          6.4.0 #1
[  204.834502] Hardware name: ASUSTek Computer Inc.
K8N-E-Deluxe/'K8N-E-Deluxe', BIOS 1012.007 01/18/2006
[  204.843801] RIP: 0010:do_compact_page+0x69/0x980
[  204.848419] Code: 2b 0d 43 8e a7 00 45 31 e4 48 01 d1 48 c1 e9 0c
48 c1 e1 06 48 03 0d 1e 8e a7 00 ff 05 98 09 e0 00 40 84 f6 0f 84 89
02 00 00 <0f> 0b 48 0f ba 71 28 02 0f 83 9f 03 00 00 ff 05 7b 09 e0 00
48 8b
[  204.867165] RSP: 0018:ffffaa18c02a3a90 EFLAGS: 00010202
[  204.872392] RAX: 0000000000000002 RBX: ffff8d83c4ebc000 RCX: ffffe1a5c013af00
[  204.879523] RDX: ffff8d8444ebc000 RSI: 0000000000000001 RDI: ffff8d83c4ebc000
[  204.886657] RBP: ffff8d83c359a938 R08: ffffe1a5c0000000 R09: ffffffff80000000
[  204.893790] R10: ffff8d83c385a680 R11: ffff8d83c10423c0 R12: 0000000000000000
[  204.900921] R13: ffff8d83c353ec00 R14: 03ffffffffffffff R15: ffff8d83c19a5700
[  204.908055] FS:  00000000f7f112c0(0000) GS:ffffffff9c635000(0000)
knlGS:0000000000000000
[  204.916140] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  204.921886] CR2: 00000000f77976ac CR3: 0000000003a9d000 CR4: 00000000000006f0
[  204.929019] Call Trace:
[  204.931472]  <TASK>
[  204.933578]  ? __warn+0x61/0xe0
[  204.936724]  ? do_compact_page+0x69/0x980
[  204.940736]  ? report_bug+0x150/0x190
[  204.944402]  ? handle_bug+0x3c/0x60
[  204.947896]  ? exc_invalid_op+0x1f/0x90
[  204.951734]  ? __switch_to_asm+0x2a/0x50
[  204.955660]  ? asm_exc_invalid_op+0x16/0x20
[  204.959848]  ? do_compact_page+0x69/0x980
[  204.963859]  ? queue_work_on+0x1a/0x30
[  204.967613]  zswap_free_entry+0x7b/0xc0
[  204.971461]  zswap_frontswap_invalidate_page+0x65/0xa0
[  204.976608]  __frontswap_invalidate_page+0x36/0x60
[  204.981402]  swapcache_free_entries+0x19e/0x2d0
[  204.985943]  free_swap_slot+0x99/0xb0
[  204.989617]  __swap_entry_free+0x6c/0x90
[  204.993543]  free_swap_and_cache+0x3b/0xe0
[  204.997643]  unmap_page_range+0x303/0xbb0
[  205.001664]  unmap_vmas+0x8e/0xb0
[  205.004992]  exit_mmap+0x95/0x1b0
[  205.008311]  mmput+0x18/0xc0
[  205.011198]  do_exit+0x263/0x970
[  205.014431]  do_group_exit+0x23/0x70
[  205.018017]  get_signal+0x8ad/0x8b0
[  205.021510]  arch_do_signal_or_restart+0x23/0x260
[  205.026217]  ? __bad_area_nosemaphore.constprop.0+0x112/0x230
[  205.031971]  ? exc_page_fault+0x36f/0x590
[  205.035984]  exit_to_user_mode_prepare+0xab/0x110
[  205.040698]  irqentry_exit_to_user_mode+0x5/0x10
[  205.045317]  asm_exc_page_fault+0x22/0x30
[  205.049329] RIP: 0033:0xf7ddb508
[  205.052564] Code: Unable to access opcode bytes at 0xf7ddb4de.
[  205.058396] RSP: 002b:00000000ffe635b8 EFLAGS: 00010202
[  205.063621] RAX: 0000000000000000 RBX: 00000000ffe636d4 RCX: 0000000000000000
[  205.070754] RDX: 0000000006400000 RSI: 000000000000005a RDI: 0000000000000000
[  205.077887] RBP: 00000000ffe635d0 R08: ffffffffffffffff R09: 0000000000000000
[  205.085018] R10: 0000000000000022 R11: 000000005786c000 R12: 0000000000000000
[  205.092151] R13: 00000000565f8165 R14: 00000000f7f44000 R15: 00000000565faecc
[  205.099285]  </TASK>
[  205.101477] ---[ end trace 0000000000000000 ]---
[  205.106104] ------------[ cut here ]------------
[  205.110724] WARNING: CPU: 0 PID: 2022 at mm/z3fold.c:741
do_compact_page+0x69/0x980
[  205.118378] Modules linked in: sha1_generic cts rpcsec_gss_krb5
auth_rpcgss oid_registry snd_emu10k1 snd_hwdep snd_util_mem
snd_ac97_codec ac97_bus snd_pcm firewire_ohci drivetemp snd_timer
firewire_core k8temp crc_itu_t emu10k1_gp pata_amd i2c_nforce2
snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device ns558 snd
gameport soundcore floppy
[  205.148503] CPU: 0 PID: 2022 Comm: oom Tainted: G        W          6.4.0 #1
[  205.155548] Hardware name: ASUSTek Computer Inc.
K8N-E-Deluxe/'K8N-E-Deluxe', BIOS 1012.007 01/18/2006
[  205.164848] RIP: 0010:do_compact_page+0x69/0x980
[  205.169468] Code: 2b 0d 43 8e a7 00 45 31 e4 48 01 d1 48 c1 e9 0c
48 c1 e1 06 48 03 0d 1e 8e a7 00 ff 05 98 09 e0 00 40 84 f6 0f 84 89
02 00 00 <0f> 0b 48 0f ba 71 28 02 0f 83 9f 03 00 00 ff 05 7b 09 e0 00
48 8b
[  205.188214] RSP: 0018:ffffaa18c02a3a90 EFLAGS: 00010202
[  205.193439] RAX: 0000000000000002 RBX: ffff8d83c38a8000 RCX: ffffe1a5c00e2a00
[  205.200572] RDX: ffff8d84438a8000 RSI: 0000000000000001 RDI: ffff8d83c38a8000
[  205.207705] RBP: ffff8d83c359a938 R08: ffffe1a5c0000000 R09: ffffffff80000000
[  205.214837] R10: ffff8d83c385a900 R11: ffff8d83c10423c0 R12: 0000000000000000
[  205.221970] R13: ffff8d83c353ec00 R14: 03ffffffffffffff R15: ffff8d83c19a5700
[  205.229104] FS:  00000000f7f112c0(0000) GS:ffffffff9c635000(0000)
knlGS:0000000000000000
[  205.237189] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  205.242934] CR2: 00000000f77976ac CR3: 0000000003a9d000 CR4: 00000000000006f0
[  205.250068] Call Trace:
[  205.252521]  <TASK>
[  205.254625]  ? __warn+0x61/0xe0
[  205.257773]  ? do_compact_page+0x69/0x980
[  205.261785]  ? report_bug+0x150/0x190
[  205.265451]  ? handle_bug+0x3c/0x60
[  205.268945]  ? exc_invalid_op+0x1f/0x90
[  205.272782]  ? __switch_to_asm+0x2a/0x50
[  205.276709]  ? asm_exc_invalid_op+0x16/0x20
[  205.280896]  ? do_compact_page+0x69/0x980
[  205.284908]  ? queue_work_on+0x1a/0x30
[  205.288659]  zswap_free_entry+0x7b/0xc0
[  205.292499]  zswap_frontswap_invalidate_page+0x65/0xa0
[  205.297648]  __frontswap_invalidate_page+0x36/0x60
[  205.302449]  swapcache_free_entries+0x19e/0x2d0
[  205.306982]  free_swap_slot+0x99/0xb0
[  205.310655]  __swap_entry_free+0x6c/0x90
[  205.314581]  free_swap_and_cache+0x3b/0xe0
[  205.318682]  unmap_page_range+0x303/0xbb0
[  205.322705]  unmap_vmas+0x8e/0xb0
[  205.326031]  exit_mmap+0x95/0x1b0
[  205.329352]  mmput+0x18/0xc0
[  205.332245]  do_exit+0x263/0x970
[  205.335479]  do_group_exit+0x23/0x70
[  205.339067]  get_signal+0x8ad/0x8b0
[  205.342568]  arch_do_signal_or_restart+0x23/0x260
[  205.347273]  ? __bad_area_nosemaphore.constprop.0+0x112/0x230
[  205.353019]  ? exc_page_fault+0x36f/0x590
[  205.357031]  exit_to_user_mode_prepare+0xab/0x110
[  205.361747]  irqentry_exit_to_user_mode+0x5/0x10
[  205.366375]  asm_exc_page_fault+0x22/0x30
[  205.370396] RIP: 0033:0xf7ddb508
[  205.373628] Code: Unable to access opcode bytes at 0xf7ddb4de.
[  205.379460] RSP: 002b:00000000ffe635b8 EFLAGS: 00010202
[  205.384687] RAX: 0000000000000000 RBX: 00000000ffe636d4 RCX: 0000000000000000
[  205.391820] RDX: 0000000006400000 RSI: 000000000000005a RDI: 0000000000000000
[  205.398951] RBP: 00000000ffe635d0 R08: ffffffffffffffff R09: 0000000000000000
[  205.406085] R10: 0000000000000022 R11: 000000005786c000 R12: 0000000000000000
[  205.413218] R13: 00000000565f8165 R14: 00000000f7f44000 R15: 00000000565faecc
[  205.420351]  </TASK>
[  205.422543] ---[ end trace 0000000000000000 ]---
[  205.427167] ------------[ cut here ]------------
[  205.431790] WARNING: CPU: 0 PID: 2022 at mm/z3fold.c:741
do_compact_page+0x69/0x980
[  205.439443] Modules linked in: sha1_generic cts rpcsec_gss_krb5
auth_rpcgss oid_registry snd_emu10k1 snd_hwdep snd_util_mem
snd_ac97_codec ac97_bus snd_pcm firewire_ohci drivetemp snd_timer
firewire_core k8temp crc_itu_t emu10k1_gp pata_amd i2c_nforce2
snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device ns558 snd
gameport soundcore floppy
[  205.469568] CPU: 0 PID: 2022 Comm: oom Tainted: G        W          6.4.0 #1
[  205.476613] Hardware name: ASUSTek Computer Inc.
K8N-E-Deluxe/'K8N-E-Deluxe', BIOS 1012.007 01/18/2006
[  205.485913] RIP: 0010:do_compact_page+0x69/0x980
[  205.490533] Code: 2b 0d 43 8e a7 00 45 31 e4 48 01 d1 48 c1 e9 0c
48 c1 e1 06 48 03 0d 1e 8e a7 00 ff 05 98 09 e0 00 40 84 f6 0f 84 89
02 00 00 <0f> 0b 48 0f ba 71 28 02 0f 83 9f 03 00 00 ff 05 7b 09 e0 00
48 8b
[  205.509279] RSP: 0018:ffffaa18c02a3a90 EFLAGS: 00010202
[  205.514504] RAX: 0000000000000002 RBX: ffff8d83c4e96000 RCX: ffffe1a5c013a580
[  205.521637] RDX: ffff8d8444e96000 RSI: 0000000000000001 RDI: ffff8d83c4e96000
[  205.528770] RBP: ffff8d83c359a938 R08: ffffe1a5c0000000 R09: ffffffff80000000
[  205.535904] R10: ffffffffffffffc0 R11: ffff8d83c10423c0 R12: 0000000000000000
[  205.543035] R13: ffff8d83c353ec00 R14: 03ffffffffffffff R15: ffff8d83c19a5700
[  205.550168] FS:  00000000f7f112c0(0000) GS:ffffffff9c635000(0000)
knlGS:0000000000000000
[  205.558254] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  205.564000] CR2: 00000000f77976ac CR3: 0000000003a9d000 CR4: 00000000000006f0
[  205.571133] Call Trace:
[  205.573586]  <TASK>
[  205.575692]  ? __warn+0x61/0xe0
[  205.578838]  ? do_compact_page+0x69/0x980
[  205.582850]  ? report_bug+0x150/0x190
[  205.586516]  ? handle_bug+0x3c/0x60
[  205.590010]  ? exc_invalid_op+0x1f/0x90
[  205.593847]  ? __switch_to_asm+0x2a/0x50
[  205.597774]  ? asm_exc_invalid_op+0x16/0x20
[  205.601961]  ? do_compact_page+0x69/0x980
[  205.605973]  ? queue_work_on+0x1a/0x30
[  205.609727]  zswap_free_entry+0x7b/0xc0
[  205.613573]  zswap_frontswap_invalidate_page+0x65/0xa0
[  205.618713]  __frontswap_invalidate_page+0x36/0x60
[  205.623514]  swapcache_free_entries+0x19e/0x2d0
[  205.628046]  free_swap_slot+0x99/0xb0
[  205.631714]  __swap_entry_free+0x6c/0x90
[  205.635649]  free_swap_and_cache+0x3b/0xe0
[  205.639755]  unmap_page_range+0x303/0xbb0
[  205.643778]  unmap_vmas+0x8e/0xb0
[  205.647105]  exit_mmap+0x95/0x1b0
[  205.650426]  mmput+0x18/0xc0
[  205.653310]  do_exit+0x263/0x970
[  205.656543]  do_group_exit+0x23/0x70
[  205.660123]  get_signal+0x8ad/0x8b0
[  205.663624]  arch_do_signal_or_restart+0x23/0x260
[  205.668330]  ? __bad_area_nosemaphore.constprop.0+0x112/0x230
[  205.674075]  ? exc_page_fault+0x36f/0x590
[  205.678088]  exit_to_user_mode_prepare+0xab/0x110
[  205.682804]  irqentry_exit_to_user_mode+0x5/0x10
[  205.687432]  asm_exc_page_fault+0x22/0x30
[  205.691453] RIP: 0033:0xf7ddb508
[  205.694685] Code: Unable to access opcode bytes at 0xf7ddb4de.
[  205.700517] RSP: 002b:00000000ffe635b8 EFLAGS: 00010202
[  205.705744] RAX: 0000000000000000 RBX: 00000000ffe636d4 RCX: 0000000000000000
[  205.712875] RDX: 0000000006400000 RSI: 000000000000005a RDI: 0000000000000000
[  205.720008] RBP: 00000000ffe635d0 R08: ffffffffffffffff R09: 0000000000000000
[  205.727142] R10: 0000000000000022 R11: 000000005786c000 R12: 0000000000000000
[  205.734275] R13: 00000000565f8165 R14: 00000000f7f44000 R15: 00000000565faecc
[  205.741407]  </TASK>
[  205.743599] ---[ end trace 0000000000000000 ]---
[  205.748225] ------------[ cut here ]------------
[  205.752848] WARNING: CPU: 0 PID: 2022 at mm/z3fold.c:741
do_compact_page+0x69/0x980
[  205.760508] Modules linked in: sha1_generic cts rpcsec_gss_krb5
auth_rpcgss oid_registry snd_emu10k1 snd_hwdep snd_util_mem
snd_ac97_codec ac97_bus snd_pcm firewire_ohci drivetemp snd_timer
firewire_core k8temp crc_itu_t emu10k1_gp pata_amd i2c_nforce2
snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device ns558 snd
gameport soundcore floppy
[  205.790633] CPU: 0 PID: 2022 Comm: oom Tainted: G        W          6.4.0 #1
[  205.797680] Hardware name: ASUSTek Computer Inc.
K8N-E-Deluxe/'K8N-E-Deluxe', BIOS 1012.007 01/18/2006
[  205.806980] RIP: 0010:do_compact_page+0x69/0x980
[  205.811598] Code: 2b 0d 43 8e a7 00 45 31 e4 48 01 d1 48 c1 e9 0c
48 c1 e1 06 48 03 0d 1e 8e a7 00 ff 05 98 09 e0 00 40 84 f6 0f 84 89
02 00 00 <0f> 0b 48 0f ba 71 28 02 0f 83 9f 03 00 00 ff 05 7b 09 e0 00
48 8b
[  205.830344] RSP: 0018:ffffaa18c02a3a90 EFLAGS: 00010202
[  205.835569] RAX: 0000000000000002 RBX: ffff8d83c3af0000 RCX: ffffe1a5c00ebc00
[  205.842702] RDX: ffff8d8443af0000 RSI: 0000000000000001 RDI: ffff8d83c3af0000
[  205.849836] RBP: ffff8d83c359a938 R08: ffffe1a5c0000000 R09: ffffffff80000000
[  205.856969] R10: ffff8d83c20f7380 R11: ffff8d83c10423c0 R12: 0000000000000000
[  205.864100] R13: ffff8d83c353ec00 R14: 03ffffffffffffff R15: ffff8d83c19a5700
[  205.871234] FS:  00000000f7f112c0(0000) GS:ffffffff9c635000(0000)
knlGS:0000000000000000
[  205.879319] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  205.885065] CR2: 00000000f77976ac CR3: 0000000003a9d000 CR4: 00000000000006f0
[  205.892198] Call Trace:
[  205.894651]  <TASK>
[  205.896757]  ? __warn+0x61/0xe0
[  205.899903]  ? do_compact_page+0x69/0x980
[  205.903915]  ? report_bug+0x150/0x190
[  205.907581]  ? handle_bug+0x3c/0x60
[  205.911075]  ? exc_invalid_op+0x1f/0x90
[  205.914914]  ? __switch_to_asm+0x2a/0x50
[  205.918839]  ? asm_exc_invalid_op+0x16/0x20
[  205.923026]  ? do_compact_page+0x69/0x980
[  205.927038]  ? queue_work_on+0x1a/0x30
[  205.930792]  zswap_free_entry+0x7b/0xc0
[  205.934640]  zswap_frontswap_invalidate_page+0x65/0xa0
[  205.939787]  __frontswap_invalidate_page+0x36/0x60
[  205.944581]  swapcache_free_entries+0x19e/0x2d0
[  205.949122]  free_swap_slot+0x99/0xb0
[  205.952796]  __swap_entry_free+0x6c/0x90
[  205.956722]  free_swap_and_cache+0x3b/0xe0
[  205.960829]  unmap_page_range+0x303/0xbb0
[  205.964843]  unmap_vmas+0x8e/0xb0
[  205.968171]  exit_mmap+0x95/0x1b0
[  205.971499]  mmput+0x18/0xc0
[  205.974385]  do_exit+0x263/0x970
[  205.977616]  do_group_exit+0x23/0x70
[  205.981196]  get_signal+0x8ad/0x8b0
[  205.984689]  arch_do_signal_or_restart+0x23/0x260
[  205.989396]  ? __bad_area_nosemaphore.constprop.0+0x112/0x230
[  205.995150]  ? exc_page_fault+0x36f/0x590
[  205.999163]  exit_to_user_mode_prepare+0xab/0x110
[  206.003876]  irqentry_exit_to_user_mode+0x5/0x10
[  206.008496]  asm_exc_page_fault+0x22/0x30
[  206.012508] RIP: 0033:0xf7ddb508
[  206.015742] Code: Unable to access opcode bytes at 0xf7ddb4de.
[  206.021574] RSP: 002b:00000000ffe635b8 EFLAGS: 00010202
[  206.026799] RAX: 0000000000000000 RBX: 00000000ffe636d4 RCX: 0000000000000000
[  206.033933] RDX: 0000000006400000 RSI: 000000000000005a RDI: 0000000000000000
[  206.041066] RBP: 00000000ffe635d0 R08: ffffffffffffffff R09: 0000000000000000
[  206.048199] R10: 0000000000000022 R11: 000000005786c000 R12: 0000000000000000
[  206.055330] R13: 00000000565f8165 R14: 00000000f7f44000 R15: 00000000565faecc
[  206.062464]  </TASK>
[  206.064656] ---[ end trace 0000000000000000 ]---
[  206.069281] ------------[ cut here ]------------
[  206.073904] WARNING: CPU: 0 PID: 2022 at mm/z3fold.c:741
do_compact_page+0x69/0x980
[  206.081564] Modules linked in: sha1_generic cts rpcsec_gss_krb5
auth_rpcgss oid_registry snd_emu10k1 snd_hwdep snd_util_mem
snd_ac97_codec ac97_bus snd_pcm firewire_ohci drivetemp snd_timer
firewire_core k8temp crc_itu_t emu10k1_gp pata_amd i2c_nforce2
snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device ns558 snd
gameport soundcore floppy
[  206.111691] CPU: 0 PID: 2022 Comm: oom Tainted: G        W          6.4.0 #1
[  206.118736] Hardware name: ASUSTek Computer Inc.
K8N-E-Deluxe/'K8N-E-Deluxe', BIOS 1012.007 01/18/2006
[  206.128036] RIP: 0010:do_compact_page+0x69/0x980
[  206.132654] Code: 2b 0d 43 8e a7 00 45 31 e4 48 01 d1 48 c1 e9 0c
48 c1 e1 06 48 03 0d 1e 8e a7 00 ff 05 98 09 e0 00 40 84 f6 0f 84 89
02 00 00 <0f> 0b 48 0f ba 71 28 02 0f 83 9f 03 00 00 ff 05 7b 09 e0 00
48 8b
[  206.151400] RSP: 0018:ffffaa18c02a3a90 EFLAGS: 00010202
[  206.156627] RAX: 0000000000000002 RBX: ffff8d83c3b07000 RCX: ffffe1a5c00ec1c0
[  206.163758] RDX: ffff8d8443b07000 RSI: 0000000000000001 RDI: ffff8d83c3b07000
[  206.170892] RBP: ffff8d83c359a938 R08: ffffe1a5c0000000 R09: ffffffff80000000
[  206.178025] R10: ffff8d83c21cefc0 R11: ffff8d83c10423c0 R12: 0000000000000000
[  206.185159] R13: ffff8d83c353ec00 R14: 03ffffffffffffff R15: ffff8d83c19a5700
[  206.192290] FS:  00000000f7f112c0(0000) GS:ffffffff9c635000(0000)
knlGS:0000000000000000
[  206.200377] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  206.206123] CR2: 00000000f77976ac CR3: 0000000003a9d000 CR4: 00000000000006f0
[  206.213254] Call Trace:
[  206.215707]  <TASK>
[  206.217814]  ? __warn+0x61/0xe0
[  206.220959]  ? do_compact_page+0x69/0x980
[  206.224973]  ? report_bug+0x150/0x190
[  206.228639]  ? handle_bug+0x3c/0x60
[  206.232131]  ? exc_invalid_op+0x1f/0x90
[  206.235971]  ? __switch_to_asm+0x2a/0x50
[  206.239897]  ? asm_exc_invalid_op+0x16/0x20
[  206.244091]  ? do_compact_page+0x69/0x980
[  206.248103]  ? queue_work_on+0x1a/0x30
[  206.251856]  zswap_free_entry+0x7b/0xc0
[  206.255705]  zswap_frontswap_invalidate_page+0x65/0xa0
[  206.260852]  __frontswap_invalidate_page+0x36/0x60
[  206.265646]  swapcache_free_entries+0x19e/0x2d0
[  206.270187]  free_swap_slot+0x99/0xb0
[  206.273861]  __swap_entry_free+0x6c/0x90
[  206.277787]  free_swap_and_cache+0x3b/0xe0
[  206.281887]  unmap_page_range+0x303/0xbb0
[  206.285908]  unmap_vmas+0x8e/0xb0
[  206.289237]  exit_mmap+0x95/0x1b0
[  206.292556]  mmput+0x18/0xc0
[  206.295442]  do_exit+0x263/0x970
[  206.298673]  do_group_exit+0x23/0x70
[  206.302253]  get_signal+0x8ad/0x8b0
[  206.305745]  arch_do_signal_or_restart+0x23/0x260
[  206.310453]  ? __bad_area_nosemaphore.constprop.0+0x112/0x230
[  206.316207]  ? exc_page_fault+0x36f/0x590
[  206.320220]  exit_to_user_mode_prepare+0xab/0x110
[  206.324934]  irqentry_exit_to_user_mode+0x5/0x10
[  206.329553]  asm_exc_page_fault+0x22/0x30
[  206.333565] RIP: 0033:0xf7ddb508
[  206.336799] Code: Unable to access opcode bytes at 0xf7ddb4de.
[  206.342631] RSP: 002b:00000000ffe635b8 EFLAGS: 00010202
[  206.347856] RAX: 0000000000000000 RBX: 00000000ffe636d4 RCX: 0000000000000000
[  206.354989] RDX: 0000000006400000 RSI: 000000000000005a RDI: 0000000000000000
[  206.362122] RBP: 00000000ffe635d0 R08: ffffffffffffffff R09: 0000000000000000
[  206.369256] R10: 0000000000000022 R11: 000000005786c000 R12: 0000000000000000
[  206.376387] R13: 00000000565f8165 R14: 00000000f7f44000 R15: 00000000565faecc
[  206.383521]  </TASK>
[  206.385712] ---[ end trace 0000000000000000 ]---
[  206.390339] ------------[ cut here ]------------
[  206.394961] WARNING: CPU: 0 PID: 2022 at mm/z3fold.c:741
do_compact_page+0x69/0x980
[  206.402621] Modules linked in: sha1_generic cts rpcsec_gss_krb5
auth_rpcgss oid_registry snd_emu10k1 snd_hwdep snd_util_mem
snd_ac97_codec ac97_bus snd_pcm firewire_ohci drivetemp snd_timer
firewire_core k8temp crc_itu_t emu10k1_gp pata_amd i2c_nforce2
snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device ns558 snd
gameport soundcore floppy
[  206.432746] CPU: 0 PID: 2022 Comm: oom Tainted: G        W          6.4.0 #1
[  206.439793] Hardware name: ASUSTek Computer Inc.
K8N-E-Deluxe/'K8N-E-Deluxe', BIOS 1012.007 01/18/2006
[  206.449093] RIP: 0010:do_compact_page+0x69/0x980
[  206.453711] Code: 2b 0d 43 8e a7 00 45 31 e4 48 01 d1 48 c1 e9 0c
48 c1 e1 06 48 03 0d 1e 8e a7 00 ff 05 98 09 e0 00 40 84 f6 0f 84 89
02 00 00 <0f> 0b 48 0f ba 71 28 02 0f 83 9f 03 00 00 ff 05 7b 09 e0 00
48 8b
[  206.472458] RSP: 0018:ffffaa18c02a3a90 EFLAGS: 00010202
[  206.477684] RAX: 0000000000000002 RBX: ffff8d83c2115000 RCX: ffffe1a5c0084540
[  206.484817] RDX: ffff8d8442115000 RSI: 0000000000000001 RDI: ffff8d83c2115000
[  206.491950] RBP: ffff8d83c359a938 R08: ffffe1a5c0000000 R09: ffffffff80000000
[  206.499081] R10: ffff8d83c4d3d100 R11: ffff8d83c10423c0 R12: 0000000000000000
[  206.506214] R13: ffff8d83c353ec00 R14: 03ffffffffffffff R15: ffff8d83c19a5700
[  206.513348] FS:  00000000f7f112c0(0000) GS:ffffffff9c635000(0000)
knlGS:0000000000000000
[  206.521433] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  206.527179] CR2: 00000000f77976ac CR3: 0000000003a9d000 CR4: 00000000000006f0
[  206.534313] Call Trace:
[  206.536765]  <TASK>
[  206.538870]  ? __warn+0x61/0xe0
[  206.542016]  ? do_compact_page+0x69/0x980
[  206.546029]  ? report_bug+0x150/0x190
[  206.549695]  ? handle_bug+0x3c/0x60
[  206.553187]  ? exc_invalid_op+0x1f/0x90
[  206.557027]  ? __switch_to_asm+0x2a/0x50
[  206.560954]  ? asm_exc_invalid_op+0x16/0x20
[  206.565138]  ? do_compact_page+0x69/0x980
[  206.569152]  ? queue_work_on+0x1a/0x30
[  206.572904]  zswap_free_entry+0x7b/0xc0
[  206.576744]  zswap_frontswap_invalidate_page+0x65/0xa0
[  206.581893]  __frontswap_invalidate_page+0x36/0x60
[  206.586693]  swapcache_free_entries+0x19e/0x2d0
[  206.591234]  free_swap_slot+0x99/0xb0
[  206.594899]  __swap_entry_free+0x6c/0x90
[  206.598826]  free_swap_and_cache+0x3b/0xe0
[  206.602926]  unmap_page_range+0x303/0xbb0
[  206.606949]  unmap_vmas+0x8e/0xb0
[  206.610275]  exit_mmap+0x95/0x1b0
[  206.613596]  mmput+0x18/0xc0
[  206.616480]  do_exit+0x263/0x970
[  206.619714]  do_group_exit+0x23/0x70
[  206.623293]  get_signal+0x8ad/0x8b0
[  206.626795]  arch_do_signal_or_restart+0x23/0x260
[  206.631500]  ? __bad_area_nosemaphore.constprop.0+0x112/0x230
[  206.637245]  ? exc_page_fault+0x36f/0x590
[  206.641258]  exit_to_user_mode_prepare+0xab/0x110
[  206.645974]  irqentry_exit_to_user_mode+0x5/0x10
[  206.650602]  asm_exc_page_fault+0x22/0x30
[  206.654623] RIP: 0033:0xf7ddb508
[  206.657855] Code: Unable to access opcode bytes at 0xf7ddb4de.
[  206.663688] RSP: 002b:00000000ffe635b8 EFLAGS: 00010202
[  206.668912] RAX: 0000000000000000 RBX: 00000000ffe636d4 RCX: 0000000000000000
[  206.676046] RDX: 0000000006400000 RSI: 000000000000005a RDI: 0000000000000000
[  206.683179] RBP: 00000000ffe635d0 R08: ffffffffffffffff R09: 0000000000000000
[  206.690312] R10: 0000000000000022 R11: 000000005786c000 R12: 0000000000000000
[  206.697443] R13: 00000000565f8165 R14: 00000000f7f44000 R15: 00000000565faecc
[  206.704577]  </TASK>
[  206.706768] ---[ end trace 0000000000000000 ]---
[  206.711395] ------------[ cut here ]------------
[  206.716018] WARNING: CPU: 0 PID: 2022 at mm/z3fold.c:741
do_compact_page+0x69/0x980
[  206.723678] Modules linked in: sha1_generic cts rpcsec_gss_krb5
auth_rpcgss oid_registry snd_emu10k1 snd_hwdep snd_util_mem
snd_ac97_codec ac97_bus snd_pcm firewire_ohci drivetemp snd_timer
firewire_core k8temp crc_itu_t emu10k1_gp pata_amd i2c_nforce2
snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device ns558 snd
gameport soundcore floppy
[  206.753805] CPU: 0 PID: 2022 Comm: oom Tainted: G        W          6.4.0 #1
[  206.760858] Hardware name: ASUSTek Computer Inc.
K8N-E-Deluxe/'K8N-E-Deluxe', BIOS 1012.007 01/18/2006
[  206.770158] RIP: 0010:do_compact_page+0x69/0x980
[  206.774776] Code: 2b 0d 43 8e a7 00 45 31 e4 48 01 d1 48 c1 e9 0c
48 c1 e1 06 48 03 0d 1e 8e a7 00 ff 05 98 09 e0 00 40 84 f6 0f 84 89
02 00 00 <0f> 0b 48 0f ba 71 28 02 0f 83 9f 03 00 00 ff 05 7b 09 e0 00
48 8b
[  206.793522] RSP: 0018:ffffaa18c02a3a90 EFLAGS: 00010202
[  206.798750] RAX: 0000000000000002 RBX: ffff8d83c3903000 RCX: ffffe1a5c00e40c0
[  206.805881] RDX: ffff8d8443903000 RSI: 0000000000000001 RDI: ffff8d83c3903000
[  206.813014] RBP: ffff8d83c359a938 R08: ffffe1a5c0000000 R09: ffffffff80000000
[  206.820148] R10: ffffffffffffffc0 R11: ffff8d83c10423c0 R12: 0000000000000000
[  206.827279] R13: ffff8d83c353ec00 R14: 03ffffffffffffff R15: ffff8d83c19a5700
[  206.834412] FS:  00000000f7f112c0(0000) GS:ffffffff9c635000(0000)
knlGS:0000000000000000
[  206.842497] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  206.848243] CR2: 00000000f77976ac CR3: 0000000003a9d000 CR4: 00000000000006f0
[  206.855376] Call Trace:
[  206.857829]  <TASK>
[  206.859936]  ? __warn+0x61/0xe0
[  206.863082]  ? do_compact_page+0x69/0x980
[  206.867093]  ? report_bug+0x150/0x190
[  206.870761]  ? handle_bug+0x3c/0x60
[  206.874253]  ? exc_invalid_op+0x1f/0x90
[  206.878093]  ? __switch_to_asm+0x2a/0x50
[  206.882018]  ? asm_exc_invalid_op+0x16/0x20
[  206.886205]  ? do_compact_page+0x69/0x980
[  206.890217]  ? queue_work_on+0x1a/0x30
[  206.893970]  zswap_free_entry+0x7b/0xc0
[  206.897819]  zswap_frontswap_invalidate_page+0x65/0xa0
[  206.902966]  __frontswap_invalidate_page+0x36/0x60
[  206.907768]  swapcache_free_entries+0x19e/0x2d0
[  206.912310]  free_swap_slot+0x99/0xb0
[  206.915983]  __swap_entry_free+0x6c/0x90
[  206.919909]  free_swap_and_cache+0x3b/0xe0
[  206.924009]  unmap_page_range+0x303/0xbb0
[  206.928030]  unmap_vmas+0x8e/0xb0
[  206.931359]  exit_mmap+0x95/0x1b0
[  206.934677]  mmput+0x18/0xc0
[  206.937564]  do_exit+0x263/0x970
[  206.940797]  do_group_exit+0x23/0x70
[  206.944383]  get_signal+0x8ad/0x8b0
[  206.947876]  arch_do_signal_or_restart+0x23/0x260
[  206.952584]  ? __bad_area_nosemaphore.constprop.0+0x112/0x230
[  206.958337]  ? exc_page_fault+0x36f/0x590
[  206.962350]  exit_to_user_mode_prepare+0xab/0x110
[  206.967064]  irqentry_exit_to_user_mode+0x5/0x10
[  206.971683]  asm_exc_page_fault+0x22/0x30
[  206.975696] RIP: 0033:0xf7ddb508
[  206.978930] Code: Unable to access opcode bytes at 0xf7ddb4de.
[  206.984762] RSP: 002b:00000000ffe635b8 EFLAGS: 00010202
[  206.989987] RAX: 0000000000000000 RBX: 00000000ffe636d4 RCX: 0000000000000000
[  206.997120] RDX: 0000000006400000 RSI: 000000000000005a RDI: 0000000000000000
[  207.004253] RBP: 00000000ffe635d0 R08: ffffffffffffffff R09: 0000000000000000
[  207.011387] R10: 0000000000000022 R11: 000000005786c000 R12: 0000000000000000
[  207.018518] R13: 00000000565f8165 R14: 00000000f7f44000 R15: 00000000565faecc
[  207.025651]  </TASK>
[  207.027843] ---[ end trace 0000000000000000 ]---
[  207.032475] ------------[ cut here ]------------
[  207.037091] WARNING: CPU: 0 PID: 2022 at mm/z3fold.c:741
do_compact_page+0x69/0x980
[  207.044744] Modules linked in: sha1_generic cts rpcsec_gss_krb5
auth_rpcgss oid_registry snd_emu10k1 snd_hwdep snd_util_mem
snd_ac97_codec ac97_bus snd_pcm firewire_ohci drivetemp snd_timer
firewire_core k8temp crc_itu_t emu10k1_gp pata_amd i2c_nforce2
snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device ns558 snd
gameport soundcore floppy
[  207.074869] CPU: 0 PID: 2022 Comm: oom Tainted: G        W          6.4.0 #1
[  207.081914] Hardware name: ASUSTek Computer Inc.
K8N-E-Deluxe/'K8N-E-Deluxe', BIOS 1012.007 01/18/2006
[  207.091214] RIP: 0010:do_compact_page+0x69/0x980
[  207.095834] Code: 2b 0d 43 8e a7 00 45 31 e4 48 01 d1 48 c1 e9 0c
48 c1 e1 06 48 03 0d 1e 8e a7 00 ff 05 98 09 e0 00 40 84 f6 0f 84 89
02 00 00 <0f> 0b 48 0f ba 71 28 02 0f 83 9f 03 00 00 ff 05 7b 09 e0 00
48 8b
[  207.114580] RSP: 0018:ffffaa18c02a3a90 EFLAGS: 00010202
[  207.119805] RAX: 0000000000000002 RBX: ffff8d83c4f8b000 RCX: ffffe1a5c013e2c0
[  207.126938] RDX: ffff8d8444f8b000 RSI: 0000000000000001 RDI: ffff8d83c4f8b000
[  207.134072] RBP: ffff8d83c359a938 R08: ffffe1a5c0000000 R09: ffffffff80000000
[  207.141203] R10: ffff8d83c4ec4e40 R11: ffff8d83c10423c0 R12: 0000000000000000
[  207.148336] R13: ffff8d83c353ec00 R14: 03ffffffffffffff R15: ffff8d83c19a5700
[  207.155469] FS:  00000000f7f112c0(0000) GS:ffffffff9c635000(0000)
knlGS:0000000000000000
[  207.163555] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  207.169300] CR2: 00000000f77976ac CR3: 0000000003a9d000 CR4: 00000000000006f0
[  207.176434] Call Trace:
[  207.178887]  <TASK>
[  207.180993]  ? __warn+0x61/0xe0
[  207.184139]  ? do_compact_page+0x69/0x980
[  207.188151]  ? report_bug+0x150/0x190
[  207.191817]  ? handle_bug+0x3c/0x60
[  207.195310]  ? exc_invalid_op+0x1f/0x90
[  207.199148]  ? __switch_to_asm+0x2a/0x50
[  207.203075]  ? asm_exc_invalid_op+0x16/0x20
[  207.207262]  ? do_compact_page+0x69/0x980
[  207.211273]  ? queue_work_on+0x1a/0x30
[  207.215027]  zswap_free_entry+0x7b/0xc0
[  207.218875]  zswap_frontswap_invalidate_page+0x65/0xa0
[  207.224022]  __frontswap_invalidate_page+0x36/0x60
[  207.228816]  swapcache_free_entries+0x19e/0x2d0
[  207.233358]  free_swap_slot+0x99/0xb0
[  207.237031]  __swap_entry_free+0x6c/0x90
[  207.240957]  free_swap_and_cache+0x3b/0xe0
[  207.245064]  unmap_page_range+0x303/0xbb0
[  207.249079]  unmap_vmas+0x8e/0xb0
[  207.252407]  exit_mmap+0x95/0x1b0
[  207.255726]  mmput+0x18/0xc0
[  207.258612]  do_exit+0x263/0x970
[  207.261843]  do_group_exit+0x23/0x70
[  207.265423]  get_signal+0x8ad/0x8b0
[  207.268916]  arch_do_signal_or_restart+0x23/0x260
[  207.273621]  ? __bad_area_nosemaphore.constprop.0+0x112/0x230
[  207.279369]  ? exc_page_fault+0x36f/0x590
[  207.283390]  exit_to_user_mode_prepare+0xab/0x110
[  207.288104]  irqentry_exit_to_user_mode+0x5/0x10
[  207.292723]  asm_exc_page_fault+0x22/0x30
[  207.296736] RIP: 0033:0xf7ddb508
[  207.299968] Code: Unable to access opcode bytes at 0xf7ddb4de.
[  207.305802] RSP: 002b:00000000ffe635b8 EFLAGS: 00010202
[  207.311027] RAX: 0000000000000000 RBX: 00000000ffe636d4 RCX: 0000000000000000
[  207.318160] RDX: 0000000006400000 RSI: 000000000000005a RDI: 0000000000000000
[  207.325291] RBP: 00000000ffe635d0 R08: ffffffffffffffff R09: 0000000000000000
[  207.332425] R10: 0000000000000022 R11: 000000005786c000 R12: 0000000000000000
[  207.339558] R13: 00000000565f8165 R14: 00000000f7f44000 R15: 00000000565faecc
[  207.346692]  </TASK>
[  207.348883] ---[ end trace 0000000000000000 ]---
[  207.353513] ------------[ cut here ]------------
[  207.358131] WARNING: CPU: 0 PID: 2022 at mm/z3fold.c:741
do_compact_page+0x69/0x980
[  207.365791] Modules linked in: sha1_generic cts rpcsec_gss_krb5
auth_rpcgss oid_registry snd_emu10k1 snd_hwdep snd_util_mem
snd_ac97_codec ac97_bus snd_pcm firewire_ohci drivetemp snd_timer
firewire_core k8temp crc_itu_t emu10k1_gp pata_amd i2c_nforce2
snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device ns558 snd
gameport soundcore floppy
[  207.395916] CPU: 0 PID: 2022 Comm: oom Tainted: G        W          6.4.0 #1
[  207.402963] Hardware name: ASUSTek Computer Inc.
K8N-E-Deluxe/'K8N-E-Deluxe', BIOS 1012.007 01/18/2006
[  207.412263] RIP: 0010:do_compact_page+0x69/0x980
[  207.416881] Code: 2b 0d 43 8e a7 00 45 31 e4 48 01 d1 48 c1 e9 0c
48 c1 e1 06 48 03 0d 1e 8e a7 00 ff 05 98 09 e0 00 40 84 f6 0f 84 89
02 00 00 <0f> 0b 48 0f ba 71 28 02 0f 83 9f 03 00 00 ff 05 7b 09 e0 00
48 8b
[  207.435627] RSP: 0018:ffffaa18c02a3a90 EFLAGS: 00010202
[  207.440854] RAX: 0000000000000002 RBX: ffff8d83f1046000 RCX: ffffe1a5c0c41180
[  207.447986] RDX: ffff8d8471046000 RSI: 0000000000000001 RDI: ffff8d83f1046000
[  207.455119] RBP: ffff8d83c359a938 R08: ffffe1a5c0000000 R09: ffffffff80000000
[  207.462252] R10: ffff8d8432ce1b40 R11: ffff8d83c10423c0 R12: 0000000000000000
[  207.469383] R13: ffff8d83c353ec00 R14: 03ffffffffffffff R15: ffff8d83c19a5700
[  207.476517] FS:  00000000f7f112c0(0000) GS:ffffffff9c635000(0000)
knlGS:0000000000000000
[  207.484602] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  207.490348] CR2: 00000000f77976ac CR3: 0000000003a9d000 CR4: 00000000000006f0
[  207.497482] Call Trace:
[  207.499934]  <TASK>
[  207.502041]  ? __warn+0x61/0xe0
[  207.505187]  ? do_compact_page+0x69/0x980
[  207.509198]  ? report_bug+0x150/0x190
[  207.512866]  ? handle_bug+0x3c/0x60
[  207.516358]  ? exc_invalid_op+0x1f/0x90
[  207.520198]  ? __switch_to_asm+0x2a/0x50
[  207.524122]  ? asm_exc_invalid_op+0x16/0x20
[  207.528309]  ? do_compact_page+0x69/0x980
[  207.532321]  zswap_free_entry+0x7b/0xc0
[  207.536161]  zswap_frontswap_invalidate_page+0x65/0xa0
[  207.541310]  __frontswap_invalidate_page+0x36/0x60
[  207.546110]  swapcache_free_entries+0x19e/0x2d0
[  207.550643]  free_swap_slot+0x99/0xb0
[  207.554308]  __swap_entry_free+0x6c/0x90
[  207.558237]  free_swap_and_cache+0x3b/0xe0
[  207.562343]  unmap_page_range+0x303/0xbb0
[  207.566366]  unmap_vmas+0x8e/0xb0
[  207.569692]  exit_mmap+0x95/0x1b0
[  207.573013]  mmput+0x18/0xc0
[  207.575898]  do_exit+0x263/0x970
[  207.579131]  do_group_exit+0x23/0x70
[  207.582710]  get_signal+0x8ad/0x8b0
[  207.586203]  arch_do_signal_or_restart+0x23/0x260
[  207.590909]  ? __bad_area_nosemaphore.constprop.0+0x112/0x230
[  207.596654]  ? exc_page_fault+0x36f/0x590
[  207.600667]  exit_to_user_mode_prepare+0xab/0x110
[  207.605383]  irqentry_exit_to_user_mode+0x5/0x10
[  207.610010]  asm_exc_page_fault+0x22/0x30
[  207.614032] RIP: 0033:0xf7ddb508
[  207.617264] Code: Unable to access opcode bytes at 0xf7ddb4de.
[  207.623096] RSP: 002b:00000000ffe635b8 EFLAGS: 00010202
[  207.628323] RAX: 0000000000000000 RBX: 00000000ffe636d4 RCX: 0000000000000000
[  207.635454] RDX: 0000000006400000 RSI: 000000000000005a RDI: 0000000000000000
[  207.642587] RBP: 00000000ffe635d0 R08: ffffffffffffffff R09: 0000000000000000
[  207.649721] R10: 0000000000000022 R11: 000000005786c000 R12: 0000000000000000
[  207.656854] R13: 00000000565f8165 R14: 00000000f7f44000 R15: 00000000565faecc
[  207.663985]  </TASK>
[  207.666179] ---[ end trace 0000000000000000 ]---
[  223.698899] sysrq: HELP : loglevel(0-9) reboot(b) crash(c)
terminate-all-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i)
thaw-filesystems(j) sak(k) show-memory-usage(m) nice-all-RT-tasks(n)
poweroff(o) show-registers(p) show-all-timers(q) unraw(r) sync(s)
show-task-states(t) unmount(u) show-blocked-tasks(w)
[  224.425839] sysrq: HELP : loglevel(0-9) reboot(b) crash(c)
terminate-all-tasks(e) memory-full-oom-kill(f) kill-all-tasks(i)
thaw-filesystems(j) sak(k) show-memory-usage(m) nice-all-RT-tasks(n)
poweroff(o) show-registers(p) show-all-timers(q) unraw(r) sync(s)
show-task-states(t) unmount(u) show-blocked-tasks(w)
