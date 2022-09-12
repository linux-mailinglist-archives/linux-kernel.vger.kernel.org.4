Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470415B5F40
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiILRYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiILRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:24:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926C73FA0F;
        Mon, 12 Sep 2022 10:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhAX0W1iGnZw6TVqWK4KibxPBXskLURpulmkKMp2Fvei9b0BL8t2FWEA5scl3LhhaoSVKz2EVpL3b2jqqZqfE2rQciSHhdq0phQuadeLgt0oarJQkg29MYXM5HojvO2hSa196sbIyD8exN7e7bhNXcuGxnTaohAPRRYGDDyacsOjbF+XOY10JLRSaFnB4CGJhPTIiqziuNvJ3WEKMLg4OslLHekgwLWGCg5UVx2+QHnRl468jjdqGlRQwQpmuziJOo74QtGxxGUY+qv3os/DWB0fiD+cogkw+LU9/43Be4oKl8reK35HQAr+31noLwspN/TCSNUo3OuFgCpwluIPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZpEKY+2zajLTl+lOEyy4FywPK+0qLw1aCaUgpFXfW0=;
 b=ACS9xJQ6TJTdsr5bDd8Ky0iGRwyze5cOUuRu4hmVjd8yzv8k2m8wCioC/ECsGlkVkFt4GmR+0qiDx9f0bQXNeUEFAICujqrrs9NWb/ir2wOZCkeJlRJ3fml5fUdRbCEvinO0o+G2nHjlDXfrCRp7WQTbmw7lQ66O1q00xBT09ZfhnpyaDqhl6gQYmsA/6f8tL6wLBMTdxpZ5G37qDAlDyHh8+0lGdOmyI1EDTes1xKY1di9cBcX0lnB0UDOGeiv15jT+1lorcUbbbqG72DtszjzAzZ/d59ldwA0aMF6kcpEVRtr90smLc1/7PVwGxo01XL5LI0Y4+rcb7ZWuVYAHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZpEKY+2zajLTl+lOEyy4FywPK+0qLw1aCaUgpFXfW0=;
 b=4TiATE/XxLbAz78tinkjSnxIdHK8LkpmybpgPdbL0hhppj3xbSzaULCgjKSBx89P0cG3KRz/pRLMSc/2mTD0sbbmWIvPLicQAE0yT/khaila7ePf+x5UGF90Kl+u0rgZSRyrJcI0d7DDI6phNMZJq1XFODJSBYI+r5/lbjF0vAo=
Received: from BN8PR04CA0008.namprd04.prod.outlook.com (2603:10b6:408:70::21)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 12 Sep
 2022 17:24:03 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::2f) by BN8PR04CA0008.outlook.office365.com
 (2603:10b6:408:70::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Mon, 12 Sep 2022 17:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 17:24:03 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 12:24:01 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <catalin@antebit.com>, <philipp.zabel@gmail.com>,
        <travisghansen@yahoo.com>, <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v2 4/6] acpi/x86: s2idle: Add a quirk for ASUS TUF Gaming A17 FA707RE
Date:   Mon, 12 Sep 2022 12:23:58 -0500
Message-ID: <20220912172401.22301-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912172401.22301-1-mario.limonciello@amd.com>
References: <20220912172401.22301-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f60eca-5a19-45bb-ee50-08da94e396bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /J8/1c59lw7lfFtWqQxJl61T/X3KuIHlTVr342mkqkfXhO/mZJ0Yjk8G7jDjvFRzgME0TyI7R1ryPi1ESGn+KdEfGT3YDTF9WgbwLlyz9+obZeWyisJN/ET6PpoQem35XmZAzYepuqvpLbCATWK0XEDabEfmuhVnFjsocnQ0oyzfFWOkvWJxY8bjT9tUGeQRhxOsNdRTDo3Y5JWofhm3T4MAbPnd4EP2wp6rCHoGXwqb8qmwgAar6+9Tm5AstzeIlAOd/n/5quVNFHODhc3yMrCqKopHMNsQn2N5u+uwqOZHdLccdLU/E+6SgLlvzWs0S+kTGfESWjQsw8VblsxxqlOlaNaEURyHo5sNQHWZXvTb73otNEwQwveDQMpV93KAYHt3+t3zcwLQKM7K5hNIc+mb/7VRFu8q3Yb8dcOwoVzsTPVs/rAM2qhbPZ/B+ZA5dm71TEbJehYNFMxGRlpwtcbQKdRererB3y9L9yD3QVmYBdsWnr4XQjCHytdS7K381Kon8GGgYsIs8r1KLkcK6TQr4dtv7UWNI42O99s2yT0WX8yqwPeNjzHM/MPyTI0vwx7wV+lNMihy4HLNkCvtxsS/prz9uKEX3oGGiJqABGqkos9fFeKSluZhECENeoALzATIE7yudmxdGvCHqJvfRR20MU6J7cdcNkDQo98CVXBGNTPVO3qs2niwqco7PG3jz7pAUKC/NQYPM5Pmp2wbdi5Xr2QFq3mN+oZvMz3v6p5pYUUIO2DPneLLJDhKvmV7Gd2P5WjRJ2Ksx8Lvz59aknwwI3FSTwmI8jHWZPQCyLJ+mzTlzY0aepChiOmVJ4+NnO9B0eU6ipV6CpxN3ygIaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(70586007)(426003)(316002)(36860700001)(6666004)(41300700001)(47076005)(966005)(82740400003)(2616005)(8676002)(16526019)(1076003)(356005)(110136005)(45080400002)(81166007)(8936002)(186003)(5660300002)(44832011)(36756003)(86362001)(82310400005)(478600001)(54906003)(83380400001)(7696005)(40480700001)(4326008)(26005)(40460700003)(70206006)(2906002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 17:24:03.3016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f60eca-5a19-45bb-ee50-08da94e396bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS TUF Gaming A17 FA707RE has problems with ACPI events after
s2idle resume.  It's from a missing call to an ASL method in AMD
the s2idle calling path. Force the system to use the Microsoft
Modern Standby calling path instead.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216101
Reported-and-tested-by: catalin@antebit.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Fixup for __init
---
 drivers/acpi/x86/s2idle.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index a9b0f2b54a1c..9ee734e0c3c5 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -17,6 +17,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/suspend.h>
 
 #include "../sleep.h"
@@ -400,6 +401,28 @@ static const struct acpi_device_id amd_hid_ids[] = {
 	{}
 };
 
+static int lps0_prefer_microsoft(const struct dmi_system_id *id)
+{
+	pr_debug("Preferring Microsoft GUID.\n");
+	prefer_microsoft_guid = true;
+	return 0;
+}
+
+static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
+	{
+		/*
+		 * ASUS TUF Gaming A17 FA707RE
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216101
+		 */
+		.callback = lps0_prefer_microsoft,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS TUF Gaming A17"),
+		},
+	},
+	{}
+};
+
 static int lps0_device_attach(struct acpi_device *adev,
 			      const struct acpi_device_id *not_used)
 {
@@ -566,8 +589,9 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.end = acpi_s2idle_end,
 };
 
-void acpi_s2idle_setup(void)
+void __init acpi_s2idle_setup(void)
 {
+	dmi_check_system(s2idle_dmi_table);
 	acpi_scan_add_handler(&lps0_handler);
 	s2idle_set_ops(&acpi_s2idle_ops_lps0);
 }
-- 
2.34.1

