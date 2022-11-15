Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E3F629411
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKOJPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKOJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:15:46 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D7162D4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:15:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7AV4nhu5kBxkFuElDNPJOEJILXT8nmDfI3fIaUWCnsYfrHKaveuuNjfk0pmBcuyikajLNWUhnN9Ew8+v/+Mo5NKUSZXknwJbWw69Fhp2TrbGhzfFB8HS8UFKdXfFD9ztOFVbvY7Y4P3++Ayiv9lZyhIB13zI0T2+SylxrfM0uOZ0sApVdAYvmQ04RzLdUTZoAQBxfk+tNNG+yPwJase5YS2PGjVdv2tvGQ+ocQrEw8L201TC8cajHLVucs7aU3ntmPLDzXhXraHJC2E8U0y4iPcXdigcFNdjhvS6p4V8jkLhlxAd5SxKxeWg8pjd2wRtFMOZ3GFWIYwwXX2wXUvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uS2Auaonzq2ChwVRYzszdRN8N4z5HI3UgZqHxZZ36k=;
 b=SSsEl6NAezifU4hXvxebdiDnkj5+sQ7GbNWyhtfrTF/QR7+Duuzk0xEmcbfzIXIByNFqOJalY+tAAYIqhSQhivAaaOifnjxNQcyxDISrx6qGyO/LLXNtsh9P4HN/T1dEw5VAi0jFQwmcnKlh/zjbTH0v1cPld11vJeb5PkKZoAT45LeoHRwZaOdj6N3LHURfvkBFvQUnJG2mE73R1k5dOehkR+rbS7p/78BWmrVJCu0gs/x6QrjYIHizI2H6Dx3XvsSDe0u7nK3c7DP+gGM0IYGWmihI/VgidS2pYNHulrj12rRQMVvFNbjZL47uBqCFmCjsOKUXpwUJyLtTzwUPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uS2Auaonzq2ChwVRYzszdRN8N4z5HI3UgZqHxZZ36k=;
 b=bG5eK2aC9kDNj+ZhiKYLCUcaIVsDNzuvoR5D29cEq9/VKFhN839yhg4ZguEp5zaey7/lVtj1Dw/USqUPq9oc3fAswXZAQJydJfeXCo2Ua/ITMxSSBzo8GyFcjrYjCeNiPx+6trP5+erjj+KPzk29Ldauw13Vfm39uPJd51rVft0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 09:15:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:15:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 00/12]  arm64: dts: imx8m-evk: misc dts update
