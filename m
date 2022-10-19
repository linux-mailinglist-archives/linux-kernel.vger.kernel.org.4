Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB007603A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJSHAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJSHAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:00:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CE06CD39;
        Wed, 19 Oct 2022 00:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMqsv/bA7DOjTysYhhJMvd27Dr/KOJwcekHiqI3MGkrOfF5C0g4n58zSTDox//DtewpOlR2NMHKqJZXJyGEfDh5JukOeV4xLEfKrFjpjFlRUGM21KA4vppXkilOjnfFeKhMXF1jsmFkWzDs73LPsXZnR8HN6ygiU8snPyfThadfLu/X6XcN4aATVs3bFoAab26IJfn48rQNWnITAEFV2h8wncFXpyiXCwm5UG9YMIzz5qTUz6MSRuVx/DpQPDlFtHz6s2PlXKqHC15iah8ESuyphm+brcJhUoOUHPvAKSGZ+5HUkxsOqA/POchbeLaayQIrmuPTQdY2Cv3P7GOba+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Abm6fFjHWrwdsgx/dRGRLfOy7LGdTEil4eS21Yt11fA=;
 b=coFbhNFbVYgFhuwzV8lHOihv/t29Wbosw1u5cN8UKnHqYLeFK4NjgUibkQC58ER5KE2bhKCdVFKrCB1r2gpEixP9qOHqa52I+Kaszu9xbwlbOYUUQ0azzrTVWBfaQLpJ/bIxsJwNwjq6v4ZJYUrKkwMLJhBkdb8NOhLr7+PAyW1ILKPLC1b5IJ16YkqHFBDhdiGnxD5KbJyS3IzY9Zfu9cJRADaUK8OF5aGEoLDO73Rgjtpqc5sdjdfszINwdysxi0ZzLSH/RWgGn4xnsiYaVH1mlSirWkvPkCQvVkvlQhA6dW+ntL+6DVzevblZneIE5C4QAsOK2Yjppjw9e/bK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abm6fFjHWrwdsgx/dRGRLfOy7LGdTEil4eS21Yt11fA=;
 b=pUCjfIP+W/h0NESBfTnh7jeErPGLZr8sRSubSpGkQ3kMvttgi0H5Pery2qcDSTY9ufbY0Ce/T/ireWjRLt0WYwP36a37W8lP4I4+Im7XznEqkC2asaq+rTTezjVKE55MMEMujirMzxaf2tspvaWs2HzYULw93x9PqcTQ9iZGhE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS4PR04MB9460.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Wed, 19 Oct
 2022 07:00:41 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea%5]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 07:00:41 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, lukas@wunner.de
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: don't break the on-going transfer when global reset
Date:   Wed, 19 Oct 2022 14:58:54 +0800
Message-Id: <20221019065854.12397-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS4PR04MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cca75eb-666a-4c06-f62e-08dab19fa2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSDpfSGwKGu7tg1bdbIGi2s+aCj8VMntCGKMqbb7H2TMUjQ3dcKjdKLNuZHkhDkUjLEN6Wqltnalv13cCuJ6EUQka7FitbV+mykSW17WpNnJ5/Z+WnqSfGhJY7FHysYnhieEi3zRhcLMQmau4BduDINNUPO0XDPpWOEVK+h7Lqn2QUVTSOFHdzzeRfB1aaJ9rY/9PupXoN6tJMylEOt73q+lo3kBk+yuwA1lF+uRITfHDypFp703tgm4n7P3sOTGob13LHvV0N4MqRIDSC8Kw7jstwPmicmJWQc5YvdYbuwt6DqvStg609gNxqwM6+/+SplOi2nlNt4IFRAEQG4tp8Qz+yrYaxw4RaZCPrRIslwBqaNqOk+miuo3QLYYyrILOu26uc3FvbiiuZ+BF2HQFAvzXRDeJmUx2F1G9T1q4uFrhTn02Fh5fRHzGpBmn52KpvCeIbBqxvI1M2MWl6YH+9snyO5Jzf1A4aMJlVKVIkgiYJPl0TIbCM/5iurvBIZy846Q7WsybTLnh46RWNrrcfprXhIhIPNwIw1qZCKUyhW7rzjCoUFFrYJ3ADIpdTf6tKIAydVy/JuRpFzqRnjzXFaBO+MkGjpGzPXFDw8fQKz59k7B4k8omlobDaLyxNXvNnQeYC6UQ+Z6tNGnzzt7WHaaYsrzxoWjOVK9HV0Lyqe9Q3xUYqqx215aonnj1DnQ1lwTSqTkHn/dQ673+aPHGL9673O5fpcqROCQ+IVB6lSqqnDG1H12Lsrei+tU214rymKIiL2KOmpaEwYYlyWk7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(38100700002)(1076003)(186003)(52116002)(38350700002)(2616005)(6486002)(478600001)(44832011)(66476007)(66946007)(66556008)(6666004)(8676002)(36756003)(83380400001)(6512007)(86362001)(5660300002)(8936002)(6506007)(4326008)(41300700001)(2906002)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gc/7Mfgj0XYLyp2KCnl9KcE3ZvwIt6R+LyEnwdmLYPDP/lHvWI2+gz4pEwRg?=
 =?us-ascii?Q?3YIACEeOWx9/si0WUGpW6FgN7u1FfIwcTBZYo4yZrG66ichhpw8v/P0MG3+B?=
 =?us-ascii?Q?rV9CcpU9zLEMePr71DCLVNpiKaJLC2h+5Bx2w0thAM5ecAkRXRdpdlnZ30Yn?=
 =?us-ascii?Q?C37OQbm6LBUOZLQQr9fAPO7EFLqIubQRL6Gdci7VtIEfIQj1GHq0Y/odaIO8?=
 =?us-ascii?Q?swpGXiJi2dQAqgQYDVWXX0jCO9EZfCZ9UDVNs7lYnfpY3nPJ+MXok4c9Z+zf?=
 =?us-ascii?Q?UhV8RcLUjkyBYbAyjHWl/hw4rsPj8SSTwzvN6k4jjZxSJdzyNq7y09EJh/Ln?=
 =?us-ascii?Q?OIcBiTxf0+OZ3ee/ejhgYbfDsrSLHNcWzoabtszRtJ37REsYtt/w/3QJT7IU?=
 =?us-ascii?Q?sXPNP1gKpRs19xbr70kv2Gg7KEU+k0Tmd/aHkXB8OVp3AAC1HiyZRhjbd/0y?=
 =?us-ascii?Q?g88gCPYhheURtpq+2ijai6oXyhmjqTgpmgiNM4JjAlMF9LKRITp4CT9p7vgi?=
 =?us-ascii?Q?OQWUoHys6RzYI+7QsbfpDk/ohKLKz+v1bq0wmRQpeJL0kg53oLrfF7bMlvVR?=
 =?us-ascii?Q?BEnCRcFqrpou71nNnW2lTsUvqIC2qmTjud9Viy4NitorMYlC9OOrMHRC1qNl?=
 =?us-ascii?Q?8eCVIousznhqZ8pwzamMKFC/ZdI/6ZRQ6oQqfKJ4LALKijmafs4AUg/sF0V7?=
 =?us-ascii?Q?ex7yZMOAvUD6iwXxokDZojYut3uXefednLGCDqDlHzEgMg4g+oMf/kQeE652?=
 =?us-ascii?Q?u7ZIYui9z6XK9A/5K1KNxpc+HpDsHDwCLln82z6RDff01gxLc/d3FyY0SXoO?=
 =?us-ascii?Q?ow15Wa2BPnI0NnbUBYlOnUst7S42Tut/OqxIeVIJ+Ab1E3ecM89A4U2ODEJd?=
 =?us-ascii?Q?rp39IijypzVZQigTEmSi/fG17JDQtwqQ/W72G3WW/ZgvGYtLdIecLwNjBiB+?=
 =?us-ascii?Q?j+wkRClN9WYqdBDKKh4WOfvNmIvp/EY6lmw9kG0+IK5v8l2XSd+Di1GLQMlQ?=
 =?us-ascii?Q?Zoi+DzcPrFYipyZ8J7hNnc0xhHHI8NsW9UKRtCjGXa95sjm4J6MjsaTXqNdU?=
 =?us-ascii?Q?OIpuZbs+KoRGhzMDBh68ea7dBRO+MkKZm9WSdWyNjIvZMZDWv3o+09Eza/7x?=
 =?us-ascii?Q?T31sBkUQpgqN96q88T4/EvBNrXsalYxpZQdFyU8LwQGPoV01hP0lor09w0fO?=
 =?us-ascii?Q?g/HWqp7jKLeHvQmigUMjbhPzfrg/rJwH/bdd1EEDhfgnAtfEA5MrZ1J8uVd3?=
 =?us-ascii?Q?7AXvU1UWlQpSxCnhYYa7/N2I9pOba3Bvx0Jt9+xMsrk0QrJcw8YeIJQjO4Ml?=
 =?us-ascii?Q?ftCPS+BhQZmoPVjXjT7tMwgThGifPPFe7l/+AiLWJ3C0bnTMbNs2T4WOAAeg?=
 =?us-ascii?Q?7JlU6mnqTbLJmnT70M2HAcgvvZ7tCFjzzh8zbh8UtOtwXAxsEaKk1SOSnz0V?=
 =?us-ascii?Q?CCo+i2mmbzPC0HlCrmEcut5f0XltET00kopFQs8jcN1PLQaRrYLxM3dWRuQk?=
 =?us-ascii?Q?h/1nZIVBHtvgfxk4fksrTlLVKQy4fTDNW/3OjSKt0W5AYiTTBaVfWLGHJ7A7?=
 =?us-ascii?Q?5gZXmrejjQjDdwz5fgP0FXv3kyESNBfSr/WpzVXX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cca75eb-666a-4c06-f62e-08dab19fa2ba
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 07:00:41.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMadbMNmb908gYXAC3FuMjshkbPCkCL/VfTklgegzKbNd7wEiOgRCXuOaFI2MA93g2SWIMAD5CiXv0GGhME79w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9460
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpuart_global_reset() shouldn't break the on-going transmit engin, need
to recover the on-going data transfer after reset.

