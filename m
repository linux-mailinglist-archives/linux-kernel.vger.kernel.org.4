Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D95F638772
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKYKX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiKYKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:23:50 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1E941982;
        Fri, 25 Nov 2022 02:23:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+xxXvJyuhy16Y4Awp/och3iJnQpTtARWFPqgmBqK5OVio16pFQ0GtAe3hrw6UOEX1WPJEhDVODtDl7rWU6nRKrbxCAgDca/X4qradk6JmxtNhOM9OW0CHXGlys7it8+HES1a6/V61Vp9Tx5MiDOoYwS6uf5CT0HOtbcyLXP4Zw0mwQgZK2ioD5oBJ4rUfWikL7Vy6ijcKGDkD+d9XuAmyXLLliOFaThDWKixXCA4K/BKBuMGOqTx+0YQQc9oEoDIP0U1k4Dk6o1StuqR4i6qUCdmdisSurLEQBqznkXiXc/zzkZbVoO5HfX3fWMFW+uXdMCMDSe6hW6x08feCoTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR9XO/rjSdD3h8ydWemhdF1l8LqZeekBPDfF4XzmGOw=;
 b=DZh4erEu5YTVZcWbfgUZ/npjFp5/EXWIasAcsEY3k/Ql0qouuejkmWqGuOZpIx4HJLb6vvU8O4RxHKeVBUrRYxXDSomkyZzyYBDJ5AhbtkA4koM6rzXIRN9sGCCEPnqRi7uHlwPSfGwL8JglXC4V1UkInZrf3+BAHB4WeE9vl0oUtXkdMzPE7nhKkrddZftBerFEteLzi3qLcjp4SEtZ6JITpg1zQ79tPKLe5A3DXHVvCxi+rt/EyfOjZkSeHLLNbWGtQhJbaQlr1+luANLMdgCPluchY4wj3W5BfahNR/mk4DnrfiVF6avO36N2x/JmlSwZFcNOLnFUqg9cYxa9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR9XO/rjSdD3h8ydWemhdF1l8LqZeekBPDfF4XzmGOw=;
 b=NdgL2cBa60eGMqRomC6s3cFcrAR4hcmWZ0eLBbvmZpNCVQMSZQH07fVpEVEzzAxU/KGKOyjxNtyNUhBVAkWn8kWMyKLNPC/gpt0Qi90b5BSlitt+JSi+wJGmLUyxhPy5jo9E77Bs+qO/RYfP0JacgCXOzbYJKyn4lw2GSWri9VI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR04MB6927.eurprd04.prod.outlook.com (2603:10a6:803:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 10:23:47 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%4]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 10:23:47 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, atsushi.nemoto@sord.co.jp,
        tomonori.sakita@sord.co.jp
