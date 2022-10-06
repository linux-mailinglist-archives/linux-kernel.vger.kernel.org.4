Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217055F5F68
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJFDTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJFDSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:18:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A8A88DCB;
        Wed,  5 Oct 2022 20:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzDqlQvYN3R8PcEXuqGSE2I7ADrDFwxSdwpZHcBgXlnIUUd2+JtTdDiPKI5y8F3sVQKRzsaZswjfwqvqzwbY7bePaDPhhU5ioPXfqHUdJVj1MpLHQXOdviS5o1VdqROybbhX2nAnyqJwoiBdeI1wepZR8OT4LYtbs16ikQoB0HZqYjGk4GmLyOMt8HkX2ad655yvrcXB++sKNmZAvBtIqCeZWXKWDojhQjOjUKAxJuBSGXLtPURGMiq09mh9U+IN8w9TdZW3gU7pO55ERDQAcDjP0JyMlkkGjyeFXbsreXOQY1JKlE0Mds4Tb9ojblWzPj6A9/8wIYQKj5gAQqcMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOmvbDyfat5EPJAy2gZNJg69L+dvwip3sgQ4+JQQeGg=;
 b=LRALAptKXSbwNmw69PF7nAn2ofpX5VMnEXxumyRYnNicqMNddDEetHwrN6WGELGleFtyVZ8n+Fm7H0I5wYBYmHuGBP1m1FL/wwL4PVaDZXFgqcSDOc+h+TUr5wuFah+waIZPGJS8VKAgTwOZZw/R3udeCLVjkZ8hi/7BmFKNuXBpFwZL2pw1QOOKmynomKPZfBWtLultMmEFk3aVQeiOn283keGqEvdn69aCiM/wp9wUveeMde1oSSjGIkeM4qtdwB5av3DM1PUJkZFRGP/dVePFKLDYsXRboBYjOZ8U7rjQyPnHpGnfUQbe69POixqs4PSrPYcs4VRGKiQ6YUxb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOmvbDyfat5EPJAy2gZNJg69L+dvwip3sgQ4+JQQeGg=;
 b=ZJLY5dALs+mzXmPwzll5Tg1oWQ+PKTL8gwBeYRvAuvfPfnkvCPMC68wnefjEZ8jvET14jo2uJK516t2c4EWnSCvjTPgzucOa2qjIz8cHXnO213T+mmGk6QvoOVx3uwuA+O5bEguPBzuAFaxzQFVEsUrsGk7aZUMnV9iry263Bwu0htn/CVuiXb4D7pnen5zlZgmqSW8dA3Crd90FRK2svizQqYRkF71RGvjKGKwzQVFNhgJeZGHVm75+MjKHhRyqfifbQESmh+9iFs9MIGZS2VBtK1vFL2kYTPfDKodmuyQ3hCLfWWAxIuMOFnyoZWfip8RcV0HfeZPxWmIy7oVMdA==
Received: from DS7PR05CA0066.namprd05.prod.outlook.com (2603:10b6:8:57::11) by
 SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.15; Thu, 6 Oct 2022 03:18:47 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::a6) by DS7PR05CA0066.outlook.office365.com
 (2603:10b6:8:57::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.10 via Frontend
 Transport; Thu, 6 Oct 2022 03:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 03:18:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 5 Oct 2022
 20:18:40 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 5 Oct 2022
 20:18:39 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V2 0/7] null_blk: allow REQ_OP_WRITE_ZEROES and cleanup
