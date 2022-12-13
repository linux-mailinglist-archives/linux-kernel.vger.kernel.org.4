Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3877864B45E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbiLMLm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiLMLmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:42:50 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636AA2669;
        Tue, 13 Dec 2022 03:42:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKxefQZoncnArcgY4U8pqGnwQjM1d+t4aCDLHBuhLCsPrDPKCK2EbwUTqQg08fr2ROrhhWr0mu9kqebSDBKYKJgy5SWQz+bk+QlaNv99CMUK5QWsDTrcwyWqQJmB1iSk8WktbRLR++IlkBCMVRz6ZJ/IJa/uHCMfREKMWI7DRyaENuhIWrNk4ZZpPBBUEAdosa9G1IS8emaD+l3bPKqyFhRlt5lH917xvOKbQest6WVEVXPfHGt50kNXI9XAccpWRWrZaGCsO1y2r8plD4BjmhyB1hD7MwkEuoD78+o+GSe2MtSn/zuT+URll+9b/vUsrNW974yylbKevijy4nzbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9l36Vhq3JyGMCrdSPAOC0EBoTUN5Ij3qw3mtgku6e8=;
 b=BvKnoZg3NfnWQH+Hnlnir48JeM/xQFP+XJR/u1u2b0+hCXhIngeII2+YICkPis7fmCkwCsnIYA0ts8fIBiDHFaq+NDLgYw9ex2OGudqZBA0TFGAp22geA/gSYjIg84dKswzBCQcBxQ019H4eilSScQ39BGZPqXyYRWj2P55Cuvs1NNOye8YG5wQVgbMmbIiyUAOhFXFNgCswCVS1R0lNc4Gnx3KJ65mKX5XmlLx58fYaw+CgIzITUAknTX8NdG1Ydr7rGxMRqCAKTIJPIFG7TfYzlo6d3pdQzsyEVNhl7yT0d3KuszoOcj4SmXMfUG90X4P1hLBP7zE3c8yLTgsPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9l36Vhq3JyGMCrdSPAOC0EBoTUN5Ij3qw3mtgku6e8=;
 b=m8yIawK5hihluHH5IglPzZpWsrnGiYzXUAKn/g/PKskr1gKqR1+jv1LeBFqTuZAoPIZ/a1sghxhLd4aw7NzwvzIDvWetF/U1gDznh4Wf41p1z19e1X2kfEX3ZuYS7t9czHent8q0cprFhZG9ktglzUHPYVWeJz8uCtp6J97q2jc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by VE1PR04MB7344.eurprd04.prod.outlook.com (2603:10a6:800:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Tue, 13 Dec
 2022 11:42:39 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 11:42:39 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        pmenzel@molgen.mpg.de, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/2] tools: Add identifier for NXP UART BT devices
