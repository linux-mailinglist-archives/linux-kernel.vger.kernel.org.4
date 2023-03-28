Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533716CB4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjC1Dbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1Dbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:31:39 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAAE10CF;
        Mon, 27 Mar 2023 20:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3qSuXgOmScrp43OimfJiIx66H73EKnJU/gZLv2rTI35F/axA1cg+FBBGIHUBoPOor+OI8RY98CXtyuX9sjIGakrEhFqQMWrcTNq1deNC0sTP+/sIvjD+hwnw/PcDWUQM6RNAMFne5J/uiUGUnJ/0/6w8rB63aFDiJWDrxI9ck9AkwxKZrYvkX8JSIx86rF4GcvVmUe5n9Aln7BagIgig35Mbc3EwG2dWp5RuTFD3U335NW73gab7PmBA/scbzw1vaivgOjzttbYkbJHoFureh1uz8fvWDBcuSLQfUi7QpU3tnDFESkEmHFl1cqWJdHXLor+74n9v6i1MZXRJpLgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONKpauhsVEpwMLN57UmK0UDUHhyRuDG4WWBBtGbfyuk=;
 b=doovq+d7TCi4Ubg7R0rdzFxKX2HQe8gTNFyQEzcuatI9lzUixhdIP6TURUVznGKtJUovPS8cum5ZTWLOFGNxgDQDsQk3AagVHZjOGcpdW6RrqTGZ9Q9/ZwYK1wVgixZ+yW1xOTTpeqt9/lecUOe85FCFamXUKB2YPeQVy6DvDpxrS3jaI+MnhcPyaXy6GIgfeRfI+XZhV453Rjn/4T04R14yDrlvh25v4Qausbd/HkfS7K2JW9PY1ucq6wtxm5qRYd+hkWkW7bFBEpNkfK9vIBp9neQBuwS111rQ5p+3JTTHaj6/BOisr0UZJZ6Ir4hxPLEMmeOS2RXV8HMo6jUDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONKpauhsVEpwMLN57UmK0UDUHhyRuDG4WWBBtGbfyuk=;
 b=iD86w+K3fvqXDhkooDfbS57MOy7JPIqXu0tmOyg4fT4g08QWBY+3nSm4HxDXA02oiCdNM961WxRmPxgEAqSkmmkTBLByyBKPUNZwW8o/K4T3v5ceKtmTUwwABmQV56ZvfeVLk+PKPzMH6vqdVcsbdtDK7P0iEBzpXq6pvtFFzyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 03:31:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 03:31:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/6] arm64: dts: imx8m: update pinctrl to match dtschema