Date:   Wed, 5 Oct 2022 20:18:22 -0700
Message-ID: <20221006031829.37741-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="a"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: f5125705-6f14-41a5-0e13-08daa7497bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPptnPFkJFA+LqCPU8qkJdubqzfYzNi0Y/7rwi2SkpvHJr4TrHbNz9dLLjqQg20n247qQYPIrEQxdy5A25UoUO7B3VM/Nus7po8Ixrx34rFVaXm9JnPMAAiCW5FyduOMppnppMh99S2nDToyXXXmGAaMAa48BrRuJhSU1FrF68NzTsY2Myd7Gc2/5W88KF8z7Y9/0CQPcvE/jFg1gRvmRWS9MdKOOaWn5e90JMB9K95Djazqk5SCMltsPsvSSH3skw6N/u8FZgdZl9IuUdxgT9SMB207rUbVvB33wfUs1ox/oSzKz++QD2NYdvNXJiaqBfGTncNR+52stCnabfnNLKKoI7zErW4jj+7YzqzRpUz5aJPrBivoBqJ671N5AKQwVtBz8r7CUtIYMHnrlVZErJYrBxO29W2QojMdmdZvNtsU9iSPgADHAEgQGWKCCC9A1fMKgrjm34q2FYQQdHeuqbj2A3zjetPfSY31SNMP2lLq7HLSwQtb8ulXqvODGFk9tgB+FxRmfQ/yllzM7XiorqcbH78WCsIqWGblqLxTsX4TfMvswz39Pm/lAoQxnBL9rH7CKlAFg4kHcYsyOPwr/7laQzfQwsy8VeCSzbgFzYEm5U4BDSZoAVDOktxkcNn8qZhG4f8UEjf4o3VYzE5c8SqnphpZKemIF8wmLmVFI+cwu/YJNbdnW2xQYTaLO5ny1Vf8ACjVWZ7FjPLh0P/x+YzMLt660ySghWLnqpga0ZjMAcOA6iMSSaDA3Iujy2gtTJDBVdqPiC4Zd84OGr7lIyGHG4WRYc2hEW7MsiH1syo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(110136005)(19627235002)(54906003)(316002)(478600001)(336012)(4326008)(6666004)(70586007)(70206006)(8676002)(2616005)(36756003)(7416002)(8936002)(2906002)(26005)(30864003)(5660300002)(41300700001)(1076003)(7696005)(82310400005)(36860700001)(40460700003)(83380400001)(186003)(16526019)(47076005)(426003)(356005)(7636003)(82740400003)(40480700001)(93036002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:18:47.6599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5125705-6f14-41a5-0e13-08daa7497bd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In order to test the non-trivial I/O path in the block layer for
REQ_OP_WRITE_ZEROES allow write-zeroes on null_blk so we can write
testcases with and without non-memory backed mode followed by
few cleanup patches.

Below is the test report with ext2/ext4 mkfs and a blktest
waiting to get upstream for this patch-series.

-ck

v1->v2:-

* Merge patch 1 and 2 (Damien).
* Change SECT_INX_IN_PAGE->SECT_OFFSET_IN_PAGE. (Damien)
* Add reviewed-by tags. (Damien)
* Add discard/write-zeroes module param to set the respective
  max sector length.

Chaitanya Kulkarni (7):
  null_blk: allow REQ_OP_WRITE_ZEROES
  null_blk: code cleaup
  null_blk: initialize cmd->bio in __alloc_cmd()
  null_blk: don't use magic numbers in the code
  null_blk: remove extra space in switch condition
  null_blk: add param to set max disacrd sectors
  null_blk: add param to set max write-zeroes sects

 drivers/block/null_blk/main.c     | 149 ++++++++++++++++++++++--------
 drivers/block/null_blk/null_blk.h |   3 +
 2 files changed, 116 insertions(+), 36 deletions(-)

linux-block (for-next) # gitlog -8
ab66a9484551 (HEAD -> for-next) null_blk: add param to set max write-zeroes sects
4ad2d08f4ea4 null_blk: add param to set max disacrd sectors
008e19cd64e6 null_blk: remove extra space in switch condition
b92a9bf280bb null_blk: don't use magic numbers in the code
cc56f23fb6bc null_blk: initialize cmd->bio in __alloc_cmd()
36037b231dee null_blk: code cleaup
d23c0fdf1ee2 null_blk: allow REQ_OP_WRITE_ZEROES
86e551dc35c9 Merge branch 'for-next' of git://git.kernel.dk/linux-block into for-next
linux-block (for-next) # ./compile_nullb.sh 
+ umount /mnt/nullb0
umount: /mnt/nullb0: not mounted.
+ rmdir 'config/nullb/nullb*'
rmdir: failed to remove 'config/nullb/nullb*': No such file or directory
+ dmesg -c
+ modprobe -r null_blk
+ lsmod
+ grep null_blk
++ nproc
+ make -j 48 M=drivers/block modules
  CC [M]  drivers/block/null_blk/main.o
  CC [M]  drivers/block/null_blk/trace.o
  CC [M]  drivers/block/null_blk/zoned.o
  LD [M]  drivers/block/null_blk/null_blk.o
  MODPOST drivers/block/Module.symvers
  LD [M]  drivers/block/null_blk/null_blk.ko
+ HOST=drivers/block/null_blk/
++ uname -r
+ HOST_DEST=/lib/modules/6.0.0-rc7blk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/6.0.0-rc7blk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.0.0-rc7blk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.2M Oct  5 19:55 /lib/modules/6.0.0-rc7blk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c

blktests (master) # ./check block
block/001 (stress device hotplugging)                        [passed]
    runtime  53.159s  ...  49.759s
block/002 (remove a device while running blktrace)           [passed]
    runtime  0.798s  ...  1.267s
block/006 (run null-blk in blocking mode)                    [passed]
    read iops  8867450  ...  8810329
    runtime    9.669s   ...  9.850s
block/007 => nullb1 (test classic and hybrid IO polling)     [passed]
    auto hybrid poll read iops       619725      ...  615361
    auto hybrid poll read lat mean   1.366826    ...  1.371562
    auto hybrid poll system cpu      76.066351%  ...  74.352941%
    classic poll read iops           618264      ...  615361
    classic poll read lat mean       1.366413    ...  1.371557
    classic poll system cpu          73.995272%  ...  72.470588%
    fixed hybrid poll read iops      625642      ...  622669
    fixed hybrid poll read lat mean  1.352212    ...  1.357977
    fixed hybrid poll system cpu     75.598086%  ...  73.809524%
    no poll read iops                630153      ...  619725
    no poll read lat mean            1.345745    ...  1.362713
    no poll system cpu               73.975904%  ...  72.037915%
    runtime                          2.499s      ...  2.515s
block/009 (check page-cache coherency after BLKDISCARD)      [passed]
    runtime  0.590s  ...  0.560s
block/010 (run I/O on null_blk with shared and non-shared tags) [passed]
    Individual tags read iops  7911915  ...  7883103
    runtime                    21.139s  ...  20.894s
    Shared tags read iops      7837073  ...  7849908
block/014 (run null-blk with blk-mq and timeout injection configured) [passed]
    runtime  86.076s  ...  60.765s
block/015 (run null-blk on different schedulers with requeue injection configured) [passed]
    runtime  44.143s  ...  43.989s
block/016 (send a signal to a process waiting on a frozen queue) [passed]
    runtime  7.085s  ...  7.091s
block/017 (do I/O and check the inflight counter)            [passed]
    runtime  1.703s  ...  1.692s
block/018 (do I/O and check iostats times)                   [passed]
    runtime  5.111s  ...  5.107s
block/020 (run null-blk on different schedulers with only one hardware tag) [passed]
    runtime  41.501s  ...  41.558s
block/021 (read/write nr_requests on null-blk with different schedulers) [passed]
    runtime  5.854s  ...  5.854s
block/022 (Test hang caused by freeze/unfreeze sequence)     [passed]
    runtime  30.137s  ...  30.144s
block/023 (do I/O on all null_blk queue modes)               [passed]
    runtime  0.274s  ...  0.267s
block/024 (do I/O faster than a jiffy and check iostats times) [passed]
    runtime  2.657s  ...  2.660s
block/025 (do a huge discard with 4k sector size)            [passed]
    runtime  3.968s  ...  3.948s
block/027 (stress device hotplugging with running fio jobs and different schedulers) [passed]
    runtime  18.602s  ...  18.900s
block/028 (do I/O on scsi_debug with DIF/DIX enabled)        [passed]
    runtime  13.869s  ...  13.742s
block/029 (trigger blk_mq_update_nr_hw_queues())             [passed]
    runtime  30.283s  ...  30.297s
block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [passed]
    runtime  2.142s  ...  2.141s
block/031 (do IO on null-blk with a host tag set)            [passed]
    runtime  30.324s  ...  30.327s


linux-block (for-next) # ./zeroout.sh 1
#################### BLKISZ 512 #####################
config/nullb/nullb0
├── badblocks
├── blocking
├── blocksize
├── cache_size
├── completion_nsec
├── discard
├── home_node
├── hw_queue_depth
├── index
├── irqmode
├── max_discard_sectors
├── max_sectors
├── max_write_zeroes_sectors
├── mbps
├── memory_backed
├── no_sched
├── poll_queues
├── power
├── queue_mode
├── shared_tag_bitmap
├── size
├── submit_queues
├── use_per_node_hctx
├── virt_boundary
├── write_zeroes
├── zone_capacity
├── zoned
├── zone_max_active
├── zone_max_open
├── zone_nr_conv
└── zone_size

0 directories, 31 files
MKFS:-
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 1b2daa8b-59f3-40d7-9e06-fa9f5347d08f
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext2 (rw,relatime,seclabel)
[18136.386533] null_blk: disk nullb0 created
[18137.411780] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[18137.412380] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][75.0%][r=1091MiB/s][r=279k IOPS][eta 00m:05s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8936: Wed Oct  5 19:55:38 2022
  read: IOPS=278k, BW=1088MiB/s (1141MB/s)(2529MiB/2325msec)
    slat (nsec): min=2164, max=57528, avg=2545.52, stdev=505.53
    clat (nsec): min=1102, max=145345, avg=54147.07, stdev=2689.73
     lat (usec): min=3, max=148, avg=56.74, stdev= 2.76
    clat percentiles (usec):
     |  1.00th=[   52],  5.00th=[   52], 10.00th=[   52], 20.00th=[   53],
     | 30.00th=[   53], 40.00th=[   53], 50.00th=[   54], 60.00th=[   54],
     | 70.00th=[   55], 80.00th=[   55], 90.00th=[   59], 95.00th=[   61],
     | 99.00th=[   63], 99.50th=[   65], 99.90th=[   74], 99.95th=[   83],
     | 99.99th=[  108]
  write: IOPS=78.3k, BW=306MiB/s (321MB/s)(4000MiB/13070msec); 0 zone resets
    slat (usec): min=3, max=486, avg=12.06, stdev=10.45
    clat (nsec): min=781, max=937009, avg=191772.55, stdev=46098.76
     lat (usec): min=7, max=1274, avg=203.90, stdev=47.92
    clat percentiles (usec):
     |  1.00th=[  128],  5.00th=[  143], 10.00th=[  151], 20.00th=[  163],
     | 30.00th=[  172], 40.00th=[  180], 50.00th=[  186], 60.00th=[  194],
     | 70.00th=[  200], 80.00th=[  208], 90.00th=[  219], 95.00th=[  306],
     | 99.00th=[  363], 99.50th=[  383], 99.90th=[  537], 99.95th=[  594],
     | 99.99th=[  701]
   bw (  KiB/s): min=45520, max=368544, per=96.81%, avg=303407.41, stdev=59205.58, samples=27
   iops        : min=11380, max=92136, avg=75851.85, stdev=14801.40, samples=27
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=38.73%
  lat (usec)   : 250=57.66%, 500=3.50%, 750=0.11%, 1000=0.01%
  cpu          : usr=22.24%, sys=75.62%, ctx=3208, majf=0, minf=15193
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647410,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1088MiB/s (1141MB/s), 1088MiB/s-1088MiB/s (1141MB/s-1141MB/s), io=2529MiB (2652MB), run=2325-2325msec
  WRITE: bw=306MiB/s (321MB/s), 306MiB/s-306MiB/s (321MB/s-321MB/s), io=4000MiB (4194MB), run=13070-13070msec

Disk stats (read/write):
  nullb0: ios=645166/1024000, merge=0/0, ticks=714/1821, in_queue=2534, util=99.36%
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on /mnt/nullb0 on Wed Oct  5 19:55:22 2022
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 524cb8db-9768-493b-b6ad-abb1db199bcd
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext4 (rw,relatime,seclabel)
[18153.154196] EXT4-fs (nullb0): unmounting filesystem.
[18153.182343] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=0): [f(1)][100.0%][r=1043MiB/s][r=267k IOPS][eta 00m:00s]                 
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8951: Wed Oct  5 19:55:51 2022
  read: IOPS=273k, BW=1066MiB/s (1118MB/s)(2528MiB/2370msec)
    slat (nsec): min=2174, max=97034, avg=2606.58, stdev=551.65
    clat (nsec): min=1112, max=151898, avg=55202.08, stdev=3056.22
     lat (usec): min=3, max=155, avg=57.85, stdev= 3.15
    clat percentiles (nsec):
     |  1.00th=[52480],  5.00th=[52992], 10.00th=[52992], 20.00th=[53504],
     | 30.00th=[54016], 40.00th=[54016], 50.00th=[54528], 60.00th=[54528],
     | 70.00th=[55040], 80.00th=[55552], 90.00th=[59136], 95.00th=[61696],
     | 99.00th=[66048], 99.50th=[70144], 99.90th=[79360], 99.95th=[82432],
     | 99.99th=[93696]
  write: IOPS=97.6k, BW=381MiB/s (400MB/s)(4000MiB/10489msec); 0 zone resets
    slat (usec): min=3, max=3626, avg= 9.62, stdev= 9.41
    clat (nsec): min=982, max=3790.8k, avg=153946.33, stdev=38887.01
     lat (usec): min=8, max=3800, avg=163.62, stdev=40.33
    clat percentiles (usec):
     |  1.00th=[  119],  5.00th=[  128], 10.00th=[  133], 20.00th=[  139],
     | 30.00th=[  145], 40.00th=[  149], 50.00th=[  151], 60.00th=[  155],
     | 70.00th=[  159], 80.00th=[  165], 90.00th=[  172], 95.00th=[  180],
     | 99.00th=[  269], 99.50th=[  318], 99.90th=[  351], 99.95th=[  494],
     | 99.99th=[  947]
   bw (  KiB/s): min=357048, max=428968, per=99.90%, avg=390095.24, stdev=23668.21, samples=21
   iops        : min=89262, max=107242, avg=97523.81, stdev=5917.05, samples=21
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=38.72%
  lat (usec)   : 250=60.59%, 500=0.66%, 750=0.02%, 1000=0.01%
  lat (msec)   : 4=0.01%
  cpu          : usr=26.27%, sys=73.56%, ctx=29, majf=0, minf=15182
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647042,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1066MiB/s (1118MB/s), 1066MiB/s-1066MiB/s (1118MB/s-1118MB/s), io=2528MiB (2650MB), run=2370-2370msec
  WRITE: bw=381MiB/s (400MB/s), 381MiB/s-381MiB/s (400MB/s-400MB/s), io=4000MiB (4194MB), run=10489-10489msec

