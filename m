Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAE7635FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbiKWNbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiKWNa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:30:56 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9185C8CBB5;
        Wed, 23 Nov 2022 05:11:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzvA5X1Mxk9vo5hfw9jPuYswC8sYYJ5CF6vUGE38KnhqiddPbaiRqTMPk4UX/g6xB8l12Wqyyjygct41K1AU1oOpmkRsMzbWziQqdz/vXi/qhqdr3D6XdVAKWir4FzfFgQhdEVQ9EZZIVTPTri2NIwkKbP5QElQFIeVLypu+j2BqZC1xsNk5YRXtAlOb35zozO5MitLokFXbuy8FozmL2b3p7B++HyK0/SE7VITX6PkoaJAIDOFWpsMcfuqY8o5PcWx7D1BW32I4raAyRyM8edlT9OJDGXEcHg+1Ow736nyp4mTJo176JdfPKzSe/WSPjPHB+xWd7rQ9tPukxsoYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9l36Vhq3JyGMCrdSPAOC0EBoTUN5Ij3qw3mtgku6e8=;
 b=ScJJgGlBrpm8EAP1tFtC5XVoypH9dOdBX3qMzO1dUvuQBl/b5D4G9Z01F1KWuzh7DRHIWm3W0fWGwPQWizyGfoUewtimRcKLmxkVSEjF5g+QhbSbsh75cmcFIh5jMeFM+6bFK18ZiBipyJS92ZwXRM47dq92d8JuqgGFiMhYVj0P65RoMmbX0PvDxQ1KgD3hQJjv3ecCxq4fiT5x9mZAJblGLJ5NOQzx90sYtULcHMxzKfRHhGOVwxrehqEShN1kGRAnyzFEEs1RpyGIaB6hwjEuXiKAbfWUyR0+TbIhKiVH1rmtrjxmAPtZI7UW/E+gsrQGpYGpbI/QWIuDsZUh3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9l36Vhq3JyGMCrdSPAOC0EBoTUN5Ij3qw3mtgku6e8=;
 b=XWbjB9cV2XiEb6jHrCnqqYcPsRe9fBO4WvuUv7ugNMw95VvJcEroIa8PqZnr/yopXkwXWtYvvyDuYXrODy7B1k8Vo/9BXGFbI/E7aeD5z8Vh69m97vTjiNisNHoym7JCG9YuKqy1cRPexCMxhb+b/ZUdCOTYlz+l7mrsDhQeORI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AM9PR04MB8873.eurprd04.prod.outlook.com (2603:10a6:20b:408::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Wed, 23 Nov
 2022 13:11:56 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 13:11:56 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        pmenzel@molgen.mpg.de, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] tools: Add identifier for NXP UART BT devices
