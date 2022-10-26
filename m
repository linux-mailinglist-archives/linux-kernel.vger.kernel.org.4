Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7269960E273
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiJZNrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiJZNq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:46:29 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2118.outbound.protection.outlook.com [40.107.22.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5727EFFF;
        Wed, 26 Oct 2022 06:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGoNJF/wcacCgOZ4t1XWftZt7bhZQ4HUTJ3I9mQ94j+jqDWL0rg9dwRZuADCsTz3dlvSBYlfTgq+OklMpFq/bwNxh7X8PS/fpP4abWdgQDFQETe8i6jIbFv6qYC7z3E2ZbxWnLtxuZVamLmT4BrL4uJnI6QIlvOYIE9ZZEUZMLbSOzYUpIGk9gBOIbRV9gEkumxn3XIN1GIE+pm4hjyua50BPSM2fcFZeLyQYCFn7f/V1Qc6BrVJqbtgHqaXli8bHRc2Bi/2WVa2PFAAmg1vpy0aWmMKVk3LUJTFRwp9w8BVPGwbvvKA6fS69Y66SoZxkx6wM+pVRw5ircdMtRJWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT3zKk5OE9MeHqRlwAWA3oRF6Rlnl/yzQNBN+2ksvzo=;
 b=kkyHwoLK8KIt8XBdLMh/RjWF26+2B0w4wiKcDTS3lgogSh+yCvGwDeO7IEIO+Mg0XN2l9OgWQa+ocTjDuz4jeWOJBShjhsPvy+LqYAXqe7lSwrZMBvFGen4p6lBRqEEQDnk2kUS7eJnJJLmFSNykdvsMK+YxOkPzNBAMQEswqB7lVdO2fUj1ujZvsXbqYsTqe7ugmlI7/EyMkKSmCoVZVG/uaYvBVIVYWGBG+HYI5Rv7udzi5smdjTIoZ0dMXqYVT+1VNcXDsJF4Ko6QN9E3gLRmxh2T1GS6u2gdw9mnVaQQe3CzFmiQFmHX3IPJBI+ixOtcF1WWdK96OPkjgHoRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT3zKk5OE9MeHqRlwAWA3oRF6Rlnl/yzQNBN+2ksvzo=;
 b=h9NyFriJdNGfGyig7htIDq3YkIsytLq4rwQtF1fzwExQTK0QpxKbaNypHRqsqclL9sRi+hoGU3laHxgTdLN/AjWe8eQ9hzLwUWdhSnWwF7Jmu56CYfn46inUa0I5MHUCNUgHhY0/PuGnHK2uzwF83hgjOGbK1nigvVRo/eIopPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by VE1P190MB0941.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 13:46:07 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 13:46:07 +0000
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
Subject: [PATCH v5 2/2] arm64: dts: marvell: cp11x: Fix nand_controller node name according to YAML
Date:   Wed, 26 Oct 2022 16:45:43 +0300
Message-Id: <20221026134545.7146-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221026134545.7146-1-vadym.kochan@plvision.eu>
References: <20221026134545.7146-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|VE1P190MB0941:EE_
X-MS-Office365-Filtering-Correlation-Id: b50f3ce8-3b30-432e-a531-08dab7586eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCSdsN/6b2Ha78Jw69y/EazDlKWUBd0Liw2S7gUu1EHrsYUnzJXB1wLuFHehogEKAZ8/7s7lAvUVpCIJWV9eAR6NYB8WMUDGnICN/pelI7f/iQKoDBBMR1xzZp3rTRWPggHNShtOE5cejOBToQ5Z2wHPRaRIwE2jMYs4qDGH9rRGk3QZFpdy6rA1tCFaFxs+Tr4myYY44hcdqbN12rYYmebKSbyq0BbJNas0YmYmJotp4vUhyJNGno9b6SK8MnttrWcdVexjgXJMWL0qxu7AmRbk8yBJ2E1b6vqOGVOl/ABTVjsrbw2tWjhrGW72diVfdigcINe43/gxtP+8htM5wamxF9tk3qAiwmDodsobKg39AdH7E3n2vKTpn8XZ1/0PC3Gn/MEldbS913OGeHF234TGTWj2RM6/sEMkfrDZVBw/8T/rDnSeCttBN25SW/qaBkLVJ1khe8TEr3a8qK789CU0v3EEfhJeV6YcAR332bopf41+hMOttjs3tAwENNwJ5x0eNF2u+0A8mZ7rE+K2/znZVs0vzPB9mnex7UIRpUHjNGHYm5iMqANv8LSaVbKNrC1bIPnsBaXM1gjwawrumrldPiXnsKi2H2Q0W4yBgDfyHmsh67CoKumCSjEFMZIrF67UilFpt4e5TKjiNke98MYjYAVMJhufXzYMCbqXq1tpEIPtQSX2MRZY11Sk88Z8qj6M8PY0hG0Akr3g3DKSnchOxXO9S5BcPMLYzJ/jApi4eyTPrOeFq3VA5ZQmDSp1PD0Vyho1z6BsDHL7Jredqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39830400003)(346002)(376002)(34036004)(396003)(366004)(451199015)(8936002)(66946007)(4326008)(66556008)(8676002)(1076003)(41320700001)(66476007)(921005)(6666004)(38350700002)(110136005)(44832011)(508600001)(4744005)(86362001)(38100700002)(6486002)(36756003)(41300700001)(52116002)(2616005)(5660300002)(7416002)(26005)(2906002)(6506007)(186003)(6512007)(316002)(54906003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gtO1ETzXcHhcxqzzlNP31pjJ6RMOsMEeFYRMWUWPxqXa1S6AvkowvMzGv+JQ?=
 =?us-ascii?Q?2eFL36qBrmzs9V5hpG5rAliK/Olkl5nvGTNLK8QGA5Dr5vtHof16fpGkWtW2?=
 =?us-ascii?Q?QMbYJRT2kAs/X262EMFbqC1s2CDVQBepdh9oCdniWZe6SY1SLcXJm+WU4RH/?=
 =?us-ascii?Q?3egtmmYJy8JzGSXGWGTmfce4F+29i9jwBs67GLdvtsu/MBabCA8vGx3LL+gQ?=
 =?us-ascii?Q?TCYPk5agVpu2b3QtUdp4iHlEjK5NMk5z8Gysr135EPOzpV5eFiy1n0avlJc/?=
 =?us-ascii?Q?QuJp6SuNf8CXlL0ETXT2aBAAK9W7VfbA3sLOU6k6V2E3Hkg0u9D4QJu4P1oe?=
 =?us-ascii?Q?5dlKi7UPyXU+3sddW9tex01vbGSjFITesvkHzFbCRFpKE86XmX+xhqrUsWkm?=
 =?us-ascii?Q?je/dmBStV9SozhyrYihGlYSa2IJPD+AqkIv7xq8USVTnWJggo+z14UhzmaB+?=
 =?us-ascii?Q?Z7T3xlb1Ik+Uy/Brr8DJ1RMyS76u4vo5Dz5K/ai+hl0gBpzqDQIMZ/snAFCS?=
 =?us-ascii?Q?CKXCnzVOGEUvgoI/BfHmvusH4YZJZyRcLxEZRUo/fbFZP/nLPa+mIGkb3wVL?=
 =?us-ascii?Q?6i07lBIXd+W5aQYbo6fO12kg9gXgTZrfKep+Ag3AVXi8DN5WFJpAPiqBdxd6?=
 =?us-ascii?Q?PP2+zRmlxwXOyqX8h6dOSEaC4uHKRRmuYzn+5SNvYYGWj3s+uMFitL39yVq3?=
 =?us-ascii?Q?uVAkv5qPvOdQrcbwdY/zNX2nHMuyOE1/sU//KRjWNfvOahopOqPyCi4Y0lyY?=
 =?us-ascii?Q?Y6FFXb0h7oraWOXJQP1Sm/rk+z0zWxzsInHrhBwUgg9rBPrMF2hSnuwhWm1k?=
 =?us-ascii?Q?9VxynXJbLc0o2WxB44it1GeBvSKnTO+dGrL5AYCKYjOrXRUG7vody4vCX3pk?=
 =?us-ascii?Q?hRgn3A5ZQWllaJo0Ur+sLwVkJL14dre58ZxTTbfSDASkFKJkLm1aGrPsUdO4?=
 =?us-ascii?Q?VLoRo7xIhu/qW8Y702Ah34BAFoaloadG0W4odgyZHFe9p6OAUpG0f671vEnQ?=
 =?us-ascii?Q?smWLyZpvGgBpDSeLHPt+6+GtlodkqxKDm9N4rfAWXAATAr24T31HAcX4HFIG?=
 =?us-ascii?Q?O/i7yMFyQc33WDFu85QVuNp2cAN/XolIV47PziQUmmLXeHKlFoCKW+47hQlm?=
 =?us-ascii?Q?M9sq2ZT34gR787iAo99pbekdR4QcCO1aGAo14T2ooGzk91DDb0kruy7XXzxC?=
 =?us-ascii?Q?TgIjv1JGnlPDql/BvGB8G8Y66sRWcfMWmT9Q+OgR7T1nwzXF2AUbewOGSQ2b?=
 =?us-ascii?Q?Gg46G8n2XJw3FIpRPVawMzcBQdeVm3EgsawGWgOTCHBeOqLHKotRF/czgVT4?=
 =?us-ascii?Q?VHdq0JjK5gnCW9XDpkcidDlC9McMcuLZCkJfP6oP6L7k+EfBpSKCQkA7sbwW?=
 =?us-ascii?Q?zSJNrb+jKHV9GWreEyd72L4PyqGoW81L6DbS/zM9htzW+YPG+zWGEfpRdD0k?=
 =?us-ascii?Q?1I6o+0El6mCrjj2BKgn8uaWe+PGFz8H7V188jDGJ+qW+pxxZresfmltKwT/G?=
 =?us-ascii?Q?Bq1nuRYnt5IqFN4xuxHysgnZeM4e9afLkbPheJMtvB2etccRs9IH74PA1+0M?=
 =?us-ascii?Q?NREkDB1immA0iuIybsFqcUIRb7S7V5aVh54lnOvsjYwhVbGJGGnT5dfeHZ+B?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b50f3ce8-3b30-432e-a531-08dab7586eb9
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 13:46:07.0578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H936NggjYPpqVs4DffXRlS+AxfOIab2cF/hiHnZEX9IkJvpLbnls7tK5k0WOo4UcMYwhFAQaEHkjOKwn3yRksW9tTMkkzLUgNwb6tAQYarQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0941
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

