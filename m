Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFF862D776
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiKQJwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiKQJwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:52:43 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC181117C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:52:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0Bqp/MiCz7pW1ohNuR0/sW11E0OGsk5oXkcePnPbk+gY+Kh064ho8nBqhnhYY9EiPE/u1+xiuDTDFRvn6Z3aFIO0G2g/jPdZuBQP+evshcHwl0DIpH6EAnR4XAxGe9eBilWIE5ePhrIccHwGWlj7ApGisFmLCzZCVDA+Q14G07j6AbIj81Q2KKI71o8UzbRNrgd9Tm1EtA3eAnPJkNz9MjmyqeCAS1mpdVksgILSnXT6ikzDxt/MsU8ZZimvh1NGE1juxNxxISrBdeJKztHCFfFfbA9ZRjvTgevqMxRSvKAoDicp7ZtswIxgmx59fg8V3T/C+m96JLl440xkCSg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBQkpWoa8PhcHHIHOH+qzKBt7QsBkxfrd/JNPM32lXw=;
 b=j52NWZWffmhy3zEVO+GGPnieWjqHKTvVhldCH1pcGp+XGWX7/i4iTb5F3tb9Z3a4IjX3yjdLJ2i+NpjSFgYNP4WtRW2TXbqviXxf+E2eqOBM2ONS8VKB3AlNr+XEG8B2Ij1uxpeEHUXypdfP2H6ok5IFEz5jppe1Ei2+bCbQoe3GLScQvS4KjGL/P0h+SCq+nU/Kg/S89+E7cERzqv7a1rVIC+i05jdqNqj2haVB45Lou2j4c/G8cstXVyNDSupRhQzicHAzm5IOVdWc8a3uSZu5ukLktfTAruXYFncxbh0/YpSzrfw/N71fAaVmVotJcUuTHdauKnDsxsuj2fmz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBQkpWoa8PhcHHIHOH+qzKBt7QsBkxfrd/JNPM32lXw=;
 b=is92XoaFoWFP5S1/Ln7skYjpaMQ4PlJz48rIAKswX2kLIViWu0IG6/oxVnnrnhfSvUdfJRSI99NnAslAIp+uJpBkl5A59vX+/6b2KYGNs7MM8/THogO8fHx3RIA4KM5GRHLB6PXHE+CHmFudHMKyza/35VY6tqPuuaDlRvgp1vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Thu, 17 Nov
 2022 09:52:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:52:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 00/12] arm64: dts: imx8m-evk: misc dts update
