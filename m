Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36DC5FFD54
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 07:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJPFUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 01:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJPFUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 01:20:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C51B2FFF7;
        Sat, 15 Oct 2022 22:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU/isqy4Rn7mQg0URc/9Bg3nr+6/tqehBhyoKhvoIQdrI+XFCKttEOXzzR/SRJwnmnPPeBWEldoDAJUaSrQ30igxFNfy+FSnqlQ4sqAHrrIZl8zOF4c6xpC+F7HpeMLJgWM5a6QbFufbBI7pDjR8T04L8HPDqUhXSBPhIO3IcaO0sxCjMNobqGVRKqi5Q+v6zQVzVej1RY6c16anLoz17l33nscv7wkoYTTZAC1ehFrWtYOHNMFkg5dW8Wnwe61ktDdm22SoI7hQAkeQ5N1o24g8C6Y5hYcV7qgLxYr/h1FLzRFM/cUHYr3AC7zVI9HGDxyt5yBQigiWMbQJJw4hIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vftwBxP+xR31p6X1gwSZ0Mup9HPMQDL/lUjHcIX1AZI=;
 b=N2pdwSKE68ak6FfXlrwPajnyO43uKFF88rQernyFsjWpUKHVXP3MqyluVs56RsaMEyPUMAJYNOZ0eU0XwPTWu4BXZsL6h5eW1GfIpm0G90bkuwHzQT4XTp8jLOFAPYunBNAvVt/WDtDenh+A6YA0m1KkMuiJ0JT1kRwlHXyAYkiyUkR6LTnp5oiHjtSoCNPKN7M/+t4CKCJKK1qHx59EMeoa7YVXzfnN4N0MyY7qAuJ2MyVJyIrVimO2EWNAl+givCYgK4Z4vhXZd3EdkgEoCeAXy11Dvy9dUnGHQ9ZlEPG64nmCsJWI7LlLCDw/yzkRe3goufi4JkjNBvt6MWyFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vftwBxP+xR31p6X1gwSZ0Mup9HPMQDL/lUjHcIX1AZI=;
 b=FZ3Ecx1EHCI+puQJ6zUUqsDDBMYzkuhjFpXe2IzIqPTm/MzK56XAwGourZSKMoEPLo8XZOW/8NRWlbxbSN2sV/kkJ9+Pl9U9v+V5OsquOdvKpObWRocfwar/HU/avYxnLjdVG6DH/V1iaRywvy9D73BMXtCsdEMpt8TAo+o6GxKrARVqBGmFz0VZ0uMqI7rOvmpYV7lnIfuRARCCYYLtb9WOs15Nt/njy2v0wKU7H+MO0RThDRquGlwPLrXRLH7m422fYwG4flkeHBxP+LiRywMHRqPdpL5Yk5VFJbnd1K/Qq4INYZg+7y1i1CFJoravgAZs4voXRLsuP7fFD51a5w==
Received: from BN8PR04CA0013.namprd04.prod.outlook.com (2603:10b6:408:70::26)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Sun, 16 Oct
 2022 05:20:31 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::4b) by BN8PR04CA0013.outlook.office365.com
 (2603:10b6:408:70::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Sun, 16 Oct 2022 05:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Sun, 16 Oct 2022 05:20:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sat, 15 Oct
 2022 22:20:17 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 15 Oct
 2022 22:20:12 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] null_blk: allow teardown on request timeout
