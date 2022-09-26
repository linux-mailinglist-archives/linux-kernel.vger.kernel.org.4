Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EBA5E9E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbiIZKGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiIZKGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:06:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01FE38441;
        Mon, 26 Sep 2022 03:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oz+ON55DcCX0utt7sc2xiF3D/nMmufceUUB6TaCUie3FfcD8siAFR76wHQo9JY6ieFOz7lqjODThDk4R3P7O3ju9dF4CR7Ud8CPHZTxaGvnR7L5SckODIV/Y74w6Wyks3fc0/XlMUd+01UQtfi2BciTHbhw5PsW9S48RmPQYYaZHhw23xXJL1dA4k09+mh2wGAooASQslkjnk0iO2/ycrN7rJDHb1cfe/tn7kmLl4HTcF33Jd75jx7382E69W7nJUDGJAmtpE+zwJjVcikpD8j8SDU1bt9Jx/cQRXYcnV0Dxrp86kfmnZwiYB/8ZOGRXMKbQTArRmgmnaVUpMXQ/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EMNRwBTrDkY2Fmxr9AgGiUDWbZFZSxtWPymL7LXPyg=;
 b=fcbKvSg7VeeiMkhTx50/MOyf9BQnIflAzPEcFs7vjBkKH6CbfmwK51cZ+xu37AqmIP9BBzRGe+sRb6hT+bmNuEoXjrbbrCxg3cb+01d9wq0Z54q4vSpGGwPdgS8saIs1H5wmABXGyHNqZ6dxFKH0upzJPmbwlSj14bEeqX5/2o70ry64UZ0J6leDhJ2CtpSMosKgibfcyFYWZ6OymY5RiiHYXXMamONHRLbMYwSJdh3QxoVHIgX1TDK+PR+8GKpUJ/NhaYiEUsUBDqoTu0WhhIfPI8ssL6FAM0XCgB0QkCcEKLu3wCqshobykWoDMfV90s7xBuoeE+Ie1OCdQC5jUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EMNRwBTrDkY2Fmxr9AgGiUDWbZFZSxtWPymL7LXPyg=;
 b=I4Z8rHpY35jYvTn2YYJRK9giTSO+BPkaggN2LITAoY4omdX3es4UOsg/opZ6EQ09YSBGydJ2irbNg5GyJxyZ6mI+riqk4JLu3iV4af7LFX6SLi3PQtizU398EUW7uEXpqY1dMN677IDiKxSS88Mb6im9j+RMC8xOdNGveso3Mtb1gxzuONDIGvBdXzVtNqCHZMoFJr7QLebUpMB0csnp5tTVh3q6lngPEBVWIqlr7fh4D8KwAPfv2Sa42FFh5u0ZdPeZ3irkKpFkqgbXRyZjcwsBDO155pYGmosjz8RqakRY+JPTfsTXsUEM18qgxUNiJj6hRo3sI8brOcS/rRp/wQ==
Received: from DS7PR03CA0312.namprd03.prod.outlook.com (2603:10b6:8:2b::21) by
 CH2PR12MB5513.namprd12.prod.outlook.com (2603:10b6:610:68::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.25; Mon, 26 Sep 2022 10:06:11 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::30) by DS7PR03CA0312.outlook.office365.com
 (2603:10b6:8:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 10:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 10:06:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 03:06:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 26 Sep 2022 03:06:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 26 Sep 2022 03:06:02 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 03:06:00 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <windhl@126.com>, <sumitg@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] soc/tegra: fuse: Export tegra_get_platform() & tegra_is_silicon()
Date:   Mon, 26 Sep 2022 15:35:59 +0530
Message-ID: <1664186759-9821-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|CH2PR12MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3f1f67-c7ff-47bd-454e-08da9fa6bd3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuG76WlqXfUrc64YwC/keUE2YNI90Pez9qUVKhc9n9UcyGwdLmcAMLqImAaVQ54E4u4qDDdq1U/ga5ZjaTWZ8GY3w2wG/bLLj83M7Sgsg3ldGEwecZAdS3lLcDke/be8DuDZzROdyMzMhuEI6mnq5y9hvC93RDxwT6HNviIhPNnMOZFbQgz9FfNV++nYef4nN2F3IdoD7uD1teyMIAD7GmcYnfjrgEzpanDw1apldoq1lINZTyIz03Ui43JDbsmWGhFkmtgxK6h16aX9pnibYX7EwUBTQoBUbHulF2UwZldaunLDq4DZNkcUjFPRJdTrkDaRqQtJElwTA7ejGCGUgKkM9povDA90prWnqd4wCLPPIuGDhvN4cqeJdtjiRPsr6ufHWikQQ1B9Pd5LIfD3O1VHtDYcAN5ecLTVGyc+u8CF00P6FrH3ahd7T1ny350H46e3wvHJhM0YN7XkPPwOWaRO3d4iyvgwl1y6sY5aHB6ZQulcPbeFvu2RXXtRsin7s6wVq0mBV5iqOKfTrRu2+tpw9KRfzLFQVozHQhmLnypX6k6xwQsoy8AywRm1dW9+byUWqp0KU89iAqEdi98W0d+4WCfe9tVNuVUZ6SFsZgIGwmHUd+RDnR3Jg3EU5P5G+sYoF5Qnor9tbtCZmWvLarm0SNRiDx4IqSKohdqp+wQWX06y+3lkPJUofUUgeK+vZHGkosalCDFiasCVyg66E2tT5TrA28xPxcYGYrFfxtHcDljsHv7WyPNu/VaYqMK4dMXA9yJvevghmXITHqGGEK3VNvX2mZ1Fj8Z+MSYYufs=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(336012)(426003)(36756003)(47076005)(82740400003)(356005)(40460700003)(8676002)(36860700001)(7636003)(70206006)(70586007)(8936002)(4744005)(2906002)(5660300002)(86362001)(7696005)(82310400005)(2616005)(186003)(478600001)(40480700001)(41300700001)(110136005)(316002)(26005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 10:06:11.3015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3f1f67-c7ff-47bd-454e-08da9fa6bd3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5513
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions tegra_get_platform() and tegra_is_silicon() are required
for pre-silicon development to correctly identify the platform on
which the software is running.

Export tegra_get_platform() and tegra_is_silicon(), so they can be
used for pre-slicon development of device drivers and kernel space
tests.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 3351bd872ab2..904797f651a1 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -56,6 +56,7 @@ u8 tegra_get_platform(void)
 {
 	return (tegra_read_chipid() >> 20) & 0xf;
 }
+EXPORT_SYMBOL(tegra_get_platform);
 
 bool tegra_is_silicon(void)
 {
@@ -76,6 +77,7 @@ bool tegra_is_silicon(void)
 	 */
 	return true;
 }
+EXPORT_SYMBOL(tegra_is_silicon);
 
 u32 tegra_read_straps(void)
 {
-- 
2.17.1

