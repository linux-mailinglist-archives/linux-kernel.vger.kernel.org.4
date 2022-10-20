Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924F7605C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJTKag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJTKad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:30:33 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3498F07DE;
        Thu, 20 Oct 2022 03:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mimjcDCSvMPUdplPGlBg/iO7x38j/Dkyn92iOIDmNECO/qWtqQOpSSJ8Ezo9QvB/dNDTrVLKhCUG6ps0lls1BsKcNEJAu/dYUXZbw6x/hI71yha9pwKUkzgNWrtYNeNaB6Bpr4Ka25eIhEh4gCEa60GjL76ahUj1/OGdHAczZ08yREkrO8VdVZXkuqjZtr3vH1mAqcpwxO65tEkj2bBjbHylyYyYjgQxtd5AsWEwaWAuqxNp0f1cy0DLdKUn8sSZVKq6E2wj0B4L5Twn0qU6rdfnYaYpJnJNXviejDjR7S94o/DXd2aNEnfzGDLBI0+t2Ug6mjuj7A9Hua0Y+HpHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZPhSsTQBNhSwyJbVrrm7W7NkxdNKYxT9+wjNV77YfY=;
 b=hIX+HCqfKhruLiijJfn4AkFJBeiNjOT58hRRpeaVJIq1TCRBUPWD/n3HttGkIXL9SdSIbRuS75M0JqP7mADHQi2wZvQ6TA5xMCozDi8gb35EHToSpjbYdGn2nrafrw8QN71qLRiGx9BWxKW17D/Vhv9THm58QluqfarPOTk0PUZwcDH6QpUK/u13ySbqHQQ9O9Wy41s2j/vs2SjijtiSZd7H3f3gLDLyL4++DBahnZQoT/Tep66b2oLc8pLYGVh2+AOxR67I/g8Eo23wUBn70BuEQRI6pxRM2RwlFNWVYgiW5vJc5PRPSdtr2LtqyZ1DVe3Ys/kPsQUM7DkxK7NhOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZPhSsTQBNhSwyJbVrrm7W7NkxdNKYxT9+wjNV77YfY=;
 b=Cg+62CTY025HdVOzhZ0g7nCnaAj+TwnvVOlDS6mTrH2wiS4heRYiFQb9OO2RvJjeH7nFgu1sQHOq5oQZJutLXL7G5hFezqnZ3iKy8vCHSBGX6wQBY/pBDpsPK/imox1O1u4TebVG2nBosyUlUSP/SGsq0KQThOoIVysxs5UxjrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8060.eurprd04.prod.outlook.com (2603:10a6:10:1e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 10:30:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 10:30:28 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] imx8mp: spi: update binding and compatible
