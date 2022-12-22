Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE465436F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiLVO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbiLVO47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:56:59 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282F22099B;
        Thu, 22 Dec 2022 06:56:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZJbjFNT13ow3e4gpS+YuAxQ0hIuzl6eU0Rvb128g8gRlyNVOUad86tMsxrxsgnJnLCWNg4+kocLImaitbVTxbxvrB+fFHqnU70Qlnd/BtKAcPwxkotpXD8ItbDMG4jU/PNhF5EEAQwCUWbtAD1MaUHyuxo9vap81gnzOwPd74rIwyoinUShH73zaUa/IHkpIVswRv45vEnF0i1SaViaUQ2TkyPEwN5HP4vKecc9huY4sliJwuzeLS/WnTTgf8pEzFDXYeXJqCgsniLOhLv9MWG+J9CO7tJZ7kap4Zy4ifil3qjfNuDVNvXhlazr+SZDXtbCBhtXMUPDopCOlifYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwXBb+M+ekhZFaA/bOzEnK1rTqm1cxuWQBpPXmRg/WM=;
 b=OILt/gnhYO8wyfyLtxRHOUXCk9mWp5quN37xFwa4GxN8wmlZGdA4JKKAGeL3aa1mRjGNSNnLekr8WfGXlilWAC18tqdiYPIOKGtvIIT2RNFmhcLi7b9eCSyDj9QnFzTAqdo+KdpHN4LUB33cEC0bMuA82keo888RlrPs+7iJ0zIeSqhGiLXMwihXeGwIzL4VnB9aDF/VF7r8OVyGLfMiB/aH8Sm89nnYGH/qr8ET8RSmlYZ87fcAoamDgWYXGZSm1kC6EO68Cq0uzElAt4LkSN6yMjDv2cLVRzSLIbuKOc1RHBFx10eg+eKiDY9deFymTuxSGXJXOsD6saamtdYC3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwXBb+M+ekhZFaA/bOzEnK1rTqm1cxuWQBpPXmRg/WM=;
 b=lbYnUjPQuRT/iyMy2Rh5MB9Jxoqk3Pw+gbhP6Xv65vlyHVLGxGyHu/7TfrakZlg9pny//IfbL8Mml7cIwzQGKU+i9MHfiM2rGSRevaqTmOfP183XP+XT4pOUDRGdbF5achXD9GHShb/LfHRhHkQhpCY9e9SRkHORGR7ke013GDKNREsp1je43IBC5HDWg5Dawnu6eiTCTu9m/x6bfsMg+cbD67oW29G9TNm0KMZhXgRJbP6y+OqabJVY6pjhgQGs64lBL480B8Yl0uIzI00mPXtkdABh87acprkxrX4CkYmekvR7THC3Fw3hxT8DbO/N70n+/nAWOyTVQ27fJ/tASg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AS2PR08MB8808.eurprd08.prod.outlook.com (2603:10a6:20b:5f4::14)
 by DB8PR08MB5481.eurprd08.prod.outlook.com (2603:10a6:10:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.6; Thu, 22 Dec
 2022 14:56:48 +0000
Received: from AS2PR08MB8808.eurprd08.prod.outlook.com
 ([fe80::566e:8bca:9034:ba3c]) by AS2PR08MB8808.eurprd08.prod.outlook.com
 ([fe80::566e:8bca:9034:ba3c%2]) with mapi id 15.20.5944.006; Thu, 22 Dec 2022
 14:56:48 +0000
From:   Nate Drude <nate.d@variscite.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sherry Sun <sherry.sun@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>
Cc:     eran.m@variscite.com, Nate Drude <nate.d@variscite.com>
Subject: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to eight
Date:   Thu, 22 Dec 2022 08:56:34 -0600
Message-Id: <20221222145634.2217793-1-nate.d@variscite.com>
X-Mailer: git-send-email 2.38.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0430.namprd03.prod.outlook.com
 (2603:10b6:610:10e::15) To AS2PR08MB8808.eurprd08.prod.outlook.com
 (2603:10a6:20b:5f4::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8808:EE_|DB8PR08MB5481:EE_
X-MS-Office365-Filtering-Correlation-Id: a18a6e31-4ea6-416f-c21e-08dae42cc071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iX9cRhhHpke5Km+VEOM4k2LMBDTeYsfDOWeNs49oJMNqMAOvF4Z1gCbbJpVtrDf9H28qf83QcjBFnZ0eOs5pj1hvchHHGMOgq4m0Sf7MAAf+O3Zn8AXPnxCmfGTR4bobxGDLXqel8PbRhbDx0oDwPOWacvqTLOdJ9JxXjHoY8sjcSx/WOHUFbEr3NTySMMhsEErTmoVfLdSGiOE9PHSaAj7T+QA9iFO+vDLAha9J+hPJ4DHT8fzGgmgV4L3CP2RWFr1UIqjox7EJzXmVwDeN+xhH+4wlUmmPNjyIRei+Rj7WPoV6W9/53FdGlrwrld86qITp+Kh18VVCyKq4JdCghyYayn/eOzisfGvIhgJHtMUvtzfF9HmQNOYZxdNWqX65H8h5z1CJ5F+v8RU+iCNEkDTt4X4JPLmzim31VFDct+IRMyeCJ1JMd2vUNaCxSJcHhq2QHqox/9/IPYFhRiqNr93kntvloE7qb69W8mSwLG/oangDnQ9BhxdkMs7lMKrEa8wJPHw6xjOyuzlIYlWSqO4AQ+xqoWK1CwAcFkprKW1v5wACSZFcgDb/rifgWU+U+sK6xfFUNDnzCoPyNEECijb/qU2GGWbdWwjig3t0b08yIztzGUQ5l/WixqlAvD0M6TdhO7JhUI6ORW0k6LofTGA9IPltyxYgTySFX7rUzN7jg7T+IvbFl7i7YkHocQmDWiBUWf3nLTHC0dHvbJVC/J44XUfnXdFrEU+juisVhMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8808.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(39840400004)(396003)(451199015)(110136005)(36756003)(2906002)(316002)(6486002)(6506007)(52116002)(966005)(478600001)(6666004)(86362001)(107886003)(1076003)(6512007)(186003)(26005)(83380400001)(2616005)(8936002)(38350700002)(38100700002)(66476007)(41300700001)(4744005)(4326008)(8676002)(66946007)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n4tvosauzdoNiivw97mBO2YNJliXZ93+swLhHQOZuG950rU2mutMLiH3mNCA?=
 =?us-ascii?Q?/SYWbIq+KdGkdgcF9ayezc4IQvCB8o3bCev0T87uoz8dO8EyGASrz447+nuR?=
 =?us-ascii?Q?NpNGcMSLu/CC4epdNk9Wi9S5zLxIxkWTPytWaP5aJGn8JDCL7LJqwXgZTpoW?=
 =?us-ascii?Q?mp2gnzuSKFwKrmTQoOqXltRxKieJ1mCOTGPBdIKSf/uwcjF/rCwHjHXKXDR8?=
 =?us-ascii?Q?fBzFxlqTNPDzG56r3vGIpeuC89jdmVvemLP23FUlQvJairiF6Ag+BxPJxYaU?=
 =?us-ascii?Q?WQ8Z3M8gPIwYWiNAQ6UWauXFC3R2FeyN0WOk9W0M5d1n1HqOq3is5tlRWJdd?=
 =?us-ascii?Q?T/Zxhvak7ubuRy3oSKlm798jQgQJxzj8sb+ouibck84HsRPXcrFFLjY1drBK?=
 =?us-ascii?Q?xfKTauNK6anK3ITpadxzQiRzPuxSC+cxJ4CFPrCC0CqSiDpt5QRD8UoeQVxA?=
 =?us-ascii?Q?9csrJwjihQjJR8jOV13tj1/SHIvjl8bDtnm5b14tU/+NKRe1X5gAlJ+DaG7/?=
 =?us-ascii?Q?WlSSOcZXYF8TLQKYPM69OGziF5FqgYhbnRcFFRksozRfF2o9wJuntfPvi/Xh?=
 =?us-ascii?Q?iqk0ZMyE/I6WA5tUGdUdSylew8LW4CG2x3lDPwQ9XEoAwZSxUk/3UNC+YIZp?=
 =?us-ascii?Q?uVnXMhoDDuKnBZufUhIiTGaLmhG/J1cGkB+7zozlqAlKTYF+8btLzP+PvcOu?=
 =?us-ascii?Q?/YqWpJ8DBNGZZP6nhsghKmUiA9ZLOQY4f9S4lX2pabz6kgPco4hv4UJjQE4d?=
 =?us-ascii?Q?aP2dOB489PFoteO2obsGr3qDcQeNR2l16mSb7SD89USQv5MlM5qzy/tsAMOL?=
 =?us-ascii?Q?+oqKmtdEBQz3nIavws2g+vMJU9iRLs/Rf2nQx/a+xzCsxXhmwVctdgMacJbw?=
 =?us-ascii?Q?TokKp6Ia0g4++OEWm03kCaYf88N6kw7IDmNrqFyZPuKnkNzuT3Fvgrw933H8?=
 =?us-ascii?Q?L4wWMIr0RK1+3Y++oNhLrsZ8biNiIwuSB0aWI2UxmEr6dbkonCV03ZOY/rA3?=
 =?us-ascii?Q?XkNCkx8CiyvSCRoXKOP8H28elgJjpnIGWJO7dPm/EDFP1Bk1UIMwRvlmJSh5?=
 =?us-ascii?Q?R4QrpFouiD5VKU5uJDzlONQY+4/NlcI/qSR18pWkgk9xFSqhzfH12Tu4qX0N?=
 =?us-ascii?Q?TiJ29WWSIVfPOe6arWQr7bWdYulHBu6Z5Iris2fFcTspRD9+sIfZ5XVdkEGy?=
 =?us-ascii?Q?KgFY+yMs7q24ccpvdbtGTToe1S3EFeeZv5mxNW5weHH9Y/Hj2Qi4cFJKazfe?=
 =?us-ascii?Q?QHFhmdnSeS0kuXNRJA2g7hG81TaN/AWFAmFAxBA1iUuJS+5EaSPVSwrc2XaT?=
 =?us-ascii?Q?Le54ZHSKBUHYZk9/bg6jgZZBy77P2dG6j5iWYqQQdROhul4re68tyzUbuECI?=
 =?us-ascii?Q?CWApi3cq3mBpbcnFLak977Yemf+OfZ1qDpgRuFKXUHQC/0QXM5qh3A/8+6Jp?=
 =?us-ascii?Q?0OVY/C50Zny/twRqWwMkQ53HQQOFNikt0NB4abf1SmxyYrQ4Ulm84VIfNegz?=
 =?us-ascii?Q?XT7Ly8TuwmPgSpOQWvhWpq/I0EI9RiiKMgDuSFJu7jVmj7x8mw7A3vEdgNay?=
 =?us-ascii?Q?wRB2jyeSESqghpC+r55hiwu+N60DDtHcl3AKqAdq?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18a6e31-4ea6-416f-c21e-08dae42cc071
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8808.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 14:56:48.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRWQuZc9Yrkdz3wqJrzOCpiFQsr5NYdAKZOkBgrB8L497EV6kbJtdu+R/8tL+DSdQJTox61dn6a/wDT57N5o1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5481
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs like the i.MX93 have aliases for up to eight UARTs, see:
https://github.com/torvalds/linux/blob/v6.1/arch/arm64/boot/dts/freescale/imx93.dtsi#L31-L38

Increase UART_NR from 6 to 8 to support lpuart7 and lpuart8 and avoid
initialization failures like the following:

[    0.837146] fsl-lpuart 42690000.serial: serial6 out of range
[    0.842814] fsl-lpuart: probe of 42690000.serial failed with error -22

Signed-off-by: Nate Drude <nate.d@variscite.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 900f9a0e4a5d..2e4af8e7a5b6 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -246,7 +246,7 @@
 
 #define DRIVER_NAME	"fsl-lpuart"
 #define DEV_NAME	"ttyLP"
-#define UART_NR		6
+#define UART_NR		8
 
 /* IMX lpuart has four extra unused regs located at the beginning */
 #define IMX_REG_OFF	0x10
-- 
2.38.2