Disk stats (read/write):
  nullb0: ios=587867/1024234, merge=0/5709, ticks=651/1908, in_queue=2559, util=99.27%




#################### BLKISZ 1024 #####################
config/nullb/nullb0
├── badblocks
├── blocking
├── blocksize
├── cache_size
├── completion_nsec
├── discard
├── home_node
├── hw_queue_depth
├── index
├── irqmode
├── max_discard_sectors
├── max_sectors
├── max_write_zeroes_sectors
├── mbps
├── memory_backed
├── no_sched
├── poll_queues
├── power
├── queue_mode
├── shared_tag_bitmap
├── size
├── submit_queues
├── use_per_node_hctx
├── virt_boundary
├── write_zeroes
├── zone_capacity
├── zoned
├── zone_max_active
├── zone_max_open
├── zone_nr_conv
└── zone_size

0 directories, 31 files
MKFS:-
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 66fa20c2-4bd7-4dd5-9002-8f832b198068
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext2 (rw,relatime,seclabel)
[18166.870587] null_blk: disk nullb0 created
[18167.892430] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[18167.893033] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][71.4%][r=1127MiB/s][r=289k IOPS][eta 00m:06s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8976: Wed Oct  5 19:56:09 2022
  read: IOPS=288k, BW=1123MiB/s (1178MB/s)(2528MiB/2251msec)
    slat (nsec): min=2014, max=92396, avg=2422.41, stdev=512.19
    clat (nsec): min=1303, max=167628, avg=52433.36, stdev=2464.96
     lat (usec): min=3, max=170, avg=54.90, stdev= 2.53
    clat percentiles (usec):
     |  1.00th=[   50],  5.00th=[   51], 10.00th=[   51], 20.00th=[   51],
     | 30.00th=[   52], 40.00th=[   52], 50.00th=[   52], 60.00th=[   52],
     | 70.00th=[   53], 80.00th=[   53], 90.00th=[   57], 95.00th=[   59],
     | 99.00th=[   61], 99.50th=[   62], 99.90th=[   67], 99.95th=[   69],
     | 99.99th=[  106]
  write: IOPS=75.7k, BW=296MiB/s (310MB/s)(4000MiB/13530msec); 0 zone resets
    slat (usec): min=3, max=466, avg=12.47, stdev=10.01
    clat (nsec): min=1052, max=903526, avg=198530.45, stdev=47804.47
     lat (usec): min=27, max=1064, avg=211.08, stdev=49.81
    clat percentiles (usec):
     |  1.00th=[  133],  5.00th=[  147], 10.00th=[  157], 20.00th=[  167],
     | 30.00th=[  178], 40.00th=[  186], 50.00th=[  194], 60.00th=[  200],
     | 70.00th=[  206], 80.00th=[  215], 90.00th=[  229], 95.00th=[  314],
     | 99.00th=[  375], 99.50th=[  404], 99.90th=[  562], 99.95th=[  611],
     | 99.99th=[  701]
   bw (  KiB/s): min=16080, max=355544, per=96.64%, avg=292571.43, stdev=60750.67, samples=28
   iops        : min= 4020, max=88886, avg=73142.86, stdev=15187.66, samples=28
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=0.50%, 100=38.23%
  lat (usec)   : 250=57.21%, 500=3.95%, 750=0.11%, 1000=0.01%
  cpu          : usr=23.21%, sys=74.54%, ctx=3346, majf=0, minf=15186
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647231,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1123MiB/s (1178MB/s), 1123MiB/s-1123MiB/s (1178MB/s-1178MB/s), io=2528MiB (2651MB), run=2251-2251msec
  WRITE: bw=296MiB/s (310MB/s), 296MiB/s-296MiB/s (310MB/s-310MB/s), io=4000MiB (4194MB), run=13530-13530msec

Disk stats (read/write):
  nullb0: ios=605621/1024000, merge=0/0, ticks=602/1664, in_queue=2266, util=99.36%
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on /mnt/nullb0 on Wed Oct  5 19:55:53 2022
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: eeac79fa-2a6f-497c-a04a-e22e48867b4a
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext4 (rw,relatime,seclabel)
[18184.019532] EXT4-fs (nullb0): unmounting filesystem.
[18184.043893] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][75.0%][r=1123MiB/s][r=287k IOPS][eta 00m:04s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=8990: Wed Oct  5 19:56:22 2022
  read: IOPS=287k, BW=1119MiB/s (1174MB/s)(2530MiB/2260msec)
    slat (nsec): min=2024, max=94349, avg=2444.00, stdev=532.18
    clat (nsec): min=1383, max=148101, avg=52612.45, stdev=2521.26
     lat (usec): min=3, max=150, avg=55.10, stdev= 2.58
    clat percentiles (nsec):
     |  1.00th=[50432],  5.00th=[50432], 10.00th=[50944], 20.00th=[51456],
     | 30.00th=[51456], 40.00th=[51456], 50.00th=[51968], 60.00th=[51968],
     | 70.00th=[52480], 80.00th=[52992], 90.00th=[56064], 95.00th=[58624],
     | 99.00th=[60672], 99.50th=[61696], 99.90th=[66048], 99.95th=[76288],
     | 99.99th=[98816]
  write: IOPS=101k, BW=396MiB/s (415MB/s)(4000MiB/10107msec); 0 zone resets
    slat (usec): min=3, max=3934, avg= 9.24, stdev= 8.67
    clat (nsec): min=792, max=7280.8k, avg=148351.59, stdev=40152.32
     lat (usec): min=6, max=7292, avg=157.65, stdev=41.65
    clat percentiles (usec):
     |  1.00th=[  114],  5.00th=[  123], 10.00th=[  128], 20.00th=[  135],
     | 30.00th=[  139], 40.00th=[  143], 50.00th=[  147], 60.00th=[  151],
     | 70.00th=[  155], 80.00th=[  161], 90.00th=[  167], 95.00th=[  176],
     | 99.00th=[  202], 99.50th=[  223], 99.90th=[  277], 99.95th=[  433],
     | 99.99th=[  486]
   bw (  KiB/s): min=93312, max=450696, per=96.26%, avg=390095.24, stdev=73136.38, samples=21
   iops        : min=23328, max=112674, avg=97523.81, stdev=18284.09, samples=21
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=0.16%, 100=38.59%
  lat (usec)   : 250=61.09%, 500=0.16%, 750=0.01%
  lat (msec)   : 4=0.01%, 10=0.01%
  cpu          : usr=27.71%, sys=72.12%, ctx=29, majf=0, minf=15196
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647570,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1119MiB/s (1174MB/s), 1119MiB/s-1119MiB/s (1174MB/s-1174MB/s), io=2530MiB (2652MB), run=2260-2260msec
  WRITE: bw=396MiB/s (415MB/s), 396MiB/s-396MiB/s (415MB/s-415MB/s), io=4000MiB (4194MB), run=10107-10107msec

Disk stats (read/write):
  nullb0: ios=583689/1024237, merge=0/5798, ticks=571/1672, in_queue=2244, util=99.23%




#################### BLKISZ 2048 #####################
config/nullb/nullb0
├── badblocks
├── blocking
├── blocksize
├── cache_size
├── completion_nsec
├── discard
├── home_node
├── hw_queue_depth
├── index
├── irqmode
├── max_discard_sectors
├── max_sectors
├── max_write_zeroes_sectors
├── mbps
├── memory_backed
├── no_sched
├── poll_queues
├── power
├── queue_mode
├── shared_tag_bitmap
├── size
├── submit_queues
├── use_per_node_hctx
├── virt_boundary
├── write_zeroes
├── zone_capacity
├── zoned
├── zone_max_active
├── zone_max_open
├── zone_nr_conv
└── zone_size

0 directories, 31 files
MKFS:-
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 95af17f3-1251-4eb3-bb08-ef59d64de711
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext2 (rw,relatime,seclabel)
[18197.234676] null_blk: disk nullb0 created
[18198.256145] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[18198.256835] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][75.0%][r=1176MiB/s][r=301k IOPS][eta 00m:05s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=9014: Wed Oct  5 19:56:39 2022
  read: IOPS=300k, BW=1172MiB/s (1229MB/s)(2526MiB/2156msec)
    slat (nsec): min=1883, max=95211, avg=2289.83, stdev=538.98
    clat (nsec): min=1102, max=144034, avg=50260.51, stdev=3111.72
     lat (usec): min=3, max=146, avg=52.59, stdev= 3.20
    clat percentiles (usec):
     |  1.00th=[   48],  5.00th=[   49], 10.00th=[   49], 20.00th=[   49],
     | 30.00th=[   49], 40.00th=[   49], 50.00th=[   50], 60.00th=[   50],
     | 70.00th=[   50], 80.00th=[   51], 90.00th=[   55], 95.00th=[   57],
     | 99.00th=[   62], 99.50th=[   66], 99.90th=[   79], 99.95th=[   84],
     | 99.99th=[  104]
  write: IOPS=77.2k, BW=301MiB/s (316MB/s)(4000MiB/13272msec); 0 zone resets
    slat (usec): min=3, max=392, avg=12.21, stdev= 9.32
    clat (nsec): min=792, max=996792, avg=194754.81, stdev=45154.41
     lat (usec): min=6, max=1032, avg=207.04, stdev=47.09
    clat percentiles (usec):
     |  1.00th=[  127],  5.00th=[  143], 10.00th=[  151], 20.00th=[  163],
     | 30.00th=[  174], 40.00th=[  182], 50.00th=[  190], 60.00th=[  198],
     | 70.00th=[  206], 80.00th=[  215], 90.00th=[  227], 95.00th=[  289],
     | 99.00th=[  363], 99.50th=[  375], 99.90th=[  529], 99.95th=[  619],
     | 99.99th=[  725]
   bw (  KiB/s): min=192784, max=369664, per=98.30%, avg=303385.96, stdev=40667.67, samples=27
   iops        : min=48196, max=92416, avg=75846.48, stdev=10166.92, samples=27
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=28.00%, 100=10.71%
  lat (usec)   : 250=57.62%, 500=3.59%, 750=0.08%, 1000=0.01%
  cpu          : usr=23.52%, sys=74.41%, ctx=3289, majf=0, minf=15175
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=646749,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1172MiB/s (1229MB/s), 1172MiB/s-1172MiB/s (1229MB/s-1229MB/s), io=2526MiB (2649MB), run=2156-2156msec
  WRITE: bw=301MiB/s (316MB/s), 301MiB/s-301MiB/s (316MB/s-316MB/s), io=4000MiB (4194MB), run=13272-13272msec

Disk stats (read/write):
  nullb0: ios=634659/1024000, merge=0/0, ticks=558/1600, in_queue=2157, util=99.38%
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on /mnt/nullb0 on Wed Oct  5 19:56:23 2022
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: b3f69fcb-abd2-41eb-aaf5-621503259a75
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext4 (rw,relatime,seclabel)
[18214.019199] EXT4-fs (nullb0): unmounting filesystem.
[18214.041644] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][80.0%][r=1168MiB/s][r=299k IOPS][eta 00m:03s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=9027: Wed Oct  5 19:56:52 2022
  read: IOPS=297k, BW=1161MiB/s (1217MB/s)(2528MiB/2178msec)
    slat (nsec): min=1903, max=61776, avg=2321.68, stdev=544.98
    clat (nsec): min=1102, max=111392, avg=50739.27, stdev=3167.99
     lat (usec): min=3, max=113, avg=53.10, stdev= 3.27
    clat percentiles (usec):
     |  1.00th=[   48],  5.00th=[   49], 10.00th=[   49], 20.00th=[   49],
     | 30.00th=[   50], 40.00th=[   50], 50.00th=[   50], 60.00th=[   50],
     | 70.00th=[   51], 80.00th=[   51], 90.00th=[   55], 95.00th=[   58],
     | 99.00th=[   65], 99.50th=[   71], 99.90th=[   77], 99.95th=[   80],
     | 99.99th=[  104]
  write: IOPS=101k, BW=396MiB/s (415MB/s)(4000MiB/10105msec); 0 zone resets
    slat (usec): min=3, max=3540, avg= 9.23, stdev= 8.10
    clat (nsec): min=831, max=3715.1k, avg=148313.45, stdev=34493.81
     lat (usec): min=17, max=3722, avg=157.60, stdev=35.79
    clat percentiles (usec):
     |  1.00th=[  113],  5.00th=[  122], 10.00th=[  127], 20.00th=[  135],
     | 30.00th=[  139], 40.00th=[  143], 50.00th=[  147], 60.00th=[  151],
     | 70.00th=[  155], 80.00th=[  161], 90.00th=[  169], 95.00th=[  178],
     | 99.00th=[  215], 99.50th=[  243], 99.90th=[  281], 99.95th=[  334],
     | 99.99th=[  404]
   bw (  KiB/s): min=89824, max=454648, per=96.24%, avg=390095.24, stdev=74144.52, samples=21
   iops        : min=22456, max=113662, avg=97523.81, stdev=18536.13, samples=21
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=21.93%, 100=16.81%
  lat (usec)   : 250=61.03%, 500=0.22%
  lat (msec)   : 4=0.01%
  cpu          : usr=28.16%, sys=71.64%, ctx=191, majf=0, minf=15190
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647285,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1161MiB/s (1217MB/s), 1161MiB/s-1161MiB/s (1217MB/s-1217MB/s), io=2528MiB (2651MB), run=2178-2178msec
  WRITE: bw=396MiB/s (415MB/s), 396MiB/s-396MiB/s (415MB/s-415MB/s), io=4000MiB (4194MB), run=10105-10105msec

Disk stats (read/write):
  nullb0: ios=606388/1024235, merge=0/5718, ticks=528/1602, in_queue=2130, util=99.24%




#################### BLKISZ 4096 #####################
config/nullb/nullb0
├── badblocks
├── blocking
├── blocksize
├── cache_size
├── completion_nsec
├── discard
├── home_node
├── hw_queue_depth
├── index
├── irqmode
├── max_discard_sectors
├── max_sectors
├── max_write_zeroes_sectors
├── mbps
├── memory_backed
├── no_sched
├── poll_queues
├── power
├── queue_mode
├── shared_tag_bitmap
├── size
├── submit_queues
├── use_per_node_hctx
├── virt_boundary
├── write_zeroes
├── zone_capacity
├── zoned
├── zone_max_active
├── zone_max_open
├── zone_nr_conv
└── zone_size

0 directories, 31 files
MKFS:-
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 90636218-f980-4d5f-a306-d0b38fd30e92
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext2 (rw,relatime,seclabel)
[18227.145657] null_blk: disk nullb0 created
[18228.166279] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[18228.166990] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][78.9%][r=1174MiB/s][r=301k IOPS][eta 00m:04s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=9053: Wed Oct  5 19:57:08 2022
  read: IOPS=298k, BW=1165MiB/s (1221MB/s)(2530MiB/2172msec)
    slat (nsec): min=1923, max=112183, avg=2305.07, stdev=500.91
    clat (nsec): min=1342, max=256057, avg=50578.91, stdev=2797.70
     lat (usec): min=3, max=261, avg=52.93, stdev= 2.88
    clat percentiles (usec):
     |  1.00th=[   48],  5.00th=[   49], 10.00th=[   49], 20.00th=[   49],
     | 30.00th=[   50], 40.00th=[   50], 50.00th=[   50], 60.00th=[   50],
     | 70.00th=[   51], 80.00th=[   51], 90.00th=[   55], 95.00th=[   57],
     | 99.00th=[   60], 99.50th=[   61], 99.90th=[   68], 99.95th=[   81],
     | 99.99th=[  109]
  write: IOPS=79.2k, BW=309MiB/s (325MB/s)(4000MiB/12925msec); 0 zone resets
    slat (usec): min=3, max=527, avg=11.92, stdev= 9.64
    clat (nsec): min=942, max=974140, avg=189663.16, stdev=44574.80
     lat (usec): min=8, max=1353, avg=201.65, stdev=46.43
    clat percentiles (usec):
     |  1.00th=[  127],  5.00th=[  143], 10.00th=[  151], 20.00th=[  161],
     | 30.00th=[  169], 40.00th=[  178], 50.00th=[  186], 60.00th=[  192],
     | 70.00th=[  198], 80.00th=[  206], 90.00th=[  219], 95.00th=[  273],
     | 99.00th=[  363], 99.50th=[  400], 99.90th=[  545], 99.95th=[  611],
     | 99.99th=[  807]
   bw (  KiB/s): min=251544, max=368624, per=99.42%, avg=315076.92, stdev=30985.16, samples=26
   iops        : min=62886, max=92156, avg=78769.23, stdev=7746.29, samples=26
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=21.02%, 100=17.72%
  lat (usec)   : 250=58.00%, 500=3.16%, 750=0.09%, 1000=0.01%
  cpu          : usr=23.65%, sys=74.12%, ctx=3203, majf=0, minf=15194
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647556,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1165MiB/s (1221MB/s), 1165MiB/s-1165MiB/s (1221MB/s-1221MB/s), io=2530MiB (2652MB), run=2172-2172msec
  WRITE: bw=309MiB/s (325MB/s), 309MiB/s-309MiB/s (325MB/s-325MB/s), io=4000MiB (4194MB), run=12925-12925msec

Disk stats (read/write):
  nullb0: ios=583450/1024000, merge=0/0, ticks=517/1562, in_queue=2079, util=99.33%
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on /mnt/nullb0 on Wed Oct  5 19:56:53 2022
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 03970406-594a-4d78-b966-d6dbdc697b16
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext4 (rw,relatime,seclabel)
[18243.612194] EXT4-fs (nullb0): unmounting filesystem.
[18243.634860] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][80.0%][r=1161MiB/s][r=297k IOPS][eta 00m:03s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=9066: Wed Oct  5 19:57:21 2022
  read: IOPS=295k, BW=1151MiB/s (1207MB/s)(2528MiB/2196msec)
    slat (nsec): min=1944, max=76366, avg=2349.04, stdev=512.68
    clat (nsec): min=1092, max=132292, avg=51163.41, stdev=2525.10
     lat (usec): min=3, max=134, avg=53.56, stdev= 2.60
    clat percentiles (usec):
     |  1.00th=[   49],  5.00th=[   49], 10.00th=[   49], 20.00th=[   50],
     | 30.00th=[   50], 40.00th=[   51], 50.00th=[   51], 60.00th=[   51],
     | 70.00th=[   52], 80.00th=[   52], 90.00th=[   55], 95.00th=[   58],
     | 99.00th=[   60], 99.50th=[   61], 99.90th=[   65], 99.95th=[   68],
     | 99.99th=[  109]
  write: IOPS=101k, BW=396MiB/s (416MB/s)(4000MiB/10093msec); 0 zone resets
    slat (usec): min=3, max=3218, avg= 9.23, stdev= 7.92
    clat (nsec): min=772, max=3407.3k, avg=148142.35, stdev=32842.67
     lat (usec): min=6, max=3419, avg=157.43, stdev=34.05
    clat percentiles (usec):
     |  1.00th=[  114],  5.00th=[  123], 10.00th=[  128], 20.00th=[  135],
     | 30.00th=[  139], 40.00th=[  143], 50.00th=[  147], 60.00th=[  151],
     | 70.00th=[  155], 80.00th=[  161], 90.00th=[  167], 95.00th=[  176],
     | 99.00th=[  198], 99.50th=[  210], 99.90th=[  273], 99.95th=[  338],
     | 99.99th=[  457]
   bw (  KiB/s): min=78848, max=452720, per=96.12%, avg=390095.24, stdev=76125.82, samples=21
   iops        : min=19712, max=113180, avg=97523.81, stdev=19031.45, samples=21
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=12.29%, 100=26.44%
  lat (usec)   : 250=61.14%, 500=0.13%
  lat (msec)   : 4=0.01%
  cpu          : usr=27.40%, sys=72.43%, ctx=28, majf=0, minf=15187
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647188,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1151MiB/s (1207MB/s), 1151MiB/s-1151MiB/s (1207MB/s-1207MB/s), io=2528MiB (2651MB), run=2196-2196msec
  WRITE: bw=396MiB/s (416MB/s), 396MiB/s-396MiB/s (416MB/s-416MB/s), io=4000MiB (4194MB), run=10093-10093msec

Disk stats (read/write):
  nullb0: ios=604283/1024239, merge=0/5858, ticks=528/1597, in_queue=2125, util=99.24%



* Without max discard and write-zeroes set :-

linux-block (for-next) # for i in `ls /sys/block/nullb0/queue/*discard*`;
do echo -n $i:   ;cat $i; echo "";  done 
/sys/block/nullb0/queue/discard_granularity:4096

/sys/block/nullb0/queue/discard_max_bytes:4294966784

/sys/block/nullb0/queue/discard_max_hw_bytes:4294966784

/sys/block/nullb0/queue/discard_zeroes_data:0

/sys/block/nullb0/queue/max_discard_segments:1

linux-block (for-next) # for i in `ls /sys/block/nullb0/queue/*zeroes*`;
do echo -n $i:   ;cat $i; echo "";  done 
/sys/block/nullb0/queue/discard_zeroes_data:0

/sys/block/nullb0/queue/write_zeroes_max_bytes:4294966784
* With max discard and write-zeroes set to 1  :-

linux-block (for-next) # for i in `ls /sys/block/nullb0/queue/*discard*`;
do echo -n $i:   ;cat $i; echo "";  done 
/sys/block/nullb0/queue/discard_granularity:4096

/sys/block/nullb0/queue/discard_max_bytes:512

/sys/block/nullb0/queue/discard_max_hw_bytes:512

/sys/block/nullb0/queue/discard_zeroes_data:0

/sys/block/nullb0/queue/max_discard_segments:1

linux-block (for-next) # for i in `ls /sys/block/nullb0/queue/*zeroes*`; do echo -n $i:   ;cat $i; echo "";  done /sys/block/nullb0/queue/discard_zeroes_data:0

/sys/block/nullb0/queue/write_zeroes_max_bytes:512

linux-block (for-next) # 





-- 
2.29.0