Date:   Wed, 23 Nov 2022 18:41:32 +0530
Message-Id: <1669209092-18198-1-git-send-email-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|AM9PR04MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: eacf6aa9-3390-483a-8fa6-08dacd544bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6oL/v6mRxJx34ouW0J9xMlU7lCvoUu72aMX3GspX49n13myKzoe2/rIZ72p8m03WMA2dG2Znn27o8AWZ76RVCGC+oKlMZiTSn8EU6FDfOFKB5FGaZxtYYF3lrGWrAnUiXwSyOaoEJYxEQZ5wbtZJp6l4RnTSGNiAPGO4SgqsH3ZrpDUW2Dkmsl8S++zwYsS2EnzxASCeMWOHXXuHWydbCFqExOHwXMgH+VhP8vIHlkVnl1VqsZ2xM+UBDCFZm44Esz3HDzYorDIMEhOcAC7uNgaynAQyuW/e+ZyXAkispfH2iA7C2sIO4PBnrWHU+Jlhjo25ctvwMLYB74zoZkUIBXqikpN1e7IPTgPm2JlesBr8W/Fa/W9FkgDQifliUSGKFknSjFpyLV7oC5WMDXVBB5fYyu7WOjLOWAXZwH88vm2VguRh/InY3XXvC8GrBmUc86Qo55wqmhDZQGmDFZW9WeLb7I2PkjG+NI6aOlWt6CtOSAcZ1PcIcXlIQwqsm65uN9wyzLv5XAKSvSCkodpFRD1md+ZlwWVal3BdZWfSMJFHGc7pTLaGDT7WGmvjWoatJNVPEDsoVUaQYvhFKVV6WEHQ+YR2dh14Nqom0FFt9+ouRPYlWV0K40lmK0sXuMNqH5l/yVOVfH+bhP0uo2gNGjfzFXKP3luc8g+qbkXUfVu/WnPff3pJXKdWvJsbGyjz07JEyrwcNohDgQMfp44zgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(5660300002)(4326008)(66556008)(2906002)(66476007)(36756003)(8676002)(2616005)(66946007)(86362001)(6636002)(316002)(4744005)(8936002)(38350700002)(38100700002)(26005)(6506007)(6512007)(6666004)(478600001)(186003)(41300700001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ywOvmrx0T8MdhU+XWZFToXiIxTqmcyqtKQPGFB2r+3UwiEXO5WDXy17QjfAr?=
 =?us-ascii?Q?9msEijzlvxIpbzqhvKBEFoRBd53+au3/4YcMnBnQfzPgKuQfetb/YICd17J0?=
 =?us-ascii?Q?PLG9BRypbjMbhPUF2CoKXRY+ww1Qh0tbV1YQlelByhbxKB+bn9ly7ABkgZFl?=
 =?us-ascii?Q?rvB+iLLpg0vndClgQORBt+0D+QWrGsePtKA/d1LNny333yn+izAz3vBZrmD8?=
 =?us-ascii?Q?cXU3IjGYzPfg79sWsDCGzvaX+/3a5YSZJqLSKs4jnzMkC7NDH+AHh4I8Ni7W?=
 =?us-ascii?Q?8vx+06yQg2jASCqtof5Gt3zRUJsDo8EthcSqqYSEGL0FgCboLas5z2SfQBZ9?=
 =?us-ascii?Q?SUy5PBskN5Wja3mrQSSyNxqjiJ3hSeKJ6SfMMa/qAyQ/DLEuAVDKXu9pkvol?=
 =?us-ascii?Q?AabBhLZjHZJzVCzexQ4try7ZicD+eHqghOTxZKq1zSLcZ1DoeaMlYEjOhEMA?=
 =?us-ascii?Q?E7QHA3ysMW5jrscl6RaqPVL6m1vFswQ6yaiHbNXSQ+fV7zMqXXPaGohRjH82?=
 =?us-ascii?Q?AdteKS/asWxFMD9rcTTdMoTrV6XiQyu9H4Bm6NGAkbgUZWWSF22/+JK32bup?=
 =?us-ascii?Q?RgF5hpZN0lf/CHnlhUt8p8LBGqlVQN2gEYhmzo6V5VKC25QqpaZ+NxOPVJCj?=
 =?us-ascii?Q?ULn4kxwksgGJJxC0lUJUxAXFYFTYaJN9MwuIHDV39weqcDBDJA8TMoTRj5Et?=
 =?us-ascii?Q?YMmUZns8CWZkYihfkQCEQ5+ZdxrZWXjAZSNBOnTV2lWaXV3sOFJQw8JurkSs?=
 =?us-ascii?Q?QsxU1RBMjQeqFW94VHWb4568RjjR0UQt6Djg2zC1ZLm+8pQHVgbxUmQtsWLN?=
 =?us-ascii?Q?nRcNX3ENBLCebYk65YnlpRAY8w1fgEg46vjEvEZ1HpoIX25ylC5ArIKRyocg?=
 =?us-ascii?Q?Tvxf+/W2uerP/oE3Y3tBv7QOGXBcHec6q0YS1GXnmQt1NCxRNbkA9kQpAdiF?=
 =?us-ascii?Q?rpL0AnSsbCB9vBmmMdrPEpVIvuOFpWJet9TjEvNIraEq+ALD8IWgqJmNWaOX?=
 =?us-ascii?Q?WVCFhGblLtDUSGuPuF0cVat8DJr8kA7NT951YIEvi7yTUrv2aGMfL1Wyldvr?=
 =?us-ascii?Q?hDSX3KKZv4I5tHzaEKWVmAqXNo9d0cTpSZb3o0ORS4zFgKPtwXzu4SmFJCTL?=
 =?us-ascii?Q?ZwmRK4bg/rGc2ABSkfBDXnb652jaOX5Zub4pfe0WDHfkjdXB4R/9Iv6oqqMv?=
 =?us-ascii?Q?gIHXVgvuQZMf8it4B3cOSyMYz22fS2TWLCiPzHatJ/10WXMunlOTksJWy/bw?=
 =?us-ascii?Q?C0X5HRRTnU+1slUn9+UiRzDCMAUtAL8ybVmomsmJ7Fw749hHVzpkvxSzd/N5?=
 =?us-ascii?Q?JEqDDBstQfBwhjFdfmZJVVzndDvv6DdgDbBaGNtbWYnRzahTZVh9ITKNXNAV?=
 =?us-ascii?Q?Suhi4blEgBKnlB1+7XfoYGwUZjbycDxctj+elqEHzbGlrVa2GIACq2qK4Tj4?=
 =?us-ascii?Q?tdR2Vyu4Nl9x1J5w1GSeIG1938sOld5ihQsStVLlK13HkSOv6jYa88eC7COm?=
 =?us-ascii?Q?3M6IPLFlu8hSFPw96EhNN8HdGXrrstUa6qQM7c32SBeOfRtQxfWFKqGdNqHA?=
 =?us-ascii?Q?h165cycXG63dXK/ZvbCTxOvkwCN2lp6VSkau1C2D7/5p+djRWqvzWppSS9b4?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacf6aa9-3390-483a-8fa6-08dacd544bd5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 13:11:56.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lXsooBhsfnvAFn79QwG1LhuO9iIP727D6eyNBXv/dx2pNp6Q681l0uQoEGMNZC0MPqYmFKGoFnBejOHERDAssQ4Vu6sXd9qwW7zQQlYm+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8873
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
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
index 4ce1be7..8a30c5b 100644
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
index 26c0d54..d62cabf 100644
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
2.7.4

