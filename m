Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E931162A23A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiKOTxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiKOTxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:53:21 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB30C62D6;
        Tue, 15 Nov 2022 11:53:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua1IJO4joYYlbf0owp0S7r9E61byRo1qQy1WH0guaNe9QWzhWTXViNyoyDahtFfcEeFjZShfm5HRZY5YLe3zbkWILV7pRLDQlP9fBdlivDVQBS50Pt02YkEAo9EVXSopAHttep+JBpHC9URqa5CzFPKq3ak8M8y3rMNjjG9RVw5vMCYTOL0f4VPV2cjFBgEIVEFSZR3m6F9M4HpI4eohC97HyjuOsMlYpj/erz08iDggdViMn+Bwshq38yDHgIh3r3qZH8vMmmaJpWD7zIpbEA9cBUMQ1QPvV5fR13vB7+SM/bW0pWy6TMI1mv3UIrka0l8mfD+mNFd6t4q6WVl+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91aKa3sMHdRTHm2xAB4cmgm8MvXkVDC4ni+IxPez2cY=;
 b=A47l4vluxBFJROqFWuhyBcBkaCzb/K4nRJiY2OKqGH8Kf5bccj2LoFEVcoCAtgvAy9DMCPacZyeWkpPokHlMuKcn1Xu9l1XxetM8nxxQt06Aug1zhxwS7vzdYxH7UhHX0ckaSmwe/UP4CnzNF5sq8Eidm+THYFmyeHdKFAHFPYs/UdZyUgA50wg00gTvNkRRvtuQGejUXcK6dTLghJp/2w8ucg0cIpTWN10Ad/XW1Hla8X/UhrmeTXjT2AXbYoTjq9Er5k1BxCnmiK9D1mQqBPDft6OoNBQOB9FIs7u+/nhsYpVm8U88jRYPwrk4v2NfXVe+pKl3dR9IsmFrXc0ONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91aKa3sMHdRTHm2xAB4cmgm8MvXkVDC4ni+IxPez2cY=;
 b=sJ9i25/NXlIeA/B6NuPFtGcM/YBQHjutP3WDmBaDyGldOlXTadrvjM4v0BvnsvIZQzV3RdzuBn6+VywLwyrgtHJLoYfPvkSirb5QlwxHYG14ngWJ1zjpZtQCRSZ5sGgNhR4Hmj9aXhMKryWzLOyMSgjM6+5ByW2fmaeb0O8OgAH/8woRYgh0+HXUNurbK/tez/ptPmdhXagXOA19zxduJl7CJvCM6P/7MoAWlThqU8b+b6UOmJfytQchUrQnXoe2YAQxN3qiHqF+bgpdNDFhURdLe1tfSMlsO4MtDfhg+lF3I4Hn+9nML+oZ2aztan75lvmenysA2nJF+ul3PdHb0g==
Received: from MW4PR03CA0177.namprd03.prod.outlook.com (2603:10b6:303:8d::32)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 19:53:15 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::e1) by MW4PR03CA0177.outlook.office365.com
 (2603:10b6:303:8d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 19:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Tue, 15 Nov 2022 19:53:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:53:00 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 15 Nov
 2022 11:52:59 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V3 0/7] null_blk: allow REQ_OP_WRITE_ZEROES and cleanup
Date:   Tue, 15 Nov 2022 11:52:46 -0800
Message-ID: <20221115195253.182484-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="a"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: ec571e70-eab2-4731-9a97-08dac74308bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7uqCofimkKdl2d5EuqwCQnpMKh8bWCsbKhtv3FDjTwyIT9AjMCF0yyyQNkX1GbW9NQ6YxkkH5L92pNmwM/i7eqH18wMMTWgRnAnT/t3z5N/TIo9Ujy37x88kWwvHEaNFa5psN/VOrUOTdRJWr8BDXNOf+CwV6W3yi7u5pc1/nqL1rNcOYG+mHc0RQ5FNbjS32CWks7tg7EkBlyroLSzHMmb5eEbcrwUpGBneDUGLNBskgxtPKoxsqPNSJXNXa4ntVDB1q1h8f3oFPuFSMg5OQ+I9cKP+4X8nuwqsf0AhTrLMxb6xn8ngXksmXWSgITQwXvbxtyQxLsBqhLz6YJuZzo6Ra7KH7NxpOiquXBLiyCJRmEKSN0SSgp/LXi36VSG4oFdd5Ejl/+HKCQW1QH4TS0JWvzDNKhEJgxSvqYR/jPFg2UAXZV6rCzcMdWuTZBCsbqK4n/k7YxJ8AL5YOZtyIfPurfr3RwEZgPYbyo5XpQ2lQcVbZTfXYRqG+n9a06UT+vohFl4Her3o52QMUABg0O8HPXLBSjjaZFX3BmSVAFBcR4cg8inR+pqGlZ7BS5F0GC0pQ7iDXbDetCE4paFhJ5RwBLL2uQV28WZ6uRch1hXgvzPq64knQBkWdjuwK9H25+jmcj/LZo0EZLFTAMUlFQnwp8Of74ZAh9roR25ibP1kFeOd6/9X4PHeSqnbCAMqfBApbe7zphSeFobGBSaF+Jr10E6inyVJHHkgyAVP19oaxlVvusPJW04vazRHWiizQvLq88dCVkHu+ExxU2NT0pPF5PpaKfcHhDUKbHHLrQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(2906002)(478600001)(36860700001)(4001150100001)(7416002)(8936002)(356005)(30864003)(83380400001)(40460700003)(1076003)(47076005)(336012)(2616005)(426003)(16526019)(54906003)(7636003)(316002)(110136005)(186003)(19627235002)(82310400005)(40480700001)(5660300002)(70586007)(82740400003)(4326008)(41300700001)(70206006)(8676002)(6666004)(7696005)(26005)(93036002)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 19:53:14.8032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec571e70-eab2-4731-9a97-08dac74308bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

