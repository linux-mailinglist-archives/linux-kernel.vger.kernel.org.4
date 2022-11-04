Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9534A619A9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiKDOyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKDOyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:54:47 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D3B2C67D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:54:46 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id x6-20020a056e021ca600b002ffe4b15419so3978809ill.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drddh3mL0z4vEtMFLWh/GDM23ivjXc1rJj9XAt34JSE=;
        b=gtz7BcpvVkMvr28fUt6nHR9498odEuKKBGrQ7brpHLw+O732UhnGPix5wt2aK/ge5O
         GoA4A+a1eHFwy113N7xCigjqSwbG3l+Iu3pZml2pgjxNfasjf5ZPhD9QGO5vi8FyvpTD
         rTCtUQNkYtdGlmjM4c5GjTvzlV9ogxqsRIMs/dxk3mO0DTrrmSo/q/o8iPCdzGYIJGFa
         UICu+Rkad4KNkBEX+RH1xc9I2nvubs6rpCQlqwIUiNAY/byA8kvAxx9nL+StYbnaBAsT
         /kf47x4tKXRhjGjg1B8yeJS8szWOzc763yXAv9dZEYI7Cw9GbZzz4SLgQfjuq1wZ6pWl
         xIzw==
X-Gm-Message-State: ACrzQf20+H3pd94+oBZWWVNaCfayqx2F0Jj6zaExXZez1c+U+Ow0y8q2
        50wN6ORciVUrKl9+OvgwPvrP+jZYv0tbAQPWep/EYLgF2sWZ
X-Google-Smtp-Source: AMsMyM46qCQgAyWlhHt4SM/eJE7JQVjnZ45E3/18Hnf3CfeMX4hZJ7Uw0S6/oWdckqTycoO8PfmgWaPePiXMd/A/geLezZql2Gkv
MIME-Version: 1.0
X-Received: by 2002:a92:b704:0:b0:300:9ad3:a7b2 with SMTP id
 k4-20020a92b704000000b003009ad3a7b2mr19826485ili.65.1667573686334; Fri, 04
 Nov 2022 07:54:46 -0700 (PDT)
Date:   Fri, 04 Nov 2022 07:54:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035fba305eca64106@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in get_desc
From:   syzbot <syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com>
To:     bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        thomas.lendacky@amd.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    81214a573d19 Add linux-next specific files for 20221103
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=132019de880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc625e9234bac0
dashboard link: https://syzkaller.appspot.com/bug?extid=ffb4f000dc2872c93f62
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12dd52ca880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5d4dda497754/disk-81214a57.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9658efff160a/vmlinux-81214a57.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3711180f2565/bzImage-81214a57.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffbc5a1c22e00
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffe4067 P4D 23ffe4067 PUD 13ff2d067 PMD 13ff2c067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5368 Comm: syz-executor.2 Not tainted 6.1.0-rc3-next-20221103-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:get_desc+0x128/0x460 arch/x86/lib/insn-eval.c:660
Code: de 02 00 00 83 e0 07 38 c2 0f 9e c1 84 d2 0f 95 c0 84 c1 0f 85 c9 02 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 d8 48 c1 e8 03 <0f> b6 0c 10 48 8d 43 07 48 89 c6 48 c1 ee 03 0f b6 14 16 48 89 de
RSP: 0018:ffffc9000431fd08 EFLAGS: 00010a06
RAX: 1fffffc5a1c22e00 RBX: fffffe2d0e117000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000006
RBP: ffffc9000431fdc0 R08: 0000000000000006 R09: 000000000000007f
R10: 0000000000000000 R11: 0000000000000001 R12: 1ffff92000863fa1
R13: dffffc0000000000 R14: 0000000000000000 R15: 000000000000007f
FS:  00007f250ff0e700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbc5a1c22e00 CR3: 0000000028c1f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 insn_get_seg_base arch/x86/lib/insn-eval.c:725 [inline]
 insn_get_effective_ip+0x187/0x1f0 arch/x86/lib/insn-eval.c:1476
 fixup_iopl_exception+0xd0/0x190 arch/x86/kernel/traps.c:627
 __exc_general_protection arch/x86/kernel/traps.c:752 [inline]
 exc_general_protection+0x176/0x210 arch/x86/kernel/traps.c:728
 asm_exc_general_protection+0x22/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0003:0x7f250f3abf8c
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 <00> 00 00 00 48 00 e0 0e 25 7f 00 00 ff ff ff ff ff ff ff ff 01 00
RSP: 0003:00007f250f3abf80 EFLAGS: 00010e96
RAX: 000000003ac744f0 RBX: 0000000000000000 RCX: 00007f250f3abf88
RDX: 0000000000000038 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f250f3abf80
R10: 0000000000000000 R11: ffffffff00000b5e R12: 00007f250f3abfb0
R13: 00007f250f360680 R14: 0000000000000038 R15: 000000003acf0fd6
 </TASK>
Modules linked in:
CR2: fffffbc5a1c22e00
---[ end trace 0000000000000000 ]---
RIP: 0010:get_desc+0x128/0x460 arch/x86/lib/insn-eval.c:660
Code: de 02 00 00 83 e0 07 38 c2 0f 9e c1 84 d2 0f 95 c0 84 c1 0f 85 c9 02 00 00 48 ba 00 00 00 00 00 fc ff df 48 89 d8 48 c1 e8 03 <0f> b6 0c 10 48 8d 43 07 48 89 c6 48 c1 ee 03 0f b6 14 16 48 89 de
RSP: 0018:ffffc9000431fd08 EFLAGS: 00010a06
RAX: 1fffffc5a1c22e00 RBX: fffffe2d0e117000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000006
RBP: ffffc9000431fdc0 R08: 0000000000000006 R09: 000000000000007f
R10: 0000000000000000 R11: 0000000000000001 R12: 1ffff92000863fa1
R13: dffffc0000000000 R14: 0000000000000000 R15: 000000000000007f
FS:  00007f250ff0e700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbc5a1c22e00 CR3: 0000000028c1f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	de 02                	fiadds (%rdx)
   2:	00 00                	add    %al,(%rax)
   4:	83 e0 07             	and    $0x7,%eax
   7:	38 c2                	cmp    %al,%dl
   9:	0f 9e c1             	setle  %cl
   c:	84 d2                	test   %dl,%dl
   e:	0f 95 c0             	setne  %al
  11:	84 c1                	test   %al,%cl
  13:	0f 85 c9 02 00 00    	jne    0x2e2
  19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  20:	fc ff df
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 0c 10          	movzbl (%rax,%rdx,1),%ecx <-- trapping instruction
  2e:	48 8d 43 07          	lea    0x7(%rbx),%rax
  32:	48 89 c6             	mov    %rax,%rsi
  35:	48 c1 ee 03          	shr    $0x3,%rsi
  39:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx
  3d:	48 89 de             	mov    %rbx,%rsi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