Subject: [PATCH V3 2/3] tty: serial: fsl_lpuart: disable Rx/Tx DMA in lpuart32_shutdown()
Date:   Fri, 25 Nov 2022 18:19:52 +0800
Message-Id: <20221125101953.18753-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221125101953.18753-1-sherry.sun@nxp.com>
References: <20221125101953.18753-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|VI1PR04MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e48755-a469-4bf9-0ab8-08dacecf2302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZd35gmEQyEY7WCSaLh0KfdFaa+Zviv+etDz62faWWBjrjDydJeZKVZCxsacpkEhIWgYyylHWDN17rr0OVaf19bUIlnD8+q2hueYI0Y40V5xl3tpgvaC7hFrNHG7GZL77xs5xQ7CGU3P/rpF8d+g92bAAF9x61kORYbom2h8I9LTUw8ld+oXFhZtdmx6esSFkQ2J+j2SfPTsfq/LJ6575YC5ZH5HNayie00NoLvkwEZFHeXU/B7GKZ0U2S1ASOtXCYYds1kqB6OTRHpbGD7bVqLeK3EE3KEeVESc4MMFKDNtdK6sKq0KsCOD/t0gbIQx9mJdmIt9yeXuMwTvLUOjfgxnJk3s74AQ9lPfVZ7dlq5e3Px4qhcScDRUAcgDDcqGI1EubCp7H7TOMiGkFk9s2ULX35lzxHBxafG3DcWK2Qhy58D7/UJRYDvzuXIOYG5uqtqSwULJxJRhh/0P4FcJdHMOruvY2jeo8fF8LVN9lv4U6JnGRTVrQGdIr7SDD8bofw0jf7OGrNIUms/mOfFkQhB8W+L2An5BR6cRYwYKMowVSloldwKAMPLzNRgk6ffsBTo6Zguu4weZ301HA718BlZYoE6niK86NNsOlZgFPTExGZWMfUghfLW4wVykk5CeOrO0Dz1rSANYCVXF5PpWC2zZ6drEVpSIDLXu6UbO4v3b0MfX2vfwA66/Z7g9XKKTxNYb5P8Nu8N/eSjc04T2MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(6666004)(66556008)(36756003)(6506007)(316002)(52116002)(6512007)(66946007)(66476007)(26005)(83380400001)(2906002)(38100700002)(38350700002)(4326008)(186003)(86362001)(41300700001)(1076003)(8676002)(44832011)(2616005)(8936002)(5660300002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JTo2DVud1fL1TO2w3owc7WGT60FrOHdqX0plzxC7auOrv2Y4f5LeJf3J0ORF?=
 =?us-ascii?Q?2jLP2JNpukS/+ktXzn8K95Te6xLswAWuy9pBsHPASsUmODvr/7BngKw7DPL9?=
 =?us-ascii?Q?dSDaDFkzk+9AwBlMrtLhofMsR07ItkR4m84nQDHOP25bLKEUyEtADgrdTz4U?=
 =?us-ascii?Q?zoMqHkRPQfoNPdCMUIEplPXuoe1/s1SmixbQb2QS0Xz6kGyFJKPiX8k9CRzb?=
 =?us-ascii?Q?lEgXxt7lNC803c2VllYNsza9alsiWQEoGpFPG4xb6sEuQVS5gf6QrCCxl7Gv?=
 =?us-ascii?Q?/etPFmpJMf0dTHiOmYJZs8FiNpy/VkRxrXa6lOnlR23U8kNioxjFvUQ7XJiw?=
 =?us-ascii?Q?g53gpyd/oElQtD9tZdf+N5tAxp4TEoOr+XNSWEJYDWPujTCL2zwLVNg9CWSk?=
 =?us-ascii?Q?QwghaVKsZ8gnyhEWlDplI13CtqkWPMe6EL5toS5lxjSUtT3MIVWyc+WnHtuZ?=
 =?us-ascii?Q?CL6Ld9UTBe2zbeA9S+7Zd7F4YpsV6aDcDr8CFPROjtAM1KBzLac8jrdsPqyR?=
 =?us-ascii?Q?yzc0OEEY2GikNjeWxIJGjF3yJo4Z8pPrGookF9q3VTLCeo8ACdNOZZVGhLy/?=
 =?us-ascii?Q?KitwmPXrPpri1phIb0jn0Frv7blwP3QGjTGZHYSgrSI+4kFPGHThkBxUUiyE?=
 =?us-ascii?Q?iG5cyFhw3NNW94vkirF2ylVfijsr3go0ch0yO9e5Fr7rrdPcAy44VuIsETQL?=
 =?us-ascii?Q?FraoadzPjI4gcVKXASasK4dk7POvDpNWdxNLCVid4HQz/U+UgW1l18/tIUq9?=
 =?us-ascii?Q?eUjxDO+xSlvpnes1FwX78t7FA7lCuMe1/loIPe4BBUikdT/tRhv0b1SCMTI8?=
 =?us-ascii?Q?qSzlNLvzoaY7UqK59lHLAipltggXoUkDzL9ZlLTe6cFL717Cm9G0Lki6vxz4?=
 =?us-ascii?Q?nuU/8o4FwFjIYlV/53JLJ8rVc5O1BBG7UJXYkhAIc/qrqrn0+3zzaFPhvIWD?=
 =?us-ascii?Q?lypCup31u1NSt2Y2dB5Ht+0bQyfu3VQEQD0fh7VD5aOuakqu3w+mc5TlMNf+?=
 =?us-ascii?Q?M0ky2Id4/4wYCsH9H7mZOEZ6WnSZE6nwmh/99xm02IrneFnyJl2RtIxrPws1?=
 =?us-ascii?Q?wcBEpSztjDLk/iE4w+nPs4QJWt9A9gDvHyU/FkJpmqHePQL83hyMk9X9oN2T?=
 =?us-ascii?Q?iC4NrYUFR6ZeXbFJdZDijpCuOjRo7plZ10e9Se3JGVj5nlOPNMsufKu7Aq0n?=
 =?us-ascii?Q?D4R420diaOEdMqOm9NIN7QEixe8v2zCPlztmi3iW9qInCPbQU/La3qHDi2iI?=
 =?us-ascii?Q?3rDy15WCcPNs8S+QNUSnxHlhW1JilFPQFThpu0q4g5OyWSBvv2YhKma4LoLB?=
 =?us-ascii?Q?RYbFKD3c5l/umuvilTPN5tsdh4VzfHsSb0RQ4twbpAgQcQSYSvztyAvkPP2K?=
 =?us-ascii?Q?y09qiX6SJF5FpEmwyf+miquzsKRCy2FQ3aK0IoY6jqHRVOB13tJDKc9Xwmei?=
 =?us-ascii?Q?95zFsAxtGM0nMJJK5N1epyrhwLmZxrAUAoa5obCol/n6EYAm+6aLPn0tS2zz?=
 =?us-ascii?Q?j6Cf8M7mdYJKt5oLPz7wa0GxA/blxfgl3C+v1u9L8xwk7TYg4MPdfLq0owWl?=
 =?us-ascii?Q?a85bpv5vWIyYMRz4u7MSVmBdqrnQejl3Kvd+Te8W?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e48755-a469-4bf9-0ab8-08dacecf2302
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 10:23:47.0059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpjBYtH7ZJ2BxHDTfQjytZQFBvSaL7BUI0faNZZoJsp64Gy4Y49v+GKBAogNM4wfmDNKlk/37bj7tYvnGJV73w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UARTBAUD_RDMAE and UARTBAUD_TDMAE are enabled in lpuart32_startup(), but
lpuart32_shutdown() not disable them, only free the dma ring buffer and
release the dma channels, so here disable the Rx/Tx DMA first in
lpuart32_shutdown().

Fixes: 42b68768e51b ("serial: fsl_lpuart: DMA support for 32-bit variant")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 9b8d32262f1e..88697ddcd8c4 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1799,6 +1799,11 @@ static void lpuart32_shutdown(struct uart_port *port)
 
 	spin_lock_irqsave(&port->lock, flags);
 
+	/* disable Rx/Tx DMA */
+	temp = lpuart32_read(port, UARTBAUD);
+	temp &= ~(UARTBAUD_TDMAE | UARTBAUD_RDMAE);
+	lpuart32_write(port, temp, UARTBAUD);
+
 	/* disable Rx/Tx and interrupts */
 	temp = lpuart32_read(port, UARTCTRL);
 	temp &= ~(UARTCTRL_TE | UARTCTRL_RE | UARTCTRL_ILIE |
-- 
2.17.1