v2->v3:-

1. Fix the commit log in patch 3. (Bart)
2. Fix the commit log in patch 4. (Bart)

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
5868a750b828 (HEAD -> for-next) null_blk: add param to set max write-zeroes sects
1dad765791bf null_blk: add param to set max disacrd sectors
28ff18cb23a0 null_blk: remove extra space in switch condition
574bbf59c69f null_blk: don't use magic numbers in the code
77fb0410ab98 null_blk: initialize cmd->bio in __alloc_cmd()
2f9c00f2e37c null_blk: code cleaup
da21346d4ec1 null_blk: allow REQ_OP_WRITE_ZEROES
c223decdb316 Merge branch 'for-next' of git://git.kernel.dk/linux-block into for-next
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
+ HOST_DEST=/lib/modules/6.1.0-rc3blk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/6.1.0-rc3blk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.1.0-rc3blk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.2M Nov 15 11:32 /lib/modules/6.1.0-rc3blk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
linux-block (for-next) # cd ../blktests/
blktests (master) # ./check block/
block/001 (stress device hotplugging)                        [passed]
    runtime  49.525s  ...  52.179s
block/002 (remove a device while running blktrace)           [passed]
    runtime  1.259s  ...  1.236s
block/006 (run null-blk in blocking mode)                    [passed]
    read iops  8698266  ...  8846254
    runtime    9.888s   ...  9.754s
block/007 => nullb1 (test classic and hybrid IO polling)     [passed]
    auto hybrid poll read iops       621194      ...  619725
    auto hybrid poll read lat mean   1.359473    ...  1.366760
    auto hybrid poll system cpu      73.634204%  ...  74.170616%
    classic poll read iops           598502      ...  595781
    classic poll read lat mean       1.418514    ...  1.409480
    classic poll system cpu          73.455378%  ...  68.109339%
    fixed hybrid poll read iops      618264      ...  611058
    fixed hybrid poll read lat mean  1.363924    ...  1.388329
    fixed hybrid poll system cpu     72.813239%  ...  75.000000%
    no poll read iops                606814      ...  650481
    no poll read lat mean            1.395035    ...  1.301867
    no poll system cpu               72.389791%  ...  76.616915%
    runtime                          2.532s      ...  2.507s
block/009 (check page-cache coherency after BLKDISCARD)      [passed]
    runtime  0.570s  ...  0.580s
block/010 (run I/O on null_blk with shared and non-shared tags) [passed]
    Individual tags read iops  7780737  ...  7903528
    runtime                    21.407s  ...  20.915s
    Shared tags read iops      7602680  ...  7854501
block/014 (run null-blk with blk-mq and timeout injection configured) [passed]
    runtime  54.296s  ...  49.470s
block/015 (run null-blk on different schedulers with requeue injection configured) [passed]
    runtime  44.127s  ...  45.185s
block/016 (send a signal to a process waiting on a frozen queue) [passed]
    runtime  7.080s  ...  7.081s
block/017 (do I/O and check the inflight counter)            [passed]
    runtime  1.681s  ...  1.690s
block/018 (do I/O and check iostats times)                   [passed]
    runtime  5.112s  ...  5.122s
block/020 (run null-blk on different schedulers with only one hardware tag) [passed]
    runtime  41.557s  ...  41.539s
block/021 (read/write nr_requests on null-blk with different schedulers) [passed]
    runtime  5.846s  ...  5.477s
block/022 (Test hang caused by freeze/unfreeze sequence)     [passed]
    runtime  30.121s  ...  30.181s
block/023 (do I/O on all null_blk queue modes)               [passed]
    runtime  0.266s  ...  0.252s
block/024 (do I/O faster than a jiffy and check iostats times) [passed]
    runtime  2.642s  ...  2.655s
