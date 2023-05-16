Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7B3704FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjEPNr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjEPNrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:47:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68831BE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxp968ZTPcdyP32psXabhoxJmIethKW/OiXOw/7JPVrhywQcsiPzMgaNrYTlxOQ0ixmjI1H+7s2RVMwAK0C5AA9XsOpRGTc3AdF0zk5y7inefRASaOMEE3suGewsG5VW+MMB6tcbptN6cJ3IsqbwUDyy6YooQuOlx8SyB8x/y7/Y2YAk+86UALeBuv+51DwIrBoN1mBoHYXljerURpxBUkCMpaVi/e3n1VbhLbANWcDUf3/+isxrihhfFp9+7t5wlSV24y6d20fB3LBTNm5zKHN0lwPaf7UeluA3No/pwkyjCU+8JlnWGjVlpkW20qP5uGs3PSWKP33bFEpsRmM4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/EsanLT7p4tF0xaUIROFFyaL8Mu4K6RFCO1xKCkmmg=;
 b=QkNYR6YQEWy5GHcHRZmaI24G4t93LxyqmveFJaiqIENMMucfOBQ4qjx8qveRVbOypnPLZOvLByenHIiAtZdUcL+qLYbZMWO+BRRR5ZRn9ImFy8cW1tZZ4mPiszIt3KA2j4OC2Z85/ILmzEwAX1njVRis6E1CHDXz6SIMVQgt9aJ7rF2hWJaQIs6qANTb0K8xNXivpoijm22I2+IN/1le3Pcc8EZPf2LIBxoZKN3d6hW36y+608FAjOr+OKVsdwkosgANg7+UiDqbbhml60yYi9FD2WtCit5IRXi2r7PrqrWzggqXChKh6UEQzhAo14nyx/nCWopdvVRKxr3AynhzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/EsanLT7p4tF0xaUIROFFyaL8Mu4K6RFCO1xKCkmmg=;
 b=c+eByeBCBpXQ1JPMd7KjzEWuCbWBBwrMYVLYpirhTKF3R+QCT6KsjhR0hQ9PIo6/u3CP2KU/Z+gTS0ePOjnIO0U+Td0thCcdbpTDYEDr6aBnGIxNXn6dpHQQT22be7/9uvzyqyEHVH5ApUtPit09XYJMdZCdvxoWgXuY9IVhWWk=
Received: from MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::27)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 13:47:19 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::e3) by MW4P223CA0022.outlook.office365.com
 (2603:10b6:303:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Tue, 16 May 2023 13:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 13:47:19 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 08:47:17 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <laurent.pinchart@ideasonboard.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Remove Hyun and Anurag from maintainer list
Date:   Tue, 16 May 2023 15:47:15 +0200
Message-ID: <18700dda117076510baf87a090acbb29cb3ba3ba.1684244832.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543; i=michal.simek@amd.com; h=from:subject:message-id; bh=YrpXG5QJhSHWPviAYzUlO4+y+tl2KGigm4yVC9JZyJQ=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTkzoQ0ufacKs/rwbqLBNREDfYtv6sf3nWorGoDd8CVH d3qZlM6YlkYBJkYZMUUWaRtrpzZWzljivDFw3Iwc1iZQIYwcHEKwETkbRjmV7uGGqWX8YYIub3a 6rTsBfsb7vQ1DPNDL7b5svOwnyu0Dj8faFno3xLcGQ0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT030:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a3cff4-ff4b-48c1-851b-08db56141151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRPAUlLw7RJCZFxlIVLwV563TVbCdnB40p/ycBCgmMhv0eDAE+ymdHSZB1xsPWSvoGHdkNacYYWAAEpuDAVDYSMV1t1B/NXBaQgo5JJF25A2OqPValj8Yx/W7i2vA6bO6Ct0Z2tJEmLa8updMIzdKwkv/Wtz87vrKNDyBBMGv+do7mGsh9gbIG4Xz7LCq8Ic73dAZbKwbumko09QAvnjkIcum68R5BrBV+ngut7SPDfQerasEjIEGUWco49C7nRaMbbhMEk4wHI98Zhp1/jIu2ct22FZUMiL7ACKj0zO8ma0AxMtde+DfkKzDwSNOPP3CXkyjf7eRF5XVh4jRbk0dltF4c+bRZSqe9dZgPBj7O9UeYtdUl5OFsHqW+pxyFMPo7EXpdLpj4LXe280IZZ7HPWwY1ntRjUJsfYrwQCEbu8kgp7Pe5HBw4MCQVZvRrcheVfd2MnIvKI6vD1FJQzxZ38QuzNqExzGf80Fw8XMKKXHG7rSOakZoHDs8bJP72qLYw+phu2EStLm/lACyXdfYDqXxTe05v9fs4IhQWFmtMJQrQfGUDVOz88CY8HYsDtCsviWvjgXX+j1udP7egHUUz1MvHleE3bu4J9recFOfoWGpqdxphHZvRwKxMWIhD1tJQWdl9iYUOAZ90JuNhKwTCJzy2qdNksNoVkKRhaLDH3OeCjvJmMOulZKwd0qHBpc7ltgihfak9euyoP6Kt9ubzgrobgDxW8qFKwhDiC5vPGkPcdQijEEoeWA8sO7UImTyPM1xkCFCtDmRAtm1N4Czw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(82310400005)(8936002)(44832011)(5660300002)(8676002)(316002)(86362001)(81166007)(36860700001)(2906002)(426003)(47076005)(336012)(2616005)(186003)(16526019)(356005)(40460700003)(478600001)(26005)(70206006)(6916009)(41300700001)(70586007)(4326008)(82740400003)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 13:47:19.1384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a3cff4-ff4b-48c1-851b-08db56141151
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no activity from them for these drivers. All of them have Laurent
as active maintainer and their emails no longer works that's why remove
them from the list.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 MAINTAINERS | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..60f6effb168c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7077,7 +7077,6 @@ F:	Documentation/gpu/xen-front.rst
 F:	drivers/gpu/drm/xen/
 
 DRM DRIVERS FOR XILINX
-M:	Hyun Kwon <hyun.kwon@xilinx.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
@@ -23162,7 +23161,6 @@ S:	Maintained
 F:	drivers/tty/serial/uartlite.c
 
 XILINX VIDEO IP CORES
-M:	Hyun Kwon <hyun.kwon@xilinx.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
@@ -23191,7 +23189,6 @@ F:	include/linux/dma/amd_xdma.h
 F:	include/linux/platform_data/amd_xdma.h
 
 XILINX ZYNQMP DPDMA DRIVER
-M:	Hyun Kwon <hyun.kwon@xilinx.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	dmaengine@vger.kernel.org
 S:	Supported
@@ -23207,7 +23204,6 @@ F:	Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yam
 F:	drivers/edac/zynqmp_edac.c
 
 XILINX ZYNQMP PSGTR PHY DRIVER
-M:	Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-- 
2.36.1

