Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989BB620865
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiKHEpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiKHEpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:45:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B4F1114D;
        Mon,  7 Nov 2022 20:45:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b08rZ+ARVyEEzdpD0L+pMTKvDKCxRrbfa1HbpdP9upEQPiUaZp9upiXCmqB9dNfqd/63s+WMGbu+tLy+0k96TZnGWUnpGwLy2xRgogzAbfGxhAuuFMNwv227guqFWzgY2hC4pMScQAIzBmK+E/MC1kEz9BW5z2rY87KmcbUI4M04TKpljKjlQBkRk6seddmwgdf9wD6Me9FIAaiiloTo/CgLZBSPGiIYEr2cxVAmyG1eca6+eVtvqR8NiBzMON0fSlfttRnoSwGB6NcW1V4knwpeOFFwqMUYVRjyvcRfQNPVla3EANXNSqzGv8incwOsIj1z9aOieN7AZCg0XM7uyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LF2yEMVusXBv9OlCVp0YyA7imPGc0nKrCO8HVZ1ywD8=;
 b=QhSvJt8GoIMe9vFjBkvffsWgkCOa5geoSPtsOvh7KtcYOtmsfTyPSgvHNovQx5iYFNFNbpaAxFsnd4cwpVeNmjC1ecD7ym1RR2g7u971pGr4uHhAlsWIU9QNsrmC6lA0z0SBIPB5jh7oOBMqbN8WOahyLPhs6Hd8UOjyCxyRHuV6YXn8Y4FQW4nvLhopvAr/F9wSNor/feKFf6Kp9NM3oXSVvWC/1ielJCUk33zqX6yOCt5bGzmofF26xHnprjV/TsJ5u7AfJo3x5w2cu/gBSAjvTOL46eGS59jll4DqfKOXV5We7f2GSFISQdfgbauKXLI7kOLEueaalLzH7Lj1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LF2yEMVusXBv9OlCVp0YyA7imPGc0nKrCO8HVZ1ywD8=;
 b=eo8iQGbbEX0M1QLk+ZtT95BfG75y2cZVHj7EQ4k2PzB+Mr3LqBQAPwdbV71jToDXJTl1lowzb5pfaXPslcHBuXTuBRzg3pV29xU5f/ID1WpRqhVRNQtLyawb6snC5F0+zRrR/9jXGmrK3cIbIMKQCHELa3joXaxrl+kLCs1mAHxj3ZwL/AOGZghTdE40fmM3zCI7p/ilWCKQodUUqu83s/PAcxX8bmY9QkZp8Jd3UL0i57CY1qTIZZ+D5/yz2xIuivM+nCBycnJf4GR3sVMmsnN3k2dIC/XVT6hyP4nzUdIQ8G3jbhEZHLYE/KUxgkRm1y9da2M0u2ei982DTF6cmw==
Received: from DM6PR03CA0099.namprd03.prod.outlook.com (2603:10b6:5:333::32)
 by DM6PR12MB4564.namprd12.prod.outlook.com (2603:10b6:5:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 04:45:27 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::4f) by DM6PR03CA0099.outlook.office365.com
 (2603:10b6:5:333::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Tue, 8 Nov 2022 04:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Tue, 8 Nov 2022 04:45:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 20:45:19 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 20:45:18 -0800
Received: from nmalwade-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 20:45:16 -0800
From:   Ninad Malwade <nmalwade@nvidia.com>
To:     <nmalwade@nvidia.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux@roeck-us.net>, <jdelvare@suse.com>,
        <nicolinc@nvidia.com>, <rkasirajan@nvidia.com>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH] ina3221: Fix shunt sum critical calculation
Date:   Tue, 8 Nov 2022 12:45:08 +0800
Message-ID: <20221108044508.23463-1-nmalwade@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|DM6PR12MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 24254b52-faf8-42f4-4fd4-08dac1440e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGk4oKv23Eb0Vb+BCfg1/177UyVsOWmEQLg/VtZV/cWeLxJNvA1cSr0INGM4/EBqHnAndZQaYYn6/XVjk819b/MqCXCe4lucJnHeWsjciZ2FXVfeGYUjeTvILzlN3lVABqYYVWk94kzkMLruhy+kCm2K/MBq1zSaKiIR9m0gJEU8bfjFWqn5+FPkWZj391Tkj9YWmbOB7VV/yF5nsgFYyAII78OLmJRKCaYqi7MmxJLzEpOdD1OzB6X6ZI7iZSs+LRL/hWGVIlzG7gL5m3RYvhjF4hH+yPwSOVXa1kso7xIwsz/3JxDTLvENYgdBvc9S+OaGBA7/kSydtwqWWhz4P3kfO3x9uPLw7vn+HSjUg9rQ2ycn1mCSVChp8dexEOMkAu4BZU31yK+5llfhupjA3xos+g5RF/16OcUuGIxpPrMniUz0e/PXJgIBqa50L4ovAd678LZDfG8npOV8w6gykQKKMuMp5H2hcFshGbLSJGTGhQhKAXjhUQmXD9amAGn8KQcES87cg6i6J6cxDvNhJitMZ25HkOWPC9JiZOkzeF1YlIU5ZrP4+Fqc5cmBcxtXXNXgqXbXeIaTHo5Q8Ch3REUjWyzJxxOpYLySMZvu15YGkZcAYW3OsysOVE/iX0ryFMzv0dnZP26rjINec2T5hu0AK39xi5y+p2hd2HmJ3Z+CDDVJWxw88bxY71pAyb2tX+K//O6QkH7J6h0XTaOY0B9NmidAYXhFm2XME34+JOUH6M87l3yxAy7tknXTR4jstOOdwHaBMMTRxJZam2cPcw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(2616005)(47076005)(426003)(1076003)(336012)(186003)(6666004)(7696005)(36860700001)(83380400001)(26005)(40460700003)(6636002)(2906002)(40480700001)(82310400005)(8936002)(8676002)(110136005)(54906003)(478600001)(5660300002)(41300700001)(316002)(70586007)(70206006)(4326008)(36756003)(82740400003)(356005)(7636003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 04:45:27.1256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24254b52-faf8-42f4-4fd4-08dac1440e93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4564
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shunt sum critical limit register value should be left shifted
by one bit as its LSB-0 is a reserved bit.

Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
---
 drivers/hwmon/ina3221.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 2a57f4b60c29..e06186986444 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -228,7 +228,7 @@ static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
 	 * Shunt Voltage Sum register has 14-bit value with 1-bit shift
 	 * Other Shunt Voltage registers have 12 bits with 3-bit shift
 	 */
-	if (reg == INA3221_SHUNT_SUM)
+	if (reg == INA3221_SHUNT_SUM || reg == INA3221_CRIT_SUM)
 		*val = sign_extend32(regval >> 1, 14);
 	else
 		*val = sign_extend32(regval >> 3, 12);
@@ -465,7 +465,7 @@ static int ina3221_write_curr(struct device *dev, u32 attr,
 	 *     SHUNT_SUM: (1 / 40uV) << 1 = 1 / 20uV
 	 *     SHUNT[1-3]: (1 / 40uV) << 3 = 1 / 5uV
 	 */
-	if (reg == INA3221_SHUNT_SUM)
+	if (reg == INA3221_SHUNT_SUM || reg == INA3221_CRIT_SUM)
 		regval = DIV_ROUND_CLOSEST(voltage_uv, 20) & 0xfffe;
 	else
 		regval = DIV_ROUND_CLOSEST(voltage_uv, 5) & 0xfff8;
-- 
2.17.1

