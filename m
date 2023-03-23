Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2815B6C6640
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjCWLNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCWLNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:13:17 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2050.outbound.protection.outlook.com [40.107.249.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4652DE74;
        Thu, 23 Mar 2023 04:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9ycgVq/+9hP4vfe7LX0bxge4RNXt/zk3waLiU7tMyGtmlMMBQPr6aueDdH6DX9HE2OUjZXYeE3IVrRRTh8v6Z5hg23NQuAnGSTcvfR55ETdxd1qpLetQTtl5DG2jf8D/GREAhSRSu7JnBySCqz59LqS+lXO/BeVOhS+IxPamQzJOFvma7/nIpsT8edFr8sLmg0Sz0KcSZ+sumt+SsmEQiIFImFduRlrRvuZH+C0RhDXyyddi61e3XOoeIPsAQETWiItefXeZkR0b5iBJhkC3tC8b7VZX0QFQQIUrlRytrPrfQbvbiOZ6k3W4Jmyl0oHrg9eKaKzPc3s9kxFdK4gvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huTnq9zFQIu3wVd4SNt0MvinA9EgU2tzSa9U63adbmQ=;
 b=dHYUMiQmUkpi2THr8EWyjBtEPmou630pl+3LsAPZgz46bUwP5gFlvqLV7bwZO8zkxAP6rKxpJD7NvHShuI2+1xYEB+pa7R7sBCuaSHo8p4FCCIP8Zq1zUDiZj6skfkB9L7w3e+Uc2CaOb6q9Uy1wBH7GLqOZ7ZdDe+fM5C260xLxVD2vBT9NveG91Shmdnbh+GkttOSp/tCw6HKSfGvLO1Mv7f3xu1+f8225qZK8ekunqj/ryBRzXWvSPBWZ7xKYUyMZWmdGOWZxkOoAXNo8kfF1lmtGZWoBVdDmvRk14T5oJzJMo8aEKJrvUD5dyYC/zUNwy1w9OkC5gH53yPxMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huTnq9zFQIu3wVd4SNt0MvinA9EgU2tzSa9U63adbmQ=;
 b=J9nwb2XFEnPW1ug+6a9kbeJS1MbFObkM2fmK3TJWoMBAVoMBYfj9D8dWP/uqWKrnIXlcpLq74j1KjjB6A9d/XrAs5LP/gUtuwYS51QuvW9SeRWTE7SkaJKTgkSaRUNwM+I73cCAapWyFbKROhO6HPRa4h9fb0gvLfBczQB7y+2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 11:12:38 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 11:12:38 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: fix crash in lpuart_uport_is_active
Date:   Thu, 23 Mar 2023 19:09:23 +0800
Message-Id: <20230323110923.24581-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS4PR04MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dd35bd-4e72-4ba4-b63f-08db2b8f8321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTW0Y0MrFO2uy8cre3U0H7sRjYpuzjCjM4iwOlFwdwNuxLBot4uln+GH41OLh2zWboevFbPeKw4C2nMKogiKrZxXFOiAEsI6GVlFYMcbZHThaDYdD4ef7+3H7+ZNYODW9C3xMkvXV/fuki4nWAAUIZT72Ix39leqsbJyYeFEyDbAwO2ZvnJ6TvHOSweEDYWCmnbHattXFZywiGtddIc4RBDGsQEYqHTxgqaLRZ89pvBB16982DsxV2nrK31liAP4Go8jpRPr+qU5bp+mWldc5FVqlWQFthy0HoOoo/o3X0II8VhshgFTpLcHT5ERd3DaY8kbsb/84epoPIL3xjQ8MpKHRRNvnhzxGWWAAJ9UIoXvn6aYUeIL1xpBl5uCOmi/N83mB9THFBO6K615UVnen2Vn2/MsKDrMCr+6bHIiTrrpa62X2S1KcoACTx/oYjnmPbi1M5gJ53k4SWq9WAsAhe+f7a4/labDQgh62cs3a958F3CIsc/vjTqE2MAYZX4SI6+bXjM87oX85dUFKd6k/x7zBmSruiRa8jfRE2Roz/cIcY29WhYe8t/nA02ThUEQprFehPpsHQsxFyesaVG4Io/49unC4VpWvys9/y7f2DdrRQZUt3CSS9Gfgybc8irPNdkqAzLwnPupGh7LVYgOPQhMX5o3dZI4FAqMtJEdJ/eb7OMpRxS2ZC+OsWZ1LhPOi+J4LsW5ctdqPjx8oNabpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(38100700002)(2906002)(38350700002)(83380400001)(478600001)(6486002)(2616005)(186003)(86362001)(36756003)(52116002)(316002)(4744005)(66476007)(8676002)(66556008)(66946007)(4326008)(8936002)(6666004)(1076003)(26005)(6512007)(6506007)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KYqWllz4zJcu4WHynuSFywtVnWzgfLXpz2aRwvBoLC/5Yb8qxW3VEb2jCa+l?=
 =?us-ascii?Q?o8UNwGLIzq79S3er98aMWCYa2eCYwu5sFV5EeacbHyyCRknPZFSW9lUpiqzm?=
 =?us-ascii?Q?xhWIvmEmK+qeppbzaJwFrgi1aNJ2Kq518Xm0/dw+gb31BRrykGxWtztz+UUG?=
 =?us-ascii?Q?vNDwgTmij34u2HLiqXdz4PbLXVblBBtx7lEcq3/cTF/v7rTJsRkzKuQQQX9v?=
 =?us-ascii?Q?DxBzbhd/KAt7viG9AKK0lxapexmA968v/baJmHwhVKtIgSq6AxcirbLtyqKd?=
 =?us-ascii?Q?GQKlZwtHZSQzXGW6jj1mTiql5ZGMitNXkZop5UD1MrDSov8eU4PNWVTxtxIX?=
 =?us-ascii?Q?GIngaZzNkabxJ8Qnppj/SvL+Wf01hGWEDMaG7EckW9T2cCdTR5AKkVI2qqTJ?=
 =?us-ascii?Q?pL28A5iV6vn52J38891Lwl6O8FRTj3EAYqoxhOdTKcZS80nA79KBg0O+HjI/?=
 =?us-ascii?Q?s37p3WL33jlObxKiNZDAggw7A7+AcDQk8Ae9s+NUoyGAfkaRjHQcZo0DpV0D?=
 =?us-ascii?Q?KWlfhEfNsQzc3pQ2z/cTbw9W/7gnRiWMcJKTOkoPrfuleKkeW6UTzRPT2h3Z?=
 =?us-ascii?Q?dmkIGx5GFkboG6BE5yPICrIKo3cxaBjHCfuVcoVDJXyQDZVGdY62Zf0v4mt6?=
 =?us-ascii?Q?RuxAN89BpfS4gdq7fb8+k5L7MQKfwW2jVvivw+jiGoK7seXiOdnw5RF6s2/N?=
 =?us-ascii?Q?mToVis5TS3LdQQ4OoeRgQT1k5rZxBPZDcKSr9SDEUtIchC6xa3ZDZK3RgfDm?=
 =?us-ascii?Q?0jm1rIClZ+GrjiX8yby14+pJ1ZAl7jCXcEur+tyktTqi9TdY7Xfxx5QVbz5l?=
 =?us-ascii?Q?R4qzAkhplA1kifPGeaLRKtIB1+CKbEiVhxXYX/VSA+cZhvhF3SmoRg5c3VK4?=
 =?us-ascii?Q?0tYa/eC+Wdkz56SOY6TvGCMJ/nZWjhWSDQINUZHNWt8cvVoIM73uubi0bLrs?=
 =?us-ascii?Q?f9yjsrFwm7XBJEgBADS3vgPnyAKIJOPmnNCB4A23ruZV6ZSv74JNjrHS97nx?=
 =?us-ascii?Q?aVmsKILfCdzia68k8bpL3lX2bZP3kisJq4CARIzYB/Mrw+YqKne0DoouxK8A?=
 =?us-ascii?Q?MhMe9L5HR6byQlr1Y4ruE2jJeiK6uQgvA3WaZSXIljtq2YkrrwG5gpioee8v?=
 =?us-ascii?Q?IFXtTFRdeTEfDHyMMTGdLJjGvEUm04/6FsGH1F33UIPYFH+6LYWGergHLR8J?=
 =?us-ascii?Q?roQ+3H1NwZeWD3KMozXac/ndBZGEbt8n/+4ktLrCoWwf8axMZ76pUv2OA3ja?=
 =?us-ascii?Q?k9o+iNbB6QoHezY2pWsfipZeAfptnFJUV8jiFV0Pg97jdwhMlvYDJYnXsnDM?=
 =?us-ascii?Q?hEJ/Uh2VPTtJ8emLo2pf7v4+gDamgLM391Ww6bGREN1i7E+fXLq60aEhIouW?=
 =?us-ascii?Q?Kab67ZyA1EgkZW430Bhytwnxmu3vb9LYswo8u5wv48DVrEEEwrFCMneL/zLQ?=
 =?us-ascii?Q?XIaC0gJ9U1T33Zuv9HK408afvV320KwG46y4oZw02uaTI/uPyxzrsJzErkuq?=
 =?us-ascii?Q?TNCqlYUuurQr9EW5b1g92U5niV6vKSCaJJCNjvF41ILjsyHBpBpmM8XezO9T?=
 =?us-ascii?Q?9u7IvQRxnx9zce4jSJ+qq72FpiUMhoFGwSGJnvyZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dd35bd-4e72-4ba4-b63f-08db2b8f8321
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 11:12:38.6367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bi5TF8WedQCpXL0tI+WJ3kVC9YPtjwrgiRxuBdKIebn1iYbPPndsy3nHuoqvNSV0kRV8YXSiSi2dXScHvtsf4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For serdev framework, tty->dev is a NULL pointer, lpuart_uport_is_active
calling device_may_wakeup() may cause kernel NULL pointer crash, so here
add the NULL pointer check before using it.

Fixes: 4f5cb8c5e915 ("tty: serial: fsl_lpuart: enable wakeup source for lpuart")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 3281e81e1723..8daac87d063c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -3022,7 +3022,7 @@ static bool lpuart_uport_is_active(struct lpuart_port *sport)
 	tty = tty_port_tty_get(port);
 	if (tty) {
 		tty_dev = tty->dev;
-		may_wake = device_may_wakeup(tty_dev);
+		may_wake = tty_dev && device_may_wakeup(tty_dev);
 		tty_kref_put(tty);
 	}
 
-- 
2.17.1

