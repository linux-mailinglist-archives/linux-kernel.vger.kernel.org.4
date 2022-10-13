Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59435FD39F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 05:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiJMDug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 23:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJMDue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 23:50:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C52B6008;
        Wed, 12 Oct 2022 20:50:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWr0ofkOmuHGf5HbNg8RJsLwDjvPV8GCOR6NZpiVX4yHgeQZ94tNOWNUXaZhnb1dRZs9qjP/Fmifsm4KUcKgLt2NpTQFPoPAZ2OtFJVK7jb43MyM2yyScQEdihdsxWbQl5IOXI2kJQhZSP4khMQ9CmwjIxencBQBm5P1F5IsS6OX6zfwKM0u80z9LT4PpdBgK2HkBTiygqz3vX+CeT/jWtr/8HnrL8KB0vk3OsC94YyjYZnZd0JMXDP1H1wmVdM+8xqy1z4QStnWIcvcPkEVvVHjBncv/dpqX5nQAwadtrhGa6hy/fO0c+kj9q4owhQ+907j24RUTZyEQ3YIYSHQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGTc6K3dLxTOxSceEvHbggOLAAKnJSUf92nf/VSuxZ0=;
 b=P/xJES7Cono+BhPDbxddlk4VdMnFO1Yq7wco7NMhbNStmX7cl7J1KWmqI2rp+GENTSLqtK359CmxnbCs3iIXWUix+L+I/y5n6Qy9Q/btVrkwhRAo87QBz6bWwBZX+zvKugYnuuhAdw4EUbtJuIjvIUQB6CjZ4yycWXNlXdMr5B/yJsfM4GC/cvTTgYWGgTHcoIO2wJddkK4sHAdjb8DckiYprXb+NJdJMOxucqMWAWq1S2eK5S17c4z2K17tzTaq+Tr4cQdj8DkaUv/93rqId/4WLzZeta1Y8TYAkELrfGzqUwH7ajdVfCrEB6Oo5bbRMaFu3ZMGlmlqQ249yMBH9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGTc6K3dLxTOxSceEvHbggOLAAKnJSUf92nf/VSuxZ0=;
 b=DcaDqXJa7x9XLg7LoQjfg+DMBSXB8eYdZUBDwSzJve+DoDWE+p46wYRkQhK7fg2likGT17P9TMV0iOPI01yiDadqv7dqnBf+sn2vQNxY2RJ/lBRoLxZIUxQxzEVy/boKrS1cYAfZCrtgxXeTxkGLEV0BQobalt/yX+8UwbcE4Bk=
Received: from BL0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:91::15)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 03:50:28 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::2f) by BL0PR05CA0005.outlook.office365.com
 (2603:10b6:208:91::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.10 via Frontend
 Transport; Thu, 13 Oct 2022 03:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Thu, 13 Oct 2022 03:50:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 22:50:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
CC:     kolAflash <kolAflash@kolahilft.de>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] PM: hibernate: Allow hybrid sleep to work with s2idle
Date:   Wed, 12 Oct 2022 22:50:17 -0500
Message-ID: <20221013035017.5098-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: 60794af0-ed4a-4b80-4838-08daacce1164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARxuWD0RyhCD9hKuZkNZ8InBuDOV/y1O55QZAnb0Ag9cbVnrOy9YExZCstXtlEJlRXnSMJXxm7WuP45prA4bqbfo0hSp+th5agGuJbOyjmWv+/3m0AGYntPf8mYKvCHy2RcanUS2BWiIn5xKrR/iE3zNKo6v9d6BKBXkB3bTV/i36+urcMLnZZTVB0eXuM//7K24W+6uXtCj+ZqECtOGYbXzmkr47nJYzUGJB59MsPp1rHpE+wNwhRHy7HdTvkAXwlQCYNM/rN9WzS+pol5N2zliEC5tKqs8BeCHtZ3+U0fjquZIe1doPmOZqZeVBJ/GcAb+gg0HlTCW2KJ4V83xmFzC4WpSt/gwOR+w0JW0Yj/NXj9vV9r5bC1UFsvN+zOfHUNxABGdLsw3a8d4hKiyd4w3zZOETCDwuO+E+VSbuQE/Y2xJUnBOAsRto8j1bxkA5Cl07aRe4hr9NbinsTd2s2LFDylHWlT06/uFGUKPU/rjgAeMaFh7Dx17croRqwmaj8pAR7G9H7rYuUhASmQOWYmWhM++CpcSTygR8BSMwMfF6YT2Opx1lBwtyfPVHVoWStZ3/TvLyRznVVb+wxNXIi0AnWuBbb/Wsa+RXQjpnt+SHoJrOIzS50edkeBmruSGEbz71QXySqsyBGkRidjztDGythtd1IMiW/gMMXWXh8rb+MCJXLogvUGtNFw4LmvmGw24Z5pWS06r5dMdHZbNlIxXFr8ZlUv+rCQbtZbrWoBBNgk6y3IcigP335WyoL5FkJYoCj6aHXd6ylWRnDFX8y7npFASXp4mVTyPt59Ppzw38Lb1uQaJr9EzKaXqXT53SIDCCrviM8JTNPKSLcxjag==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(8676002)(4326008)(82310400005)(81166007)(36860700001)(44832011)(6666004)(8936002)(70206006)(2906002)(110136005)(70586007)(7696005)(47076005)(426003)(83380400001)(40460700003)(36756003)(316002)(336012)(54906003)(26005)(41300700001)(356005)(2616005)(86362001)(966005)(186003)(82740400003)(5660300002)(40480700001)(478600001)(1076003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 03:50:28.1059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60794af0-ed4a-4b80-4838-08daacce1164
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hybrid sleep is currently hardcoded to only operate with S3 even
on systems that might not support it.

Instead of assuming this mode is what the user wants to use, for
hybrid sleep follow the setting of `mem_sleep_current` which
will respect mem_sleep_default kernel command line and policy
decisions made by the presence of the FADT low power idle bit.

Reported-and-tested-by: kolAflash <kolAflash@kolahilft.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216574
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 89c71fce225dd..537dd3beafc16 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -641,7 +641,7 @@ static void power_down(void)
 	int error;
 
 	if (hibernation_mode == HIBERNATION_SUSPEND) {
-		error = suspend_devices_and_enter(PM_SUSPEND_MEM);
+		error = suspend_devices_and_enter(mem_sleep_current);
 		if (error) {
 			hibernation_mode = hibernation_ops ?
 						HIBERNATION_PLATFORM :
-- 
2.34.1