block/025 (do a huge discard with 4k sector size)            [passed]
    runtime  3.934s  ...  3.938s
block/027 (stress device hotplugging with running fio jobs and different schedulers) [passed]
    runtime  18.416s  ...  18.700s
block/028 (do I/O on scsi_debug with DIF/DIX enabled)        [passed]
    runtime  13.616s  ...  13.438s
block/029 (trigger blk_mq_update_nr_hw_queues())             [failed]
    runtime  30.284s  ...  30.287s
    --- tests/block/029.out	2022-07-18 16:14:37.196230036 -0700
    +++ /root/blktests/results/nodev/block/029.out.bad	2022-11-15 11:38:15.571089141 -0800
    @@ -1 +1,127 @@
    +tests/block/029: line 24: echo: write error: Cannot allocate memory
    +tests/block/029: line 24: echo: write error: Cannot allocate memory
    +tests/block/029: line 24: echo: write error: Cannot allocate memory
    +tests/block/029: line 24: echo: write error: Cannot allocate memory
    +tests/block/029: line 24: echo: write error: Cannot allocate memory
    +tests/block/029: line 24: echo: write error: Cannot allocate memory
    +tests/block/029: line 24: echo: write error: Cannot allocate memory
    ...
    (Run 'diff -u tests/block/029.out /root/blktests/results/nodev/block/029.out.bad' to see the entire diff)
block/030 (trigger the blk_mq_realloc_hw_ctxs() error path)  [failed]
    runtime  2.192s  ...  3.057s
    --- tests/block/030.out	2022-07-18 16:14:37.196230036 -0700
    +++ /root/blktests/results/nodev/block/030.out.bad	2022-11-15 11:38:18.687161284 -0800
    @@ -1 +1,101 @@
    +tests/block/030: line 44: echo: write error: Cannot allocate memory
    +tests/block/030: line 44: echo: write error: Cannot allocate memory
    +tests/block/030: line 44: echo: write error: Cannot allocate memory
    +tests/block/030: line 44: echo: write error: Cannot allocate memory
    +tests/block/030: line 44: echo: write error: Cannot allocate memory
    +tests/block/030: line 44: echo: write error: Cannot allocate memory
    +tests/block/030: line 44: echo: write error: Cannot allocate memory
    ...
    (Run 'diff -u tests/block/030.out /root/blktests/results/nodev/block/030.out.bad' to see the entire diff)
block/031 (do IO on null-blk with a host tag set)            [passed]
    runtime  30.334s  ...  30.334s
