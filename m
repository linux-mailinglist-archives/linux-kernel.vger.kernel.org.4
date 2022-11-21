Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CFF632584
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKUOVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiKUOVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:21:43 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E74DE86
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:21:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gv23so28904891ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9PEVyvdNnlM2nbDt3DALa8Lv8034KLXg9dcN4fEQvwk=;
        b=dq7VWROgtRS9PJW5ASV2VwqnNLSjdnHoGV7yFgO4moHQwl84th4Kimkna6OswMbThz
         sv5qDRn2LxIGI1DVk7/GbS+lnHagr1ixDCodI7M0/klVsJrE904byA6tfXiFjqigtcvN
         9zIvlS4wx711xqS9SCS4BC/6GMmmG69LfBz2qwoCvRnPhhNGTZkxR/hMIO/L56eoW7hj
         p94X/dTuBDC4pcQUqMuUQ/fIHPvEeYBoPaGCFysJ1tkRPs6xCApGAYCIMm5TBw+Amqsk
         I0vH9/Xm7GrGq7RTqMyCBht66pXTB7HvC99higOePV2nuJeO7yf2OETjgetY6IZ06ae/
         g94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9PEVyvdNnlM2nbDt3DALa8Lv8034KLXg9dcN4fEQvwk=;
        b=OtfAZ2V/cE2P8I70XqMDHuR5LcunsG06nF1UvpHPdY7NUu8nZN0IcOGLoPNt5gtd5r
         U4wrU+90QQLXMo3U0JpLYbFwXD+qMJdthhwSpdCyD3o+4tXpk2UrezcJQfg2EWB5/cBA
         37jRyer2bo9XqLtuenebrpJsxX9geELqaXwax3jWTWG/jb68dE3T1wM4PpCB38HQ3XX9
         MbzoI9JuOk3wflVvRhcGyyrHW5TwXOHLxF2JPgVl7aZb7ipcUS+T4m4r0tUQ2GKMRN33
         FO8X+lLmbM68DY+qC1XpzPElmlo9iRTWXLdsedy2ZgpNvKAmKw9OCL9Pxz6DZblOYr55
         5FJg==
X-Gm-Message-State: ANoB5pklDjTwH73cVI5U+AZt+/mEHHsFjqVIUXdWZQxMhhiJGzrsG7EH
        ti2UIqxVegbY1PKUavAOhebQpGBsdHpluw5Gf/M=
X-Google-Smtp-Source: AA0mqf4kMUnIDylWx34jziQyvZWiwVJQoAdn+KNBEbTn6gagnazEG9SbWy/KkDHFhJWxhDGnDshYKwZFBsEcwEHp07k=
X-Received: by 2002:a17:907:3ac5:b0:78d:5d4a:c12f with SMTP id
 fi5-20020a1709073ac500b0078d5d4ac12fmr16176504ejc.421.1669040498925; Mon, 21
 Nov 2022 06:21:38 -0800 (PST)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 21 Nov 2022 22:21:03 +0800
Message-ID: <CAO4mrffy+Zby8Lqt=gsPVxpmnfw7hbwZsdtMG-ryntBaEy1Nqg@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in alloc_buddy_hugetlb_folio
To:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered.

HEAD commit: 147307c69ba
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1b2z08RYnxoR5I8UiwqaMpG9E-dYgDTcL/view?usp=share_link
kernel config: https://drive.google.com/file/d/1NAf4S43d9VOKD52xbrqw-PUP1Mbj8z-S/view?usp=share_link
Syz reproducer:
https://drive.google.com/file/d/18vNqAHwkVoyx5Db2qnswcaiT-prLx_rx/view?usp=share_link

