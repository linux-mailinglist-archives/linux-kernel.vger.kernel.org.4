Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78BB701669
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbjEMLc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjEMLc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:32:26 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2060.outbound.protection.outlook.com [40.107.222.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C17420F;
        Sat, 13 May 2023 04:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAbBX8B9IRcnMK25SgtZTMFSPLo5ySRgR8D4+lBQ3BmyYFIKnlU5gmv5Zo6IGaJHBSyscZbDSNBMyvUfCooRsgjqqb+i2mLnCR6FTnp/JxS9sbCdAHWjx3mV5S+2uGXipXPV0hdxsANq2+QjfxPUEgExO3mqwkdIjvMMMgHcqfeY8IKedX6WcGAaRGwqHylN6/eLFY6VSTjBZak4b5tqnKVnIcMfkdRkb/VxsN5HbeMuSv7zFMYEcs1XTBTlOQg92LFYJU+N4m2A/Gx+G/QJRjm8nImTW2F1s3RQhVXuo7hhzs6T91hLrckJ0kTcilKhzs37vyaEef8jqvDubEI8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93r2kEZoROPZKCoOvZf1VR2oqLZ7Bq7MnI/QGm1eSUY=;
 b=mXGhHVdw4T2ezKdBaeBT/XU7wyU6Gbjpt/mMg2INMX3tgQZoBMr5MpoAknsK95FHGCGyhhRif+rczpHAxRGb5M7YumXjOrb338xTineNkCramPDuHYioGerzDvjY2T8O1udYXQKM/Jh/6fcG6RJjSb9tOxcK+Gz/CrarL0fNQRwaPJLJvKFSt2MSXqCxc/WSHnZ1c9EU+ecQAgZVYM0WaxDmYq7UOoq4Tu3+XxZyi+bSkjj/pHhNfzEa0tqfJu/+gMoucaxxNJ3WzdBM4UPRaPV3cJFS4bkmwG0TnA9fmnPq9D0dJYJaj0mTvYLt6N0AGrf6mv88Urug0ZNTWbMcSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PNZPR01MB8378.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Sat, 13 May
 2023 11:32:18 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Sat, 13 May 2023
 11:32:18 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     krzysztof.kozlowski@linaro.org
Cc:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/3] arm64: dts: Add initial support for Emtop SoM & Baseboard
Date:   Sat, 13 May 2023 17:01:23 +0530
Message-Id: <20230513113133.1913736-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::7) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PNZPR01MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7aa361-5d07-4990-d184-08db53a5b544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUAbXlKhkKjM94FUaxGebGqtZwwXqD77Om7V7DBbvAL/3z+y9DwC0GbgnnJzEpIVqAV7P9Dcr5TGsWjmGjoq/Np0KgkDsMWMve5JmBYtyQD1AW7waJn4cHIE14/3rpYDhO7JbuZP1HmhqHn3FmcUPXp3MAUJXfZBfW8xy4tf/pndhDNxcLUGemxKFS68Z9wf0hGstAlW685dbpjfQkN+7jO5SDCO6ThCrzguEKDlUMNAAKLNtl47+k1WK+eW+Luo7wP7m3pXvWF2X91W4YIBdqdVUDHckfWh/Y1ilo11zwrmQOFePI+y3ZT5ebtXeVNY50BvNmv+RKn+NrjaKjGfYq848Owl8x/1CVfTDoaZKIF5Ne0yDZ9IvyGx7V5ZtlFb5VOiSfACE7oMYgmnVggFuIyQiil2F1l1sLSwgQHWVuFt1QIj9eLqq0Qa9kPVuH4xYFOVW6DIEBHtaSFOJsFcnjRk77CEuPfwGTAlbwDRlveXn3iDhPGQhREOoauVhjVfENOSzpbCl9A37wJrcZIteM4HFy9oW9SXSpF5Q5Kc3N9hNf9GsKJ0smTY2dptTSovJXhfjfcrbJhBgJDOlxSh1tDn8IIkIfoSy3Gb9TwIjWg9TclmlZbXpPCmxyEahB9/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(39830400003)(376002)(396003)(346002)(136003)(451199021)(2616005)(6506007)(1076003)(6512007)(26005)(83380400001)(186003)(36756003)(41300700001)(4326008)(66476007)(6916009)(66946007)(8936002)(66556008)(5660300002)(7416002)(44832011)(8676002)(316002)(86362001)(38350700002)(38100700002)(478600001)(54906003)(6666004)(2906002)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9agc/VjglFBrU6kPjHwVg7Tu9aRf3lAMfQuv7Rv5TgWER02s26zzDRbklWtP?=
 =?us-ascii?Q?LLV46klo7NPF4k657AemueKV1RYBssEBdeqXW3CUcVOzd062LqEAWHMMbfvO?=
 =?us-ascii?Q?JRwEbqTs2UYeRcMlW97VEc/+EKV5WFzUHK7zTy8SGrs9tfGz6pcPuRwsBbi3?=
 =?us-ascii?Q?QxdBkZ6k8fpZBuo4tjVnx572gvwdrxqyPkVt60PWKxqLRe/ICdA6KG42tm3J?=
 =?us-ascii?Q?fpe0JB1dln/zOnW6wYtlDKYjydkkkyg7N2oG93/DLVHivWkrPXsQ0JgNzxRn?=
 =?us-ascii?Q?l3Y2MeTSpIZUlFLb3ou5lBeOxnJ3D1WB2pb0WaHV6CIxf1ok3/HNena6YyHZ?=
 =?us-ascii?Q?4XeDJL40w5NMDsFlrMeaWRieeOtbdF2Ee2HY3cWm0HNy2iVMbltv5eCAt4xm?=
 =?us-ascii?Q?jERRKa3njAGjgWuTRwWOOkU9/gMiLujFPE2CCWOzfnKdUFz0L1850xZJR9Tb?=
 =?us-ascii?Q?cR5STwPeeQGQO3I5og04LMaQw1F8bywsJktXBlz2kyMn+HNozzP1mK3BtfMN?=
 =?us-ascii?Q?HNDr3KVhaJUleokDWVk5X5rn188ysHV3h8CsWxmr5QTfbouorFsoOAYSddjE?=
 =?us-ascii?Q?JbzOqHcuDo/+0DZKsHhkCAMS4MBMDDPYPzkSf+BklMa2FQf0EMWelmdPIf7Z?=
 =?us-ascii?Q?W9ZTPtauqpZlPewiDxzca1n35mDOSgUwQGOkJ5nDZWRYA7YTZ1YqhHYEF7dw?=
 =?us-ascii?Q?WydsZBQdXg0E1lAR4XknO99PABAuTQkHK899REkFJ+guSzREhZl+RAqzN64v?=
 =?us-ascii?Q?GJsxNs0Ymgv6ueYatdF2HnEjYPfYuaYcB3MxAKssrRDshdRSpDaDGskUxgNk?=
 =?us-ascii?Q?MUzgZsyo7XiKA+SCekcdM1xeRS8d+wGYZ4XKp0o583zPyf6pl/Fllg8pvE4x?=
 =?us-ascii?Q?dX+rOPRtU8ow+tIcKLrkCKtyRTHOwDm7jOGyS3nc+4oymw0Zgv2qQLPP28Vw?=
 =?us-ascii?Q?zOheZM8hqzxDtqI/1L8EgR5ft88wlx2MdZXgjeGTUKmgtReCvwlyqW969cqT?=
 =?us-ascii?Q?KeY9bj3Zu6a/d9ifBAKwSjnw9YWIg2D0wTJyyuPGxZ/5RxyY+1xkcP/5jOEi?=
 =?us-ascii?Q?mnRbtVa7MBEADDSp4c9Y40FC6PEdlgQ19kVtCRbHC9T0HnBIC/rXCJhueK8O?=
 =?us-ascii?Q?RURZ7cb28NxvKHig2E5UrXWFV6b/4eFLYWAYN4XBPhcbyJnviCMFIO5KmsmS?=
 =?us-ascii?Q?gwa4TGVrM+n7pjJNpyoaGJFj2EGbLU4TEs2CO/0qs612sPQsrTQKaqj7FOcG?=
 =?us-ascii?Q?w7Kn2fdHBuMx8OSL0QWd2E/1gC1QMv1C7g4sp1weon7D3jKaVAkJwwrArLEP?=
 =?us-ascii?Q?DdFUytujeqwHAD6YpneF//I/XwJ0onDbNvAxX/USgVlArAEnieef/7LKsBNK?=
 =?us-ascii?Q?VAOQ+P2lID4/Cimz9d6Rw20kefN3Qu7/eKbd+dEQ9dbJElHEmBZgT04GkaCR?=
 =?us-ascii?Q?VxVsgU3WE1IJaLtRuLKNvfOiTXjBaVJGwNqTbo7zMJBGAyW9SRL7saaGiPrv?=
 =?us-ascii?Q?n20JTGZEpLnpYFxbYO07hHiV50RVzKz+bixU4+6v//FEl+HJrQiTcVBi8GFT?=
 =?us-ascii?Q?CwmzDyVOFrPPwO7Uk7K7zl3iscFCrM81sO3sJKoLMLO7ynFo0QRRN+5aeWqW?=
 =?us-ascii?Q?k/vNHexgv3b5NQWS3Vnr8Gs=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7aa361-5d07-4990-d184-08db53a5b544
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 11:32:18.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Sg8h90MSVLAv7BsfCIC1nktQHmEKDHecod8if8bGnzbdNjVQFRir323Mmf8Q8bp9GkFfg4N0pPAyVCKYNT8t4+sF6YB73FuPNENJrVsKNRZ6SIS+sq9FkhVMjqoFRlm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB8378
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change in v2:
- in patch 1/3:
	- Update dtb add order in Makefile
	- Update proper prefix/name in dts
	- Removed stray blank line
	- Add pinctrl-names

- in patch 2/3:
	- Update bindings

Changes in v3:
- in patch 1/3:
	- Removed dead code
	- Fixed style and indentations

- in patch 3/3:
	- Update vendor prefix

Changes in v4:
- in patch 2/4:
	- Update SoM Name

- in patch 3/4:
	- Add Acked-by

Changes in v5:
- in patch 1/5:
	- Add device tree for Emtop SoM
	- Add device tree for Baseboard
	- Update grp suffix
	- Update alphabetical order of nodes
	- Update bindings

- in patch 2/5:
	- Add bindings for SoM
	- Update bindings for Emtop
	- Add bindings for Baseboard

-in patch 3/5:
	- Update proper vendor prefix


Himanshu Bhavani (3):
  arm64: dts: Add support for Emtop SoM & Baseboard
  dt-bindings: arm: fsl: Add Emtop SoM & Baseboard
  dt-bindings: vendor-prefixes: Add Emtop

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-emtop-baseboard.dts  |  15 +
 .../boot/dts/freescale/imx8mm-emtop-som.dtsi  | 261 ++++++++++++++++++
 5 files changed, 285 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi

-- 
2.25.1

