Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16EF63CBCC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiK2X2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiK2X2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:28:36 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A53631EE1;
        Tue, 29 Nov 2022 15:28:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8nxcsB4Bke5vQfqYJRpNnaYIU+Z118eovKLxb792+BOIoT5SBeSn/9zx0UNPMT0/p7buDsYl+EGmaWogWYPXzdPAuOuT1kAfDjB7nH4GCKH52+d0/IfiwWeBwz/N9+bkiU3XWECPStxX80qNPP+aflQPTxivlnwSsp1QCOzlWveKf4d0fk1ZepluUz2SiP3H+XBHJ3G5+tlHZUWZjdtvCu3b4cq3SOAxLPY093WW4ZZ1wYdrV1TieZGXtPZ7+/8ccXTTB/Rm8EPAwrtvPDbgzj+zl7ebUu2Lqc8ZHTyqfeSHsFPra0AZb/tiDTyGItImFtZT8+icJRPvE4XFex1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIzAkoh8dlHoyHWEhaftqTnHu5ACAcoMhytjq1OM4V8=;
 b=bruxSpZSP+KWk4/1EiH2Vpk8lYXGHd0umLUXxqNSPItAOCe+YjLi7LdD0m1t5WQUJw5OYoCtSiBPJbUuMWw/H0nu+DD3YZjsCG5wJ10Avs9pdFIi+D1WR9X/aYe8H9HiE36znMy8+vrrMVuwyEPeXCJu04ouy3CPuKFtt4X7jXcA6URCspPzRGcEIWF4DNd1g+sAHQL5RaQe1nKiSzApeq/r/96H3/+PBQmMp5cLZ/oN1IBkSaM7btsBflk6nL66cLSx8coMsusFNs6WhFo5wpi2MPModa7KLmFpOcynZ4hg7b4SovwgvCoKZPJM4XIEQI54az65SJkRuP5X4s/unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIzAkoh8dlHoyHWEhaftqTnHu5ACAcoMhytjq1OM4V8=;
 b=SqOY8FEfJNa1sglnc/RzMOlE0TmBNtbc76ZGqUHy9jYZdICO0UaSGQv+Hqoe0Jm7Xd47T+7xZkuyWEheMIFaMNIO8IZiR07qx0gnRbzjTuJbhJZIireL5uyq7EwnNnl1k9Qz4OFhWj//YyAokVhBQSg4BlZnlg+JJpAZZL21tgJ2AB5ZOO/KvV6BFUAwIWrSrW1Pw/qtxa8aoFtl0+hXIKcYcaqFnmIkh/fR1XVle11Eg/EBJ3tM0DDCgt66ajBJZWIssSUNEaLD83wUDL6venogfozibbkws+LdsNYQa7u0C+DZ1di1jdmOqBJYXQlXQ2NQ2foPmjDXt/tLdJ2p9w==
Received: from DM6PR02CA0131.namprd02.prod.outlook.com (2603:10b6:5:1b4::33)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 23:28:29 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::c6) by DM6PR02CA0131.outlook.office365.com
 (2603:10b6:5:1b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 23:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23 via Frontend Transport; Tue, 29 Nov 2022 23:28:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:28:22 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 15:28:21 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <bvanassche@acm.org>, <shinichiro.kawasaki@wdc.com>,
        <vincent.fu@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V4 0/7] null_blk: allow REQ_OP_WRITE_ZEROES and cleanup
Date:   Tue, 29 Nov 2022 15:28:05 -0800
Message-ID: <20221129232813.37968-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|BL1PR12MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1c7a03-074b-498d-7378-08dad2616bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fmp3uRnLusNRe89ouTkHrTel10srlu0InEwbA7XAf3EsdbG6xd+GLMayIIORkexrvxKjvgvgJ6HCeloagEpvroA16QR96eZ1fs2v+rLQlqXA+jtEYfr3oC6fCmiK28u5yxb3L67mOF5m23XJF/F6jPQrJGzyEuIFtEL8t8pofRFZ4m5v7cIyMy4FZwyY+Kr5MJPCN/qF6a8NI58j1+buX9KjrcNyOS9cDiDGBXeyYTYWGpEcLeUZKdYleRIvAPheYO9VuGPkYqTOgnsYBbObZmPpknAl9fKWvLWNMotvv+f4YRUalA4eCO0Vpr7NphPgpvoG4S0Pghw1eO/p8I8Jt+5H5WrjcFPD0N2FxrFPPIByB5BF1EuHsKdjMwd4gnW7k5T8q2vXm60e6fRXXYqlAtapwJX0O+um6BGaMsv1U9q/s+pvoC7EvlwSrbtxf0z/neLayMvAyWo1aEUgtcTLBtRwfc99j0I2TfATganTNX46ErDA5WuUYEbWWgGePTa275kZUPAVZ5VpfFMw8lQK5w1NRvgkzRZjKTNnTTrKGilcx8EVm3ol45EVQbv+Rz9lSL2HZNLnMBEw91dchPwM9wxNLCxt+KOD/KL7FJ0CMyIvn26sYiNQon0ovEyocyQGfEQY+sPOubyve81M1H7i4YRc4waQps/53XLIhTepoXXq1NqvtxUTm8PGZzEI9NOU6N7Csq+iEK2VQjzAu9Azrg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(8936002)(82310400005)(30864003)(41300700001)(36756003)(8676002)(70586007)(70206006)(82740400003)(4326008)(110136005)(107886003)(7636003)(54906003)(6666004)(316002)(19627235002)(2906002)(478600001)(47076005)(5660300002)(83380400001)(16526019)(186003)(336012)(426003)(7696005)(40480700001)(356005)(40460700003)(26005)(2616005)(36860700001)(1076003)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 23:28:29.0282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1c7a03-074b-498d-7378-08dad2616bfe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
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

