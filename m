Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8E55F4F40
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJEFFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJEFEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:04:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1223E74B85;
        Tue,  4 Oct 2022 22:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMXiWWDN1LMnTqkhoWPuGbVF6+PW77y8SIPc/4B4uQBBn2hlPV6HtupWuyBxOCbuqF5EyVuDyC0Sh07X/6BnUAfyt2l/PU1lcSWVXc6FxGFZGPs2gSG9KbKOGc594NNwIjrNGZe5yzoT3Qy2kWHRj5X8dDArxQPAvi73558y65wqVas7JrEBGX5WG+DQoEgZIZGnW2WT5uDjSC6sd4pjia3f4iZFSm8iOAUkM7PzKo8e0M0HU8/m4QKBsrAP/ImeMqDVha/Bus9crEGDv07mm5Eu1lne6DDOjkC2CNO5Uvfc4bmFN1gVRZ1RDMpXs1kywFeBL+q2VBNXamGW7KK2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xmtiNGAmNE7dW/7iM5AgEgNvt4lKAO45mgCCIQCeNE=;
 b=muO0xGdCYlpbi3067F0zvEvAiql5cQXv/3sda4c7oqZz+XhvSkF3CkmwaDjZmz6uwxh4tlCYs5fMwc7cJGJretyHoS15WKutmBvXP5l8M/sA5kxQUfUWKJ2aCdmCnFMWQ83ruiudt25H1TUpHIpUCLGjoA/bksvKry8C+oXDovZuK4YyO1EaEkwIG/09DDLphNsyI14xK+hiysO0NAtCf6k8gkoDoIoYYd2bj/OhP72+vtIb6VCz3jjGTnjkCS4ldqvjeD+q9XIqHpv/cSOuw5ljobxeioW8cbzd0xtShzycjirAodZz7isldzCNK772mo0Ek88OkoJLx1Y2Vw0/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xmtiNGAmNE7dW/7iM5AgEgNvt4lKAO45mgCCIQCeNE=;
 b=ONHjW9ZwwH8oc9v4qczXnV54KRL6PPcw4rUlKE2AJLvCkKCfRhP/mN4ANFRRMwiZOCePv6QhzsPxBCDFNOIWY7iGNcAccSdysOKMeYll0vbWxoo8ZtVkZR9ci2+LhtSfJJH6LXan+mWx7mQOU7wCoRXhNstMI+2zQK75B4Pg0ZXo1DxNPh6CIytxnvPtwBwKg7/d4nYOzEyPg5kpMV+ewiZXlWzfhSNtMyuDs5Q9UNtC9ob/7pCqeluhFWRTF9+Sjjib4YKVImu91UhI60guORHOEuzDhE8PC0syKga29kCStUnC9Ke8VVKb7HTGXY+pMAaoxatKCp/gm/n/Gc07RQ==
Received: from MW4PR03CA0187.namprd03.prod.outlook.com (2603:10b6:303:b8::12)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 05:03:42 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::ae) by MW4PR03CA0187.outlook.office365.com
 (2603:10b6:303:b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 05:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 05:03:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 22:03:24 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 22:03:23 -0700
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
Subject: [RFC PATCH 14/18] rnbd-clt: use init disk helper
Date:   Tue, 4 Oct 2022 22:00:23 -0700
Message-ID: <20221005050027.39591-15-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005050027.39591-1-kch@nvidia.com>
References: <20221005050027.39591-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: b6937243-ded6-465c-f408-08daa68ef911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G341qt4YpCEEFIv2fWnulqvSlyT9tJB3FcarfTOE9SbAcWv1gEKSMj6yRr4qY4RO3rpcbTtRcRw8GO4wil5qwEHZ8Lzyh/XR2WU1XjNxhlAbZGYTdbbUUSjGWUbaRzWQ7u+HRBd5FsE1ntWYE8ZMep7rUyoyyOlKVEDHrnvqx24o3IdOos+qc18K77eItNUPI1jmds5ZnQBukSVa4uOZ5rv4x/LOZN7Wl8HHehwrDLeWbDzKQQm38QvALDnC0wuPR3E20RzGpLofNYmFbu7aYVVgPKA+E5JQM+xZceZlG6J7oEgUeGlLimAF4iiFEmGjQ2Aw6h4JpZcL8T0oFLJfC7rLfDnQ8npcIih5MVPfujY92uru3LJonMSlpRohn3exKCxnz7nAgBk3A3ir4i+Ztg16lhqGZi/xyhHexV6lZiWovVbyDw6Vl8nttwB+hPNOjoQsxQ2BzFRW8LMWRIspe7hSfclPaKBb4V8bGEj+v5lJwfSVlH5aVhsYyQ8GLivtNl5jp/MwMV4vdLU0IB2eLHzoWvKVgwLdao2VHcwCI7cFmjgSo/V8h7EYjtpxUYsa39nCCnet7YIpuNymBw3IQMBGORQ7tzCbGAEwEJKiAaKFwTtwxEDH8m8+GmS2haxWoFCtDkf4OYdzRXwL23c7ZuAzeELyOJ6gVg2+SPXTE/ZY8T7ukx/q1/+M7IatuEXewjzdyyEFLV2dB7++HS/AivUWlrzExsP7gRZgniZw1HWXkmtoVeCcXYlCkQETsjLDP9uTgMGXkiqaUrGWpZguE0QozwUJFmJl+6d+g5Xz2HQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(8676002)(2906002)(4326008)(36860700001)(70586007)(70206006)(5660300002)(478600001)(54906003)(110136005)(41300700001)(7416002)(36756003)(82310400005)(8936002)(26005)(7696005)(47076005)(426003)(1076003)(336012)(82740400003)(186003)(16526019)(7636003)(316002)(40460700003)(2616005)(40480700001)(356005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 05:03:41.9523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6937243-ded6-465c-f408-08daa68ef911
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
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
 drivers/block/rnbd/rnbd-clt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 78334da74d8b..4f29364a6f4d 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1369,12 +1369,7 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev,
 {
 	int err;
 
-	dev->gd->major		= rnbd_client_major;
-	dev->gd->first_minor	= idx << RNBD_PART_BITS;
-	dev->gd->minors		= 1 << RNBD_PART_BITS;
-	dev->gd->fops		= &rnbd_client_ops;
 	dev->gd->queue		= dev->queue;
-	dev->gd->private_data	= dev;
 	snprintf(dev->gd->disk_name, sizeof(dev->gd->disk_name), "rnbd%d",
 		 idx);
 	pr_debug("disk_name=%s, capacity=%llu\n",
@@ -1382,7 +1377,9 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev,
 		 le64_to_cpu(rsp->nsectors) *
 		 (le16_to_cpu(rsp->logical_block_size) / SECTOR_SIZE));
 
-	set_capacity(dev->gd, le64_to_cpu(rsp->nsectors));
+	init_disk(dev->gd, rnbd_client_major, idx << RNBD_PART_BITS,
+			1 << RNBD_PART_BITS, le64_to_cpu(rsp->nsectors), dev,
+			&rnbd_client_ops);
 
 	if (dev->access_mode == RNBD_ACCESS_RO)
 		set_disk_ro(dev->gd, true);
-- 
2.29.0

