Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002F96C6D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjCWQci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjCWQcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:32:13 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898841BAC8;
        Thu, 23 Mar 2023 09:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSZXcvj0dwNVZ6HL1RYx93KZhMif9lpm/PQvl9XLH95Gxq0bMwENO/4UoyWvSHx8/16LK5kKyVAPnNdNUaSGkbW1ZPAeQqrawSTs6sHC2rTj0zF+XuoMP2HPRWhmUL/FwkcXX97lD59IPpUikK4XK74SepiJtyejTSNBjR1KBtot7w7H/84KEhgNiR3N+gHu4yfIcD4hu38mZt3OK7hjoCs+7vQJhru6WrXfv1IpcG/f1Gd2XXU7Mie/UvJsB2igSMQXr8/sDumESh3nOz19ztlvzlHQY6phDur33xVoenltnU9PrtSo9UTuWPNGGwJIZacEVPDBRQ1NXprSADBaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt3UEC/Lzh5M6uQRsBAfKb5MebsmqwGJsFWHDBSd++k=;
 b=XBRNq0f67gPvjiMAJlo4+s2Nm1Q8qHYKAIk2/zZVxJJEXoz8I9VbMYVetuhnUm5KX2v/EQcwr8YRVcTVub/Gx2bbKRLTFU1aBNbaDriiIijjCOeKpa8dDVL1PloTRpReq5mgBtG0U40r6LKZkekhKb34wJl8jyqb3O7A3bOVEUqkcItFsYv3GrNekvWprQlgrxHNDwKjs1KxflklXCvh424ZaAx5uzVWWCYUpBuKbp8jHxsfDu644LD7bYIWWiJFcVD4Bojc7IxUVEskasFOySE+95segjuigGtD8FrSVwbsEFweOn92qEHwmnogKENHIjPqB0H0Lf0BoZuhQk79Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt3UEC/Lzh5M6uQRsBAfKb5MebsmqwGJsFWHDBSd++k=;
 b=nic9fBzWURywRwaCs8dyQrbKlt/0Uf0bNi9OKTBpuadzBBJ3DWwKiPVqXtbYIc/lFnLcl3tt9tNLue2WuHfsAELEsdZLG53k745nj2u/DkQFpuVsIQVEiMkxRCHr6W1hb1ZI/3bh2kC2u9CKhg0qoS4WaROqHRnZYww2rIU33kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7789.eurprd04.prod.outlook.com (2603:10a6:102:c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 16:31:36 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 16:31:36 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v4 0/3] dts: imx8qxp add cdns usb3 port