Add support for non-trivial I/O operations REQ_OP_WRITE_ZEROES
and REQ_OP_ZONE_RESET in null_blk so we can write the blktests.

This also has few cleanup patches.

Below is the test report for REQ_OP_WRITE_ZEROES with ext2/ext4
and REQ_OP_ZONE_RESET_ALL with module param parameter and
blkzone reset command.

-ck

v3->v4:-
1. Add REQ_OP_ZONE_RESET_ALL patch in this series.

v2->v3:-

1. Fix the commit log in patch 3. (Bart)
2. Fix the commit log in patch 4. (Bart)

v1->v2:-

1. Merge patch 1 and 2 (Damien).
2. Change SECT_INX_IN_PAGE->SECT_OFFSET_IN_PAGE. (Damien)
3. Add reviewed-by tags. (Damien)
4. Add discard/write-zeroes module param to set the respective
  max sector length.

Chaitanya Kulkarni (8):
  null_blk: allow REQ_OP_WRITE_ZEROES
  null_blk: code cleaup
  null_blk: initialize cmd->bio in __alloc_cmd()
  null_blk: don't use magic numbers in the code
  null_blk: remove extra space in switch condition
  null_blk: add param to set max disacrd sectors
  null_blk: add param to set max write-zeroes sects
  null-blk: allow REQ_OP_ZONE_RESET_ALL to configure

 drivers/block/null_blk/main.c     | 156 +++++++++++++++++++++++-------
 drivers/block/null_blk/null_blk.h |   4 +
 drivers/block/null_blk/zoned.c    |   3 +-
 3 files changed, 126 insertions(+), 37 deletions(-)

* zone_reset_all module param test :-

null-blk-big (for-next) # gitlog -9 
e6379b3d9131 (HEAD -> for-next) null-blk: allow REQ_OP_ZONE_RESET_ALL to configure
2e183ad4c9fe null_blk: add param to set max write-zeroes sects
7835bf24ff04 null_blk: add param to set max disacrd sectors
d0b50155e1b0 null_blk: remove extra space in switch condition
5ba8509a3ea9 null_blk: don't use magic numbers in the code
e5ad7ffea415 null_blk: initialize cmd->bio in __alloc_cmd()
e8afe2c633e0 null_blk: code cleaup
6739fbf5fbb1 null_blk: allow REQ_OP_WRITE_ZEROES
14c66466ce0d Merge branch 'for-next' of git://git.kernel.dk/linux-block into for-next
null-blk-big (for-next) # 
linux-block (for-next) # modprobe null_blk zoned=1 zone_size=128 gb=1 zone_reset_all=0
linux-block (for-next) # blkzone reset /dev/nullb0
linux-block (for-next) # dmesg  -c
[ 1512.814822] null_blk: disk nullb0 created
[ 1512.814826] null_blk: module loaded
linux-block (for-next) # dd if=/dev/zero of=/dev/nullb0
dd: writing to '/dev/nullb0': No space left on device
2097153+0 records in
2097152+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 8.75027 s, 123 MB/s
linux-block (for-next) # blkzone reset /dev/nullb0
linux-block (for-next) # dmesg  -c
[ 1538.241929] null_blk: null_zone_mgmt 613 ZONE_RESET
[ 1538.241939] null_blk: null_zone_mgmt 613 ZONE_RESET
[ 1538.241942] null_blk: null_zone_mgmt 613 ZONE_RESET
[ 1538.241945] null_blk: null_zone_mgmt 613 ZONE_RESET
[ 1538.241947] null_blk: null_zone_mgmt 613 ZONE_RESET
[ 1538.241949] null_blk: null_zone_mgmt 613 ZONE_RESET
[ 1538.241951] null_blk: null_zone_mgmt 613 ZONE_RESET
[ 1538.241953] null_blk: null_zone_mgmt 613 ZONE_RESET
linux-block (for-next) # modprobe -r null_blk
linux-block (for-next) # modprobe null_blk zoned=1 zone_size=128 gb=1
linux-block (for-next) # dmesg  -c
[ 1558.097021] null_blk: disk nullb0 created
[ 1558.097026] null_blk: module loaded
linux-block (for-next) # dd if=/dev/zero of=/dev/nullb0
dd: writing to '/dev/nullb0': No space left on device
2097153+0 records in
2097152+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 8.70702 s, 123 MB/s
linux-block (for-next) # blkzone reset /dev/nullb0
linux-block (for-next) # dmesg  -c
[ 1575.708141] null_blk: null_zone_mgmt 613 ZONE_RESET_ALL
linux-block (for-next) #
----------------------------------------------------------------------

* blktests :-

blktests (master) # ./check block
block/001 (stress device hotplugging)                        [passed]
    runtime  51.784s  ...  51.521s
block/002 (remove a device while running blktrace)           [passed]
    runtime  1.275s  ...  0.819s
