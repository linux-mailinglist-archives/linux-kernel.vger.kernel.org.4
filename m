Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943BA64DC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLON5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLON4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:56:53 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2043.outbound.protection.outlook.com [40.107.241.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6B82B19D;
        Thu, 15 Dec 2022 05:56:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwURfv67zkfGdiWL0LRYY2XkUp54WUis/vLDc2YsZ+BVjMMCbHxhPjv7tTbX2EO+2AMagwFebzfLB2NRg2gaags05t9z3Uf1Fwz4efcKs4fum7XKhjjzcfrXHyR0aFqZeANGmboKAfr6cTLyfXXkaHzfRmAVhJ93q0sZ/yeOY6X/sLtYXdZz0GstSel9SNHfiI4xpQXJT2njEhGYEC/fnGPVO2a0BwDwuA8FCHVQ1XOutW7X6Sd7kfR7+pEAFjHfB5K0hVhW6T9DOPP6hv4YMj3je2QwRVG0ot6xD/kFqTORwugVg6gelGS7D7ba5sLV7toDiaq5C6GqwNxhnz1jrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Sufl1N/NV4aZxZLmap8uCpfgdB7R6PT/QIEepv2BWA=;
 b=JUSuQ6w/GU0s7+xjQ/ocf7dARZp9OlYDj/np/wYm0C1huyQPhkoHAA0xcH29IVSzH4RrQgvKsQkfAfwG2X5OduRvec0rYwPmG/1vXVNUy3NY7kpJ213lmlr1FHmgUqpMm/WU9321A0o89XTB6j3Ctzqfh2E6MU5rXq6VtZjiGypt/D6JWgfEF0zWhvTehdxWgEsTyjAXR/d4vIv0n5dxnCZVgMRxYi5wRSs5Hoz11J9hz7kXrZV6tqPNR5aplJUJaD8m+dkLFJROki/J3Vr1D0z0U6XemD/hBNeNIOLPXGHgEHxshXCk+DZwKY7jxNjp0gRjxX44Vr1LoQRFU7TPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Sufl1N/NV4aZxZLmap8uCpfgdB7R6PT/QIEepv2BWA=;
 b=hcfjEc6NH6X4/fil77Dooar17Kc4+aiBTl0qQ6sKMFi4nHY5QGti8Ik/q/wBV5UaYGZlJTcTMrzcQumccSc9ZxYZ0A3ldye5uLRQwMdY40kGh/eoQ67eebCTslIsLiUoMr7IBIU5FjVdJouv6myJhuuEhnkbGCSKwx+VaxODemI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by DB9PR04MB8463.eurprd04.prod.outlook.com (2603:10a6:10:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Thu, 15 Dec
 2022 13:56:50 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::2101:60dc:1fd1:425c]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::2101:60dc:1fd1:425c%7]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 13:56:50 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, iommu@lists.linux.dev
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/2] arm64: dts: ls1028a: declare cache-coherent page table walk feature for IOMMU
Date:   Thu, 15 Dec 2022 15:56:35 +0200
Message-Id: <20221215135636.3684026-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0047.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::27) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|DB9PR04MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d48064-a557-4402-25fc-08dadea436b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myAVpQBMIh2lbQ1iJxVuGGEstXSk0PVvTaUSB7Mt/JB9y+D1lsXr4X4Ez4ad/MqKtCcZRfszfinS5Xguf8XDYmMGzrUuxJUTjBmiYSvPL//5AhW19SVTidI8dQkOqcoRTAtBM5GNp6BExF3SP+ESpFv6LYuZthfxomN2c+33cDk9HfFFREsZKy6IqF2lhuBLEmVNxefS7V7Vnur1bgaS5gxmcjvYlCjETGKAtCRqbsNqiF4xv9XVqgbY4TS3XELeoz0TaXTtlITLf537f9TP0AKA7TF0o+KfdL2gIZizAaQIlkcZa4yoKeH33qiePW6CU5YD8BOKblxlG1GgVKWoB5N31hGdYG8J7Rp4EH4bxFun4h08123tPHBBb06Xcq+McYtqkovZgP2uwhxBpjyFRgDzde7qqjcAhy/RaxV+JUQ2Z7uKNBkJShl0Snbz8CvxIOmjV7iNE7O0iCGPYh8ZFSl+cLauI6uDDtTCqB0eLiuekj45glY+i95IVFe3/9MRRZwPVjvnTn+Yj1Dc7kHKL7uqVvWDA7dPczuf725Uih+iEAszAdltM6dKMPtNHGQEYpbsVcH7I6TgEW5BP191kzaY3mCRZlevTOEBSK6ysl4Nlf5KX4TcSN7IsfVHRtRMohcE4dMjzhkPdY5pbXnjZWEkd2hVQm6xeTGFUt5otX6XnkPoQxnNvd4HhRmxMDeo29Y6lLpUdm5iMTDFlUeD+SbDTYkgkBNqMhwjGbOza3EYigUMD7hO4JnSudWNpP7I6RvKFSzJSYw+NbP1rkGurg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5121.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199015)(38100700002)(38350700002)(83380400001)(86362001)(54906003)(8676002)(66476007)(66556008)(41300700001)(4326008)(316002)(66946007)(2906002)(5660300002)(7416002)(6486002)(2616005)(6512007)(52116002)(186003)(966005)(478600001)(26005)(1076003)(6506007)(6666004)(8936002)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UGbmEbLumin1XylB3PYDLjgAeFXfNihStQL9Y4V2KNXwKNosd8dRXXqyCcgu?=
 =?us-ascii?Q?A0NimvfVZHNUKM4S9vX5Y4v1JbYr8X0conYaOJ8HWaA2LH3OjHS3JeDo/CY8?=
 =?us-ascii?Q?XTzv7YOZnRvMayccvihJmo00LCbzp53a7fRAn3ufmM2tMP0hm6fxF0Z2R+8B?=
 =?us-ascii?Q?o7N1lvDGE7LxnX1tLKl+ZJm4/gYQb4FvHVdykmWplFTzg3FylkZP5uqpdwZt?=
 =?us-ascii?Q?T52XS2Q3+MyHXbR7GyZ3LlGzCGbhwNqbDqGSTsXMl0sh82GwI014ZXlwsViB?=
 =?us-ascii?Q?0jDEmpO2bGDh6aFLP3bPF2e+AHw3ZBoOXeJWoz8beX1+WWBJYc16WbCb5PRs?=
 =?us-ascii?Q?h96fhcKVCa9nnKT7CMvDt8xtlqAJUYBQwB95rflCZUHu2E2KfXMNThgt1o2q?=
 =?us-ascii?Q?kuWhBYmWaL46bWWNHGSwDJdl9DYmkpHqbL3I44LAaB/cm9tWK3MejnLX5puR?=
 =?us-ascii?Q?UuIeka3G6/yXjWSAXPXUvaxQfrXtUWR8ciZD+aqBxX4Q31nAAr+f3JabDZuM?=
 =?us-ascii?Q?vlwCSa03mN1JczzwHg/cj09xbmYEN93DTQDIGuuqx1LqVbQnkPmtr4nh1SVX?=
 =?us-ascii?Q?iwDDKqA5YR8Mo+SrN6pL6tP6cdfNwhronWjP9ri02gO35OKBhCaKOjo0swC8?=
 =?us-ascii?Q?jgl8vQ/nvyvkccWukhDOZJ/ltOKjQHHlHSjRA6U1Rm0jFWs0VThdHTKrc7tc?=
 =?us-ascii?Q?nCV8PntSNfnDNoTRMxXV3jAgXKSjfflXVJ1z2/8Gnrblt4kdY1qOX4b5ngAA?=
 =?us-ascii?Q?fSLCpjAaN9p6Pw46rzNhfTNgxuWm10AOIJQEFnSMK/j9JerqMA/+ZESYROay?=
 =?us-ascii?Q?9WXbl2FyebBdbeGBRA1zcWYGVwLIgEBvDunUWdh3P8D40sk1iN61uKZXHtIM?=
 =?us-ascii?Q?snmNCZO9QFhlEVU3kN6/OChdp2fNs3t5Nw1yRq/m9yKQhcoVhZHgQikEkrry?=
 =?us-ascii?Q?5hBY64Wg8OkAautxebh9Cds06+R0fdoS9rZo8YgqHPytdq+Jz1MRkyUhUpKq?=
 =?us-ascii?Q?4qS4rYBX3VM6RBbqLpRpl3bt7eerOyWPumBwcKV2jZKSbI5gER+Lu98uxGVU?=
 =?us-ascii?Q?JZ2WTHfr3SdvxxvQ+JK9xvEcfRS95pz7RLqSolJbhslUGhjsywWD/6R6jOpr?=
 =?us-ascii?Q?3aY6D8cOjuDmldFULL9AqY2iXqApKqeyCYznT9TUafRNJi3V2VMwkcDZbVtS?=
 =?us-ascii?Q?OGPo7S8SPZP7Sakpcs9gXsfldGgWrFRst0gHOActMriu3avnztSGUUJZ1h53?=
 =?us-ascii?Q?sCdB9Kihrxj8zc0VNvtKzKzk1fezFbyEC1JJ4L6rcy4M7CBiKmkLU4X2jcwn?=
 =?us-ascii?Q?hCqwOIGEhqeVt4yUMFmJr1qb4/k2XimOw9UiwbdpR3nCOnzEI97nEhMOqy7x?=
 =?us-ascii?Q?K8j8Hj+moTh4i5YxFo7uAFEEpCkDYoIdM01VaCHkZaqbVH/JHMLg9BnD9cTh?=
 =?us-ascii?Q?1eIBwXuu4OJuVpuoO3kDraM4bS/3bNPdU0RjDPAF0NQPFFh/vpemHnjZMpX8?=
 =?us-ascii?Q?HiTm5vu354SvZKbPKsSmIuUrvPe0zGX4aKYfXI7pDSBSXccxiQde8xlkLfrT?=
 =?us-ascii?Q?yt42CPWun2AypxtSJEHYSUx4zYDYpS1iiJ7OMBxDnNTmSBtE3k4g5SSAQ6k+?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d48064-a557-4402-25fc-08dadea436b9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 13:56:50.2952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8aKaJc0dY1m03MG1Ir+AJtZQ2C094KQaDe0IOH70boCNNm/GoGi9/+Um8Vy7HuzafWXOx7+mGPGmbgtwGtgpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8463
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMMUv2 driver for MMU-500 reads the ARM_SMMU_GR0_ID0 register at
probe time and tries to determine based on the CTTW (Coherent
Translation Table Walk) bit whether this feature is supported.