Date:   Sat, 15 Oct 2022 22:20:06 -0700
Message-ID: <20221016052006.11126-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 342dccdc-3507-4762-54d9-08daaf362527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FR1rHvfDyVe4iRnQ07OEeCENagmdGewPFFWa9ksESLJbdhTc7/jRq6IMVENFTo3LvRgJ5dvONtkh3bnh/xpuls1b1+glIFVBUory+66wsxU3US2XQZi1yuhsxuqWye/qUtauZjxBGVxIToUaWOEgkcNEG1znPLiv9mrTMhIbj4bw9W+MFAbdVPfJCLAPHhdQoCadIRMy4O2a0QjehCkL/CxrygrOxS65KYf0I7TEosSe3yhnSBZG+QyeJ7Ta63XEvymdjcGSPA+g2A/Q1UCSurh35SaG6vWH+61GsLSwO7GvDu+eoAtnIrqCiDW+UbbnQapmHD9igncuFX9+e28FvnyMeBrsPCqQEOxwMiffjV1/IzBszGdALxSEuGsZM8O1V1FQsa6RFlCzCg0jpkezLNx1xDbwYPTAJrDeZmoCdBKwxr2QT9RcnkfhR0XpmrC4tl24dyoaGzPb2vuOs4+Jk/JGFsBg4tjcEi10/BNqrMM9uL/gdj8P9X1vohFQRRQTdLMwuZ+aED0tHMRe2Gai1vh+uykZsCqx8s9VUC0uFGfEfqbHtu/cKzfjXQ2bSsrw0FSLjErE5oxn3F4vpM9Z51IqtT6h8LUHoZHPe1gtRUMy+IEfW7pj5rnPCdNuCxAeNSqlkQ0QHG7R0WrDxr/0l0VsZliH5XC2Oe/rIQI5zadcdwPZvdPY+4xXDwMtoYcsyg0/sBo8dcrScPhPXp+Ard2j51ml4yIechGaqxIW3gt6v5udBnl1s7Lb3SBDuzAHDwr7NXNIUcNN9Jgs+psp9g==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(316002)(19627235002)(8936002)(70586007)(70206006)(4326008)(110136005)(54906003)(41300700001)(8676002)(7416002)(82740400003)(5660300002)(7636003)(30864003)(356005)(40480700001)(2906002)(7696005)(36860700001)(82310400005)(6666004)(83380400001)(426003)(47076005)(26005)(36756003)(478600001)(16526019)(2616005)(186003)(1076003)(40460700003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 05:20:31.0432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 342dccdc-3507-4762-54d9-08daaf362527
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current timeout implementation null_blk just completes the request
with error=BLK_STS_TIMEOUT without doing any cleanup, hence device
cleanup code including handling inflight requests on timeout and
teardown is never exercised.

Add a module parameter rq_abort_limit to allow null_blk perform device
cleanup when time out occurs. The non zero value of this parameter
allows user to set the number of timeouts to occur before triggering
cleanup/teardown work.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
* Test result enabling the rq_abort_limit from module parameter and
  issueing dd until null_blk device disappears from the pathname
  with connetion timeout error.
 
linux-block (for-next) # !./test_
./test_null_blk_abort_on_timeout.sh 
commit 4fbcf978ae8f385aa1830ce40f210c7eec8d58fa (HEAD -> for-next)
Author: Chaitanya Kulkarni <kch@nvidia.com>
Date:   Tue Oct 11 23:22:43 2022 -0700

    null_blk: allow teardown on request timeout
    
    In current timeout implementation null_blk just completes the request
    with error=BLK_STS_TIMEOUT without doing any cleanup, hence device
    cleanup code including handling inflight requests on timeout and
    teardown is never exercised.
    
    Add a module parameter rq_abort_limit to allow null_blk perform device
    cleanup when time out occurs. The non zero value of this parameter
    allows user to set the number of timeouts to occur before triggering
    cleanup/teardown work.
    
    Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
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
+ HOST_DEST=/lib/modules/6.0.0blk+/kernel/drivers/block/null_blk/
+ cp drivers/block/null_blk//null_blk.ko /lib/modules/6.0.0blk+/kernel/drivers/block/null_blk//
+ ls -lrth /lib/modules/6.0.0blk+/kernel/drivers/block/null_blk//null_blk.ko
-rw-r--r--. 1 root root 1.2M Oct 15 21:51 /lib/modules/6.0.0blk+/kernel/drivers/block/null_blk//null_blk.ko
+ sleep 1
+ dmesg -c
##################
##################
nullb0  250:0    0  250G  0 disk 
dd: error writing '/dev/nullb0': Connection timed out
3+0 records in
2+0 records out
8192 bytes (8.2 kB, 8.0 KiB) copied, 6.13436 s, 1.3 kB/s
##################
##################
nullb0  250:0    0  250G  0 disk 
[ 1598.393544] null_blk: rq 0000000015ff5165 timed out
[ 1598.393555] blk_print_req_error: 74 callbacks suppressed
[ 1598.393558] timeout error, dev nullb0, sector 8 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1598.395885] Buffer I/O error on dev nullb0, logical block 1, async page read
[ 1598.397731] Dev nullb0: unable to read RDB block 8
[ 1598.398990]  nullb0: unable to read partition table
[ 1598.399069] null_blk: disk nullb0 created
[ 1598.399071] null_blk: module loaded
[ 1604.537424] null_blk: rq 00000000b2a753f0 timed out
[ 1604.537437] timeout error, dev nullb0, sector 16 op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
dd: error writing '/dev/nullb0': Connection timed out
1+0 records in
0+0 records out
0 bytes copied, 6.13561 s, 0.0 kB/s
##################
##################
nullb0  250:0    0  250G  0 disk 
[ 1610.681242] null_blk: rq 00000000a392790b timed out
[ 1610.681253] timeout error, dev nullb0, sector 0 op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
dd: error writing '/dev/nullb0': Connection timed out
1+0 records in
0+0 records out
0 bytes copied, 6.13985 s, 0.0 kB/s
##################
##################
nullb0  250:0    0  250G  0 disk 
[ 1616.825155] null_blk: rq 0000000091a70f01 timed out
[ 1616.825168] timeout error, dev nullb0, sector 0 op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
dd: error writing '/dev/nullb0': Connection timed out
1+0 records in
0+0 records out
0 bytes copied, 6.1325 s, 0.0 kB/s
##################
##################
nullb0  250:0    0  250G  0 disk 
[ 1622.969017] null_blk: rq 00000000cdb610e7 timed out
[ 1622.969029] timeout error, dev nullb0, sector 0 op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
dd: error writing '/dev/nullb0': Connection timed out
2+0 records in
1+0 records out
4096 bytes (4.1 kB, 4.0 KiB) copied, 6.14283 s, 0.7 kB/s
##################
##################
[ 1629.112893] null_blk: rq 00000000555ecc5e timed out
[ 1629.118817] blk_sync_queue 230
[ 1629.118821] blk_sync_queue 232
[ 1629.118823] blk_sync_queue 234
[ 1629.118828] timeout error, dev nullb0, sector 8 op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
[ 1629.125044] blk_sync_queue 230
[ 1629.125048] blk_sync_queue 232
[ 1629.125049] blk_sync_queue 234
##################
##################

