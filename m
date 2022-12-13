Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C4264B51A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiLMMYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbiLMMYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:24:37 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C50F1A825;
        Tue, 13 Dec 2022 04:24:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ezch7fZVEzl/yszfK8MqCmZnFSaa/hhqLjjBkfmern6ZUpfQsYehAS7xUqP76C0SCSkCnZfoYgd/6vAUZwhY50ZEd2dJpWfaOGwF8UUG91ykY9dcAmk8uWrnD2xTMyidiI2DstqL9CEx5LQ1stAQefGYF3AI0fiNQ0+yHho35v3FqPvNs74QhIfT7HeT7zBLFPSCeVvJEoXklWjpMMCRv2CugWV3646I2/Ln9f2eBaqGcgrkP8OkhrJECom+M2iqkF4/GYEVNYI5zIzS4cVzeqqYN9wgO/JTHWFbGdgh2c1BostoXBHu/wFpZuM//h/UqDJ7MZHsqFewZFMk8yCJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9l36Vhq3JyGMCrdSPAOC0EBoTUN5Ij3qw3mtgku6e8=;
 b=m+sXDlFhZzWU8eav9Y+zdc/YtXcnP6ZIk6wzfAqtn0ArhJpm9U0G3i0jWnhGTX2Vd/NurB0q1cVIwu1AmZ2H8wAmY7Tqh/tw6sZ968sMamAOzKm+iH63VX58/arSyZg0nyzSPJUrBRGDgvATskw8R9XaUHY0fzsbM+mbenZw9K8XagTmEWCSPGgNpGdQav5W2SdYKvpkSOwzYJVgy7cZUJ4KEirWABROGpSK2qdM/YW+8JUT4AXKmPE0Ryf8Wtt6Y+VNMr4BapbsiLuBwItjUIR9xBllZfHCGEx7VLH5/8zgZxwSJ0M+x+I60AHZBuXTwZ+165rKds3iWQ7L3rSjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9l36Vhq3JyGMCrdSPAOC0EBoTUN5Ij3qw3mtgku6e8=;
 b=peaLmWt1vuWFbCV9r+zrAOmnAHzsYDcWcZY39rb56O48jUHENatvoPGT2G7pZZIZ2jnS6au1bdnRJUcrxbbxS0Wo19YRR5RgfGTcidiioIigQYV4rJiesZJs32RrlcVTlTnyHFcp25wmh0HexAHOSgwiOiAhbonkjxs0piTxvEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by DU2PR04MB8728.eurprd04.prod.outlook.com (2603:10a6:10:2df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Tue, 13 Dec
 2022 12:24:34 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 12:24:34 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        pmenzel@molgen.mpg.de, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/2] tools: Add identifier for NXP UART BT devices