Date:   Tue, 13 Dec 2022 17:10:41 +0530
Message-Id: <1670931641-3905-1-git-send-email-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|VE1PR04MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e4c116-1f0b-44d0-ba31-08dadcff2358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAePjqO/HJOqC98OllwPfugi0uMwDKh1R8YQN+tnvY+EHWIc6r30Z4u4TamCWFj2V57F4r69vJxNK50N7IwWB0a7OM5Rq5UFEwroqqsIpJ5T4EDUAjqu3qoOfqJinFm4RPdat6+hIQt9QxAuljQJGVho2sY7vhUcZpvgqwgcs/+xE0ReSFsdGYKkFQxVsVGGWgATORBuDyOtcG7XtC/NsWLsZ4n4TM1Ef8jYdxT5OWeJ8KXLTDztvLGpi1crTybp/XZtjLHumcoFXyOkG5VkQt60UXUe4TShyA5IPKijixPMLh89RSfWeJ3LjRyaM0grK5ioFRMteIuJCXZ4T854bfzIBTuOfvftgF1sSGeESDZWJMBp97MVmvoG9n3wGkLXxaFoYjNB7Wf8oyVWLC9orpZIPMurvYccazWKQyNV5CrKcVX0QYCPZ+BQfvDbZUgDr3xrkzArvQdt4+9YCX4bbVvnjbNlenYDx9xqTE6tule1NxKGiV5U3iF0JRmfrbg6lWaaE2S0qZo/ZvdJ9ijvVntJPgokd0NqD0ih49lVDka/VdZhNc277A+WKEoqu4oJH3/sPlxpyxXrXCt0JMu9V/xXeFYDXaWVpTyuGGDxS+KHUG9TltCtmT+2/d6+JLINg25iCak10UNYNBPXvK+/FYG7letqoNU/SJgafNoevnpuKe6d8Ipbud6TBRsnnXGCMxoyed+lrcJVMcJfqfpObw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(38100700002)(86362001)(6486002)(36756003)(6636002)(38350700002)(478600001)(316002)(5660300002)(6506007)(55236004)(52116002)(26005)(6512007)(8936002)(4744005)(2906002)(66946007)(66556008)(66476007)(6666004)(2616005)(4326008)(41300700001)(186003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Swe8l0C5HKPPtq+WcavOogl0p+v5n9HZGVDwLMvcGgybzmayzeLgD9bmiNu?=
 =?us-ascii?Q?AZZYTlpggJCJhbMY9D0lO3tekb/P6rtLrn5PZXTJWdoZ81EecedT8K8xhtRh?=
 =?us-ascii?Q?Nwn6Rm9iiV99aNrtlvqCaErH0CyjKk8AvOaQpCB5Ml5ovwtHhlvtntqjqU0t?=
 =?us-ascii?Q?/ZVnNGXh7Ll6iFA1XhHWwN4RAe0fJCQoSqwBC0I1v9VmtSfZqfIe0ZT/HUcK?=
 =?us-ascii?Q?Zx2NBfqI3ClIQF0hwONo13y2FYuAKLUYWxYMFKtRInOkoVpTUVmdURBfbyE8?=
 =?us-ascii?Q?K5p4SEFsohyrb5GxEEP+oHATz0Vk8+Dnm1XXTginp3O4tGDnk8POk8zGbf6V?=
 =?us-ascii?Q?1haiv9VjKS3pOhrBMDIZ3hDYp4lPd8CDP12HXGipxDLWqfJb9nCiSfle6lh+?=
 =?us-ascii?Q?Uf+Sh9jw1Yk7fGOMVhJYResGat5wIkp93ivI1MP2k8mScxNqPnWS0zP61oSv?=
 =?us-ascii?Q?TAb4OxQDDpfKAKMstawW/A/3hgLCUBmYCXW3XLWtToBYcD757t23sOqQJP/A?=
 =?us-ascii?Q?nACsAGOXxOsiR5Nfqz4j7rclu1SLBdsEkKCNoorNOlta91aXGmwqe1b8zRUi?=
 =?us-ascii?Q?2v1mEuFyzoGwyhCtyc8qekkIEJpMytAFspvZTjoMbbyunxIioRbdQpqr5ZCS?=
 =?us-ascii?Q?c5rjhprhmNcCe0wp2P2M33VIBBtPQwFMRX+/v3BJOaMLY5UupTvFsNBJdnkM?=
 =?us-ascii?Q?0rcsLghro0QNtpDxCH5LCFXtJuk2mha1QD0mGnTJiEr63zmw2siKmKFPC6u2?=
 =?us-ascii?Q?jYko3aOWnEtSKzTZvjg3/iF+pTMzMGpE9T3YbFvT8K5JkcfgblGSqEa0+xzA?=
 =?us-ascii?Q?mk/HhuIqFj/StxaSwH4DFzUbotiwmrRxTPmFuZ0vYDlzOP6CQ/Wo2gJTMso7?=
 =?us-ascii?Q?ymnJ+ibVEIqmpZiIaDGLkrq8pClw+OyZuOalLylDVR06/WRR9IGkYuNG/5Hx?=
 =?us-ascii?Q?hrnwIo/Q7pvPf9P2TSM0nNF/NNKmR+BPh5nytPb5uzqKAqiQN9ZmPEB+H8ii?=
 =?us-ascii?Q?gnQzfo6KE7hGFV2yA3HDVfMZVaZAC3LHyBHoZezVtc+Kz8RO0AZ+eoh2JCGr?=
 =?us-ascii?Q?nINSCig0/78HBdrwbJfuNYBchr5PtZtXyuD1Hjc7FwoMhy4+Ri15QKXUn5wd?=
 =?us-ascii?Q?eTsGETqQVuWwUkxeFqgoSmoTk26oj4EYJ49GQcN1tDXdmVVlGfzo/1H3x2ms?=
 =?us-ascii?Q?fslEMmCynfE9Uf/LdRMm98nM8hoplTdo5Xr4Lzhw69O7i828A4Ca0wUo41cs?=
 =?us-ascii?Q?X2oqBeF0KGtniolKqA1d9lpWLt/5y3G/nJ6q5XhRMlqZ98/eHUkWxEm5csMz?=
 =?us-ascii?Q?WAIsIkNryldijVlD4vQFlW90MQCGwMxuZ+afPQ0v8kaWBSGxh/0n2zvTVsYY?=
 =?us-ascii?Q?5Ensspip3LCaPxHVOshMEcQg7GK+Di+PlWh37CiZHHvMYRd84hZW10H1uCbG?=
 =?us-ascii?Q?aOFvll2qD+x8rgiNeWNbCFKBShVEn5BuqOCET+Zi2L6N5xXvbvMC1NhyMFJ6?=
 =?us-ascii?Q?93Z8vbmBAR8dmaW+K8U/60im7lvH11Hny1CmWw+bi7JUgtL3IDtSaEW9USHg?=
 =?us-ascii?Q?oL2MBPUa1sHW+H1WRGhfaFs5qAF7Wq2brUxZWy3mATL+T4PizGfwNKN9VUZm?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e4c116-1f0b-44d0-ba31-08dadcff2358
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 11:42:39.7116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAIpOyTp5uZmxs1Pt8xFg9NdDFqwae2fQRi00MC0fFZOcyBQ0rcTE1hY0kZ4GCSzKP0x3ARX3pUJVTrldUKV24FgmoXe+XrufZWVchZ3/HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7344
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
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

