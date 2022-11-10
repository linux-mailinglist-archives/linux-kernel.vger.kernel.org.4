Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69729623D49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiKJITy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiKJITn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:19:43 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20044.outbound.protection.outlook.com [40.107.2.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05562CDF1;
        Thu, 10 Nov 2022 00:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wzkz3CAPhqk1Nm/xzDCOuCQkOLQngFbPE42p7X5aZ6LdpGwiDeniHyrmTAn8DN1BcnK6vKA3kn//RLX1VJv/nyZCPeQROrX6aCgNccbLm2wKdxIF9mxPIqzmYIQN3UuCiMb3ao8IojldLrxFelxtfpx8SXsCwrmBykBrdmgzpxVmvsQjRCH6NQCx7Bj2v9jKTVmZ3xX0Of03gJoc/2ZZah5yU+YimYDnWJQqucc9mRabq72+ru0tcQR8i9eti6+B32lZu8VJq9Pyd3yUurWzr+4TLbnLcBwNxv2uDXSPsKdbL//R+Y/sih3qAw4/2mpzv66B1khzjWWSOd7oQSt73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EjuuTwodrodUQEQw5TynfSdu/nznMkw0PI9L48mWiE=;
 b=hVWoFqrgAtVb5a/HVV3R5NK8i2b+9U5kj5z+Bd1r6U9yKqSP/oSCjUpQ9WATuoDXO1tK5wzZBpbIl0PbX9Y8G920N90pqSzkrsvYLsyAkufMkFzrvBigpADNGwdgIMwtMlH7XWKbTxvS9U8fi/L+MF2qpcVmj45iOGqn/v0s+6W3atYl39pQhunHXVCgQmNTaTYYylfCHfuRPHi68a/oF8E9Kg3My44a9zdxDJrGvWI8zpa6T47sVYBa1WhhiiS2V/VDfFGwxBmCKcyRHIprqQrDuX4WHN6H7Qhc6+7mXrho+JMh3YnOxzfSopOVV15zjQfL+uF0tRI2m86iDTkwjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EjuuTwodrodUQEQw5TynfSdu/nznMkw0PI9L48mWiE=;
 b=M5ualja9UjAtym8AHRIK7vGf4VUonQ8yvmdrzrczvZ0bFZgeE93Ob07Gm3Jd3fufZci49M65PX/12kexAoKy+OxLBSVtDlqqYH8BfS/QS4MgeL5rqBWwPh8o1MAgNHT6AJn1vCk3VC9smBKVL1neoMzU4JvzBo6dKM69kfU8LYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Thu, 10 Nov
 2022 08:19:34 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:19:34 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     michael@walle.cc, jingchang.lu@freescale.com,
        tomonori.sakita@sord.co.jp, atsushi.nemoto@sord.co.jp,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 3/5] tty: serial: fsl_lpuart: clear UARTMODIR register in lpuart32_shutdown()