* Test result enabling the rq_abort_limit from module parameter and
  issueing fio until null_blk device disappears from the pathname
  with connetion timeout error.
nullb0  250:0    0  250G  0 disk 
RANDREAD: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=128
fio-3.27
Starting 1 process
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=214274048, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=32268288, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=107802624, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=193708032, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=202928128, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=281436160, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=33292288, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=250576896, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=41902080, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=225521664, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=303058944, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=405196800, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=309719040, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=111214592, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=254062592, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=128663552, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=76795904, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=355647488, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=5873664, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=69328896, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=216276992, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=16027648, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=328343552, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=385630208, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=137695232, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=146546688, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=157765632, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=290615296, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=230440960, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=130961408, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=88547328, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=157401088, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=296202240, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=35819520, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=212545536, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=261697536, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=66195456, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=254603264, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=169242624, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=258154496, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=69320704, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=335650816, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=192950272, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=32813056, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=5804032, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=217219072, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=153227264, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=91131904, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=241209344, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=246509568, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=332935168, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=108859392, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=86061056, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=278966272, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=219004928, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=290512896, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=143306752, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=176312320, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=346566656, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=183422976, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=383885312, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=199393280, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=160944128, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=142491648, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=217841664, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=178466816, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=331423744, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=88883200, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=311562240, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=228642816, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=362893312, buflen=4096
fio: io_u error on file /dev/nullb0: Connection timed out: read offset=323035136, buflen=4096
fio: io_u error on file /dev/nullb0: Input/output error: read offset=385089536, buflen=4096
fio: pid=7811, err=110/file:io_u.c:1841, func=io_u error, error=Connection timed out

