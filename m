Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB4D72C368
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbjFLLtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjFLLtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:49:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DF15586;
        Mon, 12 Jun 2023 04:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0B0kLq6DV5Fgqxprvj/8v8h3Fx8av2LTzH5IkjzRzMXCHVuikE9RbErFm8MpcIEmDcrmxE5zNK3bSttbXcmO8Ouzy/TagDAtZpq+4Q2yf7oa5CP0Vezhx41XIC8N1ffLYtbYPHckFhnV4T3TktfmL058ev/uv+xABXDrEHSo7rUFWdveQed6WELjGc/tG6YfDx9uHj6clttuRg/J3j0Nt7GtuNV2tBQmqIYcg72jvdKHj1c5qAarYbYsAXG9h4shdVwOI53PKg/NPFQlf4sChsIrXqxnKpBsUqI2zz2DdwLfV4EHep7GNEgkwQyA9hiyINed5kEEQHxun37qyZd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig1F11iIfFiiShTLe5CrKMlbmabdsLvjJj48xDR+j9s=;
 b=A4URu1NY04aYxGRKpsSIf6cnuZ9O8gkwCCK6BoVx3utQOpIm/4gKnUCFnch28igfIU9LWYDFoSSgj+V+eJ4jd1LHGLK6rcb3PMpToetbZ4kGgx+eLArptZZzmmTgth8V/ybRw3drHMlOKTe/DaqyKePIygCi8rxsrS4o8WHufdoW1BbAEb/G3XFCWiP18RVJBBI86kG0lg2lGG2rkWGjallFrjigYB/i8eNChBguXl2CEntWY81EL5jBadzbtN/eWntyeGn10G2hWjzDqzr2G+b2UOt0GqZxtnlfLgLQKogoOhJfCFjHzQHW7N4OsoIQQsJkUEkcDURkMYPahGI3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig1F11iIfFiiShTLe5CrKMlbmabdsLvjJj48xDR+j9s=;
 b=UXHri+N0AhW3iUa6q5uy/r0r4h3Etj1h+Fu07JiHdYU/LRtnRsrcwJhE/hj0ccEe5gSgQ1NHEcFlFHocHs+USdN67SYRZjAG9KcSgkhbjUfMhsct3kCwjj0wcJFtzvHSf+m5AWNRGbmo//vTl5sJ/Hbx60EzfQheI7LpKRmf5sE=
Received: from DS7PR03CA0298.namprd03.prod.outlook.com (2603:10b6:5:3ad::33)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 11:43:07 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::78) by DS7PR03CA0298.outlook.office365.com
 (2603:10b6:5:3ad::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 11:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.21 via Frontend Transport; Mon, 12 Jun 2023 11:43:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 06:43:06 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 12 Jun 2023 06:43:03 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <gcnu.goud@gmail.com>
CC:     <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH 1/3] =?UTF-8?q?dt-bindings:=20can:=20xilinx=5Fcan:=20Add?= =?UTF-8?q?=20ECC=20property=20=E2=80=98xlnx,has-ecc=E2=80=99?=
Date:   Mon, 12 Jun 2023 17:12:55 +0530
Message-ID: <1686570177-2836108-2-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 225a71a5-bed2-4ca2-0256-08db6b3a30c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhBI8agY1iw/1jQ1h4334CmUUMbjKIv0seEYCRWfLPXnXXpujHV4x0LJTNji+v7pa9xrvV+kxHDgeBVu9UZ3ImJU6CW3jUKicE48B41WgRNJRyNWid61zy95CNZNHhDWFFnE8fNf8EKP7mx6GDgHGai0LAs4pttABblkjaogsGikR0jLJ8h5VpH1CDenHpWT/OBMIKkCLFh1skGQ6KdTu+5Kbjssck3ixLGzHFb76cqIwKofX+U4IqUQo/rGGE5R6RMTPDx6n71pa75e71v1TJQ5GF1BB/wPWOI5f6ngxzaIb201OmExPx0ZHF52G4uUvR8CqRzs8DW0odJM3bdFFKg0BQQPrAw8SAsKskF9tWrSY42Qbue9L+PRlNJlmaCjOp9OY5LaYh5RHEIs4cSvCZ/sq4DTPgeK88U5Wyzyu1vAWS6IM3hqiLFo2WLI9xX95GS4/bDE+CTz7JcSnZeKzHGu3LRRL1Uvup1JoLcX8IOY5GSdAoCv4+CUVEVPLuWfheYhxCQbwidUvY226MdIHSTIElA4F44t9yH76+vmN2IJ7iiO0qXQ+briJ0uunLrujcCRmqf2pw3oSuPY42TUbXSHSTAcHdhD9+sIm22Qf56cm8cknmLzY4e8jJc3ache0Q+XaO+JUi3twEvk55RdcknG10x49ZcNLFBlKE8LWhCWipb2JOWGNbcFpWF5zJlFic3pnSBNvWObPu9PfZjguWGsRQ015JhrlfPWXEBXb2m9odyDGuh1ddmjcIBO/zPX4OS+XUhT8AUTmeXuNfDFIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(54906003)(110136005)(5660300002)(4326008)(7416002)(8936002)(44832011)(41300700001)(316002)(2906002)(186003)(478600001)(70586007)(70206006)(6666004)(40460700003)(356005)(82740400003)(81166007)(40480700001)(26005)(83380400001)(426003)(336012)(47076005)(36756003)(36860700001)(86362001)(82310400005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 11:43:07.3187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 225a71a5-bed2-4ca2-0256-08db6b3a30c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECC feature added to Tx and Rx FIFO’s for Xilinx CAN Controller.
Part of this feature configuration and counter registers
added in IP for 1bit/2bit ECC errors.
Please find more details in PG096 v5.1 document.

xlnx,has-ecc is optional property and added to Xilinx CAN
Controller node if ECC block enabled in the HW.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index 897d2cb..13503ae 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -46,6 +46,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: CAN Tx mailbox buffer count (CAN FD)
 
+  xlnx,has-ecc:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: CAN Tx and Rx fifo ECC enable flag (AXI CAN)
+
 required:
   - compatible
   - reg
@@ -134,6 +138,7 @@ examples:
         interrupts = <GIC_SPI 59 IRQ_TYPE_EDGE_RISING>;
         tx-fifo-depth = <0x40>;
         rx-fifo-depth = <0x40>;
+        xlnx,has-ecc;
     };
 
   - |
-- 
2.1.1

