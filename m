Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6829B7507D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjGLMNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjGLMNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:13:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41BABB;
        Wed, 12 Jul 2023 05:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5rWV/kcTz00KEXfx8lhunrrb6aPseAkm9essRQU6f776zeHIddNjWDkDwZo9W9vm/V/cJC48zo2c9EAhn0/O7DAfEPjlzpfMtGFwWWtR5EbHwhc7ePHotVshFNSN05Z6kR0hL7ZmBRAuKeAKOakcsFRH9k+i6vlQ87TGjtI1FXRGmUc0TiAW5vyo3V9FzT7E90fNM5uWs8RLTibH0EBlDMcikrF2BZbES/mZ+sqRngPYLsJytTJttAV+TaoaWK5R37scvGTPk1/bFkQfV90Z/ThVb7GEfOP6sABQ0METqF04OSY50MwA4ttD1UasqYVIuXmJ42enaXnjqhNSyyONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyyQrZ9pLdDuWacIjJAGMwAb3NYfiD5+yQxqpGNljYA=;
 b=e4AY+P3RbMuRMf0nnx2XE95iDgV/3WsG/dbS3z0cYiO6frBQDnEB7JZMKhhu28cybngr+jwgVQqGYH4tRHj7yCF87ZjW49SukXXRlOq1TyHWX41TZg42ZCPoSSMIwoh0lXlAR+rZisUejls/f2jRmqSwL/vWhAKLlOF1fadNnh/XFXYZ7QNzcw7oXV0FZj4Yk4EzDo8RkZCRlufwkIrIgdvZ+2MIh+iFeW+oUhAher7lxWECllbA9/SpsvUy61m8CKJg6NmA4tqBn3vxYU8ZJdzMOdcIpA8HeCJSbzO2brUbAUwWxj/u+tG+c2KLY8naDF4Q2qNhe2dGSO2HydsIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyyQrZ9pLdDuWacIjJAGMwAb3NYfiD5+yQxqpGNljYA=;
 b=PP7qQukNDY3BdLjrxSDxBeythUv76iFGM6Zb5MOatrpIv4k+bZkyHAnPrlJIsGxFBAX8YOsFFb44KDnnn16UDXmudQS3hZMVTBdHhoALn13SkW3MOlH2cRCjku6AjsB4pQtDkOpGSoDKZLlNAu3PQBTCNG1NjrWMa/hmpLL8z70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
 by PAWPR04MB9987.eurprd04.prod.outlook.com (2603:10a6:102:387::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 12:12:53 +0000
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec]) by PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec%3]) with mapi id 15.20.6544.024; Wed, 12 Jul 2023
 12:12:53 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v4 0/7] firmware: imx: NXP Edgelock Enclave MUAP Driver
