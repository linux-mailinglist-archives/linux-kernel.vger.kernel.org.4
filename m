Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0E5EC076
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiI0LFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiI0LEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:04:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21E3883EF;
        Tue, 27 Sep 2022 04:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwcdpGVj22IqJHK2jT/4cfH35o42Y8e+gd8uE+MBJvFpTUkNFC7KcnAjJpfPjL1uWCh4DOt22tYC4rCNfTACGErlenvDhilrnAr7AeVpUvZmte8uXu4RjUjD2Q49X1GR6IEN3hVyivUfZ+eqlejTVN0GPkfwxcQ7gbDjzgFETiqF2xFf/YBm07j9cR5upDy3KgeVu79TxOaFeYjB2sOK5GPlgYrTPFEs85omFir2sq3YLYsUI5cPyeF59eKu8OnbqMnUEFxBuZMnDwOA8iXh3n3/Y+sBTwjBurKhqRR7Ydp6wgpLoz0IbzRTxjxIGpnd/Seb0CIfURkv51lvRY81Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+Fgv61ZntO2i1SF5cSqfajeQcxczsEL7y6Ae0F//pc=;
 b=CIIeNOEWRhsS4f2m4/ag8tw7URQUD0cU2kU+/8T/vpa4Dk6FjDHS01gAKvZa0FinuQrrG53AGSCCJzDiMnK65DU5j8lYQp1oRZtX0WFzdxzTjj0M1/F4EsFmAsVO5CxGeObfa7YRDlijQf6XZGVuKwC7npjWDUmDnpqWkpxpxZYl7R+/9ZJMX+whW6kGmqGvmsU1mQL4Jb0IkUtnVIoB/iaYqfHmSw8J/7q3dArIS6AaacnKV3RkZaQ4XbwKD9MB1Le+4A4IyblDJG58stEpVH8A4qcfXN19OcWwHnw0Y49oKBU/FPYCG0g/wykLDE9C9+Ga7XYL3qBoXvdqtR7fkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-watchdog.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+Fgv61ZntO2i1SF5cSqfajeQcxczsEL7y6Ae0F//pc=;
 b=KSc+HcrjYdFaLngnYKAaOqNhbfrhhRY9eXVPVBP3BbGZAg2sckPSPSwwbibRUJnE5MNBIsYD+GzkLVGVXEJVW9uFBmwKc3ls2tg7QUdhcCu4OeyquZOmEqD7pq7uKt/k663wwQQroeb6ROqABnwvEAGU9Yr6OUICKmCCH4ZJqcw=
Received: from BN9PR03CA0429.namprd03.prod.outlook.com (2603:10b6:408:113::14)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 11:03:39 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::d2) by BN9PR03CA0429.outlook.office365.com
 (2603:10b6:408:113::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Tue, 27 Sep 2022 11:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 11:03:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 06:03:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 06:03:37 -0500
Received: from xhdsneeli40u.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 27 Sep 2022 06:03:34 -0500
From:   Srinivas Neeli <srinivas.neeli@amd.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <srinivas.neeli@amd.com>, <shubhrajyoti.datta@amd.com>,
        <michal.simek@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <git@amd.com>
Subject: [PATCH 3/3] MAINTAINERS: Add fragment for Xilinx watchdog drivers
Date:   Tue, 27 Sep 2022 16:32:57 +0530
Message-ID: <20220927110257.41963-4-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927110257.41963-1-srinivas.neeli@amd.com>
References: <20220927110257.41963-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT047:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: da7a8fd8-7aee-4237-e671-08daa077ee6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p3QlUlQpHeCMwfVmrOIE4mYciMsm2eSAwuw92aj5J8l3M8R+OgXP8yGgxVBF9EYM+ro6RF7blWpRotyQZTL/7jfsv+IUht5dzocP4OUHoddm3ZP9hTeOkZj+fddpTBmojFYzGb0yzgdpZhBiF7bBXDvIFb4IYlw0iUsp17HACjKpS/mxPkcpLDkcsf1me2VyAT2re+7O5hknjfh426/VpHZHqEwwRfLmw9lcOmWy6XtpBUttdyCukTt9FIfzjevI6ao633cJjrQOnNFB0IDADT0IRlk5VWiOTNesSnbxjR3n/GWpA30aeL7a40hLgsv6ay4fCpVwANv6rmBprrPvxnBFJWePL7XjzRAk+CypeTXGW6GoDGAX7yBdusCU7mo+MnKoZpdvcYOEs+ZVAoUicYwXA2zZyV2/X4ZyBc+22uEKYmH60/gsD6Pe3xMDfcidwEv/AO/MJXozJrkybWNwv2aoIbZ1Bio+UQPNJPqwtz77f/lrbHFdHYQj/1R9tS7hvbz72bItNkO17Pd434yb3QA4gHPVoSgLIexkaOHwpKGG+Sx5Z1ytVFWwAo44Hx1LckSgv9aspOTmxSAVV/63fMaKruJw7YVNvM2GIpIAd6oggjYLdTbKkBOF5nQt+j3uiqrF7tHR8JkehQeB3/73Ed959BTJrsOr2wlJzaDrKz68ttEmzdOCnPs9JLIHXsSID/0/5m1nI0rfxsSGrwg36FTPUwhrh/3kDZrZCyDEuwiuY4VaMUa2JDze7bit8E5leAW7udvjzqwfk9VC25k67lyTJMl7QPxW6r/iztbmi+Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(81166007)(356005)(336012)(186003)(36860700001)(426003)(2616005)(82740400003)(1076003)(26005)(478600001)(41300700001)(8936002)(6666004)(47076005)(70206006)(4326008)(70586007)(8676002)(5660300002)(2906002)(82310400005)(40460700003)(44832011)(4744005)(110136005)(40480700001)(316002)(54906003)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 11:03:38.7584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da7a8fd8-7aee-4237-e671-08daa077ee6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added entry for Xilinx WATCHDOG drivers.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a34ec41fbf7a..b9771287276e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22548,6 +22548,16 @@ F:	Documentation/devicetree/bindings/media/xilinx/
 F:	drivers/media/platform/xilinx/
 F:	include/uapi/linux/xilinx-v4l2-controls.h
 
+XILINX WATCHDOG DRIVER
+M:	Srinivas Neeli <srinivas.neeli@amd.com>
+R:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+R:	Michal Simek <michal.simek@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
+F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
+F:	drivers/watchdog/of_xilinx_wdt.c
+F:	drivers/watchdog/xilinx_wwdt.c
+
 XILINX ZYNQMP DPDMA DRIVER
 M:	Hyun Kwon <hyun.kwon@xilinx.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
-- 
2.17.1

