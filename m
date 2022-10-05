Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D15F4F28
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJEFBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiJEFBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:01:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDFA7333A;
        Tue,  4 Oct 2022 22:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=magKLvnrfH01xG5i/5zBxn+ueDau8LLCHXv2JcG4b4I6v4waghdqVWjSW/socP6POStDylPRGM+6mNxPKs8JJ9gcL6CDqWBAvvDRNddLc9+8AkJqd5zzYB6lEO4HswzEQhpQj1kUSbQUOh3YTjMMhD5+1uCrDRMKu8Chr1w2zl5uXyzx2QDILOovWuPyCa3ZzvgLJSRJvCzXZ6Yq36bEiHEG2nBT+ZaiYoniRyizSCdjH/Ys1o1+kE+jGLOJQPzoejUK+tN7Asuwu48lXYqj4gr712ehaHr8I1QehMrzpxKMjcAKJaHCjZeKzkal06BBhWI4pUCt7G68HfED48dGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJP0HjxKqbqm2cPL0D23Vy8DyY+XnISaSuaPl2ELDEk=;
 b=c2moDgH/LQeZV80cZwlCUJJPYixrpyUkV2MalnjYjHhctNlTbLnLl1cHvusZ7Gud66AL7CUjpvIweNoxYK1UutDjEif0kzZhN0tOgpdtQmxjerL5vNzgUR8yliXsyYRsqtvDnAdCahygLiMtUgrr8ov4DVPPI2Jagof70c0sjyVb2InrLPQvKvfQhQEcYTSN29PFSGhI68Pg/UgTHndsBb/gKkbqB10DQBMHNsi3TVPRAdRuRGBHYsqtrDY/gqtBtVjBiqhpw5PlEYs4J19huAKK+3fvGPFtz1XbpOklwjkQ5Z+XyuwUMZhZgWd8znlePleScsOlluDfXYfAIeGcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJP0HjxKqbqm2cPL0D23Vy8DyY+XnISaSuaPl2ELDEk=;
 b=lLbaXg1CToKwn0fJQnesE8m9T4zeWar/lzL7WD3lDc7KgX9mCdZGnByUPAi0fnyrVU8GYfzXpYgNODUA4BNS2IXdxyRtZVy3cFUy8/UnTrRra5fubjCGguv46Eq7z7QxemGXMbzDjkD0Z+QKcz2j74DxgkrwPyoHJ2KAbiVeGoFhJlTYSg+1tzsUsotfY08jgMUWGsNvfphyejNjbVlj/dbblmMSluvNKPyzWARtpVt6CGCfV1OKkvId6A1H0uqU3oR/1+2+DnAllwc2Pdh9MxJMaQjYG6KvM0Z6IHtjLV5+exMYxKdbgRhMXPrpmOBsoM5QA9bDwZyXH6FcO/BNbQ==
