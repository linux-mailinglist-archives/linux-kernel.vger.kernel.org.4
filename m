Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E4E6E5860
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDRFLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDRFK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:10:59 -0400
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9082108
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1681794657; x=1713330657;
  h=mime-version:from:date:message-id:subject:to;
  bh=TurDRCtZ1J/dNDAimU8rHcNjMaqahe/MnINBq4Z4JBk=;
  b=MwR8Hq8Mo1ww4+eUfMnxN43HO1xaa7Rii+N77lWqHp3Bq/p736vCrQcB
   UHksZH0hkCpIN5ChKbGInRCPui79sjHePSYQihLmttXgoYcV/+Mp5jjsb
   6nW0M51DIgS6kAOUvzoVYSKeIcQvYnO5bXj427+6j6Ygpog1TuvcRtjSH
   0U1aLgi9GbeW5u7yZ9nokBXXywa4H+w/I7sVUY0+CDqwGTpbZoddVRB9/
   p98zEca0zOK3mqCJBWmoK6C2Iv6Ejdio3lH6qKAdGhsYnZA9euDBy4JbM
   UGQtFZAaTAdNCYlM9lz66ZLj/Rfs14R6kzH0b9LQEyVkuJVddvfNXbSdm
   w==;
Received: from mail-wr1-f72.google.com ([209.85.221.72])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2023 22:10:56 -0700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2f443ca3357so536838f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1681794653; x=1684386653;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+7Fedb5tj9ghgEdpqXU48jiWB2RrGK2UDeTIQwVU23U=;
        b=JsxNb045D5qsw3jh8O1I5JW9+GpZrq6cBZjmDOSsfdgfhh/R/2REh/fxslBQK7ROU/
         LpHps9OaFiMomO1vafkOZ+rXya4SsM4enYThwP7bubI/P0u79dp4Wxq5spsA+EiIwM84
         LdiDGPaQ+lVLe8FrXxjqU+HBlgwDoTojtXWqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681794653; x=1684386653;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+7Fedb5tj9ghgEdpqXU48jiWB2RrGK2UDeTIQwVU23U=;
        b=LAcwA8vIZTfLKmagiKwxFtrbxndXqhaoS9JVKYfDdT8MpCeWgKoQL8Vhk1wIrqlCM3
         HKmo3N4EEyK00e5dnyRUwwQ1tvfatOAXUDFm55oT+9lCK7BXaAZm83IimSSW2aqw7eBf
         QPk3ivH0GWiarTEQhotWcv8/pVRoYqI+VNFtjl4Gui6AWqIdTy2mkZa5ot12RDrqpyPO
         O1d2STKbJWgM1syCcAFQ8zRpTxUVDEX8ZWRPWvnWw5cWP7ctpyF0aDsR2kLuQGnSjPy5
         muxo8z+wchz8WFd+HKiqvoJoi6WIJGJORNvZ9UIw2moyFI/jNteTylCxR5j65A+nI8vT
         aZ6A==
X-Gm-Message-State: AAQBX9cQYE2XLv1bV5ePEK4ClAU1SFGd9jUeTZr2lHAiI6df0gGFNmcg
        KU87EcxZDLMXGRS69P4hv+Q3+xKT78cON5ePQQZ64G4dwUHeuBfgbR3arBAROp0u21Elf7h+9Jd
        B65VJ2w3UJKeCTPV0QtLp2QGjdOfq0rDoXEXtYXVjzA==
X-Received: by 2002:a5d:43c2:0:b0:2f5:83a8:a9a9 with SMTP id v2-20020a5d43c2000000b002f583a8a9a9mr681125wrr.16.1681794653695;
        Mon, 17 Apr 2023 22:10:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z/B26dTF8Ao0J/9seDtO9mdlQzYWs61Wdbt4Di8NjirpY9mhIpS9Y6HDB/RpLPwVHpqyfpbNpTKCHaKE5U73k=
X-Received: by 2002:a5d:43c2:0:b0:2f5:83a8:a9a9 with SMTP id
 v2-20020a5d43c2000000b002f583a8a9a9mr681112wrr.16.1681794653415; Mon, 17 Apr
 2023 22:10:53 -0700 (PDT)
MIME-Version: 1.0
From:   Yu Hao <yhao016@ucr.edu>
Date:   Mon, 17 Apr 2023 22:10:42 -0700
Message-ID: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com>
Subject: BUG: divide error in ubi_attach_mtd_dev
To:     richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-mtd@lists.infradead.or, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We found the following issue using syzkaller on Linux v6.2.0.
The full report:
https://gist.github.com/ZHYfeng/a3e3ff2bdfea5ed5de5475f0b54d55cb

The brief report is below:

ubi: mtd0 is already attached to ubi0
ubi7: attaching mtd147
divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 20023 Comm: syz-executor.0 Not tainted 6.2.0 #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:mtd_div_by_eb include/linux/mtd/mtd.h:580 [inline]
RIP: 0010:io_init drivers/mtd/ubi/build.c:620 [inline]
RIP: 0010:ubi_attach_mtd_dev+0x77f/0x2fe0 drivers/mtd/ubi/build.c:955
Code: fc ff df 48 c1 ea 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38
d0 7c 08 84 d2 0f 85 1f 25 00 00 41 8b 4c 24 10 48 89 d8 31 d2 <48> f7
f1 48 89 c3 e8 b6 f3 1b fc 48 8d 85 40 17 00 00 48 89 c2 48
RSP: 0018:ffffc9000be0fd30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff888047a49d40 RDI: 0000000000000002
RBP: ffff888024e1c000 R08: 0000000000000016 R09: fffff520017c1f47
R10: ffffc9000be0fa37 R11: fffff520017c1f46 R12: ffff88806545a000
R13: 0000000000000000 R14: ffff88806545a010 R15: 0000000000000007
FS:  00007fd45e85c700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f64aeef53a4 CR3: 000000004f39a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ctrl_cdev_ioctl+0x303/0x3a0 drivers/mtd/ubi/cdev.c:1043
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x198/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd45d6902fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd45e85bc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd45d7bbf60 RCX: 00007fd45d6902fd
RDX: 0000000020000000 RSI: 0000000040186f40 RDI: 0000000000000005
RBP: 00007fd45d6fec89 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff676814bf R14: 00007fff67681670 R15: 00007fd45e85bdc0
 </TASK>