Date:   Tue, 13 Dec 2022 17:54:15 +0530
Message-Id: <1670934255-4147-1-git-send-email-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|DU2PR04MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c0c481-4163-46e1-6f49-08dadd04fe10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+2szEkse5049S3S57BNRBah6ePNtc/IVI3HN87HdQFREKI5Gb0yhshyqFVlRzM3ROjK18v40O0FHSmMnSLlgMOco66ZeuHE5lDuq3XEfyHvwpUd/9sOWVtlxwdYzSnN3/TL3PM9sYllQyqvNuXjvvq2+c4LTmdScIdASRJLxIvVraHIya1PB+euR8Zy6f56US2hi3bqzWvYWEVlW74++S3Zu/xI7DsM/qWRlVuyjczOABFZ7gncCDtvS+VQyBz6zDat0Rm6ZPW/1YT/dZ2Dt824sa+YBXkioWsrcFGi+g2hUIZ0+Tpca9Xb9CwehiKiml4lllvmQEXwGqBG0aJyQuJfwPmH+t17bSfsvELGIPdhQGCGd2fh4Q2xVVmlj+G9XbeWK5eMHo+eVHu6T84eEubMbvs8mKgfoPr3HcQo7ZGSV/f4uZZ2c6bQEHuJSlMWxx+MDTFjMWI1fgNxfgvEDGdff0DUiaCq0xUFDqkK+q+YqecflNIYvJLEKLV67f2yYxxnuNaQ0FwBVms7WubpQsemFAVQKOg/gQV+yQGkIa/W+Rc7C67TL1VgrJpeGx4rrDwMOGkudcyQ8Pet1PGqTcFGWRsZu/wHmCyT1tkYp4SJUoLQyMopUTFFHeSrpBvL/+x6BekJaMGkoQ9itoNM1RSa2Xk+BK/dVIb1zhO/l2qBXhjKljLfSGFzPR3uqDSlQ42h57bLoOU7q4q7VIV4Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(2616005)(86362001)(478600001)(6636002)(316002)(36756003)(6666004)(38100700002)(6506007)(52116002)(6512007)(26005)(38350700002)(186003)(2906002)(4744005)(6486002)(8676002)(8936002)(66946007)(41300700001)(66476007)(5660300002)(4326008)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A6naCr4acojiVIPNhlQcjh8FfRUrLGrQnOfKUoge5R4/4931C+vm6/+NpCtH?=
 =?us-ascii?Q?dCXSxmoylNKDrSjGdm5BENPn45PYRXWQbvepnq9XDEild5GiTFdDKjD5rSof?=
 =?us-ascii?Q?CmqIzKqr1W+x9jqmq7RIqL4U9jAKzP29OqNAo9MQ63/Sqi0e9wPPYHZFLQHV?=
 =?us-ascii?Q?T3DqGJnnD5viUcItBd+JSjGw2Fc/hiZtLnbwiBYgd1msmIkNphNr+fbvoDQx?=
 =?us-ascii?Q?xEPXyrU06+EEzymdws5mJiXUkatjEm6Oun8rHCOnK0EhdsY4Zi85AsEZRTD5?=
 =?us-ascii?Q?uKNJFvYdgAuBiMR+Mj5iYEFDNv7wGTK+D1sL9Ck+hITHPdAsExTmstvZfZOG?=
 =?us-ascii?Q?yY1na5ZIM76BRDMX3+uu/DwvLGtu9mkMtP4JeadoTWY+F4MeOUtVKEXRnOD/?=
 =?us-ascii?Q?CqZGMZOe1ghkJdANNFyxvdakt2ffMAonzlJDe+w5cpICAfoAJAzz1hqaAYgk?=
 =?us-ascii?Q?LbneV1JK8Ga5TH0WCWevhIxn/m6kHmlpyVRce64ULhPcWMhDpv9tDDc6Z0OB?=
 =?us-ascii?Q?FsC0wlbccpqd+KxFBDoN3BP/GdonSQKJMzE4/y1wh9IcwZj9oVc/lzClvS09?=
 =?us-ascii?Q?YjlmOyLmP4fRAwMtLLkazdk05mCG0CVq7ZYjre9AMK6EfZ/M1uegpiVm4Zet?=
 =?us-ascii?Q?Kvm7q9P0TmEiP0WmU2EewFWGmVhTG8YiVqwoI45lMEuZ075Tegg3HiYarq9w?=
 =?us-ascii?Q?ufXAUQQbpVlTJv/RxjnQIrMMIbCVKtZRjzTv3uQEWXRxWa+PvcbTKw+auY02?=
 =?us-ascii?Q?zX3Bi1umXZIBY3sekV+7XIp7Iqm4BNw/TLFrXHNnozFLWU4MVaNROOONvHHI?=
 =?us-ascii?Q?708wCiZcBmnTMhXSmGIniUZcmZbVT2M6afXtEbYKxhks4EV35DwhzEs/nTvV?=
 =?us-ascii?Q?eBFJOnVVYPuiVIGvygwrlHNI3g6NRFJEd/LfpE0kUQJv9jVv4MTwVBEx+/Xx?=
 =?us-ascii?Q?9BoJEaM8jNtgN3fixVYY6BZ6z1kO6R81kS2whD821DrJyWDJNil6BmOq/3Xs?=
 =?us-ascii?Q?KH8rQd6Ax1TGXQV6qNnPCU/L9DbFsqJdq+56RlgbrrDUh6jyLEkn8l+L7KFS?=
 =?us-ascii?Q?AuXMsrl0DSZQQj+tObeRLsl9g6gDZGtvy9IHkYjdaQWsTveLM33pS3ad85sZ?=
 =?us-ascii?Q?LKCEbbg6ksDKeJ69IwIyxeALsHW5vJ9HM9HdIYmTHeCkDInPovsR8uZN3W3q?=
 =?us-ascii?Q?Gzms6HagsQTW0+tOc+03TMxJpXwYYRvvgKNjG1Prw+qnDzKKhUyj0JjwUxd0?=
 =?us-ascii?Q?yHtOhVjaxmuwg9g560bPeiu1cyEzztkAG2V3k+/6rYuscr4bsPCCBDZOPLlT?=
 =?us-ascii?Q?oTaFqfR02OK1jlkIA1Y0ZV1lbKeqGt9d3uqP1UmrfYBZ9gg1ZcMOhg7S1/Rh?=
 =?us-ascii?Q?B9vc5K9dnKPt5OBNAnF9LwMvcgdnTQZW5VOvoc/tThUPqlwXuady0ZxyT2bH?=
 =?us-ascii?Q?HJOY0PKspUrL1laRLFqW0MpFjA+YHApB0xs+KNTRA5RSdkjhYYfHcyHVlhRc?=
 =?us-ascii?Q?++12+5gOqI8tcXv/kVLyX8iJXMviZXds7+xiJGk4Ttz97px/Ql2iYogotVLi?=
 =?us-ascii?Q?mpVnJdASH7AITbI9+bGqDNDv6qku6VQ1a61k2ZxJxLV4SWNyAc5oC6UsOcPe?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c0c481-4163-46e1-6f49-08dadd04fe10
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 12:24:34.2037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MojdYneY+Cvx3FkjtVug4NPQ7l/MjFWJ5tISuvxIj9Nqt+btNSijO81V2MtF/kX9yDeD9p1AfF6E34umyrU8oDYwtmhZSnc7YnryKkC4K3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8728
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