Date:   Thu, 20 Oct 2022 18:31:56 +0800
Message-Id: <20221020103158.2273874-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: a6457510-eb9d-4ad8-a924-08dab2861b12
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s03TIJQH92SaXfEL6BTR6azXC/+tWKARFFUyLIWh0GhGzp/nnt1kpaxVQ4XDdD/u91UBxXP2s1ukMptI7IJJYvb5qXLQCRg3OKZEPhiVvEfzQH5uZq2nh783O2W8Mww/LQYePx75ndUCf33dR34aZmjxtWd6xRWaFxQsZW/ZwSKypDQtCZHkYoP+EtcPqvYRA+dMfg2dzGcv8Xg8h9HrHLPHrniMBi1IACDeBR2wUP7edpZRVQ4vTsHbj/7K1SIJmp5/Yj0+sFC3gEWqighWZVVzRn90EIKkQdrb6uny4ddNvW375viMpAGygFXBJpWW/wTbAWccOu3tAOYsqdS/uPyrOpuj9xAyG4dxB0U86TrJ8tJfJID8D71gohMixq4dvp92pFvD/LkXLafjaS+8lCx6fhrLTJw7K2LrevGxl1B7VC5pYn2CyPBtF1e9DH5FxVYH6haxPmqWf9kC1s0sivm0U69LI2sXMZK3eAze+Cla6ABsagJd9QM8oRpZ+cGmSEDls1E/l4EQzpW7/ryp9ZFtZbCw5ZMFH/PIPXY0KNaNAjBqhPIl1//C4WUCA10WlOjbgOFcR8BjJJDBPrYn8tKPUzP3GQFHbeGO/8rQqcFl6VCPqHVoanDZ/9aTMBfyfkXfGOexhIGCFg3MtjD97GkvsivDR7Gs3t6DkDAU2mzrV7rdC5UicjiH3zRmHyLeJ3CM4hB44frUa0kLc82SKTcNVd69Sd4oX/6TsGlq2l8diS2XrTE8mKbuMwxk3jeU1c/kOX5piKNrFjHPtu5bQiSEEw2br53JstlvWN3fUlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199015)(4744005)(4326008)(66946007)(66556008)(8676002)(86362001)(66476007)(52116002)(6512007)(41300700001)(83380400001)(26005)(6506007)(5660300002)(7416002)(316002)(8936002)(6666004)(2616005)(38100700002)(6486002)(2906002)(38350700002)(186003)(1076003)(478600001)(15650500001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z2rhBW6RWxkbLNZ3gWQajQsvzEjCR4RxlOPT6zL+RXDSbIbB1GavwFQnios1?=
 =?us-ascii?Q?qqbymBTGkLdyAcYTpvuwMoWYoSfPuZN1idvHkOLxkwRq2tMef7LYiMb6k/73?=
 =?us-ascii?Q?uGPBie7ikNVQuYxf5Nyl26RVG+aLLUqKVC9z9FZr5+XBKX/rlQIAOg5K2dfe?=
 =?us-ascii?Q?qT3Co6YNBYO3PSx4oM6RemtS9b3L+cU4rI6W0QZI2VoRR/89g1ZFrxjbN3y6?=
 =?us-ascii?Q?Y/VAR2Q8cSage8syxPAHo5+cNPsFUxHjPESj6aU0SoM9SlDMvmFzrp0vA6J/?=
 =?us-ascii?Q?OsIirmQvxGcuzkmyY4AzWKfIs+Vx2lnfLCK8Ay9Tk3j48gEYd5FO3OwxW4kl?=
 =?us-ascii?Q?qnbycg6TnT6q0oMU3YgJ1Rz38agPPLMDJP6V2qspEqPSWFWA4GRU6gko2oSG?=
 =?us-ascii?Q?kIt1RU4OQROIWfPzn5JWgmnWajldk6Yifi4V5DkTvQZT1lxbOSx7UDHouPdu?=
 =?us-ascii?Q?o8/BDRgQ41B48uCe6Ez3DXiWN7EOiGO3pTj2Gpfvru3H61meXLWncr0Cjh8g?=
 =?us-ascii?Q?mNd2Em/uQ5BV05xau72xUC6VAvouZWkvN2fbogJP1/JDunnUbwCDkZ6iXOPn?=
 =?us-ascii?Q?TFK/NLUkZDZFWmZ6MKYDT73sDzq8J2IEj1BAvNmF9ZrA2r7lNK/kwHLnoGtS?=
 =?us-ascii?Q?A0z1MPm7vQzO8pPzLmYt8g/r5H0Cc3W1rxgrwsaLE7eDvIh2MRspENxSNOwd?=
 =?us-ascii?Q?g+86LuKsr80joL47sNPGs5X5gf7Cx+QuhruWmaDoLHgMju8Jtp9DrCW5Vjgj?=
 =?us-ascii?Q?BOKGyyRknM6cS7DKX4UbImVSVPfDAgDgEhHzeANl2sW0VTh47MQEnJ4huiGW?=
 =?us-ascii?Q?xkkbpd//rFPQDIk7JQmMlDomFzl6NnQdTKko8bqcF4kgIGM7WktoQpULu9uM?=
 =?us-ascii?Q?BkXfhxjlaZ3BEQjL3RY0c6zQKayOTggqCWAXOIHhJb/7tsNjPOODb4ecsOmS?=
 =?us-ascii?Q?TWo5oZrKANKQ/qWpzYM32PYb6k6DotF0NLhQ7WoU7aTdmGeHWMMGlOAdaLA4?=
 =?us-ascii?Q?9fXhliwSOjPt+zj0KuCwR60xpHL6Zed8wF8yhMT8NRI6qUJPUW2D8jSypSD6?=
 =?us-ascii?Q?34Wb5QDNW0MxhY+5ixXQvCx6DtqHEU3KGmzBELjyhRqcaD0xFuUD9I7hv+2S?=
 =?us-ascii?Q?KRFfc6Bl7p5g0mRIRWyfYColzg9jkHtxJ5W2PzxCQu0AopGgvTMF6STs6SkV?=
 =?us-ascii?Q?IAPUt2qgg4LAQ6wmvDcEgF+HhWKoxsHhRS6bW7aHuqHClstiGXpQRrcokR+O?=
 =?us-ascii?Q?kSPr3PoxnAq73Bhy6HspwjpXsEq0gAiJ2o3cwdmKRXht5wYWgqkr1N3N8Usc?=
 =?us-ascii?Q?XphFmmc54i6pu+xOImQDkE9mlpBLUBn9S5jN2MwKjpFwPq7qIN86lk1HpbPV?=
 =?us-ascii?Q?njhFL07yvs/i9g7/WCDFA0D7XDx8tOjD4U+iOvIb7PwPQDr9w570iXaYPphG?=
 =?us-ascii?Q?OaduMzx+c7cjVSUjvxEW+CNdP4GP1tytc63amsWKPpsGCEKmFSiRUiVvjk0d?=
 =?us-ascii?Q?Css+Uyi4inqqn8/O7slJOstuPy5fpB807o2vCPSpHP/Zz3QaA+Scj+XpYqsh?=
 =?us-ascii?Q?fuY2/+/hgXU5nBYvi3+e6+mincywmsDYXMDlyP9e?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6457510-eb9d-4ad8-a924-08dab2861b12
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:30:28.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mKHjMQNjG7VIN9Y+8+NBB/cUmSbwy39bH3IxfY4ps74Xbcyv1onKSZPWd++i2Xe2uoujrPpnqrnqXSyKVhaMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8060
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP ECSPI reused from i.MX6UL, so update binding and dts

Peng Fan (2):
  dt-bindings: spi: fsl-imx-cspi: update i.MX8MP binding
  arm64: dts: imx8mp: update ecspi compatible and clk

 .../devicetree/bindings/spi/fsl-imx-cspi.yaml     |  4 +++-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi         | 15 ++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.37.1

