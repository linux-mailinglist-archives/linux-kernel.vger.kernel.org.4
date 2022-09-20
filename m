Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66BB5BE377
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiITKjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiITKjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:39:17 -0400
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACDE5696E2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:38:14 -0700 (PDT)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id BAEA0DF00AC; Tue, 20 Sep 2022 12:38:12 +0200 (CEST)
Date:   Tue, 20 Sep 2022 12:38:12 +0200
From:   Philippe De Muyter <phdm@macq.eu>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Wu Bo <bo.wu@vivo.com>, wubo.oduw@gmail.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: does fsck.f2fs-1.14 breaks f2fs filesystem from linux-4.1.15 ?
Message-ID: <20220920103812.GA12541@172.21.0.10>
References: <20220914080839.GA19067@172.21.0.10> <20220915071004.23550-1-bo.wu@vivo.com> <20220916145906.GA6753@172.21.0.10> <YykO3Fh9Q20n36dk@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <YykO3Fh9Q20n36dk@google.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Kim,

On Mon, Sep 19, 2022 at 05:52:44PM -0700, Jaegeuk Kim wrote:
> Hi Philippe,
> 
> Kernel 4.1 is really old one, so is there any chance to upgrade the kernel
> at least 4.14? You can find all the backports from below.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-stable.git

Actually it's freescale-originated kernel based on 4.1.15.  I can update
the f2fs driver if it remains compatible with the rest of the kernel,
but I cannot update the kernel because all the freescale drivers
are based on 4.1.15 and are not compatible with higher kernel versions.

Actually, the f2fs driver in 4.1.15 works well enough, but I would like
to run fsck.f2fs on the partition before mounting it.  I had picked up
the 1.14 version of fsck.f2fs which was the last available some weeks
ago.  I could use another one if you recommend another one to me.

What I noticed when using fsck.f2fs-1.14 is :

It detects that my f2fs partition is from an old version :

    Info: Force to fix corruption
    Info: Segments per section = 1
    Info: Sections per zone = 1
    Info: sector size = 512
    Info: total sectors = 7372800 (3600 MB)
    Info: MKFS version
      ""
    Info: FSCK version
      from ""
        to "Linux version 4.1.15-02187-g7bc7275 (phdm@perdita) (gcc version 4.6.2 20110630 (prerelease) (Freescale MAD -- Linaro 2011.07 -- Built at 2011/08/10 09:20) ) #173 SMP PREEMPT Thu Sep 15 18:15:41 CEST 2022"
    Info: superblock features = 0 :
    Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
    Info: total FS sectors = 7372800 (3600 MB)
    Info: CKPT version = 31bff9
    Info: Corrupted valid nat_bits in checkpoint
    Info: Write valid nat_bits in checkpoint
    Info: checkpoint state = 284 :  allow_nocrc nat_bits compacted_summary sudden-power-off

Then it changes i_gc_failures from 0x1 to 0x00, for many items; the amount
seems to be proportional to the number of new files in the partition.

Then it terminates with what looks to me as a success message :

    [FSCK] Max image size: 3600 MB, Free space: 963 MB
    [FSCK] Unreachable nat entries                        [Ok..] [0x0]
    [FSCK] SIT valid block bitmap checking                [Ok..]
    [FSCK] Hard link checking for regular file            [Ok..] [0x956]
    [FSCK] valid_block_count matching with CP             [Ok..] [0x91e7b]
    [FSCK] valid_node_count matching with CP (de lookup)  [Ok..] [0x128b9]
    [FSCK] valid_node_count matching with CP (nat lookup) [Ok..] [0x128b9]
    [FSCK] valid_inode_count matched with CP              [Ok..] [0x127be]
    [FSCK] free segment_count matched with CP             [Ok..] [0x263]
    [FSCK] next block offset is free                      [Ok..]
    [FSCK] fixing SIT types
    [FSCK] other corrupted bugs                           [Ok..]
    Info: Duplicate valid checkpoint to mirror position 512 -> 1024
    Info: Write valid nat_bits in checkpoint
    Info: Write valid nat_bits in checkpoint

But thereafter, the f2fs driver in the 4.1.15 kernel complains once with
    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 2359 at fs/f2fs/node.c:1863 flush_nat_entries+0x734/0x7c4()
    Modules linked in:
    CPU: 0 PID: 2359 Comm: python3 Not tainted 4.1.15-02177-gcef0cbe-dirty #166
    Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
    [<80015f58>] (unwind_backtrace) from [<80012020>] (show_stack+0x10/0x14)
    [<80012020>] (show_stack) from [<80732e64>] (dump_stack+0x68/0xb8)
    [<80732e64>] (dump_stack) from [<8002b694>] (warn_slowpath_common+0x74/0xac)
    [<8002b694>] (warn_slowpath_common) from [<8002b6e8>] (warn_slowpath_null+0x1c/0x24)
    [<8002b6e8>] (warn_slowpath_null) from [<8024f8dc>] (flush_nat_entries+0x734/0x7c4)
    [<8024f8dc>] (flush_nat_entries) from [<8024456c>] (write_checkpoint+0x208/0xe68)
    [<8024456c>] (write_checkpoint) from [<802400c4>] (f2fs_sync_fs+0x50/0x70)
    [<802400c4>] (f2fs_sync_fs) from [<8010436c>] (sync_fs_one_sb+0x28/0x2c)
    [<8010436c>] (sync_fs_one_sb) from [<800df9e0>] (iterate_supers+0xac/0xd4)
    [<800df9e0>] (iterate_supers) from [<80104414>] (sys_sync+0x48/0x98)
    [<80104414>] (sys_sync) from [<8000f440>] (ret_fast_syscall+0x0/0x3c)
    ---[ end trace 5d91f10cd7a61715 ]---

The same run of the kernel afterwards complains about accesses beyond
end of the device , with three different sizes: 112, 16384 and 16.

    attempt to access beyond end of device
    mmcblk0p2: rw=112, want=58078880, limit=7372800
    ...
    attempt to access beyond end of device
    mmcblk0p2: rw=16384, want=6874055224, limit=7372800
    ...
    attempt to access beyond end of device
    mmcblk0p2: rw=16, want=2693281864, limit=7372800

And after a reboot, the run of fsck.f2fs removes many not new files and
directories !!!  I have attached a log.  So it seems to me that despite
the efforts in that sense, fsck.f2fs is currently not compatible with
the f2fs driver from linux-4.1.  Could you recommend me a version of
fsck.f2fs that really checks a linux-4.1 filesystem or find out
why version 1.14 breaks a linux-4.1 filesystem and fix the problem ?

Best regards

Philippe

--CE+1k2dSO48ffgeK
Content-Type: text/x-log; charset=us-ascii
Content-Disposition: attachment; filename="fsck-f2fs-after-beyond.log"

Info: Force to fix corruption
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 7372800 (3600 MB)
Info: MKFS version
  ""
