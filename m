Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3426C00FE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCSLuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCSLuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:50:00 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF5C1C7EB;
        Sun, 19 Mar 2023 04:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiM5gOCIxlEPGOGXZwOB4pBMO3UFEccY1p+JNc5sHme13m9nnZ+XIxST5jo4PqYYdxlsYIxnbVHPmRaiHQ5IHoxRp6qui5gQMgpMU6b20RRAPHR7ZML5Dv1aJ7n2Xs8E8XOmMMmbVHbxPuAkBRLeAWhPa6I+MngHolJhJ549ZQ8jNKWuZoPVbXv6V/Qroc2318v5C4MrzlNSj7lMnznX3WIx55NZIMlJwTIu51SLr88FYNljC+DEXuYGKLMeMItFMYTUnbM0jvHVy/j71UffUwj9hEpW13NCUUUYH5VcWL1iJEa7Gq0DEzJVivOpcKe8iFNVC+GtTIlElJ86uVmj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWrpeklBnWQNHjvke3oWhBngpO5L3at8wWpI4ANoASA=;
 b=FfZ94qLfNg+7R5IBowqe4hTWEfLLzHMDzNKd/MW0boZkpkBt/9ZcM8cGr4/TnD4AigpIfLJD97DNH1Pg5oRaGpLJhyP26gT3kSaqC/PzTxkcnQUeugvZDDkTvFBtD53czqyteI3/2u7etBWZtaqcJXkL+xRoOXnUgXMlRt2rRnQ7Nratu3WMz4HId0eqhvbWiKgmqIruIqRdlot2uyRkNVXec26HmNS+Y3ZTcqjG/F3khkW6cXhbghUn39JFm7TyZ+D0ZixSjd8cQnUmNpAJaF3Wr8Y3/Hxf640U6MeI+3Ov3SQr9iG5pGeKtxSgihKsDqNIANl7yBz0jkJIPy2zPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWrpeklBnWQNHjvke3oWhBngpO5L3at8wWpI4ANoASA=;
 b=Torb0EkM5vk9LYR/BD7AANSku428PNbb1giJj2EQzdheGbdBu8UpygjX7o5OBvvc0g1GSDmgUv95QOu0o0dcdi6lVzWxT2QU03kpAkhRjPFI3jdGv3fF2cWgaZm4qHpAcS+WiBw9pThsF4Eh6fIheFThC4KVyguoch3VofeQbes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB10075.eurprd04.prod.outlook.com (2603:10a6:800:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sun, 19 Mar
 2023 11:49:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 11:49:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 0/9] dt-bindings: usb: covert ci-hdrc-usb2/usbmisc-imx to yaml
