Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABB2671977
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjARKpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjARKmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:42:52 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B03B3DD;
        Wed, 18 Jan 2023 01:47:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZmcKc+MbAJQu/a/BTor3PPhQ1rdwkQmKi6Uexb7ifYD8WGPIYPy8qfk59XoGicCBmkCMqpg4DfOmXfm7V2wumz40dRo8LeI5ps3pVdoUXPQ1vpjBlLUVjlW/EI9HGyshOUdNutou3k4TZRXCNcwCTcKEQ33wwv3oI8ZQZ3jSJ3s0GXXLMKWyCfUXJVwaNebPTUjGMv8t++TB8bqc3vkiRLemSI1VXDoDdeYFA6pW0Jtb51jic0GOGljcF9HhN79X63Tg+C1KiOtNGJOhDnmKE/B4h8dooX10zyp1CO8z8oqIszNW5Yvear1W5uVqB9zhCU7vwR2q1/mhgbYsy1XrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htUDlL2fUPZGlv4ttgLfQORbYnyLTRt3+p0zVomaxoI=;
 b=gLQRgTlQH/j1HAQkaEV7/VTXg/zmAUMoVjM6aRnJjM9aMpk+Q/Of6f1qROop2guu3JNOYqZvW5MuX9HMdrA3qyfgvFRlxN3GxJPLkaRb2Z2YpIWIQRYDMKqYWePQxVNmBwVs7NjEPuscvhISxKBDfqvFZrfTP1MAWGoun2/VLQSic4t8dfTwbtvIuzplRUzJREf9/yR4RUuYemibPxrWxf9rxWxXP3ONzT75nD+S3dS+BTo4zf6hI/dydVjoqvS1hC53BAfDL6gHnOMzUM4ljrLgtrLDoB5Drp1Ur2sO4qx7VasMplGCcEjEOvvuHee0jwa2lBZ8NAJ0NGpT2d9lqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htUDlL2fUPZGlv4ttgLfQORbYnyLTRt3+p0zVomaxoI=;
 b=5FAaQIxCZLlLg8q20ALao4IVrs/RUWrXvEE8x3j+UOhIIkGHn5jSqbiDJzZ8zBW73n6Fx6U1u++SvhLvbYtMXOlKwD77L0/An2q+yJkgWUoijWCwpWfhXy1sFgjsC4Xb7jFjmbRvAXXRn0Nvlj71KdYZal/dDmZTe1HA8qU9my12rybN7n+WgP2OyiPHb5AanAA4SumtSDJbM5sSTf5ZlWjG0AL4TV8fHaB8NuTTe+S5qmQpHuTZdIgeaqFyfuItFV83UbEp8aNmBAKHRcaVuPGC1j5qgTiFY713m/sJbwMf65PpwLOGWFh3rhs6JHtV1eVSMiiIbvwO3svndf7epA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 09:47:39 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f46b:8bec:aa6:b8a1]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::f46b:8bec:aa6:b8a1%5]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 09:47:39 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     Chester Lin <clin@suse.com>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v4 0/3] Add pinctrl support for S32 SoC family
