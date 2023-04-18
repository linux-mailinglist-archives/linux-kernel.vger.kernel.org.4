Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE4A6E583E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjDRE73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRE71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:59:27 -0400
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19622D77
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1681793965; x=1713329965;
  h=mime-version:from:date:message-id:subject:to;
  bh=98Q2lIKGXj/TGphoJQ26QVEniVJlpkDOfi8A6jvyOYU=;
  b=HxNHUjEbnUiHa8ElMlb2YlHPO7ZPyKyl0tsisewv4fllWH9uLBJHy9iu
   W+fM9wKbEQ8M63F2/Uf0mZNbveyt2t+OekjNzv6sHXtPH9YawERVSBhPE
   fzzD0peF6Q8whKIebWbunhCnVFJMjNArt3NXzkuQB7Kgf1k6m6MAJSGBo
   GpeGqkv+1cRQR6I6SXqPmr8lCWQehl1FBqI0T0qOziKWox3G4mTjOkDKe
   9UJLujjeZlhYjPyMOOviZJjVrhQsiUXOUqOWl/gp4Mf4A2t45YuR7Cy2p
   zkeOjPPvkDTOmk8nlcs8quUkLNluf/mgwHMlg6NdEBajzBCpGpUCi5UlX
   w==;
Received: from mail-wm1-f72.google.com ([209.85.128.72])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2023 21:59:25 -0700
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f1749c63c9so4136915e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1681793963; x=1684385963;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WO/9DwG7mN10zw1Wsfz7OasLpMvXhn/ybdShM4ePvbg=;
        b=wj6GQ1s4SgTCWv0CHvxU8LO8yABWm+VnChKGS3jwmESuFqfGe/zkBvXYk4YqShp+LM
         JUqu7vIQaWnGGPQ87duhhSvxcoWguQNRU2Bb4TC4uwJ65ExUp+Rn5C7I/vGVZNokI8XE
         WUQQE3aDrehAc/9BSJwJteP4Ahv34tVZRf3VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681793963; x=1684385963;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WO/9DwG7mN10zw1Wsfz7OasLpMvXhn/ybdShM4ePvbg=;
        b=OO96ORJH7lqPm/uAR70lTI+FQJmwn6SDSJDbKPW1etCLYiKQ/vMsTQactKf0cu/gen
         66TvkvUrn4B01sQDl67NLKlH9XxHrnn2DEdcudxaRFU3nVgBRZHVLTSIf3kXMkeQ7pV1
         yqhVGwQpoY/ScE9G/+YWUSbuoyJMnat9Wh1gaVMYRLgX1H+Bf0aa0xJIT3B3m9eFY3yj
         iMpQl5V3Fl2PZkm5zuEqH9jxYbRZwj1ArJpv41u9rBL1s4voX2MaO8pxuPd9MS12pKM3
         x7D3tfjW/KeALe3iIG921UVs6/5QNy62Ox3yRnspC3fwCafCpxaoJhVsW8GOboE+Zuxi
         JsKQ==
X-Gm-Message-State: AAQBX9clzL+sdfLhy7PSoulKFRIBxyZ8jH78wluueRYyunXYMdRd2oZB
        1UjtKaZTsIXJ6Ig0sD6Iv4jI4h2ghge+YHiagJ8xkQjCOCIcbGALl+jIn1tM9/gaoObChKnFYug
        1mZYNuvMm2Km6YsVJKsGY/TyV5ZJRulWUvZ3gQ0+S7Q==
X-Received: by 2002:adf:ee86:0:b0:2f5:fbe5:bb1c with SMTP id b6-20020adfee86000000b002f5fbe5bb1cmr841613wro.63.1681793963334;
        Mon, 17 Apr 2023 21:59:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350YPjWSAfJLf/Il143EKEgyc3ZQ+0vGEJZbFk49zxFaL8teYJxnS4znmbHqDafxpzBJuLL5OqZDv+9HQkDiEA9A=
X-Received: by 2002:adf:ee86:0:b0:2f5:fbe5:bb1c with SMTP id
 b6-20020adfee86000000b002f5fbe5bb1cmr841604wro.63.1681793963031; Mon, 17 Apr
 2023 21:59:23 -0700 (PDT)
MIME-Version: 1.0
From:   Yu Hao <yhao016@ucr.edu>
Date:   Mon, 17 Apr 2023 21:59:12 -0700
Message-ID: <CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com>
Subject: BUG: general protection fault in hci_uart_tty_ioctl
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We found the following issue using syzkaller on Linux v6.2.0.

In function `hci_uart_tty_ioctl`, there is a race condition
between HCIUARTSETPROTO and HCIUARTGETPROTO.
HCI_UART_PROTO_SET is set before `hu->proto` is set.
Thus it may dereference a null pointer.

The full report including the Syzkaller reproducer & C reproducer:
https://gist.github.com/ZHYfeng/a3e3ff2bdfea5ed5de5475f0b54d55cb

The brief report is below:

Syzkaller hit 'general protection fault in hci_uart_tty_ioctl' bug.

general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 8770 Comm: syz-executor.0 Not tainted 6.2.0 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:hci_uart_tty_ioctl+0x244/0xc20 drivers/bluetooth/hci_ldisc.c:774
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cf 08 00 00 48 8b 9b
b8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <0f> b6
04 02 84 c0 74 08 3c 03 0f 8e 5f 08 00 00 44 8b 23 e9 14 ff
RSP: 0018:ffffc900022a7d10 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8710057c
RDX: 0000000000000000 RSI: ffff888046df8000 RDI: ffff88801cf510b8
RBP: 0000000000000001 R08: 0000000000000001 R09: ffffed10039ea204
R10: ffff88801cf5101f R11: ffffed10039ea203 R12: ffff8880204eb000
R13: 0000000000000000 R14: ffffffffffffffe7 R15: 00000000800401c0
FS:  00007f203e7dd700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005587ec7f32d8 CR3: 000000004629e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tty_ioctl+0xac0/0x1420 drivers/tty/tty_io.c:2784
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x198/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f203f0902fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f203e7dcc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f203f1bc020 RCX: 00007f203f0902fd
RDX: 0000000000000000 RSI: 00000000800455c9 RDI: 0000000000000003
RBP: 00007f203f0fec89 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffee4615aef R14: 00007ffee4615ca0 R15: 00007f203e7dcdc0
 </TASK>