block/006 (run null-blk in blocking mode)                    [passed]
    read iops  8698266  ...  276934
    runtime    9.911s   ...  257.702s
block/007 => nullb1 (test classic and hybrid IO polling)     [passed]
    auto hybrid poll read iops       618264      ...  621194
    auto hybrid poll read lat mean   1.369138    ...  1.360774
    auto hybrid poll system cpu      72.340426%  ...  71.496437%
    classic poll read iops           622669      ...  613920
    classic poll read lat mean       1.361180    ...  1.383144
    classic poll system cpu          77.142857%  ...  73.474178%
    fixed hybrid poll read iops      615361      ...  612485
    fixed hybrid poll read lat mean  1.380764    ...  1.387007
    fixed hybrid poll system cpu     74.352941%  ...  73.067916%
    no poll read iops                615361      ...  615361
    no poll read lat mean            1.381291    ...  1.374778
    no poll system cpu               72.470588%  ...  78.117647%
    runtime                          2.511s      ...  2.522s
block/009 (check page-cache coherency after BLKDISCARD)      [passed]
    runtime  0.612s  ...  0.590s
block/010 (run I/O on null_blk with shared and non-shared tags) [passed]
    Individual tags read iops  7742139  ...  7772627
    runtime                    21.273s  ...  21.055s
    Shared tags read iops      7666079  ...  7685394
block/014 (run null-blk with blk-mq and timeout injection configured) [passed]
    runtime  49.537s  ...  60.790s
block/015 (run null-blk on different schedulers with requeue injection configured) [passed]
    runtime  45.369s  ...  45.660s
block/016 (send a signal to a process waiting on a frozen queue) [passed]
    runtime  7.084s  ...  7.074s
block/017 (do I/O and check the inflight counter)            [passed]
    runtime  1.701s  ...  1.708s
block/018 (do I/O and check iostats times)                   [passed]
    runtime  5.114s  ...  5.111s
block/020 (run null-blk on different schedulers with only one hardware tag) [passed]
    runtime  41.520s  ...  41.569s
block/021 (read/write nr_requests on null-blk with different schedulers) [passed]
    runtime  5.431s  ...  5.380s
block/022 (Test hang caused by freeze/unfreeze sequence)     [passed]
    runtime  30.162s  ...  30.142s
block/023 (do I/O on all null_blk queue modes)               [passed]
    runtime  0.270s  ...  0.254s
block/024 (do I/O faster than a jiffy and check iostats times) [passed]
    runtime    ...  2.653s
block/025 (do a huge discard with 4k sector size)            [passed]
    runtime    ...  3.935s
block/028 (do I/O on scsi_debug with DIF/DIX enabled)        [passed]
    runtime  13.590s  ...  13.213s
block/029 (trigger blk_mq_update_nr_hw_queues())             [passed]
    runtime  30.301s  ...  30.297s
block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [passed]
    runtime  2.167s  ...  2.231s
block/031 (do IO on null-blk with a host tag set)            [passed]
    runtime  30.346s  ...  30.317s
----------------------------------------------------------------------

* REQ_OP_WRITE_ZEROES tests file systems on null_blk  :-

blktests (master) # cdblk
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
├── zone_reset_all
└── zone_size

