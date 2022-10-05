Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEE35F4E0B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJEDRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJEDRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:17:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E036FA1B;
        Tue,  4 Oct 2022 20:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQqRfd9MlSydamn9k6QXKwQ2H26XRa80QasIZhqqS8wXcWSzsYiRrNRHouOOQQ9TaJeuIUawehujxOF8TIP0wD3xfzMhg2HFswoeFS/JLJEJDV/oOV7V6Hzf7lJyercScNazGOEyAUq7xETFEs21oqNTy14f7ZQ9IRFUNgIJEpoVb7n8fIbrHRf354UqvQbTHa6ZutKAS78W+235Ay7jYeViiKEjX9pe/wx+raa/DnxpakoGskJW6TK9//B0AIwf6IdStgwtQoNXJgSiTlralIg9J0xJ8y3FAvLLHjutVvHxDz+xAW9bzyuZj0Af0Obk/uKz1OYNeGbEJiqkF7fmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp5xGb04xZ7qLPo6VKdPz6ePbVATtlA7+P0mzrdIpJU=;
 b=nMH8uO+a2EVeWXDhCU+xaUFZCxdodkr8HUoaVD9hctroPfeVBh51o1ZloKrJ2UCG+HAB8pGO9gNsPDxpivIgpZuw3ZlI5A0QXNeC5n05YKE6HV5rm+RiY/PqLcpLsXRasIDL99Q2sNY0v1n3ukFjKBOj5XaHcgEL1zrFvUKo0qx6dzIHmCPp+pqqrohYMzPp+LL/uhICX0NBP/sDgjQAWJR8cvnPAhf3xK597KKuEw2YlgMwOxyAQMWcmEPnJUQYjAQ0HbQ0GdVR44I+Dk1dS8J9Zjll+VaFu0st48Mq2rtae0ZT7i4NFj8K5uOdUQqJtjl2fvhhB0qk3WgcUzOGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp5xGb04xZ7qLPo6VKdPz6ePbVATtlA7+P0mzrdIpJU=;
 b=DFo4JPfqRsn8pf01Eim2Mj9kUCD2bxpufB7mxZshIPCLXKep6+5/6A2KpKkd7RcZ69qLQh1sMudMJR2uj5+5/CKNXzH1LNvfIG7E+iPkHPViGAWyw8S3rc4iCADqxNlfl3IRnNkYSaMCRe1Bk+0gVe+F05I2V9v/+VPdlqGZSJ43weCVq5kmzh7Y3v1Gd7TmatCY+OStAuj34by7zw5Eo0XK5S8YvtF/McA8ZA9l0sTX0ni8WIETjs0A5oZgAJFUbHopRmiEzkGRoD7LnbnB92pyUuFLCMzNyNAMCOJ2VVlBffRQl8U6VrVro+WBvcL9Cmr0AUTYRPvl8BdDHT3TYA==
Received: from MW3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:303:2b::16)
 by MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:17:14 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::72) by MW3PR05CA0011.outlook.office365.com
 (2603:10b6:303:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.7 via Frontend
 Transport; Wed, 5 Oct 2022 03:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:17:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:17:09 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:17:08 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 0/6] null_blk: allow REQ_OP_WRITE_ZEROES and cleanup