This can help earlycon here, since commit 60f361722ad2 ("serial:
fsl_lpuart: Reset prior to registration") moved lpuart_global_reset()
before uart_add_one_port(), earlycon is writing during global reset,
as global reset will disable the TX and clear the baud rate register,
which caused the earlycon cannot work any more after reset, needs to
restore the baud rate and re-enable the transmitter to recover the
earlycon write.

Fixes: bd5305dcabbc ("tty: serial: fsl_lpuart: do software reset for imx7ulp and imx8qxp")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 67fa113f77d4..5064fdba1b61 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -408,11 +408,9 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 {
 	struct uart_port *port = &sport->port;
 	void __iomem *global_addr;
+	unsigned long tx_enable, bd, stat, sfifo;
 	int ret;
 
-	if (uart_console(port))
-		return 0;
-
 	ret = clk_prepare_enable(sport->ipg_clk);
 	if (ret) {
 		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
@@ -420,11 +418,30 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 	}
 
 	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
+		/*
+		 * If the transmitter is used by earlycon, wait transmit engin complete
+		 * and then reset
+		 */
+		tx_enable = lpuart32_read(port, UARTCTRL) & UARTCTRL_TE;
+		if (tx_enable) {
+			bd = lpuart32_read(&sport->port, UARTBAUD);
+			stat = lpuart32_read(port, UARTSTAT);
+			sfifo = lpuart32_read(port, UARTFIFO);
+			while (!(stat & UARTSTAT_TC && sfifo & UARTFIFO_TXEMPT))
+				cpu_relax();
+		}
+
 		global_addr = port->membase + UART_GLOBAL - IMX_REG_OFF;
 		writel(UART_GLOBAL_RST, global_addr);
 		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
 		writel(0, global_addr);
 		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
+
+		/* Recover the transmitter for earlycon */
+		if (tx_enable) {
+			lpuart32_write(port, bd, UARTBAUD);
+			lpuart32_write(port, UARTCTRL_TE, UARTCTRL);
+		}
 	}
 
 	clk_disable_unprepare(sport->ipg_clk);
-- 
2.17.1

