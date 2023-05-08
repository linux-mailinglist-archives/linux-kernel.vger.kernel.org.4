Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E176FAFD5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjEHMW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjEHMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:22:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2F435DA4;
        Mon,  8 May 2023 05:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E043xdFA9ImNYrWe7L560vsfN2dxESIaT7YPvc8e/zGCh3IbSJ4PlRwrjsL7WYCb5sqldVE3UPMFu6Pp3+BwepH6BGpLqhsEytTVQnsbskQP4KlwOAm6xCr577/lNwzdWlNYkk8h1pclR0rWorOFXE4eWOE2Gh+NNWQHdA0eT/u+CyfWTmX4RyPbIdpJkkRr9fOjhFnayat3EuPaVV7gjrU69hSqrep6URi5+L8S3qk6yRusW2ht7i6bREdzVd4Pt1ZZJRMOeE+fzP913Yzd46TIxclWtQ8dwOKmQYi2K/dfylln04o2G1OoXBWn7iPIu8TIyf0jfO7GjLaEah1ZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbTEvp50RqbaAbCHYNh1Aeu0qYmjLlrZGmU+v+U7/9U=;
 b=Na9Z4CjNNFjEPDBfZJeQjS7937J3lYDUnjsWFF+tm+3Gy70UJqB1j+6WsjYOb4jMBGRSOufYX5MNDXZKuHky/+x7us2V/Bu17PWIaC1YSBUCkoAJ6FUQu/oThuPsjap583FI6o7ixvh43PT3u4WFei9phUrupeia/kPpJqGG+WbKf+0HConU/yBf5/YspeH+x5SSXmq5Bd7fUuokkEt+tku6Ngd9Df4InUYbxIP81EAmukiA1k9qWy1D3KLZFFqs9b4Bg3MlADU/o3zRQwTKWru/AKRJJJjVtEzV9thlQCNiQV/ByAtxLRnymbcF6qs3odlg5L9pIrzlmLWA+j6w5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbTEvp50RqbaAbCHYNh1Aeu0qYmjLlrZGmU+v+U7/9U=;
 b=VHgtShPIBrN0GFkmNSdISJ+j3657UWq5w19koCGt8kI1dAX0DSRIuFZl7EhyrVKv3RObrH36FUryVLuFk5h3qtFBC1yZAYreUD6/P0AhC4L14ZYFzRdROdhsNcCYBw+dmdMzUIoRXH770gnGGLzUurPdke+KzFmys3WCeegdl2qX/BDD9iqxFou2HoS1l1yk+bC4UqvKw+88ZoN9ibTA6QolE7UVFbQW2mhy7B43zAbGtcQaOtyDkQzUc/OHh7DidlqGjj4J4VtMWkPwhGjj/fArqpRYwVyD1jk0PW6pDHdCCHna6xlBpfwi2eqGTAP7/lCK3+oFtBmtTK5sOsj2ag==
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 12:22:53 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::2) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 12:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32 via Frontend Transport; Mon, 8 May 2023 12:22:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 8 May 2023
 05:22:39 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 8 May 2023
 05:22:38 -0700
Received: from mallet.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 8 May 2023 05:22:36 -0700
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
Subject: [PATCH 1/5] dt-bindings: mailbox: tegra: Document Tegra264 HSP
Date:   Mon, 8 May 2023 15:20:46 +0300
Message-ID: <20230508122048.99953-2-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230508122048.99953-1-pdeschrijver@nvidia.com>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b062dbf-0669-4610-357d-08db4fbef1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYg0H3Oi1oZky7c3ra28YWItNHwWIsaPsw+l7/adB2Ws/5ogE7OCm+EaLid2YDaVyIktpIpiBJHJW4wVBcV53Go+P6ZIAjdOrfvx/JjrTzJvueF5IepOOSrgJOF18rHth9K00Uf2/TEo2t4l5NsTyuIskdmlxesSyfa4OLIkeKdxETM3ZlS423xViHmBN10KysjLjsfGwTIu6RQmV1PynEQvRZ11ES40Dfl1ZUioyfsH0IVIqZgZ0UfApNThqgi4szf2XQf/fdCCS+QsgRb7x/OYjnjWNoiLHKi3XSx/8J8zEZoJblGERPbjC23+8OPC23L1dEgJcnVuEyVtADqtQRb2SQcLweZaQEGnQm2FoZixzNpZkcACfsUimtJQGV4TxqmUYc2fGhHysLLEKcYblJsmEpprdYN4nOXKhUq7RJ2LP/CvGlpzqFvCHi036+BkM0aCUPlVbeEsv0POrfibgjvhtK59KXU0MRH0Z/OhagpEs6lVjYZhog39afAGmaw+0Hh2i1uuRZxoaCJe+usSlrd/auIz/+Pcl+RshuowBv54ntNlYb+F7LPk1k3T9L6unJxA0tSuL4TGUB2czXVOYdWfkP8wx7o9ER0YjolXomTUddolsMbwthfztyzs42ff8f8jvI59rALo/AXixKuIkwztKnr5830fFiKeyKGUtjtTNYrCg/bA0iQ9jSJQQZXp3d8149lXnkZZs5Cf5JvnjQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(26005)(1076003)(83380400001)(336012)(40480700001)(426003)(36860700001)(36756003)(2616005)(7636003)(86362001)(82310400005)(82740400003)(356005)(186003)(40460700003)(7696005)(47076005)(110136005)(15650500001)(54906003)(2906002)(4744005)(8936002)(8676002)(316002)(41300700001)(478600001)(70586007)(6636002)(4326008)(70206006)(5660300002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 12:22:52.3647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b062dbf-0669-4610-357d-08db4fbef1fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string for the HSP block found on the Tegra264 SoC.

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
2.40.0

