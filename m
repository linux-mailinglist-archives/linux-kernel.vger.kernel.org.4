Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87896F7D58
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjEEG6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjEEG6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:58:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB02B11B6E;
        Thu,  4 May 2023 23:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIq9WooD8HBrNnRZqrFg6G8DAauwHWO6TmiPDHCMteRE0zxrhfzqXWX5a/2yCpzLZB7OQ1EV3ZeoEy//pE+9vGZ4tLDv7nRevEYwTgf8wY7KQCkERk06E1CYlunVarBAwlGUNLRMQvdrm9s4znWJ+iCnn+B7a0kNkI2/AHSF/uuLDCYMjCZRSeMoMSo/rwY4IJjdiOTCU/uPWuthH5+WamphCv2n/EPfi3ihacN6u9otAM5na6JeTF/6aUCUXe3MpcVwsbu3Ku943k0gO/uleTpfnqbRkxsV6l+HG5kluwpF7GvhUoxqZP3QFK/RD+BXvbBuVrCV5YNiawLTdibq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKR7UhjvxupMGxcZoHyzFMzxG0OHPFSgCc+be28w8Kw=;
 b=SZ1s8vKjBhgkKmb04Wq4DMMW3P5SUWklxV4ER34YIQJhFf+StEmNHX8x7P8MxomsfuiIOywBBV1Nw22Ptm6eVfQ4VeepV6CPIKAKrGtXmUaR4ctVkMRBBDAX8d7Yq5igbSxL6wzvW8NUXS7sHW4IBnpHwoZEanIBllk9WKTJ4eILEPSetJ57YK1XLcMsPGWItBXbt5Ik69K9TlaJbVagWNjBe0M1DKwg4P2DH+I4+5HC+m4qmfJk3acOnuYKtWmM2wwRV4jtSADBQghVizxGdxYAFspgghBbkg3gXYc87QzVP3GM/UPUHiEP9wySopwLB4ZlDAfU0/CX3LiXCobufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKR7UhjvxupMGxcZoHyzFMzxG0OHPFSgCc+be28w8Kw=;
 b=KqBA0aezODk093kxz8D6YMlZxSlLxicdIi1IYXktcjezRPQGPBFGrYTX2KMfwAPIgb91GH1/K5zIXS1jI4eSCUKsTqD07PUbz0hic+UMPAHlpFSh7WOJ+WMRshVgTI9iOO81Zw9DTFci+jAIy0lmHet3vPR3mSBPz1pW58cWhys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5098.eurprd04.prod.outlook.com (2603:10a6:10:1c::18)
 by AM9PR04MB7521.eurprd04.prod.outlook.com (2603:10a6:20b:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 06:58:39 +0000
Received: from DB7PR04MB5098.eurprd04.prod.outlook.com
 ([fe80::6418:d0b1:6971:5da0]) by DB7PR04MB5098.eurprd04.prod.outlook.com
 ([fe80::6418:d0b1:6971:5da0%5]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 06:58:39 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: imx-tpm: force 'real_period' to be zero in suspend
Date:   Fri,  5 May 2023 14:58:39 +0800
Message-Id: <20230505065839.3973693-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DB7PR04MB5098.eurprd04.prod.outlook.com
 (2603:10a6:10:1c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5098:EE_|AM9PR04MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f0c8fa-43bb-44d7-0ef0-08db4d362753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utwAQqKCdL4meb8kvKnzA3OLNuqJ3Rj4uPDf06gS2IdVqfKSC/DeNAYMutPn2Rx1dnP/cee9Nyva6afrSP3pM2xK7Zut7LyiVtWWgEjH5OpLnlTCUNvDwZNY8z1osT/O9REfPwHuzHu7T7mfAwVYD02X1jybjOPZQL4XdpUXRM5MFcvbJOucmoHvl1as0YjzqMiC1mNFhm/8o1cdpN7HkM6bhIec3uQwZ/iJf8vjG0PTu5tW4LI2lDzjW80HKfzfhs3J3u7Cy79z40pWs4nnQj6PN81yw0KjD6sU2c8Hktf8yj94St6Q7oFmNmyW/jcAYojKp9/Gk06Q35Qirk9HAZiUIombRg0t8p/ynhrF11Y6+pSESfZUPOt6xNo9HMeMXn2A0bL/TZnZH2VIlwzoqGETVHIiBn5J5VyQfGuTrExgQihRPsFMJnZwJeCPrgoeV48s4w6MawVT8H7+UKW26+zmdBlt9+5GaZocb0KwRdVvKuy3wO1WiMqQXYhUsYkqhc9oG5t3VwWgyBqzSfeBLdUBVHWIIXh58rYOmoOqSl1xx7N9I5YVlL3gsNgpeOVQQeB4EApbz+AA/HA9dW1FkBLCKkN9UxzoT2vHKatAbHt0pMmhrDFKVO3O72MDXP9A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5098.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(83380400001)(2616005)(66556008)(66946007)(66476007)(52116002)(478600001)(186003)(2906002)(6512007)(5660300002)(15650500001)(8676002)(6506007)(86362001)(1076003)(36756003)(6486002)(26005)(8936002)(4326008)(38100700002)(41300700001)(38350700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ymVMq28DaW9WRnJ6fquszGo2ePJq6HhousPw4fPku1BontZRnJ1i8IB0iSD7?=
 =?us-ascii?Q?PZQ/FIda+vqC6Tw2z0vHEqRfxwy+EFn3FUAVBKK+Urm6yiUIjxJMoILAyVm6?=
 =?us-ascii?Q?D/XDZGvlm979oo74esKaF4jagNnqzHB20mZuN0eY3v8O9/D72+gvkLrd1i8x?=
 =?us-ascii?Q?GD5/4RWmqZZW8TMrgsMhxLIy4PzJIhlgnwHAE1/Gwm4FrRMcGSW2G7L+wKOq?=
 =?us-ascii?Q?SmR9JzyPsrIQt27MulVcdUrsSMXtKgUbaRCvkLmNPl0hoSaJphuBiWI3bEEb?=
 =?us-ascii?Q?ITm6ig5Im/FWsjKHkqpAHH+192urmGyPYymp4zkYoBPlR8MctMZa6GE8Yb1t?=
 =?us-ascii?Q?TYuM8STMfxKf5kQfXPLqjLYlE+K+DLETAcoSYoPgpx57/swQeK6z0az/IyBz?=
 =?us-ascii?Q?haHtMfkQUosIJO3bV3qh1d3mo5ChAk+pj4SZvt6zAfXQ0vpt995/2QAVV31Z?=
 =?us-ascii?Q?xrrf8pAouHlzVkbtxgFKcfNNE5el7mC0AT9Nk0DAOIF905veV6irOHdQFP2k?=
 =?us-ascii?Q?VEiG5vQRxUSqZEctjfMIzYsooNxAPzKlTkoOCMsPQ6HIFcCrvHcQMaLWFzT/?=
 =?us-ascii?Q?0vU7CNiprLWWos+qwafeFgzs9+U4TNIKBEgOc+c1ak9xx/L3OobyowZhn74A?=
 =?us-ascii?Q?7z1/SXCtg3p+X8mvf1JTOGbD3SLDWqfj77sK1FvXsFk3hmh8moRFCq37NuQT?=
 =?us-ascii?Q?o4pAPOnh0ucqa8KLxwn1UoKIpf6C+nf/gQq0oj8cbmvM9eSkAHbMchy3PD0t?=
 =?us-ascii?Q?Ytxuvx3OmBG125VzYqY1id0PPB4HCAD+vGxns0evrajhKkQOazZTDiiTtTNz?=
 =?us-ascii?Q?QdGvwJ80WUlO4KnYgdxPw+8IYMkb4Iw6AaJkdaa932r8rI7WtAh4V8oHcSlX?=
 =?us-ascii?Q?QE2TIZgyzQpPxel5AwKC06X3Javh24NP7DT22gm4KuJ+jv9K5xQw7lsaTKxw?=
 =?us-ascii?Q?VSc+8on8Hd5d9ogubdyHH3blBbMDCGuFqxrhx5BOenKAt14ekeXionuWxyUC?=
 =?us-ascii?Q?w52yVm1OsdgnFFjNJ3KoUYaEU/affrKEZvxQgEmSqNd0asZHaPAB6I+kf66K?=
 =?us-ascii?Q?sFGIbzNYJSIQ5gjsA3BzHvIZWjJ2mv1oshevPxXuaX1oDzls4nD+iZ0yzjUS?=
 =?us-ascii?Q?c91aZH3mW0S/QD6skmQ2EBlqXfpMN/jkr9JoUm3lsUEr3v+MM/iDBc9otbFA?=
 =?us-ascii?Q?Nzmjkmi9UaTsBhpTO0U5nl/yE9JGY+MRrffpNJNnhJDZV+We39lmTUc13m38?=
 =?us-ascii?Q?hKUKsi7UMgZV5zoDVvyqi/0SOUNU3T5YTd8Ua5CE5KTag11GshbdGB2SkW+u?=
 =?us-ascii?Q?UVK6RS0YqOQCwqaRac0Ib6EmniN8s9H+LhVxwafgXlaXuXt1fDSNr11g/wMa?=
 =?us-ascii?Q?QuvTs0cMz29k5zN0jy+/Fh/RXP+u9yScdzSJi+25mli3PDtEM72MtmwXXI7B?=
 =?us-ascii?Q?8vOwmItCz7CAcqy7YZd5DYszT+7lL+UIsLnMhJ/1a4bCzr7JlMvjDvZEW3Gi?=
 =?us-ascii?Q?5ASQjyQWITOBZDfUa5YlmyZ24E/dFP+dBYQHc5pPYQrGjeg0C9kF2k+1i7zX?=
 =?us-ascii?Q?SN5vMz8rDt72XEo0K1h6AHp+b4QC8U31to7v/KkR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f0c8fa-43bb-44d7-0ef0-08db4d362753
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5098.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 06:58:38.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeGHVQS+VFQj3xjfBbOQ9m+A53aqydon7RuAGiTknuSTp7ajpZq4+dxBfJ87FWjNaxzQUZP9Na/fSGEz1kSBqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7521
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fancy Fang <chen.fang@nxp.com>

During suspend, all the tpm registers will lose values.
So the 'real_period' value of struct 'imx_tpm_pwm_chip'
should be forced to be zero to force the period update
code can be executed after system resume back.

Signed-off-by: Fancy Fang <chen.fang@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/pwm/pwm-imx-tpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 5e2b452ee5f2..98ab65c89685 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -397,6 +397,13 @@ static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
 	if (tpm->enable_count > 0)
 		return -EBUSY;
 
+	/*
+	 * Force 'real_period' to be zero to force period update code
+	 * can be executed after system resume back, since suspend causes
+	 * the period related registers to become their reset values.
+	 */
+	tpm->real_period = 0;
+
 	clk_disable_unprepare(tpm->clk);
 
 	return 0;
-- 
2.34.1

