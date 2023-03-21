Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BB46C29EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCUFfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjCUFfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:35:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0767A21A06;
        Mon, 20 Mar 2023 22:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3Biw+m8L7s7gdYnt3KyNiqwpV6B1d+YgECNydeKDcb/qSqvsry0eZ4zwRS2e9NrC8i5S/wBREDvxvTROK61ryLoiNhkHMxdfdlZ/jzhNAZx05IKPqSLsuDafdUqZFrakRg9Ms1sv3XIuTtOa4r4t4pKUc38aeKZblF76qpkj5RjfpeUQSGLa6OTQEHaZn1WYYJGlLGSEyfafl1WegWpBItmOcuHWVBo123F17vKfVKUsopAZxdAUjCZjEgulr3dXUH30wU5aq2+/0U+qzFOJ+badvyMvDYc2vS42YlGzTlN/howLTczU6nwqLlfOThbgrx8XZddie5Tf4HdZzdd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkAUfB5JznI08JeLH9v2EaBLlRCni90g6ZC+gwzzi/0=;
 b=mtuWRIcjzbfi54t85fH5rXPxH+rU0IUzGO/z2CDtG6LkxRF0ayGNxkVg+klQHwnZj3YzxQzcdEBjq3V22Y3XJQlvuuQjvGHvoNrRXKZrNFnbf/079pMZbKdKGA+SLoHndb57LCLrC+uIuO8L4H5jG2eUpmW3ycevV+ihtmsFLALYf3d5lU864bDoyS+0tnIo1Kv1IlDjlixEgPYvihTGjn8MFmCZ+AUY2p0wvbfCbzkEzcSspsbMfh523m+J+C6+dDdBKmI6DxuHoAHenzs3griDr3crhlwQjAC4fsVdlR4iR7o3FE0jGWjuPXPLLFYlPnUUBXYnmiw/pGMU2MhRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkAUfB5JznI08JeLH9v2EaBLlRCni90g6ZC+gwzzi/0=;
 b=yA1hTnTfGjk55cZlR7YVfgOzPJO0FIJ47/YmIfCBP5wr6ssdQRyBbUIKqmv08iiTJZMdx4Big3fSJj7Qo4SDtcFa8yhByjyalPRdOjgIC5AtjIrYst+MVb48LGyIooGm2/P1N01Y3c/RvDrYX35TzoZiAWvWsxgUr8H8OzZE370=
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:35:36 +0000
Received: from DS1PEPF0000E649.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::ca) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 05:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E649.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 21 Mar 2023 05:35:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 00:35:33 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Mar 2023 00:35:31 -0500
From:   Harsha Harsha <harsha.harsha@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <git@amd.com>,
        Harsha Harsha <harsha.harsha@amd.com>
Subject: [PATCH V2 4/4] MAINTAINERS: Add maintainer for Xilinx ZynqMP RSA driver
Date:   Tue, 21 Mar 2023 11:04:46 +0530
Message-ID: <20230321053446.4303-5-harsha.harsha@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230321053446.4303-1-harsha.harsha@amd.com>
References: <20230321053446.4303-1-harsha.harsha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E649:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: b09f8b0c-16f1-49ea-c821-08db29ce182a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l2mLbsUkc6XLqjrMkg0ONwQHJPRgcof9FuKZyU08dwGAaRQcqyn3VbX35/AzjWG71kBt36JhN+GukyhZdqKnKn8giXgCiW3lBVYo11xarTJQLJqjOeKhXdeHlQ3IyXvJub6zCguZhNWoxGfJ0OhQnHMPCIXGZ3lAi/dxFxEaXdai3wkkIXA8S+DaZ0GM6IWQgguXG4gYnNKP/mKst3/dkYEERL5aoGizLepdtXrezgDug1xAE+Ar13APlK6F9OzLlnieXC9vncgqbL1NyG/IWJbooysUo2PATX7SdVC2FEil8RtMZ8cY9yVPcmRLqB2vGYUkH94aIEu4jrBbPdbo1NDsGjkiijXI9pUtUuql02rO+MXaQx3xmieYcpjiRcN8RVsNrq36/Z7FtXP3Gl00H4hCyBWqbVD5JjAMCuy8LQcT9vzDEMG9ky14Tn/HXSu1TU+/p/+mOw2kYmc/BPcu8rxkrOfoya3+vd8VOheTj5sLjRpotaO+Gud6WgT5oq/ZskI+fZsdZ9xULKKrU6GlSNgXWnFcd6HruEjSXsCm4booaxgtTXXLZuZuWwb3ORSGJaYMKcMD1fwFSS+eAABSxpupODsnZ3Z3Zbk4RkgrMhjSB9OhsOlXO6+8fH2b0gJLSWy9PFOvwaJUpAf9qIdlkRtMlE7vrdd3TwvqqQb8uGDvtcmCdiqGtZAen7aAPi1q9p1popOkWtxHyx9P3Gv5lSXZa4DTaBgog+EQ5qVkuBhUNUI3S5DoIDdJKvWTJU/f
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199018)(46966006)(36840700001)(40470700004)(44832011)(4744005)(8936002)(5660300002)(41300700001)(36860700001)(4326008)(40480700001)(356005)(86362001)(82310400005)(36756003)(40460700003)(82740400003)(81166007)(2906002)(1076003)(478600001)(47076005)(6666004)(426003)(186003)(966005)(26005)(8676002)(336012)(70206006)(70586007)(110136005)(2616005)(54906003)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:35:34.7734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b09f8b0c-16f1-49ea-c821-08db29ce182a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E649.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an entry for ZynqMP RSA driver in the list of
Maintainers.

Signed-off-by: Harsha Harsha <harsha.harsha@amd.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c90bc235a0a..85714c5ac916 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22913,6 +22913,11 @@ T:	git https://github.com/Xilinx/linux-xlnx.git
 F:	Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
 F:	drivers/phy/xilinx/phy-zynqmp.c
 
+XILINX RSA DRIVER
+M:	Harsha <harsha.harsha@amd.com>
+S:	Maintained
+F:	drivers/crypto/xilinx/xilinx-rsa.c
+
 XILINX ZYNQMP SHA3 DRIVER
 M:	Harsha <harsha.harsha@xilinx.com>
 S:	Maintained
-- 
2.36.1

