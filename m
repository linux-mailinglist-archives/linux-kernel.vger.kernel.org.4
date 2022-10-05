Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6B65F4E86
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJED1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJED0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:26:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7D733C1;
        Tue,  4 Oct 2022 20:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsP9CuxPJtR/q9XS5KKaJXEvOi6BADmwLOjAlReHkmXHF63nglaj+3k4CMTARb7SPRbyiyxueGw6a+HTI3eC/0kNJc09JDk2GMJvYtUFsJe0/0J/X3nvJtFWM582oMOBrqMqv4XQFZZ2wEcRQLTXPT3cMdNQXd3n2MParjE8XEREjt5H+OZ2SR1k/2pDFuwqloUKz1XcwVXUq2r9T0k/M0oEOL6YaFcpf2Mgr7PDiekplDY5OQcPlwlYU+H3lwxYlK6OviWOXUjn5+BCwi7njRrx1ElnNnDsdCoeOwrjRB/p/fabLhfnBO0gfNKVh/r8OaDA1YKnwnqbB0eucqyecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwJoYyzzFtLJ6RYN8jm17eFSPpNKKb7Ir3gvcoHky7s=;
 b=I/elbQjDx9Hs+tsKJ50X7fdP0RdAlKW6n6rYJCyrSRaN1j2C9bGo2xLLiKmfAgqi/grAqNuqhRzk9WvoolEvwLQ7wNrRWmi+x0NFkJA9SEvEvDW6BpwWB3MUyiSneiJxPfiy5GR2MSVUZkZ6ioDExsXIz4s76IW1g1yPy6MxMbKvTsswl0tz0FIHtuXMu0215dBaefSue93kaFAQRPtWOmodZfmxE4ECzqrz8O118khaAI1AHi+W4U6bdeCdi3Ted8efjEVN3N5M411wvMh4b1WpC4Cl83C1pSAlU2AuLMZh9qz5lbSh90vF/oyqInSBoBpN0az8LTEGFjr54UxLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwJoYyzzFtLJ6RYN8jm17eFSPpNKKb7Ir3gvcoHky7s=;
 b=JdicFUG8fzc8JW0qLJGYk2kcaMIlzPVt022pzB6MEtPRTX6X8T0xHzyTON4HeIoArTZEnvfFo87s+KCjXtg7sOsCQPBoYwYuFzmG4k/rvFtd5LHMWQSievHUejUWr5VJqN2sA1jVv+WOSJJR6AUsupRC4KINf3yG00mLBp9syazP0zj3IDGEvy/yMT4NzEgWPcH/W/y0cPGLAs3O6ocbXLYemRUj3BSmBMEKlzkjUelsOxT4/xt41bw6GYAtbojbk0Ve5rWNakUx+LiAlsCm682Y+x6FIfd5SbQf3/XKKCVLYoEJ1U3+2cGa9vjCVjmlyiY+WDfEmxQYHTgao/XEFg==
