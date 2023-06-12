Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D4F72BED8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjFLKXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjFLKXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:23:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88931250F;
        Mon, 12 Jun 2023 03:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6kHQ5U2bY2cAj6Av2MNmY+jlvnw0oFlRhIAIjp9n6FkTPYG6d1PKb121JeGq/7KKlM8Ye88JlbDFwnvr3RHvmBRrd9PGRr0VIz+RTgzSsFBAz0ATlfEzGXXfVZcATLuaS/LKswSyBvzeOQXESYzCPVu2mRi4T5ziTAUgJsexDIo3wlLMhv0vypPFIh3noXROjv2IDvpyf6zPIYpBm5zT/0bm91NFinuxyiz4rkf9GYoUwaVKDsigkJYmkzg5sRHe/WP3DgnS0uC3ZJL8+gXPGI4zKyIDoMbqXamT7xbchdnN5cj6JhPpVkAEe7+6ljCAT+PJ9jt+cOFWRv+Iz0Gxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFI8992NbwPrXsxs1R+70pYZKmiiwXBSsjjsnEtvDMM=;
 b=RvzYwaQgNQWTY5/oGORoRcgeTov42/z86ojFBx2aS5np0+7gVP3KNI6TLpu+8U9EzNsmVh0iCI+i6VMoBp26gjKpwFA743jSOLwuGiN+HXA23y2SKtoVN40iSG74Mnf7sEMO7DCnWbX6FsHFYmWgS0H7hr3NdBD+ME0BF/LYCIHl1dVDDrE2W9IhNm3kanNlyAen0gqOdBOuRKN6EaeXyWoKFiSmk3yqYmJJL8QBC3iSpAwXBaeinRGMly9zTBOAlFOfKfCZzSbgZ2Ky3j/N4tibp7ub8KLv4bj2Cr7RNTP80dFuTxDgXJT6gaVd0qkK0nkp9HrY0IPAXhsDhKMerw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFI8992NbwPrXsxs1R+70pYZKmiiwXBSsjjsnEtvDMM=;
 b=Uf8a0cWdUe3vFCFEde4R7VDiP6GGfugWJDaa55tpUyxEB568kb0uYZZwE2HvurYB6ecbthWuJa1tPPX5bAfHZdzr2MlmTMzk7W4hIejjNC5FwG3x8tCiyRJS0Pmjua/80Vaj+nsG8aZJKEJiAJwqvJFCDmoB85qkm9PKeEi6tgo=
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 10:00:53 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::35) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 10:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 10:00:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 05:00:47 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 12 Jun 2023 05:00:45 -0500
From:   Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
To:     <richardcochran@gmail.com>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <vincent.cheng.xh@renesas.com>,
        <harini.katakam@amd.com>, <git@amd.com>,
        <sarath.babu.naidu.gaddam@amd.com>
Subject: [PATCH] ptp: clockmatrix: Add Defer probe if firmware load fails
Date:   Mon, 12 Jun 2023 15:30:44 +0530
Message-ID: <20230612100044.979281-1-sarath.babu.naidu.gaddam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 9971c17c-a61e-48d3-e040-08db6b2be84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkbTW7f0hYfQb0tHjhYgNicWnWWlVqe9sDp6SL/1UdLoKfNHk5E16ss/mF19vOd+Lh07CCPDeg4shAdQBcvc1tk1t4mKnbjc8LH1fHogJ8pykeqQI4bDKFnxIHmJCheSrE2pdVNfYF/A291myqBTw03mGH+btkOG53HoqYPZF1anOA1CJKC/TkrGpocU+nCgUSXLTGCRwm0RrCRgp7TMVXUhGXXpPUAIadIqrkPxvNR0y2dXWSQtvxf/jdppZDtd1VDAFCN4/qipdT9AJZqHH6C8M+zwl9sA8JJCaBmqivyUY2DCetASMmz5iwxD5I2b6lfVicbiU8FBr5M6yxdQ5GuH7IENMStBDatKlWrtRN3ftwVBIKG9Da6/eP9kXfOWHqSxdGI7ARHjDKu1VC2SrFobWUJPPEfXXoybAQYj88FzgVw6CFV/jA5LFYqkRLVMqp8hIkv1ef0gdcwoAZpsCbqk1k9sj1snLyqYEkDv/dCQw5bC3Q09bZFMvOwnDGirpAOSP3eHrkSR5cLsKq+fVNOeSjC2y3m1tfrQ7GdtiHErf1khzFFVX+IC5J1/VHy/0Gjdo/3d2V4kC1V9mzfBE7hU6rgFXa7K93kMMb0ZLAX13peTVANiPd6IHcG2bH47jbRttNKXoFts/o1mqiM/sBc33UuH3aYTascjjLIYlosuFM2NHXzeXJL91aUaD/DhhoX1F8BfaB5Lc/Md/VUSsCXMe3RCbx5io1/KqjWTnlbRrLs1G0hbiJKeb2fyE3rmL3x5ZkvkXFeAW3slB69SfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(103116003)(36756003)(110136005)(4326008)(478600001)(54906003)(70586007)(70206006)(316002)(40480700001)(8676002)(8936002)(41300700001)(5660300002)(4744005)(2906002)(82310400005)(356005)(81166007)(82740400003)(2616005)(336012)(426003)(1076003)(26005)(186003)(83380400001)(36860700001)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 10:00:52.6743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9971c17c-a61e-48d3-e040-08db6b2be84e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock matrix driver can be probed before the rootfs containing
firmware/initialization .bin is available. The current driver
throws a warning and proceeds to execute probe even when firmware
is not ready. Instead, defer probe and wait for the .bin file to
be available.

Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
---
 drivers/ptp/ptp_clockmatrix.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index c9d451bf89e2..96328dfb7e55 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -2424,9 +2424,13 @@ static int idtcm_probe(struct platform_device *pdev)
 
 	err = idtcm_load_firmware(idtcm, &pdev->dev);
 
-	if (err)
+	if (err) {
 		dev_warn(idtcm->dev, "loading firmware failed with %d", err);
 
+		if (err == -ENOENT)
+			return -EPROBE_DEFER;
+	}
+
 	wait_for_chip_ready(idtcm);
 
 	if (idtcm->tod_mask) {
-- 
2.25.1