Date:   Tue, 4 Oct 2022 20:16:55 -0700
Message-ID: <20221005031701.79077-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|MN2PR12MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e1e723-0812-4321-d537-08daa6801999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHcWwaiFE827ge6AAbmNd/vZG1f0VXH1kGh5THUk8eTmpv0wXNL5wnFvPivggz8IRYLEdahxrhrXHw3QGcpHFQ55l0/yNpjNAAoWa7zpSHBNTaUR6XVA4h0C/IHNNGlCHl819ed9RKzbI3uEXeoep/eY3OaywkSpqdoaMhWw8Ry9vww/i8VaPGMBhT3wXy3WFuJKKKoD/eN+4weSXDcUIReFNCLHATNDdCtF++ryoamGjt7xlLSJmouDEeIBgVD5jD8n2L37zHLLb0gFkGwvPESlzbV9AXkfzP3dKF9xedSum+NV/pW9VKpzfiIQDCf9fUXEy9s3Vj7Yz2uzpbgDvSR5Mhxo7hVEhvi5KCySDYVj7luNo4vvQI/ntceEeCMhM0hF5OdVnG1XkaJjlcw5dteoRmVwO4wwRpnIFpPpTIJ4xhw5k64F6FNjCZTNAnD9zeCvSUeUdADpGem9QtZTdVtE5yeN/sZ2VWXznNw2CmwPyXYJrKumyTa+B9mQUWcmdKJEwy1BkQDNnGNNPrf0kTVTVrRBQO67NczYEBhMSAIl51AWOplDPbACjuIHbN4LUud9rx3htJHYNrxjvvq1ixg8vdvB/hFHZHIyFzFXIElJhqzzee10ZHDiMcRgIWR0rM4HWqXnMu4TUpf5iFuvYHmAuQGUdG5IQ80XtFoYLoJvsDjibpkNl3AE6bLOllidJpmqSKrCv6aLZVkqZu9m9FNMZRX2qH2rj652hw6qSDSB3ejq1cWMuqfNvNieVKIvsNxOEar77Czor62jll1cTg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(26005)(7696005)(6666004)(478600001)(2616005)(1076003)(70586007)(186003)(54906003)(40480700001)(82310400005)(41300700001)(2906002)(40460700003)(5660300002)(7416002)(7636003)(356005)(316002)(30864003)(4326008)(8936002)(110136005)(36756003)(8676002)(36860700001)(70206006)(16526019)(82740400003)(47076005)(336012)(83380400001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:17:14.0945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e1e723-0812-4321-d537-08daa6801999
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
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

Chaitanya Kulkarni (6):
  null_blk: allow write zeores on non-membacked
  null_blk: allow write zeores on membacked
  null_blk: code cleaup
  null_blk: initialize cmd->bio in __alloc_cmd()
  null_blk: don't use magic numbers in the code
  null_blk: remove extra space in switch condition

 drivers/block/null_blk/main.c     | 131 ++++++++++++++++++++++--------
 drivers/block/null_blk/null_blk.h |   1 +
 2 files changed, 97 insertions(+), 35 deletions(-)

1. Write Zeroes test with ext2/ext3 for memory backed :-
linux-block (for-next) # mkfs.ext2 /dev/nullb0 
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 262144 4k blocks and 65536 inodes
Filesystem UUID: 76037c2c-9c32-4ac6-b1d6-d1f62e6071ad
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376

Allocating group tables: done                            
Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done

linux-block (for-next) # mount /dev/nullb0 /mnt/
backend/ data/    nullb0/  nvme1n1/ test/    
linux-block (for-next) # mount /dev/nullb0 /mnt/nullb0/
linux-block (for-next) # dmesg  -c 
[18833.072830] null_blk: null_handle_write_zeroes 1225 2097024 128
[18833.072963] null_blk: null_handle_write_zeroes 1225 536 4096
[18833.073439] null_blk: null_handle_write_zeroes 1225 262680 4096
[18833.073845] null_blk: null_handle_write_zeroes 1225 524304 4096
[18833.074202] null_blk: null_handle_write_zeroes 1225 786968 4096
[18833.074581] null_blk: null_handle_write_zeroes 1225 1048592 4096
[18833.074951] null_blk: null_handle_write_zeroes 1225 1311256 4096
[18833.075381] null_blk: null_handle_write_zeroes 1225 1572880 4096
[18833.075748] null_blk: null_handle_write_zeroes 1225 1835544 4096
[18833.076164] null_blk: null_handle_write_zeroes 1225 4672 8
[18844.752019] EXT4-fs (nullb0): mounting ext2 file system using the ext4 subsystem
[18844.752487] EXT4-fs (nullb0): mounted filesystem without journal. Quota mode: none.
linux-block (for-next) # 


linux-block (for-next) # mkfs.ext4 /dev/nullb0 
mke2fs 1.45.6 (20-Mar-2020)
/dev/nullb0 contains a ext2 file system
	last mounted on Mon Oct  3 18:28:05 2022
Proceed anyway? (y,N) y
Creating filesystem with 262144 4k blocks and 65536 inodes
Filesystem UUID: a4c66d5f-bda9-4f58-aa03-911b87bb5c7d
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done

linux-block (for-next) # mount /dev/nullb0 /mnt/nullb0/
linux-block (for-next) # dmesg  -c 
[18882.721160] EXT4-fs (nullb0): unmounting filesystem.
[18888.687070] null_blk: null_handle_write_zeroes 1225 2097024 128
[18888.687159] null_blk: null_handle_write_zeroes 1225 1160 8
[18888.687309] null_blk: null_handle_write_zeroes 1225 33968 8
[18888.687839] null_blk: null_handle_write_zeroes 1225 1048576 65536
[18892.105964] EXT4-fs (nullb0): mounted filesystem with ordered data mode. Quota mode: none.
linux-block (for-next) # 

2. Test blkdiscard with -z for different block sizes :-

linux-block (for-next) # ./zeroout.sh 
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
├── max_sectors
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

0 directories, 29 files
ODD:- 
19+1 records in
19+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.000521991 s, 19.2 MB/s
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
10002 bytes (10 kB, 9.8 KiB) copied, 0.000376636 s, 26.6 MB/s
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
├── max_sectors
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

0 directories, 29 files
ODD:- 
9+1 records in
9+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.00040033 s, 25.0 MB/s
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
10002 bytes (10 kB, 9.8 KiB) copied, 0.000325488 s, 30.7 MB/s
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
├── max_sectors
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

0 directories, 29 files
ODD:- 
4+1 records in
4+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.000367949 s, 27.2 MB/s
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
10002 bytes (10 kB, 9.8 KiB) copied, 0.000310981 s, 32.2 MB/s
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
├── max_sectors
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

0 directories, 29 files
ODD:- 
2+1 records in
2+1 records out
10002 bytes (10 kB, 9.8 KiB) copied, 0.00028502 s, 35.1 MB/s
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
10002 bytes (10 kB, 9.8 KiB) copied, 0.00024765 s, 40.4 MB/s
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




