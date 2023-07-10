Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DC274C9AA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 03:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjGJBkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 21:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGJBkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 21:40:06 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18754EB;
        Sun,  9 Jul 2023 18:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaPX66x4VQPTrUA3Z5VFBOa8QOeher21WLyRV0RgBd6slb0wlk1m9niDJI9VT/YDXA3jm1j2WSY19NluCPXzg8k1js85O+Xdn7kBUAJvQGGFhP0wKBNF+ASKsj0jY4+DOkAEl+xQ4+RBFOz+nqq37NkGkfSzlBYatvGtBwkjZcCeDA7/YJxXDXsfnX6FW9O90it4mnWjUpcqSmIkOR9QsZeOnRuy9UOeLdn8KFAl+YZHocCpqlOxYxfgzOmykObQy2TxiqrRUDf17Cw5iSrxk1b7+0suOYMLcjjEM4z26wjVZbrOo7ox8DJv4tqEOj9y4zW3DifcPmhqZURU9smjyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biL8ygFZEKRw41k+N1aUCiCuZQy89AeQMMYXhbQSx0s=;
 b=Y0vZvUmnYeeD9i5xorgPoGkon5ph3ZrismkI1bBSB8abnzrRalSmJDbWt6teRpPrFQnl3RdSpCI5uAeFn34ldEwKQHdbw2EjT4Sj2r0GEEOi4cyvzXE6XPh2TOCFCxygeKZUdJTr1OCMqLX8Dszcjg+IkO0kgSiFwgkCnFQw1X2lrHbi7EU4EI0Nu4mZZejinDwPqRBHMC2Ttc/URmnRXM/KXtu027QQxIgXA17/FukT4zcJ5rqHvMt8KMBESo4oxiJW3OWp27AZkaUETmtp7dRI8NFUemsHEIbY6blYXi527wCeuqnsYu7xbVmS28/CJJ1WwTR/2hfopbYAtz7ASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biL8ygFZEKRw41k+N1aUCiCuZQy89AeQMMYXhbQSx0s=;
 b=JyQwHv0+ryKexsTGt3H2fMhq/lT1B/WBPSI1tFcJQNL5DVzMuCAabQWhSt/vRFHTBgc19Y52FixG9SEI9X9bZsKlWcb9hIQqMZZxfKICeh27ErHqChiHZBxAbLziA6j915X3PYJugbcW+ymFRbwg4oU+q5mgf1tyejwWN7BBbz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8117.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 01:40:02 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1e0a:1ed2:2e4c:6b6b]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::1e0a:1ed2:2e4c:6b6b%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 01:40:01 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 0/2] fsl_lpuart: Add IDLE interrupt support for rx_dma on imx7ulp/imx8ulp/imx8qxp