0 directories, 32 files
ODD:- 
19+1 records in
19+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.000397535 s, 25.2 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0000512   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000528
0001024   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001040
0001536   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001552
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0002560   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002576
0003072   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003088
0003584   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003600
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0004608   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004624
------------------------------------------------------
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0000512  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0000528
0001024   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001040
0001536  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0001552
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0002560  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0002576
0003072   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003088
0003584  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0003600
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0004608  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0004624
------------------------------------------------------
EVEN:- 
19+1 records in
19+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.000354233 s, 28.2 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0000512   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000528
0001024   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001040
0001536   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001552
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0002560   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002576
0003072   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003088
0003584   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003600
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0004608   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004624
------------------------------------------------------
0000000  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0000016
0000512   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000528
0001024  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0001040
0001536   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001552
0002048  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0002064
0002560   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002576
0003072  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0003088
0003584   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003600
0004096  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0004112
0004608   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004624
------------------------------------------------------
MKFS:-
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 559bb828-96da-493e-9f1a-e95ca2511cc1
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext2 (rw,relatime,seclabel)
[ 2318.588649] null_blk: disk nullb0 created
[ 2319.711011] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[ 2319.711647] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][75.0%][r=1068MiB/s][r=273k IOPS][eta 00m:05s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=33178: Tue Nov 29 11:41:06 2022
  read: IOPS=273k, BW=1068MiB/s (1120MB/s)(2526MiB/2366msec)
    slat (nsec): min=2144, max=86435, avg=2581.56, stdev=533.42
    clat (nsec): min=1312, max=254073, avg=55146.61, stdev=2945.44
     lat (usec): min=4, max=260, avg=57.77, stdev= 3.03
    clat percentiles (usec):
     |  1.00th=[   53],  5.00th=[   53], 10.00th=[   54], 20.00th=[   54],
     | 30.00th=[   55], 40.00th=[   55], 50.00th=[   55], 60.00th=[   55],
     | 70.00th=[   56], 80.00th=[   56], 90.00th=[   60], 95.00th=[   62],
     | 99.00th=[   64], 99.50th=[   67], 99.90th=[   73], 99.95th=[  100],
     | 99.99th=[  113]
  write: IOPS=77.4k, BW=303MiB/s (317MB/s)(4000MiB/13222msec); 0 zone resets
    slat (usec): min=3, max=425, avg=12.17, stdev= 8.79
    clat (nsec): min=811, max=912994, avg=194013.00, stdev=43636.73
     lat (usec): min=6, max=1091, avg=206.26, stdev=45.56
    clat percentiles (usec):
     |  1.00th=[  128],  5.00th=[  143], 10.00th=[  153], 20.00th=[  163],
     | 30.00th=[  174], 40.00th=[  182], 50.00th=[  190], 60.00th=[  196],
     | 70.00th=[  206], 80.00th=[  217], 90.00th=[  229], 95.00th=[  277],
     | 99.00th=[  363], 99.50th=[  412], 99.90th=[  529], 99.95th=[  594],
     | 99.99th=[  725]
   bw (  KiB/s): min=158880, max=368952, per=97.94%, avg=303407.41, stdev=46322.27, samples=27
   iops        : min=39720, max=92238, avg=75851.85, stdev=11580.56, samples=27
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=38.69%
  lat (usec)   : 250=57.76%, 500=3.47%, 750=0.07%, 1000=0.01%
  cpu          : usr=22.96%, sys=75.13%, ctx=3281, majf=0, minf=15174
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=646667,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1068MiB/s (1120MB/s), 1068MiB/s-1068MiB/s (1120MB/s-1120MB/s), io=2526MiB (2649MB), run=2366-2366msec
  WRITE: bw=303MiB/s (317MB/s), 303MiB/s-303MiB/s (317MB/s-317MB/s), io=4000MiB (4194MB), run=13222-13222msec

Disk stats (read/write):
  nullb0: ios=591402/1024000, merge=0/0, ticks=679/1716, in_queue=2395, util=99.37%
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on /mnt/nullb0 on Tue Nov 29 11:40:50 2022
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 16c104f4-70b9-4dbc-bd64-3e2a455fc2c5
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext4 (rw,relatime,seclabel)
[ 2335.638785] EXT4-fs (nullb0): unmounting filesystem.
[ 2335.667259] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][70.6%][r=1063MiB/s][r=272k IOPS][eta 00m:05s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=33191: Tue Nov 29 11:41:19 2022
  read: IOPS=272k, BW=1062MiB/s (1113MB/s)(2528MiB/2381msec)
    slat (nsec): min=2114, max=57911, avg=2609.46, stdev=523.69
    clat (nsec): min=1192, max=113706, avg=55470.72, stdev=2535.05
     lat (usec): min=3, max=116, avg=58.12, stdev= 2.60
    clat percentiles (nsec):
     |  1.00th=[52992],  5.00th=[53504], 10.00th=[53504], 20.00th=[54016],
     | 30.00th=[54016], 40.00th=[54528], 50.00th=[54528], 60.00th=[55040],
     | 70.00th=[55552], 80.00th=[56064], 90.00th=[59136], 95.00th=[61696],
     | 99.00th=[64256], 99.50th=[65280], 99.90th=[68096], 99.95th=[70144],
     | 99.99th=[82432]
  write: IOPS=98.6k, BW=385MiB/s (404MB/s)(4000MiB/10384msec); 0 zone resets
    slat (usec): min=3, max=3670, avg= 9.50, stdev= 8.89
    clat (nsec): min=901, max=3807.5k, avg=152411.99, stdev=37693.76
     lat (usec): min=6, max=3814, avg=161.97, stdev=39.12
    clat percentiles (usec):
     |  1.00th=[  116],  5.00th=[  125], 10.00th=[  131], 20.00th=[  137],
     | 30.00th=[  143], 40.00th=[  147], 50.00th=[  151], 60.00th=[  155],
     | 70.00th=[  159], 80.00th=[  165], 90.00th=[  174], 95.00th=[  180],
     | 99.00th=[  215], 99.50th=[  255], 99.90th=[  326], 99.95th=[  486],
     | 99.99th=[ 1029]
   bw (  KiB/s): min=338664, max=438728, per=98.90%, avg=390095.24, stdev=30398.74, samples=21
   iops        : min=84666, max=109682, avg=97523.81, stdev=7599.67, samples=21
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=38.73%
  lat (usec)   : 250=60.93%, 500=0.32%, 750=0.02%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%
  cpu          : usr=27.52%, sys=72.30%, ctx=25, majf=0, minf=15185
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647104,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1062MiB/s (1113MB/s), 1062MiB/s-1062MiB/s (1113MB/s-1113MB/s), io=2528MiB (2651MB), run=2381-2381msec
  WRITE: bw=385MiB/s (404MB/s), 385MiB/s-385MiB/s (404MB/s-404MB/s), io=4000MiB (4194MB), run=10384-10384msec

Disk stats (read/write):
  nullb0: ios=614200/1024237, merge=0/5794, ticks=691/1819, in_queue=2509, util=99.28%




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
├── zone_reset_all
└── zone_size

0 directories, 32 files
ODD:- 
9+1 records in
9+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.000487677 s, 20.5 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0001024   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001040
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0003072   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003088
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0005120   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0005136
0006144   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0006160
0007168   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0007184
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0009216   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0009232
------------------------------------------------------
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0001024  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0001040
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0003072  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0003088
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0005120  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0005136
0006144   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0006160
0007168  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0007184
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0009216  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0009232
------------------------------------------------------
EVEN:- 
9+1 records in
9+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.000338302 s, 29.6 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0001024   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001040
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0003072   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003088
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0005120   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0005136
0006144   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0006160
0007168   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0007184
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0009216   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0009232
------------------------------------------------------
0000000  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0000016
0001024   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0001040
0002048  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0002064
0003072   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0003088
0004096  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0004112
0005120   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0005136
0006144  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0006160
0007168   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0007184
0008192  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0008208
0009216   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0009232
------------------------------------------------------
MKFS:-
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 76101011-10f1-4ec6-9d98-2ddd161bd864
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext2 (rw,relatime,seclabel)
[ 2349.239397] null_blk: disk nullb0 created
[ 2350.358369] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[ 2350.359025] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][78.9%][r=1104MiB/s][r=283k IOPS][eta 00m:04s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=33272: Tue Nov 29 11:41:36 2022
  read: IOPS=282k, BW=1101MiB/s (1154MB/s)(2529MiB/2298msec)
    slat (nsec): min=2074, max=80162, avg=2467.59, stdev=537.50
    clat (nsec): min=1322, max=131670, avg=53508.87, stdev=2599.84
     lat (usec): min=3, max=134, avg=56.02, stdev= 2.66
    clat percentiles (usec):
     |  1.00th=[   51],  5.00th=[   52], 10.00th=[   52], 20.00th=[   52],
     | 30.00th=[   53], 40.00th=[   53], 50.00th=[   53], 60.00th=[   53],
     | 70.00th=[   53], 80.00th=[   54], 90.00th=[   58], 95.00th=[   60],
     | 99.00th=[   63], 99.50th=[   64], 99.90th=[   68], 99.95th=[   72],
     | 99.99th=[  110]
  write: IOPS=79.2k, BW=309MiB/s (325MB/s)(4000MiB/12925msec); 0 zone resets
    slat (usec): min=3, max=436, avg=11.88, stdev= 9.13
    clat (nsec): min=771, max=817313, avg=189666.35, stdev=42086.13
     lat (usec): min=6, max=1163, avg=201.62, stdev=43.78
    clat percentiles (usec):
     |  1.00th=[  127],  5.00th=[  143], 10.00th=[  151], 20.00th=[  161],
     | 30.00th=[  172], 40.00th=[  178], 50.00th=[  186], 60.00th=[  194],
     | 70.00th=[  200], 80.00th=[  208], 90.00th=[  219], 95.00th=[  247],
     | 99.00th=[  355], 99.50th=[  367], 99.90th=[  523], 99.95th=[  594],
     | 99.99th=[  676]
   bw (  KiB/s): min=263160, max=371280, per=99.42%, avg=315076.62, stdev=30770.94, samples=26
   iops        : min=65790, max=92820, avg=78769.23, stdev=7692.66, samples=26
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=38.74%
  lat (usec)   : 250=58.22%, 500=2.96%, 750=0.07%, 1000=0.01%
  cpu          : usr=24.01%, sys=73.91%, ctx=3158, majf=0, minf=15193
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647497,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1101MiB/s (1154MB/s), 1101MiB/s-1101MiB/s (1154MB/s-1154MB/s), io=2529MiB (2652MB), run=2298-2298msec
  WRITE: bw=309MiB/s (325MB/s), 309MiB/s-309MiB/s (325MB/s-325MB/s), io=4000MiB (4194MB), run=12925-12925msec

Disk stats (read/write):
  nullb0: ios=623394/1024000, merge=0/0, ticks=634/1557, in_queue=2192, util=99.35%
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on /mnt/nullb0 on Tue Nov 29 11:41:21 2022
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 77e31a3f-74b7-4d5a-a6ac-b301b57e5641
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext4 (rw,relatime,seclabel)
[ 2365.921130] EXT4-fs (nullb0): unmounting filesystem.
[ 2365.946875] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][75.0%][r=1097MiB/s][r=281k IOPS][eta 00m:04s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=33285: Tue Nov 29 11:41:49 2022
  read: IOPS=281k, BW=1096MiB/s (1149MB/s)(2527MiB/2306msec)
    slat (nsec): min=1994, max=109890, avg=2499.66, stdev=567.50
    clat (nsec): min=1223, max=234395, avg=53755.24, stdev=3190.19
     lat (usec): min=4, max=240, avg=56.30, stdev= 3.29
    clat percentiles (usec):
     |  1.00th=[   51],  5.00th=[   52], 10.00th=[   52], 20.00th=[   52],
     | 30.00th=[   53], 40.00th=[   53], 50.00th=[   53], 60.00th=[   53],
     | 70.00th=[   54], 80.00th=[   55], 90.00th=[   58], 95.00th=[   61],
     | 99.00th=[   64], 99.50th=[   66], 99.90th=[   83], 99.95th=[   99],
     | 99.99th=[  123]
  write: IOPS=99.2k, BW=388MiB/s (406MB/s)(4000MiB/10321msec); 0 zone resets
    slat (usec): min=3, max=3517, avg= 9.44, stdev= 7.93
    clat (nsec): min=942, max=3691.6k, avg=151485.29, stdev=34257.79
     lat (usec): min=12, max=3706, avg=160.98, stdev=35.57
    clat percentiles (usec):
     |  1.00th=[  115],  5.00th=[  124], 10.00th=[  129], 20.00th=[  137],
     | 30.00th=[  141], 40.00th=[  147], 50.00th=[  151], 60.00th=[  155],
     | 70.00th=[  159], 80.00th=[  165], 90.00th=[  174], 95.00th=[  180],
     | 99.00th=[  210], 99.50th=[  245], 99.90th=[  326], 99.95th=[  437],
     | 99.99th=[  586]
   bw (  KiB/s): min=285432, max=445696, per=98.30%, avg=390095.24, stdev=38760.46, samples=21
   iops        : min=71358, max=111424, avg=97523.81, stdev=9690.11, samples=21
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=38.70%
  lat (usec)   : 250=61.03%, 500=0.26%, 750=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%
  cpu          : usr=27.24%, sys=72.61%, ctx=26, majf=0, minf=15179
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=646864,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1096MiB/s (1149MB/s), 1096MiB/s-1096MiB/s (1149MB/s-1149MB/s), io=2527MiB (2650MB), run=2306-2306msec
  WRITE: bw=388MiB/s (406MB/s), 388MiB/s-388MiB/s (406MB/s-406MB/s), io=4000MiB (4194MB), run=10321-10321msec

Disk stats (read/write):
  nullb0: ios=582149/1024235, merge=0/5742, ticks=586/1682, in_queue=2269, util=99.25%




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
├── zone_reset_all
└── zone_size

0 directories, 32 files
ODD:- 
4+1 records in
4+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.00036307 s, 27.5 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0006144   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0006160
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0010240  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0010256
0012288  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0012304
0014336  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0014352
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0016400
0018432  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0018448
------------------------------------------------------
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0002048  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0002064
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0006144  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0006160
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0010240  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0010256
0012288  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0012304
0014336  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0014352
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0016400
0018432  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0018448
------------------------------------------------------
EVEN:- 
4+1 records in
4+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.000343111 s, 29.2 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0006144   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0006160
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0010240  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0010256
0012288  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0012304
0014336  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0014352
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0016400
0018432  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0018448
------------------------------------------------------
0000000  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0000016
0002048   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0002064
0004096  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0004112
0006144   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0006160
0008192  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0008208
0010240  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0010256
0012288  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0012304
0014336  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0014352
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0016400
0018432  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0018448
------------------------------------------------------
MKFS:-
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 1b57f322-be38-4950-a963-94dd4276b5bb
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext2 (rw,relatime,seclabel)
[ 2379.405522] null_blk: disk nullb0 created
[ 2380.523797] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[ 2380.524358] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][80.0%][r=1061MiB/s][r=272k IOPS][eta 00m:04s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=33365: Tue Nov 29 11:42:07 2022
  read: IOPS=269k, BW=1050MiB/s (1101MB/s)(2530MiB/2409msec)
    slat (nsec): min=1913, max=60406, avg=2571.22, stdev=660.83
    clat (nsec): min=1202, max=125759, avg=56086.29, stdev=3692.00
     lat (usec): min=4, max=128, avg=58.72, stdev= 3.80
    clat percentiles (nsec):
     |  1.00th=[49920],  5.00th=[51456], 10.00th=[51968], 20.00th=[53504],
     | 30.00th=[54528], 40.00th=[55040], 50.00th=[55552], 60.00th=[56064],
     | 70.00th=[56576], 80.00th=[57600], 90.00th=[61184], 95.00th=[64256],
     | 99.00th=[67072], 99.50th=[69120], 99.90th=[74240], 99.95th=[78336],
     | 99.99th=[89600]
  write: IOPS=75.1k, BW=293MiB/s (308MB/s)(4000MiB/13631msec); 0 zone resets
    slat (usec): min=3, max=402, avg=12.46, stdev= 9.23
    clat (nsec): min=882, max=1006.9k, avg=200071.94, stdev=43702.18
     lat (usec): min=6, max=1156, avg=212.62, stdev=45.49
    clat percentiles (usec):
     |  1.00th=[  135],  5.00th=[  149], 10.00th=[  159], 20.00th=[  172],
     | 30.00th=[  180], 40.00th=[  188], 50.00th=[  196], 60.00th=[  204],
     | 70.00th=[  210], 80.00th=[  219], 90.00th=[  231], 95.00th=[  285],
     | 99.00th=[  363], 99.50th=[  379], 99.90th=[  537], 99.95th=[  611],
     | 99.99th=[  725]
   bw (  KiB/s): min=85440, max=354232, per=97.36%, avg=292570.86, stdev=50623.71, samples=28
   iops        : min=21360, max=88558, avg=73142.86, stdev=12656.04, samples=28
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=0.47%, 100=38.28%
  lat (usec)   : 250=57.61%, 500=3.56%, 750=0.08%, 1000=0.01%
  lat (msec)   : 2=0.01%
  cpu          : usr=23.26%, sys=74.74%, ctx=3384, majf=0, minf=15199
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647741,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1050MiB/s (1101MB/s), 1050MiB/s-1050MiB/s (1101MB/s-1101MB/s), io=2530MiB (2653MB), run=2409-2409msec
  WRITE: bw=293MiB/s (308MB/s), 293MiB/s-293MiB/s (308MB/s-308MB/s), io=4000MiB (4194MB), run=13631-13631msec

Disk stats (read/write):
  nullb0: ios=606253/1024000, merge=0/0, ticks=609/1680, in_queue=2290, util=99.40%
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on /mnt/nullb0 on Tue Nov 29 11:41:51 2022
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 6fe66e2f-3816-42b8-a491-5de76a872b6f
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext4 (rw,relatime,seclabel)
[ 2396.902577] EXT4-fs (nullb0): unmounting filesystem.
[ 2396.925680] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][75.0%][r=1125MiB/s][r=288k IOPS][eta 00m:04s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=33379: Tue Nov 29 11:42:20 2022
  read: IOPS=288k, BW=1124MiB/s (1179MB/s)(2529MiB/2250msec)
    slat (nsec): min=1973, max=104008, avg=2402.39, stdev=562.74
    clat (nsec): min=1183, max=344946, avg=52394.60, stdev=3095.91
     lat (usec): min=3, max=347, avg=54.84, stdev= 3.16
    clat percentiles (usec):
     |  1.00th=[   50],  5.00th=[   50], 10.00th=[   51], 20.00th=[   51],
     | 30.00th=[   51], 40.00th=[   52], 50.00th=[   52], 60.00th=[   52],
     | 70.00th=[   53], 80.00th=[   53], 90.00th=[   57], 95.00th=[   59],
     | 99.00th=[   62], 99.50th=[   63], 99.90th=[   68], 99.95th=[   72],
     | 99.99th=[  119]
  write: IOPS=99.1k, BW=387MiB/s (406MB/s)(4000MiB/10332msec); 0 zone resets
    slat (usec): min=3, max=3493, avg= 9.46, stdev= 8.55
    clat (nsec): min=922, max=3689.5k, avg=151643.40, stdev=35090.99
     lat (usec): min=7, max=3702, avg=161.16, stdev=36.36
    clat percentiles (usec):
     |  1.00th=[  119],  5.00th=[  128], 10.00th=[  133], 20.00th=[  139],
     | 30.00th=[  143], 40.00th=[  147], 50.00th=[  151], 60.00th=[  155],
     | 70.00th=[  159], 80.00th=[  163], 90.00th=[  169], 95.00th=[  178],
     | 99.00th=[  204], 99.50th=[  229], 99.90th=[  293], 99.95th=[  363],
     | 99.99th=[  494]
   bw (  KiB/s): min=283352, max=422080, per=98.40%, avg=390095.24, stdev=30150.48, samples=21
   iops        : min=70838, max=105520, avg=97523.81, stdev=7537.59, samples=21
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=1.71%, 100=37.02%
  lat (usec)   : 250=61.07%, 500=0.19%, 750=0.01%
  lat (msec)   : 4=0.01%
  cpu          : usr=27.72%, sys=72.09%, ctx=34, majf=0, minf=15194
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647483,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1124MiB/s (1179MB/s), 1124MiB/s-1124MiB/s (1179MB/s-1179MB/s), io=2529MiB (2652MB), run=2250-2250msec
  WRITE: bw=387MiB/s (406MB/s), 387MiB/s-387MiB/s (406MB/s-406MB/s), io=4000MiB (4194MB), run=10332-10332msec

Disk stats (read/write):
  nullb0: ios=593747/1024233, merge=0/5673, ticks=538/1638, in_queue=2176, util=99.26%




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
├── zone_reset_all
└── zone_size

0 directories, 32 files
ODD:- 
2+1 records in
2+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.000348442 s, 28.7 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0012288  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0012304
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0016400
0020480  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0020496
0024576  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0024592
0028672  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0028688
0032768  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0032784
0036864  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0036880
------------------------------------------------------
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0004096  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0004112
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0012288  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0012304
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0016400
0020480  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0020496
0024576  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0024592
0028672  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0028688
0032768  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0032784
0036864  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0036880
------------------------------------------------------
EVEN:- 
2+1 records in
2+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.000225138 s, 44.4 MB/s
0000000   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0000016
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0008192   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0008208
0012288  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0012304
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0016400
0020480  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0020496
0024576  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0024592
0028672  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0028688
0032768  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0032784
0036864  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0036880
------------------------------------------------------
0000000  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0000016
0004096   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a   a
0004112
0008192  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0008208
0012288  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0012304
0016384  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0016400
0020480  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0020496
0024576  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0024592
0028672  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0028688
0032768  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0032784
0036864  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
0036880
------------------------------------------------------
MKFS:-
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 19fd9837-934d-47fc-8f7f-bab84f720e6e
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext2 (rw,relatime,seclabel)
[ 2410.378712] null_blk: disk nullb0 created
[ 2411.491527] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[ 2411.492107] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][78.9%][r=1142MiB/s][r=292k IOPS][eta 00m:04s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=33461: Tue Nov 29 11:42:37 2022
  read: IOPS=291k, BW=1138MiB/s (1193MB/s)(2529MiB/2222msec)
    slat (nsec): min=1873, max=133413, avg=2348.75, stdev=527.11
    clat (nsec): min=1302, max=268730, avg=51768.86, stdev=3074.23
     lat (usec): min=3, max=274, avg=54.16, stdev= 3.17
    clat percentiles (usec):
     |  1.00th=[   50],  5.00th=[   50], 10.00th=[   50], 20.00th=[   51],
     | 30.00th=[   51], 40.00th=[   51], 50.00th=[   51], 60.00th=[   51],
     | 70.00th=[   52], 80.00th=[   52], 90.00th=[   56], 95.00th=[   58],
     | 99.00th=[   62], 99.50th=[   65], 99.90th=[   81], 99.95th=[   84],
     | 99.99th=[  110]
  write: IOPS=78.8k, BW=308MiB/s (323MB/s)(4000MiB/12997msec); 0 zone resets
    slat (usec): min=3, max=439, avg=11.93, stdev= 9.13
    clat (nsec): min=691, max=1021.1k, avg=190729.24, stdev=42245.49
     lat (usec): min=7, max=1196, avg=202.74, stdev=43.94
    clat percentiles (usec):
     |  1.00th=[  126],  5.00th=[  143], 10.00th=[  151], 20.00th=[  163],
     | 30.00th=[  172], 40.00th=[  180], 50.00th=[  188], 60.00th=[  194],
     | 70.00th=[  202], 80.00th=[  208], 90.00th=[  219], 95.00th=[  255],
     | 99.00th=[  355], 99.50th=[  367], 99.90th=[  519], 99.95th=[  586],
     | 99.99th=[  693]
   bw (  KiB/s): min=261816, max=365464, per=99.98%, avg=315076.92, stdev=31029.00, samples=26
   iops        : min=65454, max=91366, avg=78769.23, stdev=7757.25, samples=26
  lat (nsec)   : 750=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=4.08%, 100=34.65%
  lat (usec)   : 250=58.18%, 500=3.02%, 750=0.07%, 1000=0.01%
  lat (msec)   : 2=0.01%
  cpu          : usr=23.78%, sys=74.14%, ctx=3225, majf=0, minf=15191
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647342,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1138MiB/s (1193MB/s), 1138MiB/s-1138MiB/s (1193MB/s-1193MB/s), io=2529MiB (2652MB), run=2222-2222msec
  WRITE: bw=308MiB/s (323MB/s), 308MiB/s-308MiB/s (323MB/s-323MB/s), io=4000MiB (4194MB), run=12997-12997msec

Disk stats (read/write):
  nullb0: ios=623488/1024000, merge=0/0, ticks=565/1518, in_queue=2082, util=99.36%
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on /mnt/nullb0 on Tue Nov 29 11:42:22 2022
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 4b42ba06-00a0-4c88-9a51-1626adbce878
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext4 (rw,relatime,seclabel)
[ 2427.057182] EXT4-fs (nullb0): unmounting filesystem.
[ 2427.079726] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][75.0%][r=1133MiB/s][r=290k IOPS][eta 00m:04s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=33475: Tue Nov 29 11:42:50 2022
  read: IOPS=289k, BW=1129MiB/s (1184MB/s)(2528MiB/2240msec)
    slat (nsec): min=1914, max=93848, avg=2394.61, stdev=533.46
    clat (nsec): min=1203, max=144454, avg=52202.30, stdev=2627.71
     lat (usec): min=3, max=146, avg=54.64, stdev= 2.69
    clat percentiles (usec):
     |  1.00th=[   50],  5.00th=[   50], 10.00th=[   51], 20.00th=[   51],
     | 30.00th=[   51], 40.00th=[   51], 50.00th=[   52], 60.00th=[   52],
     | 70.00th=[   52], 80.00th=[   53], 90.00th=[   57], 95.00th=[   59],
     | 99.00th=[   61], 99.50th=[   63], 99.90th=[   67], 99.95th=[   70],
     | 99.99th=[  105]
  write: IOPS=100k, BW=391MiB/s (410MB/s)(4000MiB/10229msec); 0 zone resets
    slat (usec): min=3, max=3675, avg= 9.36, stdev= 8.20
    clat (nsec): min=922, max=7011.3k, avg=150140.47, stdev=36842.61
     lat (usec): min=11, max=7022, avg=159.55, stdev=38.40
    clat percentiles (usec):
     |  1.00th=[  114],  5.00th=[  123], 10.00th=[  128], 20.00th=[  135],
     | 30.00th=[  141], 40.00th=[  145], 50.00th=[  149], 60.00th=[  153],
     | 70.00th=[  157], 80.00th=[  163], 90.00th=[  172], 95.00th=[  180],
     | 99.00th=[  210], 99.50th=[  235], 99.90th=[  293], 99.95th=[  351],
     | 99.99th=[  498]
   bw (  KiB/s): min=200472, max=448840, per=97.42%, avg=390094.86, stdev=52556.93, samples=21
   iops        : min=50118, max=112210, avg=97523.81, stdev=13139.30, samples=21
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=1.31%, 100=37.43%
  lat (usec)   : 250=61.08%, 500=0.18%, 750=0.01%
  lat (msec)   : 4=0.01%, 10=0.01%
  cpu          : usr=27.58%, sys=72.25%, ctx=28, majf=0, minf=15187
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647247,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1129MiB/s (1184MB/s), 1129MiB/s-1129MiB/s (1184MB/s-1184MB/s), io=2528MiB (2651MB), run=2240-2240msec
  WRITE: bw=391MiB/s (410MB/s), 391MiB/s-391MiB/s (410MB/s-410MB/s), io=4000MiB (4194MB), run=10229-10229msec

Disk stats (read/write):
  nullb0: ios=625624/1024236, merge=0/5772, ticks=563/1615, in_queue=2178, util=99.26%







-- 
2.29.0