Date:   Tue, 28 Mar 2023 11:36:34 +0800
Message-Id: <20230328033640.1930104-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f362318-cdbb-42b7-98bc-08db2f3cedce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oG1+18hnk7yzSVjHBhIt/ajAWtUVFm6Y4BtTzmcmbhY7qxcJ3nYRiwTk8/NQbUc9AsxqEtH3nYP+ZGFt4cG0wLNpgGNVXQT9Ey7agGF8Noqs/MJ1LtBCzmQYlaBdazfG/jc53Wjp3Mdy0X3qTNvFwOwP6jFJQ4LQcv7zcGk+O6XAKnkkwQY33VrPsip/BEQUVysBnayd1ag/mcsfofEAxBt5ut+JnYCeZmP+u/IGJbkoeMnBd5+TjYAK0plVIEgxATo4J26QjQ2m/myow0myMtV0nYxWEmP7DmzKp4BwG2OQ7HzcHCZ0eDYd16Hti2JLnVRQOUNxPFleu1vAtTuFuzQ3TJK3B/iATJEjuv2+3elskv55otAs0ZD79L1YzjiaF4psO/i7D/hLa/5wTHjXyu3uqYzcy/fo9nWbUiOwsvKIc+iKkq9b+KFoKKEONzsNhuqtnXrcro9kp46PPNyHLS1kyoC4pofZRxqhqPT7viFlZUpblY9yzAAej3U1UJwy6a71tJh7nuayYuF7MgFF3qavS53Y5elVGmVPt940OgWc5easJGQof8sPgRTglcgmG6h6wPrTPkyMFvkHySs3nYH02ijl3W0X12qfhHDq6j4qSm80dI61CXmLpz8BpAV5x0P5hROzTq50XUiN3nfLGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(86362001)(6506007)(1076003)(26005)(186003)(2616005)(83380400001)(6512007)(8936002)(5660300002)(6486002)(41300700001)(52116002)(4326008)(66946007)(38350700002)(15650500001)(2906002)(38100700002)(316002)(66556008)(8676002)(66476007)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hIaxeRCWvFarN5d9jMFO0Z3YfLlJ/NSg2UXxs1C29b6VKpR1kssRjuXRZpcC?=
 =?us-ascii?Q?ln+AQ/4ZGeaabk059Fkx2sfDdriq4nsJSVmJ8msJSEHSLEsqqNoaV3qgXnHC?=
 =?us-ascii?Q?ckqqP2fNzSb+8ZVAP5VvuCqYPuDRefx4VBfuqwQ5nfqMUoqPwceFBRSeH+Oh?=
 =?us-ascii?Q?ltI242MKjF1CupasLPxeVMsf1S0BTJa8pQLGw0hQqHQlq88yuMZTY23chbUh?=
 =?us-ascii?Q?jbrUU+WovzEuAX76pmPKSr0vtVUYIGFv4RHr/di45RPPS9571v/IH+Uq5zmN?=
 =?us-ascii?Q?zVHv4llJFMPBWGLIglnEzSEd3M4OULDvd72qGEp+Eo7PQOZsUMlU/I+oqD3O?=
 =?us-ascii?Q?xUHavUdqrMz6f8ThVhuNH0FEXmow3d1Afj23Cs8EXPwuEufhDItPA/UOUoGk?=
 =?us-ascii?Q?zAMHNINI5vx9gsxCAWpKnfR66P2ICY2bJ042NwQvxQt+CyoK72Wn1vWHSch8?=
 =?us-ascii?Q?Ey2Is8EB0Gg+CVaEau/HqdCT8BrcWjwUGkrVRgQE1uW8DF+iYA7iVkTd+DWg?=
 =?us-ascii?Q?oj42FJR3kWKXgFI6dhvifYG+RwOFjtQ7hC/a2riTOIk8spRFR4Ig0Mkr9XDj?=
 =?us-ascii?Q?BEVqDrJTnzMuzMacUe0zRWAMdfOH4tXl9XPXX4QGP6YtFw5YKu9epZAStLic?=
 =?us-ascii?Q?autZyOTSFL+HP+D51mANyStiocGlinbYirvXIz1lDZ1/YfgOm7a2LBjeyWj3?=
 =?us-ascii?Q?9SHi2LMveNc8zoIRkD2DKnYDuLXqyDz/LTQMO7n4XsnMbiShRNs8rXlCE1xY?=
 =?us-ascii?Q?+DOPS9pmOU/ZR5oQETNOhntIEO1f8N2tPBmgZgrCjcS+Amg7J48YiknyE42S?=
 =?us-ascii?Q?mGETXxrlAyGphAroGEjCjRBwcwIJIfqVYcap3vScz+JhDCv5LA3EGF4HHcZy?=
 =?us-ascii?Q?T2u4Xp/uBgAbJpGNJwLr2ak9qHKemSSVZEkXYB4S+i48IuavBaRfsOua8swN?=
 =?us-ascii?Q?6o+LjRQMQrAH+xBgurxJRK9toM8v4qv8ENqM03bY7v/VOT4MrbSFtOiH/SqI?=
 =?us-ascii?Q?Qt7BnJYX5b0sWHEGqjuguufql6NiQtD9NwoGJ3WY4RTlD0s5OIW3MWdNNB7k?=
 =?us-ascii?Q?4m3ajA+aKpp2nZz2yzpWMYNTb8y9vY8FgftRSb0a8om39So50rXvcf4mqMIP?=
 =?us-ascii?Q?6Bp6ufwAW2o9t7h89jZ0NMuySsmS5vcKWT7IEOkr8YT+oRV1BOcyD/CkFGFX?=
 =?us-ascii?Q?Ex9hpw7jPsA2IpI8bsESFbyGrcjT1HjT5PXpP+Ni6XhC+rANrKVuKa75L5Vd?=
 =?us-ascii?Q?r74iO0J9VTRxgjPVjgyTshol3vrY2/uanf1GkGvs03yvo367rbHOZJd6ywIs?=
 =?us-ascii?Q?8IoTrtW9mJePCtZ577CTOAmHkXjSkFKgaLyjOccuJYdU3nEIoW/PJ9Cp61MG?=
 =?us-ascii?Q?mK6TTA0CSMMS/SXesHFI2SMmiJVyMb113CNAoTH9FQSyja89ghB+22nYILA7?=
 =?us-ascii?Q?xxhYKpkBrV8Xa3eOBYDg9lKm99MRmUgV7GmktmAoKBhzJYCSASEgyOes7VMo?=
 =?us-ascii?Q?5wPZur9krQY/BDr4jbz1pD7j/9u7QpP2Nb4xjyp/uRpwCQFPBkAdsMJc/Oee?=
 =?us-ascii?Q?ieABX09XXgCcC8zmDpwVLGl/tDlka3YmVl6b39UZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f362318-cdbb-42b7-98bc-08db2f3cedce
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 03:31:34.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehEyRtG9mFv3KbnPW3g32mFtutix/ARdSFYpxDIxfbMgwHwJHrc2hKDXKDfaMwHFQs+3sDMpvE9XRUrojegYlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

During the System-ready IR 2.0 check, there are lots dtbs_check warning.
The pinctrl dtschema requires grp in the end, so update pinctrl to address
dtbs_check warning.

V2:
 Add more update
 With below script to filter out:
 grep "pinctrl.*:.*{" ./arch/arm64/boot/dts/freescale/imx* -rn | grep -v "grp {"

Peng Fan (6):
  arm64: dts: imx8mn-evk: update i2c pinctrl to match dtschema
  arm64: dts: imx8mm-ddr4-evk: update gpmi pinctrl to match dtschema
  arm64: dts: imx8mq-librem5: update pinctrl to match dtschema
  arm64: dts: imx8mm-emcon: update pinctrl to match dtschema
  arm64: dts: imx8mn-bsh-smm: update pinctrl to match dtschema
  arm64: dts: imx8mm-prt8mm: update pinctrl to match dtschema

 arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dts         | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi           | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts           | 4 ++--
 .../boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi      | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts       | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts    | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi             | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts   | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi         | 8 ++++----
 9 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.37.1

