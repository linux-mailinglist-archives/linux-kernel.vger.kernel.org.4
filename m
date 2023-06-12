Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8A72B92F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjFLHvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbjFLHuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:50:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F12510CC;
        Mon, 12 Jun 2023 00:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNZov1+rNP77lyOixQt5VX/AtAlSX71EH21QsH1XhQIbVtdYRu2eDxZdrDAi3e2nPeQQeE/IqDWK4RKmtf6otMLhz4fcpZxBplxvV8kUyQN8lBMoiGP+YEVGyi0iM5giZJpZcDj4QXZREHBxHT7r3SuD7bButZL5Vv3J+yJi+x44gzV++47fEB1RzbmlEN0YO49IkX53qiweAAZ6l11dT9b6bLLVRMd4LvWE4TzObdIZy2uEjIsBoKifo2olM0nNuMXBu8m6N0Qqn+LKuscqAZtnOJdOP9nA3lHvSnZ770TN7dl0AOUVcY1uMqyhDvEuyCXEpdaijYKbMx7g9RK3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ+Hxw3NbsunbCkE2bMam0WEBUCbPvkSDplBt/1jnYQ=;
 b=dbecDcddqKwrET8Cb18JxsNqiubpW0+FkcUj27N6H7CGyDbTgQU6UQwuJ1n75e6P8AVoFONjDOW1sG9b5bDtO0iX6cSjjE+O+90yJ+Lyl+RdC3wj1xnTC8pfFS1d1MvaHcYeDo8aO+I5fohDOt+A6hf0pE3uYtuJqzyYy7VZucnGF1Cl0cMrHKMEg8kz7MYGlP9BSlLgD7DLQrzCrTvLfPOyDDdgxOWRpu3g8iJAJOPREp8dD4MZW2v7+PwyFfqUqq0cjRtZ/+bOeqx+k3O2aEyoAJwuWdgj4zViPxh6l0cdxwjJ3+QnCKAEF2PdnY9npHmxIofFErmxKhZzmmhoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ+Hxw3NbsunbCkE2bMam0WEBUCbPvkSDplBt/1jnYQ=;
 b=ityaNEl09jWldjhUx5S3U1NR6FKE/7YK0B06dYujrOJQBczoLIhDOvOhovzgVbNUb9MltwUo/LZWL3fWm/7SoNuFmmfdc2VpAbqtW/kZdvxVYVdMzkKs/zPV7TWNAyG9+aNTkxDQyvEx6Vrd05K8/a/2xRqT//kNQ8+S7B3/jio=
Received: from MW4PR04CA0155.namprd04.prod.outlook.com (2603:10b6:303:85::10)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 07:42:21 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::c9) by MW4PR04CA0155.outlook.office365.com
 (2603:10b6:303:85::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 07:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Mon, 12 Jun 2023 07:42:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 02:42:16 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>,
        "Amit Kumar Mahapatra" <amit.kumar-mahapatra@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: zynqmp: Add memory reserved node for k26 Kria SOM board
Date:   Mon, 12 Jun 2023 09:41:45 +0200
Message-ID: <8ddc7fb4bf40faead7a015ad7e095f3f7d2ec191.1686555698.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=michal.simek@amd.com; h=from:subject:message-id; bh=w6JfC03gzUsXK9qu3GdeOaZlOr1C/FiP/08AEzrGoqo=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpS2M8am66rka7ck3Hv37c/qT8/etxzV67zdLiC6SnwVu 4D/U5+OjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARlwUM82tu/Zwu8sVu4yFf kRPv9k28PyP7/iOGeeYTRHOlDp29smPl6VlZP//uPlhVygcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a08e99d-480d-4fed-6e53-08db6b188e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/p/ou8bn7q17kHmB6n+oIbeZVI52dN7ru+pnl+F49StHkjYjmW0mR5OHPaTl2rrZdOzafmDret3XfGw/bjoTcR4HXwpKqxA3nc9rv7bC6j0aXO6ZAZbGKqiYUibUqsKRwwAvZMYfQnI6A+OIeiXF+pMKtANBrZ3iaH68Vj3djbJW1s1nzBtxxWIrxZcuvg4ZXzPtDGSca5qhmJmH2aRGi/Tu/Irf3Qq9I3oKgOY9XgtAAcJ/FXq/h5DamudxB90aLvlWghE+UPklpRA1ePQk+9LA//KeZbXeafSKZgGHPYbZvoUEWQaF38xqbjYlU6Gs3glC5sXRFTd14dfJXqcvTDYHfFhIQ3pCbDZAMLvsiHxmfdhAYM8of5w8JM4t0kGxm+yLfLbTyiYRMm3qcIYwyqCKvi0MzyNDLMuN0CwaQBfAZHM9L+hBgxORoMr3r7L9X56yjomaqpTvufiyUlDJM0UZpnM194FyLJ4Hj2N0jurrySmk/YMhuJNj5j+4MhSJYhqsn5DNKhUrsA2eOt51Rsavfb1VRy+YJL6hO/+aFUNQtVtX5/GYlaAoniS2Axdcslu1N5tl+5KtifihlMmM5yoWJ/LdP9wcXjt6B6lplJ7CopFEZIoZ/s/EYtJTZulwlVkmIm8U8BPegas6jkaKjF1IBbwaBNmLuLOvJ+ca8FFAc11VVFAGz1xom8xs+jY5AwxrhVzOFj86tgkWhmPGG3oiW3OkB+Qp25UFPDhx9buHaj+cCuVsH3GX8S83ax7VtbHjuxGaiISn6igL2S5f5AC7d7nWPeVvVAfm5tNaM0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(54906003)(5660300002)(110136005)(4326008)(7416002)(8936002)(8676002)(44832011)(41300700001)(316002)(186003)(16526019)(2906002)(478600001)(70206006)(70586007)(6666004)(40460700003)(356005)(82740400003)(81166007)(40480700001)(26005)(83380400001)(426003)(336012)(47076005)(36860700001)(36756003)(86362001)(82310400005)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 07:42:20.8716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a08e99d-480d-4fed-6e53-08db6b188e16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>

PMUFW (Power Management Unit firmware) requires top 1MB of the lower DDR
memory reserved for its operation, this is missing in k26 SM static dts
file. Bootloader or kernel shouldn't access this location.

Signed-off-by: Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index c1f21b0e1760..c4774a42d5fc 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -50,6 +50,17 @@ memory@0 {
 		reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		pmu_region: pmu@7ff00000 {
+			reg = <0x0 0x7ff00000 0x0 0x100000>;
+			no-map;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
-- 
2.36.1

