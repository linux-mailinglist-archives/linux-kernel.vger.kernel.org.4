Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8065F4F3C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJEFEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJEFDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:03:51 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02CD7434B;
        Tue,  4 Oct 2022 22:03:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlHU/KRovQ1zoOmPusDQihZAywsAe+9saYFzSvkF/vCJJxVd7rTwel7ppyREm39KrRHCr+UHTA+p4XZIyW9cWYjMZb7MEDUVj3/n2OL0MEF0FH37K/n1WPDlVqnQJYmAI2khS6SV4rek/UpLrLDKVSLBLYFP6DV0ERo1csLQOjQ/KXc9b8duezQiiaEKAhExBFKFksGLkjqPv6WRUXok9alMLztDBoXS7gctIv63h4imqZceqGt4GajPcxXPZ3l3GQ0AZEdnHGsZlQYbpaxL1xHbBiKolmLHA9PeKzKCWSZdQnR8ltJ07QRzKmBG5XziTw8A4DtT3GTlTvE1JGzL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+7/+g4e2Ke+0bCNjaxTKjA95kp5VH1jRQ/Rn928iYQ=;
 b=b+2ze7uCANPpfN1u2NE4a5ocgtJhelqDt2xkUxrlz+qp3LNjb3lgK/2j93BdjYnQbEbuPyjBCVjUOAE4pFjQFVNPhSFTQpmnxmcnoiRBaey4v/QTftfX7rbExmBLiNon//lrfL1idPOgPR7vg3FCuhLHC17jm7u0/YagiWjrbtSUHwsfYaT5MOyB3dpm2bx29XtimDzf5xKKQUdDZr0HCuHFO0l0Y130/glzLtu3ja1ulqJnyN7C5ekTWPdGQOQm93wcGjdSndLnFjdtgDmd/PVLNvu6j7/5BV40PfDqYFCf8E/uQxcEO+ogg9OIMk9M7a0mEekO+SQwWBjVaf1PZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+7/+g4e2Ke+0bCNjaxTKjA95kp5VH1jRQ/Rn928iYQ=;
 b=anVO3AQWtGnYLJ2kckVLSJZa1aBZLcuKbcqvnyTpj47TDw+6ZvOiFoV+IZOPURNSTuIm9F1nTpHvdeisOUMrIQAASksKAkFDsv9qsp3/AiVOm0oL/XIbncDVLwHVVcRi6H1RPDjjTABrtubak1vEvSmbT5xxW177ljlQfwdmEZgGKyRy4ZB6LdgfY+isfr4mG9LAxco6CHjcV8cbgGNxl3tuk6SWE/rtgAhlrw7+tTUO8gm50ZpiGux8BmkW08MwLzyJrPbQEgTFrHv+15IALu5+7bkG7wvlX3pTCp6dmxqKdhS1OG+iOvaAj4hFMPwZsH5QV9ZpYmUUcMkxVkezfA==
Received: from MW4PR03CA0068.namprd03.prod.outlook.com (2603:10b6:303:b6::13)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 05:03:14 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::70) by MW4PR03CA0068.outlook.office365.com
 (2603:10b6:303:b6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Wed, 5 Oct 2022 05:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 05:03:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 22:03:00 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 22:02:59 -0700
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
Subject: [RFC PATCH 12/18] pf: use init disk helper
Date:   Tue, 4 Oct 2022 22:00:21 -0700
Message-ID: <20221005050027.39591-13-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT048:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: dd606bac-2956-44bf-095d-08daa68ee848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WCe3bHY3aiqOIyukhVwzls4juzKwxwYnlIXimEhWng6ZsH1oC5DU9nPcISNelNuo5zsbTohyCNcVQVqz82fmoP0I84MiwI07wC707drJbxzuYKqcuxCowS2jma2NNrhAnoBW3ZfTz/zLL4tQqq2PGLWaNWxk6S72vNtfp732ynF/epItK192VcF+CgWuzd89d8scHYU2qMFOQlo/WsDClImgnpDVGSDmZr6qX1dq1oJBRZP6FyIjPTqEg7/joFGO39+doIyZ+qgyXqVTCg+fuwSOd/jPAQ/EJSjO3wYjp9bUbq4TBA4LJjip+iyUeAyn97IkKXqeszEPsu8sZuOFj+VgplEuNVd/7qr7axnxls//CuIL6m1wYy9fzaiAoxSCqMfvMrFa7lMK7MPDPyCYEwqGyXscp2RD1KROBLQ56SZUfEAxafhSMuQjEzLGyy6X2gpa4aVE4qr/RA+PKfT2Pnkohzg+bJHRaDQFNTCxc+EINUaZA0KHBi64qMgAo4E04x0SPDz58gFyb80jSG8I58g7IoOiBQennQsr4sgTDUtw4tKpT5LBBSlMsfVFRcjU+tGI3wvz7UMH6tBb0pCFoZvn6qSueodCMqZXzrcglC0QfWyJq9wVcspGGfuOMJW1EA9lfHzUCVgf6Vi8FKedWiejCyZtOE8pIcBtDGb9tG1PI0ydLwigLe8IdrKY8JQRJvCjqXbfxeENGfsGuuJ+Ws6vec53tT+wO8tN1nzTMtdkVtlmHZ/5v89u1WZGUxKg8KUc1/Hj6Y23r4Y3IvEFTQJaNUMYAEmwo+syfIMMKw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(2616005)(336012)(1076003)(16526019)(186003)(47076005)(426003)(83380400001)(7636003)(356005)(36860700001)(82740400003)(7416002)(2906002)(41300700001)(8936002)(40480700001)(82310400005)(4326008)(8676002)(6666004)(478600001)(26005)(40460700003)(7696005)(316002)(70206006)(70586007)(5660300002)(54906003)(110136005)(36756003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 05:03:13.8011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd606bac-2956-44bf-095d-08daa68ee848
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
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
 drivers/block/paride/pf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index eec1b9fde245..2950642402a8 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -937,15 +937,11 @@ static int __init pf_init_unit(struct pf_unit *pf, bool autoprobe, int port,
 		ret = PTR_ERR(disk);
 		goto out_free_tag_set;
 	}
-	disk->major = major;
-	disk->first_minor = pf - units;
-	disk->minors = 1;
 	strcpy(disk->disk_name, pf->name);
-	disk->fops = &pf_fops;
 	disk->flags |= GENHD_FL_NO_PART;
 	disk->events = DISK_EVENT_MEDIA_CHANGE;
-	disk->private_data = pf;
 
+	init_disk(disk, major, pf - units, 1, 0, pf, &pf_ops);
 	blk_queue_max_segments(disk->queue, cluster);
 	blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
 
-- 
2.29.0

