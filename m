Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4ED6A2F9D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBZNBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBZNBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:01:00 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED8912F06;
        Sun, 26 Feb 2023 05:00:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iECOtQQLjXAmV30lvhSzFVH66oTb0qnF+SnlrdK6qWBjTn1uJfr00/l4mnu4pgFX09CD+nracyZLIKze+r1za6MdA+IfOS6JNLgmcF6moCNt/svRpwXXkrXxQx9X5XZGuDKA553jqJpJB5imrm5D57RalC2ppINOyUcJqwVBodlOK3Fx8lp6xQnuHfdLc/feaSFh8PLeNo0Uw+No+GcRNXit/vgCoaqrLj2bma0AZY2YiG5+H/ovYx0Pb0zCwwUP7hWbtZDeCtlTOEyOonRerfvB4t7+sdAQsYuHxXxv1AuTffBfkXobc1il4NtaE22mNMcEeYeFq4xunmS7HjCYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4su1aOj7lVci/jLQbhDsijghLuWngMzCPKUa9A9iLQ=;
 b=XYRSU2kqmRvv3KjLfJEVdyBpICTNXBleTxkVAKOwfaCTL7nYBGVDgUAWMgSRfshG+4RNWR2RFdsNKCWDi4F0KxWIek12QUuURs13zsB5RJtW7PkXF6AKXvzFYk80NWQhVqV1Efd55N+5f5llm3kkzguuLQk7iQ0efn4bc9opQ0fBElG6WCVUseukeoQh6WSO2S2XFX8lG8/UDBj1OoJmzICLIw22jCaYWroFXnWSvCyxY9zxbWmtTsSI9RPW8jerlN0uLSTeFoZ9GW9yY3QQJ1Pfbg6n/vWZSlyCATtikml55CM5Pduc6490ygpmB8Plxi1etBdeNb9dTdzOU5lTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4su1aOj7lVci/jLQbhDsijghLuWngMzCPKUa9A9iLQ=;
 b=UPpIQ69SLseXMS/R0TEBSL/5F/8q41Hmy/78+511Sp8eBJewRgmhCJ88KAppTUsXJ/cva+6MFq5SATGt2o/GbD9KnjLnmC8MAhjrxewG+ojtRwVps8BJRv3QbGvML3NCGF6n9hh4Bw7NlOY9vYY6DnNDUWfigbLvPV0t8dyUFhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 13:00:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 13:00:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V3 2/7] dt-bindings: usb: usbmisc-imx: add clocks property