Date:   Mon, 10 Jul 2023 09:38:55 +0800
Message-Id: <20230710013857.7396-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cc6144-a375-4d99-7aac-08db80e693d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /R8GT335MNzneXGIIZiocKnn5eu7GZ7wa2kalELandFuS9oTaq6QQuxaPvRR3Zuls8n7in/yAPaPRRfSAC/xLBRXRwlLc+DASAV78aQicXokdnygEJoUI5WL+5xim+hTNMv5AOHdDqX3UfdEFvRfxdJl7fgV7k5iy8Dit2+y4s8n3kyvbrB6dnzKg4Uyp4mj1d+VaPXPpijfZBpanO8tDo2kaR6+WntsjvGF8XkZSFKsXT4LmZLhnHSI3AISpRsf34BcYH86GAVDm7slXucBxtG2Dtl7hB0Hahol1iJb1rZ/8gwUTq13a1hSCbL7X1Bi3TGoTXoQ77G7+RxlxDVDOGDW6rx14m/tZGJqxhUrf+fqT0/jZNzzRxxANpetUHwCHwXQVcLpd5YntsU/+DzKD00diZMqWdIFr1xovZoEeUwFJF+qh6kuXj2UdfvGSy59kyJh+XZyhxE9hPVBusyBqrJcGSpilFhuZx5tc2ZBhgBMK5ikNDDg3zH+jWrlxUeFUQP26B5xKVhq3NsWjAL9MgMjN45pZlQk5ntrB1SvPTU7Pm1digV2yg7EJDKkbLaNsXaCLUlVp0X4xmGtGaNx9X6Avf50VDG8Cm3BeBW8KDaa9gLqeY5og1ZRUZHiJLNN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(52116002)(6486002)(478600001)(6666004)(2616005)(83380400001)(36756003)(86362001)(4744005)(2906002)(66946007)(186003)(6506007)(1076003)(26005)(6512007)(38350700002)(38100700002)(66556008)(66476007)(4326008)(41300700001)(316002)(8676002)(8936002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rnh2dLhVdRfJ0CQxw/lNpDc4YZZ6UzEJmmeVyXQPfFHjDSbLvP0DNonQ2McK?=
 =?us-ascii?Q?NNT/2iqXZMQbsNrBBak/tB2WLqslopIhq/x97uZM0bxa+KO5Yj3PljuIO1dN?=
 =?us-ascii?Q?MhghiEmCgRiecoaaAEj3Q72YgmSsjKqnCBL4MMzimQ10mbSBi45SxCCdaT4Q?=
 =?us-ascii?Q?ySu9ZViqnQc/zvRcMQ7t2k6Z4eWFgnOQFyObY3YHPTeEsPVAJENUzkndux8x?=
 =?us-ascii?Q?EMvzju2+j8L0/zinaZu1eP5PHyVkfxJfN+dZyaaKZLeX1SWszhQ9y9awcOA/?=
 =?us-ascii?Q?G1lbk4thYm4RTAtjZU4VCJ14ctDnkV5wrMvKI9hrDHg33ePswJ2PSeIefC0I?=
 =?us-ascii?Q?esfskedURaM6hp+AIhrJ27jSaI4ET2ePP39lGZLmxC4YSswee2rQ6dAJbi6I?=
 =?us-ascii?Q?rfpT/iNP9qIZMXD/aCUvTQ70FFuYOHRDRP7fZC6d0LxCRbMhF7R/yk2oXec4?=
 =?us-ascii?Q?IFqP53249Hwxg4kkNo43cOAdIdncNkuW6AlxI9Lv1MkBJIv+f4BFXhtnZKtJ?=
 =?us-ascii?Q?EY4aLMSuXNt+a5xjtEfMe2xXzuUn8J4WsXMB7L4TBvtosWk2oZEGfTGHaFDM?=
 =?us-ascii?Q?+ltt0/5buyt5nss/DXA4nkf7uuKodq6XD6KLVdOlpV6xv9kMCGGuPQLdv8HW?=
 =?us-ascii?Q?4hWUsByIcJELq6465dfWc4WL7vdjQS0wOtGjs5wpqSruJek+RRLQG77GExSK?=
 =?us-ascii?Q?WE4ct+Ziq0G811zVrBM3JC58m3aDRykKj3ede6xZlbvi8DKI+0kgUz3a/Yo+?=
 =?us-ascii?Q?56QPGgIJFxipRCk4BMaXgvl+5/0jngcFp1j4MFBuE9uBh56ROUVWrsPIiI9z?=
 =?us-ascii?Q?b/kz2tFN9dmMeoHw/InvZBXImK7xsWPsgiS20TgvnWkvbBi3FI7CTRD7jo6m?=
 =?us-ascii?Q?7gWCHoaGU8kx0A+vUe1SA7PiLrlhpcJUOVpN/+VPWGEJMOo7LBg2Ev1UrKck?=
 =?us-ascii?Q?8iZr082AkE9oWpn8Gq8MfH8NoxjKnarPYky+Rft7XhVOvg0xPV7ccSOAVVbM?=
 =?us-ascii?Q?yG0LWnW+2uJcZjatkiFONNh7BEnVAhRCm846kC15dakpDXNUzvVv23gO09cP?=
 =?us-ascii?Q?LoS2n40LW0mscLp6N3m6UhfAkPm8oTcintz7dSQUmx2p2YIPkUMs5dlTLwEV?=
 =?us-ascii?Q?/V0UoPvS9jblZuS9R6UwWrspG0fmPk8G1pEHPo5L6xwi+w2cplbip2eKSzPF?=
 =?us-ascii?Q?YLT7GlKnUxS9lZTWl5mE0w6n9RIIap1MP3L28LYFpCEFosJKLJA8DkCgI3Sa?=
 =?us-ascii?Q?5qF6stJYEUoemjLaOvEo8Wgxteu6PThI4Le6WBWs7e/hmzLOjyM8mzqGOxZg?=
 =?us-ascii?Q?9giyEezL3iVlRDH0WO7HA7De0VVIXxv4PvdwfInx1WdnDvveMBZKmaII7pvi?=
 =?us-ascii?Q?5w+jNaIqxZVqm3loXrjKAWiNeU/ldsUfhA2S0nOhw0nmM9jbd9utZmdEEpPO?=
 =?us-ascii?Q?ZbR9mpuyv+Ww5cqVNTKB2RBwHeCPGnwU5veGQx/YCtNf4tCBggHj2VufUqRB?=
 =?us-ascii?Q?w0vrCt7JYGWD8EtzkJVBbHqMnEdFVJIYX2ZoatVVhgwBXIWnXeHUi0S7+7On?=
 =?us-ascii?Q?AB2pJvjc6TnivL+xBiuP2pSQze7kj8n3aNvAODq1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cc6144-a375-4d99-7aac-08db80e693d6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 01:40:01.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbGL/AQyWHO68Lx/LPjFyyy4nEHX6z2JRBrHunW9iG9RV2NWdyYA7obfLYZ5MyMJreLPGBpEbcLhEnzo4k+Qig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now in the lpuart driver, we use receive dma timer to simulate the hardware EOP
event, but the timer latency is big which cause the Bluetooth Firmware download
timeout on Android platform(it has a limited FW download time window).

So here we use IDLE interrupt support for receive dma on
imx7ulp/imx8ulp/imx8qxp platforms to replace the receive dma timer, which can
reduce the BT FW download time obviously and the performance close to hardware
EOP.

Patch#1 move the lpuart32_int() below lpuart_copy_rx_to_tty() to avoid the
function declaration in Patch#2.

Sherry Sun (2):
  tty: serial: fsl_lpuart: move the lpuart32_int() below
  tty: serial: fsl_lpuart: add IDLE interrupt support for rx_dma on
    imx7ulp/imx8ulp/imx8qxp

 drivers/tty/serial/fsl_lpuart.c | 83 ++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 22 deletions(-)

-- 
2.17.1

