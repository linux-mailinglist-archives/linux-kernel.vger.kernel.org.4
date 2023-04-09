Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98B76DBFCD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 14:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjDIMRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 08:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 08:17:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F2C2727;
        Sun,  9 Apr 2023 05:17:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so883212pji.1;
        Sun, 09 Apr 2023 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681042641;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=raVQ6Mn2O5XUUM7epQk+2pwjEMob0hHDFVP85OeXRyI=;
        b=jR6TS9shBf3Ct4lEbPlbhvlQyxwkC3YhPXrc2yv+i5Kz8pBist9kPvEdQ/cGQmwQ5I
         XFKSfYXv2wAIsbb/aUkL+OpgJwr46WZdP0/s6WQQa1XVvQkBqvo4NJqrEWJvMHYtDq0a
         y6gibNbzTDFdkZbHMs26BO9kJSlZBd1ibZ4GX3nvD2kOqx+9B0rvd0v/js1D+ppNnK2j
         xXePq3fWCvg+NbJMloKNlsS14X2Q5HHj5huQ62plJ3Rjqt7Kt5BsK8khg3RKUxybqRr6
         T82CYs4ow+FTVS9m59e8QER074nzo5Rn4nRNoLKxUWgIvFknuQ9sZ6osIo8sRBlrVUP2
         sRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681042641;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=raVQ6Mn2O5XUUM7epQk+2pwjEMob0hHDFVP85OeXRyI=;
        b=ImO74Uz98RAocxI0KzTeaCBnySTEPlqQ7b6VEWd/cc9WZoqliOS9HlABRqaAaOJN2S
         e2SRJ0l3mI9vwTXLG5+E9B1TxcaHZ9UdTl4+DEvBinD6AvgvwpB+fKBBFdL5BpI4i1vU
         2DXIskRGvCi/m7sVziqnurdN9Vsk1booh/NJJaQjtQbLxAAYMPNRLofsNIUkjOVh0gOR
         eaecJ28goHHDI5a9C45NDF7y/kT1Vl0hUp8lAaoVLHxiHB8qmtCqiGcR+TFnjAVBC40S
         6ciG6mSSFUGzNDJBi7Rs6X1ok5qsGdJkKVd4zG3uXGhyTSYrljiV4qK8jvDOJrUXBfWP
         H6Ng==
X-Gm-Message-State: AAQBX9dyP/q+2339ELLEKYX5CEWfozbDTS6ln8qz1jVo+6Usrie0Uqq5
        PLYMRTZcUf/lOCTPiEYw5/k=
X-Google-Smtp-Source: AKy350Y5iBNjtaESU2HoOcExz48mEUPCtn0/soeA9uA+ZTStE0jeBz+YAQ9KEU5nKZsPKdNVvR4jTw==
X-Received: by 2002:a05:6a20:3b92:b0:d4:e980:9f90 with SMTP id b18-20020a056a203b9200b000d4e9809f90mr7545321pzh.44.1681042640806;
        Sun, 09 Apr 2023 05:17:20 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id n9-20020a62e509000000b00580e3917af7sm6027162pff.117.2023.04.09.05.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 05:17:20 -0700 (PDT)
Date:   Sun, 9 Apr 2023 21:17:16 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
        heikki.krogerus@linux.intel.com, mchehab@kernel.org,
        mailhol.vincent@wanadoo.fr, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: BUG: unable to handle kernel paging request in usb_start_wait_urb
Message-ID: <ZDKszDkJSxxRf_2J@dragonet>
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