Date:   Wed, 12 Jul 2023 17:42:12 +0530
Message-Id: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8638:EE_|PAWPR04MB9987:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c88f37-1b6d-489c-271b-08db82d151b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tB9lzqecaZatlQx5zYYhE15Gk6W7GIhdBY6D7tpcYq+h3t8ZBgnb7Cz6cBnWFEDi9DVhPZBCrrGe0jAmPXYiXXBhSqYd9uS2jpti8jIzZ/N9wVkWk+kUGfVndFWu81Z13EHgOcn3XgkseOjmFCPORqBrYTZfzIuh50w7x4sM0J4BVN8x9CHTj2Ht1TUowELq65VkqiVfWkyocbdWZgVmfG1qn+1tFrQT1O/xl2jEQv5i2offQgBlhu1O7/FPNorO5luupjFBCugDMAv5iRPk/B0LY7t4vPjpBlDiwC8mDzh0GmWqqT42upPHXgvKYtFl0Pi2UDiC5PRdGkvgKXqFqgdvq2E7pm04utsHvBECoTHv0BfEYN6CYZpfaeWcEcNFp85/578XuK3UeeiRehVSqITfRzVjWhCgR9xF6IF9szW+idF7lG0kMi9vz8+vwThzaQSUud17JPUFpknDBnvIDLKAhFemAeQ8Jlq772KBYTvH5alDVd0/5/a5NQ197mQ+Ud5WTqjQ926w3eg4rEtb8yJpeAilQ24ILhlknpRXpHvHPotBv+zn3gwcgPDg8R9Da3V6nh0AeVorGLH8PEDoaHQirZ4wWF76JgHsKPaCGBPyUO6uItE0Pg0ZdYZPjTEO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(7416002)(44832011)(6636002)(4326008)(66556008)(66476007)(66946007)(41300700001)(316002)(2906002)(478600001)(8676002)(8936002)(5660300002)(6666004)(6486002)(52116002)(6512007)(6506007)(1076003)(26005)(186003)(36756003)(83380400001)(38100700002)(921005)(38350700002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JEMwm+RA45XMH8fnae2PIAy29ybFvx9vG+z1a7XOrC3ZJbt4nHZ4FlZv1WEr?=
 =?us-ascii?Q?HM049d47advbUn2vfIy7MrytHTfh2L+PH6sSMHCbRZnDPJ3TId+jYm4wQaqt?=
 =?us-ascii?Q?cil3REdCYziOeDXPnw+dKS5U8Ay4VtZPrQdrK1K2m09rRS5Aml7lAhJjhTZK?=
 =?us-ascii?Q?pKi8GxrEN++sSkMekLNjvp7XSIICNJvpuO5yjttAlwszGw5CPvxYJcMjdiAy?=
 =?us-ascii?Q?VhdZt5kDk3r6uK6V75Yp4+CGK9UTJzDMd/crdcGJMp4lXTmlYMHVSOE/NxXd?=
 =?us-ascii?Q?5+iYuR5Agg0xzwJV8Je1+6jIq0A6isikFZYS73lqBipNWcjhwMidnp9cHIcb?=
 =?us-ascii?Q?76+k62qU7W8X6JDT6p5/bR+y0h2u8Ijfm+NZXkLZASaA2KH7hZr8bEnJD7h5?=
 =?us-ascii?Q?HUgSXwHErNQWJpdC+RZQel+uwbQimhmx4EuMa18pB+TIqBIRLGpsmrmdhIyc?=
 =?us-ascii?Q?x3W1Sz5RCHqgr/U2tPQUIzMa85TnSfL/0MvQX3pghyL06TQmO7JR529OktDA?=
 =?us-ascii?Q?4ICvWsfuQWyH6baHjbf8WsZzgV2zaxa6kwkA5OD6ij6/UTIdpXu6s1Uz/hbm?=
 =?us-ascii?Q?a4Z2q+s/abHiToLY8nEXnL7bulNIVgStG2fe3xKDqtSHKRzCYWuCJT0qy+1z?=
 =?us-ascii?Q?pqA10ihVPWJbA/eGXd9El9ZgwbrSM5Gl7V1GKPCKffIY+pLLGQ9EcDv1TwNM?=
 =?us-ascii?Q?3i7IqaPa7ivKhSI8MS8rsoNqPLZmv3XgNJPvgxzQLiifNaBBMsJyisWaH6gS?=
 =?us-ascii?Q?EVt8GfrGO0ikzB9qqnepjf1zZ/n/8OzKXxsEkeZ1s60XK/2PLlHSJkvB6MV4?=
 =?us-ascii?Q?PyFUE9e/Gguy2chgrCVig8X6BTqmCs6Oi4xvA6AsSFOQ3dj5h8rFa29akQoL?=
 =?us-ascii?Q?kIQrAlvvkSi8mGB66dEKZBRhBbCYHXfcQj3D9M/mcLH/KJfIKKa9TxA0obbI?=
 =?us-ascii?Q?+2gdV5U3mF3DpkAFFOE3f992Fcijmr2iRcvVuDBa9SqbiRHHOKNXKkjV8x6M?=
 =?us-ascii?Q?cVf/X6Awib2FdzxmC7+RdAEI5OD/gTFBm/kVovK1a5qGOilpH3Pt1SFXugOQ?=
 =?us-ascii?Q?FcCODjN1DZWcczMUMakEXLq/Kge2q0qviV1ESBtsAZp2qWw0B13VjwtaT41g?=
 =?us-ascii?Q?czf07/0KaBoLKGL/Zw8eDcuTNECdogiMI7SGwUU7j0uE5zFPpOFDW3qE/v8I?=
 =?us-ascii?Q?fp6D0YtT44eiAyadfAuaFkQkUdBJyosapRXE3daz52MBGJDLV0EbFkv1X91w?=
 =?us-ascii?Q?PEsKfSQdNiSnVZ854D6LD2sVQRzf2xV7utsks5V79s72cNVj3m0k0qSajR5Y?=
 =?us-ascii?Q?poybEgBlrK71K+VYiDrOpFhuKUGMuJdJMreQGgGsh5CS4y2NalHyR2j32nIr?=
 =?us-ascii?Q?TOM6A8zM2Ule2lqrpJ6RQooa0J0pSDS8GAmU8PK84Ko9pd9rCwqBNjn1INQk?=
 =?us-ascii?Q?NSvhMn3wPnjiNupUYMMGWXhh5yZMpJY3u/b7Bx3TYUznpKgp71ULMsEPr0/h?=
 =?us-ascii?Q?FmG+6nKJFqbcKEXxaCjPnh7hOCe9wQ6hc9eEuL98jPcfB6gPr3pmSz/j20dH?=
 =?us-ascii?Q?LiMFtGbCJFWnHWIFa4JMXSdsjvB3PbV4TomYosua?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c88f37-1b6d-489c-271b-08db82d151b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:12:53.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsgyqBN7prGo3N2WPKHamRtD9ZWOAtMtA7YAU/xI37tC/3SU65GZ7Y9+gIxHh3bx4YkRVSNHeH2TFdHDglW5kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9987
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4 Changes:
- Post internal review, changed the name from "ele-mu" to "se-fw".
- Disposed-off comments in the dt-binding file.
- Removed the non-hw related dt-bindings from the driver code.
- Corrected the File MAINTAINERS for correct name of yaml file.

v3 Changes:
- update the commit message for documentation.
- Fixed dt-binding checking error for file- fsl,ele_mu.yaml
- Coverity fixes in the ele_mu.c

v2 Changes:

- Fixed Kernel Test Bot issues.
- Removed ".../devicetree/bindings/mailbox/fsl,muap.txt"

v1:

The Messaging Unit module enables two processing elements within the SoC to
communicate and coordinate by passing messages (e.g., data, status and control)
through its interfaces.

The NXP i.MX EdgeLock Enclave Message Unit (ELE-MUAP) is specifically targeted
for use between application core and Edgelocke Enclave. It allows to send
messages to the EL Enclave using a shared mailbox.

Patch-set add the ELE-MU  kernel driver for exchanging messages with i.MX NXP
ELE IP; both from:
- User-Space Applications via character driver.
- Kernel-space, used by kernel management layers like DM-Crypt.

Pankaj Gupta (7):
  dt-bindings: arm: fsl: add se-fw binding doc
  arm64: dts: imx8ulp-evk: added nxp secure enclave firmware
  arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele_fw
    dma-range
  arm64: dts: imx93-11x11-evk: added nxp secure enclave fw
  arm64: dts: imx93-11x11-evk: reserved mem-ranges to constrain ele_fw
    dma-range
  firmware: imx: add driver for NXP EdgeLock Enclave
  MAINTAINERS: Added maintainer details

 .../bindings/arm/freescale/fsl,se-fw.yaml     |  121 ++
 MAINTAINERS                                   |   10 +
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts |   15 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |   12 +-
 .../boot/dts/freescale/imx93-11x11-evk.dts    |   15 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      |   11 +-
 drivers/firmware/imx/Kconfig                  |   12 +
 drivers/firmware/imx/Makefile                 |    2 +
 drivers/firmware/imx/ele_base_msg.c           |  372 +++++
 drivers/firmware/imx/ele_fw_api.c             |  112 ++
 drivers/firmware/imx/se_fw.c                  | 1443 +++++++++++++++++
 drivers/firmware/imx/se_fw.h                  |  180 ++
 include/linux/firmware/imx/ele_base_msg.h     |   62 +
 include/linux/firmware/imx/ele_fw_api.h       |   19 +
 include/linux/firmware/imx/ele_mu_ioctl.h     |   52 +
 15 files changed, 2436 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
 create mode 100644 drivers/firmware/imx/ele_base_msg.c
 create mode 100644 drivers/firmware/imx/ele_fw_api.c
 create mode 100644 drivers/firmware/imx/se_fw.c
 create mode 100644 drivers/firmware/imx/se_fw.h
 create mode 100644 include/linux/firmware/imx/ele_base_msg.h
 create mode 100644 include/linux/firmware/imx/ele_fw_api.h
 create mode 100644 include/linux/firmware/imx/ele_mu_ioctl.h

-- 
2.34.1