Date:   Sun, 19 Mar 2023 19:54:47 +0800
Message-Id: <20230319115456.716969-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB10075:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c53b9d5-0adf-4313-3ba1-08db28700b49
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgiPtPInMM1sI+WVDPL2H9xWUW7wLU0jx31sxkffudD/GQusndChSzObuW+l7UFoK6l2Sn4xwUT+lK87dmaQgwxXx8F8rImya0xeRzy6DZY9u5/AUwyf70Obbsr+fH3gHEEPbNZVdhRhJnaWmG8jlhrNxlq5cSKU2LgGCWmxAQuKtx4AyzU6E6OKDY5k1mFD/RccZGYmWAxJM1nsTpESq0EknrxanTe3EdwTutIWHk6x7zoQDfT4t//sZmYcpUO6t/OC1PsSLtCTEckfxogJvm+V+2sW8+MiLwCvVmdUBAVj8fGVNnB937l3XI7rUIPUfkhR25k4jOW2h1Km3wXAu3+XnCoKzLQdQugMptOeLTCvUjqZBzNJlqYzj3ySWOYlHnqJbzfLwsP4leN9hAM4jJOEpFAuDG3sj3JGM9V/s6ht5LjqXpxbraFjpsHL6nKTc+E8NZA91kSemQdbxmegwfhs7TmNfuke9YL0f/yLEcgZ/CBcNMHFT1Lg7CHPTUN5yjB+u4Y2i54z3hqwxG6EmnYBRbsERQu6YuHk7DeIIJssqDvlOvgH5rEjWlzFVtw32pNEPVPMulItq/P3t5YPJVJXw1BN305keFwHAAReIi1IwyOHW35NCjYTW0dDIdvy9Er8MaQb2FS9WWp3bjaDTnZBFV37CwozXdqzp5khmbFqAY0Pw6U6fAfeNaIqt9Qoj4sH5IkhPVH+S/Azzgwzqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39850400004)(366004)(451199018)(86362001)(2616005)(186003)(1076003)(6506007)(6512007)(26005)(6666004)(38100700002)(38350700002)(2906002)(7416002)(8936002)(5660300002)(41300700001)(8676002)(6486002)(4326008)(478600001)(66556008)(66946007)(66476007)(316002)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+BNkDiip/e9PqSvx3BSwEJ5arHd17UIrX6y7b48AOQwJIzK7iwjP7frTuZeM?=
 =?us-ascii?Q?pT3fkWL74MfJexNBTvXY4j4JXLCgrHnQnZlPZCL/FcrWA/kZ5jnG+Qh7d4M5?=
 =?us-ascii?Q?iSffrTjJe1OPi2DDdAbwU868XjMIAwwHfWFDCtpzYo09olzoILqhDsCAAU+G?=
 =?us-ascii?Q?RptuZS6KKIrFmzxWCYH5nSNL5gUceSMzpk/4Q8m8RhnOLxGuExw0m897BObk?=
 =?us-ascii?Q?sY3U0fUS2h+VZ89WfQs7v2NRfQbzep8OTCqP96/OX8NJejP1dQEu+1lVTYf2?=
 =?us-ascii?Q?j7+Hbdg9ePWJ23hLkILhxsBOl4CQg9jF8DhGIjwnPfZpDz6R/9PbGS35EzOi?=
 =?us-ascii?Q?hO+iHjLcoTlav4CVkUBgWaVN6r7I8QMFHnd1wKi7OmAjDYUQqrbuBN0HsLUq?=
 =?us-ascii?Q?5JCjWYsqevU/4/IK5Z1eSHUKullePsYXBTHnSG24UDIj5hhcUTofK+YBxRSe?=
 =?us-ascii?Q?eVL5Anbf0w/RbnvtvWyGAIt886OqPqxv+n3rVy0h9Cxkw9i93BDdl2RE2zK2?=
 =?us-ascii?Q?SkIL262/55xRq+n7v0gIvKsnOuBn8RWP+4Mnx3tLuA34B46nF+j7ZnpAwSXC?=
 =?us-ascii?Q?sY1MEnVIxoY0xYqBGXE+Na4gLGx7m9DNOiLeYP4wswIivPSHFYbvox70pfds?=
 =?us-ascii?Q?t9XxYdBFMamAajvehtgbxsuihsbGv0n/HWvGZPc9VLH1zjnshQDVCXnbQaSp?=
 =?us-ascii?Q?mXyPu7EqyyGob172gRtfFJHMG/ZdmjjbM6qCW8USA/kuFMZd3k0MUyw8sY0J?=
 =?us-ascii?Q?oypN/9asWsoTwj/0sy55eYcjWZ9qw7yL1EdMAB/lHpVwmSgZm4Obhk5moOpF?=
 =?us-ascii?Q?9p9WQTc8EiGjALbZbnryTUgeWnRjlhd5Y0gSKtbO3LzPj8tl30dtt30pvi7B?=
 =?us-ascii?Q?hhNhq5UqhnuvGk5EXddEer9Gs0FiHJNVSPuLGm2HJxIA+oDyRX2Owclb+Wa0?=
 =?us-ascii?Q?SyTYvZxRVcWf4xqhYajH7q5Z7o+VeL8jehJmF+uBiN4O1dFdkO7HiC51iSu8?=
 =?us-ascii?Q?Kfbc4pljVfRFNSj4TEPAaP1RmrEzkz91dQjJvPDVCSWWx+XH7oruzmeHlA78?=
 =?us-ascii?Q?nptXtVnLsNrb2RU60DgnFN9DPta5qz+UAwx/foEqks4O4wuEL5fGolsSIb1Z?=
 =?us-ascii?Q?9Y7OpybZyP0Z120BZmgZHs9Ghx2cI3CNULDq/D6fIpMdeKiHGel5g1VwBjvm?=
 =?us-ascii?Q?y/EAuE48rbOS//i3cCl0i/Zgna5OoYt+MjYxT0GiqabQ4wAO5VFU7Qic98d7?=
 =?us-ascii?Q?3SwT2oPTF784vuysidAVHoNlWGpGbXPnaomrLLsB65gfyDMEsIzg8DO0QA46?=
 =?us-ascii?Q?lCUlRy5cGmMPLy7gqNSfYZozG+MGYJ5rDQ60sY/o0bPbPjnooVmBkFDCkTYk?=
 =?us-ascii?Q?e9Ae88YNt/hUet6+yCfjCsiJT3bfZeCUSTmr+d9YuFIjzeTmtwyZBCKUmfUC?=
 =?us-ascii?Q?lS44kLCIujCbErWCRBlnG5stFj1T3WTeFWFkJya4ZhuQifiukhbVDpYYdarm?=
 =?us-ascii?Q?0/roxTpeeo+zr/KVdeDNgV6R9dPfxgnyedoX179MME2Z7voWQO5vQft/Y+Lz?=
 =?us-ascii?Q?5V83HxBb+lhdwKggfPLkgKl6hYDzFbmQVvt3DZUp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c53b9d5-0adf-4313-3ba1-08db28700b49
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 11:49:49.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Shtcejh9+bMEhPdlbBQE6BooNTvsQyNrB7aXHZKVAJ7k9mMf55J+rh03Z6t6M/XgxODIUfagOFAcug2Hbhn1Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10075
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This is target for i.MX8M* System-Ready IR 2.0 Cert.

