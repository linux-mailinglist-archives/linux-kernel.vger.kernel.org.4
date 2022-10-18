Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1006029F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJRLNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiJRLND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:13:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101CB5FEF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCvS7atpx3cqyuyZpLgu0JkqLE1VqXquJpT2uP7fh0SGDvO/aKYSxxHA1soGyyxsauu5gojId55oZHnCbKNBNkTZmZ+fKRHdvXdMN7kg6M0r0cugTsq1TyNR41mO8+H6xAEa7ESby9rQG17coUcNa+sWnNAmKmVoVJmUf9u3nX56CNK5IzN/ChYjTfRoUEGSqsJ74XqIeKpA2TOuG8aLHsBqmlnBbvx4U+zfZFa61NBJFvfU/so/FSGfeM2WbhZUw2WUqMbDMPCHWN7hDOwUT3wsLtU5NlZpWwyo2tHZD0nqzX5D8R8eEcAsncE0/MYbGIWr5CxPwQvic8Uecugpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeAPQEwQKuNZQMaJQlGzvdbHNmcoYOHCAFDtDi7IAuU=;
 b=Tmn45YB9l+tsr05PR1EvciTDmH2XlZZOw01S58EnXrvlpSRE2OaT0UDM59BqxTCfm04sdXjccE9sHjs5Sxrw3zWri5vTKxGZw3KdNsMi25LX1l+RrIH1MADkrlYT0YiqZew3MF3MTD7TM3jLxrl95eJVgEHxE00cxvW2/sHZfZXxB50HKp7l8CFxgtN0RNN8Hy41axf7vjb2MoCUiQ9AX7nKCqlO90JS4ULYHt/DSuHINlwUhiH092B5pPPDnUprPv8NzxVUfl3Bbwev55CAuijnoAO2BjNchIvjdxDooy+PZPwQ3LABlts0IK0x56AD9t4ucO3k5WK7j/MM334/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeAPQEwQKuNZQMaJQlGzvdbHNmcoYOHCAFDtDi7IAuU=;
 b=GMyd3RigostGeF5U5g2wRda3ebn0Svm1cySq+MFUqo8pY4c8TYevDQXs3bqDqB5RPlSLiH+6NZ5g47wDfLnQvFB7eDIZOFUlgLumanSZSZZd2hUi+EF8y4QoXJjR/sPAoa11FwGZlC+UStyIZZJAjCC2b/56eJ83drfGb5U/ZClZyzBcfJPSAPHwMPRGFT5TOdJewdDN5DfxZf3ApShdKpVr0bfo1moUBItJamzFJZMLBRSosuE4foDTFA3URTxZ9vqkDogF2KWZXklu4mjcljCrUfrPWSbXZf0DiYBeQBkURzYanLB5aAew63VE3pKznKAL8M9u+p5641Rku3uZQQ==
Received: from BN9P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::25)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 11:12:53 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::1b) by BN9P221CA0003.outlook.office365.com
 (2603:10b6:408:10a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 11:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 11:12:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 04:12:44 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 04:12:44 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Tue, 18 Oct
 2022 04:12:42 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <si-wei.liu@oracle.com>, <eperezma@redhat.com>, <lulu@redhat.com>,
        "Eli Cohen" <elic@nvidia.com>
Subject: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Date:   Tue, 18 Oct 2022 14:12:29 +0300
Message-ID: <20221018111232.4021-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018111232.4021-1-elic@nvidia.com>
References: <20221018111232.4021-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a9beda-3aa8-480c-1022-08dab0f9b39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K53Ol84j8q5eqbX0FCs4Cf3DlMY4lThooX/f8KFI8GeMRKW4gz5RbG2gFwG1V3OKJqZW1sd3hdGQGijPCVdDDYj9oSA8OFczAYfnP4MU0ysVt3zbkAvZ7ifGAEC6uK/VJHXLYyvm/0GmUI+Biw+e1E2abjLVOTThwfbsNweqGNI6fne+7mBx8Nh8/4Ud16r25tBhGBQOhxtyJIAwwnBNx70cQlA7R+99dqNu54JsRROSOaR4CFkwy7VBiZEY4TbJSU0KX21vXLdw84mHigAvrk4qTuhKklkh1Ce+BLnMAlU8RcxF45Eo7xvoBAe16P/1us0tJM/r5/iAe+vZXTShxZIbjmt8KKYSeIadIpaB5EIyLU6vmeIFDxXKfrRlm7/D656klzlEbx9mBG0Fa/kzl9EYMrzrIpo3qzmaTI35Ars5mkgJOObsIKta15JRJWjf9lHNV3XtrbFKHc3UYIuCMm3RHo6m9zFaLk7a0ArKHV3kPQJSQWkhG3EyrI4n2asW6FKmwBR5e4vTDL6I3851HY5Y9IHpjCem8eA3osE6TCv4DUSFb45U6DClzBOj5EVISsW837urcoliXyrbc97QyvCrpQ8T7wrbLm+h/s2KEAqSf4VH8eOi/VOCjvSLdbsSyxXAnYXS7Dk2zGpIKcrY2uhMq1OWPeOsk83MlT+6s0Br9Q5pedFKI81K0eUdRQzCo4xBNxBQe0yp3g19YagxWX90GYFLhtuidzyezeCKdcpAiLXdgMdR8SOVOawApYiZkVjs1JPK02Csnb6QH9B9NA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(2616005)(26005)(1076003)(8676002)(70586007)(70206006)(4326008)(40480700001)(316002)(54906003)(40460700003)(5660300002)(41300700001)(36756003)(8936002)(2906002)(7696005)(6666004)(107886003)(478600001)(110136005)(356005)(7636003)(86362001)(82310400005)(83380400001)(426003)(186003)(336012)(36860700001)(47076005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:12:53.0632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a9beda-3aa8-480c-1022-08dab0f9b39b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the VLAN id to the header values field instead of overwriting the
headers criteria field.

Before this fix, VLAN filtering would not really work and tagged packets
would be forwarded unfiltered to the TIR.

Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 90913365def4..dd29fdfc24ed 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1472,7 +1472,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 	if (tagged) {
 		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
 		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
-		MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
+		MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
 	}
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
-- 
2.35.1

