Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C110605B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJTJ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJTJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:58:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770CD1CD68A;
        Thu, 20 Oct 2022 02:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkXo4y54zhULfWaJopnoHKsLkN+KY8IIvjJYh6WtSbxN9UP4RrpiLISQZ2CxQXJvX7VgrKafFUfP6GmZuZa+qPDd5Ct8dxCnNZgw/6WustpC6w67X4s1OHLhi5pAehbZaex4rMixguUqUxo6DkMMWicxFEIsb6vCvRE9o8tCUrYBs1oL+MYoLbuJO8ZQjlaUoGD/BHMrc6n3gYoFdS/iUQ1l+dIFMrpQDJuQNaF4Y5dj2cy9gm8Ps7WDfZKDmkBa+lHZ/YT1CKaBPjbcYhlJEmzHTb5qZzjiJIv6bg6rELuGabyOYlFQT6k8bX8mwxN38m97Vc2J0Vrh+Gmh6z6y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2QCo0IvbbvzuwfeE3vtUqzd5vEvJrp0KeX70qTAv+A=;
 b=N8cg+jhRRX7hTuXPZeWVA7U3ZcpSHNR74pd0wmMWZhmfQuNxO1cOFdNBp01EjibkyFK8IKL9Fi5MSS0mW9gTwCrnXyFM+KPjUVjJnqIOHxg30/FA0MZlmZ4eeCxD/RmytPGd3qTSpKI4e5K0Z30CkjoAh2rjZnzqkevY4MMbRaDohma8RAiXqeBTk2XrESl+0+u0ZiyPiCEW5po5P95wxoncmhX/g+NVtUpzF7pkDMoJlhApG75k4Eu35fIWgog112+bCXcOTVFFYOi4WFNVjJimCPHI3KlrYi4c/obthdxh+J1/BLRfQTWhcLWIsyBSZhvdQilrG0+YFl4s+TCYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2QCo0IvbbvzuwfeE3vtUqzd5vEvJrp0KeX70qTAv+A=;
 b=k5UiTHzd6HPsymDiyQI3HP8xU6g+x7mTU+7v0ZTxnb+TaxJxcQpveAzWNhBd3I++s2P4rUX7bqUeViiJRH92tQ4+VJXNEizEiYOA/Vw74sD+MLE6g6allAbysPtllhFr76ZMcQqLPuwQttFi/3aq6bcZtfuxbNFwF0HjsD8SQOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9320.eurprd04.prod.outlook.com (2603:10a6:102:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:58:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 00/15] arm64: dts: imx8m-evk: misc dts update 
