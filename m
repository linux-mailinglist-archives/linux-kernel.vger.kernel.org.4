Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F36599AB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiL3PV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbiL3PVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:21:50 -0500
X-Greylist: delayed 436 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Dec 2022 07:21:48 PST
Received: from ofcsgdbm.dwd.de (ofcsgdbm.dwd.de [141.38.3.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60BB186DF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:21:48 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by ofcsg2dn1.dwd.de (Postfix) with ESMTP id 4Nk81f5jCnz1xZd
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dwd.de; h=
        content-type:content-type:mime-version:message-id:subject
        :subject:from:from:date:date:received:received:received:received
        :received:received:received:received; s=dwd-csg20210107; t=
        1672413270; x=1673622871; bh=3qsan0jyqr8GE3J5MzJTpSe93pjJ+4fq1vj
        UMbYAGt0=; b=hNhFvCOPjFuKEIfp/E8GcbgHBsas/POwNvFyqSC86bt8FYuCmEx
        GqXDSw2B99SFDIsk/i12dOUUYggsPwEYcHMVX/Wo8kmuXNhx/DMeIS4mywlZ0or8
        mwulGmWjBO10sM80Ae+AzCQarYeS62T1NKW+MI6vD94jGkqyCNM9uaSTsET2Iy3C
        d42AsJA73CDQjIjSE7yswkvvXElffQkTPgEtRmIHVhvenLnnI6+ZKBtWs8V9aEn+
        KLFMVvj8VxQgEUOUrSzTq+23qZa94r6h24DpLsMTmNvS4Lix0n+KauiSn+k8Dayh
        J2H4uGJARV2ZDYrM/3uWe/+ZiV3T7FudD5Q==
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2cteh1.dwd.de ([172.30.232.65])
 by localhost (ofcsg2dn1.dwd.de [172.30.232.24]) (amavisd-new, port 10024)
 with ESMTP id 0i7-fbU_clYC for <linux-kernel@vger.kernel.org>;
 Fri, 30 Dec 2022 15:14:30 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 58B1BC902C7E
        for <root@ofcsg2dn1.dwd.de>; Fri, 30 Dec 2022 15:14:30 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 4A37DC902C7C
        for <root@ofcsg2dn1.dwd.de>; Fri, 30 Dec 2022 15:14:30 +0000 (UTC)
X-DDEI-TLS-USAGE: Unused
Received: from ofcsgdbm.dwd.de (unknown [172.30.232.24])
        by ofcsg2cteh1.dwd.de (Postfix) with ESMTP
        for <root@ofcsg2dn1.dwd.de>; Fri, 30 Dec 2022 15:14:30 +0000 (UTC)
Received: from ofcsgdbm.dwd.de by localhost (Postfix XFORWARD proxy);
 Fri, 30 Dec 2022 15:14:30 -0000
Received: from ofcsg2dvf1.dwd.de (ofcsg2dvf1.dwd.de [172.30.232.10])
        by ofcsg2dn1.dwd.de (Postfix) with ESMTPS id 4Nk81f1Z5Sz1xZd;
        Fri, 30 Dec 2022 15:14:30 +0000 (UTC)
Received: from ofmailhub.dwd.de (ofmailhub.dwd.de [141.38.39.208])
        by ofcsg2dvf1.dwd.de  with ESMTP id 2BUFET9W015793-2BUFET9X015793;
        Fri, 30 Dec 2022 15:14:29 GMT
Received: from diagnostix.dwd.de (diagnostix.dwd.de [141.38.44.45])
        by ofmailhub.dwd.de (Postfix) with ESMTP id CB29745280;
        Fri, 30 Dec 2022 15:14:29 +0000 (UTC)
Date:   Fri, 30 Dec 2022 15:14:29 +0000 (GMT)
From:   Holger Kiehl <Holger.Kiehl@dwd.de>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: memcpy: detected field-spanning write (size 128) of single field
 "&r1_cmd->io_request->SGL" at drivers/scsi/megaraid/megaraid_sas_fusion.c:3326
 (size 16)
Message-ID: <88de8faa-56c4-693d-2d3-67152ee72057@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="646786348-1378339476-1672413269=:1844100"
X-FEAS-Client-IP: 141.38.39.208
X-FE-Last-Public-Client-IP: 141.38.39.208
X-FE-Policy-ID: 2:2:1:SYSTEM
X-TMASE-Version: DDEI-5.1-9.0.1002-27356.000
X-TMASE-Result: 10--11.598100-10.000000
X-TMASE-MatchedRID: H0y8l0/iTDcq/mR31mzCQJObxJgN/hOxfkuZtv/FS5pKC3gQHLUDUpgU
        Ly4zAbFBJZyncll9Yioa8S7tBYtNDHN94JK30y2IsApP/McUJK6fmd9HsjZ0U0ekR3VSvOYVyzQ
        Dw5yHT0HR7gdsg7zrbf73+nTN7plbI3NndjiMExGAwosDBeuPwTYvC/PFFfSAJYvGOWtLLy8t5F
        ll0ErBKf2xnceIhmwokelBawAEVAmEYjs8p9Au+IXQ/hu1OV/0jkDrBOJwwnS+f7ap9DJaDQ5yy
        v+x7gEpe+eZU8eiw0bXeRIHS1+6h3RzYmrvNw7ttT4jIeGRd/XT7Anw28zJOZcFdomgH0lngxsf
        zkNRlfKtIWznhjjBtfoLR4+zsDTtgUicvJ4MChmlT5d7ih0CPHoXIHDkgWPPP3cIGIWi8OixZEn
        7uOCk8dfNdKo4Qp+n
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-DDEI-PROCESSED-RESULT: Safe
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--646786348-1378339476-1672413269=:1844100
Content-Type: text/plain; format=flowed; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hello,

I am getting this at boot when filesystems are being mounted on all
systems with megaraid_sas:

          Starting File System Check…b5c5-42c7-93bc-06a5c05f0141...
[   25.705445] ------------[ cut here ]------------
[   25.718769] memcpy: detected field-spanning write (size 128) of single field "&r1_cmd->io_request->SGL" at drivers/scsi/megaraid/megaraid_sas_fusion.c:3326 (size 16)
[   25.751153] WARNING: CPU: 107 PID: 2741 at drivers/scsi/megaraid/megaraid_sas_fusion.c:3326 megasas_prepare_secondRaid1_IO+0x13d/0x150 [megaraid_sas]
[   25.783375] Modules linked in: sd_mod sg nvme nvme_core t10_pi crct10dif_pclmul crc32_pclmul crc32c_intel ahci crc64_rocksoft_generic ghash_clmulni_intel crc64_rocksoft ice libahci sha512_ssse3 bnxt_en crc64 sp5100_tco megaraid_sas
[   25.834579] CPU: 107 PID: 2741 Comm: fsck.ext4 Not tainted 6.1.1 #1
[   25.854737] Hardware name: Dell Inc. PowerEdge R7525/XXXXXX, BIOS 2.9.3 08/05/2022
[   25.872776] RIP: 0010:megasas_prepare_secondRaid1_IO+0x13d/0x150 [megaraid_sas]
[   25.891150] Code: 00 00 0f 85 2f ff ff ff b9 10 00 00 00 48 c7 c2 70 92 6f c0 4c 89 f6 48 c7 c7 c8 92 6f c0 c6 05 51 49 02 00 01 e8 fd 2a 3d d9 <0f> 0b e9 06 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44
[   25.931873] RSP: 0018:ffffa5588625f900 EFLAGS: 00010286
[   25.947337] RAX: 0000000000000000 RBX: ffff8df60693a180 RCX: 0000000000000000
[   25.966847] RDX: ffff8ff13e4ec700 RSI: ffff8ff13e4e0560 RDI: ffff8ff13e4e0560
[   25.985757] RBP: ffff8df60680e000 R08: 0000000000000000 R09: ffffffff9b184de0
[   26.012930] R10: 0000000000000001 R11: 0000000000000001 R12: ffffa5587374f058
[   26.035873] R13: ffff8df5f9470820 R14: 0000000000000080 R15: ffff8df6191b0750
[   26.054510] FS:  00007f8dac1e2780(0000) GS:ffff8ff13e4c0000(0000) knlGS:0000000000000000
[   26.073109] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.087901] CR2: 00007ffcd3263fe8 CR3: 00000100ad48e004 CR4: 0000000000770ee0
[   26.105898] PKRU: 55555554
[   26.118517] Call Trace:
[   26.130464]  <TASK>
[   26.144148]  megasas_build_and_issue_cmd_fusion+0x185/0x230 [megaraid_sas]
[   26.166138]  scsi_dispatch_cmd+0x8b/0x220
[   26.181020]  scsi_queue_rq+0x279/0x610
[   26.197569]  blk_mq_dispatch_rq_list+0x18b/0x690
[   26.216612]  __blk_mq_do_dispatch_sched+0xba/0x330
[   26.230539]  ? release_pages+0x15b/0x450
[   26.244164]  ? elv_attempt_insert_merge+0xbc/0x100
[   26.257915]  blk_mq_do_dispatch_sched+0x3b/0x70
[   26.271189]  __blk_mq_sched_dispatch_requests+0xf0/0x140
[   26.285749]  blk_mq_sched_dispatch_requests+0x34/0x60
[   26.299851]  __blk_mq_run_hw_queue+0x35/0x90
[   26.316085]  blk_mq_sched_insert_requests+0x6a/0x150
[   26.337224]  blk_mq_flush_plug_list+0x122/0x2f0
[   26.352449]  __blk_flush_plug+0x102/0x160
[   26.365502]  ? __wake_up_common_lock+0x8a/0xc0
[   26.379836]  blk_finish_plug+0x25/0x40
[   26.393678]  generic_writepages+0x5a/0x80
[   26.408024]  do_writepages+0xcf/0x1d0
[   26.422927]  filemap_fdatawrite_wbc+0x66/0x90
[   26.438551]  __filemap_fdatawrite_range+0x54/0x80
[   26.456288]  file_write_and_wait_range+0x43/0xa0
[   26.469451]  blkdev_fsync+0x14/0x40
[   26.481500]  __x64_sys_fsync+0x33/0x60
[   26.495285]  do_syscall_64+0x5c/0x90
[   26.509468]  ? ksys_write+0xab/0xe0
[   26.521848]  ? syscall_exit_to_user_mode+0x12/0x30
[   26.534957]  ? do_syscall_64+0x69/0x90
[   26.546588]  ? handle_mm_fault+0xee/0x2e0
[   26.557927]  ? do_user_addr_fault+0x1d6/0x690
[   26.569652]  ? exc_page_fault+0x5d/0x120
[   26.580668]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   26.597062] RIP: 0033:0x7f8dac32c067
[   26.608530] Code: ff ff ff ff eb b7 e8 38 82 01 00 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 6b f5 ff
[   26.641441] RSP: 002b:00007ffcd3266108 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
[   26.655857] RAX: ffffffffffffffda RBX: 000055f73742d400 RCX: 00007f8dac32c067
[   26.670764] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
[   26.685898] RBP: 00007ffcd3266170 R08: 0000000000000000 R09: 0000000000000000
[   26.702612] R10: 00000000000000c8 R11: 0000000000000246 R12: 0000000000000000
[   26.721338] R13: 00007ffcd3266178 R14: 000055f73742d1b0 R15: 000055f73742d1b0
[   26.739231]  </TASK>
[   26.748275] ---[ end trace 0000000000000000 ]---

Think this was introduced with kernel hardening code

    54d9469bc515 fortify: Add run-time WARN for cross-field memcpy()

CONFIG_FORTIFY_SOURCE=y, committed in 6.0-rc2 as mentioned in
https://bugzilla.kernel.org/show_bug.cgi?id=216563#c3

Regards,
Holger
--646786348-1378339476-1672413269=:1844100--