V5:
 Fix dt warning
 Add more properties that existed in dts and driver to address dtbs check error
 Update NXP device tree to follow compatible rule
 A few dtbs fix to NXP dtbs

V4:
 Merged V3 patch 1,2,3 into one patch
 Merged V3 patch 4,5,6 into one patch
 Added patch 3,4,5,6 for dts update
 Addressed Rob's comments to v3 patch 1, patch 4 for compatible, deprecated property

V3:
 Sorry for this long time delay for V3. I thought this should be V5, but actually
 I only posted two versions before.
 Add myself ad maintainer
 The major changes are in patch 4:
   Added some properties to address dtbs_check error, for qcom, fsl. But I still leave
   some properties not introduced, such as phy-select for qcom,
   nvidia,needs-double-reset operating-points-v2 for nvidia, which I would expect
   sub-soc maintainers continue on it.

 Add A-b from Rob
 Add a new patch 7

v2:
 patch order changed, usbmisc-imx moved to first
 Add Xu Yang as maintainer
 Typo fix
 Not define properties within if/then/else
 Set additionalProperties to false
 Drop duplicated compatibles
 Fix checkpatch issue
 For pinctrl-names: I think there is restrictin in allOf, so not list items
 Add fsl,usbmisc: ref
 Define items for mux-control-names
 Rename usbmisc-imx.yaml to fsl,usbmisc.yaml

 Hope I not miss any comments

 Note: there will still be dtbs_check failure if run with only a single patch,
 with this patchset applied, there is no related dtbs_check failure.


This patchset is to convert ci-hdrc-usb2 and usbmisc-imx to yaml format.
There are compatible strings not landed in binding doc, but in device tree,
so run dtbs_check on the single yaml conversion patch will report
dtbs_check failure. If apply the whole patchset, there will be no failure.




Peng Fan (9):
  dt-bindings: usb: usbmisc-imx: convert to DT schema
  dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format
  arm64: dts: imx8mn: update usb compatible
  arm64: dts: imx8mm: update usb compatible
  arm64: dts: imx8: update usb compatible
  arm64: dts: imx8dxl: update usb compatible
  arm64: dts: imx8dxl: drop #stream-id-cells for usb node
  arm64: dts: imx8-apalis-v1.1: drop ci-disable-lpm
  ARM64: dts: imx7ulp: update usb compatible

 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 159 -------
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 449 ++++++++++++++++++
 .../devicetree/bindings/usb/fsl,usbmisc.yaml  |  68 +++
 .../devicetree/bindings/usb/usbmisc-imx.txt   |  19 -
 arch/arm/boot/dts/imx7ulp.dtsi                |   5 +-
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  |   1 -
 .../boot/dts/freescale/imx8-ss-conn.dtsi      |   4 +-
 .../boot/dts/freescale/imx8dxl-ss-conn.dtsi   |   5 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  10 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |   5 +-
 10 files changed, 533 insertions(+), 192 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt

-- 
2.37.1

