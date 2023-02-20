Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A81A69C90D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjBTKwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjBTKwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:52:07 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCAF196BF;
        Mon, 20 Feb 2023 02:52:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRlzf1m6fl8vv+VElSgxhYdkHB0zUH0Yki1fYFWlhyHYf00GU/V715N+yDNH7nOlYADsteYN3SKK+V2UNgenq+6jJcOatJBmaXhg7DEdyHjqElaSlX0L5Q8nAxwKnXq86wiVZKXkXBAfKd8y7kf4yVij81uEH8nbiiJRaexOXLpluBQwyD6sAOOUsdRIqRnrIhhVfDjBtUduQ65wTtZJqO059bmiFlnS/E342s9PECf0z5LRjtuWsr0YEWb5OA4GNl+Uot7S786QfVskMxy2zZVwq/6Wjz1GUwQdxbVMxhGL/fPsLvl7c8xq8ojQ7CviAbq6v4X43X2Xn/LvExLtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7jBEZCklkP/XzXteWJEE6Cz47LBC6NYxQELvdV7c7c=;
 b=mGq+BQZrOQt82K8f1BQZzMtYNZpOGADKHE2ZsxFy+JcXgtCnZidoSW+RM6gxIDoVxCQikzZrOR9bQ33uOuMqfl7Rpw6BDE4uVRywsPm5UDD/j9C0oueBrIJ5F+lPa87njhyo56wVnDLSaoTo701DIm/RDyp3POwVfMHNwMmL0kinc+f0MpJsAGddFm48hfngVWmJeyAkVdu4vIPl09sNk6q5a56z4XeFNsh2fYxu/UZGvN+Rv/Pkv7dYxPUswHLAj8Et7dylF3vFGNjm5+ZmzbcKLE4HmfLpKlf7tPH1VUaMLea8DaCIXRVXMf3FmVqzSbnnlpBLnDjwQ2SnccBIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7jBEZCklkP/XzXteWJEE6Cz47LBC6NYxQELvdV7c7c=;
 b=H2HqQ+nJHUUswN0hmNkjEPl5ArI86JlLlBnps26ZUlhcZ815cE9G7jkgmi5OvhGbf74cvSqzwS2HQEoKMEhtcigMiaFBh21qBtXSq2JsxTwkLChiAGa7gwlZtnQ7hq9n/3eF7vXoW//eefADcQQ2KRhjLSlooHQJD4RalRJRDKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AM8PR04MB7203.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 10:52:01 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%4]) with mapi id 15.20.6111.018; Mon, 20 Feb 2023
 10:52:01 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, VIJAY.BALAKRISHNA@microsoft.com,
        Tyler.Hicks@microsoft.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, franck.lenormand@nxp.com
