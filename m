Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA0612A28
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJ3KiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3KiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:38:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75327E62
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:38:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id 13so22971571ejn.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b/AuLbTZoT8XYza5mPP+NrdXykdUcGA7om2sJd/4Q4o=;
        b=ieLYe7G0lPqNPg90uhZdvPsnDP+m9GAZ+2SJN7opTHiXinarpUJ+asBpHcvBb/TE0D
         t/DsSbxICnqYOD9iMLB4yO6+fOnzN7xnB5imVQllQHMQFk/xD+LAX+Z01rA8o6SMmR/B
         QrrP1xet9XzzL47FdD1Cjx3fOP3R24hMCMrGp6OtNnxz4TZvhTTEV9OutTr0r4+klh09
         bvCJa8bwySutiwEyYvrMhqopYwiH3pUeoY9HDbFudLoGb+Qg9dVHJl2xeNOmjmfkNU4I
         c8JMTX85QKJGQ7CDd/wSZFzg/irALTB9775NODTx7IIwWVbvAWJ8NyDmuhx9HytOkBSL
         56hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/AuLbTZoT8XYza5mPP+NrdXykdUcGA7om2sJd/4Q4o=;
        b=thGKIRbxPZW0QLLwxjmqRh5TMaLAY6oY3aRilAXYJ4Wcy27Iemj5x/EpC5Q9bUwOCM
         KR/32lkS8nsHMNstGrf5Uj3bH85hBM7mENc5XnDAy1/ZjO2KQ4kPpNJyCJ8enmDw93Xn
         jMBzpcMXgphj/rtBU1Eyn452bEnLn0A3EkJip9y8crT/8iMY/PBmNtYMhjMDFOOEw/9L
         2vCEyeBT+EWLsTAM80ZWxTM0xzNo7Eb//BaCIFbVIYmjfWM1yK7YFACGuhBpBxRBZ0/G
         SY7q7Fdx1q5LJYcYeTqHs1YOYcCTF24tMETrRXuWrQDwJ0CRAibnH6M0DFxcFl7v31B1
         PI5w==
X-Gm-Message-State: ACrzQf2oT5fq56zbVouc5UzXOmiQgVK2i1WnJpCLFpIhOt3uVMaEzRDn
        65T0MpJcZYO+PTlxin80I69O4bgSWoqXzbDdnig=
X-Google-Smtp-Source: AMsMyM5RMVQwmnh+LEOn+7B3BW5pwvyDW+ilcZOPTMZQNQFhHE+kxfQSpJPy6HgCzUgVZ5HvstJohjZ/B3fK0LWIXHk=
X-Received: by 2002:a17:907:2c75:b0:78d:c201:e9aa with SMTP id
 ib21-20020a1709072c7500b0078dc201e9aamr7689123ejc.235.1667126291977; Sun, 30
 Oct 2022 03:38:11 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 18:37:36 +0800
Message-ID: <CAO4mrfcw6RxYreivijxCgQLOYc8sEQaWG=Q-Y1yX85LNPkdNmw@mail.gmail.com>
Subject: WARNING in save_fpregs_to_fpstate
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org
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

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: gcc 8.0.1
console output:
https://drive.google.com/file/d/1DkbPrIA6cVbIgS86sfFCZARE1jKhbMTk/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

set kvm_intel.dump_invalid_vmcs=1 to dump internal KVM state.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 11082 at arch/x86/include/asm/fpu/internal.h:304
save_fpregs_to_fpstate+0xc2/0xe0
Modules linked in:
CPU: 1 PID: 11082 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:save_fpregs_to_fpstate+0xc2/0xe0
Code: 08 5b 5d 41 5c 41 5d 41 5e e9 da c3 29 00 e8 d5 c3 29 00 48 0f
ae 45 40 5b 5d 41 5c 41 5d 41 5e e9 c3 c3 29 00 e8 be c3 29 00 <0f> 0b
eb a2 e8 b5 c3 29 00 0f 0b e9 75 ff ff ff 0f 1f 40 00 66 2e
RSP: 0018:ffffc900028ffda0 EFLAGS: 00010212
RAX: 000000000000e11d RBX: 00000000fffffffe RCX: 0000000000040000
RDX: ffffc90002a29000 RSI: ffff888135ae3700 RDI: 0000000000000002
RBP: ffff888010bde180 R08: ffffffff8113afa2 R09: 0000000000000000
R10: 0000000000000005 R11: 00000000fffffffe R12: 0000000000000007
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
FS:  00007ffa8d5d6700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000003d98d000 CR4: 00000000000026e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000006e52
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 kvm_save_current_fpu+0x61/0x70
 kvm_put_guest_fpu+0x34/0x230
 kvm_arch_vcpu_ioctl_run+0x541/0xb20
 kvm_vcpu_ioctl+0x3b8/0xa30
 __x64_sys_ioctl+0xe8/0x140
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4692c9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffa8d5d5c38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004692c9
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 000000000119bfb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bfac
R13: 0000000000000000 R14: 000000000119bfa0 R15: 00007fff96fd8ad0

Best,
Wei