Date:   Wed, 18 Jan 2023 17:47:25 +0800
Message-Id: <20230118094728.3814-1-clin@suse.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|PAXPR04MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 16638680-f4ab-4362-2d73-08daf9390914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKJnJEYvsF8MqM2rlrfno7V+CZ/VPz768DiBU6GzWrkhyownh5n8Rb9kAqhSMCj4Z7t6Nhh3E7/iAW6OPVTZbZDndSKtUk1+roAH+nqP5JjWFmvoMZh/PSUZlrr6PEGg+3e2PzlPsceRWOmPtdBgbVgnkfelFwEl8iCSyHzZ/QNu5NM9fCpnUyF/dR75oyTpBwYHBBTsg2bnn0tPghPuusr3qcWtpTM+emvUhhd2X9KJJx9umqy4dQCv6D3ai15j31wO6iN4iH2YbIQ3hxiTWtAIbyfJXaoS5pXvCF09xp31jNY31l1JZm0efEsIT9OMY5gRgWxDJy4I9Sqdho4a8dhnM0GpHL7/JmC8hs6IZnxGvdA3iU3/6786kFCHM+9yDU1LhKNHb7+E1Z0DvWReR6DdyoZr9su/tFU4jnVfQlbDJEArrhtbMWTcz/wgCAhAzjsdrPmFVn/hBnYhr8bn/GYN5tNrWXHYUGxFKdhX0A6tUaOPGP5jsw/EeN7qi2u8dm/xY2moAaMD8fhc0dS77nOXGmJf4TVoWQrprGKsJLyVQuA44z3UhVvEcL6M50HP5uECyXAGZZ0BnbNS5BJ75+RvTm+vn/08EtR0XayPE7aVvFJYCtL7njaFpXsopQdpnjEbff1ePxgVCEXvStXGwXJBJR10a7sDPlskmyWWR1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(6506007)(36756003)(478600001)(107886003)(6666004)(38100700002)(6486002)(8676002)(110136005)(66476007)(966005)(8936002)(66556008)(86362001)(316002)(4326008)(7416002)(41300700001)(5660300002)(54906003)(66946007)(2616005)(1076003)(2906002)(186003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2utqbiSeLIU21Gkk9bppqRWo/qi3FeZpAvJIMQmiXXL5IFakDdcsNK6UIosn?=
 =?us-ascii?Q?E8xaRdrFvDeT1Qi4PXJY9tjhpJSlTtmkGux2Cu15UuJr9nJ5aTX0c4CDhxKZ?=
 =?us-ascii?Q?LFSjW1DVrSoclTdiVEXqIMOdJ5zWL2D84230MeO1EBNx/x9vwch1OBhwi1LM?=
 =?us-ascii?Q?lN0Bv9F9lOLFkov5jqnMbKJucBY+Dc1K8HXM/bAudirImMzzGte/sqMFK4r2?=
 =?us-ascii?Q?KRfliQvRSkMbffJSyWAC83dMr8eWpxamq9Y8QAdtq5Os+7gWXp6joKqQfy86?=
 =?us-ascii?Q?ELo+B7LLb5jQ1zI66GMlmBVbFkH2O4F1Qwicyj0D2h+nGCv9nCpqpUUKWdLX?=
 =?us-ascii?Q?CVNqePI8LHNFl+url3qz3d5j8g4UUq1Sat1ZNzc3SivVu8EsgEu5qrow7moO?=
 =?us-ascii?Q?zDdllCBvUj8zldMaknwWigKPjt0WHbR+yFIXG8VLFP8sF3NapPmUe5vK4UXB?=
 =?us-ascii?Q?0t8MAmnW7jqW+O3yGSltaXIoqYjjJLtVa7RfqzCUd7lR8boMcifu0gzgXDhA?=
 =?us-ascii?Q?a9w5cngfCiLzeKqJCDoIqJJxJ/WrTPtamtOXmDZ5T1Flb14z0CNskjl/qxAa?=
 =?us-ascii?Q?lte6VXbvqMxANmq5Tcis7nlzhDSJ1sFtp044mPZ0MK2IM+te79qdv5rwuZnb?=
 =?us-ascii?Q?IkmHeslkqQj/DuFNGvUpzJIe5Sze4PaEatrp6ykc6zz107pRAOVM/G/hAQX7?=
 =?us-ascii?Q?cMK4mAra70DhBa4bnqS+mPGuLsGE3MsDO6FBHgs+Isu2tDFUkXehae6waIru?=
 =?us-ascii?Q?xF19+oVDDQfdfY4AfBsqBRyBK8+qGWMMqiEfa8Dh1wyKhrsxZFgWICzwLeI7?=
 =?us-ascii?Q?83quHDpup71MtBVgYxJ0F8qQH4KLhzGb7AbQkMfZ+wq3Ll5tXJu7xCZm1PX5?=
 =?us-ascii?Q?IoA6k7uQfEXib/ZAUWPz9fm25BER2THN5D9qQlWS2gqQvetmlYwkYKcmqKzB?=
 =?us-ascii?Q?PDScMnjqqkUistEKDyaPC7+zO1dZfAWKJE5XRl3FrqPgzYdGaqf367Ul0k38?=
 =?us-ascii?Q?YrJ5PweSzDQfx6RfIS+wiWmSBK1SB5q+n872WcorNzWVFFqWPM7EnIRJAZnk?=
 =?us-ascii?Q?Uig9ptAzq9sdsibPcBEJp6oJ7QXln5NrJ52f86FJ4syX3iFPblMZWVBtHcKv?=
 =?us-ascii?Q?IgC8vwXZV3DA4ibRX2D4z/W33hgdT+EC0p4BI0euJZ5aqcJvv3z57i1Un8v1?=
 =?us-ascii?Q?VS+LkDAPVlK/xShQyIqLm4tgP1qC4lUsgDYXo7mNhwOC9B4s+wE/zwL9gMyh?=
 =?us-ascii?Q?OOzEWGgdiscT0bYhjDHCtHrWswFF1c+5ufEaSAmn5WyCZccrWUVQyiK24vCC?=
 =?us-ascii?Q?B+P5n+uJRG+cchDcOlthBBqUPRlVBeewzZuIC3b9tR2Sjy4I7ZbKcuLChZQg?=
 =?us-ascii?Q?b3pDhMab5xO3+nkz4b5tZh8XHDwIWayQhy4sAlAvsr9zP+lHyJSl3IbbxzP5?=
 =?us-ascii?Q?Afh8RxjST/qN5QljCikuS+CKZcpqmi1PPHmhPCBhl29/6SiwjdXrrr7o/GYE?=
 =?us-ascii?Q?hFPkQb+L52vLli1l7qO29cJzJSVhICpY/tgF2scgkRfRPW5pXT2HkbmwJdKV?=
 =?us-ascii?Q?NkfkhUYdfkErKJfi9wE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16638680-f4ab-4362-2d73-08daf9390914
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 09:47:39.0240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ep5iRld+lfqAlXPr8bRIqXH3v7q5FuL2SEshoRpiXc2kTUJCHWMFOSa+XHGnMs9I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8829
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here I want to introduce a new patch series, which aims to support IOMUX
functions provided by SIUL2 [System Integration Unit Lite2] on S32 SoCs,
such as S32G2. This series is originally from NXP's implementation on
nxp-auto-linux repo[1] and it will be required by upstream kernel for
supporting a variety of devices on S32 SoCs which need to config PINMUXs,
such as PHYs and MAC controllers.

Thanks,
Chester

Changes in v4:
- dt-bindings:
  - Change the representation of available slew-rate DT values from
    register values to real frequencies.
- driver:
  - Add a mapping table for converting the slew rates to register
    settings.
  - Move driver files into an independent folder drivers/pinctrl/nxp
- Add a MAINTAINER patch.

Changes in v3:
- dt-bindings:
  - Remove the minItems from reg because there's no optional item for
    s32g2.
  - List supported properties of pinmux-node and pincfg-node and add more
    descriptions.
  - Adjust the location of "required:".
  - Fix descriptions and wordings.
  - Rename the yaml file to nxp,s32g2-siul2-pinctrl.yaml.
- Rename pinctrl-s32g.c to pinctrl-s32g2.c
- Adjust Kconfig options [menu-invisible] and names [S32G -> S32G2].
- Add .suppress_bind_attrs
- Drop the .remove callback and replace the module_platform_driver() call
  with builtin_platform_driver()

Changes in v2:
- Move the "nxp,pins" ID range information from DT to the driver.
- dt-bindings:
  - Fix schema issues.
  - Add descriptions for reg entries.
  - Revise the example.
- Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
- Fix the copyright format suggested by NXP.

[1] https://github.com/nxp-auto-linux/linux/tree/bsp35.0-5.15.73-rt

Chester Lin (3):
  dt-bindings: pinctrl: add schema for NXP S32 SoCs
  pinctrl: add NXP S32 SoC family support
  MAINTAINERS: Add NXP S32 pinctrl maintainer and reviewer

 .../pinctrl/nxp,s32g2-siul2-pinctrl.yaml      |  123 ++
 MAINTAINERS                                   |    8 +
 drivers/pinctrl/Kconfig                       |    1 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/nxp/Kconfig                   |   14 +
 drivers/pinctrl/nxp/Makefile                  |    4 +
 drivers/pinctrl/nxp/pinctrl-s32.h             |   76 ++
 drivers/pinctrl/nxp/pinctrl-s32cc.c           | 1004 +++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-s32g2.c           |  773 +++++++++++++
 9 files changed, 2004 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nxp/Kconfig
 create mode 100644 drivers/pinctrl/nxp/Makefile
 create mode 100644 drivers/pinctrl/nxp/pinctrl-s32.h
 create mode 100644 drivers/pinctrl/nxp/pinctrl-s32cc.c
 create mode 100644 drivers/pinctrl/nxp/pinctrl-s32g2.c

-- 
2.37.3

