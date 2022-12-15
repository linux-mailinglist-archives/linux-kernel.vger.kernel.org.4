Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A495A64DCD5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiLOOXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLOOXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:23:47 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA612A40C;
        Thu, 15 Dec 2022 06:23:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4TyYXkxLoO8ZD0yzeRJYH5Rd5PQsuhJb4miqM9m7l8R6vtLitcS20txZPP4xv62dK7uv3DyyYvuuVrYvJOCUZIrIZek8D2bzIgAPTKZ9a91aqe+OOEqsdEX6n4PDY2UIduFOakm8wBCzuLLB18ENWdb63cQa91Hsf2iPfv8paBC6HYa0qEOlEk7EeFQa4jNYf5rOZx6bjvEFr9pziv1igxRjGCNvzFxTq9PK5nIqj5oZ+jljJ4cwqctdGuKSolT6/104lsZLx3zcmakygNew92MtPVb5myuXxzKzh6eHd5UgAVolOnGUjVoWOsHLGcGu8PauiFW0sHY5dfEPyAZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cfG+LWsgth+JOhn8We/0dkK+SmKX0vt/aRGzQl7D3A=;
 b=klCYahWSXb2AagOwJ3ZCGuIXFy7XAUnKladuMzANjZssrcb1xx/2oTxI0UiaCH0jz2TJpcDtEUF5XXFSBPwfkgfPTr/4WEhAO/QafsRP2dfVUs6yB6gZsMdBiTx2ZgJvgqfTMh1Lt35rSV0TGaPh/WXNQGLZFu8euher5/pKxuYj7rw3OhoNEYqzJwioPr+XIreYP9A6fiFSHGRH5MuC19kFlcMbemY2D3sTjYFZAwtjMbpUS/SWx8QtO8euHZO+Gk3I3s4U0fVD7dnj1KOnOxumu4x1VyD6dUu2XoULtf7XWauSA1CcFfMa7gdGgbqCaD62RGszYQKbEAQnq5u0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cfG+LWsgth+JOhn8We/0dkK+SmKX0vt/aRGzQl7D3A=;
 b=TuMT0ldPihVoN74rIw2TYTx3gAYi7ervsv1isHXOuafL17SdC/8TXWnuIk1we7t0I+cs6FhRbaAGem0ooECOLqy6YAIGQAApF+arc1L9+3UBEKp9NIw3wd66BKo+pg5ya85IG+ljpj/6Ry+/OOmLx49FXdz4J4DrDyG72UfwNoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AM9PR04MB8400.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 14:23:43 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 14:23:43 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        pmenzel@molgen.mpg.de, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/2] tools: Add identifier for NXP UART BT devices
