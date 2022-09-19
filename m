Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185965BCE50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiISOPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiISOPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:15:40 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2081.outbound.protection.outlook.com [40.107.212.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D008D22B1F;
        Mon, 19 Sep 2022 07:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNtwPujkkrm8SG2/UCYsGzTV5G9fSm40oAd0f6wCaH7l0v/3PfWoTH9oNv/C/A+8kfn9lvYNm2LfXCnxSHGe4a2BxhIF7VuFoQOznj3lFdFWdNlt5SYrCCxtZnFX05/1+3BSzgLDtE1KhINo76eozb/StM1CQxRZ/LS4ctrqzqE9aKoELPGo5hJKa7ZiftD8QrbYil/sZ6CSsr8uHvxjACEG0neIdWYDb5sXeFwzAMnzlgsHKBrlEnnIjnYpNCVzoRaQ63K4K7/t83OurRE5uGIDwZlWzD40omigEUcJPxYb4LyFK8fUMqLlnR3zDNTOHEqPyBd1lxdFXQsrn5CZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOfzlzVM/hxhhjK+JwkpyXDU1ZFV+P07/WO5ezM0v1s=;
 b=N+vuLAW74NJnpthx4S+oxk4dOs6dgaig0z7bKBY1tBUVzBWwMRF2PrWBNGQMFt8Z6ThqRSQ9NKvlO/Hhr/1FY87ekaSvxzh7+V5HkdOq3l0AiOoPkYx3zjh90sOOmzH6r3zrS1YxnFdRQvn2iehrPxRctu81iIq5o2UaoNX2EOYfloC7yunjnkK4Npq39+b7ww1viCwADhRFrB7I/I7Y1hE/n0iHS2nirhg39xJy1NhUiscq+88s1Gax+F72peRGvYMCWuMN/BuNkVeudjaAgPt6ukhpxoMOHv7CITmfbJO8C57TJLyWM2k+6TdTydng4NZtSnWUFhwmVPKsowL8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOfzlzVM/hxhhjK+JwkpyXDU1ZFV+P07/WO5ezM0v1s=;
 b=H0jSXneFICth2IjG4eboecUeKLXJzN6J2Q+K/Rmk5eIxD6p1qBXEmAnFJdUaJwzb4Yc+Z9x2D8GvpIPCUJDiKqAhLaL4oqJsVXfQ+pkUmyVHU3ZElObrcLGN6SIOROI5Zt1Cw8ZVtUwWTleigLaDBVUj/4M4bfxiE7iYA5UQla8IVqXhP48o1rxtgIELwNLdZ6loUJSk10PzoFvmW+8a46aD8OKPJnXCXNlT/ePAOMzPp33kYBXFvrYBufgoxESOpqgnN69yOzA2nLd5HNGQPydSq/3SzUdoVQQl4OlcAHeXYZ0ks1aoc+67FD2t8t9/tn0tElDjoDE+s3y8ataLpA==
Received: from MW4PR03CA0003.namprd03.prod.outlook.com (2603:10b6:303:8f::8)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 19 Sep
 2022 14:15:37 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::4d) by MW4PR03CA0003.outlook.office365.com
 (2603:10b6:303:8f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 14:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 14:15:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:15:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:15:21 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:15:18 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH v5 3/3] arm64: tegra: Add user PWM support on Jetson Orin
Date:   Mon, 19 Sep 2022 19:44:55 +0530
Message-ID: <20220919141455.31084-3-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919141455.31084-1-spatra@nvidia.com>
References: <20220919141455.31084-1-spatra@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT010:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e317b6-f976-43fd-a6a2-08da9a496c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8mWcJ9PFYnrGQPjDZTls8yp/yE8cu6AMu7jZLD/YJ9NX6vI92C7763FKE44XZYuB+poAkvVnNPcjIW96Hy9cJT6nF6bK3d+bUNhJauIxOcZVX6V4cbt0NUUpGcFLUUysNiJPUB4Njdyqa/OvTNWDRzet5J4qSqMASNFcWVijqT6r+H5FwY+714CnG7LmE8zPxAiysDMzFJ0noSwKwZSWi/pMJsb4I9BPBf6B1wO/GHUE/r39szqcOdgQt1Ntpdy1Gn1MXlLsyFxcIuxjYZUH1dU5TSgeF3B6C6SVask2rJsl0xNND3XktcT1zhH7DKYcGvzWTgig6FtWLg8dSY8wXVR+u1B6yBh6AGEZc0PsUD24RAQVfMzG0m4X8TfE+N31HWupjAeeoYBKnsb++K9rHhIWoqkzUKjMEinVQkbMpolHvkoyOZ2h5Y4AUX5O4811WOhJG/x5+JGs7lNK/CU6isWPJH3cPUDwNamSpAZKSyOUd+Pl59of+8LPX9xSFMnox4h73Z2Ph52oh2LtcACXBj/DSkNkan2cMTzmdb5JB3VXEf5OuLZ+bL6Y6Ts/z25GZhDU37m7AKCk6efsognHPXzjnwa6YP9vM7HIG9S8Wydaa3ywK2fRqmDgDaQNGM4Oc7OdSv1m6X3ASUR3SWVUcyH+ew1lWFpwqw6qQysm51LOtusgCdSbId8YdmA02rWDlp6lj7G14R8f3NPJcF/3IfL1N2tPA+ty3Q5d3C1mWc1CqIj1N04R/9auS6Z1Pt9XrWsxM5fBm3qSvhtLsiK9Gha3yz7NhOgklwW+eDjyuPI=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(110136005)(36756003)(1076003)(7636003)(186003)(82310400005)(478600001)(26005)(356005)(316002)(426003)(5660300002)(86362001)(70206006)(336012)(2906002)(107886003)(8676002)(47076005)(4326008)(6666004)(82740400003)(36860700001)(40460700003)(4744005)(7696005)(40480700001)(41300700001)(54906003)(70586007)(2616005)(8936002)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:15:36.7199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e317b6-f976-43fd-a6a2-08da9a496c6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable in device tree and use it to drive the PWM controllers on
40 pin header of Orin dev-kit.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
V1->V2: Overriding by node label instead of node path.

 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
index a85993c85e45..5108013a18c6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
@@ -3,3 +3,15 @@
 / {
 	compatible = "nvidia,p3737-0000";
 };
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm5 {
+	status = "okay";
+};
+
+&pwm8 {
+	status = "okay";
+};
-- 
2.17.1