Unfortunately, if we transform the syz reproducer to C reproducer with
syz-prog2c, the crash would not happen. Please consider to use
syz-execprog and syz-executor to reproduce the crash.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD a9b2067 P4D a9b2067 PUD ab02067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 30461 Comm: syz-executor.0 Not tainted 6.1.0-rc5-next-20221118 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:_compound_head include/linux/page-flags.h:250 [inline]
RIP: 0010:alloc_buddy_hugetlb_folio+0x1bd/0x2b0 mm/hugetlb.c:2009
Code: ff 74 16 8b 04 24 34 01 75 0f e8 ae 04 d8 ff 49 63 c5 3e 49 0f
ab 07 eb 05 e8 9f 04 d8 ff 45 31 f6 49 8d 7e 08 e8 23 84 eb ff <49> 8b
5e 08 48 89 de 48 83 e6 01 31 ff e8 31 09 d8 ff 48 89 d8 48
RSP: 0018:ffffc90002823bd0 EFLAGS: 00010246
RAX: ffffffff814fad41 RBX: 0000000000000009 RCX: 0000000000040000
RDX: ffffc90000afd000 RSI: 0000000000000ab3 RDI: 0000000000000008
RBP: 0000000000146cca R08: 0001ffffffffffff R09: 0000000000000000
R10: 0001ffffffffffff R11: ffff88812663a000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f7190641700(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000000ab00000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 alloc_fresh_hugetlb_folio+0x73/0x370 mm/hugetlb.c:2030
 alloc_surplus_huge_page+0xb6/0x1a0 mm/hugetlb.c:2245
 alloc_buddy_huge_page_with_mpol mm/hugetlb.c:2321 [inline]
 alloc_huge_page+0x9d6/0x1620 mm/hugetlb.c:2937
 hugetlbfs_fallocate+0x57f/0xd70 fs/hugetlbfs/inode.c:865
 vfs_fallocate+0x486/0x710 fs/open.c:323
 ksys_fallocate fs/open.c:346 [inline]
 __do_sys_fallocate fs/open.c:354 [inline]
 __se_sys_fallocate fs/open.c:352 [inline]
 __x64_sys_fallocate+0x75/0xc0 fs/open.c:352
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x4697f9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7190640c48 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 000000000077bf80 RCX: 00000000004697f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f7190640c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008800000 R11: 0000000000000246 R12: 0000000000000005
R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffcccf17d70
 </TASK>
Modules linked in:
CR2: 0000000000000008
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:250 [inline]
RIP: 0010:alloc_buddy_hugetlb_folio+0x1bd/0x2b0 mm/hugetlb.c:2009
Code: ff 74 16 8b 04 24 34 01 75 0f e8 ae 04 d8 ff 49 63 c5 3e 49 0f
ab 07 eb 05 e8 9f 04 d8 ff 45 31 f6 49 8d 7e 08 e8 23 84 eb ff <49> 8b
5e 08 48 89 de 48 83 e6 01 31 ff e8 31 09 d8 ff 48 89 d8 48
RSP: 0018:ffffc90002823bd0 EFLAGS: 00010246
RAX: ffffffff814fad41 RBX: 0000000000000009 RCX: 0000000000040000
RDX: ffffc90000afd000 RSI: 0000000000000ab3 RDI: 0000000000000008
RBP: 0000000000146cca R08: 0001ffffffffffff R09: 0000000000000000
R10: 0001ffffffffffff R11: ffff88812663a000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f7190641700(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000000ab00000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: ff 74 16 8b          pushq  -0x75(%rsi,%rdx,1)
   4: 04 24                add    $0x24,%al
   6: 34 01                xor    $0x1,%al
   8: 75 0f                jne    0x19
   a: e8 ae 04 d8 ff        callq  0xffd804bd
   f: 49 63 c5              movslq %r13d,%rax
  12: 3e 49 0f ab 07        bts    %rax,%ds:(%r15)
  17: eb 05                jmp    0x1e
  19: e8 9f 04 d8 ff        callq  0xffd804bd
  1e: 45 31 f6              xor    %r14d,%r14d
  21: 49 8d 7e 08          lea    0x8(%r14),%rdi
  25: e8 23 84 eb ff        callq  0xffeb844d
* 2a: 49 8b 5e 08          mov    0x8(%r14),%rbx <-- trapping instruction
  2e: 48 89 de              mov    %rbx,%rsi
  31: 48 83 e6 01          and    $0x1,%rsi
  35: 31 ff                xor    %edi,%edi
  37: e8 31 09 d8 ff        callq  0xffd8096d
  3c: 48 89 d8              mov    %rbx,%rax
  3f: 48                    rex.W

Best,
Wei