Date:   Thu, 17 Nov 2022 17:53:51 +0800
Message-Id: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dcebb12-5223-4ada-15f2-08dac88174fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjSIDJR1/LFxnwuF7yYx15c1u2JdlrKWud0j10tK33aYqend2srzVSPnhccx0FoxxjJA2hCjY5z/+1eY+fgN+DuHM7cl+XgPX4tSuH/XqXejjKxsD3pkFowJLmZsDJdgAzGr2NEdiCems6bOQkW7ieU1nf/g2Mj/GhjZXqe4xiIW+I42IRz9EYCFM9jM+31ua0qGKs+iYgfTGfI4bGUAfofstQO53zyzt09GXXZl1i/+O5iWQWuO+jJDtrXAOlsCxZyWMLMtLjiH2gc4ZxKiyKwhXz6/D4591gS43C1PczMPwTPXvaTrMKIlQT88o+S0OUmMnG1W6GTjJuoNBG0sgMIT9ix+F218xJ/krgiN0c2rhJlTJe5IZKDRQcbYnUkHd6mpdU4m6QkPJ2nPIs+f3TWgf2AL+BeimcnC+YhIMjmNBeuocAmdYww56gUKvn4r1mdw10pzuLxu4CYTVXhz5yrivyo6qcJwDfwo5LZc8CvhhAYgG/lhOlt5ovrMv/+WDvA3JhbJUOMRVtMV/hIPQak7hVfVDl/l6BeEdily9OO52U82IBGz/ce7YHMw0U9CIdHEkI6GQVl/HXVJtKPuObYtGEf3gJNpqPYuLxTRkum4Rig9QXDcOia0dXvJ8MYG028AdtiWshP6IEA+jzrHNvyk3Q4HW5jg+yI6LpCDq+MpybRLdmWAIZVABv6Zmh6fNatW5siA851Y9XY682l5GrXe9Cz5uZD0tznkU7Kk2H4FNqI2ocMzqsjbt4HmlWvl0Vf0UxUhhbJ5zkpZhwAJpse+pLBieYSC9i+RerRrMX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(83380400001)(86362001)(38350700002)(38100700002)(8936002)(2906002)(15650500001)(4326008)(66946007)(66556008)(66476007)(8676002)(41300700001)(5660300002)(52116002)(6666004)(6512007)(6506007)(26005)(2616005)(186003)(1076003)(316002)(478600001)(6486002)(966005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CBZEaAooAEi0qoEnNaOnoP0wXkGU5H32jsp0C0G2RadKaCB4y8NOOYVdqABn?=
 =?us-ascii?Q?qqhxG3pKQrrf8L2ZC6odtkTgH53AKXMWHTMRYlUdS6A8Ic1Vc5uOPereXZA9?=
 =?us-ascii?Q?sQzbp6OYsH5IKMliKSY0iGlyWje4JmlsJEQ86QIj4EEZsMHMEW1z5ZFiCe02?=
 =?us-ascii?Q?tgyPTPCHxdNtRs3wwjHieOoxoeD6CAeGvdNRodlYvQ/bLF3AtYWeqOuexz/R?=
 =?us-ascii?Q?TNo8cEuyMR7WSH3hh89E2LLQtkw4FzF9LxmgAW0RM9G1xIl25Fal0CufFSz7?=
 =?us-ascii?Q?a80lPyDguELbI3M504nGsEYHilCKTTT4WeLV3heCHJzMyBgeCFFDPnl+M0bg?=
 =?us-ascii?Q?f8Lof9geIvMeKYKu4gcs5rjZFspxuhsDd547WN75rb39HucvvtAXAc784Puo?=
 =?us-ascii?Q?gwuNw5J6SXsbwQMMP0cDdb79JhI7sUZ9W1k7zJbqBO4JjXB9tOJV4GQPe23U?=
 =?us-ascii?Q?9Cv8wNXoTyC77qTSXS4UmwG8uM8YmWaF39rlyrZsum2tn5kYVWzBLnDI2c2w?=
 =?us-ascii?Q?tC7RgkTWKhxuaNjExTges/HkHBl0UeXpnakDDuIWf6tZtshNVdgASGKcBMyy?=
 =?us-ascii?Q?VoSEHY5Z+rUBotFBZoeHqpHNLssq7wq0u6b9vRJoF1g8CxxY/9TqQBMpFbdK?=
 =?us-ascii?Q?0RYnWugawvDVorWUg7aTY4gIX+yjlBFd2jWnwhCbdd+r1wVPXyhH1j+8Yu1v?=
 =?us-ascii?Q?RA5BRlsRjCI+Yuoj5e4eFnxPnOSvPZTaT/JTpVQrDT4bZqgYefy60DziKfXY?=
 =?us-ascii?Q?m7xllp7AYRau/cMWP05apTPk9h1tvIbqqAecny1O6mW3E1MHtsKrCbSyTi66?=
 =?us-ascii?Q?NTdMxh2Ei1pbFIMsSUTOb3AC5xc0czIUa/LJ05nkPjEmvuDcFYf2BSjXTZyD?=
 =?us-ascii?Q?sLfP+iqplGmA7iRXWhAUMT+4XM77dkW9fdvS+cq7gxPjBZ1PPUNfTUglT3IZ?=
 =?us-ascii?Q?qoGI6fEdzb/oU8eLyiCq6dClR/jtEsyJavkLcNlJ0qyRTm71czp5xX7qiPzg?=
 =?us-ascii?Q?T92j8OkoBTUsWirbDTqY46M3WbmFii4CkVuFwY++7KbEmfuYs5krV2EuJPv4?=
 =?us-ascii?Q?Dwj5evOcxUofDZ8HtxIL4sMguvKnvOg+6Y1RsMRxbgQlDG0cN4CKj8B8ktcW?=
 =?us-ascii?Q?m+bdsno1TTO+LD4BfY71EEWbfYN69jKk+8YTqKW0DCI2jiaqns+HZ5nJ2rOr?=
 =?us-ascii?Q?EW53AeoMlK34t8vIbMDm7Q3fJ61Q6YS6ZgH83isuBgxxmjlpRdqqihmVDQQ/?=
 =?us-ascii?Q?u0u5ksW4gmPPHJzh63KHF2IsMK1yY+WU/V9u3vQqoHI8yabDRymOLC0NfOJ1?=
 =?us-ascii?Q?leckM2+6/6kPwfckC9jawwaNu9Bwo6H9S/o6PpzfC601sGTMAK70Ri8+Ip4q?=
 =?us-ascii?Q?bUykKf/CSWzxtuG6h+cuEsJOYZ5n7tjGp6FRiCRm1CV06ynDkT5VcW6G9hys?=
 =?us-ascii?Q?Ya/zUxReDVGhSsCdw+o3S3AOPG/vR6UQ+snlqWoQ5g89tVFj51uqAWZM117X?=
 =?us-ascii?Q?diTY5mvogGBInjmCGYVnpggH/mCa+Cap70PtPZXcTlS6EuHJbaHEBptOdajr?=
 =?us-ascii?Q?KHcXuM2nHzmPsnrFUQ8zncdpB86Wmn378IkLQVxI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcebb12-5223-4ada-15f2-08dac88174fa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:52:36.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5w5mhXJUfykhZ3oNstTw9TullFQ0z/punp12pMftBFBqkxukxUjFgKA0zGo/Ybfv6cdNHzsw0seuInPnzLyvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7702
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V6:
 Add R-b
 Drop nxp,dvs-run-voltage in patch 7

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
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts  |   3 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi |  43 ++++++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 117 +++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |   8 ++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |   1 +
 6 files changed, 167 insertions(+), 7 deletions(-)

-- 
2.37.1

