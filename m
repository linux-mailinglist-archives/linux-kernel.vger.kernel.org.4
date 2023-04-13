Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9386E1691
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDMVkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDMVkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:40:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C4D4489;
        Thu, 13 Apr 2023 14:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ2uKVHK032ulsuKc/G8IJTYN/qK1zHjDjFs55eSzWdkm/RqsHWMHMSgcAFe+xOHrJCMhNHyqjHQ4PGftbBcVL11x2vUhPeoHIZ0DlI5ov0xFIKazeED5tjS318Mq4F9Im9dvbY/gXYPLi5Eebc/Kwu3rETk7+ZmB9jtEKk4H4+h46fkTnOeb+zaeHZwOCneJxCCnETCDAABOy9ShdMDu1BDzVpNIZ8vtoMN55Uhe5Ka8XSRRO8/3L0LGHUSCM1u1HabpFo17kX245Eaqek5lD+kLEhQaZzJJedxxO30KbTsWFjMxT2tbAaZhasjqJYIFYzI0Uq9gWzEcEBojFI5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiHuUUfrrrH6loJm8iG6n+fxqUJFZfXt7+aVHIqiuo0=;
 b=X9DbayXVPzuFYsk601gDjUu/5GGV7OO617EpEEJyQtl9acYlaufyqDRqB2y93FyyJfU24XjuVAd9NXmbg7+adffptWCijTEy5OSjcKw/0mUMfcCqHOA0X3PztVv4Bs828e2w2W4wD5KcLNF7dWhkFTj9aKhYTJOe4Uulx5oN4P7qT8bnBJYTciuXOhFLhjg8BKx0v2efH0wG2GIgpQMHO/Flad5yyMYLNKHMUwJhZ4HdmsIB07qNUrm8Kh/i+T+buVaNH9olwLisHenmw7y4j/MU1HbaVvPNzcm0gHQm8RyWDDoqYefrw/KR4BZyI/rrVlIWyu1XOibva8r/YAKuMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiHuUUfrrrH6loJm8iG6n+fxqUJFZfXt7+aVHIqiuo0=;
 b=c9goM+M/tQOpse/EAFaKMoDWdsqJ3JOf7ftXnjJqh149C3Ug+NaPwqD1rX8crqhjCFSjAarLx3Bat/fMLMqlDQpz/Zgodc0rLbSwEGNzcvFY612xHA1HHT7j+CYScm0XhZs8GxA5aGnXAYYCmp5DRcdxfzIxEjDPCFO+yFWmmLc=