RANDREAD: (groupid=0, jobs=1): err=110 (file:io_u.c:1841, func=io_u error, error=Connection timed out): pid=7811: Sat Oct 15 21:52:09 2022
  read: IOPS=33, BW=64.6KiB/s (66.1kB/s)(420KiB/6503msec)
    slat (nsec): min=942, max=6485.4M, avg=29824299.02, stdev=439245367.62
    clat (usec): min=525, max=6501.3k, avg=3899782.52, stdev=3194606.52
     lat (usec): min=530, max=6501.3k, avg=3961597.01, stdev=3181404.42
    clat percentiles (usec):
     |  1.00th=[    545],  5.00th=[    553], 10.00th=[    562],
     | 20.00th=[    611], 30.00th=[  15795], 40.00th=[  15795],
     | 50.00th=[6476006], 60.00th=[6476006], 70.00th=[6476006],
     | 80.00th=[6476006], 90.00th=[6476006], 95.00th=[6476006],
     | 99.00th=[6476006], 99.50th=[6476006], 99.90th=[6476006],
     | 99.95th=[6476006], 99.99th=[6476006]
   bw (  KiB/s): min=  216, max=  216, per=100.00%, avg=216.00, stdev= 0.00, samples=1
   iops        : min=   54, max=   54, avg=54.00, stdev= 0.00, samples=1
  lat (usec)   : 750=12.39%
  lat (msec)   : 20=6.88%, >=2000=28.90%
  cpu          : usr=0.00%, sys=0.00%, ctx=4, majf=0, minf=150
  IO depths    : 1=0.5%, 2=0.9%, 4=1.8%, 8=3.7%, 16=7.3%, 32=14.7%, >=64=71.1%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=98.9%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=1.1%
     issued rwts: total=218,0,0,0 short=40,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
   READ: bw=64.6KiB/s (66.1kB/s), 64.6KiB/s-64.6KiB/s (66.1kB/s-66.1kB/s), io=420KiB (430kB), run=6503-6503msec

Disk stats (read/write):
  nullb0: ios=90/0, merge=0/0, ticks=0/0, in_queue=0, util=98.55%
