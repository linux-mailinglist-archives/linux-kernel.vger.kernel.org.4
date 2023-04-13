Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBF26E1170
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjDMPv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjDMPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:51:09 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05401FFE;
        Thu, 13 Apr 2023 08:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=He2zaOcFRHo+cl7O2MOqUrhAHHObSFMkt5NPFffssnOB7Xb6/YRrLxxPHY5PJ3sp/R/r3TggYADkUsot+3I4pCXLDyS9ceDxVESwyMyAS2rnCg1iRuypSp7VgPwZkDXSl8PNhpbkSDskqTGTEnPFpyZlSkA7YE78JGm3k9/inCrEbn7nfuuLli6Rw2rPgoAu3KDbXxjvJonSiemV0cvbo8iOegElU+ac1JppWe2GGyG3gcwalMOc4zjl2/D2VlcnSwWq2P7W2c1Jo8lcl2+ANVUlfgX3ZyOO9DM/rik3sGSE/8+YnHwrLWIh8fh7asa1dfGQ9rEbZx8XA1xvUz4C0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prx9PeZ5g2rquvDx5Ip+BVvDR5QuT/nArwEhD2AUIxg=;
 b=AvUpp2mPWWOjh25q539eq5fILGZBcyuIayPvKwb59iX4g5VqKoMiBT+/iez8dj67OIJJd1RfPh3pIUt87yEJJ38gt1Eh4zAFktqqbZJ8rpI4FkabvjMKFdUnPz4V1Ducnzr7wXBpo8f6wM2Og33HFyifHoNUDDOLI1Rbk44hfMGbYHDq9mHKQ3gvPB41VF72MsAg0SLQsED/SUuVEZSGm+6wYa5kpcOSYjGdaK2S0MG8iDEDcPwtDlJUN9Lj3QJogZ3LJS2cAwdraF97ekkxSNWBJNWPmFJjswVd4C+Gcx4W2WBOf6NE2SAPCMCR8O/o894kQpw1JZPVymUDLYOnAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prx9PeZ5g2rquvDx5Ip+BVvDR5QuT/nArwEhD2AUIxg=;
 b=b+5kuNgL1uNBSYaahqLn8LSnXuV6DQoOgg4+2xvi1HX6y6IiF4KEcIGisLcJDua51E3/xo3ubsMdC/IDz3N7i+t3sTywqWnqMa3DrUKJiGu5003vcbCeTnk5TcHST2T3RPJMskMEFwNgsRBDSSW7u+WlHHaStYvhlmQQTWZHf/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8752.eurprd04.prod.outlook.com (2603:10a6:102:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 15:51:04 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::3b2b:11e9:91b7:465]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::3b2b:11e9:91b7:465%2]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 15:51:03 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     pawell@cadence.com, imx@lists.linux.dev
