Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0879A620680
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiKHCRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKHCRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:17:02 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150045.outbound.protection.outlook.com [40.107.15.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1356821247;
        Mon,  7 Nov 2022 18:17:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg0lPZVe8RotW2ONmdTRiteRRtvprJ4MGdyiUeyRSdgZEJQMsI9tPCYSKvPDm3pgROPK4RNrFdr2ceHD0g0YaNj/S/AV7TUyTaWJkEiCGjSWc3nqUv+pUQebuNWXUqdcTBVJgkdyKo16w0duqcFT5Y74UAUCWezUyQh9QQ3kdKfMG2hZwReGRApEcYgbRiGA0m5flBoGbCMUjbr42yac9gJU2rjJvIlDcnDRWRgxMjSV743yIhBBu5yI00mO6sfdmuIVVbNOHfQAs+qW+QJ9lDBRCKV9leYBLOK1s4ochRezgioW08irxFwW/7CLr3P83Y5Da65k46hOnPLm/ewWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKQOWdhLRMYI/ssNamZHmXacVB47QxYI5MrsOTmeNnE=;
 b=aEgJX17CKQOURTpgrNNbZv4/ifDa4XnQqBH6Rqu1cW6R1c5B/8/7T7bi3Jec3EURkDo50oaW2/7VTz4+LmUSh1v9TQmwWkT73eVguWMBJkia/y7BIPAKm1szANAn/uXqn01WQmstmoDtEmaO7tDwTxn6OxVOBELWJ+/qXl7uS+aKvjtt3Vg3wN6jis2qzPtElBzJjc/EscPxJAzIUPZ+8SDt73wJBiMeZKvLaVukFAbu5v9xgPBfmCC7fIvCTUxJDKH5PnFrbWCIUeofz0TI3oNDc56STsRhDecAQveUYJEOj769XNLKIr3LqLTOyEwzMqRCdnruOSLGpIDqVwPhmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKQOWdhLRMYI/ssNamZHmXacVB47QxYI5MrsOTmeNnE=;
 b=a9mnlneqBaz+v8s1wSgjlUhAEQJgSjMzOFEANOBboEAKX+GxBiKIUrV6lnqsyR2P9mhAM4FgVjxZAjq/YGHQ72mCP5TbckU6tssWVs4sPTKrCSsuPjtJMXoLRa+m0tc2DCl/h+bEZnu6xxztxDv0iG9iROC8dlT1e4mobh0KhEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7195.eurprd04.prod.outlook.com (2603:10a6:10:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Tue, 8 Nov
 2022 02:16:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:16:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 00/14] arm64: dts: imx8m-evk: misc dts update
Date:   Tue,  8 Nov 2022 10:18:06 +0800
Message-Id: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a48b5f-f6f4-489f-d373-08dac12f4f54
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2IurMIV6twNTIDSTnLtJaj8/jrdbb01lwXvpbaywyVoGTXJSyhJnYJ8xQe4oGsqTc3tw2bWlgoThFwkfaR1O99PrgeU/CShKY3ibkR1E5CY6U7Qx1gZx3/ARbCcUoT2LxiPcAxU7nC1dXUh4ad2WvhfzGDVLRFCMA77qgHktgTksx3eXSp0ekjtg3A7R9yhuev8DOeIF+U+4t9QPRSrne4uhy0tEI2YPIA7M5+biUmlwFoRxChUzWdxFPYUlmIl/TB5XGg2LmS7cA4AkR7Z+ONfR45LC9UmsBk7A1KfIuSDeSMDbp3ZV9JFGUCEsZVB98brkCYqoS6GqqvRq9wZbMHdjE2FbRGrjb9J3NTQZwVe5A0AS6/uvfcPCOklsk20I5PdAW07q42NwH2yZci2V7rwqYMs0nrfrPpxE2CQ/QM9dxS//SHRFbPKi/ovxvjcBWXtZemDVDtE+jRFIjpoZNfCD+2OKrIgeoXLsNbhnG+cH14G1oaZnubJ5xeK89JUMFJGhWv8wotXXXUDJKTJ4+ldKqRRkwCZM1ayTrlTjwjqSVusmzJQQUNb4+bArLNo/6Fo0iJzmG88gZ2XXE9tScmuA4QlwHhWlW91e3OESVMmiNE2atTJO2XS3P+wl+TEA/+M/GRxVibt/603S3/2tFQE0ZV/XFfJqoCoyx/jYiZcSRcHZda8rvnI3bv9kPYEw7aKtVz37R1+UdXoeuVNhQ7jYFZFLYDCTuy1Kxv5vEjQBbXoDg3mekG2IcOPHaRqWsTVPI4MXNZXGSvd3O7gjSVfGoU23xKW5jAuT+YerzUbMU9z6ZyAVHjtU4OJjfoDFhpvRDkOcp/l9FK6icJb9f5m/nARjBZWU8/aSWRF1cA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199015)(15650500001)(6506007)(38350700002)(2906002)(86362001)(38100700002)(478600001)(6666004)(6512007)(26005)(41300700001)(52116002)(316002)(4326008)(6486002)(966005)(66476007)(66946007)(83380400001)(66556008)(186003)(8936002)(1076003)(2616005)(8676002)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Pi6lOIqFtf24frmKiuPdIZkGPfShHdGtPZE32SrfJ4lu+/eP0IabMNsobqs?=
 =?us-ascii?Q?tzUqJMl9PyC+Rl+DmyYlK7WbZj409nOjMt656JS8+LOdlfITz+8dYEWdEFo5?=
 =?us-ascii?Q?hew+z6mqD6k0ud/WZFbeG9hmqF/U2uAqee+QPpBJMx7QGFnZbxtOcvLM7jCt?=
 =?us-ascii?Q?5RYuLMtZRwdkaCtmpSU//aboCfqxvPpkTq7MTe93LXRnVWXSG9Ieb0Nut6zx?=
 =?us-ascii?Q?YOrhFQS2WRz6rJXtUWLQSJIp7qo7AhN1XqzHqjJyP0sUSvSMJoBWBLSyNlNi?=
 =?us-ascii?Q?jfsslm4y8my7UNKoUbfVf7MDvemsTcNEgBzjB8ngz+LlzcQLs/gPq50/KRmd?=
 =?us-ascii?Q?781iQ5YqHr1mHtphPOFyMdrMeJtAz/Tl5CwSgbWT9nL1F9y+M61BJcqjNM2l?=
 =?us-ascii?Q?PpFqWpYZZFYeZa1GlbKsrlKax1vWhhVFJDdOry0xzjhcQBSYgnqTwcv2aiOH?=
 =?us-ascii?Q?igC2NUtPCB8LX2qsuPqYg4lP3MAtQ//G2gJ3ytC+crZFM+LfEEwdBxAVNTOE?=
 =?us-ascii?Q?ufcZxbYfci5Zoptya5sYDbbCwUQycjMAiCVTMA3/kHZQxhLTygtG+Jxdw3TT?=
 =?us-ascii?Q?FdWKW+/lR9sC7NuCiBVx0MS3evsQwBo+z/zg47r69tHIlHwHBQNAruX1v+fl?=
 =?us-ascii?Q?ker0V1rg8pZ2sfnVDKHpKMqRNCS3Snsa50IoRASvwBHmp8sE24HGjK/YLWjJ?=
 =?us-ascii?Q?45Ghx2W0mLwL43vciUKHfl+WkpsEyfydclG/ll0+L0T5x9UJGPwM1f9Lz/bm?=
 =?us-ascii?Q?aqcC8Kjf4FZGUz9fsay6ffNBVe4jdZOMMqS7sBU5nC20V2XLtUq/68mWbV4x?=
 =?us-ascii?Q?s1fhlRF2EHltMYIewo2OQZOauskaz/IoCk0NIcz45/+9SfBl5J/bVL9fZWnL?=
 =?us-ascii?Q?uUvB4oxnMB0JqdVEykC6p8E0/tOe72UJ/6spUDGjL89uKzXGm9bYB6dAzJxt?=
 =?us-ascii?Q?3BLlqXuTbrbqF85T6biBim3psEA0Ohjpg7Z32elcn+O/PhU+gs8QBdpHE20P?=
 =?us-ascii?Q?Tvx0gA3T29kVXZMbvfCbhYMVI1jcGjoUAce82y/Q873AS4eFA2k1eCyqo5CB?=
 =?us-ascii?Q?i0B/Sl8b7nk8YuI12vKfJlqMD9/SiRyzNiSFk3RLCjD+34E7XFwVpJ7YudR9?=
 =?us-ascii?Q?nAA24D1nLtij8B/rkLIhYZHcS2+Q28vKQ3CkoLLixxg4jYq5BNqgPXZ3QnQv?=
 =?us-ascii?Q?LHRcoYy26o8uu2ZzdgNN7fsGc4eyGMj2o+TvxNLidtggqSEuyudjI/5cI6Yc?=
 =?us-ascii?Q?gjMfjHWB4y4UxvUZ2wKdIkxj7JPlgz4x6wWr8f0zdz6NNE6CkMj1FM+lda4Y?=
 =?us-ascii?Q?PpVTHsCLurhilpBmkTeRnOWm9YJQTpygDEt4v6DZIIgDEMGPdXOlGcIp3cjS?=
 =?us-ascii?Q?ZtpFs96BIiq3VyusEWCN5+wwOhRgFCXX2ctkRqk2smPK0yJgvu/sk9H+IkM8?=
 =?us-ascii?Q?kjt/Y3+D+ijb1cmjSYXPNpb4LUBD4rQh5XGhPwbDLSLp49ltMTqrSBkT3FvP?=
 =?us-ascii?Q?KU292q4K7HofEc59FjjsqvfXPfEQ0L/fVW7wJB5WbUyq4bhIlWYyMBk2nr87?=
 =?us-ascii?Q?KSnmvU43RlRtay6QMEZT/ttK/TOXqQtCOZGkIk7V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a48b5f-f6f4-489f-d373-08dac12f4f54
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:16:56.7756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Acz7wsEg9bOT3JdL4Ff6kY5MC6TgrRP+A/wuwa4wjVgbXkqJWruFr/ga1U8b8k8hGbwJwP78qz1sieczWd1gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7195
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Drop patch V2 3/15 
 Add A-b R-b
 Sort order in patch 9
 Update commit log in patch 10
 Drop #address-cells, #size-cells in patch 11
 Use off-on-delay-us in patch 12
 Update patch 13 according to patch 12 change

V2:
 https://lore.kernel.org/all/20221024031351.4135651-1-peng.fan@oss.nxp.com/
 Address Marco's comments
   Update commit log for patch [3,5,9,14]/15
   Order iomuxc in patch 4/15
   Update flexspi node name in patch 6/15
   Increase i2c speed in patch 7/15

V1:
 https://lore.kernel.org/all/20221020095934.1659449-1-peng.fan@oss.nxp.com/

This patchset includes several dts update for i.MX8M/N/P-EVK, with
only one dtsi patch to add mlmix power domain for i.MX8MP.

 i.MX8MP-EVK: Enable PWM, uart1/3, I2C2
              correct pcie pad
	      Fix pmic buck/ldo voltage
	      off-on-delay-us for SD
 i.MX8MN-EVK: Enable UART1, SDHC1, I2C recovery IOMUXC
	      Update vdd_soc dvs voltage
 i.MX8MM-EVK: add vcc supply for pca6416
              use off-on-delay-us for SD

A few patches are directly cherry-picked from NXP downstream which
already includes R-b tag

Adrian Alonso (1):
  arm64: dts: imx8mm-evk: add vcc supply for pca6416

Clark Wang (1):
  ARM64: dts: imx8mp-evk: add pwm support

Haibo Chen (1):
  arm64: dts: imx8m[m,q]-evk: change to use off-on-delay-us in regulator

Han Xu (1):
  arm64: dts: imx8mp-evk: enable fspi nor on imx8mp evk

Peng Fan (9):
  arm64: dts: imx8mp: add mlmix power domain
  arm64: dts: imx8mp-evk: correct pcie pad settings
  arm64: dts: imx8mp-evk: enable uart1/3 ports
  arm64: dts: imx8mp-evk: enable I2C2 node
  arm64: dts: imx8mn-evk: update vdd_soc dvs voltage
  arm64: dts: imx8mn-evk: set off-on-delay-us in regulator
  arm64: dts: imx8mn-evk: add i2c gpio recovery settings
  arm64: dts: imx8mn-evk: enable uart1
  arm64: dts: imx8mn-evk: enable usdhc1

Sherry Sun (1):
  arm64: dts: imx8mm-evk: Enable usdhc1 to support wifi

 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  23 ++++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  41 ++++++
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts  |   4 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 110 +++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 117 +++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |   8 ++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |   1 +
 7 files changed, 297 insertions(+), 7 deletions(-)

-- 
2.37.1