Received: from BN9PR03CA0919.namprd03.prod.outlook.com (2603:10b6:408:107::24)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 21:40:13 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::82) by BN9PR03CA0919.outlook.office365.com
 (2603:10b6:408:107::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.32 via Frontend
 Transport; Thu, 13 Apr 2023 21:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Thu, 13 Apr 2023 21:40:12 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 13 Apr
 2023 16:40:11 -0500
From:   Babu Moger <babu.moger@amd.com>
To:     <clemens@ladisch.de>, <jdelvare@suse.com>, <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <babu.moger@amd.com>, <Baski.Kannan@amd.com>,
        <yannick.hemery@corp.ovh.com>
Subject: [PATCH] hwmon: (k10temp): Check range scale when CUR_TEMP register is read-write
Date:   Thu, 13 Apr 2023 16:39:58 -0500
Message-ID: <20230413213958.847634-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: a77c57ce-c90a-422d-c00e-08db3c67a978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/tbKcZdimLSykOTyEeJYV50MG1ba9tVAnIranCvveQNhU7R1sz6go1KDUmLJocPVakLNHhyYDOqWp8u5KcrY3WztmP/N++2OOfTDAQMYC89GltSveenrVxVvvQZ9VMBpX7CosvbCWqXrcLXQUvzdV/e02UfwhByPZEdvHU4nngJoTlTkhugJQFvu3rxJZvBgUzkQMOrTU0O181LmskmtgLYqr6N1lEmYS4uA6FwaWuCOv4nOUY3ej+3qJnvkJE3p5f3QBtKMzMrIkkTB8JBQLdwWIUaDNLI6yyguZ88RfLgyK3sW51l786qwUK1A0Gpbo9/yx6Yovrh7j9xJUpoEJVs+eRMjTYygV5PvYCDuUGBWVeVhmjuEzo1nTqNHjdB+iLDcm6DEP26XA+5AiB391nmViNiGJOFYSnIE9m5nh/WiDxC1pAhKL4E2ZtnmlwyPs5rbzmGIBeTim+UqN1GgPM4b9KqHyWezXGx4iy5wifK+aNr+tpcRCa5ImebJZja65ehPsJhezmSLl5qD57BrqYG+HlRxG0y7HK6XAZDlfKvbNGDTOAbHlLUZuHDVKFCdcf9UcDMixIru5vqXtIMZOpHuQPQeAXhEx8oGZ4Dcq+4bwE8KUdudpPgXubIXjgRJ7w5Py/9I6UMK/rvQeNRIa16BiBvpC6/47hxj/pB2QfS+tvrvbgQzHxzH2rOZN51QUcvYem3b/cXeLsSU+OTCZ40zWi2i/LrrohYF0G/Tzc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(36756003)(4326008)(70586007)(70206006)(110136005)(2906002)(44832011)(86362001)(81166007)(356005)(41300700001)(5660300002)(8676002)(8936002)(82740400003)(82310400005)(316002)(478600001)(40480700001)(54906003)(1076003)(336012)(26005)(426003)(2616005)(36860700001)(16526019)(186003)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 21:40:12.5305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77c57ce-c90a-422d-c00e-08db3c67a978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Babu Moger <Babu.Moger@amd.com>

Spec says, when CUR_TEMP_TJ_SEL == 3 and CUR_TEMP_RANGE_SEL == 0,
it should use RangeUnadjusted is 0, which is (CurTmp*0.125 -49) C. The
CUR_TEMP register is read-write when CUR_TEMP_TJ_SEL == 3 (bit 17-16).

Add the check to detect it.

Sensors command's output before the patch.
$sensors
 k10temp-pci-00c3
 Adapter: PCI adapter
 Tctl:         +76.6°C <- Wrong value
 Tccd1:        +26.5°C
 Tccd2:        +27.5°C
 Tccd3:        +27.2°C
 Tccd4:        +27.5°C
 Tccd5:        +26.0°C
 Tccd6:        +26.2°C
 Tccd7:        +25.0°C
 Tccd8:        +26.5°C

Sensors command's output after the patch.
$sensors
 k10temp-pci-00c3
 Adapter: PCI adapter
 Tctl:         +28.8°C <- corrected value
 Tccd1:        +27.5°C
 Tccd2:        +28.5°C
 Tccd3:        +28.5°C
 Tccd4:        +28.5°C
 Tccd5:        +27.0°C
 Tccd6:        +27.5°C
 Tccd7:        +27.0°C
 Tccd8:        +27.5°C

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 drivers/hwmon/k10temp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 5a9d47a229e4..be8bbb1c3a02 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -75,6 +75,7 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 
 #define ZEN_CUR_TEMP_SHIFT			21
 #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
+#define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
 
 struct k10temp_data {
 	struct pci_dev *pdev;
@@ -155,7 +156,8 @@ static long get_raw_temp(struct k10temp_data *data)
 
 	data->read_tempreg(data->pdev, &regval);
 	temp = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
-	if (regval & data->temp_adjust_mask)
+	if ((regval & data->temp_adjust_mask) ||
+	    (regval & ZEN_CUR_TEMP_TJ_SEL_MASK) == ZEN_CUR_TEMP_TJ_SEL_MASK)
 		temp -= 49000;
 	return temp;
 }
-- 
2.34.1