##################
##################
[ 1635.256737] null_blk: rq 00000000834b8ba3 timed out
[ 1635.256748] timeout error, dev nullb0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1635.258876] Buffer I/O error on dev nullb0, logical block 0, async page read
[ 1641.400625] null_blk: rq 00000000ee97fbff timed out
[ 1641.400636] timeout error, dev nullb0, sector 8 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1641.402919] Buffer I/O error on dev nullb0, logical block 1, async page read
[ 1641.404755] Dev nullb0: unable to read RDB block 8
[ 1641.406666]  nullb0: unable to read partition table
[ 1641.407559] null_blk: disk nullb0 created
[ 1641.407562] null_blk: module loaded
[ 1648.056420] null_blk: rq 00000000834b8ba3 timed out
[ 1648.056432] timeout error, dev nullb0, sector 418504 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1648.058914] null_blk: rq 0000000064c974a9 timed out
[ 1648.058918] timeout error, dev nullb0, sector 63024 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1648.061288] null_blk: rq 00000000ee97fbff timed out
[ 1648.061291] timeout error, dev nullb0, sector 210552 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1648.063663] null_blk: rq 000000006c6fa717 timed out
[ 1648.063667] timeout error, dev nullb0, sector 378336 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1648.066011] null_blk: rq 00000000fa856166 timed out
[ 1648.066015] null_blk: rq 00000000de9bec9a timed out
[ 1648.066016] timeout error, dev nullb0, sector 396344 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1648.068390] null_blk: rq 00000000f12b4b17 timed out
[ 1648.068393] timeout error, dev nullb0, sector 549680 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1648.071389] null_blk: rq 00000000667726b2 timed out
[ 1648.071393] timeout error, dev nullb0, sector 65024 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1648.073740] null_blk: rq 0000000088f0f903 timed out
[ 1648.073744] timeout error, dev nullb0, sector 489408 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1648.078759] null_blk: rq 00000000fd349776 timed out
[ 1648.078762] timeout error, dev nullb0, sector 81840 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1648.081093] null_blk: rq 000000002eb20dc4 timed out
[ 1648.081096] timeout error, dev nullb0, sector 440472 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[ 1648.083492] null_blk: rq 000000002db4026f timed out
[ 1648.083496] null_blk: rq 00000000db8f8be3 timed out
[ 1648.083499] null_blk: rq 00000000078a6daf timed out
[ 1648.083502] null_blk: rq 000000002c1b7c68 timed out
[ 1648.083505] null_blk: rq 00000000790d87a1 timed out
[ 1648.083508] null_blk: rq 000000004f48b7de timed out
[ 1648.083516] null_blk: rq 0000000074a5ff86 timed out
[ 1648.083518] null_blk: rq 000000000daf10f8 timed out
[ 1648.083521] null_blk: rq 00000000d54f527e timed out
[ 1648.083523] null_blk: rq 0000000009dc7bb8 timed out
[ 1648.083526] null_blk: rq 0000000017e81cd2 timed out
[ 1648.083529] null_blk: rq 0000000088e83fa2 timed out
[ 1648.083532] null_blk: rq 000000003c014afe timed out
[ 1648.083534] null_blk: rq 00000000b7a99358 timed out
[ 1648.083537] null_blk: rq 00000000d2d80485 timed out
[ 1648.083539] null_blk: rq 000000008805db58 timed out
[ 1648.083541] null_blk: rq 000000005c2e8f7a timed out
[ 1648.083544] null_blk: rq 00000000a33a2f2d timed out
[ 1648.083546] null_blk: rq 00000000d05bf454 timed out
[ 1648.083549] null_blk: rq 0000000080cb849f timed out
[ 1648.083552] null_blk: rq 000000009cbb48e0 timed out
[ 1648.083555] null_blk: rq 000000009e426689 timed out
[ 1648.083558] null_blk: rq 000000003705d117 timed out
[ 1648.083561] null_blk: rq 0000000010bc80b4 timed out
[ 1648.083563] null_blk: rq 000000004da816da timed out
[ 1648.083566] null_blk: rq 0000000081ceaf3f timed out
[ 1648.083568] null_blk: rq 00000000fb1e808e timed out
[ 1648.083570] null_blk: rq 000000006baf39c2 timed out
[ 1648.083573] null_blk: rq 00000000241e851f timed out
[ 1648.083575] null_blk: rq 00000000a7b7ff27 timed out
[ 1648.083577] null_blk: rq 0000000092e37377 timed out
[ 1648.083580] null_blk: rq 00000000a2b070cd timed out
[ 1648.083583] null_blk: rq 00000000a2c63d6f timed out
[ 1648.083585] null_blk: rq 00000000b775711d timed out
[ 1648.083588] null_blk: rq 000000000bfe50e6 timed out
[ 1648.083590] null_blk: rq 000000005c0b7039 timed out
[ 1648.083593] null_blk: rq 00000000af60d454 timed out
[ 1648.083595] null_blk: rq 00000000d2a38d75 timed out
[ 1648.083598] null_blk: rq 0000000000ae81a8 timed out
[ 1648.083601] null_blk: rq 000000001974c62a timed out
[ 1648.083603] null_blk: rq 000000002aaf80e6 timed out
[ 1648.083605] null_blk: rq 00000000bcdf1c85 timed out
[ 1648.083608] null_blk: rq 000000008b5d9eb6 timed out
[ 1648.083610] null_blk: rq 0000000066fcf345 timed out
[ 1648.083613] null_blk: rq 0000000067dc1221 timed out
[ 1648.083615] null_blk: rq 0000000088e78508 timed out
[ 1648.083618] null_blk: rq 000000009d1352eb timed out
[ 1648.083620] null_blk: rq 00000000a7019839 timed out
[ 1648.083622] null_blk: rq 00000000f5756a31 timed out
[ 1648.083625] null_blk: rq 00000000841b16a6 timed out
[ 1648.083627] null_blk: rq 0000000082fa3e11 timed out
[ 1648.083630] null_blk: rq 00000000794e9904 timed out
[ 1648.083632] null_blk: rq 00000000c3bcf5d1 timed out
[ 1648.094395] blk_sync_queue 230
[ 1648.094400] blk_sync_queue 232
[ 1648.094402] blk_sync_queue 234
[ 1648.096130] blk_sync_queue 230
[ 1648.096133] blk_sync_queue 232
[ 1648.096135] blk_sync_queue 234
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda       8:0    0   50G  0 disk 
├─sda1    8:1    0    1G  0 part /boot
└─sda2    8:2    0   49G  0 part /home
sdb       8:16   0  100G  0 disk /mnt/data
sr0      11:0    1 1024M  0 rom  
zram0   251:0    0    8G  0 disk [SWAP]
---
 drivers/block/null_blk/main.c     | 90 +++++++++++++++++++++++++++++--
 drivers/block/null_blk/null_blk.h | 10 ++++
 2 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..52db6b99b448 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -77,6 +77,10 @@ enum {
 	NULL_IRQ_TIMER		= 2,
 };
 
