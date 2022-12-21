Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6272E652D50
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiLUHc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiLUHcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:32:53 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC06320BD6;
        Tue, 20 Dec 2022 23:32:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8DijXH1ITfkfDN7gsimSpVZzLv2QDdTYix5Wvb/fISf0RETriHUhNpbAnBvn4AQF2KM5cLCHDsFSBiUWS/JCYkMbx1SaIDkByYknLGX2/uaSbNTnpN+qvK/5QS1jh3d1Crpc9DXOv7tf4TLOJztYDm5svAgVO4+VRbUZrS8AeUSv//DGGoNFIHAkWlxIzzAL1pCq8SV0nxdobsuJgYjY6l8VpQ230JbKXuvmZ6TVb6oFoxPDCUXwfRzrs0URa5sUxfBxaFjRkfHFFBnFmOpDZl9lMgMQzK05sLCdVKdowNoVzZ9mPFDoXQwsyEy8Gyo7QYzT2Z4Hh6+HvaXB0P+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZupERb9kGlftVhBB1DAPJc1cBskYrBt/iLqK1wJ8+Ps=;
 b=fjnM2ve8prLVVIoNRqp+YmVWbTalaDUTjwsLNNn8FbCJ3G2vckVVoSxaeg5ykdMBWjOI201AS4zREXhsZ9OGuZ9LcakjzImZnqpJSjFls1RD7m7vwaeMNgk5dRX4TsPjPgG4Er1IaUnefhMdUsFkOn4ryo4Z2+znyKaqhEgWOaU9KVaDFxT5tfVk4hZ7rdbeo4RSuihd1T2IRXTVuth4cD7RUxY/JiMb2iRJxznBn/3gJ5q2M5vXeODWTc1H+loEbZ45jC6OyXP7hajV4d4ZSRuy531PPbj81XQ4ookF619b3JxRNj3mgMiwLZNqk7JZgeb4waTnDp17Cd932tOseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZupERb9kGlftVhBB1DAPJc1cBskYrBt/iLqK1wJ8+Ps=;
 b=HyFawUy/ltAJfsGo/xwzcxj1FAoEdy2wcXBBdrst4y6Ssvc8MJcC9+vxSDNAciQ8qSDjuI4hOxMp/Vl3BEoer7YQRcBk6ajZE1YwK++giRqCuqE1caTiYEDwGIrQX1dQsgGPcAeuKpAemQKp3J7/xwDHV4HtvaUjiG1rcpykQRzcuNMV0ZHtYUYENwrT24dpL7yehA+KMn5aGsgd1TLVvRbVyaGLfObrz5dxafdt+6Sh+0VJyQa0ERSRZvZ24xEwScUAEq91oDgkT9LUgX+xBZj4J/x6V9V5LkPzqqWZxWMkcfg5aJjmPrkOyQ9XLL4QFXGYyXD28X04iLN7r/HNnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DU2PR04MB8917.eurprd04.prod.outlook.com (2603:10a6:10:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 07:32:48 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::9028:2d9e:dbd:b5c]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::9028:2d9e:dbd:b5c%7]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 07:32:48 +0000
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
Subject: [PATCH v3 0/2] Add pinctrl support for S32 SoC family
Date:   Wed, 21 Dec 2022 15:32:30 +0800
Message-Id: <20221221073232.21888-1-clin@suse.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0160.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::13) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DU2PR04MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a19deb-e6f3-4161-4370-08dae3258f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06EWLnzAz3EUEsZQB/WD+UQw3zvIhV9LjMlNVjkL4hnmG0Qljd4RmH8P5Z2Xl5E7tkC/GEkaIS7vljWMclvQOpIM+r4HlM8vNa6a6k7vAoTvjhUlPzLPqV776mDKu4hA8zmCTJ6UeKVsOWwebeg+5qJuPmb4rC3NOoI4pnLHMOW+xr8y7HmCBsc+V41DSgTd6CaxraduxhdG7tJds27iHbrEriqEHmp/zbD3KsvBwcokM9mH4h1k672hDU2Asj9vEnCf49JqoiEtRFz2msYYCSUfNf3BehVdTTwgjO0/LvB5OEpEeIt6HmattqJn8FrvK5+VOVKYeh5+gqVpFyDPZHHYoWZdWt+bGACTXitGphZW32sQ5/Hojm3THpC+BUxvv8OPYBh5PcTaJasKDkS4FQrKeGGQXB0m1PVl+0zzyWLbgm5MTrR9irXI3ZHt5ewbF3SdD87vwPgVZXME0nbhWvJ5n6UuUo/iVPHyzCxVfkDYBVQSGkrBuzlm7O20jVO7mYrBtLogMtyE+qY8ZEVJ+HMTCGiqxKdFLMJYMltpu1Cfjw/A3kdqTPXxOIMg9zjC1kP5VpjUS4d/7flUiJ5QvODk2x4iwxKeDFdBd2Lbk8buzR+9gBBa0oqV8Xf0lUH/gso7IKmWYjYJUXWNV6po4Vb6CI39RrGgf4OYgnnsZU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(38100700002)(36756003)(6666004)(86362001)(316002)(6512007)(54906003)(478600001)(6486002)(26005)(107886003)(966005)(5660300002)(6506007)(110136005)(8676002)(8936002)(7416002)(186003)(2906002)(66556008)(66946007)(1076003)(41300700001)(66476007)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7VM4Xq9OETheHm5JHjKor1QXxrUVI9JCxeP2IstE0ItlUy0iaidmImLf1+4W?=
 =?us-ascii?Q?2gZe4jPep4uW8P6HUovqO9Vmmrzm7DXA5MlXjIjdkjFVcp3qb2D56tCcBBMo?=
 =?us-ascii?Q?sXU+EvIERKw3r5i3y7KeVJ5mG+nrLRpw5vkYP8//AAhm6sDRgPjZ4rd4MDHC?=
 =?us-ascii?Q?eRl1G0k5ynsVDuacfgYg2CC6llagzO17j/HnRrQCk2EBKNxaxC+9jvtjkyz5?=
 =?us-ascii?Q?kLWzmhe4kwRgkOP5Wd7RpIZnXT8QwzKxpLdZBynUWqKUZg6NgC7ZTw/IhJW1?=
 =?us-ascii?Q?/1AWRBpSbMoViq/YfkcS+gItwRlVDIdxQej6zBYd9nBZly6/ShR+QqI86xpi?=
 =?us-ascii?Q?bOc58F3/0fE4+o+74K8dVDh4pDRZc0Ba0UsUE1C44xNrYR/NKbpPDXhNAfbT?=
 =?us-ascii?Q?dA4lzR1cWFiROv0GnV/GtmTq1Hjn76MjvmvJOqreoobYcqt8bWeJL0cJLZ2i?=
 =?us-ascii?Q?Nsz5Svciv9XfttejwivcSvi2in6hcEKSRWEjlUxcwuVQCFp5nnv1GfWHOXZF?=
 =?us-ascii?Q?P8hIZEkKQuSC91j+TCp87fiZTGGBVXjDL7ITtYc71sNTUQzK2jrjJrglUZDL?=
 =?us-ascii?Q?ycygJ+T27o/BHY94weCkswodk17Kx++KraNQgJuWAL4hFqAJHzYJMSRMUFOT?=
 =?us-ascii?Q?mmJtZEUkL2yYtGTVgSulY67ZFkOc78yffYN+jdyTcSydYT55h/+VFRSGggZa?=
 =?us-ascii?Q?rIO7VjbJZPR53GFhVAKEKBgkp475WVioOOIT2tCASvOjTqgFVeKnwWxJzaEd?=
 =?us-ascii?Q?lXdjq/ffaYfbiqA+LCG3rBL2FcqSOVL1Q2Wgk5nbY+CUTT+8jhntGJtzg7Pz?=
 =?us-ascii?Q?RoBk8fN43fcuHi4WYUj+i0YlnUyNgWcumnr4bpVhRptsAmES8o3bUhMoVGE6?=
 =?us-ascii?Q?WE6VI1fI4c9CJA9VyK1hceKJhE1bxRCn5I8R4+ejgFeUFwDwE8c98TKRkyAW?=
 =?us-ascii?Q?CYcI9nUVGnBi9aUoHbQB/iR5Phc9Y4/YXsFfsMLl+fjV6PByHHqDlz7VhArR?=
 =?us-ascii?Q?M7YnrfAScfxP1LzhO1lEKHhoWr0BQghS1v3TQG4q7zTfKCxfD6HQjxn8U3HW?=
 =?us-ascii?Q?lEP8y864MGUNN4ZZkW35Eq/ocGmdrE9gUB4vv/XFUKVap1QKnciAHr64YHm1?=
 =?us-ascii?Q?WmhDadDyXT/GqEa46ZL0Epl2ly9IzRVfFPdhCpRT+6zy/fc//SY47sQ9bTGi?=
 =?us-ascii?Q?6iiZaBJvWBHJ9vqE3RqaIm4Ua6HIS1bBMNC7AE7qaY/QJzlDqCufbzzwBb6F?=
 =?us-ascii?Q?FlAEyGsnt2n2fHxAiCjIvRhrHt8mfmizX+y/JREdTA1gAB5x+4gsVZFxh/jc?=
 =?us-ascii?Q?OwfF7+313GpA6UUJxtkWXSpgyAmk6DQQrrQbH9T2sKrCqKp1MvW8n64JxzNm?=
 =?us-ascii?Q?e628oiK/rjs2nZ6Soi+dv5pvjeoWKyVnCOnOkbmvg/ydN2wKeGrXDPZ0jtGr?=
 =?us-ascii?Q?N0fYNifVDHvcrTklM3Wdunc5vV6PhvfLPZToCnIjSnr1xdgYVWUxAUda6xL3?=
 =?us-ascii?Q?AzbSg5mZ7pVtmFcot2Lq55fkwYxUgJXhk7cOVr40PCx4jwd6ag/s0IOyxeeY?=
 =?us-ascii?Q?PADFFGON0a+iN7WJy2M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a19deb-e6f3-4161-4370-08dae3258f24
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 07:32:48.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnC1vf+BG4Wl7zoFIkwdppDZZWhlTtbRU9TCkvkAE8lXMTh89yPJ9YZDwbetKUO6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8917
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
CodeAurora[1] and it will be required by upstream kernel for supporting
a variety of devices on S32 SoCs which need to config PINMUXs, such as
PHYs and MAC controllers.

Thanks,
Chester

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

[1] https://source.codeaurora.org/external/autobsps32/linux/tree/drivers/pinctrl/freescale?h=bsp34.0-5.10.120-rt

Chester Lin (2):
  dt-bindings: pinctrl: add schema for NXP S32 SoCs
  pinctrl: add NXP S32 SoC family support

 .../pinctrl/nxp,s32g2-siul2-pinctrl.yaml      | 129 +++
 drivers/pinctrl/freescale/Kconfig             |  14 +
 drivers/pinctrl/freescale/Makefile            |   2 +
 drivers/pinctrl/freescale/pinctrl-s32.h       |  76 ++
 drivers/pinctrl/freescale/pinctrl-s32cc.c     | 983 ++++++++++++++++++
 drivers/pinctrl/freescale/pinctrl-s32g2.c     | 773 ++++++++++++++
 6 files changed, 1977 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
 create mode 100644 drivers/pinctrl/freescale/pinctrl-s32.h
 create mode 100644 drivers/pinctrl/freescale/pinctrl-s32cc.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-s32g2.c

-- 
2.37.3

