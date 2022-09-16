Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C945BB21C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIPS1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiIPS0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:26:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720BEB6D7E;
        Fri, 16 Sep 2022 11:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGH9JwdIu2rc4vaOrc3w0AIhCpEoF8YIiMM4lgaa8cP2pOdnEHRqGkrufuCHAZ+yRkt3DqNpqfoAKA/I2mjb973n/RyH3U1RgnlqX+p8ET/GVghIXXzgrRpZq2HuI5ThifL3CelPBWzWpWxEKwBkMUWeO8wBxNsMNSdKWmeoGp45ttGtDW9w+t05I/p+GYXUhkdOwP8FFyJhEAnSXECqtirjFfADFpQ7TlRA2NcZ1PzH4lk4ZBKLxCHzBrKUbM93OXkJzF8PbicBrTZ36AsF8vRqj0VtJMNX9O0IIbVr4p1W0nUUBmRTy47Wtee3sBy+m1tnwcHjkUIVK/GPRT+DkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJm2EnFFi2RnO/ktg5JU9Ghz8mVgR90GXT1HwnJiNlc=;
 b=HZulTG293CTfZEuCYd9eEoHfrOLuOalvW/8w7Y8JhVLg8JU5yLXuRmvWnsRjEZ6OW71DHpxI0V1Mg5IZs10U62ccs+E0FIf/VGHV07QpYo0Ksz4paHF83qtgoIhSZ0fTkU9/vCwnKpwMtv3kdlHV0FFIBPKkYdzRgsGqsiYJ4vYEQ2gAaHfX8Bql7ZiYvPyAsrVJunzSF+gB0XAo25j7i9P/3mBVBYaXt9XtCITEB9nqufJWaVn7AgL8oKtwATkNTVUmP6pCkn3WEUZHo+69JMNFmiS5d9lDM2N3ZxDyPkACoWZJ58q2mMtvZQlY89I17LzpSRFTjNUbEW53N7Y0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJm2EnFFi2RnO/ktg5JU9Ghz8mVgR90GXT1HwnJiNlc=;
 b=F47gj/B3tK9Zn1p4HxXYIn4DaFhs1pY8zGXqsJEufVqfQ8cGVoksWOe4gciyo6fIMU0h0vcJfJGAmAqj8d/67KQoQIAQ4wmOvrZpyIASoWWeiX1ftQIbMf/dPu35hUBesDz/TMYV7SFAZnjkzsGnhk5k7/Me+vJKvSC4hMln1VE=
Received: from BY5PR17CA0018.namprd17.prod.outlook.com (2603:10b6:a03:1b8::31)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 18:26:29 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::ed) by BY5PR17CA0018.outlook.office365.com
 (2603:10b6:a03:1b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 18:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Fri, 16 Sep 2022 18:26:29 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 13:26:24 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <travisghansen@yahoo.com>, <catalin@antebit.com>,
        <Shyam-sundar.S-k@amd.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        <philipp.zabel@gmail.com>, "Sebastian S ." <iam@decentr.al>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Len Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH v3 7/7] acpi/x86: s2idle: Add a quirk for ASUSTeK COMPUTER INC. ROG Flow X13
Date:   Fri, 16 Sep 2022 13:26:09 -0500
Message-ID: <20220916182609.3039-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916182609.3039-1-mario.limonciello@amd.com>
References: <20220916182609.3039-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|DM6PR12MB4943:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f1622a-74be-484b-b89d-08da9810f92d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WEMhEe7dKl6c67U8ytcC637xpaooi8orAVHgBVPqWjtAxGoHxDyRplX9GGGLozjISVwe3+02wh99IMyw2IxWhRnLBzmBBznAg51PqCta6sHK4Rud4kCjCsQpKymNu4mCe8MCW0wc2lwtKBQKgyYkq+M5yeQ7mTWS8VGZKiTovbGs4KOXqzGvDgCNLNZ+nI5OEiM28snkzflBBsUvDN/CUk3Oh7MRVxxetZ9HqKD2uxfwm9YC8JX+9vuMYhuRg5YJGXW3/nAamKBy0Cdrw9ffwsXksNjJ2mfn7EAQJSF+F95NAoFpibhM/sUHt8VfdQszq7pW8nHyU9K8iL6gaxh9OIZbLdI4AcIuWs40fx+BY1qhnX6Pd+kKfTSX9z7l2wWoCDtwqVCH8JkfIX8lZ3QKZpq/+xpAHMlDLP09WPpbscCJC55kPiDy73Y/HD2lhuOxtS8aBsc0e2h6e7Kl9DVpyNc+GhcGQLl4TVJjmucrkc3+7h6ehB784EwwwYDfsebUZPXzQi60sY2fUTpzMFxd7Mmo/9oUZsm8OqJ7nMoomjGLVaYBIpWxWU8/B0IMOAllxP9PkutGQHXyPhL9gh9j5KNjvIRKx9JQ58Nc/SNsFqVnxWWBU4p6iV/M+YvB79qZd7PALY6nJ8YfcEjXSLCBzmTEebQNMqb3hCeizveFZUVN1WLc4QiVCYdyyOQ5QCZ9YviJbuaAmHgaxIRpEAXf8mEsx/ke6rTLWWfjK9jFgTf69zxD9Lp5HcJ7SQBd0Wf
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(86362001)(7416002)(44832011)(5660300002)(966005)(8676002)(110136005)(26005)(36860700001)(40460700003)(70206006)(54906003)(70586007)(2906002)(336012)(4326008)(8936002)(41300700001)(316002)(36756003)(45080400002)(478600001)(1076003)(81166007)(6666004)(356005)(82740400003)(7696005)(426003)(16526019)(186003)(82310400005)(40480700001)(47076005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:26:29.1892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f1622a-74be-484b-b89d-08da9810f92d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUSTeK COMPUTER INC. ROG Flow X13 has a problem with fans upon wakeup from
s2idle. In examining the ASL, functions 3 and 4 are not called in the AMD
codepath but only in the Microsoft codepath.

Add the system to the quirk list to force Microsoft codepath.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2148
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * New patch
---
 drivers/acpi/x86/s2idle.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 9c84eb068e19..d6fab1eb6a83 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -440,6 +440,17 @@ static const struct dmi_system_id s2idle_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82"),
 		},
 	},
+	{
+		/*
+		 * ASUSTeK COMPUTER INC. ROG Flow X13 GV301RE_GV301RE
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/2148
+		 */
+		.callback = lps0_prefer_microsoft,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Flow X13 GV301"),
+		},
+	},
 	{}
 };
 
-- 
2.34.1