We observed an issue "BUG: unable to handle kernel paging request in
usb_start_wait_urb" during fuzzing.

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
BUG: unable to handle page fault for address: ffff8800302e746d
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 8679 Comm: kworker/1:3 Not tainted 6.2.0-rc7-32171-g7f09e8f6ebfb #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Workqueue: pm hcd_resume_work
RIP: 0010:freelist_dereference mm/slub.c:388 [inline]
RIP: 0010:get_freepointer mm/slub.c:395 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:422 [inline]
RIP: 0010:__slab_alloc_node mm/slub.c:3347 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3442 [inline]
RIP: 0010:__kmem_cache_alloc_node+0x1b6/0x430 mm/slub.c:3491
Code: 48 89 df e8 6c 25 e7 ff 49 c1 ed 3a 44 3b 6d c0 0f 85 08 01 00 00 41 8b 5e 28 4c 8b 6d b8 4c 89 ef e8 0e 25 e7 ff 49 8d 3c 1c <49> 8b 1c 1c e8 41 25 e7 ff 49 8d 47 08 48 89 45 a0 49 8b 06 48 89
RSP: 0018:ffff888107ef3740 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffff888008441328 RDI: ffff8800302e746d
RBP: ffff888107ef37b0 R08: ffffffff83c943cc R09: ffffffff83c93f61
R10: 0000000000000002 R11: ffff888108e22180 R12: ffff8800302e7465
R13: ffff888008441328 R14: ffff888008441300 R15: 0000000000025081
FS:  0000000000000000(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8800302e746d CR3: 0000000010104000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc+0xa6/0x290 mm/slab_common.c:981
 kmalloc include/linux/slab.h:584 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 rh_call_control drivers/usb/core/hcd.c:514 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:848 [inline]
 usb_hcd_submit_urb+0x60c/0x10e0 drivers/usb/core/hcd.c:1552
 usb_submit_urb+0xc3d/0xcf0 drivers/usb/core/urb.c:596
 usb_start_wait_urb+0x8e/0x190 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x19d/0x250 drivers/usb/core/message.c:153
 get_port_status drivers/usb/core/hub.c:584 [inline]
 hub_ext_port_status+0xbd/0x3c0 drivers/usb/core/hub.c:601
 usb_hub_port_status drivers/usb/core/hub.c:623 [inline]
 hub_activate+0x50a/0x1150 drivers/usb/core/hub.c:1133
 hub_resume+0x49/0x210 drivers/usb/core/hub.c:3947
 usb_resume_interface drivers/usb/core/driver.c:1359 [inline]
 usb_resume_both+0x41e/0x640 drivers/usb/core/driver.c:1519
 usb_runtime_resume+0x21/0x30 drivers/usb/core/driver.c:1977
 __rpm_callback+0x185/0x2f0 drivers/base/power/runtime.c:392
 rpm_callback drivers/base/power/runtime.c:446 [inline]
 rpm_resume+0xa80/0xf60 drivers/base/power/runtime.c:912
 __pm_runtime_resume+0xe9/0x110 drivers/base/power/runtime.c:1170
 pm_runtime_get_sync include/linux/pm_runtime.h:429 [inline]
 usb_autoresume_device+0x25/0x60 drivers/usb/core/driver.c:1707
 usb_remote_wakeup+0x4a/0xa0 drivers/usb/core/hub.c:3785
 hcd_resume_work+0x2d/0x40 drivers/usb/core/hcd.c:2393
 process_one_work+0x281/0x6a0 kernel/workqueue.c:2289
 worker_thread+0x3a5/0x6c0 kernel/workqueue.c:2436
 kthread+0x13f/0x170 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
CR2: ffff8800302e746d
---[ end trace 0000000000000000 ]---
RIP: 0010:freelist_dereference mm/slub.c:388 [inline]
RIP: 0010:get_freepointer mm/slub.c:395 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:422 [inline]
RIP: 0010:__slab_alloc_node mm/slub.c:3347 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:3442 [inline]
RIP: 0010:__kmem_cache_alloc_node+0x1b6/0x430 mm/slub.c:3491
Code: 48 89 df e8 6c 25 e7 ff 49 c1 ed 3a 44 3b 6d c0 0f 85 08 01 00 00 41 8b 5e 28 4c 8b 6d b8 4c 89 ef e8 0e 25 e7 ff 49 8d 3c 1c <49> 8b 1c 1c e8 41 25 e7 ff 49 8d 47 08 48 89 45 a0 49 8b 06 48 89
RSP: 0018:ffff888107ef3740 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffff888008441328 RDI: ffff8800302e746d
RBP: ffff888107ef37b0 R08: ffffffff83c943cc R09: ffffffff83c93f61
R10: 0000000000000002 R11: ffff888108e22180 R12: ffff8800302e7465
R13: ffff888008441328 R14: ffff888008441300 R15: 0000000000025081
FS:  0000000000000000(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8800302e746d CR3: 0000000010104000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 df             	mov    %rbx,%rdi
   3:	e8 6c 25 e7 ff       	callq  0xffe72574
   8:	49 c1 ed 3a          	shr    $0x3a,%r13
   c:	44 3b 6d c0          	cmp    -0x40(%rbp),%r13d
  10:	0f 85 08 01 00 00    	jne    0x11e
  16:	41 8b 5e 28          	mov    0x28(%r14),%ebx
  1a:	4c 8b 6d b8          	mov    -0x48(%rbp),%r13
  1e:	4c 89 ef             	mov    %r13,%rdi
  21:	e8 0e 25 e7 ff       	callq  0xffe72534
  26:	49 8d 3c 1c          	lea    (%r12,%rbx,1),%rdi
* 2a:	49 8b 1c 1c          	mov    (%r12,%rbx,1),%rbx <-- trapping instruction
  2e:	e8 41 25 e7 ff       	callq  0xffe72574
  33:	49 8d 47 08          	lea    0x8(%r15),%rax
  37:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  3b:	49 8b 06             	mov    (%r14),%rax
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89
