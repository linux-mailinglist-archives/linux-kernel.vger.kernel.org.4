Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085C3717733
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjEaGxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbjEaGxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:53:13 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F00180;
        Tue, 30 May 2023 23:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSdTe0k4q5NykJ5fCelbUZ6ayY+PH/Uo1yOjqTpNYXKQJ58VkpaLWrOHgT3cTqEHCwgEBblNcA6bXlwX009YU7odVfUOn9dTuwA07H7uWskTKJ3xQfnBQ0u/7ArdX2tpMsF5C4qRe7GgDG+4I9j3mTp+38+Ua+7GJ3k6Ns6C+qy9JcOrLudCvPy7vBH/AeO1CRXcyKMXH9qtoUH70D66SuS5BHnERDsLflX2+ierHV9d+bRH4h+z3tnA9BQZY4DUT4U8dd5lY1y/j6oN/xorTJ/lTsxpGg2MqCaHiZlOthHrYCfmlDtX42ldNkvOk8KzEeM0dM1XXhJfYK3ptckGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnAxKAFQ14kxtbL38CDjLl1OxPjBd0jd7YqACLvbtaM=;
 b=BoPD4gr4bj8cAuyvgQjFPp8grvkGGJvRg+j/cVQYJ18d+wmevbjGgA/BMSzUievSpi4FR7mqoAnmqRu/zfSxIGhOH9rbSIgfhB/8YTkgknF1TR0bY7pHCh5+fbHj7tOEQk8XcRzoxjDSPbxO80sb3iIrPAN72RmvPScT6W5HfvSuwJ+kEYk6QLEDBq8E47It7nGc5L92L4Dn4yjl1sGxfP+b786K9cAMUbJiKvo9Ghh1NnPZkPEhSB2NQcRpkYN1C3Zc4/teZRynrwyBQskD4LSAJL7y7wT7qy1HxQU/CqRXfpKVKQnDvttcA7iMMRoTz4SeqXcp0I9TPb/MI86b0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnAxKAFQ14kxtbL38CDjLl1OxPjBd0jd7YqACLvbtaM=;
 b=j5d+pfNNGdYSHm4Z4SO4pmgrmfEnjaq0lPXV+lxA/UgOmqn/krI16U3czV5LnFu25UPHM83U0B64aYn28p6j5tEjnKmtkqiMCaQjRKq5U/NLW6g7Hpvj6Ux6jyzYFmw2Zonw1rJSr5X7NWwQmNDu4wUNaSQ78HC9LVbuoskZyp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 06:53:08 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::1a8e:7e33:7f24:d77c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::1a8e:7e33:7f24:d77c%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:53:08 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     ping.bai@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: regulator: pca9450: add pca9451a support
