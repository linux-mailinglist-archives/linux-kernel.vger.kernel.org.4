Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94936DDF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjDKPMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjDKPMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:12:08 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB025BB1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtfOQ/YjJzg0f8d02d8y6AC39pWbSIJXaJbIAAiijgowLa5oZLAExzKT+Vmv7vwo1T5lkQxzXT63kp9vhlSVeqSkBsxch3weRSlylwCN21WOUa+kNuGV4GlHVtCGom5KJWx9Wr0y3hweuDOXKPiV6WklSl/ueQOu4+QLD5XyKonRspkGrf7blWb8uCENnbMMVbMjqxsC+QRy9qxTxrf8aTRDrgFLnJGVQGE8hdSNTz75vhRxQFiA6S8nglZFika+u+DZ9SdTYGnGxlmbT2xqfNW+k2M7RC0lM+O4JHd3jG1TLyNKZnz1qfoisz9vFmpXcO5QFACK25OUsvM7X7x7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epOg+TaATSU9yswWrbY7l+uvP2X5RvFImlrNro8jRQs=;
 b=RpGUi8dHyHNXo4Oc/iaXGnKe+uJR/nwhAj5sEG4126Q9AjRRCox8xAw+vw1QUn70mhv5YQRcFzXF3HsNW2HLjPghL6tSPUZKOhrIiAaFVgQggv6iW3Yeuds7ufXPkp8soFuE47b0Ts9O2Q/NUw3lUSU1+4WD9+KpxSDUQA9HZWBZFa1aFcfnJIFHfXRKtkx7U9wZujtO2QAYdHxbR3MN4ECXb4viovEu0jV+Ihs4CLgsW/c4T3ly2R8VlGsAKCapaLQooeo0mTDj+2O/fhr8bwDlT40IcIKuWyq/EZsS33czsXJmar6IsAgUBg+Dz5WReIHN3YEONp+AUN94CiqZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epOg+TaATSU9yswWrbY7l+uvP2X5RvFImlrNro8jRQs=;
 b=mBXHjtHZIQOdAfTd9cRVptZ3ANk9d6MfcBsw6G2Bf2ieyCVGMHirDbEsDG9k1cznkPTU0Lx2OosZle6KO1C0XlcQm8w0R/TZHY/S/GYy8jWpZkaGH7Rd1yYtgyVu0eWrOYt1Gwms9mI2IigCDAT8oxFUAY6vbdb2ye/okj1qQ80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 15:11:35 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%8]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 15:11:35 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [NXP ELE-MUAP Driver 0/7] *** firmware: imx: NXP Edgelock Enclave MUAP Driver ***
