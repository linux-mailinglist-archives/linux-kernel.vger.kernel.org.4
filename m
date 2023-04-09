Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828616DBFCB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDIMQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 08:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIMQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 08:16:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611CE2727;
        Sun,  9 Apr 2023 05:15:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w11so2302073pjh.5;
        Sun, 09 Apr 2023 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681042559;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2t1G48wxCUMMNbti7GgTNE7UH21GayHo7SYoWCZ/eD4=;
        b=Tbvt+HdVNbYiGq7fDUN4njsb312cRhqX1XfVQwj94qBSr7Zlg51ZZ0j2h9zEAYDD8p
         n+dJCTsqC4IJgwX4WVSijqh89bsh8yYQxHMuGN518SK25WfGKACYJ/W2wiZF76e2zIVU
         vAMmf3VEfDlPO3NMGWrw4YlcZF00ygEWpT2X+mB5WBiiaecNIeUEhlIRM6wqk64nt5ho
         LXvlHYUvDeSULNTXSdpLImpJn8WPNjXoGcCvkobJqmD9ewbQOaDHeRn8FwxbqVrnWZw/
         HHlDlCqojRU9DgBe8Cw4oKfzVHwneJljrw8jMZ30lFm2sX54aa4KjiD7vH+KdAmycyG2
         HLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681042559;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2t1G48wxCUMMNbti7GgTNE7UH21GayHo7SYoWCZ/eD4=;
        b=uTscLPFJLX5Z4VXNmL2+ZeM9LWk3IaHs2Krs1UdCnFnMyeQ4YhBqCqbmNVbbYxlGLj
         bfGQX/QLjmsv8BznOi7+8heR6xSVtn0rBSX2yoS0y2AHsGNfVDCQRnW8S+yxbP1+htgj
         FJBzcJ3ygO0pe1hxLUuY8P48v8SNLbqnwmgrV843o5TDbY03/3jaViLBXe+8Pnlllh5e
         L0/O09G1c+80e7TFkHkn0rqYOOW7wm5SLEAVchy20xO+BpMn06r+nrU6OegK1YZvI/Me
         e9p+Q5QSAcY5yUeHkaXZMYbDoZUTTTY6qbm2SzSFgU5DQhiuCeVboFqrydE2arsNhZDb
         sPmA==
X-Gm-Message-State: AAQBX9cijWNVNSUGXuaucFmlrnzi7krF0xxRDuAmOhPDnXSLpFwDc5wP
        ozec+7NUZ3+D2/jArykqSBmFg+Qe5VE=
X-Google-Smtp-Source: AKy350b6EIoszL0MLK9VxD/SyGuJSu3zGGhxXa7DggjtZSCA8l2yRe9zb1npycWT30wpm5/jlC4v7g==
X-Received: by 2002:a17:90b:390a:b0:244:b000:d8e3 with SMTP id ob10-20020a17090b390a00b00244b000d8e3mr10163647pjb.45.1681042558567;
        Sun, 09 Apr 2023 05:15:58 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709026b4900b0019fea4d61c9sm5777925plt.198.2023.04.09.05.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 05:15:58 -0700 (PDT)
Date:   Sun, 9 Apr 2023 21:15:54 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     daniel@ffwll.ch, deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: KASAN: null-ptr-deref Read in soft_cursor
Message-ID: <ZDKsev8m5ShO_z0j@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We observed an issue "KASAN: null-ptr-deref in soft_cursor" during fuzzing.

We acknowledge that this issue is a bit old, and we are sorry for
reporting this late. And unfortunately, we have not found a reproducer
for the crash yet. We will inform you if we have any update on this
crash.  Detailed crash information is attached below.

Best regards,
Dae R. Jeong

-----
- Kernel version:
6.2-rc1

- Crash report:
==================================================================
BUG: KASAN: null-ptr-deref in soft_cursor+0x420/0xe80 drivers/video/fbdev/core/softcursor.c:70
Read of size 16 at addr 0000000000000200 by task systemd/1

CPU: 2 PID: 1 Comm: systemd Not tainted 6.2.0-rc1-30092-gc55e2cce6a18-dirty #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1cf/0x2c0 lib/dump_stack.c:106
 print_report+0xed/0x1f0 mm/kasan/report.c:420
 kasan_report+0xef/0x120 mm/kasan/report.c:517
 kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:189
 memcpy+0x25/0x60 mm/kasan/shadow.c:65
 soft_cursor+0x420/0xe80 drivers/video/fbdev/core/softcursor.c:70
 bit_cursor+0x1c95/0x2710 drivers/video/fbdev/core/bitblit.c:377
 hide_cursor+0x95/0x3f0 drivers/tty/vt/vt.c:907
 do_con_write+0x216/0xf270 drivers/tty/vt/vt.c:2927
 con_write+0x20/0x40 drivers/tty/vt/vt.c:3295
 process_output_block drivers/tty/n_tty.c:586 [inline]
 n_tty_write+0xef3/0x1420 drivers/tty/n_tty.c:2350
 do_tty_write drivers/tty/tty_io.c:1018 [inline]
 file_tty_write+0x625/0xa30 drivers/tty/tty_io.c:1089
 call_write_iter include/linux/fs.h:2186 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x848/0xd90 fs/read_write.c:584
 ksys_write+0x182/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa7860101b0
Code: 2e 0f 1f 84 00 00 00 00 00 90 48 8b 05 19 7e 20 00 c3 0f 1f 84 00 00 00 00 00 83 3d 19 c2 20 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24
RSP: 002b:00007ffea5a37dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000000000a RCX: 00007fa7860101b0
RDX: 000000000000000a RSI: 00007fa78853ccbe RDI: 0000000000000013
RBP: 00007fa78853ccbe R08: 00007ffea5a37d90 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000013
R13: 0000000000000000 R14: ffffffffffffffff R15: 00005626fb929250
 </TASK>
==================================================================
