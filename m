Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D405EF0F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiI2Iy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiI2Iys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:54:48 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60061.outbound.protection.outlook.com [40.107.6.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EB218E0D;
        Thu, 29 Sep 2022 01:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEvIF35JpjfppGXBLTUvi3GFJGwgZFbb955A/rfXBLA8au2FyZB2iWsWH+hBQ2GwUy0zbpH96aJCxFeQpIK6nNDcZRfGbSVCczukSsvFKPlAfqJhtAYRkMNJjpCI06yOeqNvmtUouHnwr4qldDYdO5ujPc3eeaokmxUf20CNrV1fQ1WT9bnReSqjl6oXjwnYb7S+py64poxS7wzWhE6L+Fredszl9MXyV8dosp0KllElgH/pWjdAV3IY6+6d07VYH7F8VqXiDkcWwD/UidBa/SlRbDrVZ4QKnnoaIHrYTLvtf5ODMxhtEFRkBHH8kLw7PxHOJsYI3BiC5xWfLVSw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsAiK3s64TBgbtM5mi3DhNv1iv0FSOb9wzaWJ1Q+fQk=;
 b=FSJgZ3+Mmt4C8OFehHrFXrwhllQ3C0bcj7M2mW/GH0xSIBPb5e0C0aMkyHK42BqXXi/CbhOfSmPKRX+tkKh812LdYIGwZd+9ewve4hJT0nl79nS02J9LzZxKVTG1U7df/F5ugHaOZHDQlLgsMvLog9sGu4vJ7clmzbVCUAg910agIAWU76MgNwsT9PAdsNxW7wVuJ0UqOCNfsPKW7pwEJiNSbGNm7IIwuocFIfphQ9L6Y9zAxBo455XlFyB2CroZIJWjwQTWRC4/crYlHZwWAlz2xaH0FT+Ixc/9iPkoxs0dLEn7SwNI3xzH8ojmAKw1SrAXOwDxrnKjQvubfpirRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsAiK3s64TBgbtM5mi3DhNv1iv0FSOb9wzaWJ1Q+fQk=;
 b=cZHO0Ndnlq54jNsmWI1yhhj1W/DH2VNF9Z0qsSCIn23enXv8JT5NqjSoC7mE5SQVyvnMjVK50XAj2grNefiRe3FTJZ6F7ZmKkf0etJN0rSCo31ihhVpNC2kUnD44s0JOiQHl/ixfE58/zgvd1tIeJiitIIYPadZ747A+XmZrQQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 08:54:45 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::121:6a2a:2d4b:cb8a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::121:6a2a:2d4b:cb8a%8]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 08:54:44 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, lukas@wunner.de
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Date:   Thu, 29 Sep 2022 16:53:18 +0800
Message-Id: <20220929085318.5268-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6dfa3e-85d3-4894-e30a-08daa1f8413a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2hduGU2qGO3YkXM0Qmrx7D0J7qZAVHSxLywzYmoTxiWw7QvcMPV9kFHQdJ57dWCvG+iavDDlQ2ldY5Hcay4zJQqcGrLBQOUPi/rtNulkUUa/6gBfuPAojAKu7+pzcXPvv9RXwJ0k68ZQMln/aqjCKnF1fZO++dvcyZHP+K2WpYsTmnxKnMxYIMCdySVfpW1cI4WlXtH9giqnqS8Ugp2bQg172qByEuwZrMp0p0W6gsJVlJSJTXI4YHfqRTrWx7fteFe7qk1sAWx5KUHJb/A4l13O+L6FiJsBnylYTPEr4ixKD3HGtj28rCTmXNsXn+m14VUhuYPaIM2qQpIrZD1Lm+ytJ86a/IzpNClZ/DX8J1TlVBmj/XCWmLBFWL3xYPnv4P+0dBjqw/bken5gW6vdXGGFGawQ4c39E/SF5J6AtXrlX7MDGmNifZAJwwYLxtb6Dt+gMp0hQ+eiau3xGhF3hH0ZCTwky6zo6VIFxiy+Yf+3yMQAP1nAhH+sGDrBhDMlVUgZ2IWKBwURr3C7s4WDrrE7GrnvLrgtpakb35RFJPNJiibMNosARSGreBhosCBTLHEb2e4HeYiZURmthTMFZm54xrBPdiuJO9RsiZqcGgDEAn6JQt23I+eytrItcUBXxrVknouvUpBtIW9eMlPuWwyQytiLmp1pMMuxsfGbO8X9D8tNwBhaxMzdEYudd5BXcgEaPr1iPozMUNUswyEfeqwbKsXoyIdk97tNcbb0PmcBF4OWBLppebL5Na/L8LcDQ+etgHHOxzgwauH/tOlp54Eqp8jXEMVTkI/P2KNQhi/i+wiVQUk9nZUGvKeUDcr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(4326008)(2616005)(8676002)(1076003)(36756003)(66476007)(41300700001)(186003)(66946007)(66556008)(83380400001)(2906002)(38100700002)(38350700002)(8936002)(86362001)(6486002)(44832011)(5660300002)(6506007)(6666004)(316002)(26005)(52116002)(6512007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfQh+H+JXdNgxYU6s4iAVP/DnJUsdCFae5rP0/01+ynqmibAZrgSymG7zxWO?=
 =?us-ascii?Q?NPrSlw9YFQs5aEasrWsPYrISZQVH09SmpDYO6zVQGTFdBsQOI/CGs0OlzP63?=
 =?us-ascii?Q?CtsnbLA0y858qBQziKzet2MGK4aNUZFJ6SGlFqNLAcMUOAZ8e3chI5ko9WdT?=
 =?us-ascii?Q?G8bWKezzE0PcNMQC+kH+ly4kDb40gG/DwU64T220ewcg5/BlYF8mu1sJ0f2b?=
 =?us-ascii?Q?49Ohne5+47rePXM3QaCnopMeHiW62TfN0GyFrt79hcrJ8riwSZBXRHPGYzoR?=
 =?us-ascii?Q?9qE4Gm2f82dlH4FunDfYcNDYR2P+eucHOaoSwvca1KIGnqmUSajg0/YFrzxg?=
 =?us-ascii?Q?qUMcI3eYO6gm+mP1zrEC5xAVhshCS4tcF/DFDteTL7r9rmI2uMAz0FOUFYZt?=
 =?us-ascii?Q?/xqGHQuyGUiOwfQ6QvUUrLbfGRP3MlOHdIaPzuuo9Tfolzf75x6K000XURYb?=
 =?us-ascii?Q?Qzk8naLMQ5+6k2NQNJNxMJ7+S1mnLJj1nn6Q9RPciVZYB9EsBFLvoGgqbmv+?=
 =?us-ascii?Q?om1FS06zWbKedFCusgfRL8/Kafk2tXG1ru+0QM4VEFauQPLI3aQjFqt07MEC?=
 =?us-ascii?Q?Kk2++Dpj2A6kh63LrfzP4JduZcpL6iSlCfaSMtoyJRKKI5kfauDeQw3rCH0H?=
 =?us-ascii?Q?G++twiNbqJj419rs92Sg2qo5vhiOCA7rpP3u+QsJoeH/Bt5gUvjokt0aqq4h?=
 =?us-ascii?Q?b2bqaUPLkdQ0qNCwd7nEnD1hRzJv4VYjTZfH7nDV4eKcBz1j0Q0o+XPEHYv2?=
 =?us-ascii?Q?sm1TdyrXKR6yne9CAIfdXxseEJkXqlkFbYX25dXUf1TSW7MTU+Ex4ZcWIg0P?=
 =?us-ascii?Q?U3dkxBF+5020xEeHS2z8Pwkij1fPB/oCz4lVZqzy02gIzrpzbUiesoC0dWmY?=
 =?us-ascii?Q?qQFXmUNKIydJhGF16BlZWDaZlnCN80QeidwNhi73T/cj3FwXs7o4qk39h9y2?=
 =?us-ascii?Q?OY+DqYd1a+Cf1N/opaEERemchE8FzjBWqGJuZTrzI1wT7cqxJaRmWPFKafZ8?=
 =?us-ascii?Q?4pYVOAX7p1rvxjgTjBYY8x6r5YIni7pYQVF9FwbkzPChknDFPlDB2hiKc60A?=
 =?us-ascii?Q?WiUwus14CfHjEAKPVX8Slxp0I9NviX+pPMKs5pI/KhC9r09t60RGmpsoUU4q?=
 =?us-ascii?Q?hABUxFf7GkfY+4EuyoRb9x9vCNzrsji44XcymEMDromU4cSWVdbJZSw1Ebks?=
 =?us-ascii?Q?ku5ryTRLa/JSHR+UX0/WQsss3JE4j/ERUUBL7X1js3FXXZM57eQ7DPPgHiA0?=
 =?us-ascii?Q?JcHO7e7R/5Utfd5aaqYObSHfK8qn03yx9+7f3EPhbHnJ3esvu8mrZgRmYX3M?=
 =?us-ascii?Q?tKj22jOj0uGpcme943UOw+9WmuM7kW9v1D8qpjO7sFUENY8C6uX4Qgf4J84Z?=
 =?us-ascii?Q?Srz9AJDB8SRkf2sjs/A+Ax7ZwXE2RGjpesOI9+YTjL08+sTGCY4oFnrnhniE?=
 =?us-ascii?Q?GI6LhPG80Cav/nQzNoNlbpn/MmL0COM+etituOiVTk+Yeb6LuJi9xdJI779S?=
 =?us-ascii?Q?TtVOOse9BvIALjS/AxTRRKcQFpntmE+6nQcEi1pmfFi6IFENY+ZYM/xGsORc?=
 =?us-ascii?Q?TgWgeYKdGJqE4Dildvj6PwjetnQMY5uyrxGi7gMc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6dfa3e-85d3-4894-e30a-08daa1f8413a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 08:54:44.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsjvZ5SNj8dM7OaC7jkXMGmGDJpZIKQhfYxsuXb+mkswhQAojJiqZlBF9YemKL55IHFA0pn9GcWThJ4nDJGzGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 60f361722ad2ae5ee667d0b0545d40c42f754daf.

commit 60f361722ad2 ("serial: fsl_lpuart: Reset prior to registration")
causes the lpuart console cannot work any more. Since the console is
registered in the uart_add_one_port(), the driver cannot identify the
console port before call uart_add_one_port(), which causes all the uart
ports including the console port will be global reset.
So need to revert this patch to avoid breaking the lpuart console.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 67fa113f77d4..7da46557fcb3 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2722,10 +2722,6 @@ static int lpuart_probe(struct platform_device *pdev)
 		handler = lpuart_int;
 	}
 
-	ret = lpuart_global_reset(sport);
-	if (ret)
-		goto failed_reset;
-
 	ret = uart_get_rs485_mode(&sport->port);
 	if (ret)
 		goto failed_get_rs485;
@@ -2734,6 +2730,10 @@ static int lpuart_probe(struct platform_device *pdev)
 	if (ret)
 		goto failed_attach_port;
 
+	ret = lpuart_global_reset(sport);
+	if (ret)
+		goto failed_reset;
+
 	ret = devm_request_irq(&pdev->dev, sport->port.irq, handler, 0,
 				DRIVER_NAME, sport);
 	if (ret)
@@ -2742,10 +2742,10 @@ static int lpuart_probe(struct platform_device *pdev)
 	return 0;
 
 failed_irq_request:
+failed_reset:
 	uart_remove_one_port(&lpuart_reg, &sport->port);
 failed_attach_port:
 failed_get_rs485:
-failed_reset:
 	lpuart_disable_clks(sport);
 	return ret;
 }
-- 
2.17.1

