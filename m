Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F1D644ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiLFWyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLFWyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:54:36 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF784A06B;
        Tue,  6 Dec 2022 14:54:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsNJ2SwBYRHJ2TJgepKS1QbkiZSUNl8KF5uHg7DFARcKAtHlL8kyopuz+0UFR9PpRqtXrmeiPTdAkkPhNnYVeSX59Z6ErJFvD9u+cgBGnCYs7VmttGYar+OEquY4fVTpgJpmVcTEAYx+9DDBTStpjl+BuraubrKOfwVPw/47IbtujQqCBoLlOl7C6LfHVnIPj2M65k9uyr7O5fLSw5LJYUC9s9AicfeBM6lN//BP/C8L8ZRgHmgWLjlJTezZIMXVZu7UoZLUPb3JypXdO1x1iqf5QXdZS2J0vYdarjck9ex1bsXDsCtYOGFMSZtxNlE8jjZ6Ul7W6nsPbi24yGAG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUiagk4KV0+An7OkO3ak17Ov48u1WNwtjbdTnhxl0OA=;
 b=UvJjiafOk8C5CEC7YrfyQiep/DD3QaM9OoxOfGW08Wz2UvS0rziGIKFcp/0EtaEPHf5wxzVhxkXzSqZxDm7nTAmBsAsXryul8ZIs93xsV0GhLvNDItkyjY3FMw5saekFwKu292C/uE3so3KsGdOQE+8scHEBOxGV9kVZ2kx7V6st6487N2BvnjSp6XmesHwN0OBZiOSkSHqBG+ri8Moid5Qu/DNoh3EOw3ToseG/aKXaVecfSw8i1+fkqpeW8OIFW4Ct8BchfP80y7p/OONIShCUIi9eNVKJFmq2S+QX8PPqgdgVFLJg3yN05bNZ+OD2vWcXFrMVbmH9XC0YM+1b9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUiagk4KV0+An7OkO3ak17Ov48u1WNwtjbdTnhxl0OA=;
 b=qy81XSWWGk7s649YSFUCr7oNy0VmbTowdVWU4eTAZi4VMik8bbqP6BV9/pmw6VhtXQIgvwPbDg1c/PRAavE5y/wSqji45HonXLEOVcDoT4yeM/u6UtnoGBxpTbcQg9bhE6+jNU3KkoxRChJikHLQa0DNyrBm9r+zWoZEwyVz0iY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by PA4PR04MB9318.eurprd04.prod.outlook.com (2603:10a6:102:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 22:54:33 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%6]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 22:54:33 +0000
