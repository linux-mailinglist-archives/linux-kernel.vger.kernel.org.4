Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1292F6FDCCD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbjEJLf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbjEJLfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:35:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AF126BC;
        Wed, 10 May 2023 04:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUs2XBSFtlJC+TgncE+14RuOmdQHR21OgnpSXcwRxgHEHt4DbsHIDdQ7553Iy2vE7Fla/TtmaglUU8GJsE7OXWcJDtpo1H/QRpwBiI8oUOBRyR2bcSLDvxFltwXRRtKx6vkKYIGlaUlmS337ZZeYbiXKkcVZiDLydJijp6JoltXZepGpalWRz7d5P8IRKHPSJR7BPuaUQtrTjXGDlaAWvH+2khg3GmKZmMK/Euav03/LRqVjzZYpkq3SsQHzvrCX4rPRgwcKdqiDUDs/p0k+VatnnTZlihkmrKnb2zhvgaOUEoVGe6fKJfsXTYnZvpWuXBi8b7nKEPwGRN1p50rA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QFbVU4iNqq8Fhl/n5IQ/osELI+lYBnhDbBsHekle3g=;
 b=avaRsS32PHpvdbJ6XKzkC9TsYAACOXxf7Znam8dfL+laOkZPZB/o9obVd0FAmPqLIKURuZtoQDDOf/75jpe6J9afeLcJhGmjZ8Xboc0CzZ9rXDpF1PWo/JtuCtaowQzTonKn4BDNuxDifguP0m5GymUZhMz/EEPB2to2TLsZk2nVP5vMT4X11qdqhth4szbUjWKPNIhf56Km4Fsbn1pSCtayNidhwKPEv8NeP+d2EwghIds/AwUk16rkdFlcTcJVTLtimioEfTRgR4kRo1yl1mb44oDJqKGXppiDhj4nEffEvbQytqqewn5ze6t2hUS05EXtA62JpiNOfu7L04T+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QFbVU4iNqq8Fhl/n5IQ/osELI+lYBnhDbBsHekle3g=;
 b=hfnQTJvsO/+ZQ1J28Jh+EZSb8cXbeBvlm1jT/vsf9X75SFCuNLEfzV1LDzBA2d/pcWHPqwVlbou4VSi/ffa8YZZNIIR8i4otN1uPz9xr/ORcStBoGP1f6oT0S5lri6uRiMASa4CsTwAYCb6amJqKEXLvwcqcmC7DUSuoRz/ZD7nQ3jZeberpnc8S37rxiPr+Xlss/FIApQoj/bnAhy4gJtBV7ImY6dUl/GWcXE9faN9dOKsNOl7UP/yXa4FimKx5IlKe3G/qByrRLQx3P1fAfQ3/93fUkxCgf8EKgQwP+zVSc7BvuJFfvzABfcj2gwgO/5Qe5y7IPmUCtQs0V67WIQ==
Received: from MW4PR03CA0196.namprd03.prod.outlook.com (2603:10b6:303:b8::21)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 11:35:13 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::38) by MW4PR03CA0196.outlook.office365.com
 (2603:10b6:303:b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 11:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Wed, 10 May 2023 11:35:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 04:35:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 10 May 2023 04:34:59 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 04:34:57 -0700
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
Subject: [PATCH v2 1/6] dt-bindings: mailbox: tegra: Document Tegra264 HSP
Date:   Wed, 10 May 2023 14:31:26 +0300
Message-ID: <20230510113129.4167493-2-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: c66a60d5-aba0-4861-509d-08db514a9e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DVYL9hOSyHh9BuJMF8AqVDwLAqqmmjOZ7CNfhUFtUMWQ/+TIW75qBBOKaTCH+vCebOGdo/Wi91AJIZwWZ8wLBMJ4YCxU5hr1ARN18pH+NvF6PfQQ01FX5PWvO/SJPrAm6HZs1XwYyF+tEW4Np0DUzS5dPPEsdn8KnKGXrBxISe9Cq61rRqS7gpUEkhGQtq761G4nwSOVZ7YyPVcT/q1iicuGLvsmHKGlzZFw0b6lTDgZckLAbcv51nmzdsjUqc9J9NxbL/0yB/FLVcLaldqqxehHiv1+/ldWUeGASM3ipPquDD/XBbb+fyYJxXla45+NrN7cj1bBNAPtyDrSGGPtcmEhyQyDgsyWPomaSqGed+D1aCEAkjdr+xjVeM/V5OFMu3Y1exoKqaXtyhiMzqM41QRAbB7F6CxS2uXSK7zzUMU2DKbYTnp9cJ/I/8cSfunn28T43/3XYnyBhEmWq/Jl0j5RQ8vswGdsdzXuDpuy4zbk8ZY4eQI9ph+FSMaguVI7tLJUU0Y6MUiQ6oFsZ5qBvA7iqEn9tOgdVwOZKK7E3Tl4Ub2irc0+DUflRPlMuweMurU2VG5/U3SqZgyM288JJSa+NLM/3RFwJc+Yp9u40xs8ZKhlp0uf9uzc8ZujH8aT1dZgj9dC6HLG5YJbXX8nT5hYFnnle4V1IYHex+qmf9MwDaQgsKBgPz3Xn7syMOAmkMHnAlgQPYhnz1hZXCrmg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(36756003)(6666004)(316002)(54906003)(70586007)(7696005)(6636002)(478600001)(4326008)(110136005)(70206006)(40480700001)(82310400005)(426003)(15650500001)(5660300002)(8676002)(4744005)(47076005)(8936002)(41300700001)(2906002)(356005)(82740400003)(7636003)(186003)(1076003)(36860700001)(26005)(336012)(83380400001)(2616005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:35:12.8792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66a60d5-aba0-4861-509d-08db514a9e62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556
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

