Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37966C78EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjCXHhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjCXHhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:37:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E10340C0;
        Fri, 24 Mar 2023 00:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMNyRSr3vdx2QuPQquildwCGI+lZq6YqWjqwssW180BWn1cmAOhA4WINTZsJabD5GFIHO48f2beE0cvcGwewUIM9H71Uyq6SpqfyETEipdcwxpz3Zu+O8bmNY5vT3vVu/aVqy6VirjyZnOI0JfKbA+OiUP2pxhTLDIbSYwPXXWimM3Ry7IDZDBOvYeT0tVFC26UwxMHZTa97rUb9RDhV6J1K2ecrNI49/lEONScp19OslczleEBKrAjnKoe6Sioszl0vK/3PryDPoj7KQ60FCWWXdaMHAeTD9SWBmUMo89EHZ2ntIps0OoY7iRRPkn7AaLQdC92TMd927JuqaVTIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVc8ZJuErBpzijR9LjiJ3B34vw6NXI8DrV/BLNtbg1k=;
 b=gEaZdFiM2djYahINqHWofaRJ6mbUq58R8Lq44Y8S2Sczrcw+h1YFnNB0rWSpFoNM8S8zt8xUDluvE0OK0ixLSrLDN0cn2A0z+fPJphc9ssvSmZeipbHBvWv/l1K/W6SagG85czRE9tH7VWRXqbo1ZOmBs80maxoKJlX6Dfd0MOOUiiAP+tzTc+3fRQIDVeEHYtVkt2kiHa5vFwIFdxbupFkuwGy3QWK/ekqlc73qOzgZL/tYCw3fYdgwPhHeiewUCeYKvSpWMETy1hDTHNkepW1KdqANlQ6Odzrk2XLADW2XXH2Tom3/ZqM1a7Xuv2uze29QrD/qQ3z8y1jXteQ3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVc8ZJuErBpzijR9LjiJ3B34vw6NXI8DrV/BLNtbg1k=;
 b=0yVXx/5MCf324q69WSGJ2cpB+psLac7t1tRU8y/Spk2MiMyE6CCiyq0zCZAh0Tv9WvU6nLroQL+lnuk8RHB98607YvLn4y5Y3YUrwlT/TKSIBico2P8ovFn6BNm1O0/0iN7ON7apKKyx1FZrePiW0MdkYqY2iceFw84jkU6Vjk8=
Received: from DM6PR08CA0052.namprd08.prod.outlook.com (2603:10b6:5:1e0::26)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:37:00 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::48) by DM6PR08CA0052.outlook.office365.com
 (2603:10b6:5:1e0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 07:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.9 via Frontend Transport; Fri, 24 Mar 2023 07:37:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 02:36:59 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 24 Mar 2023 02:36:56 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 0/2] mmc: sdhci-of-arasan: Add eMMC5.1 support for Xilinx Versal Net
Date:   Fri, 24 Mar 2023 13:06:28 +0530
Message-ID: <20230324073630.3194724-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd4787b-4caf-47bb-b773-08db2c3a8dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lW5FaxPmPEzsP7gF1RcJVHsLqeSf9v3hGMIc9tSQoZ71my9u8yQKzEwvAR7THq8kXzZiRN0vFxvl0qgFxfLbO12a1lNDhzutL6+TJKimO4OE6HJR8cCJCCEJFuuT94OXjAE/DhrzBBU1fWG8EXOvnyO1F5n4hfvkkz9I3fD1xptyst8J1UPDTxtO88GIa9AimItP0Gzb9IW978/lHfsyIOhqT8mp/LfQyztRu7bra7lzUabnUHkT5kAZcRRa4rIuGS28E1/9P6jUVmrPZSr/zQeWn3nN/RICV8aITaNp7pcpTn8aowRkV/QbPErR+l9JnJ4D9oRIdu+wH+0efURXJs2kPduZ9RMRj2dBdzo+9slPRARwILiqE63TKXE2lHl72kUoMBVJoH82Xs8twkKSPyugww08f7ubsmruX4tHWlYUbo0FZ4TR6aFbqgZ8PFe6bhjKHJLe+NE42aF92A+0ul9HikbVBFm9bbDHicI1UKuX4+7yGG5renI6ZhFn/IPFOZ+tkF0jR3zkqx01d622qVow/oCHmKx5hTmV57KAvAmAeo0aXMJC5GO6dPAySB+Hyr5S5mVL1QGU8eGRvRrbIoZFtyQ8w+9FgCCrZznpVB0wCj42zukWb0QDHYlyIjcaFxf9r+A5WHShPBG0Ksrj72KQ1K3NxOSyn3FT8rOEWuukFnbbi+VcceaCLOW//KLqOimsIz8BTc4PJT7ToTTVmwdMN1kFv9PnhipfFeahw9M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(103116003)(40460700003)(36756003)(41300700001)(4326008)(8676002)(70206006)(8936002)(70586007)(316002)(478600001)(54906003)(110136005)(4744005)(5660300002)(2906002)(7416002)(82740400003)(40480700001)(356005)(36860700001)(81166007)(86362001)(83380400001)(186003)(26005)(82310400005)(1076003)(6666004)(336012)(47076005)(426003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 07:37:00.3127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd4787b-4caf-47bb-b773-08db2c3a8dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
X-Spam-Status: No, score=1.3 required=5.0 tests=AC_FROM_MANY_DOTS,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add eMMC5.1 support for Xilinx Versal Net platform which has PHY within
the Host Controller space.
Also, add Xilinx Versal Net compatible for eMMC5.1 in DT binding.

Sai Krishna Potthuri (1):
  dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net compatible

Swati Agarwal (1):
  mmc: sdhci-of-arasan: Add support for eMMC5.1 on Xilinx Versal Net
    platform

 .../devicetree/bindings/mmc/arasan,sdhci.yaml |   6 +
 drivers/mmc/host/sdhci-of-arasan.c            | 237 +++++++++++++++++-
 2 files changed, 242 insertions(+), 1 deletion(-)

-- 
2.25.1

