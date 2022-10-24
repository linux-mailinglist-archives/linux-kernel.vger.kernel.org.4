Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D58360987E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJXDMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJXDM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:12:27 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B87F638C0;
        Sun, 23 Oct 2022 20:12:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yq7/Oe7h3fH0Ygug52AJq3O7v26kfeuxDMknVheYEyzLOhLzgfa+E8LRwC3wFnMC4H3XToNRYZZIesSLyrFVhYICJK4mm1KeNm0Nh5NkYolYqbbD4TZK51B0oj83EalKRQSkJwQqYnCGWymGdERKqQ2VpY7izvI0GjCynRHGqgSm4jp9QmVXOXAmBkLZ/Th1hav57xf0JjrckY7jQmTx0guohcqzLQ71+ZyqsL3HYt9LHp2RuctdeWFcHbbxOXY/uP3d3BRMZWb3gKBLnv0zCqn5WV9ckUMIVjxgzf6pQKHneYGXK4WesPmrVtVYKP/a99z6yGQ8y4Sc+4VbCV55Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMSZJtcEhJvDN/Lihc99jFQEMG0ENGwoVlcaNpxGyeY=;
 b=IWSxqO561nEDGgTOJ6c9s0AtDeKIfJ/sMq15+j3UC8sa29T+BW5NOer0UC8W0ECKedJjOtuIQ8bicfzRn5mCvEh5fxBjw4epTnprRJRYtXHU0FG3X/yvJlgjvCLOep6NJLewrcbujzSD8DGbzMMP8TXhrvPIEY0Xwkctt0VMQPzgeL7xD1Wd7rE8qGZE327TpTtMRdnTQrN2sQpXzV2Y6pj/UzKZ6X28GupQIUyKEjJ7gUjJXoTZSx0M+zhOF8W8xqyEDuYrJ2/fEtvBR34r4cAxeSg9vERc+tC69ylljOIbZz9ColVrBj5h1A+zRSDS4HnIXd5p91xuOCuRPdJEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMSZJtcEhJvDN/Lihc99jFQEMG0ENGwoVlcaNpxGyeY=;
 b=HC28ff+XU8wkZPIX8M2rWv8vqJ8sIhZM+ngIWGAP1elSX1rZqLdL3q4jbraVxyi+hAHOk4FiYdCMvDvZ3Y02iT6I9DZcabBL3N3WUMz7fvFjIeXSFfDSRBDOOU146B1SLNRTXtjRAanJkNBrrsGhyBn8S4ZDNOTiY6HszPs81AE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8340.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 03:12:21 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:12:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 00/15]  arm64: dts: imx8m-evk: misc dts update 
