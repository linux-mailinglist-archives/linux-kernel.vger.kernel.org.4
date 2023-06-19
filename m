Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C520A735C72
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjFSQy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjFSQyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:54:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EDE9E;
        Mon, 19 Jun 2023 09:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHbCZs8LBhfB3UoGhOnq5RBONC0h1g1W8HRI3xAbvoGu/vtMKuLvwjzWCCDiL7iAh938rgm50D+aCJf0CThx9z7WKAnKT/v3cGO2EiX2CLDilSyMEsmpZUls1iZj15RBfy3SQKFY5IuhuV6J6jakBQbLr27zAj32XvKK2MMKmbaL3y/p00UpDAsJJe/nNde72Ty5B4sATgBy+8SZ7mjXe1Cx2TCZ4Rlqz8bDz0jQxtzbKjxpPnmvTqyDbJ7EG4ptyjEZEIGHrQozHbwq8TbHDv5rCCUSpG2vYV6EBBOYBl6Gpd6wNV2VcWullDXKuKCfidnzT1yJHKlBvrPIkMNxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOqELVAQ6GcJ+A+evtviUV/bXiC/lFz0X13IUXIK5bY=;
 b=nwqEdw0D8JxxoSrDXv23BknjEdXzCthpGCROSy/rUUeKRE+hbRqlpYCaFKp1l6bmVHbogBbJgHmsC+p+a9Zwr57nNLC/0eqMnNZ2tS+HySvyKkqHRvh1h72UI4qz7fNzmP3RoObiaRWULVQ4a5PONUo6N+rxAppSkp22JbYXiN3D8VjHOAy4BRgnBllKBkpiflATpb3695vDNvHjFiDExCyYpl0nxrjiZ6WpcCwrNHGM2ps37gVuyqW4mSn63yEK1v7g/iD3xrHfZhLcXwaP/6Lo3TVrVlj+jozqPsvO8Udk0GC6DnNoMTz6XnBDdqHSupo2efwVAd2uW8gQ4KffMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOqELVAQ6GcJ+A+evtviUV/bXiC/lFz0X13IUXIK5bY=;
 b=BiHpPJW+gwDTR3tQXrXxod6oNQ75DtntAkLqtTUhXeojrZaK+OjMfke19HeyzhUXIDvxJuJQ2A3XLvDi+IgngdztxkscJD46ZZliNqcq54sK3yVAJ3cVsWPKaTJeIL2Xb4l7uO2iqxsvJUgoYU6RX9CRlzsbUb2tBkSwdLIWg6E=
Received: from BN9PR03CA0572.namprd03.prod.outlook.com (2603:10b6:408:10d::7)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 16:54:51 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::d) by BN9PR03CA0572.outlook.office365.com
 (2603:10b6:408:10d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 16:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.36 via Frontend Transport; Mon, 19 Jun 2023 16:54:50 +0000
Received: from amd-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 11:54:49 -0500
From:   Baskaran Kannan <Baski.Kannan@amd.com>
To:     <Mario.Limonciello@amd.com>, <babu.moger@amd.com>,
        <baski.kannan@amd.com>, <clemens@ladisch.de>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Baskaran Kannan <Baski.Kannan@amd.com>
Subject: [PATCH v3] hwmon: (k10temp) Enable AMD3255 Proc to show negative temperature
Date:   Mon, 19 Jun 2023 11:54:14 -0500
Message-ID: <20230619165413.806450-1-Baski.Kannan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f12799-a3c8-4fa9-e350-08db70e5e597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSN3nkv9NQd7lAHL0U4JxCG1cjsbj5KgkR6S+Ug1yarC0jALDgefA93DMhqzY0djxPBSWoMowEN5d5eMVF0l+GxbucCOt4DOlQue417DduFB5Ap+U0A4Zp3bzpg3Ye7SzljoMm/zYiWxaVcHfm7nN7UCVebOuLhmP2H3JXdQSWH7mX7hI0dx3D99KqHsqrVvf/R9Y6PXZEICcbi/+81/E9O8PfvGhkXPmjJ7OxDMCvjnnVqn+ihBD2IX25tmlx7rQ/aXgursqE55Pv3vThgm6sluuF2vPemA8mLHA9gWOFBTISD/0pbdSQCSR4f02To1YSBXP0wWPSQMHEDhxUD6AakiAMlIMRa/tPgNvRIK5fGB/Ni1XbtIEy5e0hONpKoX/qWc6zH+yQhASvtCtZiadJb20IjD67kVxlxEgT2R665bbQyZqFN8anbZ7ZYwRait67tohNaeANVp7uXV1tzI+OnO9ecnIysdFK0zgeYpCxQCUM9h/ZJMeriaj9cPzo7sFo5PFn8pfgIJC4Y3dBMTQ286DHAkY34bQ2dJr3lcJbdNbqR/deFzPiO3TLnBNPEZgS/ZIr7DITRa4jFODu4O7Hen0X2ovc1TIGUmsJCa7VMu4f++2SGYbXciay75WbQcl5MdE5UzzlRfCDG0PAQeoqxUy3A7tN1LxIG7LYV54yPikahprsCh39JAiav0y8UadXDAQEtqaJvxnowjzFyIogsPaNstxYobtFew60iDeU3msH0fn1EZpWMjx4hyfQFhB5SHqq8gK/76j+o0L0NE9K4iakC1BYPXjKVvpMp7Wok=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(4326008)(478600001)(110136005)(7696005)(40460700003)(1076003)(26005)(16526019)(186003)(40480700001)(6666004)(36756003)(2906002)(8676002)(41300700001)(8936002)(70206006)(70586007)(316002)(5660300002)(82310400005)(83380400001)(47076005)(86362001)(426003)(336012)(81166007)(356005)(2616005)(36860700001)(82740400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 16:54:50.4502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f12799-a3c8-4fa9-e350-08db70e5e597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Industrial processor i3255 supports temperatures -40 deg celcius
to 105 deg Celcius. The current implementation of k10temp_read_temp
rounds off any negative
temperatures to '0'. To fix this, the following changes have been made.
Added a flag 'disp_negative' to struct k10temp_data to support
AMD i3255 processors. Flag 'disp_negative' is set if 3255 processor
is found during k10temp_probe.  Flag 'disp_negative' is used to determine
whether to round off negative temperatures to '0' in k10temp_read_temp.

Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
---
 drivers/hwmon/k10temp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 7b177b9fbb09..2613420d43ff 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -86,6 +86,7 @@ struct k10temp_data {
 	u32 show_temp;
 	bool is_zen;
 	u32 ccd_offset;
+	bool disp_negative;
 };
 
 #define TCTL_BIT	0
@@ -204,12 +205,12 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 		switch (channel) {
 		case 0:		/* Tctl */
 			*val = get_raw_temp(data);
-			if (*val < 0)
+			if (*val < 0 && !data->disp_negative)
 				*val = 0;
 			break;
 		case 1:		/* Tdie */
 			*val = get_raw_temp(data) - data->temp_offset;
-			if (*val < 0)
+			if (*val < 0 && !data->disp_negative)
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
@@ -405,6 +406,9 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	data->pdev = pdev;
 	data->show_temp |= BIT(TCTL_BIT);	/* Always show Tctl */
 
+	if (boot_cpu_data.x86 == 0x17 && boot_cpu_data.x86_model < 0x8)
+		data->disp_negative = true;
+
 	if (boot_cpu_data.x86 == 0x15 &&
 	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
 	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
-- 
2.25.1