Date:   Thu, 10 Nov 2022 16:17:26 +0800
Message-Id: <20221110081728.10172-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110081728.10172-1-sherry.sun@nxp.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: e646b902-f2c7-4f83-df96-08dac2f44cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lQo/tUfgBM970hFvDUXR0jeWkYjG3T4S2M+HRJTFEiYFFw+V9Bcjw9mT4BIy1PKC9kDmosCBWtf8VrPUUg/Iyu3gs+vM8tVOGuDNqJK/MBhIjkunh8r2pNToFTi7fj1HbSaIS1E2eE4MxT856DbQOhKdzeka0mvs4SwaM9cC3X+HPZBBg+A+3IVbBr9mOR9Gxhe91Fefa3UAann/LEFgFxRRSXjRryHzyJkTK9no7NP1pPIeXo6VhWcvgcX2HJZy1id0JZL/XfNbpnWjpdGwcAlngFFylrnAOQvk+1Vr3n1WpG5wjmnFnCON+tGFHgn7raRo/MNroybcT99ySyraWdaQFBIa3iAad3vcYtzFikQll62qM3+NiLRNihbNkjaSiJiEr8aI+u2ZBh/bH5xGfchS7o5prGakv4LV5/od4Fh0CXg8tT6q6/uMSZ1WTS9IZVTftEKNLwajUbZQ69KEEGlk6RNuNKXP/rmgUEymPGMloUFbm/EXaoILvE4/bsR3m9ASzCObADyLiGlYf+8hwSZaX5PM76akn0ZFLQEFL+Th3cRrPCXEzdfXlhQhJP+Wwu1Izm7KsYio5GNlwMek1fsgY68v3IrMMdroJvtTLSC9OqcQpT6hIrRaICYpa2Z6t0u6531+7BaozGVFRRDirZii0mjRSJKBgtb/Kh52sKBCq8Dt0L4u3o0ecb9ghFOkjvCgTFDDM2NerTm3appXbmv6FsFBQr1Qd0P4RoBwUvQWCeMPoCrKI77fm6LTS79MyZ50UP6tZJDax6Yi9p1iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(6506007)(38100700002)(38350700002)(36756003)(86362001)(26005)(2906002)(478600001)(6666004)(186003)(41300700001)(6512007)(316002)(66476007)(6486002)(44832011)(66556008)(4744005)(83380400001)(66946007)(8936002)(2616005)(1076003)(52116002)(8676002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UG57a6tGWjoYVbceMVgEgj3oKlRUEIAWP19RVKjWAeByAwveBOpNZGcXGwi1?=
 =?us-ascii?Q?hJzeQmPL6gj67zGeoPVKOLhZxWBptAKl2R0TW52jztCV+Gguz9v9sVKbBx1t?=
 =?us-ascii?Q?4N13pbbca0ZzkMc1Wzq48WWFwGJQwuNANaXuban+07TQKKnotz8xd1vFMCN+?=
 =?us-ascii?Q?/kkxudvM9Ut/8dpSF9KADegTkZ81aHWFIIr5Gk4Fl5oJwgki5K7+cEEwT2u7?=
 =?us-ascii?Q?ZigPT9DfQi/uKN28gqnacIOBHP89z6nUpjEUvW5AxnGoopWxVq1GjY81ZOfg?=
 =?us-ascii?Q?gu8ui0nbrsvOCK4GFnljIUCIeyxlaC64fKD8XSOKlMGPYeNv4Znpd9XnONzf?=
 =?us-ascii?Q?Im2dNcvu+LbwzU65YEdcDGXoE7+Yvk99Qdn0ail1OVmSWs38rxE4ERgz/kYj?=
 =?us-ascii?Q?pqy8EplK8pbcxYmQ6QrlBCfmXV69SdqG1mnbnlBsWg9lft68U21nd/XpHOxM?=
 =?us-ascii?Q?rRJ43Mtn1c1q/l6i3o6fA0Q8UuQnKLTbVxCUXlcCktWzPdRf4Ax79ManVgCR?=
 =?us-ascii?Q?d7H6Terpcr7RoeSIkjpn20wvGzHkJBpw5e+7yciERVLehJ+B4m2nnE2n0GRC?=
 =?us-ascii?Q?9bzmcNYbp/JcgXkE5R1t3fYsAsOZYfI7//zT7ep6txSoVKrZ7AGut32OBmrY?=
 =?us-ascii?Q?+qzAX0eVIBXZyd2lDqcgjxozxYhb75NokArt1FpYX98ktE/GPZaM8tvMSnue?=
 =?us-ascii?Q?GGghpnDONcYnsQHPRdtCO4JvoV+6V1/elm2lT/vuFMm40sQ0o5STTnCQC9EX?=
 =?us-ascii?Q?LZMlOENQ8LzC+1l1jXrhOKWkA37iEO1BQgMAzzES2QVVn8xOet4Wc5cUviSd?=
 =?us-ascii?Q?y0ceq8nGo+jLBEzUW0hxbMqwHeWeCZ23lDSp8yWFxEM/hu+IFgWHKvNsTmak?=
 =?us-ascii?Q?Fw8NF20xeUROb1dxWyDiScA9/MLz3ogDw8jsArMA+xEo90ooTS2Ot6Zzlxk0?=
 =?us-ascii?Q?nfs+ZxDm/yrYsZyrwJ0ELekC//2umzKnRipKJBgd4sYiqMgcHFFEOJeVagh7?=
 =?us-ascii?Q?ZyXooq46MlVDPBNANJfeeZL/Q8MyhMKYkPOR7cmTKL+Yzof/3I5Fr3Yf4m/Y?=
 =?us-ascii?Q?Si8DmmPuErbg0GI4eJqZBMhEcj8OIh3lXpUmIru+wSmkSVg94RnfipVEJyE5?=
 =?us-ascii?Q?4VbEWxOKCxapSSukCgCUroTG1kms4BRtqgGo6p28aTn0GhnYwlOrTJGgyoXp?=
 =?us-ascii?Q?1kx9N+RDEQ8TE9BUfO8tp4H3llG2223h43PHPdrE8Wfn3w+CPmxkxl2KjKxQ?=
 =?us-ascii?Q?rwNQkTx+lw5KvezpJ+MdrKvx+5sPyuL4pF+aLUgwGTmoXpHz8nBk/xGNi6Cn?=
 =?us-ascii?Q?Da981FFx3S7I1oLp1BHFxGJytMk1TL2BnhEN35i4D+eF8QcygFjXVIvT/iNU?=
 =?us-ascii?Q?xy9j/LR2wG4uqmRMKPbsXQ7lf8Jv3CyfIygYc1tLaGq+0qnqYBT2pCT+AuO4?=
 =?us-ascii?Q?OMEQ1V9YJuVhA5vlGCyjxkaASE5dpNJLu2C5S2kzEdg0IN7IvTLntRNkLmfb?=
 =?us-ascii?Q?tT7/SAr6MX77KzCj4WJzb7go+qp0ZAtttgl4mDR2YRi6Y5lCmwuOC7ZRFTLa?=
 =?us-ascii?Q?cZwKRStnc69SsULFH9qh9yht0y0o5bz1/nscwS51?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e646b902-f2c7-4f83-df96-08dac2f44cac
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 08:19:34.3365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzelXD2jU/BKMFImohJPpFuoJFJmWFoCG+0yp0Z3t+cHQKqvEj2tnDjYRKuKZ+Zdx3Q0XxSq3Gtf8HuS3cZIDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UARTMODIR register is configured in lpuart32_set_termios() according to
the termios flags, but nowhere clear it, should clear it when shutdown
the uart port.

Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Split one patch into four smaller patches to improve the commit
messages and add Fixes tag as suggested by Ilpo.
---
 drivers/tty/serial/fsl_lpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index dbf8cccea105..a6f7b056d57b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1775,6 +1775,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE |
 			UARTCTRL_LOOPS);
 	lpuart32_write(port, temp, UARTCTRL);
+	lpuart32_write(port, 0, UARTMODIR);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-- 
2.17.1