Received: from DM6PR21CA0022.namprd21.prod.outlook.com (2603:10b6:5:174::32)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Wed, 5 Oct
 2022 05:01:32 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::af) by DM6PR21CA0022.outlook.office365.com
 (2603:10b6:5:174::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.8 via Frontend
 Transport; Wed, 5 Oct 2022 05:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 05:01:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 22:01:12 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 22:01:11 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <ogeert@linux-m68k.org>, <linux-block@vger.kernel.org>,
        <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
        <drbd-dev@lists.linbit.com>, <nbd@other.debian.org>,
        <linux-mtd@lists.infradead.org>
CC:     <axboe@kernel.dk>, <philipp.reisner@linbit.com>,
        <lars.ellenberg@linbit.com>, <christoph.boehmwalder@linbit.com>,
        <efremov@linux.com>, <josef@toxicpanda.com>, <tim@cyberelk.net>,
        <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>, <kch@nvidia.com>,
        <mcgrof@kernel.org>, <hare@suse.de>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <vincent.fu@samsung.com>, <shinichiro.kawasaki@wdc.com>
Subject: [RFC PATCH 03/18] amiflop: use init disk helper
Date:   Tue, 4 Oct 2022 22:00:12 -0700
Message-ID: <20221005050027.39591-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005050027.39591-1-kch@nvidia.com>
References: <20221005050027.39591-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 015a58a7-467c-41b8-86b2-08daa68eabaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzprjFkKHROONXcQ/BAh9OJW7TC9NuBrrwffpsNsEvOZWdDtb2drAF/9pqEq0Yz+i6iFjvSYkJDZIT/FNWgECniZ70oNDk6zjhdLsDKCZZ3inLx4dXR+m1C+2qFzSm0IB54Jk39NnF4Vprp8C8BEF7ihDjfR1KbS2hRa4iMP2oFTy0Vdxb9CzKSz5YiyeoJYDTdYGcrI+jXCElnRfcJCFebVBe3ea5zrLLHbqQVnsPPXMaUln+gcyLsc2+Wy0rifJAYRbjMTM+lxyypS9ZqYt8jXEriAQYQuApF7P3LkzuZUxYtoxNrCdD1AlqwzZqyJDGfWaCpOLiBo6ARDz6P453ssLshFn/Mkc2/Qq4L+ruIlZ8isikEULUPbfQTOy0qyEpTRgNsIEXg6QV8y+iVONSFZAJaalj9KmfYoAVPkSnRXzLVk/eesMfzDYdtMisltdw7+Kc9DA2rXEpxUW3xRGFz6YXTdBg2Sf08y/jQCQNUKQqIiW6kQiifKXJals7Jk0mbOPIVic3lY8Qw5Q0eKPPJM8nhUfg9lBX91cb1IbxEANAQ7nCkvkEtH/2LcfvtcbP1dMdqrTDhQ5g20otdGwnf59DhBJUVtPHps+ADVlXEI7rGne690hoAD0M9TaL7MykD2AMroThGT271amts89c0LoXr2FK3vbHwMmEIPvDJm9PxuaXqppd6BlwOxOFPzjRDDI9MQCTr4euapzn2u/JbqMP97aGMst8zmNNbxmTK1u9v6STrnhkN0h8PLfYbch9amgsIlYCgEGH+WJ9h1K7CdKTu9JCV0HIHPHWqycSQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(40480700001)(36860700001)(82310400005)(16526019)(41300700001)(2906002)(7696005)(2616005)(110136005)(54906003)(36756003)(40460700003)(26005)(336012)(356005)(316002)(8936002)(8676002)(4326008)(478600001)(83380400001)(7416002)(426003)(47076005)(7636003)(186003)(5660300002)(70586007)(1076003)(82740400003)(70206006)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 05:01:32.0118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015a58a7-467c-41b8-86b2-08daa68eabaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and use the helper to initialize the common fields of struct gendisk
such as major, first_minor, minors, disk_name, private_data, and ops.
This initialization is spread all over the block drivers. This avoids
code repetation of inialization code of gendisk in current block drivers
and any future ones.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/amiflop.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 4c8b2ba579ee..40f220fd61a7 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1786,18 +1786,14 @@ static int fd_alloc_disk(int drive, int system)
 	if (IS_ERR(disk))
 		return PTR_ERR(disk);
 
-	disk->major = FLOPPY_MAJOR;
-	disk->first_minor = drive + system;
-	disk->minors = 1;
-	disk->fops = &floppy_fops;
 	disk->flags |= GENHD_FL_NO_PART;
 	disk->events = DISK_EVENT_MEDIA_CHANGE;
 	if (system)
 		sprintf(disk->disk_name, "fd%d_msdos", drive);
 	else
 		sprintf(disk->disk_name, "fd%d", drive);
-	disk->private_data = &unit[drive];
-	set_capacity(disk, 880 * 2);
+	init_disk(disk, FLOPPY_MAJOR, drive + system, 1, 880 * 2, &unit[drive],
+			&floppy_fops);
 
 	unit[drive].gendisk[system] = disk;
 	err = add_disk(disk);
-- 
2.29.0