blktests (master) # ls
check   CONTRIBUTING.md  LICENSES                        Makefile  nvme1n1    results  tests
common  Documentation    local-block-031-0-verify.state  new       README.md  src
blktests (master) # 
blktests (master) # 
blktests (master) # cd -
/root/linux-block
linux-block (for-next) # lsmod | grep null
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
ODD:- 
19+1 records in
19+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.001324 s, 7.6 MB/s
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
10002 bytes (10 kB, 9.8 KiB) copied, 0.000401131 s, 24.9 MB/s
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
Filesystem UUID: fb802f1b-5d92-487b-9ebd-e936a5952f44
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext2 (rw,relatime,seclabel)
[66860.364528] null_blk: disk nullb0 created
[66861.496865] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[66861.497385] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][80.0%][r=1083MiB/s][r=277k IOPS][eta 00m:04s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=181274: Tue Nov 15 11:40:08 2022
  read: IOPS=272k, BW=1064MiB/s (1115MB/s)(2529MiB/2378msec)
    slat (nsec): min=2154, max=158802, avg=2591.49, stdev=736.38
    clat (nsec): min=1313, max=238742, avg=55360.06, stdev=6883.70
     lat (usec): min=3, max=241, avg=58.00, stdev= 7.17
    clat percentiles (usec):
     |  1.00th=[   52],  5.00th=[   53], 10.00th=[   53], 20.00th=[   53],
     | 30.00th=[   54], 40.00th=[   54], 50.00th=[   55], 60.00th=[   55],
     | 70.00th=[   55], 80.00th=[   56], 90.00th=[   59], 95.00th=[   62],
     | 99.00th=[  104], 99.50th=[  105], 99.90th=[  118], 99.95th=[  120],
     | 99.99th=[  188]
  write: IOPS=74.8k, BW=292MiB/s (306MB/s)(4000MiB/13688msec); 0 zone resets
    slat (usec): min=3, max=538, avg=12.66, stdev= 9.63
    clat (nsec): min=801, max=1015.1k, avg=200837.48, stdev=44069.44
     lat (usec): min=7, max=1077, avg=213.56, stdev=45.83
    clat percentiles (usec):
     |  1.00th=[  137],  5.00th=[  153], 10.00th=[  161], 20.00th=[  174],
     | 30.00th=[  182], 40.00th=[  190], 50.00th=[  196], 60.00th=[  204],
     | 70.00th=[  210], 80.00th=[  217], 90.00th=[  227], 95.00th=[  285],
     | 99.00th=[  371], 99.50th=[  388], 99.90th=[  553], 99.95th=[  619],
     | 99.99th=[  709]
   bw (  KiB/s): min=123440, max=351160, per=97.76%, avg=292548.86, stdev=41626.13, samples=28
   iops        : min=30860, max=87790, avg=73137.21, stdev=10406.53, samples=28
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=38.28%
  lat (usec)   : 250=58.26%, 500=3.35%, 750=0.10%, 1000=0.01%
  lat (msec)   : 2=0.01%
  cpu          : usr=23.45%, sys=74.46%, ctx=3377, majf=0, minf=15192
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647428,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1064MiB/s (1115MB/s), 1064MiB/s-1064MiB/s (1115MB/s-1115MB/s), io=2529MiB (2652MB), run=2378-2378msec
  WRITE: bw=292MiB/s (306MB/s), 292MiB/s-292MiB/s (306MB/s-306MB/s), io=4000MiB (4194MB), run=13688-13688msec

Disk stats (read/write):
  nullb0: ios=598210/1024000, merge=0/0, ticks=674/1775, in_queue=2448, util=99.41%
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on /mnt/nullb0 on Tue Nov 15 11:39:52 2022
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 14eefd9e-aef7-4500-b5ef-f3fea6f1e126
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext4 (rw,relatime,seclabel)
[66877.927718] EXT4-fs (nullb0): unmounting filesystem.
[66877.956419] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][70.6%][r=1075MiB/s][r=275k IOPS][eta 00m:05s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=181294: Tue Nov 15 11:40:21 2022
  read: IOPS=275k, BW=1075MiB/s (1127MB/s)(2528MiB/2352msec)
    slat (nsec): min=2154, max=55936, avg=2582.05, stdev=492.16
    clat (nsec): min=1112, max=117372, avg=54781.62, stdev=2453.47
     lat (usec): min=3, max=119, avg=57.41, stdev= 2.52
    clat percentiles (nsec):
     |  1.00th=[51968],  5.00th=[52480], 10.00th=[52992], 20.00th=[53504],
     | 30.00th=[53504], 40.00th=[54016], 50.00th=[54016], 60.00th=[54528],
     | 70.00th=[55040], 80.00th=[55552], 90.00th=[57600], 95.00th=[60672],
     | 99.00th=[63232], 99.50th=[64768], 99.90th=[69120], 99.95th=[71168],
     | 99.99th=[86528]
  write: IOPS=98.2k, BW=384MiB/s (402MB/s)(4000MiB/10423msec); 0 zone resets
    slat (usec): min=3, max=4111, avg= 9.54, stdev= 9.29
    clat (nsec): min=892, max=4287.6k, avg=152969.66, stdev=37959.01
     lat (usec): min=8, max=4294, avg=162.57, stdev=39.33
    clat percentiles (usec):
     |  1.00th=[  119],  5.00th=[  128], 10.00th=[  133], 20.00th=[  139],
     | 30.00th=[  145], 40.00th=[  149], 50.00th=[  153], 60.00th=[  157],
     | 70.00th=[  161], 80.00th=[  165], 90.00th=[  172], 95.00th=[  180],
     | 99.00th=[  204], 99.50th=[  219], 99.90th=[  281], 99.95th=[  437],
     | 99.99th=[  603]
   bw (  KiB/s): min=350488, max=433056, per=99.27%, avg=390095.24, stdev=25613.79, samples=21
   iops        : min=87622, max=108264, avg=97523.81, stdev=6403.43, samples=21
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=38.73%
  lat (usec)   : 250=61.09%, 500=0.15%, 750=0.02%
  lat (msec)   : 4=0.01%, 10=0.01%
  cpu          : usr=27.73%, sys=72.09%, ctx=37, majf=0, minf=15189
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647282,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1075MiB/s (1127MB/s), 1075MiB/s-1075MiB/s (1127MB/s-1127MB/s), io=2528MiB (2651MB), run=2352-2352msec
  WRITE: bw=384MiB/s (402MB/s), 384MiB/s-384MiB/s (402MB/s-402MB/s), io=4000MiB (4194MB), run=10423-10423msec

Disk stats (read/write):
  nullb0: ios=611304/1024241, merge=0/5921, ticks=676/1838, in_queue=2514, util=99.29%




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
ODD:- 
9+1 records in
9+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.000408326 s, 24.5 MB/s
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
10002 bytes (10 kB, 9.8 KiB) copied, 0.000351117 s, 28.5 MB/s
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
Filesystem UUID: 535605e4-52bf-41d8-9695-198f156dd440
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext2 (rw,relatime,seclabel)
[66891.591141] null_blk: disk nullb0 created
[66892.708280] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[66892.708830] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][75.0%][r=1135MiB/s][r=291k IOPS][eta 00m:05s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=181405: Tue Nov 15 11:40:39 2022
  read: IOPS=289k, BW=1130MiB/s (1185MB/s)(2530MiB/2238msec)
    slat (nsec): min=2004, max=87557, avg=2412.56, stdev=493.35
    clat (nsec): min=1383, max=261085, avg=52107.29, stdev=2767.75
     lat (usec): min=3, max=266, avg=54.57, stdev= 2.85
    clat percentiles (usec):
     |  1.00th=[   50],  5.00th=[   50], 10.00th=[   51], 20.00th=[   51],
     | 30.00th=[   51], 40.00th=[   51], 50.00th=[   52], 60.00th=[   52],
     | 70.00th=[   52], 80.00th=[   53], 90.00th=[   56], 95.00th=[   59],
     | 99.00th=[   62], 99.50th=[   65], 99.90th=[   70], 99.95th=[   76],
     | 99.99th=[  110]
  write: IOPS=77.1k, BW=301MiB/s (316MB/s)(4000MiB/13285msec); 0 zone resets
    slat (usec): min=3, max=439, avg=12.25, stdev= 9.62
    clat (nsec): min=691, max=966015, avg=194939.47, stdev=42572.14
     lat (usec): min=7, max=1328, avg=207.26, stdev=44.18
    clat percentiles (usec):
     |  1.00th=[  135],  5.00th=[  151], 10.00th=[  159], 20.00th=[  169],
     | 30.00th=[  178], 40.00th=[  184], 50.00th=[  190], 60.00th=[  196],
     | 70.00th=[  202], 80.00th=[  208], 90.00th=[  219], 95.00th=[  285],
     | 99.00th=[  363], 99.50th=[  375], 99.90th=[  545], 99.95th=[  594],
     | 99.99th=[  693]
   bw (  KiB/s): min=188448, max=339888, per=98.41%, avg=303407.41, stdev=31231.18, samples=27
   iops        : min=47112, max=84972, avg=75851.85, stdev=7807.79, samples=27
  lat (nsec)   : 750=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=1.12%, 100=37.62%
  lat (usec)   : 250=58.02%, 500=3.14%, 750=0.10%, 1000=0.01%
  cpu          : usr=23.84%, sys=73.97%, ctx=3272, majf=0, minf=15197
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647639,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1130MiB/s (1185MB/s), 1130MiB/s-1130MiB/s (1185MB/s-1185MB/s), io=2530MiB (2653MB), run=2238-2238msec
  WRITE: bw=301MiB/s (316MB/s), 301MiB/s-301MiB/s (316MB/s-316MB/s), io=4000MiB (4194MB), run=13285-13285msec

Disk stats (read/write):
  nullb0: ios=607879/1024000, merge=0/0, ticks=609/1640, in_queue=2250, util=99.37%
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on /mnt/nullb0 on Tue Nov 15 11:40:23 2022
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: c1a58ae3-4c3c-4707-9413-249ec935e0a0
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext4 (rw,relatime,seclabel)
[66908.577976] EXT4-fs (nullb0): unmounting filesystem.
[66908.604562] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=0): [f(1)][100.0%][r=1071MiB/s][r=274k IOPS][eta 00m:00s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=181431: Tue Nov 15 11:40:52 2022
  read: IOPS=283k, BW=1104MiB/s (1158MB/s)(2526MiB/2288msec)
    slat (nsec): min=2064, max=55737, avg=2477.85, stdev=522.77
    clat (nsec): min=1113, max=115029, avg=53321.61, stdev=2517.96
     lat (usec): min=3, max=117, avg=55.84, stdev= 2.58
    clat percentiles (usec):
     |  1.00th=[   51],  5.00th=[   52], 10.00th=[   52], 20.00th=[   52],
     | 30.00th=[   52], 40.00th=[   53], 50.00th=[   53], 60.00th=[   53],
     | 70.00th=[   53], 80.00th=[   54], 90.00th=[   58], 95.00th=[   60],
     | 99.00th=[   62], 99.50th=[   63], 99.90th=[   71], 99.95th=[   75],
     | 99.99th=[  101]
  write: IOPS=96.9k, BW=378MiB/s (397MB/s)(4000MiB/10570msec); 0 zone resets
    slat (usec): min=3, max=4143, avg= 9.69, stdev= 9.14
    clat (nsec): min=902, max=8152.9k, avg=155134.15, stdev=42347.61
     lat (usec): min=6, max=8165, avg=164.88, stdev=43.97
    clat percentiles (usec):
     |  1.00th=[  119],  5.00th=[  128], 10.00th=[  135], 20.00th=[  141],
     | 30.00th=[  145], 40.00th=[  151], 50.00th=[  155], 60.00th=[  157],
     | 70.00th=[  163], 80.00th=[  167], 90.00th=[  176], 95.00th=[  184],
     | 99.00th=[  215], 99.50th=[  243], 99.90th=[  330], 99.95th=[  408],
     | 99.99th=[  482]
   bw (  KiB/s): min=51824, max=440064, per=96.09%, avg=372363.64, stdev=75777.57, samples=22
   iops        : min=12954, max=110018, avg=93090.91, stdev=18944.88, samples=22
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=0.01%, 100=38.70%
  lat (usec)   : 250=61.04%, 500=0.25%, 750=0.01%
  lat (msec)   : 4=0.01%, 10=0.01%
  cpu          : usr=27.04%, sys=72.74%, ctx=327, majf=0, minf=15177
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=646761,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1104MiB/s (1158MB/s), 1104MiB/s-1104MiB/s (1158MB/s-1158MB/s), io=2526MiB (2649MB), run=2288-2288msec
  WRITE: bw=378MiB/s (397MB/s), 378MiB/s-378MiB/s (397MB/s-397MB/s), io=4000MiB (4194MB), run=10570-10570msec

Disk stats (read/write):
  nullb0: ios=585939/1024234, merge=0/5702, ticks=587/1738, in_queue=2325, util=99.31%




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
ODD:- 
4+1 records in
4+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.000362418 s, 27.6 MB/s
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
10002 bytes (10 kB, 9.8 KiB) copied, 0.000310148 s, 32.2 MB/s
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
Filesystem UUID: 52d082f5-badf-4ed4-8a01-32e24ae621b1
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext2 (rw,relatime,seclabel)
[66922.293478] null_blk: disk nullb0 created
[66923.411765] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[66923.412345] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][71.4%][r=1143MiB/s][r=293k IOPS][eta 00m:06s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=181524: Tue Nov 15 11:41:10 2022
  read: IOPS=294k, BW=1150MiB/s (1206MB/s)(2531MiB/2200msec)
    slat (nsec): min=1914, max=94730, avg=2331.47, stdev=563.62
    clat (nsec): min=1102, max=167378, avg=51209.99, stdev=3492.57
     lat (usec): min=3, max=172, avg=53.59, stdev= 3.61
    clat percentiles (usec):
     |  1.00th=[   49],  5.00th=[   49], 10.00th=[   50], 20.00th=[   50],
     | 30.00th=[   50], 40.00th=[   50], 50.00th=[   51], 60.00th=[   51],
     | 70.00th=[   51], 80.00th=[   52], 90.00th=[   56], 95.00th=[   58],
     | 99.00th=[   65], 99.50th=[   72], 99.90th=[   88], 99.95th=[   95],
     | 99.99th=[  108]
  write: IOPS=75.3k, BW=294MiB/s (309MB/s)(4000MiB/13590msec); 0 zone resets
    slat (usec): min=3, max=524, avg=12.54, stdev= 9.34
    clat (nsec): min=821, max=1017.9k, avg=199408.01, stdev=44731.27
     lat (usec): min=6, max=1250, avg=212.02, stdev=46.63
    clat percentiles (usec):
     |  1.00th=[  135],  5.00th=[  149], 10.00th=[  159], 20.00th=[  172],
     | 30.00th=[  180], 40.00th=[  188], 50.00th=[  196], 60.00th=[  202],
     | 70.00th=[  208], 80.00th=[  217], 90.00th=[  231], 95.00th=[  281],
     | 99.00th=[  375], 99.50th=[  408], 99.90th=[  553], 99.95th=[  619],
     | 99.99th=[  725]
   bw (  KiB/s): min=58240, max=361120, per=97.07%, avg=292571.14, stdev=54664.73, samples=28
   iops        : min=14560, max=90280, avg=73142.86, stdev=13666.23, samples=28
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=14.75%, 100=24.00%
  lat (usec)   : 250=57.42%, 500=3.73%, 750=0.11%, 1000=0.01%
  lat (msec)   : 2=0.01%
  cpu          : usr=23.75%, sys=74.27%, ctx=3340, majf=0, minf=15201
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647840,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1150MiB/s (1206MB/s), 1150MiB/s-1150MiB/s (1206MB/s-1206MB/s), io=2531MiB (2654MB), run=2200-2200msec
  WRITE: bw=294MiB/s (309MB/s), 294MiB/s-294MiB/s (309MB/s-309MB/s), io=4000MiB (4194MB), run=13590-13590msec

Disk stats (read/write):
  nullb0: ios=601631/1024000, merge=0/0, ticks=544/1629, in_queue=2173, util=99.38%
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on /mnt/nullb0 on Tue Nov 15 11:40:53 2022
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: 2bea2344-e903-42fb-bea3-5812319229ac
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext4 (rw,relatime,seclabel)
[66939.549992] EXT4-fs (nullb0): unmounting filesystem.
[66939.572566] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][75.0%][r=1138MiB/s][r=291k IOPS][eta 00m:04s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=181545: Tue Nov 15 11:41:22 2022
  read: IOPS=291k, BW=1137MiB/s (1192MB/s)(2528MiB/2223msec)
    slat (nsec): min=1924, max=102094, avg=2374.71, stdev=533.20
    clat (nsec): min=1503, max=433523, avg=51807.71, stdev=3883.92
     lat (usec): min=3, max=435, avg=54.23, stdev= 3.99
    clat percentiles (usec):
     |  1.00th=[   50],  5.00th=[   50], 10.00th=[   50], 20.00th=[   51],
     | 30.00th=[   51], 40.00th=[   51], 50.00th=[   51], 60.00th=[   52],
     | 70.00th=[   52], 80.00th=[   52], 90.00th=[   55], 95.00th=[   58],
     | 99.00th=[   62], 99.50th=[   68], 99.90th=[   96], 99.95th=[  104],
     | 99.99th=[  131]
  write: IOPS=99.0k, BW=387MiB/s (406MB/s)(4000MiB/10340msec); 0 zone resets
    slat (usec): min=3, max=3807, avg= 9.47, stdev= 9.02
    clat (nsec): min=882, max=6505.2k, avg=151752.51, stdev=38984.09
     lat (usec): min=12, max=6587, avg=161.28, stdev=40.70
    clat percentiles (usec):
     |  1.00th=[  117],  5.00th=[  126], 10.00th=[  133], 20.00th=[  139],
     | 30.00th=[  143], 40.00th=[  147], 50.00th=[  151], 60.00th=[  155],
     | 70.00th=[  159], 80.00th=[  163], 90.00th=[  172], 95.00th=[  178],
     | 99.00th=[  202], 99.50th=[  215], 99.90th=[  277], 99.95th=[  334],
     | 99.99th=[  416]
   bw (  KiB/s): min=295752, max=434984, per=98.48%, avg=390095.24, stdev=30689.19, samples=21
   iops        : min=73938, max=108746, avg=97523.81, stdev=7672.30, samples=21
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=4.43%, 100=34.28%
  lat (usec)   : 250=61.16%, 500=0.13%
  lat (msec)   : 4=0.01%, 10=0.01%
  cpu          : usr=27.09%, sys=72.66%, ctx=449, majf=0, minf=15187
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647098,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1137MiB/s (1192MB/s), 1137MiB/s-1137MiB/s (1192MB/s-1192MB/s), io=2528MiB (2651MB), run=2223-2223msec
  WRITE: bw=387MiB/s (406MB/s), 387MiB/s-387MiB/s (406MB/s-406MB/s), io=4000MiB (4194MB), run=10340-10340msec

Disk stats (read/write):
  nullb0: ios=598120/1024237, merge=0/5791, ticks=540/1647, in_queue=2186, util=99.27%




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
ODD:- 
2+1 records in
2+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.000394609 s, 25.3 MB/s
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
10002 bytes (10 kB, 9.8 KiB) copied, 0.000231178 s, 43.3 MB/s
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
Filesystem UUID: 472150a1-06d4-43bb-9ec8-f9855439ef51
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext2 (rw,relatime,seclabel)
[66952.985308] null_blk: disk nullb0 created
[66954.103807] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[66954.104413] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][78.9%][r=1164MiB/s][r=298k IOPS][eta 00m:04s]                   
write-and-verify: (groupid=0, jobs=1): err= 0: pid=181633: Tue Nov 15 11:41:40 2022
  read: IOPS=297k, BW=1161MiB/s (1217MB/s)(2528MiB/2178msec)
    slat (nsec): min=1963, max=68339, avg=2318.80, stdev=478.10
    clat (nsec): min=1392, max=154052, avg=50753.94, stdev=2410.44
     lat (usec): min=4, max=156, avg=53.12, stdev= 2.47
    clat percentiles (nsec):
     |  1.00th=[48384],  5.00th=[48896], 10.00th=[48896], 20.00th=[49408],
     | 30.00th=[49408], 40.00th=[49920], 50.00th=[49920], 60.00th=[50432],
     | 70.00th=[50432], 80.00th=[50944], 90.00th=[54528], 95.00th=[56576],
     | 99.00th=[58624], 99.50th=[60160], 99.90th=[64768], 99.95th=[67072],
     | 99.99th=[84480]
  write: IOPS=78.4k, BW=306MiB/s (321MB/s)(4000MiB/13062msec); 0 zone resets
    slat (usec): min=3, max=459, avg=12.06, stdev= 9.33
    clat (nsec): min=781, max=878889, avg=191647.26, stdev=41358.52
     lat (usec): min=6, max=1256, avg=203.78, stdev=42.97
    clat percentiles (usec):
     |  1.00th=[  133],  5.00th=[  147], 10.00th=[  155], 20.00th=[  165],
     | 30.00th=[  174], 40.00th=[  182], 50.00th=[  188], 60.00th=[  194],
     | 70.00th=[  200], 80.00th=[  208], 90.00th=[  217], 95.00th=[  239],
     | 99.00th=[  355], 99.50th=[  371], 99.90th=[  529], 99.95th=[  586],
     | 99.99th=[  685]
   bw (  KiB/s): min=35760, max=361560, per=96.75%, avg=303382.70, stdev=59886.47, samples=27
   iops        : min= 8938, max=90392, avg=75845.67, stdev=14972.03, samples=27
  lat (nsec)   : 1000=0.01%
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=18.50%, 100=20.23%
  lat (usec)   : 250=58.30%, 500=2.90%, 750=0.08%, 1000=0.01%
  cpu          : usr=23.28%, sys=74.59%, ctx=3190, majf=0, minf=15184
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647124,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1161MiB/s (1217MB/s), 1161MiB/s-1161MiB/s (1217MB/s-1217MB/s), io=2528MiB (2651MB), run=2178-2178msec
  WRITE: bw=306MiB/s (321MB/s), 306MiB/s-306MiB/s (321MB/s-321MB/s), io=4000MiB (4194MB), run=13062-13062msec