Info: FSCK version
  from ""
    to "Linux version 4.1.15-02187-g7bc7275 (phdm@perdita) (gcc version 4.6.2 20110630 (prerelease) (Freescale MAD -- Linaro 2011.07 -- Built at 2011/08/10 09:20) ) #173 SMP PREEMPT Thu Sep 15 18:15:41 CEST 2022"
Info: superblock features = 0 :
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 7372800 (3600 MB)
Info: CKPT version = 31bf31
        Error: f2fs_init_nid_bitmap: addr(1006662402) is invalid!!!
Info: Corrupted valid nat_bits in checkpoint
Info: Write valid nat_bits in checkpoint
Info: checkpoint state = 294 :  allow_nocrc nat_bits fsck compacted_summary sudden-power-off
[FSCK] Check node 1 / 76000 (0.00%)
[ASSERT] (sanity_check_nid: 430)  --> nid[0xc132] nat_entry->ino[0x13410000] footer.ino[0x0]
[FIX] (__chk_dentries:1736)  --> Unlink [0xc132] - user len[0x4], type[0x1]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x278]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x279]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x27a]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x27b]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x27c]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x27d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x27e]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x27f]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x280]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x281]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x282]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x283]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x284]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x285]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x286]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2e7] [0x1] [0x287]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2df] [0x1] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2df] [0x1] [0x1]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2df] [0x1] [0x2]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2df] [0x1] [0x3]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2df] [0x1] [0x4]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2df] [0x1] [0x5]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2df] [0x1] [0x6]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2df] [0x1] [0x7]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b2df] [0x1] [0x8]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e5c9] [0x2] [0x2]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e5c9] [0x2] [0x3]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1e464] [0xd7647]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1e465] [0xd7648]
[ASSERT] (sanity_check_nid: 493)  --> SIT bitmap is 0x0. blk_addr[0xdf1aa]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x224e8] [0xd76fa]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x224e9] [0xd76fb]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x65188] nat_entry->ino[0x65188] footer.ino[0x1de4b]
[FIX] (__chk_dentries:1736)  --> Unlink [0x65188] - 4.1.15-legacy.g3-g512f1f5066f1 len[0x1e], type[0x2]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x735b7] nat_entry->ino[0x735b7] footer.ino[0x8afb]
[FIX] (__chk_dentries:1736)  --> Unlink [0x735b7] - 4.1.15-4.1.15.apply.an038-gb801608e5899 len[0x27], type[0x2]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x1a4 i_links: 29, real links: 27
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x1a4 i_links= 0x1d -> 0x1b
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0xd79] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0xd80] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1311b] [0xd763b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1311f] [0xd763f]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x196] [0x0] [0x1]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa278] [0xd7635]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa27a] [0xd7637]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa26d] [0xd762a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa271] [0xd762e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa26b] [0xd7628]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa27b] [0xd7638]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa268] [0xd7625]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa269] [0xd7626]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa274] [0xd7631]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa26e] [0xd762b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa2b1] [0xd763a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa273] [0xd7630]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa266] [0xd7623]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa267] [0xd7624]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa272] [0xd762f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa279] [0xd7636]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa27c] [0xd7639]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa265] [0xd7622]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa26a] [0xd7627]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa26f] [0xd762c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa270] [0xd762d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa26c] [0xd7629]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa264] [0xd7621]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa275] [0xd7632]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa277] [0xd7634]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa276] [0xd7633]
[ASSERT] (sanity_check_nid: 414)  --> blkaddress is not valid. [0xbb000000]
[FIX] (fsck_chk_inode_blk:1017)  --> [0x1184] i_nid[0] = 0
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x83]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x84]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x85]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x86]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x87]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x88]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x89]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x8a]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x8b]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x8c]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x8d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x8e]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x8f]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x90]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x91]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x92]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x93]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x94]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x95]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x96]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x97]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x98]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x99]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x9a]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x9b]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x9c]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x1186] [0x0] [0x9e]
[ASSERT] (fsck_chk_inode_blk:1046)  --> ino: 0x1184 has i_blocks: 000008cd, but has 1234 blocks
[FIX] (fsck_chk_inode_blk:1051)  --> [0x1184] i_blocks=0x000008cd -> 0x4d2
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x118a] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x11c0] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2b93] [0x1] [0x0]
[FIX] (fsck_chk_inode_blk:1141)  --> Regular: 0xc147 reset i_gc_failures from 0x1 to 0x00
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x12a1] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x234a0] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x1349] [0x0] [0x0]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x688b6] nat_entry->ino[0x688b6] footer.ino[0x675cd]
[FIX] (__chk_dentries:1736)  --> Unlink [0x688b6] - roi_coords.challenge len[0x14], type[0x1]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x68a06] [0xd77ab]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x694ca] nat_entry->ino[0x694ca] footer.ino[0x6b22e]
[FIX] (__chk_dentries:1736)  --> Unlink [0x694ca] - out len[0x3], type[0x1]
[FIX] (fsck_chk_inode_blk:1141)  --> Regular: 0xc149 reset i_gc_failures from 0x1 to 0x00
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26c9] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26ca] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26cb] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26ce] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26cf] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26d0] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26d3] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26d4] [0x0] [0x0]
[FSCK] Check node 7601 / 76000 (10.00%)
[ASSERT] (sanity_check_nid: 430)  --> nid[0x61684] nat_entry->ino[0x61684] footer.ino[0x54736]
[FIX] (__chk_dentries:1736)  --> Unlink [0x61684] - memleax-src len[0xb], type[0x2]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x64edb] nat_entry->ino[0x64edb] footer.ino[0x66e1d]
[FIX] (__chk_dentries:1736)  --> Unlink [0x64edb] - camera.pyc len[0xa], type[0x1]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x75d54] nat_entry->ino[0x75d54] footer.ino[0x6eb9a]
[FIX] (__chk_dentries:1736)  --> Unlink [0x75d54] - digital-locking.spec len[0x14], type[0x1]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x6afe8] nat_entry->ino[0x6afe8] footer.ino[0xa945]
[FIX] (__chk_dentries:1736)  --> Unlink [0x6afe8] - macq-metaicar-g3-3.20.0-0.dev.20220523.12.45.48.3.20.cleanup.afb6831.noarch.rpm len[0x4f], type[0x1]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x1340 i_links: 18, real links: 17
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x1340 i_links= 0x12 -> 0x11
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2a11] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21357] [0xd76bc]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21358] [0xd76bd]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21387] [0xd76be]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21388] [0xd76bf]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21389] [0xd76c0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2138a] [0xd76c1]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x213a2] [0xd76c2]
random: nonblocking pool is initialized
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6ce8f] [0xd77b1]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61cc3] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2a61] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2a84] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2a97] [0x0] [0x0]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x61d38] nat_entry->ino[0x61d38] footer.ino[0x5e93a]
[FIX] (__chk_dentries:1736)  --> Unlink [0x61d38] - net-snmp len[0x8], type[0x1]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2b5c] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2bb9] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9c5a] [0xd7619]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9d3a] [0xd761a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa135] [0xd7620]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2c10] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21ceb] [0xd76f2]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2c61] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21b4b] [0xd76eb]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2ca6] [0x0] [0x0]
[FIX] (fsck_chk_inode_blk:1141)  --> Regular: 0xc140 reset i_gc_failures from 0x1 to 0x00
[FIX] (fsck_chk_inode_blk:1141)  --> Regular: 0xc14a reset i_gc_failures from 0x1 to 0x00
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2cd7] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x51329] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26c9b] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6b378] [0x0] [0x0]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x6918a] nat_entry->ino[0x6918a] footer.ino[0x1dec7]
[FIX] (__chk_dentries:1736)  --> Unlink [0x6918a] - motion-jpeg len[0xb], type[0x2]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x703b4] [0x0] [0x0]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x2ca6 i_links: 27, real links: 26
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x2ca6 i_links= 0x1b -> 0x1a
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2d43] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26cb4] [0x0] [0x0]
[FIX] (fsck_chk_inode_blk:1141)  --> Regular: 0xc13f reset i_gc_failures from 0x1 to 0x00
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x271f7] [0xd773f]
[ASSERT] (sanity_check_nid: 493)  --> SIT bitmap is 0x0. blk_addr[0xdf499]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x29f5] [0x0] [0x2]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21ced] [0xd76f3]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x29f5] [0x0] [0x4]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21cde] [0xd76f1]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2f80] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2f81] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2f82] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cf9d] [0xd7783]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b65] [0xd7725]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cfad] [0xd778f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20a53] [0xd7685]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cf9f] [0xd7785]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b6c] [0xd772c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21779] [0xd76dd]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cfa9] [0xd778b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20cc4] [0xd76b7]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2177c] [0xd76e0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22bf6] [0xd7733]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22bf9] [0xd7734]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2270b] [0xd7709]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21770] [0xd76d4]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b6a] [0xd772a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20dc5] [0xd76b9]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b4f] [0xd7716]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2176f] [0xd76d3]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2177a] [0xd76de]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21775] [0xd76d9]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20a50] [0xd7682]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21766] [0xd76d1]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b69] [0xd7729]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b54] [0xd771a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21773] [0xd76d7]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b59] [0xd771f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cf9b] [0xd7781]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b67] [0xd7727]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b68] [0xd7728]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21776] [0xd76da]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b5a] [0xd7720]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21777] [0xd76db]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20a52] [0xd7684]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21772] [0xd76d6]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b56] [0xd771c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b5d] [0xd7722]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b6b] [0xd772b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b52] [0xd7718]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21771] [0xd76d5]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b55] [0xd771b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b60] [0xd7723]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cfa6] [0xd7788]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cfa8] [0xd778a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2176e] [0xd76d2]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21774] [0xd76d8]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cf9a] [0xd7780]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2177b] [0xd76df]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22bfa] [0xd7735]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b53] [0xd7719]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b61] [0xd7724]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cfae] [0xd7790]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cf9c] [0xd7782]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cfa0] [0xd7786]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b51] [0xd7717]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20cc2] [0xd76b5]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cfa7] [0xd7789]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21778] [0xd76dc]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b5b] [0xd7721]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cfac] [0xd778e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20dc3] [0xd76b8]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20a51] [0xd7683]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20cc3] [0xd76b6]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cfaa] [0xd778c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cfab] [0xd778d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cf9e] [0xd7784]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cfa1] [0xd7787]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b57] [0xd771d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b58] [0xd771e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22b66] [0xd7726]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x3266] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x3267] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cf54] [0xd777f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3db] [0xd77b3]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3da] [0xd77b2]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3e4] [0xd77bc]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3dc] [0xd77b4]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3dd] [0xd77b5]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3de] [0xd77b6]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3df] [0xd77b7]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3e0] [0xd77b8]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3e1] [0xd77b9]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3e2] [0xd77ba]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3e3] [0xd77bb]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3e5] [0xd77bd]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6d3e6] [0xd77be]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9b0b] [0xd7618]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb56] [0xd775f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb55] [0xd775e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb5a] [0xd7760]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb5c] [0xd7761]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb5d] [0xd7762]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9b09] [0xd7617]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb4c] [0xd7757]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb4e] [0xd7758]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb4f] [0xd7759]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb50] [0xd775a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb52] [0xd775b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb53] [0xd775c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb54] [0xd775d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22258] [0xd76f7]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb49] [0xd7754]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb48] [0xd7753]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb4a] [0xd7755]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb4b] [0xd7756]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb3e] [0xd774e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb40] [0xd774f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb42] [0xd7750]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb44] [0xd7751]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb46] [0xd7752]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20a39] [0xd767b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20a3a] [0xd767c]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x37ec] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1311e] [0xd763e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21a61] [0xd76e3]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21a5f] [0xd76e1]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21a60] [0xd76e2]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2e3] [0xd7670]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2e4] [0xd7671]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2e094] [0xd77a1]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2e093] [0xd77a0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2e095] [0xd77a2]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20a3f] [0xd767d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x37ec] [0x0] [0x3]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2225a] [0xd76f9]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20a40] [0xd767e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20a46] [0xd767f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20a48] [0xd7680]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20a4b] [0xd7681]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x37ec] [0x0] [0x5]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22259] [0xd76f8]
[FSCK] Check node 15201 / 76000 (20.00%)
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2153a] [0xd76c9]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2153b] [0xd76ca]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21539] [0xd76c8]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1facc] [0xd767a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1fac8] [0xd7676]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1fac9] [0xd7677]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21536] [0xd76c5]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2153c] [0xd76cb]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21538] [0xd76c7]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1faca] [0xd7678]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1facb] [0xd7679]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2153f] [0xd76ce]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21537] [0xd76c6]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22617] [0xd7702]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22618] [0xd7703]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2261a] [0xd7705]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2261b] [0xd7706]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22bca] [0xd772d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22bcb] [0xd772e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21542] [0xd76d0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2153e] [0xd76cd]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2153d] [0xd76cc]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21535] [0xd76c4]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21541] [0xd76cf]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21534] [0xd76c3]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22619] [0xd7704]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2261c] [0xd7707]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22257] [0xd76f6]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x3aee] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb39] [0xd774a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb38] [0xd7749]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb3a] [0xd774b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb3c] [0xd774c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb3d] [0xd774d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb30] [0xd7742]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb31] [0xd7743]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb32] [0xd7744]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb34] [0xd7745]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb35] [0xd7746]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb36] [0xd7747]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb37] [0xd7748]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb5e] [0xd7763]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb60] [0xd7764]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb61] [0xd7765]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb62] [0xd7766]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb63] [0xd7767]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb64] [0xd7768]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb65] [0xd7769]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb67] [0xd776b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb66] [0xd776a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22872] [0xd770b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22873] [0xd770c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2287c] [0xd7714]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22876] [0xd770e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22877] [0xd770f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2287d] [0xd7715]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2287a] [0xd7712]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22871] [0xd770a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22878] [0xd7710]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22879] [0xd7711]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22874] [0xd770d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2287b] [0xd7713]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc50] [0xd776f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc56] [0xd7775]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc58] [0xd7777]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc52] [0xd7771]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc59] [0xd7778]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc55] [0xd7774]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc53] [0xd7772]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc57] [0xd7776]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc5b] [0xd777a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc5d] [0xd777c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc54] [0xd7773]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc5c] [0xd777b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc51] [0xd7770]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc5a] [0xd7779]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc5f] [0xd777e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc5e] [0xd777d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x49fa] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21b23] [0xd76e6]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ec31] [0xd765e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ec2c] [0xd765c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ec25] [0xd765b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ec2f] [0xd765d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4b40] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4b91] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4ba3] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4bba] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4bc3] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4bc9] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4c10] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4c24] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4c77] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4e4c] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4f40] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4f4d] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4f53] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4f58] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4f59] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4f5d] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4f60] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4f63] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4f66] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4f6b] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4f71] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1fac4] [0xd7672]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1fac7] [0xd7675]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1fac6] [0xd7674]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1fac5] [0xd7673]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20ca0] [0xd76b0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20c9f] [0xd76af]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20ca2] [0xd76b2]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20ca1] [0xd76b1]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20ca4] [0xd76b4]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20ca3] [0xd76b3]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20c9c] [0xd76ad]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20c9d] [0xd76ae]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2588e] [0xd773b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2587f] [0xd7739]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2587d] [0xd7737]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x25886] [0xd773a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2587e] [0xd7738]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2587a] [0xd7736]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2222a] [0xd76f5]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2253c] [0xd76fd]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2253e] [0xd76fe]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2253f] [0xd76ff]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22540] [0xd7700]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2253b] [0xd76fc]
[FSCK] Check node 22801 / 76000 (30.00%)
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x25517] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26cba] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26cc6] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26cc7] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26ccf] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26ccb] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26cd3] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26ce4] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x26cf0] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x488c1] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61ce7] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x5421d] [0xd2800]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54225] [0xd2801]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54228] [0xd2802]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54253] [0xd2803]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x5425a] [0xd2804]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x5425d] [0xd2805]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x542d3] [0xd2809]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x542d4] [0xd280a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x542b7] [0xd2806]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x542bb] [0xd2807]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x542bc] [0xd2808]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x5438e] [0xd280c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54392] [0xd280d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54371] [0xd280b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x543bc] [0xd280f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x543c1] [0xd2810]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54397] [0xd280e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x543cf] [0xd2811]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54452] [0xd2817]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54453] [0xd2818]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x543d0] [0xd2812]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x543d5] [0xd2813]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x543d6] [0xd2814]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x5441a] [0xd2815]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54423] [0xd2816]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54497] [0xd281a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54489] [0xd2819]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54556] [0xd281e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x5455a] [0xd281f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x5455b] [0xd2820]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x54536] [0xd281b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x5453b] [0xd281c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x5453c] [0xd281d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x545ac] [0xd2821]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4faa] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x25890] [0xd773c]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4ff5] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4ffb] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x500a] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x5053] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x5059] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x506f] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x50b2] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x50b8] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x50bd] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9b08] [0xd7616]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x50ed] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x5101] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x5123] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb2e] [0xd7740]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cb2f] [0xd7741]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x515d] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x51aa] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x51f2] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x520a] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x5223] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x5249] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x525f] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x5265] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x526f] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x528a] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x528e] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x52c7] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x52dc] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x52dd] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x52de] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x52e1] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x52e2] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x52e4] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x52e8] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x25892] [0xd773e]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x5365] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x536d] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x53a3] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x53af] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9b07] [0xd7615]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x53f0] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x5414] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x5433] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x25891] [0xd773d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x5479] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x59af] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x59f5] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x59f6] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61d20] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61d26] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61d2f] [0x0] [0x0]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x71104] nat_entry->ino[0x71104] footer.ino[0x1f968]
[FIX] (__chk_dentries:1736)  --> Unlink [0x71104] - morpheus len[0x8], type[0x2]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x5b19 i_links: 6, real links: 5
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x5b19 i_links= 0x6 -> 0x5
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x5b22] [0x0] [0x0]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x61ac1] nat_entry->ino[0x61ac1] footer.ino[0x1dc73]
[FIX] (__chk_dentries:1736)  --> Unlink [0x61ac1] - meci len[0x4], type[0x2]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x622c] [0x0] [0x0]
[ASSERT] (sanity_check_nid: 493)  --> SIT bitmap is 0x0. blk_addr[0xdf59f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21218] [0xd76ba]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21219] [0xd76bb]
[FSCK] Check node 30401 / 76000 (40.00%)
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6fb6c] [0x0] [0x0]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x2f28 i_links: 105, real links: 104
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x2f28 i_links= 0x69 -> 0x68
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x62bf] [0xd7600]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6baf7] [0xd77ae]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6bafd] [0xd77af]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6baee] [0xd77ad]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6baed] [0xd77ac]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6a0a] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6a10] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22bd2] [0xd7732]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61c75] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61c79] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61c7d] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61c81] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61c85] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61c89] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61c8d] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22bcf] [0xd7731]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22bce] [0xd7730]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61c67] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x61c6b] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa05f] [0xd761f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa05c] [0xd761c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa05d] [0xd761d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa05e] [0xd761e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0xa05b] [0xd761b]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x70d4] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cc4f] [0xd776e]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x7206] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x720f] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x7210] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x7211] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x7212] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x6ce77] [0xd77b0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21bff] [0xd76ec]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21c01] [0xd76ee]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21c02] [0xd76ef]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21c03] [0xd76f0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21c00] [0xd76ed]
[FSCK] Check node 38001 / 76000 (50.00%)
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x1]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x2]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x3]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x4]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x5]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x6]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x7]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x8]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x9]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0xa]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0xb]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0xc]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0xd]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0xe]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0xf]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x10]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x11]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x12]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x13]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x14]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x15]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x16]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x17]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x18]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x19]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x1a]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x1b]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x1c]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x1d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x1e]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x1f]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x20]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x21]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x22]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x23]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x24]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x25]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x26]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x27]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x28]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x29]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x2a]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x2b]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x2c]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x2d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x2e]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x2f]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x30]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x31]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e704] [0x2] [0x32]
[ASSERT] (sanity_check_nid: 493)  --> SIT bitmap is 0x0. blk_addr[0xdf1e3]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e92a] [0x2] [0x6]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e92a] [0x2] [0x7]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e92a] [0x2] [0x8]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e92a] [0x2] [0x9]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e92a] [0x2] [0xa]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e92a] [0x2] [0xb]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e92a] [0x2] [0xc]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5e92a] [0x2] [0xd]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b7a] [0xd768e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b7b] [0xd768f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b8e] [0xd76a1]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b8f] [0xd76a2]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b8d] [0xd76a0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b7e] [0xd7692]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2c1] [0xd7666]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2aa] [0xd7661]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2ab] [0xd7662]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2a9] [0xd7660]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2c7] [0xd7668]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20c4a] [0xd76a7]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20c4b] [0xd76a8]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20c49] [0xd76a6]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2ad] [0xd7664]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20c48] [0xd76a5]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2ac] [0xd7663]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2d1] [0xd766e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2d0] [0xd766d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b87] [0xd769b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2c0] [0xd7665]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2d2] [0xd766f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b7c] [0xd7690]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b7d] [0xd7691]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2cd] [0xd766a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2ce] [0xd766b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b7f] [0xd7693]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2cc] [0xd7669]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cbf8] [0xd776c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b81] [0xd7695]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b8c] [0xd769f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b6e] [0xd7689]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b6f] [0xd768a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b6d] [0xd7688]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2cf] [0xd766c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b6b] [0xd7686]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b6c] [0xd7687]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b8a] [0xd769d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b91] [0xd76a4]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b90] [0xd76a3]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b8b] [0xd769e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b84] [0xd7698]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b86] [0xd769a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b85] [0xd7699]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b83] [0xd7697]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2c6] [0xd7667]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b80] [0xd7694]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b70] [0xd768b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1f2a7] [0xd765f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b88] [0xd769c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b73] [0xd768d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b71] [0xd768c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20b82] [0xd7696]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2cbfd] [0xd776d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1311d] [0xd763d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22640] [0xd7708]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a2a] [0xd7612]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a27] [0xd760f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a19] [0xd7601]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a1a] [0xd7602]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a1b] [0xd7603]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a1c] [0xd7604]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a1d] [0xd7605]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a1e] [0xd7606]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a1f] [0xd7607]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a20] [0xd7608]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a21] [0xd7609]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a22] [0xd760a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a23] [0xd760b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a24] [0xd760c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a25] [0xd760d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a26] [0xd760e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a28] [0xd7610]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a29] [0xd7611]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a2b] [0xd7613]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x9a2c] [0xd7614]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x8dff] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x8e03] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x8e0b] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x8e27] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x8e32] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x8e9b] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x8ea8] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x8f1d] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x8f60] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x8f61] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x910d] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x910e] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6965f] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x92e6] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x92e7] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9310] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9342] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9349] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x93d4] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x93d8] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x93e8] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x941d] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x941e] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x2363d] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x23640] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69705] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6974a] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x697d2] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x943a] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x943a] [0x0] [0x1]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9495] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x949b] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x94a9] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x95eb] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x698bc] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x698c0] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x698c6] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x698cb] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x698d7] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x698f4] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69912] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69919] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9603] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9608] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x960b] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x960f] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9612] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9616] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9619] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x961c] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6987c] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69881] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69886] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6988e] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x698a7] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x698ae] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6996a] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9654] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9659] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x965f] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9685] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9689] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x969d] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x96a5] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9708] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x698b2] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x698b7] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69923] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69936] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6995d] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69976] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6997b] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6997c] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6998f] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69998] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x699a2] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x699cd] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69a06] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69a10] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69a1a] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x9e5a] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x23709] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x23771] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x23e30] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x23e31] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x23e36] [0x0] [0x0]
[FSCK] Check node 45601 / 76000 (60.00%)
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x699c2] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x699da] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x699e6] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x699f2] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x699fd] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69a78] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69a84] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69a8f] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69a98] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69aa5] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69aaf] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ab3] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ab7] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69abf] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ac8] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ac9] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ad1] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ad8] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ae2] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ae6] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69aec] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69af1] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69af7] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b02] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b09] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b0e] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b30] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b36] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b3c] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b13] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b1a] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b22] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b2a] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b43] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b5b] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b65] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b6a] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b75] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b89] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b8d] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b90] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b94] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69b9b] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ba2] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ba6] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69bb5] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69bba] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69bc0] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69bc7] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69bce] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69bd1] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69bf8] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c04] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c0d] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c19] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c25] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c2e] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c32] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c3b] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c45] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c4d] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c54] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c62] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c70] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c7e] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c86] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69c8a] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ca6] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69cba] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69cc3] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69cd0] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69cd7] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69cdc] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ce1] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ce4] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69ceb] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69cf0] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69cf3] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69cfc] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69cfe] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69d03] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69d0f] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69d15] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69d1f] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69d22] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69d28] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x69d37] [0x2] [0x0]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x616ef] nat_entry->ino[0x616ef] footer.ino[0x6a713]
[FIX] (__chk_dentries:1736)  --> Unlink [0x616ef] - lib len[0x3], type[0x2]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x69dce i_links: 3, real links: 2
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x69dce i_links= 0x3 -> 0x2
[ASSERT] (sanity_check_nid: 430)  --> nid[0x66aac] nat_entry->ino[0x66aac] footer.ino[0x541b0]
[FIX] (__chk_dentries:1736)  --> Unlink [0x66aac] - extsprintf len[0xa], type[0x2]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x68b58] nat_entry->ino[0x68b58] footer.ino[0x6a717]
[FIX] (__chk_dentries:1736)  --> Unlink [0x68b58] - benchmark len[0x9], type[0x2]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x69456 i_links: 5, real links: 4
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x69456 i_links= 0x5 -> 0x4
[ASSERT] (sanity_check_nid: 430)  --> nid[0x6a0d7] nat_entry->ino[0x6a0d7] footer.ino[0x5e8d2]
[FIX] (__chk_dentries:1736)  --> Unlink [0x6a0d7] - node_modules len[0xc], type[0x2]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x6a0d4 i_links: 3, real links: 2
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x6a0d4 i_links= 0x3 -> 0x2
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6a6da] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6a6ec] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6a727] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6a6c3] [0x2] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x6a6cc] [0x2] [0x0]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x95dd i_links: 352, real links: 351
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x95dd i_links= 0x160 -> 0x15f
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x13445] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x13446] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x27]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x28]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x29]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x2a]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x2b]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x2c]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x2d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x2e]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x2f]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x30]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x31]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x32]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x33]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x34]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x35]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x36]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x37]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x38]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x39]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x3a]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x3b]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x3c]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x3d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x3e]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x3f]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x40]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x41]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x42]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x43]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x44]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x45]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x46]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x47]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x48]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x49]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x4a]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x4b]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x4c]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x4d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x4e]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x4f]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x81 -> [0x5b384] [0x1] [0x63]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x134f2] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x134f2] [0x0] [0x1]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x13579] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x13596] [0xd7640]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea2f] [0xd764a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea30] [0xd764b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea31] [0xd764c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea32] [0xd764d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea33] [0xd764e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea34] [0xd764f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea35] [0xd7650]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea36] [0xd7651]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea37] [0xd7652]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea38] [0xd7653]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea39] [0xd7654]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea3a] [0xd7655]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea3b] [0xd7656]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea3c] [0xd7657]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea3d] [0xd7658]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea3e] [0xd7659]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1ea3f] [0xd765a]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x135f9] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21b48] [0xd76ea]
[FSCK] Check node 53201 / 76000 (70.00%)
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x13ffd] [0x0] [0x0]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20c9a] [0xd76ac]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x14004] [0xd7641]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20c98] [0xd76aa]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20c97] [0xd76a9]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x20c99] [0xd76ab]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22223] [0xd76f4]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1421b] [0xd7642]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1421c] [0xd7643]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1421d] [0xd7644]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1421e] [0xd7645]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dab2] [0xd7794]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dab1] [0xd7793]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2daaf] [0xd7791]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dab0] [0xd7792]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dab8] [0xd779a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dab5] [0xd7797]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dab3] [0xd7795]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dab4] [0xd7796]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dab6] [0xd7798]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dab7] [0xd7799]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dabb] [0xd779d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dabc] [0xd779e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2daba] [0xd779c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dab9] [0xd779b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x2dabd] [0xd779f]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4e4c8] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4e4d1] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4e4d1] [0x0] [0x1]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x4e4b8] [0xd77a3]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x4e4ba] [0xd77a4]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x4e4bb] [0xd77a5]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4e4c4] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4e557] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4e575] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4e57a] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4e591] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4e593] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4e594] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x4e5a4] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x140f7] [0x0] [0x1]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x4e857] [0xd77a6]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x4e858] [0xd77a7]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x4e85e] [0xd77a8]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x4e862] [0xd77a9]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x4e864] [0xd77aa]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x6c986] nat_entry->ino[0x6c986] footer.ino[0x6eb93]
[FIX] (__chk_dentries:1736)  --> Unlink [0x6c986] - lzma len[0x4], type[0x7]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x225f0] [0xd7701]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21b41] [0xd76e8]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21b44] [0xd76e9]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x1473d] [0x0] [0x4]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x149de] [0xd7646]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21ae9] [0xd76e5]
[ASSERT] (sanity_check_nid: 493)  --> SIT bitmap is 0x0. blk_addr[0xdf5dd]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x22bcc] [0xd772f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1e9e4] [0xd7649]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x1311c] [0xd763c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21b3e] [0xd76e7]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x1acfc] [0x0] [0x0]
[ASSERT] (sanity_check_nid: 493)  --> SIT bitmap is 0x0. blk_addr[0xded6d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x5f]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x60]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x61]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x62]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x63]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x64]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x65]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x66]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x67]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x68]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x69]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x6a]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x6b]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x6c]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x6d]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x6e]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x6f]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x70]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x71]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x72]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x73]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x74]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x75 -> [0xc13c] [0x2] [0x75]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x6aa -> [0x21ae4] [0xd76e4]
[FSCK] Check node 60801 / 76000 (80.00%)
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x1df60] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x1df63] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x1df68] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x1df6a] [0x0] [0x0]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x6280e] nat_entry->ino[0x6280e] footer.ino[0x1de2e]
[FIX] (__chk_dentries:1736)  --> Unlink [0x6280e] - node_modules len[0xc], type[0x2]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x4c49b i_links: 3, real links: 2
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x4c49b i_links= 0x3 -> 0x2
[ASSERT] (sanity_check_nid: 430)  --> nid[0x67d15] nat_entry->ino[0x67d15] footer.ino[0x5e563]
[FIX] (__chk_dentries:1736)  --> Unlink [0x67d15] - out len[0x3], type[0x2]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x67d05 i_links: 4, real links: 3
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x67d05 i_links= 0x4 -> 0x3
[ASSERT] (sanity_check_nid: 430)  --> nid[0x68f84] nat_entry->ino[0x68f84] footer.ino[0x5ed3e]
[FIX] (__chk_dentries:1736)  --> Unlink [0x68f84] - node_modules len[0xc], type[0x2]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x68f7a i_links: 5, real links: 4
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x68f7a i_links= 0x5 -> 0x4
[ASSERT] (sanity_check_nid: 430)  --> nid[0x67f3e] nat_entry->ino[0x67f3e] footer.ino[0x5e5b3]
[FIX] (__chk_dentries:1736)  --> Unlink [0x67f3e] - node_modules len[0xc], type[0x2]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x3a07e i_links: 3, real links: 2
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x3a07e i_links= 0x3 -> 0x2
[ASSERT] (sanity_check_nid: 430)  --> nid[0x3a6f5] nat_entry->ino[0x3a6f5] footer.ino[0x1eed5]
[FIX] (__chk_dentries:1736)  --> Unlink [0x3a6f5] - import len[0x6], type[0x2]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x3a69a i_links: 8, real links: 7
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x3a69a i_links= 0x8 -> 0x7
[FSCK] Check node 68401 / 76000 (90.00%)
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69b28] [0xd282d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69b51] [0xd282e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69b73] [0xd282f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69b76] [0xd2830]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69b7f] [0xd2831]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69b91] [0xd2832]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69baf] [0xd2833]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69bb0] [0xd2834]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69bb6] [0xd2835]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69bbc] [0xd2836]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69bc5] [0xd2837]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69bcb] [0xd2838]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69bd2] [0xd2839]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69bd8] [0xd283a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69c72] [0xd283b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69c75] [0xd283c]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69c76] [0xd283d]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69c8b] [0xd283e]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69c8c] [0xd283f]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69c8f] [0xd2840]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69c90] [0xd2841]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69c94] [0xd2842]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69c95] [0xd2843]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69c98] [0xd2844]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69c99] [0xd2845]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69ca4] [0xd2846]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x699b3] [0xd2822]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x699b9] [0xd2823]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x699bf] [0xd2824]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x699c7] [0xd2825]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x699cf] [0xd2826]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x699d7] [0xd2827]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x699df] [0xd2828]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x699e7] [0xd2829]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x699ef] [0xd282a]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x699fb] [0xd282b]
[FIX] (is_valid_ssa_node_blk: 201)  --> Set node summary 0x683 -> [0x69a01] [0xd282c]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x3aff9] [0x0] [0x0]
[FIX] (is_valid_ssa_data_blk: 333)  --> Set data summary 0x5da -> [0x3b02e] [0x0] [0x0]
[ASSERT] (sanity_check_nid: 430)  --> nid[0x6a896] nat_entry->ino[0x6a896] footer.ino[0x3dbf]
[FIX] (__chk_dentries:1736)  --> Unlink [0x6a896] - node_modules len[0xc], type[0x2]
[ASSERT] (fsck_chk_inode_blk:1104)  --> ino: 0x3b75d i_links: 4, real links: 3
[FIX] (fsck_chk_inode_blk:1109)  --> Dir: 0x3b75d i_links= 0x4 -> 0x3

