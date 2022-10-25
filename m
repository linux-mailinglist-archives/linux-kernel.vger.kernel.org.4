Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD10B60C9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiJYKVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiJYKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:21:04 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2094.outbound.protection.outlook.com [40.107.249.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EA418B4B2;
        Tue, 25 Oct 2022 03:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHvLVm/JJeEyvyqkGniFgONzAn0NVNnvM8BCgx/4y0CU6lGG3OWjD5ugfhNdlZT9HoUMZEUbvQnyxTCl2RR7hSxLcQ8X9jeLXEqTVbVCJwDHvIVWzvqwlwgQSzCDMZ+af+BsWD+32fRE/T8qPfmJkux28sSwydC9x56/cv3UhOBle/iwzVd8n3Kj7hGZeABffYqlYfj8agSdJ+LpQIKM4jF/MbHispvzIt1SspM0m7CTKtR7FlEZHPHRCxz9qXngx6vqGguMdMgzSOeF+tuPhJEtPXRvyZMbkbNWzH+TYMV8NOp7oMVZKkMOLO3xD1zfY1vb70OmtthnbI9Bs7K3fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT3zKk5OE9MeHqRlwAWA3oRF6Rlnl/yzQNBN+2ksvzo=;
 b=bQyNgbfmFHq0q/pgOxOGUYJT2iQMw6qg/VtlvtysOY2y3Bq8WaYyQ2pUqa+8TgUY3LpOVqctFnyG90ZUW1t4Q2PqMt6Y9fkwcCjiqPmz2HDrqpVf6skWQ815LGOD4s7edLGytp8/GKhGuQkuHCpEivsODMNK3J8gC06repmwcREl6GIkJPwIkvoECZH7aFqJ9P2/YfsWnmmmX/PuTbirhcpR/OhUAB1FsE9bmeqyJ6eAGVZvfFj7GzTSyAPEq6xSV8sHWU5C9kW8qOIUejiBRBjqiitWxuGJbVgUc+7Bzr2X7LteLd8DIhszghgZRaBcYQUc8OijL+2dCzIUNBnKmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT3zKk5OE9MeHqRlwAWA3oRF6Rlnl/yzQNBN+2ksvzo=;
 b=mYsro4+67RZC7A+PX35kFaOqsuET7+GKfkgk1fpzTHnNqpp2P/NKeHG7uvgRtCSqnm8uheSlLwCPzOQaRkFdzBr/8GKu4i5t7MCDkWN1NAwtQhyQ8mVv84EWTWkIpl6kixPfz6GMLgyQjXD/QUxZsjYs/nJLOxcBPTQ+eHe1y1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by VI1P190MB0733.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:121::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 10:18:10 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 10:18:10 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 2/2] arm64: dts: marvell: cp11x: Fix nand_controller node name according to YAML