Disk stats (read/write):
  nullb0: ios=616272/1024000, merge=0/0, ticks=547/1593, in_queue=2141, util=99.37%
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on /mnt/nullb0 on Tue Nov 15 11:41:24 2022
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: f17569a8-1b75-430a-97bb-4b4b8f23406a
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

/dev/nullb0 on /mnt/nullb0 type ext4 (rw,relatime,seclabel)
[66969.684331] EXT4-fs (nullb0): unmounting filesystem.
[66969.706596] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
write-and-verify: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=16
fio-3.27
Starting 1 process
write-and-verify: Laying out IO file (1 file / 4000MiB)
Jobs: 1 (f=1): [V(1)][75.0%][r=1143MiB/s][r=293k IOPS][eta 00m:04s]                  
write-and-verify: (groupid=0, jobs=1): err= 0: pid=181656: Tue Nov 15 11:41:53 2022
  read: IOPS=292k, BW=1141MiB/s (1196MB/s)(2530MiB/2218msec)
    slat (nsec): min=1943, max=59723, avg=2357.85, stdev=610.78
    clat (nsec): min=1122, max=126250, avg=51644.27, stdev=3519.72
     lat (usec): min=3, max=128, avg=54.05, stdev= 3.63
    clat percentiles (usec):
     |  1.00th=[   49],  5.00th=[   49], 10.00th=[   50], 20.00th=[   50],
     | 30.00th=[   50], 40.00th=[   51], 50.00th=[   51], 60.00th=[   51],
     | 70.00th=[   52], 80.00th=[   52], 90.00th=[   57], 95.00th=[   59],
     | 99.00th=[   65], 99.50th=[   69], 99.90th=[   77], 99.95th=[   81],
     | 99.99th=[  109]
  write: IOPS=98.4k, BW=385MiB/s (403MB/s)(4000MiB/10403msec); 0 zone resets
    slat (usec): min=3, max=3347, avg= 9.53, stdev= 8.05
    clat (nsec): min=1182, max=3537.4k, avg=152680.35, stdev=33311.37
     lat (usec): min=13, max=3548, avg=162.27, stdev=34.53
    clat percentiles (usec):
     |  1.00th=[  119],  5.00th=[  128], 10.00th=[  133], 20.00th=[  139],
     | 30.00th=[  145], 40.00th=[  149], 50.00th=[  153], 60.00th=[  155],
     | 70.00th=[  159], 80.00th=[  165], 90.00th=[  172], 95.00th=[  180],
     | 99.00th=[  204], 99.50th=[  219], 99.90th=[  285], 99.95th=[  355],
     | 99.99th=[  474]
   bw (  KiB/s): min=349128, max=431920, per=99.08%, avg=390094.48, stdev=22615.43, samples=21
   iops        : min=87282, max=107980, avg=97523.81, stdev=5653.77, samples=21
  lat (usec)   : 2=0.01%, 10=0.01%, 20=0.01%, 50=11.55%, 100=27.19%
  lat (usec)   : 250=61.10%, 500=0.15%, 750=0.01%
  lat (msec)   : 4=0.01%
  cpu          : usr=28.99%, sys=70.86%, ctx=27, majf=0, minf=15197
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=100.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=647655,1024000,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=16

Run status group 0 (all jobs):
   READ: bw=1141MiB/s (1196MB/s), 1141MiB/s-1141MiB/s (1196MB/s-1196MB/s), io=2530MiB (2653MB), run=2218-2218msec
  WRITE: bw=385MiB/s (403MB/s), 385MiB/s-385MiB/s (403MB/s-403MB/s), io=4000MiB (4194MB), run=10403-10403msec

Disk stats (read/write):
  nullb0: ios=580338/1024235, merge=0/5744, ticks=513/1640, in_queue=2154, util=99.29%

-- 
2.29.0