Date:   Sun, 26 Feb 2023 21:05:34 +0800
Message-Id: <20230226130539.277336-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230226130539.277336-1-peng.fan@oss.nxp.com>
References: <20230226130539.277336-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 964b1f44-1f39-43f2-c044-08db17f97713
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXd2+G6x3+2qgCaAGkixfldycr5HtkrXEfkf+mqihUecK+prW/bWaOOrlwRtZnQVRmVEcFapWrvfmby7jxMwy1iAEnUOfH0uZdL2l3XCW/C/Iu6PAGHES7WACMufd11nGDkOR2XfWn2ba9uv+FWnJoTg4X0NhTt5VfYL5kIE45pO5difyaNNNv+/b8WUP+en80mv/7fL0WR0GKRoXmT+1Xym5BtDVRKwOSjx9teb9TShnM+IxoZqn2p0Hq9MLvF9rC7pkRSamxuG1v0X8wMUzwqPeCZ+743e3AMod3dfgnwdXtjuQOydWmgFW4yViPePm7W2O85RW/BrAUOsotSO0J7Ci3S99ckk3YQBvwpd7M10jexok3zITe3t298k4kDmmeFxpraEUZkCz85Ujfrmd2sUo+ffDqwe/AZXde1i3Q/fXYsdvHPh/1xozpovR0zGT6IUO3NqvOX+C4lIxr57nqnHy789+22L/3pntOFb8/hDvAr3/WcSAxXbeuhonPioB21vR/lxmpzSqTNyLrit/nNpPFL0L18VTpEfyo0OtJH1IuPTG3uZgsRx+gydfIbUCXWdTSP9lhku3isVZfozuprJzXaL7p8SyGKxGLWn1Xy7zjX+sE/cXDOgo3QxVIF6bjuJPXAsBvo6OeJyVVghzTbp9pSO69wIG4ny2ySL+XDiwveeR+dQG44HmxivHRWQVDj0DV4eetNXl2kKNng4UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(83380400001)(8676002)(6666004)(38350700002)(38100700002)(86362001)(8936002)(5660300002)(478600001)(7416002)(2616005)(26005)(6486002)(1076003)(6512007)(6506007)(66556008)(66476007)(4326008)(4744005)(2906002)(66946007)(316002)(52116002)(186003)(41300700001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WzgdN20nEwGdkHiTlDk74MVu0jFM2SKxHNEJ3ojLpC5ubZ9V4fe6jIN1WT9g?=
 =?us-ascii?Q?wrEXV0z3VHOwb9UDthMgGkilmhVks8OcPyc+AJBcWEM0DdWUQ5lz4LORymG1?=
 =?us-ascii?Q?CbJeY128TanF0w8d72wcCyzh4UXKD4WdY/EWIzFEbdNfKoWmJoX26NJadRji?=
 =?us-ascii?Q?wMb1+KwTUFqLDDm2LfElsMH6UDTKFJf6dR6vktLATXFreQRVEyVMVUL143hu?=
 =?us-ascii?Q?Ec0JngfJ5CdoGV18ueEh8SQxdLPLVZgT4C4Qxna0DzDglcO4upIaehjDWh+h?=
 =?us-ascii?Q?WUXn/rjO0kqtOPdCV9pTvvPSvPAo4quxOccev2Q2sg8zafBX0Bl2ctg1PdrQ?=
 =?us-ascii?Q?Uv/OXvGLFQD26EJyc/rHFUbRquDgfnTWxTD7ebPpgmHiHVgr+pv1sep2O+ND?=
 =?us-ascii?Q?p4n10RPGBO1AMch12czAUDk2uMJtLoGxW8RbdnM8CX0wmHRdRVaBLghgERGP?=
 =?us-ascii?Q?9CrAHmxmwqGFMa1y/Gikj1/6G2LuTgG5sfBQkxDeYfpglOIIu0NmWi0HeCib?=
 =?us-ascii?Q?DOG6iSuqMV9/spA3FMS/qhqJmXpScG8/zgnMB+TklMNANrVesgj5VSz8Jvve?=
 =?us-ascii?Q?4Ud+eZ/XNECSoEE7lhP+7WRzAs9NqX3jqoVqWIT322q5odZozkGi1sth0W7k?=
 =?us-ascii?Q?nowaNMneVCiFT0sSZSLRGE/XbDINowk2INUWauaPAi9xYAzGe0H/7yeLynCH?=
 =?us-ascii?Q?gVmv1VmRFpOLWrtMZlqOs3IVGvhVKU8C1KtLqLTxYbx7/ktFCvG+7Fm4gx2v?=
 =?us-ascii?Q?2zay12s1sl659kDqFLE2YKF6DJuYLGpatVCjV/B+kxnuk135C49jxWnA47MJ?=
 =?us-ascii?Q?lv2iBkvQQdu8JPIVv9ILWqboZsOBfoDPJ1ylAMBxdkYxHNpZl7GhZu1KFoh2?=
 =?us-ascii?Q?8z4fhsiRnhYqV+srNxA9c4eGXqoqjWEjn1AgggQmDgu3N0mDxTe1rTPg0Hib?=
 =?us-ascii?Q?sb4cY6s/Slib9aiIJhAuiuT+kBBtcO/dHUH9Lb/lB9f6peW98X0+Tlemluxp?=
 =?us-ascii?Q?K315wSYVhAb41qCh0GSLZgyGkRuEm22HQ9ByRl+p9nlIcu4vK6vTWb/r0X1Z?=
 =?us-ascii?Q?ZZCmwvo/qWmck9RQ1SU+URcx8xOTM/niruKSaJ0MTh+0qiZP1N7WrJeNtQeY?=
 =?us-ascii?Q?i9wHvY/oMmiNSUeWW77WOeXFH1kfY2kt4L6Dr5op2a0iyH4wthIJIEbpj3SK?=
 =?us-ascii?Q?sQVrcDV2D3clQLFkPYxAra3ijEerRdWg1FLcIvjqmLJDp/ORDa+yFukHv0ML?=
 =?us-ascii?Q?UTBsxEmLyNjslnWYm47vq+VaoZiS7m8V9ChT9meGg3qA6UMKuFg+01QM13QJ?=
 =?us-ascii?Q?5AfNhRKXWk8Sf9keaDy5fUAZFeXcNpDBaEBtufI3hpHR+0C0DG8l5GL/AhWW?=
 =?us-ascii?Q?LRts2LDAib7vFZsBgwuuMP9TfammBU3T/qkVWys7fAYThVQAMG69mxct6I2H?=
 =?us-ascii?Q?JwTPw1QSVMjKC8Qptg0T72SoQ3d/4rvWKArmshBb6KLk1i7VWSgdW5SoMthV?=
 =?us-ascii?Q?H+xFFtReL32sGtoOnztlf7mITNf+OU4BKIpKeIvQEmoKkIxR2tGB5YWSgIh+?=
 =?us-ascii?Q?5hSv+X3XGKoDqQBAHxgFhQZcEQ4yX70iGNyRhn76?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964b1f44-1f39-43f2-c044-08db17f97713
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:00:41.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5gnNqA6sb5KiJbOV+BK6LRvyjAJDv324pa6QvrpzztPs2FH/h1iMGr8mmlHyEONTKDnKlmMneHcojskA5Dsrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8968
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add optional clocks property

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
index 517390b9d2c6..37b982c1f97d 100644
--- a/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
@@ -29,6 +29,9 @@ properties:
               - fsl,imx8mm-usbmisc
           - const: fsl,imx7d-usbmisc
 
+  clocks:
+    maxItems: 1
+
   reg:
     maxItems: 1
 
-- 
2.37.1