Date:   Tue, 25 Oct 2022 13:17:11 +0300
Message-Id: <20221025101713.11893-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025101713.11893-1-vadym.kochan@plvision.eu>
References: <20221025101713.11893-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|VI1P190MB0733:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4f4210-9d81-4f98-2425-08dab672376f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UE04Ee4EwfeK34nJ6U+15D7VMf6WjDmBv2dmXf26UrNL/PVLVaqH1F+rA4KwVpTRP3fhjyJAwk0j8ziRLpLI3IiZbl8op5e9aAVOGpUoiuHQA/jgFBUgx4nE7eZm9I6C0qcGt0CjdXI4Gl0+jMtdLPQp2yMCOk5636pqskezviwpU+M7LEJqWOMfgdDpkcGByn40nv7rljcHJD9yx932tfBl3DvIgbGv01XKDPE3rK7pbJWKuZ4A7fbb5DKu3uyKO5szy5PLGsL7dCjn3m5pVQmThKSReoyfrvSRHS6HzZ9Dih/oOD1bO2ILi7qLNs5WQ4gzfN4RoIMWD4hZM827K4hXio693gxyvoH/5fMVOaZ6Nkt45sDoMILrelM3g4pEnskav1GMaHznUJ0d+15ZOphWaeq19t2uXdeYBj93LPCySXADeaePIQZoyMb+98Uo7Qt3feon79nEgd8HrAgSnN1P4mFRfzoFa33Z/6tulhIw2L6JI4E37Qw1fMlwjiaEqFZZSzGISxRJRjOIE3NoHZjTrgAFYj461lZy3juGfkjjulimsH4HH/R5m6iaGn9islNiV9RYLxynNFm6tNHv7l/ub/ihXtiF0EuXZ27Z+UEWzgzJaaYAufLM9o+aaM0jaR/sIIT5DjCr3pm0/7VI9P2S+5sjWLMjeWwg9WAEha+WiD46vD9IGS3kEA9PuekKsaXjns9Pn2HJlVrLm6kF2GcqUuwRQ4k+S+BCSIinP0rnZIquH/qa/GFPPcqaaxjyxGq3z/OaOkngkNQyLi3k3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(34036004)(396003)(39830400003)(346002)(136003)(451199015)(86362001)(36756003)(38100700002)(38350700002)(921005)(2906002)(5660300002)(7416002)(83380400001)(44832011)(8936002)(41320700001)(4744005)(52116002)(6506007)(186003)(2616005)(1076003)(26005)(6512007)(66946007)(110136005)(54906003)(8676002)(508600001)(316002)(66556008)(66476007)(6486002)(41300700001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?33JYDiuZ4iJqBfzmaqkkiqyEaDmYrHqMqVuxFs6mgGJDeEQryFOfZ7tx2wQi?=
 =?us-ascii?Q?/gGTJJCghh1P0u13xrrNqV7aiYAPI6r1ShFumpOtbhbu21AmaeOVBsix+Cd3?=
 =?us-ascii?Q?wA+MylL7d6f//CX3b4WRum1zqYjxEDRrUoHLaZn/4uuuAi8MWNJ3z8v4BFYn?=
 =?us-ascii?Q?Tqv4ZETEU5VwGcDwCKXb1VMsFEJ5ttm90gxrWdBjmSCaII265t8DA46LbFRn?=
 =?us-ascii?Q?qAS2IEHQNKzFYVebceqCQUqEqOnfRmX9pJyNja+qf828DrfSlvHzUvi++vTo?=
 =?us-ascii?Q?KHieturnNJWOikmZiy2PnKw2aWVy0owjpcaugH6iM7M99jURdZNNhsbbL+om?=
 =?us-ascii?Q?bp4RTi2RBnLxo4jNad6aAcISfpz+s1Wj3MNLbeRzxCsQdEoI5Yt418Y3W00Y?=
 =?us-ascii?Q?rjYUHycGe14W09/OPGW8n0exwVxs3m85sO8G79NCiyTySZ08+O/CX+GFW1pY?=
 =?us-ascii?Q?8mIWAP+OIdcMhngc9/6zQMK/DvpwoEF33OU8kpvgGhsi4aEMu/vbtzhCPT+T?=
 =?us-ascii?Q?/87N5OxKbrwGqxcypi45XYi/WVZc1zvkmwZDK3V3SNTkMlvJo5M0M6ijEWKT?=
 =?us-ascii?Q?DLK3cBWnKg03jRe3qNjogIrH9ITy35CfOSB72ivruR8PT096ZtjrhAQeCo5T?=
 =?us-ascii?Q?CkZG7etpH0kXCOAypOSLh9A2A5ZdYesBsKc0HlYXtcPOkNJY29+DwlS/Q/5B?=
 =?us-ascii?Q?E0r016uJ4E4OB9xYSSHE/ZI3qbMCFPRTs1dWZneBIWkcyYYda9eM/aHtZ+wW?=
 =?us-ascii?Q?yRAeBgGo+pmoAcnd8ToMZmI2nn1UhlInANOuSFv7iLLE/6wXM2cyVIRpi7Ig?=
 =?us-ascii?Q?gg179NvTqWk8qENgZiSVWKjxth+3qIk/qdE3qF8AVgsXvCpccwcGTGNz0lCd?=
 =?us-ascii?Q?8xOxUT/gpGUVNcxAj3O0V+7bX+ne784IrNlboNgC1SLJ27ChPkLJUnO9uURu?=
 =?us-ascii?Q?JMhASR72jnGWxf7551ASfk+wR+LmJgtMenC5w1N3PP2OMFFnclb+l68JvI7A?=
 =?us-ascii?Q?mgfAL9t+xOrtUWPnYq0PK27UzWk1TUxeNpqFMde05/2Aqv+aRqIc5WcaI0Ik?=
 =?us-ascii?Q?sDaJnpbzGpkz852KN+7LFEA1rEsguGLFmudE4ATsimv1nWEa5Trz54b9fce6?=
 =?us-ascii?Q?ChC+yYcHD4YIlD9+7vJzZez5WePuH3WfgWFrH/Jx22JT7U2RBZ8qNyZxLbLi?=
 =?us-ascii?Q?rg+iOhjsZGebvz7be60B4/XyQ+tuySgTmI8ZimZdPmXTH2v8k8UlZuaSQ6dn?=
 =?us-ascii?Q?o3TpxkAn2j7kTOuxy0robaMd+iR2+csOczU+6eD2agSPudFSrGrFXwFd3qum?=
 =?us-ascii?Q?ihELs83wYFxB6sTzm3E3jB4n5Dh0PCMwCl7U1d0wt1HgUqCXrbAOTD1tMSyU?=
 =?us-ascii?Q?UWTF9m9l8Fu4cbqrnpbBcQkX5ysflHqxQf/rE91hLKsMkUBg1fhu0JBUMJCl?=
 =?us-ascii?Q?77XoGZkFbCmAcdMxGIoxNJ7sJSZMo9Kk/SZCCTxeTddUbBAao47R7q+w5cu9?=
 =?us-ascii?Q?iCchSIZhXIMzRGc/gXkUMtPeKDqSzQ/G3C8Z6CdpU1HJnmaIafSeas48fdPH?=
 =?us-ascii?Q?9tw5lVeWBruhosanX1i5nYVzXtYLQ514Lqrp8+uYo9AujQP/c6ysyBt0Niva?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4f4210-9d81-4f98-2425-08dab672376f
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 10:18:10.0622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEkk48Y+XOGgAkKNz7dlE2Yic9z6eVojvsfNF9cid9cox9hlEGAVSx3QjtprMyFP+uELIKSZdvoZEMVMe6aXGlKhyr9auBg/Uo8Jkx0KhIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell NAND controller has now YAML to validate it's DT bindings, so
change the node name of cp11x DTSI as it is required by nand-controller.yaml

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 7d0043824f2a..982b180b33e6 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -468,7 +468,7 @@
 			status = "disabled";
 		};
 
-		CP11X_LABEL(nand_controller): nand@720000 {
+		CP11X_LABEL(nand_controller): nand-controller@720000 {
 			/*
 			 * Due to the limitation of the pins available
 			 * this controller is only usable on the CPM
-- 
2.17.1

