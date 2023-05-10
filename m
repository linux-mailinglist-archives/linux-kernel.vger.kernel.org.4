Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD116FE001
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbjEJOX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbjEJOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:23:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583B149E9;
        Wed, 10 May 2023 07:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQocjQOO4P96vu5QxWJMWT7UQXTgTveKd8lCzVCcVm6VTpBb/E33PFyfuCvkmn0caSz9NPEXukcr61+zSryliubc3pHHJ5H2DjTbOY5oA9LVZ5+CWP6YFrg76HIyUmy8HpkLzGBkmUxyHc+MJtIvFZR3sEMKmpnTJZ1WMcc4N5AQy756yftlJiLk17/ipDvnnfydVqXV2wQ9j4sZ4fQNGiB4CXPIu38LTfs+ZiQ6FMnLvtspZ0Ey4qNBaEUeLMvUXQwQ9OhPaQXoRqvGntF3CNsMhJ+E9btlhQipv3FvDcIh5FGj1XnTuGZq3tz/xKsz+n1bHot4U/ulQu3aLIjfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QFbVU4iNqq8Fhl/n5IQ/osELI+lYBnhDbBsHekle3g=;
 b=lWCJHEOlBuxkT2guu9z/z09o02hXzmb6Uy49AIDj+Yv1/6ctURcJ28To6lQdQyWIbuQbtIx/D2e9kE0dOgsMTvO5/LjSJpbv1U/Opb+e9fOEDo4HK+q5GdNXhd2uJqHghGmvCZixGciRJoRYiICLrJj6JKewYLx6N1ASfhPydapepbEg3sZ8r3JA/Cm/jHi6E+xht2BRCANLw0ZmuXyqtOoS/tHgNGiIqmVIBliX3jCRtsHEY2JZW/duzEAXu+GazOUracUMaCH2oTr3uq2hEgE8syQtFiSTAMHv+maj6gbtdjkhU/ErE5l0ShHLNZud15ccpO8wnhb8baN5dVpnuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QFbVU4iNqq8Fhl/n5IQ/osELI+lYBnhDbBsHekle3g=;
 b=aCyA2O0JnuvlOqTTPiOLjtSQumQghVVpSKPgMAWLLmPjgoXsW+gic9bvDJgJiM0dW2peufQiJU9gGOUDiMSymj14qKFEjEor2DA7Cl1VbQuylEgidka1AwI7hWTzmRhZjp1PRokJ6adeTfaBdkk7M8rVasHgG6Bxv8mrhDQ8v6cJW+r/EjH0zwqXxLQiG7NyQSZXk7e9aVNb+6hBIECdrGz8eEkUXZ2AU3CjVBcvdgyYMFsaPuFgu75ndiQKcAJCxk9eDVJdcqrqXeV7NMbMLoRkzNiW1e9K/t+fdji5BhLb3okhZ/I/Bn1A166xW5Uonm/+AUNzHInr37a74ht3Yg==
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 14:23:14 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::1c) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 14:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Wed, 10 May 2023 14:23:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 07:23:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 07:23:04 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 07:23:01 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 1/6] dt-bindings: mailbox: tegra: Document Tegra264 HSP
Date:   Wed, 10 May 2023 17:22:43 +0300
Message-ID: <20230510142248.183629-2-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510142248.183629-1-pdeschrijver@nvidia.com>
References: <20230510142248.183629-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 64adb8ae-803e-4c8a-61a6-08db5162170a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMunmwWJmQsqr0ULoUyFp3feIUiC6Rvb8akeb2lDIdGJrKa5adYuZIPIyFp4J8dL0lKdKbf7BO643LUWdTYzzTRb4EF2S2yidY+0itMf4wUIj0p94leDZm0+FiTpXyyyS0kt4bxXwMDm4Uwnd07qZl/peebNohAkigpuXFT0E+s7H0GXca+Po6wCsp/J9Hv65OhU6HDBug02yt8FecgzH+j+HrP+AGblQTSjzk3Ym3b/HPouf17jNJH6hpOt4QKoDL9O7+lNOTM/2WloZP6HrQePTTiaV6WyBb2ObaHIAVshmvULBi4BRpnz2X3sQ3twxIEkYkBZAQ2q0hI1am8Lp2Qpz3dZ0VU/1QyiQrf4gx7mBhKZPB86iCRKSPL8PK7OLE25r659EqHAyiM+RszRJimeunbFsBcIXTfMHKq9sc3VPfXvBAwXGue3hdot09yXgLAFlOErVbfg6YOwanY2j78zUUirKuQBpYmsTbclGOU8VDIAUg+Vc7zech/ENjcZZUo/JRrSBLwQeC1MYMLYcSXw2VpXqeD2iQhnKrtlhZjF/72aZnlprwWSXP9wtIxSCYru4Y4NZfo8A4OXaMmlr6la7uQN2mTamUuiISQ4u6gIM5GOrqf5XcGct+4AOkgoxPuqYZUv20/wvX2us/34bC+4Hhfuwzul3MP3v/C4OYP9tSikI4caF7HzzaFY8h+mznBsssWNmT1UXOAJmBVSVotIXg1vU3nayyzxRzHvO/WF4Y6Ex45zkquZUEpjtSUC
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(26005)(2906002)(4744005)(186003)(15650500001)(40480700001)(1076003)(5660300002)(40460700003)(82740400003)(8936002)(8676002)(110136005)(54906003)(478600001)(36860700001)(83380400001)(2616005)(336012)(426003)(47076005)(36756003)(7636003)(356005)(6666004)(82310400005)(7696005)(86362001)(70206006)(70586007)(316002)(6636002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:23:13.7164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64adb8ae-803e-4c8a-61a6-08db5162170a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string for the HSP block found on the Tegra264 SoC.
The HSP block in Tegra264 is not register compatible with the one in
Tegra194 or Tegra234 hence there is no fallback compatibility string.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 .../devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
index a3e87516d637..2d14fc948999 100644
--- a/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
+++ b/Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.yaml
@@ -66,6 +66,7 @@ properties:
     oneOf:
       - const: nvidia,tegra186-hsp
       - const: nvidia,tegra194-hsp
+      - const: nvidia,tegra264-hsp
       - items:
           - const: nvidia,tegra234-hsp
           - const: nvidia,tegra194-hsp
-- 
2.34.1