Subject: [PATCH 1/1] arm64: dts: imx8: fix USB 3.0 Gadget Failure in QM & QXPB0 at super speed
Date:   Thu, 13 Apr 2023 11:50:43 -0400
Message-Id: <20230413155043.102307-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::9) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c693f07-941f-4eb9-6dbc-08db3c36e2e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0uRacVnWISXakrOxNmlGvS/aMmgcawWKGoGx6/dioRGx2qhtfPEIABGiBfL43lpAOfUhGlqMUvs3mIp/YxDy6tQtjgc3uEOC5KvCx83xAz2BH8lFwjLoMbygpuTm3gmXSg668qKPRa0FIVqt50OBpcmpMf+mg+GFyXX/ru7qwp2WB22rsIaLMnGATyyox5lodEVn9wNoQVSOhXVpTcITASsPiAYAurYWE2Ve4U9PfGUO+iWTONicAiTkc4EL9mX8ogj+rE7TaGkzjxMqkGfAgw+3eKp5WiNc/lpvH/YvqdgbUWEHy0Gxh57dAxnNHXDjvC8sXATbWDGMA/ZUWq7lVnlHk3xfF4AvjbY5iOTWOzuDhApRLT1/mlw1oizwe2UCeOGgNdcNqTMPqXlNv2rtX+3ep0340ewzQQ36TOsQxCJQvjUhd1LJhyDYRb6Yew2CAdh5o6SuhWPxZYwf2t/iWO9OYGEYlZlkx2/cuC2x+BRCy51iBM6knWNErGxVE51a7qFTiVeprhD5f7cWfEFiVjtDnnpB8mRNvXHY/2s8cmqzbXVRvybCGcJD5f9DSr30rf5kcNfnf6iXP58HL6JSul4Rzo3qho8BB8ApTMLOCESsUkMWuXgJrsJwwiZOebGPRIOUFL3POaqxlAF4H9ZoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(316002)(38100700002)(4326008)(38350700002)(66556008)(66946007)(66476007)(2616005)(5660300002)(41300700001)(52116002)(6666004)(36756003)(86362001)(6486002)(6512007)(6506007)(26005)(186003)(1076003)(2906002)(83380400001)(7416002)(8676002)(8936002)(478600001)(921005)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vVMRX4XRqU5Ax8vSQ+azkpOkpJmlzDcIZ5RWTLMk3kufQJ+C9Ul6v+H71wMS?=
 =?us-ascii?Q?YPBg8Tcts0bH9g0dl2qRbpfnwzjL3pQumOZypETZeVH6MUfAasphbM9gcc0+?=
 =?us-ascii?Q?j5ph7u/Ch0y2vNv8wmD0vYSwYm24W83rdKGtaT0327ffmIGvL7s3SfcF1/ct?=
 =?us-ascii?Q?eoJByI9T8Qr1ZVTKz3kWNqa4eiAaSwre+GPo2r8CkYY1PkXWlvGoFWmuk6+b?=
 =?us-ascii?Q?3oyK4CDIpXnIGtJxUpf5LQllxyTaRmPHwyjOB/BviiVPKrSmpflHDLtAUP6P?=
 =?us-ascii?Q?0waTmOB7Gi/2m7uWvepm3SAJHoLMhB2BMEAJo/hP6pD3azfzpiI8nKXDgsFc?=
 =?us-ascii?Q?E97JfRpaJxw5hhhZFcli1srT6YiHMK8uARhO8yyG2LW5C3dxQBS1C/HTrnOf?=
 =?us-ascii?Q?dxOVoHWxro8gUoVwi4WoNoOvVynTJqoL9QMHiUC7gU1XmpRkeyOgUDnvWeu5?=
 =?us-ascii?Q?Vp9YRZc9Tx3HuuONTveSYegtPmMH3OQew157NFW6UfnuLeitSSfC6HF0SpJY?=
 =?us-ascii?Q?n9ivo9tO61+IevJvXsC3AtTOmiliUxUFAiTerf+rx/zQ9T9b7AWtQCH6d8v8?=
 =?us-ascii?Q?XOsP2k0mSPFxYK5s+dhv+Az9SYyoJM9hXAMyroR0ld0u23bw/A2UU4N3r/+g?=
 =?us-ascii?Q?et0N0A4Agrd6KD5WkS+rXPDYYdPKpyP6JPQisu9pC6mJ64yzBuCczFfHXXWT?=
 =?us-ascii?Q?/oZNxgmiy6XgwcmRtE7p4gudx4rMgRFj07l9YAb699MG/XC8AjjY5G4EJes3?=
 =?us-ascii?Q?/c6ATHI9/aKRM0RWlg4NZrI9ysFEofNYnsehQTWUJhL+docQXmQCmPDyiNbl?=
 =?us-ascii?Q?lp5DU62OQzcfAnhoAmFuWdnTkgTJQ/vCI7bLaLJ8I25mgJ/eeSTy4imnzlu0?=
 =?us-ascii?Q?2NneZM5xt7uZvPJsQnxj/Efy946nr2dzPdzHBvbiHHiNc1A7zzum40vxt0dU?=
 =?us-ascii?Q?zhRDa0Etu/PKhCBQhpE6SSkz6N/dfcDOBds6gC+lWgtujmhoqE1pFNezmYXW?=
 =?us-ascii?Q?1PALvWhJufRWVVJI/2jP7hLbeVlA2pt+x0WayHS9vSmsyb3ZaDfuh2pGxAlM?=
 =?us-ascii?Q?cs3CuYL74NuNzR2z34gF5PmsFc4usLO2TXxgiSgikZOwqp9VFMyq/IiQnx+I?=
 =?us-ascii?Q?2VrijQgwb/wy670DYbMYHeKdC8ODKYQ8LyWx8VttbfY1BDh6ZnwtFwgAIuP8?=
 =?us-ascii?Q?IZgVTDJqOTva5xANqhAUUQXukFbdz9CnweJ+y8/xs9QqRgdT983kKjcE4hMr?=
 =?us-ascii?Q?HGBfw7ZbxV4kyQ+G6Nt6i+Q6deyCYI5McX1qdvbUVPG9yw3akTUVqtJ+a+Ja?=
 =?us-ascii?Q?9M5+0MC6MWfY6gWI31h1AGPxpxQH3OlGMiBdkZBqroWRpxZ8hZdorL3jyfVH?=
 =?us-ascii?Q?d3j+fm3bf/ubXCEY16bMUJUJSnaJsrAxQKb2pCxkLIYM0Mwhp+9UkhepOp5D?=
 =?us-ascii?Q?c94Ilj83Ocmg87YHz05vwM4/tqTw70b9sXFOX7DCr5eoV/5XtFfsOl37x6mf?=
 =?us-ascii?Q?w8EDI0Dppj2Ne34AYpJrYBGrNDcXlItpJQXECMObgDzkmUWCdufUSSEg7v4Q?=
 =?us-ascii?Q?21+W0z4/p4435p5L/YSnyTKRD11GPd/vvYA2R7rl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c693f07-941f-4eb9-6dbc-08db3c36e2e5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 15:51:03.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5emL7uy0ir8fvJfCz0rvHSRjB42xsImBo1CVGQ684a3j4ckKgmQF530FgvL+o6KmkluIVgzINkGlCEhHYTKuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8752
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolve USB 3.0 gadget failure for QM and QXPB0 in super speed mode with single
IN and OUT endpoints, like mass storage devices, due to incorrect
ACTUAL_MEM_SIZE in ep_cap2 (32k instead of actual 18k). Implement dt property
cdns,on-chip-buff-size to override ep_cap2 and set it to 18k for imx8QM and
imx8QXP chips. No adverse effects for 8QXP C0.

Fixes: dce49449e04ff ("usb: cdns3: allocate TX FIFO size according to composite EP number")

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index b32c2e199c160..030c273c8be40 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -171,6 +171,7 @@ usbotg3_cdns3: usb@5b120000 {
 			interrupt-names = "host", "peripheral", "otg", "wakeup";
 			phys = <&usb3_phy>;
 			phy-names = "cdns3,usb3-phy";
+			cdns,on-chip-buff-size = /bits/ 16 <18>;
 			status = "disabled";
 		};
 	};
-- 
2.34.1