Date:   Wed, 31 May 2023 14:57:22 +0800
Message-Id: <20230531065724.3671795-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230531065724.3671795-1-joy.zou@nxp.com>
References: <20230531065724.3671795-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|AM0PR04MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d5e6a1-08b9-477e-5bac-08db61a3b0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kW4dQhGVkLFk6TxGp32ycWd471Ervncm1habpHoe36ZwTOf0zbA2sh42CJmTaaZO3JWRdwhYpI3aHZVXHWt43k5c+6ExAi4WIAkFUOIqzou5eSr6GWdhoYctHrk3xHIfu1ewaTFpTjxI0Bpw8+rflg+NID+WL54afxZRtXqIzxXSE/KcvFJ2jzO9fB6gl6S8ZMgmmuo9kj24rKJjn53LwNEXzrWOc95UE5d4YS+ljplA5+mnBbN53D+zCVciXDMr6QO7bMK8ksG006KzCqJcPGEBLIfHyK8d2RhsgGqo11pXvWq09Ov1enuhNVrrKjJjvegc8+wFxyY0228FjuhsMQSg9OcDSPRWZrWNZqkUJwHAOZVXMOUFfiXulZ4BlBxd4I3yIeX1uQAMC/OlN/wFFg5cadOg6ovTXCyCZeaHv0eO+EKfXqo6xoI1cZNLQB3BurlMpWOseTfnuOG9/Nd7GO0V/oVm9ynRWj6LxZG1k7Qz7bd5swwF5zKktklnLf0R5x3VgRF9Hv/n7l1tJ4JWO4EoXmDTj53NP2ac6v6gOLN1KquZ+wM3D/JSDZi66F3pHQuR/DGNcCbnEgt9iiK+SRKdHwKxG7Mi161XYuUR8oRXOz4innc1vNqQDjoD3S7U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(26005)(1076003)(38350700002)(38100700002)(41300700001)(52116002)(6666004)(6486002)(83380400001)(186003)(6512007)(6506007)(2616005)(478600001)(8676002)(4326008)(66476007)(66946007)(316002)(5660300002)(4744005)(8936002)(86362001)(44832011)(7416002)(66556008)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sby7OlvDfhp/I3xTueS7tSQv9VsG7vmHWCk/H+i36vwEKLhP9Yix5qiVqio1?=
 =?us-ascii?Q?N+E4604vwWdlxqElWlHGUyhh9gc8eiZVjSwCWoZCZX51IE7cgPyciEWbnf46?=
 =?us-ascii?Q?v4464LbwM0WiEt6v+TiEZh1xOnedMBm0AzgktWw9BhP+CPRWpV1YRbLimJFR?=
 =?us-ascii?Q?EPupGcbjy2AR9cQbk3mqhQNRg3/qrA0WFT0s9iojIkG/ldhdealWgoeX83oe?=
 =?us-ascii?Q?jI98sHI3T8/3AI1aCtQVFi2QPoXmwef2dkzPzkyyRFWoATdLzay/7zl4ZgVT?=
 =?us-ascii?Q?6JOTsmHQC2VDtl99/12znOgdCv3eAWeSHIrM5ebKzRnb4dkkHJkZ3Bvh5ngq?=
 =?us-ascii?Q?jX+BU1SbAqHb2tIViVqbfKv1BJWfmGNemrfmFKY+NhO5qHNytQPfCxYSBlMW?=
 =?us-ascii?Q?BI6GMXmXGfit9yk76nziaZIPfpeMAW7nG5cwhOZZifFKYXZvvWhabASYLBnA?=
 =?us-ascii?Q?+zn9p8hSm0/gwWqmI3rxUGgbvdPtxq1O8/HOnvgLNVb3/qDRkUoDp78pcI4D?=
 =?us-ascii?Q?AYwyTVBYbRNmqfbkgPfkx/WkOArBPQQqA4WgoxcLcu1rqrHys0OxGZ4/zRSH?=
 =?us-ascii?Q?krT5AGsU1xbrmugaIM/MlQ1/OC5+DOpn1pGJg2lo8vYUpsoRxCqx627GAJg8?=
 =?us-ascii?Q?UGsxzdLVdxSQqSxoutmuy0Lgl5th/LqbbeyjqLEKkI0y+q1FzIi0BWVQq79a?=
 =?us-ascii?Q?bm0Nmr8MXCTFz6zsZx6CHYSb4sSAfYnK8KObDPLL62Rt4E5s1yb1fuwtPs3i?=
 =?us-ascii?Q?uVoZ4tsCRLGDVrLhkmXmk6LcWLNmDIuO/GIZrh+xtOZYyxGe8S432FDwBK2o?=
 =?us-ascii?Q?XnYgMlCFS27mrnW0LDuosFnA24w6AaqDyoqW3tjPhJyLsCEPwLcIAMDFggF+?=
 =?us-ascii?Q?p8NW8prc+9KUS6SYDdtLMggQlUYMSDR3nh5hEd+/4FxYJmpqzB4spK013Eld?=
 =?us-ascii?Q?snrsva/4NZPFXVQvxe6yfUdnW18L169F9EpYc54NgiJBUCMU/GJ3hdnqj7Yv?=
 =?us-ascii?Q?yBWaqWwZCh4ewqt8FzfQ+I9HPdImZNdSXAi6/LmjyMVdZOAaOdVB3Q+ZwRXG?=
 =?us-ascii?Q?tWP+zMEPvApfnXXpfe9p6iG3z8mR5QupAriSB+OfJ1NFcmeTpAWllAq4raht?=
 =?us-ascii?Q?y2q3tiwjoYyuZASr1IPhrCxd1bp+HHJCzLoYpWqcdKNPvnZkFErhDsnXmd9l?=
 =?us-ascii?Q?RGZ2nGKAgTTMlr6TFTTDYHjLyBVecgE4JRHS1RBd4HYUWjzTF27G0wplnhpi?=
 =?us-ascii?Q?APkcGYYDuAnzeBkIGVmgNKmGrvU/HsAQhFzTFE4RObAMKtqCw6rH+e2C+v1S?=
 =?us-ascii?Q?CdfqcBr25FsvJs7gYakQb4xr/fi/7DiHmxc+WxXdFrFVhsFXFWbGG0fcaWuu?=
 =?us-ascii?Q?M7g9vJhpvIuLCzj08MG/NaAjoqltd/Xcp5EikLLNlYR8jnmYTwFXa59ltPbU?=
 =?us-ascii?Q?AT/+pp5K2WMxkxk2oXL/14d+Fv8ozuMAKjxTXMUdCCN1MqbiLrHOGF5APwwo?=
 =?us-ascii?Q?jmzJee7g1AygZiDzepFpQyXfmAYCoP/aTkKic2y2I8kYGkgu4T41O+D7/HGM?=
 =?us-ascii?Q?8Zw7E0Wnj4Y8bWVkY5Ma4RKJRiPPXxV1YHuZhbtV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d5e6a1-08b9-477e-5bac-08db61a3b0e8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 06:53:08.1700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNzao0oQ+sILzpCWPW1FDOjO6ZldSu2DaoAHxrGZEtdcISi86dGXGHLtIXEptMtR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update pca9450 bindings.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index 3d469b8e9774..849bfa50bdba 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -28,6 +28,7 @@ properties:
       - nxp,pca9450a
       - nxp,pca9450b
       - nxp,pca9450c
+      - nxp,pca9451a
 
   reg:
     maxItems: 1
-- 
2.37.1