Date:   Mon, 24 Oct 2022 11:13:36 +0800
Message-Id: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM9PR04MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 86965a20-8963-4c2d-a316-08dab56d90ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUipuTMXzkGgYObKhjMWRYDEiDLYU/vgI+XCORB6MfhoRlkr0grpFBcV/jyXrvYJoziCE9kdGjeG1XgBea4Yh51D/hIbc3/m+yZUbNKR2CxK9yGvJHxNWj7p0hXW/3qki6fM3EYvlKfS/KXjGYQONbKcdzfv1dbADqQurq6N5fCPT0Rgf0K7Tkq8jjRi2wEKDNTBSQTCyzWHPShi0IytiogrEFXfv6m6EZYSP+WZiJq9xCe9FIJ46IGBqyf2xf4BPSyn1rUE73MkvfT5kNHmWttB2LnSK9RcW7jBoxxIXKkfIC7Wq8FesJnCsDCJz7yIVl9XaPnR4q+dvx/acpqA3B/2EM9JeTueXmqlhErKguqKkSeDnjEmszMQ8n/dfWsfDbceCQhc73YvJ4Sq6cWrTBvSciIwWMHc5vcqNd+tzRmxupD3Z/2P+0p7qI6xy7cv3V7tPVnnsgdiscJqoJ5siNrkCRP4N7p7+CopasIpvz4LRQW5ABIMBVsLZJQi9DAZX9XlZf07quymVIKm74dkSrqVrc6xktYE04O3swXgvDcA28aBO81AuFaQ44M3lPh+xPe5dps8MOU91HIuTUC3/lgvZyEm30zk/eArBT3oldixKk6rUhCPqKa9j/KwtmQbsfp+l0Rlh1u0vv/jE6MbkMNFsdVPDOglBUb66IGEF47k38QShqaS1IHduMZUi9DKCOvY0gnGdN4XZ1HvRR1yyiGd8SjJRKLqVT4nNXIPo/9Q4wg9uyil9RUxilZSm7JzZwZinRkrNg7AUnlpOz9+EJBj/1EB92fDGsrohOlv63X9NahwEA/dJsBVuQ3x+nuT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(2906002)(15650500001)(41300700001)(52116002)(83380400001)(86362001)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(5660300002)(1076003)(186003)(4743002)(2616005)(6512007)(26005)(966005)(6486002)(478600001)(6506007)(38100700002)(38350700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTFuTmI3clVINzZvckQxRTdhYUY4SjVmenZPcWlLd1hsU2pIOGQ1bWg4aE1h?=
 =?utf-8?B?ZExmL0U1ekxPdjlZalRhQU9MbnhWa2FaWitkS3RHMWVBczk3VmFzeExxSHlT?=
 =?utf-8?B?ajRKQ2l1eEFQTlhJcWJEaEx3MWE1ZWRja2IrSGtBWGRJMTA1amxkTU83WXRK?=
 =?utf-8?B?YlRXekE0U3V1YW01dTBoSGNxRzg0T3NReGw0OUVUa2dpWHdTTFp2QTF2Nzhi?=
 =?utf-8?B?UzFNREVhWVBkaHcyWTdidmRyRFRTM0taMVdFM3JrallPbFY1ck9qVXg1Uk9I?=
 =?utf-8?B?MGYyR251cnFVUmFuaVkvVm01WUw3RFVpaUczU0Q0YU9ZUXhRM3JQeFkyRVI3?=
 =?utf-8?B?UE9yR0dJU3VwYzR3OHJ5cERTT2NRbEdHVEZXSDJWRjZEYmFWR0c4ZEhIdmtw?=
 =?utf-8?B?YU9mNktHK0l1TFJ3VlJ4VktwTllNMjdOcjdVVUpWbk5reFRSZGJiNVEzQ0J4?=
 =?utf-8?B?WW1ZVGw5c0tGVmo5NnB0TzNxR1hYdGlRUS9xdVVaS2ZsTmsramNTZ0JBMUsr?=
 =?utf-8?B?Szlhc215ZHFndUtMNmxGNmRmZVNRZEJxOWdxOXNEbFlqL2VGQzkxWDdyRWtk?=
 =?utf-8?B?Wlhxbkd4RlYvN09kQ1VzUitsWDlBc3lZV0FhY3lqd3NubGFXekc3aUNDK0FR?=
 =?utf-8?B?Yk9GWmY4d1g3RVhFMWhURmFDdUQ3VUxNNjNRbmNWeGhZSEhRYWl0WU9iSkZp?=
 =?utf-8?B?V1RXdzF0aExwN1NlOUlFQWpsTkpJa0dRVmFqNStHTHJycmdFcWQxUG5EelJE?=
 =?utf-8?B?bzBObDZ1QjFIV09Ha0txQnVMd3hHQVpZdFJuYXk0L0NJbW4zeks0dGtiKzJ3?=
 =?utf-8?B?Z0d3cldmdjFETE9Hb1RlcDFVbVF2UG9WaFVyWC8yQ3k4MDdwcnlCRDBQaUZn?=
 =?utf-8?B?Z2tZM1ByQ3UzNVMxcGpPR3BVbTU0YkNmMkhhSlp6TWFxazFKL2JIQW55ekJK?=
 =?utf-8?B?R09ueDRFRElPUUt0UnZYeUQ1Zmc4RENNRENPUWJIR2ZFQTVxd2VIS3RzYTZH?=
 =?utf-8?B?MkNCQkJvZkJ6MVpQcUF6VGV2NDlxa2V6MXZJd3BIbjRMN1A0eXp1NjFGNDFQ?=
 =?utf-8?B?K1NrWkM0YmFBOU0vMHNGOGtmMVV4U0VYL2hwS2ZBNXlHS3pKVTZBWC9aZWtX?=
 =?utf-8?B?bUM0aVh2UE5ZdWo5andUU2U0UHFTRjRScFY5eFFrZ0JRMVQxVFFoc3JFdHo1?=
 =?utf-8?B?bzNWd0VvUUVIV0p6Rk1xM2dIVjdUWEJhRUNIZUNDQkJDTkwwbXpvOUV1ZUk1?=
 =?utf-8?B?ZUdvSTJ2NTVjd3hEaVdxRTNneU9aZ0tNOVk0UHlBcTBHb0c4Wll0emlrbis1?=
 =?utf-8?B?Tmh6UFZ0Z0x2Q0psdmM2STgyMXhYUHUxakNRaE1idzR6MkQ2L09HWjJRQ2hY?=
 =?utf-8?B?YmovSndkdEhDZUJXWmxCclNQbHo0NG5VMWdia1c5MlJpRnJYNlcwY2VHclJL?=
 =?utf-8?B?VmorV3RRV2l6R3JwTmRZU1VocFhaZWVWZWV3ZjY4SXRsZFhRY1JneUlYKy9n?=
 =?utf-8?B?cTRoaEtadmxmL3EyWWVaU0V5SitzU2JDZDlXQVlMSHpLOVo1OXdnT0Vucy92?=
 =?utf-8?B?UkJFVVMybE5vS1VrYjI5a3BkcDRkeFZKS1JobTVNV3VJY0Y1SkZhd2VGVFM5?=
 =?utf-8?B?eEV0cEFiNXVvbWhnbGs3WmhhRG9CNVNXVWNaTmxNQXNQbkpPMjVaYWlWVXl6?=
 =?utf-8?B?K2lHTkZGSUhIS2w3VGFaN3M3WnEyRW05UncwUHE5QytSZ2N3K3dNczNTbm41?=
 =?utf-8?B?bThoUDlkNlhaTUh6QzZFVnZ4TlVVQ0lSWWQrZG1KNlFGdG9wNVJYSDZnRDNV?=
 =?utf-8?B?VGF6aWxMQXE2T1JWVFdBSEtuSXhGZzYxa1NjMUVMaGdyR2tsWlVYN2I1U3hi?=
 =?utf-8?B?WlYxQUlXV1ZPanhobzFCcCtFQUdMQzlTbzBEazFnSlZ4TEl1Z1BoTU1kdEF6?=
 =?utf-8?B?Z2FjYmZCMUg2Q2RRUi82SjIrcGVmQ3NBVzJJM0ZLb3J5bGJNMHhFV2hQd01o?=
 =?utf-8?B?OFdENlUxb0c5LzdRYlcydHhMS2lxSGVyK0o0aE1EdjRQTlBNMHllYW5hZk5R?=
 =?utf-8?B?L1lmWVJkbDVVazRsUHNWOEVORitteHdKV3RtZmpZTVRwUGRYMjRNU251ZEFi?=
 =?utf-8?Q?Tjho57MsZ6qvhUsGie6YmXfAy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86965a20-8963-4c2d-a316-08dab56d90ae
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:12:21.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HHXG+DPolRR9d4bikzrQRbGbSMwwY3Yf8rS44DUg6jv66S+8Rv2V+YoYk1eFfquZDg8B3XDkSC0rxxhsKCmzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8340
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
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
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 161 ++++++++++++++++--
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |   8 +
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |   1 +
 7 files changed, 329 insertions(+), 21 deletions(-)

-- 
2.37.1