Date:   Thu, 15 Dec 2022 19:52:49 +0530
Message-Id: <20221215142249.241195-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|AM9PR04MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: 69902169-872d-4deb-d5ae-08dadea7f85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYgTIlPbN4u1IX4FUXRktBW3rS5u+2z2sAMAGpQT39mSlSE+TCJ//zYcRhH+zUyKgAT9Vrl1sESG+C2LORBhDjGJREtrF4veEliztHMS9P7srxF5S/gQf0E5b7pTViPf6ZBI48OoTBkACTmkUE/IP4ufkZ6FN6Qh5jogPXTdUCT/Dm+tlJYbFD3SwYaFX7dYfoYa19V+I47ZoS8yJOM0MGbStxWj+dXmPIdAUObrQgKCpdeeFyO8KNHbea2GawnjCr5kJK5xo4xoe3MpM64Ou7q+iaSiiWVgSo/p9Vv1qAWfZMia/Ay0y8vLmZzx2x4MuwnFkke59SZ7zh1CThNAjwOmu3n0whHZC73ZcktZzoTj0n7L1GvXDRpBl2Np2UUiQI+lVEgSMJocbTp6GbtvB1iKIE2zcNE7mmMCQ8vp1sqUBL4gqfZ7nsOUjJ4B8L4+9jzWTmxotZP4NmumvLWZW2chCw9+h5pEu3u2VvxWzXTeOkFnfOQIlsR09KnndDXMjrs8dZ4PwwPpXCp9yqMt/jNwB4qRj/MTzcTusNwO733CahYcvAFkMnpaRBFGd0HeNT7JTWQ8V8FEKUW2cahdA8qdr8CJDtlRbPLNxxgxZN414JU4tv6xVV7RYYN2A2HoYvHRtF98GEzN1QBPyIuSCxlRvFH3tMTcBekMz+VR4y+bGFpmPSC12e27lartByEi84253+vNOw+sCOILNgf3jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199015)(36756003)(38350700002)(38100700002)(8676002)(2906002)(66476007)(4326008)(66556008)(66946007)(4744005)(5660300002)(86362001)(8936002)(478600001)(6486002)(1076003)(316002)(6636002)(52116002)(41300700001)(2616005)(26005)(6506007)(6512007)(55236004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KJrXIyemNNqvQWTZwuDh8TVfCANcW7oWClcRLmmLUsBFPYlscAS+p51VHCIE?=
 =?us-ascii?Q?ms940BhAG3N2FnIqNcvqLNYWXrUh7+Y3afQBkapBrW74AVJW2r/ZWbFJETiY?=
 =?us-ascii?Q?eb1yg5FWA0knBdz76tERjAhWjQLjDtFy1b0RmQjnrSae7x4la+tsOz9tM788?=
 =?us-ascii?Q?DFtU8xbGj18ZuaFQVHpcUI15W2XTIweehrydS3o/5eDiYQsyPqSjyZ7o0/4T?=
 =?us-ascii?Q?ZKlmuwslQnzJGlh/85DpP+dcdRwIY9a4M8m3MkvkceBWxRuzIqVs/GKmOqfv?=
 =?us-ascii?Q?bWvGCkYAFqrHlem+R5y/X7bGEdLvQW8Rl1uLKH820kEssg3/oLkgWcidjIFZ?=
 =?us-ascii?Q?GviYoqpKLlTvYI+gHHBJF76lafQmGWvBva1B2uQzNvv3Grwm+69FfXCbJ9T8?=
 =?us-ascii?Q?HWR8WSpBUpfMZQTPAVo8DOYGi0vytc/GGofWWPUjrGgo+XxAra5w63w04m2+?=
 =?us-ascii?Q?bY6rl2KEOpG3m6a4OTZR6RNqFnryj8B0qTBhLhOhprndy5Pr8iufQGZqi54s?=
 =?us-ascii?Q?mALGPYJXfL0Lpr61fHV490m3rbusaxL4roascHR0ATkZimcm1eq+MIWPYNXU?=
 =?us-ascii?Q?a2MP/HNHHO7Pdk7nZEBVtA7qcBq4pHJ7dNtDOYvLCq0yXJoy8TS/14fv26ZT?=
 =?us-ascii?Q?ZnXTTzYVqh7omxJ3Qblsa1KAG8vyRvbQcYCv7cRKpEvOYVFbelDQgTctjmFR?=
 =?us-ascii?Q?N+8kMjKaJOp1aq6QhlgnLJXebmWLsd9hvOxmUlVAS37qTQ/TI/H+oSiDyAcV?=
 =?us-ascii?Q?TqHiCm7WLVQPnPb2x74O2h0OO33JKCUl7/pem1fbE7lXMN9eUYbFJz4Gg/aI?=
 =?us-ascii?Q?osHfDMJov1ObD6ox0VImofnUSynAOqjHHer/6BWfLchlWPIDOGYGaPEgo557?=
 =?us-ascii?Q?69KldgKfGe+o17R//CWe7768lLQQSJZ+YFFT4shKbKHuJTw8kVFdHWkgjVan?=
 =?us-ascii?Q?vX4aRozPC709gW9xB6Cdgj9IVf2JxDaMwMHe+EHyAz2tAzYLJsQJxYADYUNE?=
 =?us-ascii?Q?smGY7TikKWVgpkyusqCo+2Hk4ZPm0DRuEU/hG7/4g+SjZ8Hnjy05OnDQLlj1?=
 =?us-ascii?Q?aw5+Al7hjgn/82OFYjwb19eFMt9Z9AEdSxTF5lML58vbE9vQ1xdRv3UfK4W8?=
 =?us-ascii?Q?WrzNmxKYs5mqxYMkzGQfYul02Oj8B6+cLnbxX0yPDvxbC8QukNqIzmM/DH4G?=
 =?us-ascii?Q?Se4MmBB43AWbFZOFhlEDTduFUksc2kuEh+srXsHPj6FVpAQWryR/qAQvwHym?=
 =?us-ascii?Q?etwIrVn1D90Mi/8r48rTw49H859+5biPO2S3qWHOOcaFoAs6/3BYbaVne+iF?=
 =?us-ascii?Q?fNZ7wVo6pn61xHTLrALQ044XigAk4wVn0DU3MxKPaxMnCESqjCPyXG//Y2Ba?=
 =?us-ascii?Q?ctwvhpKid1WXBIcOBmtnInN0PC35ILZou6bPYgMVKQDKcRoawY9kWxwognnX?=
 =?us-ascii?Q?JXsiP8hmRJv7nJvj0K25tQZOUaWcwj5Gfu7mAwlNxUffFccNPU06WYrLkkSy?=
 =?us-ascii?Q?T1ruGA/q85JlIf5lnFqYn3G0WpGb2phDSAK5tG4wk5o0gE0j6yu5fO+SpH1t?=
 =?us-ascii?Q?NPlMtkzA9WGbEj2LI0mnCMfyYBLyap/4x+3/bGA1myl+2iGnsoMLhL7529Ak?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69902169-872d-4deb-d5ae-08dadea7f85e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 14:23:43.7652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vr1EgQGWyxtl60cqoCREVJLllMH3j6K2NQq6h5pljCFVxxeFwYMYvLPLQ94Tu1qWnhW1JbtbuWt7gSo1211hsZ65eie+geAaYxDYr6pBhuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8400
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add identifiers for hci_nxp to support NXP UART BT devices for btattach
---
 tools/btattach.c  | 1 +
 tools/hciattach.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/btattach.c b/tools/btattach.c
index 4ce1be78d..8a30c5bd1 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -212,6 +212,7 @@ static const struct {
 	{ "ag6xx", HCI_UART_AG6XX },
 	{ "nokia", HCI_UART_NOKIA },
 	{ "mrvl",  HCI_UART_MRVL  },
+	{ "nxp",   HCI_UART_NXP   },
 	{ }
 };
 
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 26c0d5424..d62cabffe 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -32,6 +32,7 @@
 #define HCI_UART_AG6XX	9
 #define HCI_UART_NOKIA	10
 #define HCI_UART_MRVL	11
+#define HCI_UART_NXP	12
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-- 
2.34.1