NID[0x11] is unreachable, blkaddr:0x3b90000
NID[0x1185] is unreachable, blkaddr:0xbb000000
NID[0x7acf] is unreachable, blkaddr:0xd1601
NID[0x7ad0] is unreachable, blkaddr:0xd1602
NID[0x7ad1] is unreachable, blkaddr:0xd98a2
NID[0x7ad2] is unreachable, blkaddr:0xd1603
NID[0x80fa] is unreachable, blkaddr:0xd8469
NID[0x94b5] is unreachable, blkaddr:0xcf16d
NID[0x94b6] is unreachable, blkaddr:0xcf16e
NID[0x94b7] is unreachable, blkaddr:0xcf16f
NID[0x94b8] is unreachable, blkaddr:0xcf170
NID[0xa781] is unreachable, blkaddr:0xce43e
NID[0xa7b8] is unreachable, blkaddr:0xce475
NID[0xa7b9] is unreachable, blkaddr:0xce476
NID[0xa7ba] is unreachable, blkaddr:0xce477
NID[0xa7bb] is unreachable, blkaddr:0xce478
NID[0xa7bc] is unreachable, blkaddr:0xce479
NID[0xa7bd] is unreachable, blkaddr:0xce47a
NID[0xa7be] is unreachable, blkaddr:0xce47b
NID[0xa7bf] is unreachable, blkaddr:0xce47c
NID[0xa7c0] is unreachable, blkaddr:0xce47d
NID[0xa7c1] is unreachable, blkaddr:0xce47e
NID[0xa7c2] is unreachable, blkaddr:0xce47f
NID[0xa7c3] is unreachable, blkaddr:0xce480
NID[0xa7c4] is unreachable, blkaddr:0xce481
NID[0xa7c5] is unreachable, blkaddr:0xce482
NID[0xa7c6] is unreachable, blkaddr:0xce483
NID[0xa7c7] is unreachable, blkaddr:0xce484
NID[0xa7c8] is unreachable, blkaddr:0xce485
NID[0xa7c9] is unreachable, blkaddr:0xce486
NID[0xa7ca] is unreachable, blkaddr:0xce487
NID[0xa7cb] is unreachable, blkaddr:0xce488
NID[0xa7cc] is unreachable, blkaddr:0xce489
NID[0xa7cd] is unreachable, blkaddr:0xce48a
NID[0xa7ce] is unreachable, blkaddr:0xce48b
NID[0xb2fc] is unreachable, blkaddr:0xce076
NID[0xb2fd] is unreachable, blkaddr:0xce077
NID[0xb30a] is unreachable, blkaddr:0xce084
NID[0xb30b] is unreachable, blkaddr:0xce085
NID[0xb30c] is unreachable, blkaddr:0xce086
NID[0xb30d] is unreachable, blkaddr:0xce087
NID[0xb30e] is unreachable, blkaddr:0xce088
NID[0xb30f] is unreachable, blkaddr:0xce089
NID[0xb310] is unreachable, blkaddr:0xce08a
NID[0xb311] is unreachable, blkaddr:0xce08b
NID[0xb312] is unreachable, blkaddr:0xce08c
NID[0xb31d] is unreachable, blkaddr:0xce097
NID[0xb31e] is unreachable, blkaddr:0xce098
NID[0xb5fc] is unreachable, blkaddr:0xcc376
NID[0xb5fd] is unreachable, blkaddr:0xcc377
NID[0xb5fe] is unreachable, blkaddr:0xcc378
NID[0xb5ff] is unreachable, blkaddr:0xcc379
NID[0xb600] is unreachable, blkaddr:0xcc37a
NID[0xe082] is unreachable, blkaddr:0xc2b49
NID[0xe083] is unreachable, blkaddr:0xc2b4a
NID[0xe084] is unreachable, blkaddr:0xc2b4b
NID[0xe085] is unreachable, blkaddr:0xc2b4c
NID[0xe086] is unreachable, blkaddr:0xc2b4d
NID[0xe087] is unreachable, blkaddr:0xc2b4e
NID[0xe088] is unreachable, blkaddr:0xc2b4f
NID[0xe089] is unreachable, blkaddr:0xc2b50
NID[0xe08a] is unreachable, blkaddr:0xc2b51
NID[0xe08b] is unreachable, blkaddr:0xc2b52
NID[0xe08c] is unreachable, blkaddr:0xc2b53
NID[0xe08d] is unreachable, blkaddr:0xc2b54
NID[0xe08e] is unreachable, blkaddr:0xc2b55
NID[0xe08f] is unreachable, blkaddr:0xc2b56
NID[0xed8d] is unreachable, blkaddr:0xbbc54
NID[0xed8e] is unreachable, blkaddr:0xbbc55
NID[0xed8f] is unreachable, blkaddr:0xbbc56
NID[0xed90] is unreachable, blkaddr:0xbbc57
NID[0xed91] is unreachable, blkaddr:0xbbc58
NID[0xed92] is unreachable, blkaddr:0xbbc59
NID[0xed93] is unreachable, blkaddr:0xbbc5a
NID[0xed94] is unreachable, blkaddr:0xbbc5b
NID[0xed95] is unreachable, blkaddr:0xbbc5c
NID[0xed96] is unreachable, blkaddr:0xbbc5d
NID[0xed97] is unreachable, blkaddr:0xbbc5e
NID[0xed98] is unreachable, blkaddr:0xbbc5f
NID[0xed99] is unreachable, blkaddr:0xbbc60
NID[0xed9a] is unreachable, blkaddr:0xbbc61
NID[0xed9b] is unreachable, blkaddr:0xbbc62
NID[0xed9c] is unreachable, blkaddr:0xbbc63
NID[0xed9d] is unreachable, blkaddr:0xbbc64
NID[0xed9e] is unreachable, blkaddr:0xbbc65
NID[0xed9f] is unreachable, blkaddr:0xbbc66
NID[0xeda0] is unreachable, blkaddr:0xbbc67
NID[0xf5d9] is unreachable, blkaddr:0xb92a0
NID[0xf5da] is unreachable, blkaddr:0xb92a1
NID[0xf5db] is unreachable, blkaddr:0xb92a2
NID[0xf5dc] is unreachable, blkaddr:0xb92a3
NID[0x3a6f5] is unreachable, blkaddr:0xde64c
NID[0x3a6f9] is unreachable, blkaddr:0xd0e69
NID[0x3a705] is unreachable, blkaddr:0xd0e6a
NID[0x53c19] is unreachable, blkaddr:0xe0d0b
NID[0x53cbf] is unreachable, blkaddr:0xd3967
NID[0x53cc0] is unreachable, blkaddr:0xd3968
NID[0x53cc1] is unreachable, blkaddr:0xdcc5f
NID[0x53cc2] is unreachable, blkaddr:0xdcc60
NID[0x53cc3] is unreachable, blkaddr:0xdcc61
NID[0x53cc4] is unreachable, blkaddr:0xd3969
NID[0x53cc5] is unreachable, blkaddr:0xdcc62
NID[0x53cc6] is unreachable, blkaddr:0xd396a
NID[0x53cc7] is unreachable, blkaddr:0xda782
NID[0x53cc8] is unreachable, blkaddr:0xdcc63
NID[0x53cc9] is unreachable, blkaddr:0xdcc64
NID[0x53fb6] is unreachable, blkaddr:0xda783
NID[0x53fb7] is unreachable, blkaddr:0xda784
NID[0x53fb8] is unreachable, blkaddr:0xda785
NID[0x53fb9] is unreachable, blkaddr:0xda786
NID[0x53fba] is unreachable, blkaddr:0xda787
NID[0x53fbb] is unreachable, blkaddr:0xda788
NID[0x53fbc] is unreachable, blkaddr:0xda789
NID[0x53fbd] is unreachable, blkaddr:0xdcc65
NID[0x53fbe] is unreachable, blkaddr:0xda78a
NID[0x53fbf] is unreachable, blkaddr:0xda78b
NID[0x53fc0] is unreachable, blkaddr:0xd961d
NID[0x53fc1] is unreachable, blkaddr:0xdcc66
NID[0x53fc2] is unreachable, blkaddr:0xd961e
NID[0x53fc3] is unreachable, blkaddr:0xd961f
NID[0x60000] is unreachable, blkaddr:0x13410007
NID[0x61684] is unreachable, blkaddr:0xd22c5
NID[0x616ef] is unreachable, blkaddr:0xd1cd7
NID[0x61ac1] is unreachable, blkaddr:0xdc220
NID[0x61d38] is unreachable, blkaddr:0xdc4d8
NID[0x6280e] is unreachable, blkaddr:0xdc225
NID[0x6280f] is unreachable, blkaddr:0xda5f2
NID[0x64edb] is unreachable, blkaddr:0xdef70
NID[0x65188] is unreachable, blkaddr:0xdc22b
NID[0x65189] is unreachable, blkaddr:0xcf8d8
NID[0x66aac] is unreachable, blkaddr:0xd3984
NID[0x6735d] is unreachable, blkaddr:0xd23fa
NID[0x67361] is unreachable, blkaddr:0xd23fb
NID[0x67d15] is unreachable, blkaddr:0xd22d5
NID[0x67d16] is unreachable, blkaddr:0xb4499
NID[0x67f3e] is unreachable, blkaddr:0xd22d6
NID[0x67f3f] is unreachable, blkaddr:0xb44cb
NID[0x67f4c] is unreachable, blkaddr:0xb44cd
NID[0x67f52] is unreachable, blkaddr:0xb44ce
NID[0x688b6] is unreachable, blkaddr:0xdc4d9
NID[0x68b58] is unreachable, blkaddr:0xd1cd9
NID[0x68f84] is unreachable, blkaddr:0xd22d9
NID[0x68f85] is unreachable, blkaddr:0xb4515
NID[0x68f88] is unreachable, blkaddr:0xb4516
NID[0x68f8d] is unreachable, blkaddr:0xb4517
NID[0x6918a] is unreachable, blkaddr:0xdc23b
NID[0x694ca] is unreachable, blkaddr:0xdc4da
NID[0x6950e] is unreachable, blkaddr:0xd1f69
NID[0x6a0d7] is unreachable, blkaddr:0xdc0e7
NID[0x6a0d8] is unreachable, blkaddr:0xdd219
NID[0x6a896] is unreachable, blkaddr:0xdda5b
NID[0x6a897] is unreachable, blkaddr:0xd6463
NID[0x6afe8] is unreachable, blkaddr:0xd4d0e
NID[0x6c986] is unreachable, blkaddr:0xda97a
NID[0x71104] is unreachable, blkaddr:0xd3872
NID[0x735b7] is unreachable, blkaddr:0xd233c
NID[0x75d54] is unreachable, blkaddr:0xda97e
[FSCK] Max image size: 3600 MB, Free space: 959 MB
[FSCK] Unreachable nat entries                        [Fail] [0x9d]
[FSCK] SIT valid block bitmap checking                [Fail]
[FSCK] Hard link checking for regular file            [Ok..] [0x956]
[FSCK] valid_block_count matching with CP             [Fail] [0x91d59]
[FSCK] valid_node_count matching with CP (de lookup)  [Fail] [0x12844]
[FSCK] valid_node_count matching with CP (nat lookup) [Fail] [0x128e1]
[FSCK] valid_inode_count matched with CP              [Fail] [0x12749]
[FSCK] free segment_count matched with CP             [Ok..] [0x260]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Fail]