Date:   Tue, 15 Nov 2022 17:16:57 +0800
Message-Id: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 674bbca5-568c-4f00-4c07-08dac6e9f830
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hps+hQhF6M7hnwcw6gExUdDjCuptv3cd5PhE6cdiAmf8IhL2+Ve2rgfR8Mi7cHfiCyqf5m97n49pwOyZBUKye0KBf1bCtkB6ETxtnG+7bHluqMscsjtcLgrFNQjdFWVx3kdwX66E7qfTX8uxrUcxmlTkl//AKpA4TSP2R0YudMNmPw0DIOk+i6Nkz/yigFTrE60Qa1dTKIWWNxB5K3GDg/2rf+/hRVwgod9wxqggcgWJuG8YC0XnhM1+MwxjQiIdfmHsGGv1nGTFgX5dTu50jiPdWWtFCfXafZGCA0EmmuJtRWCAyFacAlyoj/WwVyPNHMuOmdnke1kziv/0fgczszuE5WRwUyf1sxNa3tmYujvqgyyoUHZVMAoVNdJQVYFGhF3o1h31ZjC4YtdfS8zy08kuZGNsj8xZezQEn8ePd7SXFWmSs3RPeLbBhLPXxGnuTVpFJvfFwgriHMUvaVivpONLfjii13SzgV3N+3lv3xkEKAtaM32sOHG2Zbkmp4c1rW7xztnvtGO1H0sV6Uw/o5Q5+chxHFO/WVG9JQO/nc0eEzUuBpUfWVwXkGToEKKHi+QMnuXrQ2zd2vvNFQHEXKN+HL7ywJyzoWZimJEm3yxXLpBEUaJze0qFsnjNwJwEhIHt/qTrhV5/JnDZFYL2chKI+stJeOMsm7XWHqLKDKDl29ndA/s02qN77RFbFkzEkOp4TB1TnVJy0Ey3NKxAOKjQXWReXnTqggSVGUOqOYueLyDaez442y37T3dYfEDW+FIiuf6gkBoERAePX/PCCgERHtJTZt+Dega9luDfPvOKHMs1BLxA3mH/4t8HHAZUO+ZufacJmGyQTMqYBaCXwrIv7ZGocXswXocNmfk1Mjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6512007)(52116002)(86362001)(38350700002)(38100700002)(1076003)(186003)(83380400001)(2616005)(2906002)(26005)(15650500001)(6506007)(8936002)(5660300002)(6666004)(478600001)(966005)(6486002)(66476007)(66946007)(316002)(66556008)(8676002)(41300700001)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikZXS7VxSJmTecf4zIcGzpH7uMp6JLESkz3U5JIz/r6y3mDegJlv4qYKdz2M?=
 =?us-ascii?Q?+UNgapUUXP8WEK4Prq2YdynR44CG18UU8cGAYzFqwu+IpPq3wrrVwaNqWcJg?=
 =?us-ascii?Q?wFTF3Sz8k/1P1DbGVtOW6jB0woUT+BCtlW8ivf+uW1p4dvK5vihBrDDxKZ10?=
 =?us-ascii?Q?hKl04btLT+6iWyXsxzSQoj2Mi9eOKMwlu7/FuSUJHyBvZT1aCbpxQzmXrgxF?=
 =?us-ascii?Q?NktYhHyUxR3bhgPYXJUSXgaSZbgukXLyXr2ju8TV8DPSU6r51rdFJPVqHBbq?=
 =?us-ascii?Q?nD1+Q+LETmhtN+bwEgGXIt3jmP15V5EsfbPlZ7sKmA6beklInHmZsQ3dnbyJ?=
 =?us-ascii?Q?fCbI9vFv6g5rUokc9bXCip3PB2gfKme184r6suG3bvOkOrCJxfOFmbxGQpga?=
 =?us-ascii?Q?NjIWUd92VpNMfakHZXNHmj7PBUzLsSZuK3paYRDSAwXU0+bbhqEgIDsAYNFA?=
 =?us-ascii?Q?n9JDz+VIyWiaXK3yQ/uJ5i3lSVcNKd1jAeHaB3JRgMYoDDiu6fY7CytTqrcj?=
 =?us-ascii?Q?er0ycGgRTcCz/WlVULE4Ur5uzko3GLUa5CD33spn3Gy2zlgvnxIspWxYY/42?=
 =?us-ascii?Q?BUV7eyQEujZBxE68qMvv2dnVWErS1RJ9pMcJEL8j6fC8KAFRY8DlATQHQz1U?=
 =?us-ascii?Q?tI2XpAD6SMa6Vpxi0hXvREj+fKD954aHaptmv9+Y8Pyk+ygEb73K3fVyiZjx?=
 =?us-ascii?Q?XtY5xsDd+iUthNOcJ4bHzOk6TJ+QlVFKvAqY1to/CeRrhhOInEN4nJai/6Du?=
 =?us-ascii?Q?eseZP6XaseRFFj9P+75g9JNRswY5v6Xcmrx66e8USjrrTBkG4RbiMQznFIn2?=
 =?us-ascii?Q?afpVO4JOw/XmQrdLP/QI2h+z0qj4X3egpt+TndIhwaBVQLFBeh5iDYPufJnM?=
 =?us-ascii?Q?+WyywM9n1wLHXR3brRV6G2g6gq74EXljl3RUh6lW3u0COkCA/WS3d+/pSC7o?=
 =?us-ascii?Q?ZoIOFiNamAfzDtDrBJjZxIyTOkzOrvZ3YTmVOAsRQNdpqNcXPVRX3oWrwqnR?=
 =?us-ascii?Q?B4KeqNeOh5MaVJDU5NysyN0krs4OvVy7LwWhFztsinWnLEKeB8dU5aYdiUwb?=
 =?us-ascii?Q?eFrs73RjTPKeGI8ekRwPhpd4lJnVJsWGBg3IJpGvXTe1Kd+Iezl1LLQP9f4G?=
 =?us-ascii?Q?UkhpgEArh67zRdui7wurmGbGm8PECRrR6sLF3aYuipBsBtZdLc6J2vEPJnfd?=
 =?us-ascii?Q?DYM04M3r+PeqiPtO9Wsad/o4LmjHxv2SqvuZOkMM3zxNt5Pj1vcWU3RXTfix?=
 =?us-ascii?Q?NFTg/27YSckbCSX/RIunL1bxAbkn5K3kx+3oU30BN9BgBJfrb8MnD9O9bQmB?=
 =?us-ascii?Q?7R71rQ3uPqRWKeN0bkWeim+SBqf/eCE2orWMdfqJHpyByPTCPhsgXnAsjSAP?=
 =?us-ascii?Q?7ty9+bKQyALe35iWhgQfMa03oFnFR8owfQ2CYt3JxI3RIYU8eO2UzoA+fios?=
 =?us-ascii?Q?fG+kbFGdClJhtYOXdQP2r1SvZSqzGPF2JOoHudv5oBjI+NUKJO9oOUnMH3dF?=
 =?us-ascii?Q?keOWChpF60yuM+F02UoXkrEJbOTGnjJoF/JGYAyFK+B+43seVgsC4GsrzLV3?=
 =?us-ascii?Q?7eO5atPfF6ZL2AUF3xFv9nKfT2LkgulG5zR87t1M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674bbca5-568c-4f00-4c07-08dac6e9f830
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:15:42.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RwceoscbSCcrm5ePVMUgM+5rYnI58uVOwTVrkIAU5YsOJM0D0hKgy+7zjAfFW4XI+d89urvNPMrl2R2hQy5eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V5:
 Drop patch v4 11, 12 which could added together with wlan support.

V4:
 Use mmc-pwrseq in patch 12
 
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

Peng Fan (8):
  arm64: dts: imx8mp: add mlmix power domain
  arm64: dts: imx8mp-evk: correct pcie pad settings
  arm64: dts: imx8mp-evk: enable uart1/3 ports
  arm64: dts: imx8mp-evk: enable I2C2 node
  arm64: dts: imx8mn-evk: update vdd_soc dvs voltage
  arm64: dts: imx8mn-evk: set off-on-delay-us in regulator
  arm64: dts: imx8mn-evk: add i2c gpio recovery settings
  arm64: dts: imx8mn-evk: enable uart1

 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |   2 +
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts  |   4 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi |  43 ++++++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 117 +++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |   8 ++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |   1 +
 6 files changed, 168 insertions(+), 7 deletions(-)

-- 
2.37.1