Date:   Tue, 11 Apr 2023 21:55:29 +0530
Message-Id: <20230411162536.30604-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To AM9PR04MB8636.eurprd04.prod.outlook.com
 (2603:10a6:20b:43f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|VE1PR04MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 80778f1c-9906-41a6-4fb9-08db3a9f09e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUnpHS1MHHKo/q4pa2Po7lIWXi7BQw+4C+crM+KgQILO9i+tCEP07yfPh+OzXjC2GWUgWrDtHa0+AKTI6QdSfviT3z6ezSNr0HsSLKbaUx5mhtGuuQQKOY2Pbnvrn/44zNWtACD7Oi/9INiAifSbCTzjTTbtIIeOX9iI+oeZVu//3L2Phcn5OU+RByy+yCXKC2/iomaIz+w+n99/kz/Pn3o8WjVhghFH2+UyAX6wb2kbW0O6UpggWTOInYp2azg4w6bRtGyBr9SkVhiW5C2EzcR6kCu9pUY+Bfti6GgeWCU7/TfsRANV5upmKA87VwdZGxRDhg38clwqetFEiXxFsq0/gJv7J58MROxC1A06VxdU8q6fXW4HKQC8kxLo21PJsj7G/+un6GkDwJyW4Qf0bfEHVLt8CaAWHp6G6LFyLryFx/WGvVJW5RfufuMXtz+i3JRcwvR8K9A9dJvq6Qobj58eHkoJ5QDUOXeSPUhHieX+OWf/QXP8KMIQfbqVEgTiPs0bv4PqDvcZApaZ/eAVcSewdrg7NnvYqfk/2yjxoNYIodwxhGXhBva5miOo/gU8e1jOh+tr2gRXemH+yFH6yotaxHDUexmpAomYC7b8fEzzpNqJOPzayk8uwbQE/u+PTVQxSe2Tdrf/9KWt41zZTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(6486002)(478600001)(4326008)(52116002)(6636002)(8676002)(66946007)(66476007)(66556008)(41300700001)(316002)(86362001)(36756003)(83380400001)(2616005)(26005)(1076003)(6512007)(6506007)(6666004)(2906002)(8936002)(44832011)(5660300002)(38100700002)(38350700002)(186003)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7PruVFk7zJBl0on0OUt/zHeXQlSwusJEn+PV+SYA5IUMcONC3Ed3BoWujSjo?=
 =?us-ascii?Q?n+6n/hRw+FDXcnu538jmgr22kRj7mnQu+VtI9r4cH9fB74nRXCdLcK3VWI6e?=
 =?us-ascii?Q?8RBe7wa2ssAVecJAOheNTdl2HzV6x5G3rJ3vL1XK7q0bU7N5ywjwVae7Hbjb?=
 =?us-ascii?Q?f4YxtEXg9nhEObAL3YdHYdhW+fP5z2/f1BvoAP5FqU7Mma9Hzcjr14mBqeCo?=
 =?us-ascii?Q?M3zxU9X6aRMF2gRCADkyCsKcu7ql25JmMkxn1kpLTbTs0lif5LIe5xOh+A32?=
 =?us-ascii?Q?m/5lBoxYBMoEevip+OclSy++9Q5AHoihHrhFANg1RozjQlLOQ+pGIMqgG4lz?=
 =?us-ascii?Q?IvbxkWhLE2j6FdIKbsiTybE67RlGxb96xeADVhH353X3xVz/0mOPsPLBLRQo?=
 =?us-ascii?Q?8qB7okzbVhPZHKZZXRMZDTF0ljvjV0IkSlxZqdhjc/52Xhc4xCcqXtTQAYCL?=
 =?us-ascii?Q?prb+LtC8L0Gc2Ewj48iXpKk2z6RDkjvCCsFJUJgYgtmP12IJNMKMYnRW263J?=
 =?us-ascii?Q?UVeUS6L/o4TcabYubL6orYs7PRRdMMtdvp8lvvxnKmiw+H8VRbypY6IbxTNb?=
 =?us-ascii?Q?YKfxJPwzJvXM75W4tWvak0ub33eKjV4h9lrxdUBPu3hviCMqB5ouV+jHvk5O?=
 =?us-ascii?Q?L7f8RpgrmD6SPPgYJKpYQULf+V42xfRsvRpXZfnHeYUQlqsHA0DonIPgcYKb?=
 =?us-ascii?Q?Xm0eH8rnmwOA2QlCke6xZ/9zOnktt1CgUrhFeLSQJNYFYIDMtJwsswxfwc/G?=
 =?us-ascii?Q?DR9A+ESDHUxP3kjKIZpMEKqT7AhiY6qv7zVNVQv05b/CyCdgm6ZRENG4a/lo?=
 =?us-ascii?Q?epWVy+nSAObgu8oIt+1kT2nV14AKuPtqZK7G4q68qjDOOaO9u0q6Q7v86PF0?=
 =?us-ascii?Q?xRPQnGek8Fte22qtrjjzDylEdk0OwNoK1CTt1VBGjsag+u0tcNLNk3kHF4Va?=
 =?us-ascii?Q?pk82SqXK1u6FHWXqmnZVEMHUsHicldQi/8iROg2ssTyamQTM+hdWpooNcnkm?=
 =?us-ascii?Q?0IkawF0xgRK4UdT6Sd1JOh5XtX4KwAenjWqCop8CrbvoJCtbgKXD8rCKzy0S?=
 =?us-ascii?Q?9dabeeLA+SgBP5OY7x++/WuiHaNro34cxb7JMaOmsCkdLd/vkp1QRNIdreBH?=
 =?us-ascii?Q?73d47101DQxDgLEXCx56/0ehR6Vu6waWY/xI6jBYCIDRGBG8S5jAvcs/6AYm?=
 =?us-ascii?Q?trOMfXNlUjPmJYSLazogETxY68l3ut2cl0H8JSF6EznsV21tvqYEdyiVy0gJ?=
 =?us-ascii?Q?luJCiOa6tjjLmLNssX4vAFjDypDF0yvBQtTH2Vdd6w9eWVyD5P27K5f1NmhZ?=
 =?us-ascii?Q?zb+WpZrdFqfgzi1VBBenB8bjeoi+gr7SL3QImX6mcmBN30oLiDBOcR7haRrn?=
 =?us-ascii?Q?NmSWZCxHvobdvAu7RCr/b0jkj6hIF+OwnERNkhksr/mezGXLjahmsUm7kp6k?=
 =?us-ascii?Q?EHfo/YzGrOy6OAkH6tkOkvlNVT5bAwPLChTHmiOVfSdTGW0pQsFGBBEvwt2n?=
 =?us-ascii?Q?EpVJ5xWf2/lvScYFdRSfoCLvzP1GTTLD0JQLlQ957iLO9OkAWsKWlKQIjXb4?=
 =?us-ascii?Q?u+O/chbSAFQKoeKlAdUuTQTdY8CJCTI45chkrHKG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80778f1c-9906-41a6-4fb9-08db3a9f09e4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 15:11:34.9310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh/w+zuCTq9rY51qaoJWcngcZQF4mN2V8fwf3vNbUcjS1z77VbzoZVDnGe0Ra7SoY87hCjvPQUPEwqz4RL7EIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  doc: device tree binding addition for ele MU
  arm64: dts: imx93-11x11-evk: added ele-mu
  arm64: dts: imx93-11x11-evk: reserved mem-ranges to constrain ele-mu
    dma-range
  arm64: dts: imx8ulp-evk: added ele-mu
  arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele-mu
    dma-range
  firmware: imx: add ELE MU driver support
  MAINTAINERS: Added maintainer details

 .../bindings/arm/freescale/fsl,ele_mu.yaml    |   90 ++
 .../devicetree/bindings/mailbox/fsl,muap.txt  |   89 ++
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts |   15 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |   13 +-
 .../boot/dts/freescale/imx93-11x11-evk.dts    |   15 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      |   11 +-
 drivers/firmware/imx/Kconfig                  |   11 +
 drivers/firmware/imx/Makefile                 |    2 +
 drivers/firmware/imx/ele_base_msg.c           |  377 +++++
 drivers/firmware/imx/ele_mu.c                 | 1284 +++++++++++++++++
 drivers/firmware/imx/ele_mu.h                 |  174 +++
 include/linux/firmware/imx/ele_base_msg.h     |   66 +
 include/linux/firmware/imx/ele_mu_ioctl.h     |   52 +
 14 files changed, 2204 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,muap.txt
 create mode 100644 drivers/firmware/imx/ele_base_msg.c
 create mode 100644 drivers/firmware/imx/ele_mu.c
 create mode 100644 drivers/firmware/imx/ele_mu.h
 create mode 100644 include/linux/firmware/imx/ele_base_msg.h
 create mode 100644 include/linux/firmware/imx/ele_mu_ioctl.h

-- 
2.34.1