Date:   Thu, 23 Mar 2023 12:31:13 -0400
Message-Id: <20230323163116.2921999-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 981f04dc-0e71-47d6-22e9-08db2bbc1242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zw5fzyshSPXS8CsDMMFER0zqnJEG1RCxvsCJ2Yo9B8AR+4P2e+Zfa4PySmXW7A1zZ8be6E6l6MUbNy6hto7MiLRVOfeFAP3LpTfo7cjrE4KeVlnkSo8n4NcN2jlDYwqcpbJzNGyjmOlIrhQziVdz6Gnz4TcyC1GMUJI7YWUKxVAiDnTyvs4782eSyAX4QyMVeOqa4TJALajs982NHbe+Yy07tepJe7clEcuz7Wj6HFzj7beZwNqB1iW9gxC1siT6CVodDnD3k+g/GHEQBZAL/Syt2Q7whIiMBLCdPzXtMetA3dQLqgUV4kJ8eSzGtdbfH0FxcQetntzydlgAAKX1yx95n1eogJpIYEzCFOj5gx3argeiITxMrVDYA4ZPIPfO9hWRutHvvmej0FEyFtQ9jwItxzVpE90NdMLOtqui5l9fCD963WLJHdeyrFB8FDk622T+qRya835z5X+X0Vfrm5B/wjBsmqPHxinyzkkO+bOGSgkrTB+Y2xPa1TGBWNmlP94JfxHpzMIhYL6KqDVLtVhJEhXWqjfIeFxcAN4ziL4hvvy5o3CTDyVDkhX4lxsm5utIBV14lHuMuwrFBhZbjVqOL1RdxMU7729urkKVhPFrIFghwjnedqNmG5/4uRNdeFPxEwXj5AG5MV49XPm+GWdbciyCd2veIpPR6RNAq/dOMn0+4yVa2CA/Hl4UKvlXr3Pj7ZP/RTKdGYzDqSXwsWtIf+jRXfREByR1L6jmsHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199018)(38350700002)(8936002)(34206002)(66946007)(66476007)(66556008)(41300700001)(4326008)(86362001)(8676002)(36756003)(38100700002)(6512007)(6506007)(1076003)(26005)(2616005)(83380400001)(186003)(6666004)(52116002)(316002)(478600001)(6486002)(37006003)(2906002)(5660300002)(7416002)(4744005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YA4mZF8kSS22LyhkmXMf+sGMlHRu0Gz0Djwek6xxPXMdL8OEZIbEjr+wIX/W?=
 =?us-ascii?Q?vxwiFScB+hh+S/TEJOdjzNHASRSu9hoJxDcGknnWBSWn7wrV1EJI9Flbc1rw?=
 =?us-ascii?Q?X37CFoxSLI1Huz4K1v5vHzWs3tr4FSXbJw/pGBajuBLgZNTb3uxWBO12RsOZ?=
 =?us-ascii?Q?ssiCUzJGYRdKgy4/n4fAAgyXEwT1C5F1eQzZBRGhb7OGC5T2sigKbmRweIVC?=
 =?us-ascii?Q?6TORhH0IW16Ja3SLXUx4RjTKO2JydUVxPAYSPHSXpeX+lWm9+lShcHa5ycnC?=
 =?us-ascii?Q?gNBxnQ1sYAGMPwmhrVe3UoO0qGtAOQmJUg+M4P7r8MgUZPzGZ1bGuWTKIcZJ?=
 =?us-ascii?Q?dGvFUh6Wvgby3JtlWYvmgcKAmILotTYL0ctrbxq81kXEhyC0v4NNTIDJm5CN?=
 =?us-ascii?Q?lk9EWboklnklS7X7OuDAw2/FtgEZG06kaAGu64NNEkLGPimYQu7CqlcxHdA2?=
 =?us-ascii?Q?9CvHKztS3DLAVCYHopy+JjK+eLYgX/E0cz2mhFY94lLisZBDSA0t1Fp3ZiI3?=
 =?us-ascii?Q?3ieO5/N13NM5NK2a9YZkuFC5YuFJaA+Q+XupXuZa57KYvMTqm16LLotDFDe2?=
 =?us-ascii?Q?IgzQ19e2geRp1wjygHQ7kc7/c8wpeoUhnFIyj6UljZulSBnKKGicv5YxBqaV?=
 =?us-ascii?Q?of9h7NL3TCQgwFlwDMLnFx08jZlJZz/Ff0xyG/FGlwH/IwH3sJ9GgIpZNQED?=
 =?us-ascii?Q?4TdHUEhMCl0Y6KpS14gO8cOZZhMW998CwMALqlnpHtaeI6PQX9nW7gAPTtkq?=
 =?us-ascii?Q?4FsS1zMh+Y5K7iY4UD1egM6Sq1B/Jb12aMUDMPZJHKjB2ogJP2NoXMPeDOqZ?=
 =?us-ascii?Q?fQSTEuRnY1aZQ02A+D5DyjW6kVc42A31fKPZE7GpJ5XAXXh3QbpgTq14fwd0?=
 =?us-ascii?Q?maQTQCFwmzVeNPyTse0/vS4qwZuVmAUd2PZ8qEXEn0EwTPqIaI53BuwhVLFc?=
 =?us-ascii?Q?kQDcqhRBu5RPt5P7iOLnj2ko4Y3xUgi0xjpxF0ksWCBIz2aHhqgttP05swP6?=
 =?us-ascii?Q?GSzsTV1MN8az7v1QCehMTm6DnvVWtF+Ws3KFQzckbwM4F/s5zNWuzrdkTbG6?=
 =?us-ascii?Q?stCsiQO5k+CGFvEv9F+hqoX+XWUvhdLygZP5GKbIe81BUJTQPJ4l1XfOihtz?=
 =?us-ascii?Q?lD+czuKE7ExoO/YnBvYNbLYCUiprErpfU5a6tV6Pq35Cw6/TVG+7+yEQcTHF?=
 =?us-ascii?Q?2uKg0e7ldXeobFgKv0Xdqak30a0VcCV3rl7o5HKKaHzLoNOqVzmNHdIJmoWC?=
 =?us-ascii?Q?cew6ncn2EcfdrwoOgiMa8hYZmDji5zt+8icDTlkNCYW8CrSNdC63tHfMalNK?=
 =?us-ascii?Q?YSyFLDtw45J7kNRB209TuFZa5dIDhJfG7PUux9M5mxOG23uf/iZlkh2c/t8x?=
 =?us-ascii?Q?kAOFfWZhU5FCDSZVhhOvnaRjoN0sk6XIzxTdUMye7XXjhUypuL7EsraYKH7h?=
 =?us-ascii?Q?nVOt3IJkTWYkvLoGsgv7rQI7ozYcPLORgWjdNKCGkKP8IYufJ4+Pkd6i+glb?=
 =?us-ascii?Q?IrCr3BtjanfQTRrPueqD7LpwKShy0H3uugj86J9Zb9TAFDrU/meh28HRgwu+?=
 =?us-ascii?Q?cphC1Wmc1tyMkXkdHZjWWOJQIX4n6upj7uZU17+h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981f04dc-0e71-47d6-22e9-08db2bbc1242
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 16:31:36.6195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1+wJY2gfWoRKL+/8hQa4YGxu43qsTgeWl0eH8vULajRHRBdAdoOjNNGCON3JM5dA9V2Z4WbS5e/i7ln7jxrcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7789
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cdns driver code already upstreamed. but missed dts part.

Change from v3 to v4:
1. drop assign-clock in yaml

Change from v2 to v3:
1. drop fixed frequency clock binding

Change from v1 to v2:
1. Add binding docoument.
2. Fixed all shawn's comments

Frank Li (3):
  dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue layer
  arm64: dts: imx8qxp: add cadence usb3 support
  arm64: dts: freescale: imx8qxp-mek: enable cadence usb3

 .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 122 ++++++++++++++++++
 .../boot/dts/freescale/imx8-ss-conn.dtsi      |  72 +++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  85 ++++++++++++
 3 files changed, 279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml

-- 
2.34.1