+static unsigned int g_rq_abort_limit = 5;
+module_param_named(rq_abort_limit, g_rq_abort_limit, uint, 0644);
+MODULE_PARM_DESC(rq_abort_limit, "request timeout teardown limit. Default:5");
+
 static bool g_virt_boundary = false;
 module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
 MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
@@ -247,6 +251,7 @@ static void null_del_dev(struct nullb *nullb);
 static int null_add_dev(struct nullb_device *dev);
 static struct nullb *null_find_dev_by_name(const char *name);
 static void null_free_device_storage(struct nullb_device *dev, bool is_cache);
+static void null_destroy_dev(struct nullb *nullb);
 
 static inline struct nullb_device *to_nullb_device(struct config_item *item)
 {
@@ -578,6 +583,18 @@ config_item *nullb_group_make_item(struct config_group *group, const char *name)
 {
 	struct nullb_device *dev;
 
+	if (g_rq_abort_limit) {
+		/*
+		 * abort_on_timeout removes the null_blk and resources. When
+		 * null_blk is created using configfs entry by user we will also
+		 * need to cleanup the those entries when abort_on_timeout is set
+		 * from null_abort_work() and that we shold not do it, since
+		 * manupulating user's entries from kernel can create confusion,
+		 * so just don't allow it.
+		 */
+		pr_err("don't use g_abort_on_timeout with configfs entries\n");
+		return ERR_PTR(-EINVAL);
+	}
 	if (null_find_dev_by_name(name))
 		return ERR_PTR(-EEXIST);
 
@@ -614,7 +631,7 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
 			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
 			"zone_capacity,zone_max_active,zone_max_open,"
-			"zone_nr_conv,zone_size\n");
+			"zone_nr_conv,zone_size,abort_on_timeout,rq_abort_limit\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -1609,10 +1626,60 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	return nr;
 }
 