From:   Han Xu <han.xu@nxp.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     han.xu@nxp.com
Subject: [PATCH 2/2] dt-bindings: spi: spi-fsl-lpspi: add num-cs for lpspi
Date:   Tue,  6 Dec 2022 16:54:10 -0600
Message-Id: <20221206225410.604482-2-han.xu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221206225410.604482-1-han.xu@nxp.com>
References: <20221206225410.604482-1-han.xu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|PA4PR04MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eed93a3-a964-494f-8ac3-08dad7dcd74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orw352FdmjAAwZ7sWAQFwHhFZrTyF2pUpir92FPpPI/9PoPl0Y50G253OdD34DxlpD5A/7cDj07suw03Y9Q+Vz3+L8Her7YMwiozlhdXPLZPSMlucUiYdWHatcngAXIu29RwjsWRs8YVr2FBgaej4OU+vOLZPJiRo9tWYfL/kE8wBYNIek0CB9WMbLLkeD9acfVyxgtsk26ObWeOaYOYInmJkr4Dw9uRQ7eS5a5bOvhUECFkiPDu1sNWXD873C3QP3HFALnpzDtm1iufuuOIrkKHvwNyKL+At4hOfVZ4ljqg+ZDwCpTlIFd9GD0/i4i9oYB4JHE8gbA9YsH9kRRCMptXTyIW40hXj9UmO1gB21IJ8uv0c+ux/yxXGuy0uCSikcSQEtfbU78Cpj4ye9FCScNWn36yJq2/A6SAVYcrAq6N4TXBIAGO0BAXLsJWkO9B0jOzJ9q/fo5W6trJykwp0x2g9bO4xYUbfeSsGe3mmnrfFHGH66A1p94RAz/ft5gl4Hpl2jLLyIErfwETvKOu9cU0X3wDh06f0bZ4pJSlgoRX7ioa9hXGM4nEtMeOaaOax43X8BesHJhsELNVZ0XnrNqSIVTp51ks3Xw2bN21RAq9Ib6yFl3MtNE50Ciuqy/DZwHPhAnsqDDmBYvO4or4gPXsLlF7HTA1gAc4ZeTWc2GupAsdRrPVwnHxxcW1xRsY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(83380400001)(38100700002)(38350700002)(86362001)(8936002)(44832011)(5660300002)(4744005)(4326008)(2906002)(41300700001)(478600001)(8676002)(26005)(6506007)(52116002)(1076003)(186003)(6512007)(6666004)(316002)(2616005)(66556008)(66476007)(6486002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WuRwE1NH9yOaEvoxjtooH+EuASFYArVuaTjMvlE0XkvLF87iEvVEJpyfuU/F?=
 =?us-ascii?Q?7cah0PXFmkedCb6d3t0hWLh+c4Yr3poQ6UXJuCXklS4f9bMAvsEYkc7jDATV?=
 =?us-ascii?Q?+/145L34NuzggG4Ihsj4fKk656FwbnveM3Sxu3XMHPuljT6Kk+CRymY5mvZl?=
 =?us-ascii?Q?n9G6CUTpaZwBGdyzTpppfNOL1JeJXSg8S3cVa58FenEdwMeHq1B6pfvSqcDZ?=
 =?us-ascii?Q?8aG2FBw9OCVuUtmebPNRtokcs2dhQvFFNglwk1lvsnCBTsGm1gt46iHgvN2z?=
 =?us-ascii?Q?TjN12RbqvfsryN025ECwyLV7gUNKUt4x4lIpa5Tp9ainxglbJELZgOsM/1XP?=
 =?us-ascii?Q?xnqOHqLgprWhQwEyoqWpPQM+Tsg/hgd+2PuQQCnA2j7jpqZNcEJSlzzljudb?=
 =?us-ascii?Q?BYfXSJaZXeO2ValLc4AYOd9t6i/aq8KYHnskl7rBPUZHko51JmKX1+pHexhf?=
 =?us-ascii?Q?1nqKCzUkZWAl0xrYPmDFJpWkGr8B4wHCZFR5XjLJ1IQHO/bs7WQnbQKIPmCN?=
 =?us-ascii?Q?HXgV1iTrwKFK5jv37j/Fzx/UozF8q6s4AHh8CgFGKE0GI4+lSS91qnCCSG8O?=
 =?us-ascii?Q?YcXzl7uvVKFN9zZEGYNO2pBi9EenT82WifIC4z6EKCgcFs431VTSIyy8QnU4?=
 =?us-ascii?Q?pInPwqolqENsoOALwPVWE17gOetia+K/8x7PbSi96sbJR5Alj4dzMiONaWNL?=
 =?us-ascii?Q?D2KAw4Pnoo/ujdOQkE+5y6EZ9QYuzJ2/SBr50p1S88Sr7X7p17zmhHASx9ZF?=
 =?us-ascii?Q?iUKS35PgR7UJnvi37j1IVuLh5UaS9lQnwUD0gSbFvYTd+xYp2Ox3KDqzIx3h?=
 =?us-ascii?Q?vwGNawbV3YNFqW8Xd0kqeeDnRbj0CxDLFxThvucDImwPMZfz4m6Hq5MMYihH?=
 =?us-ascii?Q?lcUHZnVZhfE/9+ylq1YlHSXHNfoWNfjnPMX4leVmBuQdUJ36nn7H0Kuytzc+?=
 =?us-ascii?Q?YeqB90w4topTICNs1j25RDrpAV1SZh9LgPsDMt7zLVYbu/8ABxsmWK4X1frr?=
 =?us-ascii?Q?uWgEO67EgQ5Zv/GoN+AcpHtR2eUGR2DPBfuSPLEcXZYjSO55Zq0VKGxH62Io?=
 =?us-ascii?Q?SOqivuXmf5X8fj5grnxBiNO4i2OVpdWbPEpijX+Xksq+c/8Zo7vYm6RkywzR?=
 =?us-ascii?Q?c7KmG6jkWTUjtOi61FGgnYP1TdOk2r6BGpOBvtXCl1YYc9KBcj+mUXjKoYey?=
 =?us-ascii?Q?Zhq6tkYSdY1CuRKCqR2xsdC7HDKV47T4Fu9i+1q3gKvbCTHiUtFEQ1xtYpKc?=
 =?us-ascii?Q?srq27La+Aox7DWIHuV1jt7ya2f2eG/HMnl3wKTtA5oGMixcZGU9ZB2HbFqGa?=
 =?us-ascii?Q?dwqNJOedaiElj0EYznxESgKzu+jwpqcscGoN/hslTi0PcegITu0Mbg/EprlS?=
 =?us-ascii?Q?GtxrJJeggP30PLMk9+Ap1LWecUlQfqKS38u0nRABgwwSKvneEP/degwU6dRC?=
 =?us-ascii?Q?x11IU2uC+fDOAuZqHFhB9o4QHyOJPQjgRtma0Kw2HfsDfu10Z4gHcjkBaF3N?=
 =?us-ascii?Q?B5yj103H24JPH3WKEq/vTJVXs+Rr0VF+gCm2Azgd98bvGOC2wpr8tjOBS0ne?=
 =?us-ascii?Q?h+oBmGe7y1o6ZzKGjh4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eed93a3-a964-494f-8ac3-08dad7dcd74a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 22:54:33.6265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUejZxw1asc6mw7gLiZEhRhZz7jkX01NI/Eo5qCyzw6YK99LumZIklG0W8pwEEFa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add num-cs property to support multiple cs for lpspi. This property is
optional.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index 8b44284d30c6..94caa2b7e241 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -56,6 +56,13 @@ properties:
       this property to re-config the chipselect value in the LPSPI driver.
     type: boolean
 
+  num-cs:
+    description:
+      number of chip selects.
+    minimum: 1
+    maximum: 2
+    default: 1
+
 required:
   - compatible
   - reg
@@ -80,4 +87,5 @@ examples:
         clock-names = "per", "ipg";
         spi-slave;
         fsl,spi-only-use-cs1-sel;
+        num-cs = <2>;
     };
-- 
2.25.1