Unfortunately, it looks like the SMMU integration in the NXP LS1028A has
wrongly tied the cfg_cttw signal to 0, even though the SoC documentation
specifies that "The SMMU supports cache coherency for page table walks
and DVM transactions for page table cache maintenance operations."

Device tree provides the option of overriding the ID register via the
dma-coherent property since commit bae2c2d421cd ("iommu/arm-smmu: Sort
out coherency"), and that's what we do here.

Telling struct io_pgtable_cfg that the SMMU page table walks are
coherent with the CPU caches brings performance benefits, because it
avoids certain operations such as __arm_lpae_sync_pte() for PTE updates.

Link: https://lore.kernel.org/linux-iommu/3f3112e4-65ff-105d-8cd7-60495ec9054a@arm.com/
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: reword commit message, drop Fixes: tag

vfio's problem with arm_smmu_capable(IOMMU_CAP_CACHE_COHERENCY) should
be resolved independently, I'm not claiming that this is the only fix
for that.

v1 at:
https://lore.kernel.org/linux-iommu/20221208151514.3840720-1-vladimir.oltean@nxp.com/

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index ac1c3a7e5f7a..9be0b4b7babf 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -712,6 +712,7 @@ smmu: iommu@5000000 {
 			reg = <0 0x5000000 0 0x800000>;
 			#global-interrupts = <8>;
 			#iommu-cells = <1>;
+			dma-coherent;
 			stream-match-mask = <0x7c00>;
 			/* global secure fault */
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1