+static bool null_cancel_request(struct request *rq, void *data)
+{
+	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
+
+	/*
+	 * Keep it simple and set the timeout error since we've been schedule
+	 * from timeout handler afterall.
+	 */
+	cmd->error = BLK_STS_TIMEOUT;
+	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
+		blk_mq_complete_request(rq);
+	return true;
+}
+
+static void null_abort_work(struct work_struct *w)
+{
+	struct nullb *nullb = container_of(w, struct nullb, abort_work);
+
+	mutex_lock(&lock);
+	if (!nullb || !nullb->dev)
+		goto unlock;
+
+	/*
+	 * To make sure that null_handle_cmd() callers are not in progress from
+	 * null_queue_rq()/null_submit_bio() when we are stopping nullb, we
+	 * quiece the block layer request queue and engage in teardown sequence.
+	 */
+	blk_freeze_queue_start(nullb->q);
+	blk_mq_quiesce_queue(nullb->q);
+	/*
+	 * We already ensured that submit_bio() will not add any plugging by
+	 * quiescing so it is safe to sync queue now.
+	 */
+	blk_sync_queue(nullb->q);
+	blk_mq_tagset_busy_iter(nullb->tag_set, null_cancel_request, nullb);
+	blk_mq_tagset_wait_completed_request(nullb->tag_set);
+	/*
+	 * Unblock any pending dispatch I/Os before we destroy the device.
+	 * From null_destroy_dev()->del_gendisk() will set GD_DEAD flag
+	 * causing any new I/O from __bio_queue_enter() to fail with -ENODEV.
+	 */
+	blk_mq_unquiesce_queue(nullb->q);
+
+	null_destroy_dev(nullb);
+unlock:
+	mutex_unlock(&lock);
+}
+
 static enum blk_eh_timer_return null_timeout_rq(struct request *rq)
 {
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	struct nullb *nullb = cmd->nq->dev->nullb;
+	bool fake_timeout_no_abort = cmd->fake_timeout && !g_rq_abort_limit;
 
 	pr_info("rq %p timed out\n", rq);
 
@@ -1632,9 +1699,23 @@ static enum blk_eh_timer_return null_timeout_rq(struct request *rq)
 	 * Only fake timeouts need to execute blk_mq_complete_request() here.
 	 */
 	cmd->error = BLK_STS_TIMEOUT;
-	if (cmd->fake_timeout || hctx->type == HCTX_TYPE_POLL)
+	if (fake_timeout_no_abort || hctx->type == HCTX_TYPE_POLL) {
 		blk_mq_complete_request(rq);
-	return BLK_EH_DONE;
+		return BLK_EH_DONE;
+	}
+
+	if (atomic_dec_return(&nullb->rq_abort_count) != 0) {
+		blk_mq_complete_request(rq);
+		return BLK_EH_DONE;
+	}
+
+	if (!flush_work(&nullb->abort_work))
+		queue_work(system_highpri_wq, &nullb->abort_work);
+	/*
+	 * null_abort_work() will take care of completing all the requests
+	 * including timed out one.
+	 */
+	return BLK_EH_RESET_TIMER;
 }
 
 static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -2124,6 +2205,9 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		goto out_ida_free;
 
+	INIT_WORK(&nullb->abort_work, null_abort_work);
+	atomic_set(&nullb->rq_abort_count, g_rq_abort_limit);
+
 	mutex_lock(&lock);
 	list_add_tail(&nullb->list, &nullb_list);
 	mutex_unlock(&lock);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 94ff68052b1e..d7f5d3161908 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -133,6 +133,16 @@ struct nullb {
 
 	struct nullb_queue *queues;
 	unsigned int nr_queues;
+	/*
+	 * null_blk request timeout teardown limit when device is in the
+	 * stable state, i.e. once this limit is reached issue
+	 * null_abort_work() to teardown the device from block lyaer
+	 * request timeout callback and cleanup resources such as
+	 * memory and pathname.
+	 */
+	atomic_t rq_abort_count;
+	/* tear down work to be scheduled from block layer request handler */
+	struct work_struct abort_work;
 	char disk_name[DISK_NAME_LEN];
 };
 
-- 
2.29.0