Do you want to restore lost files into ./lost_found/? [Y/N] Info: Duplicate valid checkpoint to mirror position 512 -> 1024
Info: Write valid nat_bits in checkpoint
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x11] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x1185] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x7acf] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x7ad0] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x7ad1] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x7ad2] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x80fa] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x94b5] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x94b6] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x94b7] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x94b8] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa781] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7b8] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7b9] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7ba] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7bb] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7bc] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7bd] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7be] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7bf] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7c0] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7c1] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7c2] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7c3] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7c4] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7c5] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7c6] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7c7] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7c8] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7c9] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7ca] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7cb] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7cc] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7cd] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xa7ce] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb2fc] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb2fd] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb30a] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb30b] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb30c] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb30d] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb30e] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb30f] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb310] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb311] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb312] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb31d] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb31e] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb5fc] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb5fd] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb5fe] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb5ff] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xb600] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe082] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe083] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe084] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe085] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe086] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe087] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe088] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe089] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe08a] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe08b] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe08c] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe08d] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe08e] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xe08f] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed8d] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed8e] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed8f] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed90] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed91] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed92] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed93] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed94] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed95] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed96] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed97] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed98] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed99] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed9a] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed9b] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed9c] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed9d] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed9e] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xed9f] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xeda0] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xf5d9] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xf5da] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xf5db] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0xf5dc] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x3a6f5] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x3a6f9] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x3a705] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53c19] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53cbf] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53cc0] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53cc1] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53cc2] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53cc3] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53cc4] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53cc5] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53cc6] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53cc7] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53cc8] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53cc9] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fb6] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fb7] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fb8] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fb9] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fba] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fbb] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fbc] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fbd] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fbe] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fbf] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fc0] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fc1] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fc2] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x53fc3] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x60000] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x61684] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x616ef] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x61ac1] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x61d38] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x6280e] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x6280f] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x64edb] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x65188] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x65189] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x66aac] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x6735d] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x67361] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x67d15] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x67d16] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x67f3e] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x67f3f] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x67f4c] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x67f52] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x688b6] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x68b58] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x68f84] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x68f85] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x68f88] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x68f8d] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x6918a] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x694ca] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x6950e] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x6a0d7] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x6a0d8] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x6a896] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x6a897] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x6afe8] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x6c986] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x71104] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x735b7] in NAT
[FIX] (nullify_nat_entry:2957)  --> Remove nid [0x75d54] in NAT
[ASSERT] (check_curseg_offset:2559)  --> For LFS curseg, space after .next_blkoff should be unused, type:4
Info: Write valid nat_bits in checkpoint

Done: 43.501954 secs

--CE+1k2dSO48ffgeK--