Received: from DM5PR07CA0077.namprd07.prod.outlook.com (2603:10b6:4:ad::42) by
 CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 5 Oct
 2022 03:25:29 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::6a) by DM5PR07CA0077.outlook.office365.com
 (2603:10b6:4:ad::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Wed, 5 Oct 2022 03:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 03:25:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 4 Oct 2022
 20:25:26 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 20:25:23 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-nvme@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
CC:     <axboe@kernel.dk>, <efremov@linux.com>, <josef@toxicpanda.com>,
        <idryomov@gmail.com>, <dongsheng.yang@easystack.cn>,
        <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <mst@redhat.com>,
        <jasowang@redhat.com>, <pbonzini@redhat.com>,
        <stefanha@redhat.com>, <ohad@wizery.com>, <andersson@kernel.org>,
        <baolin.wang@linux.alibaba.com>, <ulf.hansson@linaro.org>,
        <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <marcan@marcan.st>, <sven@svenpeter.dev>, <alyssa@rosenzweig.io>,
        <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
        <sth@linux.ibm.com>, <hoeppner@linux.ibm.com>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hare@suse.de>,
        <kch@nvidia.com>, <bhelgaas@google.com>, <john.garry@huawei.com>,
        <mcgrof@kernel.org>, <christophe.jaillet@wanadoo.fr>,
        <vaibhavgupta40@gmail.com>, <wsa+renesas@sang-engineering.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>,
        <christoph.boehmwalder@linbit.com>, <joel@jms.id.au>,
        <vincent.whitchurch@axis.com>, <nbd@other.debian.org>,
        <ceph-devel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <asahi@lists.linux.dev>
Subject: [RFC PATCH 10/21] amiflop: use lib tagset init helper
Date:   Tue, 4 Oct 2022 20:22:46 -0700
Message-ID: <20221005032257.80681-11-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: b706260a-84d9-4945-0731-08daa68140d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qaLD80h+r+AI/5ufb/enJLpaqCCOh4b3Rak4Zo+0qBI4SfshnOJHnnYCHodzIeaE+KkAoMJHzFkZ7lFTUHjq33FL00Rw2VtMqJGiqn9eZq8YPPi5wDr6IADXjmPabyL50hN4jJwYK4f1IiH9bJAcPHvcAvonFinGIOBuubttRsERKQC7biX2nVTUeXpD9UlXelMM1wbbGkjEJs9X7qhS79acHxZpFu11eyiZa+RPNs21l2wejLpyOe9E/RMUj3/c7XdgXVpfVuz6TPtqhfS4BvBgKlHkE7tO5a02jF529MJ8UfqAMCKCoBH69ovSJlYlJCQ4dt7GdNDK6Vyc3OZEcHeceVg1kWrukYe8UaWR1urHd9gXiWyOLt3qjxKOacr7R+lyInSm0SUT9ULGnX3d+HLJYhaOeOQsY32XE6pm77a9EOC2M/DAhYh8HB42h1/Tko/WSrxwzP04v8RmE5mEl1oYxyLM3JSo2hAZnrkVV3VRX7b60t6Y5QTiZd3peFDm0kw4Whnt1h7BzDRLgNDXN1xDAArqEE6R9Zo8+ibnygb4Yd79WZsi9wxLPred57ejxexCx8ZvzU5ibd1UyHAh10GOsvAUz2+ZfZqdSEwQzsq4UrJAgQeJQCWiWuoaXmYuK192Bp5rLpTX9lxO0VLLilOSINaef/CIItHwUlxCd1yga0VhixPrv7b+nzN4+7HLotZIRcDWudMtsywafqAHKPM1yKaMQ7SP4BD/eWvywpAeYQ4EPhlp+MniyeOd/tzyAUyRsOe4wCtL9eYLT2gO+iCISW3ZS2djqr/CWEbivtM3B3E9/YE948bA41tULWwyxMFNjyFFt+cUUHpwvk/QKBaFY+tw3o/0kAT3U3Nwi80=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(4326008)(7696005)(186003)(6666004)(82310400005)(1076003)(478600001)(8936002)(110136005)(16526019)(54906003)(70586007)(7406005)(336012)(47076005)(426003)(2616005)(36756003)(26005)(70206006)(2906002)(7636003)(41300700001)(36860700001)(356005)(7416002)(40460700003)(8676002)(316002)(5660300002)(7366002)(40480700001)(82740400003)(921005)(21314003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 03:25:29.3504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b706260a-84d9-4945-0731-08daa68140d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the block layer helper to initialize the common fields of tag_set
such as blk_mq_ops, number of h/w queues, queue depth, command size,
numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
is spread all over the block drivers. This avoids the code repetation of
the inialization code of the tag set in current block drivers and any
future ones.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/amiflop.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 4c8b2ba579ee..af3f9a4b46ab 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1813,12 +1813,10 @@ static int fd_alloc_drive(int drive)
 		goto out;
 
 	memset(&unit[drive].tag_set, 0, sizeof(unit[drive].tag_set));
-	unit[drive].tag_set.ops = &amiflop_mq_ops;
-	unit[drive].tag_set.nr_hw_queues = 1;
+	blk_mq_init_tag_set(&unit[drive].tag_set, &amiflop_mq_ops, 1, 2, 0,
+			NUMA_NO_NODE, 0, BLK_MQ_F_SHOULD_MERGE, NULL);
 	unit[drive].tag_set.nr_maps = 1;
-	unit[drive].tag_set.queue_depth = 2;
-	unit[drive].tag_set.numa_node = NUMA_NO_NODE;
-	unit[drive].tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+
 	if (blk_mq_alloc_tag_set(&unit[drive].tag_set))
 		goto out_cleanup_trackbuf;
 
-- 
2.29.0