Cc:     linux-imx@nxp.com
Subject: [PATCH] drivers: crypto: caam: jr: add .shutdown hook
Date:   Mon, 20 Feb 2023 16:21:39 +0530
Message-Id: <20230220105139.1450262-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AM8PR04MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: aadda204-0334-4523-7309-08db13307eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7Ou6olipXlf2DbRjgywa5H/iJC8nZlxhdlsl1OYmreLUf6jttB5fMhsBPqJpI6IyQ6sUIOznNwoWpHDR09ZxWRFKlmodgeGdgWwGjd9WAah5DMOsrLlk2JUDJ+nG1Crloc771uNBCj6ISezXWjUZaifowtObfEiVT/w1Ho1MVhYEenBE/XNP6zRa43h0Lxy+o+v6IrVCpvIw9x5ZExubXHnLArAqdovd1kxD4y22/7xFFWwXUvdPX1fVUpjplt9M3udySwbwwOtwhIRs4Ig+EphIU53pIiJXVqQ87XyikW/ummeJ/ZGA82AVgJER5voi6kX3FsNXwWC/vOobIZQzSZCz6IRSZQmVf9q6Givj59hKI/qtWoYIPm5nPNGrJgY1ojlS8nlUs2KmdUh/KOlMHezQG2IQoitkzhFJjPzySKIMFVtDKiFvu3twAbXl3PlgdShmjEygbriUf7fQbomzr/Ew8QjMsVChM0v5rcUDKPGY/0a4KYEcgMsUKfbJnb/MshL6cJjLsg0I0knRIDOo5GIU3NG8Q8kwwvG7fthZzMLyPMFHnbAmd1mzmZuVFhC29Ts9F5k81R/2dohYLPVi5iPBMv7rXLzI6JLYn9svJ8k6v/S41RWxj9Iz5COFBroroloo4GM3kUKeMKjkpPPRMIUHmUOCA8vOitP4rhz66kwbuyg8ZOK+Y6zwf+alVC70/qWit/wjDk9EX7crcheStzKNvrXj/OJXQPY+ZE6CgqGHLmUinOdd8EshqMJQRIx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199018)(6666004)(66946007)(8936002)(316002)(66556008)(66476007)(6506007)(8676002)(2616005)(4326008)(1076003)(41300700001)(26005)(186003)(6512007)(9686003)(6486002)(478600001)(52116002)(921005)(36756003)(86362001)(5660300002)(4744005)(2906002)(38350700002)(38100700002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+qujD54iLmn5uz6gL/kTGwYc8UbbKweVKMCUwFdYlUX01BLgEN69aPdH3Q/1?=
 =?us-ascii?Q?jAWaxo5W1TaAzm6sJGPh9mg0duAtOSVA8LtVV8ZRNzs+ceqG+bMqUnmjk7Vc?=
 =?us-ascii?Q?wQdG1Y/G7cX1ocN/w2dom3Onpyw4g6f/wDSRoVgdbrc3dA2OqX4f9FkcyqOF?=
 =?us-ascii?Q?CxTpoNhBOJ9IRkrGbOJ4kayFo98LQ4WzyKwgaWFE16d8qOb4we0RC0/9PAFz?=
 =?us-ascii?Q?K3V5D1zuBI6SM28LnkBG1ls7Co8d1ibTDyyIdZZqCa+sS9FtMRgHqmigxlxC?=
 =?us-ascii?Q?jVQWlZjgs6TNcoWAvV9ebUEx3FpE6HSMiz5PJ/Rp1Zsg0P9gaYjGNhE5QKrB?=
 =?us-ascii?Q?qkBTVH6WoPaKUX4BdmEZgG87xsgYpsnuDEqisPK8xexq6egnRXCS4mRgTr02?=
 =?us-ascii?Q?34MNR78syOcyCyRPd8nXgqr+EqO6+Co649FszCeN1ir69JPtslydk9CW0p8R?=
 =?us-ascii?Q?gHKviritpKU/sRjp4kQp8OUKNFJ3aXt1sw7jky/nkdOG1vW3BvB306tguMyV?=
 =?us-ascii?Q?i4tgX+ASv76AhEOYY/hJIwvE9Q8FByjHuiXZD3QamhX6FYl84F5bATFtrk7k?=
 =?us-ascii?Q?SBmCMV4j8wWcQ5ZWkxT2HXsMP6tSoAh7kQOaq3h9S0cxGxHpQGce43+yE3Ui?=
 =?us-ascii?Q?rt01zlOZKnr8/5aCzdtkuMXMML599citDnW0W/OrUQRuEK08M5QtPqCERqx9?=
 =?us-ascii?Q?cHPQRCjlSjZ0MZuP9PyLBHwy0k9F2/hR9VDiriuZ83DSa5oMs9t83iXoxNsR?=
 =?us-ascii?Q?icQSazFqDKqcS2oPQr0MqD84oWMxE3y3qC9bE1wvyseh5TRQHwKFNLNHitVi?=
 =?us-ascii?Q?t0BViCXIY4oCwADEfgFZyJQ4+imzdalY4CN9bvWARqD3+iXvYIWG5/0o1+fi?=
 =?us-ascii?Q?X/QgAHgHIVEj7dKgj3+6qkmurrInVkgJ2Fz+AjJgCC6MYZDscksfUAxDF+E6?=
 =?us-ascii?Q?Eue/ysMXZg6pLb1z6e5FalG5166BKhagZDuVmnvielEVMfxIviQfIuQ4jILr?=
 =?us-ascii?Q?oLlGd7xy75UnOxhe0GdVwsv6FuknVNyivNlVk0SYUmDbzi17EqXKTC7/IH9S?=
 =?us-ascii?Q?eTszfixDC8B9cu8kakE675TgpP5yeWto/gyEoJNVfHcRTSBuiLnTrYLs0+h2?=
 =?us-ascii?Q?WFVcoDRRcb1njvg0zTGCr2okO2OI/L1lsq262INJMxmQ3WSgKyONaL5Jz47M?=
 =?us-ascii?Q?zYyC1tF1zE3t26S4CXjfCkr5kd0jOxicDfae69h9YIJtnY6RBW7jO/mdnF6T?=
 =?us-ascii?Q?sb2bR+Oy703f9iJ57TIOuU8zo74f/KKiMvAZLBPhIKSChTLGDOtRWiAj51u1?=
 =?us-ascii?Q?DVvPJwUsGkjSFEKrxDST8bBk9BuKeaXPKdhXoRRNFZ9uahYLULMVANNLgPxi?=
 =?us-ascii?Q?Rug4Fqj2bSu25OHccHY1IT/ZmY7EWTEGPSL0eNbbr9vDIXfKnUSzwN5GyK/w?=
 =?us-ascii?Q?w1EUojzwwXg7VqO4RLDCLWFmc8MnDkz7vn/tMfyzJB30T69TUrrSqC9eM7xk?=
 =?us-ascii?Q?WGixD7i1yBMR8JtmhqJNi2TqqKS+i2Ve7Eyr8wEqGaZnH7XJg7hJ9EHpigiW?=
 =?us-ascii?Q?jqaPLGPvUjP1uMxsrb50nsutkoiBr+C3FsrFbYr5nfoAilhVBiedNEOcIac0?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadda204-0334-4523-7309-08db13307eb0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 10:52:01.1671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N2AXGXYb+BNVM0hSNMniBdGdp5ul82MaszTAiEteBUNYmYjqRI1hvRGqgzaMPOgLdEUHvZwdlx+h+5Bzx+onuOk++1Yekj4/tMwIvhF61o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaurav Jain <gaurav.jain@nxp.com>

add .shutdown hook in caam_jr driver to support kexec boot

Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
---
 drivers/crypto/caam/jr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 8745fe3cb575..a2a99d09b4ad 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -198,6 +198,11 @@ static int caam_jr_remove(struct platform_device *pdev)
 	return ret;
 }
 
+static void caam_jr_platform_shutdown(struct platform_device *pdev)
+{
+	caam_jr_remove(pdev);
+}
+
 /* Main per-ring interrupt handler */
 static irqreturn_t caam_jr_interrupt(int irq, void *st_dev)
 {
@@ -653,6 +658,7 @@ static struct platform_driver caam_jr_driver = {
 	},
 	.probe       = caam_jr_probe,
 	.remove      = caam_jr_remove,
+	.shutdown = caam_jr_platform_shutdown,
 };
 
 static int __init jr_driver_init(void)
-- 
2.25.1