Date:   Thu, 20 Oct 2022 17:59:19 +0800
Message-Id: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f241b4-73ec-4484-b4c9-08dab2819a90
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBqIgVs/NS/ZI6/dPXQhbf67dZjaDhE6r6i0T8gq53Cf/Goz7Sxaqr88cik3XqYC5G0iNLLZ46wtAIO/eDh5Y96P6aC1lGy4xgjSmng4ed8nPgtGS3vsfnIOTEtRzcJcE8gEb913xoAaSKFrPHhnOT/CbgnRBDpLtNciScpGLAvEBwtDGVDAn3W9zYqW8PSNQLG/2YQiiOjn3iTDu2ync0z+r4rpYofs8FyTi+x2gl43FShRJrxcHWGzTWfUJv2TGCYmH+PBS6kK68bCwguXaaSTwQbW60F2pvpoyVuaBvUXkFnpuoWSaZCu1zYJoi+JZCbMQ2oYmwgn61O3AO3hianBYz7Hf9b7Z5mQpeP6AHURasmYTkZ1oPEr0YvjigUkQ0eHavbEUlN3w6RJYzqonrM9yG0EJhuq3bExttAp5Y0piI4yGdXwfYQgskz76bkNfDt789njGuJFzMo/79svgYVO7qspqfpI+j+3WPKCdTdewAn/BRVix166VWw3CaqJATUJol70CQJ/P6nqdH7TI7vX0vtViA5rkUQR93ESpe+jV6HwIsmWi68U1F/sOHG91m/6BJz+7nTjRPx5j4RhD2X9dHB7+cv1bUHp4yWbkrhKoZ2gMRWN20BO5pulyqE/zLcUE5go11B+ndY6qMLNdx9Qw4G02WG3RqMuwr50uLQRm/tpOSToP+CJ3auayNhuNVvPuVc0MXfhO8KLaatbjN5A2DdvMDI+0a3uv37IIMvwuJfOK8TJnsTcbLWplRNnnB1RpuxD1eyqu48km0gcRBmzXoq5MDFXspCmQQ1yHC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(186003)(52116002)(38100700002)(1076003)(478600001)(38350700002)(2616005)(15650500001)(6486002)(66946007)(66556008)(8676002)(83380400001)(6512007)(86362001)(5660300002)(8936002)(66476007)(4743002)(4326008)(41300700001)(26005)(2906002)(6506007)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHZxUkdaeTdaR2dmWldQWUVsblM1ejFJUklaK1owQWZzOWY5MllvTEhqNi9p?=
 =?utf-8?B?Y3VQbGZUTUY1WmQ4RE9ES0w0cHJCS0RSYWY1N0VZclBFUWZkZWk1Y01LQ3Y0?=
 =?utf-8?B?NFZRNWY4b1NLMloraXdwT2JwQVVFaTZHdWZHejlJdmxYWHV4U1E4TVBzaEND?=
 =?utf-8?B?RklOZnp1Vi9SRjUreTJ0NWhibUo2SzArWUpYV2dhK082YkJleFY0c0VUR29Q?=
 =?utf-8?B?N0hJdlRUQUxsa29SYXN5dENTZFJHYXd3Zm9PbzNydFZxWk5yb2NWeGhSN0JQ?=
 =?utf-8?B?VjVlbnVSM0Ivd0ZQekdZWlpTNmR3UFZIWERSRlY0YTNXZ0grN3V2bzJJQ0xE?=
 =?utf-8?B?cXo2UnlDZGgySzdpRnBjb01pNDhHQ0x3UW1PUHhQWHFhbHZOak9UT2hucUd0?=
 =?utf-8?B?a1hrazJYWWhxTTBNbzl6VTFFSldrRnljRmJTa3FCWFJEK2dVN1V3SnZ2U2Nj?=
 =?utf-8?B?ZnhPYWZNQjFPOG0wUHRWTHJXdFhUU29tc012d1dTSDk0cTN2MjRaR1VLbk9j?=
 =?utf-8?B?czJja0ZCUXgwN1FRZC9QWmdCOUhhZ3JGZXF2cE1UYWx3RnJKVVRHSlRyc05J?=
 =?utf-8?B?VzVnZk1UeldvTlRmek9LNlB3SlhCUFczZ2FZV1N4L1FBTjF3MmxJT1hwbkZY?=
 =?utf-8?B?MlpodTNUb2dWQndmS2poNkFFNy80UWdFbnlvU1lpQXJPQnFBdXBSNFMwaEdP?=
 =?utf-8?B?MmVsNElSMWM5UkVsS3ZLOWIzdUhDNi9ONWtMRDNYdm9qR25JbTJUZWVHcG1X?=
 =?utf-8?B?Nm9TU0hzN1pEOFpOZitzemtlTGg1S1MweWhHQWhTRjJzVVhOZkJLR20rS21p?=
 =?utf-8?B?UHo2UWRUMCttS05pbHBwWWJMOVpHQWpQU1NEZjRQV0dhZHFVMVl0cXpZTTFF?=
 =?utf-8?B?aENzS3BoU291R2Q5YlcvMFNmNlpoR3g1NFVQS0p1YUdFWVlSaTNTZ2ZsbVV4?=
 =?utf-8?B?czFKRHJnTk9XdEEyUldicU1oWkdNWWZ1TnBaUDFJblp2UVlXVDRJTkZzc0J6?=
 =?utf-8?B?TXZVK0lDempzM2Zxcmk3akFZZmpIQkRmZis0UmdsQkg1UTJSOXlkNW9lTzRv?=
 =?utf-8?B?TFdPampnVGc4OXhJSTJlNHkwVmUwSU8xRWtlelV2d29VNnVuUUFtK0pRUFRv?=
 =?utf-8?B?OG9mVExtNlhKWGNwekI3bEFHb2xwaG5acHJ1Uzk4eHArbldjbUlUODdmTmpT?=
 =?utf-8?B?azdpMW94bE12QTVoMEVOeGYyVDdINzR5MlJmL3oya2QxaGRsWFVMMHFzRm01?=
 =?utf-8?B?VjF4a21HTHV3ZjFWWTZ5U0lQZUZTd0k0TFFTYW5sZ1ZpVzdPTmw4azE1NnU2?=
 =?utf-8?B?enp1YmFBOFc2Q21XZWdRNHR5M1lsaGZpdENBa0hKL0JBSDN5cmlHZE9TMDJD?=
 =?utf-8?B?Nzh5VlZSRWMvM0RuVXBUcGtxQ0FjTDIzNE5oVjlGMGFnU25sWTFRYXM2M2Q5?=
 =?utf-8?B?akc0YnJsNmdDOUJ4QzB4R0JrbDRNdnpxUi9Hdmo2MlplaHUwUUsreS95RDh4?=
 =?utf-8?B?dXV1NG9pOW84TVFEa1V5a0hraGxxNUxjbEMwN24xRkI2SUlVMEpxSFdCSC9y?=
 =?utf-8?B?TFVJZnJBZjNFQzEvek93aHNvZlFNRVBTK0JLeEFKMGo2ak5FVm4xUVFZaDIw?=
 =?utf-8?B?SWlDN0pqS1ZMSGxkdmRkUHV5ZjdVd0FoQnRzd1J3ajZ0NGdnK0h1SnBpcHhj?=
 =?utf-8?B?bldsUGNkblRxNnFMLzUzVkU4dnlsTzc0b3E2bHhSMmFyZGt1SjEwaHZwRnZU?=
 =?utf-8?B?UGh1MFRkRnExS0NpdmpxQUNzU0t6V3ZCYlEySnpQaTB2dGdTUy9pY1pnQ29j?=
 =?utf-8?B?eTNQU2U2WTJzU05KUXVRcTgyT3ZLeDUxa3hQaFRaZ281QzBJVTdjVmFya1V3?=
 =?utf-8?B?UTEwN1Z6V25pa3R3SnVGV0ZabmltSDVZdVZqMGprL1JmdFNrdXhQR0Y1b1NO?=
 =?utf-8?B?Z1JEZDJqOXhjTWRXOFoxZ1I5WllqYmhoRmtDa0YycnBZM0hraXVBMlFHazBS?=
 =?utf-8?B?dnhvUm5lSWxIdi9SM0x1blFxR3dWOUJVcVhGVGdsLzZyRmdDWVZTb0RjOWRL?=
 =?utf-8?B?OGozeVZWVjNZcmlvRTFwRjNtNllIQk1CWUl5ZDg3SllGT05mWGRWcHNpZEo1?=
 =?utf-8?Q?JE9UJK4foBHX7gGL2texUZnxf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f241b4-73ec-4484-b4c9-08dab2819a90
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:14.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/bfWJNarrH7Xsx39WDBnbzzMYnNWm3k4zUXJkWVEpIluxng03krzCL4RBsfMlohGBJe1OFYxnZ5RazP1OMM9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9320
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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
  arm64: dts: imx8m[m,p]-evk: change to use off-on-delay-us in regulator

Han Xu (1):
  arm64: dts: imx8mp-evk: enable fspi nor on imx8mp evk

Peng Fan (10):
  arm64: dts: imx8mp: add mlmix power domain
  arm64: dts: imx8mp-evk: correct pcie pad settings
  arm64: dts: imx8mp-evk: fix BUCK/LDO voltage
  arm64: dts: imx8mp-evk: enable uart1/3 ports
  arm64: dts: imx8mp-evk: enable I2C2 node
  arm64: dts: imx8mn-evk: update vdd_soc dvs voltage
  arm64: dts: imx8mn-evk: set off-on-delay-us in regulator
  arm64: dts: imx8mn-evk: add i2c gpio recovery settings
  arm64: dts: imx8mn-evk: enable uart1
  arm64: dts: imx8mn-evk: enable usdhc1

Sherry Sun (1):
  arm64: dts: imx8mm-evk: Enable usdhc1 to support wifi

 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  |  23 +++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  41 +++++
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts  |   4 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 112 +++++++++++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 163 ++++++++++++++++--
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |   8 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |   1 +
 7 files changed, 331 insertions(+), 21 deletions(-)

-- 
2.37.1

