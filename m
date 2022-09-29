Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56BB5EEC87
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiI2Dm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiI2Dmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:42:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D202F12871D;
        Wed, 28 Sep 2022 20:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kva9cmhdNfwI/72xKCT6npI87Cn/XiM+rLNy0djMwv00DMPJx0VEumKnVo1mmJ5kVVy41YbOFLAqkvGBEhu7EGa94L/YIwiBi2Z9kElszDRGH+MerzIpB1SOyGzX1b2RGqCmgwOMkGSLnOYFBsZUVeH80nhdeDtOQhIpCooVJH/roneULNEX/iKuFzaC/2DnX0QvFaI8yP/9Ofx1+OsY45mcJeZ2M2gkkO6sPQIejMq48cf6bEawZ42E5BP6f++WCrNYprn/z4b9zPTqszOXJsgOMENbaf23yr4yuAc8YvLiG6G7xaqydndZKqpvQ1lozGAn+juQmPl477aNcrsF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHmjnRjP/lrgIGSqHOjb1dXP1ZYQJ0exFsi3rXEZMVI=;
 b=aY10HsT6tcdwr+SvxJMkrL2GIUdCY4aghOPmqcGAidf4JA8SboKlpYZtYXaXnf1AWjk5odw0VLuyCAnnCPZUp+8IfaegY7/Z1BJC1sucHEzJ0dDp9Q9RtRsndZVpBPXEUEetqd2eqqpb+ch5VJP5ZHwrE5BdoZWd2ZJjreRg6eYGkHL3Jc+GWvesNj6larWOZ8h/HJQFphb3cSxXB9biVzDmkn+2SwDH7jT+ZoGX1H3e2QT3PtaNvRiP4MK+cGwwJ2VotOcp6S3ky/cCbzv0Z9DY/ozuviYqtsDhT4Zv38Z0rIuDLkcI8IvIK1mxKyPcMJ7yX0R6s8cGJU4fDNnqNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHmjnRjP/lrgIGSqHOjb1dXP1ZYQJ0exFsi3rXEZMVI=;
 b=thHwlu0dZWiYzcCoEBSsRmQ5nBZGZNm1PgbLIELawdbhy7+zDvUMygiecUs/YwVXBzuXwJoDbIA40YhJa7vj3Id0Wv080aKrtHDIde16H4QH81sXv+YF3yz921ccZHWoynC2Ob6sjK6aqVDLggWOjLnkUG1MLrayEkEs/mJUtPxPMLuhjMgWBdZtQvVNmMh1dVtkRJYbL+UJW2uQ93sVJGvJpG/ZxNQVjHVWKPaXk0Cp/NL9lB7r2Yg6jzyBsZ9Kz1DDZ9IRHUFHGldToj0lnMLwP0IAhcPhI2coq94iJNLojUqLKmwJJkaliURFbeiRzGchLUDDyXB7kAxXNkfoPQ==
Received: from DM6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:333::25)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Thu, 29 Sep
 2022 03:42:44 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::9c) by DM6PR03CA0092.outlook.office365.com
 (2603:10b6:5:333::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18 via Frontend
 Transport; Thu, 29 Sep 2022 03:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 03:42:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 20:42:33 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 20:42:32 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via
 Frontend Transport; Wed, 28 Sep 2022 20:42:30 -0700
From:   Wayne Chang <waynec@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <nkristam@nvidia.com>,
        <jckuo@nvidia.com>
CC:     <waynec@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] dt-bindings: usb: tegra-xudc: Add Tegra234 XUSB controller support
Date:   Thu, 29 Sep 2022 11:42:21 +0800
Message-ID: <20220929034221.3817058-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 1644da25-6df8-476e-d678-08daa1ccaafc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lh1304qNmVGm31hE/PWuvmDnftQ7iiaMnaC4XZXWNNf1uX45pqPJuxBCz5GZG1r7Ca1N7Q9MDa6iP+rLj0u7041PsnclMwlb2dp/lVvtOGhJ/hKKewCO0u4JJy/1LB0Is4rxLii1FIRnIBvDX2DqmcjjhLKdxqIxyUfZ+mVnnDqivJYvaiQlSuRiTmhut3NwR47nQsEpb+CmHdcReOfB0b2iJse8prNR49bbOudBlzVjJHGGfcIPwutl+NUK6HaICQDcG+9qKasuGXbgoMCiL5SmZs4yzEVGCutI1PwMT2aNIQvp9fpbDzJrfasnKm6rZAnFR4WKwpd+UBhEz5E6VqkXNwVVgH/hEVmoD653+w9nKeD0n0Bw0C2ntwsACC1Gua+VNBu02zxycn/+f0DjjEzbJnOaFOgA5HYozX7zW4oaner3kKmmeazxv4V1C8RTrjzN4fzHfSh/QNcO+UioFU2kTBc/AvslLjnAbQ5lTGC36Hus4wIFd64cCwfSLZZ6GTIhxlJcHWbi2Cxf/RgI0N/+KcS8yCuDyaF6aFPKxJhIPbOi91xxmrIr0c8MkgOnBO5KeUNxCTFuUOKE+UiX10ypLDvn22GH6jS9s9fy4ChK0GLHCB3m6PGNimZ5xQFuiwPyCmWXJYGtYbgWEShjsC8pkIm3WeqmPLfGftjK3m2wbF+Jvsc+OsRCRf4gSwJo0OMW1yTxn46nfznJZEmhZu/Cr2NCJmN3+wUtGa+m3K1PmozU2RrxxOo+M77k3C607+HrObuUVCxtpZr+7v7bJQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(86362001)(82310400005)(4744005)(41300700001)(40460700003)(8936002)(2906002)(82740400003)(1076003)(26005)(70586007)(336012)(6636002)(70206006)(2616005)(40480700001)(478600001)(356005)(8676002)(7636003)(316002)(4326008)(5660300002)(7696005)(47076005)(54906003)(36756003)(426003)(186003)(6666004)(36860700001)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 03:42:43.8881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1644da25-6df8-476e-d678-08daa1ccaafc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the Tegra XUSB controller device tree binding with Tegra234
support.

Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
index fd6e7c81426e..7e4eb379bcf4 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
@@ -22,6 +22,7 @@ properties:
           - nvidia,tegra210-xudc # For Tegra210
           - nvidia,tegra186-xudc # For Tegra186
           - nvidia,tegra194-xudc # For Tegra194
+          - nvidia,tegra234-xudc # For Tegra194
 
   reg:
     minItems: 2
@@ -153,6 +154,7 @@ allOf:
             enum:
               - nvidia,tegra186-xudc
               - nvidia,tegra194-xudc
+              - nvidia,tegra234-xudc
     then:
       properties:
         reg:
-- 
2.25.1

