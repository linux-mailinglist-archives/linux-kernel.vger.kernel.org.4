Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6204F64E72B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLPGBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPGBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:01:50 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2047.outbound.protection.outlook.com [40.107.14.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5F2396F3;
        Thu, 15 Dec 2022 22:01:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LURsbuW3RdGForTFULXvLhNtwYMMD7CJqmeFXV8jWYE+dr/8xyiHA8iECE4YH4S1H2RaBgwH+zCheyYie2WPuJhOElQZA6Ar2N/8yxcjXu+OQsfth6qdFMhGHhXuQNwKIMKAOqPeimV7yg3DwPaVXeElr7qyi+7D0zxW3SdHENUTgoKqoDd3zVdnIUi94toLzxR5GVKextzB2hzvfiQNnkSZZ70oYKFbq9LXq2KXLc5E4ZSQL8JsSwuy8Fo1vPAxHZJM6+5MDrP+452MStTbdlefqGCghA6XlLep1z+6ifGOQkNImAmUo2HlQUE3BxE7LIe63ZG65jaUnv1tI4pV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVZsmdV/Mt+Zb0no/bw/nEaNXJS/2e8LkxQd0Vh4sFI=;
 b=HTU4oCuVOfevpzrIuoYmID1iiv8FH9KZbLCEZqnpIe3FrCy8qhQ+oZ7k0APADPy63Biwqgp9LpNDEhE7zNQWxDtg7rixQVb2XedJ11/T8LHnW7sE90unOz57i1+k65j98lQGT22oUC0TlyO7/wj7KWuDQ00bNwuSNRzcsNOM7Is5fRa+FChv4q4zBIHm9S6dw4Ym38LNWLUyYPc+W3/Rv6D55xdAQRyfWTy3WJwjL207IAErTO1AGZqs8jd3vwpP1ibJ9Hau1io0cLqvOmCfeJFtYC7HvRnq2yKxywDxr1G1+LV30GupfiihZfBu0Mk3q4+C75scKvsZuksaaizIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVZsmdV/Mt+Zb0no/bw/nEaNXJS/2e8LkxQd0Vh4sFI=;
 b=LNxqWc8q7BlpZA3t4kfSp6WuKikLsfH6xAX9mMh4zb+oxto1+ypAFv/yuXp9J311hsPa3WWJTTc6w/FrvlvgVsviNWGTEIS/ExhnyonHqXBio5hQSN8dYpklwjfum6sQ/hffabtlZT57xazi1xMCjqZFNllgedAI+KwmcTTeE1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AM9PR04MB8148.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 06:01:44 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 06:01:44 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        pmenzel@molgen.mpg.de, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v5] Bluetooth: Add hci_nxp to hci_uart module to support NXP BT chipsets
Date:   Fri, 16 Dec 2022 11:30:58 +0530
Message-Id: <20221216060058.746276-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|AM9PR04MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 667cfbfb-e89a-4e35-0109-08dadf2b0293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Y0iy3HFfOjnpFGNlr7FOzQEWZ30pZX20SejNhwlx3QYZcSYFdQNovSrerICb9R94taSpJkgLg/vCGDJE47EKfGgTKAE0Sbycp/vkoAi+lkNFRqAo/eMZYmiFZsiNnCmVmitMDsbBYpDv4ywNnDlH4TRKpHxw3eqH3ko7RCZaSfw//ZTCiKmO5rihbfL/tDntPYFstwVZXQAltzePhkXDRIlpIIUJcTK5EVOZOWM19QaHFY7tCMLZdOk+6pVUn2IE5qiZLmAI+ZS+LowBSdKQuCBPs069VtsmE4G3sG/DfbyQ4FBL+YjBOuSNG76HjVfkOz68RsPgQ76lHVrgaO5DEL46dA15xlTTpIBhdxr5qp7YZK6HogkUNNCC2dcERfKZ1h6gVYVPZk52dr9lpBFn3l99PRvo/BXiKtZvvvPTT/gqLHuUyq1u8mxEPGSrBfVnW6oCLVCc35WCsa8AksuOXzWVRi1KU78Oe8IIlA8GxxXtrLw+tL1Osg1xNv2kcecB6Z01QRbC3iNGEsp1nUM0juJzUGXyBo45k1tSPMdE5DZsJgP/KXgiWaeaFes2JKa4n5X4bqE56LKfvCb0NHvKGp/csCVeqJXMHnLLfxHZO8WTPaoa8neNPHSiUDz86hwJa5Ystv+kSTIGhmFrRmmfUzJ9KJSEX2H4WHdux60JiZwGyzLcUQxFIrBRjn9X0BW2oBCu6w8EDNvAwypjjTWxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199015)(38350700002)(36756003)(38100700002)(86362001)(6666004)(316002)(66946007)(478600001)(186003)(26005)(6512007)(55236004)(2616005)(52116002)(6486002)(6506007)(6636002)(66476007)(66556008)(2906002)(4326008)(8676002)(41300700001)(5660300002)(1076003)(8936002)(30864003)(83380400001)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9CJE5bMvGuSY4bpVB6u9HHK4CRkkNajdsiRERSY4xthvOWW04keamC+HbOi4?=
 =?us-ascii?Q?jSp/FlByk5zwTL9AEMH/N0nfwbyHTL7sx/ow8mf+1g9bxk0LRhROSf3w72jD?=
 =?us-ascii?Q?4SfmVgcpLV1vRfINoBO7/yxhqDgEgCwh1Uy4QDSXD4FJcT9EnXuwcXjfAk7P?=
 =?us-ascii?Q?OxOGZPj4yo9tFqTgwchk3GIKMm/4jyUOcd1WVaYuXDabYuyQRruc3L8GDlb2?=
 =?us-ascii?Q?z6OUq6vCB+zAvqizgSMNwgU2rYEprI5ATMHDdYrqLh4Y77CsQAxMCY8MSG7o?=
 =?us-ascii?Q?sSxnJnzxR4yUkhWYotZgUJmdRqlhsoJWShu2xAbVachlp9i0nKETEDW1RilC?=
 =?us-ascii?Q?KAqXu9Jwd4/X+V1AEXX60X5Z5Haghl5NHUsd/oYfwefXRvBCB/RtPf+Ccsq5?=
 =?us-ascii?Q?H1Fng46Oc7xTtOfGYlrbCcLJ9cEPzl37FfeFbpY6stpo3twLUlWAz+XKFZaD?=
 =?us-ascii?Q?ZBmZkfPmZREfsi6HQwXLc3OYMi7Rnhtg+pzl1nhxav7LPTXeC+SH8cA9gf+k?=
 =?us-ascii?Q?iKyM+VFZT6qwIvtfMVCxxvvxZkoiTN1XPhkJXktETp2AU152mTsyycDwabK+?=
 =?us-ascii?Q?MMKM7iRO1ZaBgHMRc1NKDdM1ahWjDikgUpGRREjGZwxv0EQyarFLrmbKKmsE?=
 =?us-ascii?Q?SqYGkqhk8XxJu7NZbi3nfXKLr/Bkz6QNIMH40852hCKEATG2F93Y03LOKx2w?=
 =?us-ascii?Q?e/R5Eo+LG+0KVoRYXr+dTt2dzQ1aPKCi9lhEN/zp4eT+Ar8dohpfAip1I1VD?=
 =?us-ascii?Q?DvjFCJsxFJwqcic6nzBID/4mogxuJsDcNRkIlk33pBJHJjX3icMllYCcww4t?=
 =?us-ascii?Q?Gz78b0HakdcWUVS6dSrjGzKmTxJcfDImBP41tpkijFSQoPgtF6IDDG9vll1c?=
 =?us-ascii?Q?V4nkwOIkxiMwT7WM3vZATYXQrZdv4YmPRsXxrlSqBJ9h7K7phYIH8kYalU4a?=
 =?us-ascii?Q?wVCRLrv8jVHgwJeOQi3+W8USQiOQBA0oq6yoQtVTS+GMwcdjxN7yF+XZ0NHx?=
 =?us-ascii?Q?WsfU3TwaHFGsw6BIRyb6zKhuTvPgnDyohRQTBZCMBF0rx43N0X+cs9+7n0Y8?=
 =?us-ascii?Q?KSDSOmWBN0vD+ERYHWM1d45JxBPsrQ/zohqFQmYiCRLC2x6qDFkYZE8VcA3l?=
 =?us-ascii?Q?LyWvFHMqkQdGaJYtCwGsvCg73uryT0jjK6U2kcq1Y2xicp1O+jGsNHWn5QIH?=
 =?us-ascii?Q?iRBRtDmkwmcZnOXycAB6chDBKFGMUZqYjlHK/Tzg+4Q/zuCc5Z52CkZ+cGM+?=
 =?us-ascii?Q?GnvzjveDjFlmYck6qyzJhYVAa72ZxhLbZGvSp23pQq97Q5Oq32bMriDheZFi?=
 =?us-ascii?Q?sImfA/3fBfA8TWTV9gBCAX9T3EWT6mvNgODhyc1RBCJlSeaF0bT4R1gLQLhM?=
 =?us-ascii?Q?Tm5wnYr1U5vU9R2wFFRzC+wRt1ouTH1GNCC5WdWvYff7ZnBpkSG/UgKgnmmb?=
 =?us-ascii?Q?Q2zWRd+S1ZmqO3rtyr/dBLWu3+T+tzKV7gSFvV90o3RCytqXofVXfTydFLHy?=
 =?us-ascii?Q?a65tyr9mmfLnCzlrjlwRFVkUBgcdhkO3xGAWYQYYcpIPFiPwNe06sxgcKrOR?=
 =?us-ascii?Q?jcJaMA+WSqro6H5Q4MU2N0mjQaFJ6QTCFRS7WY3rYl6yfuI185IqJAeYSg/x?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667cfbfb-e89a-4e35-0109-08dadf2b0293
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 06:01:44.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Vqj76oCQp8rJhJ9qgvZuP+M+++oNeLnayvLB1NEPnuJc9xHk9jo46r05eD4sQXcTNBtnXaHIpgw0hnFxg4nL9S+l+tPMXkNyhAfX49YIMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hci_nxp to the hci_uart module which adds support for the NXP BT
chips. This driver has Power Save feature that will put the NXP bluetooth
chip into sleep state, whenever there is no activity for certain duration
of time (2000ms), and will be woken up when any activity is to be
initiated.

The Power Save feature can be configured with the following set
of commands (optional):
hcitool -i hci0 cmd 3F 23 02 00 00    (enable Power Save)
hcitool -i hci0 cmd 3F 23 03 00 00    (disable Power Save)
where,
OGF = 0x3F (vendor specific command)
OCF = 0x23 (command to set Power Save state)
arg[0] = 0x02 (disable Power Save)
arg[0] = 0x03 (enable Power Save)
arg[1,2,...] = XX (don't care)

The sleep/wake-up source can be configured with the following set
of commands (optional):
hcitool -i hci0 cmd 3F 53 03 14 01 FF    (set UART break method)
hcitool -i hci0 cmd 3F 53 03 14 00 FF    (set UART DSR method)
where,
OGF = 0x3F (vendor specific command)
OCF = 0x53 (command to set sleep and wake-up source)
arg[0] = 0x00 (Chip to host method NONE)
arg[0] = 0x01 (Chip to host method UART DTR)
arg[0] = 0x02 (Chip to host method UART BREAK)
arg[0] = 0x03 (Chip to host method GPIO)
arg[1] = 0x14 (Chip to host GPIO[20] if arg[0] is 0x03, else 0xFF)
arg[2] = 0x00 (Host to chip method UART DSR)
arg[2] = 0x01 (Host to chip method UART BREAK)
arg[3] = 0xXX (Reserved for future use)

By default, the hci_nxp sets power save enable, chip to host wake-up
source as GPIO and host to chip sleep and wake-up source as UART
break during driver initialization, by sending the respective
commands to the chip.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Changed the subject/summary lines and added more details in the description. (Paul Menzel)
v3: Made internal functions static, optimized the code, added few comments. (Sherry Sun)
v4: Reworked entire code to send vendor commands cmd23 and cmd53 by using __hci_cmd_sync. (Luiz Augusto von Dentz)
v5: Used hci_command_hdr and combined OGF+OCF into a single opcode. (Luiz Augusto von Dentz)
---
 MAINTAINERS                   |   6 +
 drivers/bluetooth/Kconfig     |  10 +
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/hci_ldisc.c |   6 +
 drivers/bluetooth/hci_nxp.c   | 592 ++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_nxp.h   |  94 ++++++
 drivers/bluetooth/hci_uart.h  |   8 +-
 7 files changed, 716 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_nxp.c
 create mode 100644 drivers/bluetooth/hci_nxp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e55a4d47324c..a234bf348f92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22591,6 +22591,12 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/zswap.c
 
+NXP BLUETOOTH WIRELESS DRIVERS
+M:	Amitkumar Karwar <amitkumar.karwar@nxp.com>
+M:	Neeraj Kale <neeraj.sanjaykale@nxp.com>
+S:	Maintained
+F:	drivers/bluetooth/hci_nxp*
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 89b4d47b7c79..7f6d1dc2cb23 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -273,6 +273,16 @@ config BT_HCIUART_MRVL
 
 	  Say Y here to compile support for HCI MRVL protocol.
 
+config BT_HCIUART_NXP
+        bool "NXP protocol support"
+        depends on BT_HCIUART
+        help
+          NXP is serial protocol for communication between Bluetooth
+          device and host. This protocol is required for most NXP Bluetooth
+          devices with UART interface.
+
+          Say Y here to compile support for HCI NXP protocol.
+
 config BT_HCIBCM203X
 	tristate "HCI BCM203x USB driver"
 	depends on USB
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 3321a8aea4a0..bc80329cdd6b 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -48,4 +48,5 @@ hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
 hci_uart-$(CONFIG_BT_HCIUART_QCA)	+= hci_qca.o
 hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+= hci_ag6xx.o
 hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
+hci_uart-$(CONFIG_BT_HCIUART_NXP)	+= hci_nxp.o
 hci_uart-objs				:= $(hci_uart-y)
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 865112e96ff9..f3c85c27ded7 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -882,6 +882,9 @@ static int __init hci_uart_init(void)
 #ifdef CONFIG_BT_HCIUART_MRVL
 	mrvl_init();
 #endif
+#ifdef CONFIG_BT_HCIUART_NXP
+	nxp_init();
+#endif
 
 	return 0;
 }
@@ -918,6 +921,9 @@ static void __exit hci_uart_exit(void)
 #ifdef CONFIG_BT_HCIUART_MRVL
 	mrvl_deinit();
 #endif
+#ifdef CONFIG_BT_HCIUART_NXP
+	nxp_deinit();
+#endif
 
 	tty_unregister_ldisc(&hci_uart_ldisc);
 }
diff --git a/drivers/bluetooth/hci_nxp.c b/drivers/bluetooth/hci_nxp.c
new file mode 100644
index 000000000000..362ea84fc330
--- /dev/null
+++ b/drivers/bluetooth/hci_nxp.c
@@ -0,0 +1,592 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  Bluetooth HCI UART driver
+ *  Copyright 2018-2022 NXP
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/interrupt.h>
+#include <linux/ptrace.h>
+#include <linux/poll.h>
+
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/signal.h>
+#include <linux/ioctl.h>
+#include <linux/skbuff.h>
+#include <asm/unaligned.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "hci_uart.h"
+#include "hci_nxp.h"
+
+/* NXP Power Save Feature */
+/* Power Save feature will be enabled and wakeup method will be break signal by default */
+int wakeupmode = WAKEUP_METHOD_BREAK;
+int ps_mode = PS_MODE_ENABLE;
+
+static int is_device_ready(struct hci_uart *hu)
+{
+	struct hci_dev *hdev = NULL;
+
+	if (!hu) {
+		BT_ERR("hu is NULL");
+		return -ENODEV;
+	}
+	if (!hu->proto || !hu->hdev || !hu->tty) {
+		BT_ERR("Device not ready! proto=%p, hdev=%p, tty=%p", hu->proto, hu->hdev, hu->tty);
+		return -ENODEV;
+	}
+	hdev = hu->hdev;
+	if (!test_bit(HCI_RUNNING, &hdev->flags)) {
+		BT_ERR("HCI_RUNNING is not set");
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static void ps_start_timer(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+
+	if (psdata->cur_psmode ==  PS_MODE_ENABLE) {
+		psdata->timer_on = 1;
+		mod_timer(&psdata->ps_timer, jiffies + (psdata->interval * HZ) / 1000);
+	}
+}
+
+static void ps_timeout_func(struct timer_list *t)
+{
+	struct ps_data *data = from_timer(data, t, ps_timer);
+	struct tty_struct *tty = data->tty;
+	struct hci_uart *hu = NULL;
+
+	data->timer_on = 0;
+	if (!data->tty)
+		return;
+
+	hu = (struct hci_uart *)tty->disc_data;
+	if (!hu)
+		return;
+
+	if (test_bit(HCI_UART_SENDING, &hu->tx_state)) {
+		ps_start_timer(hu);
+	} else {
+		data->ps_cmd = PS_CMD_ENTER_PS;
+		schedule_work(&data->work);
+	}
+}
+
+static void set_dtr(struct tty_struct *tty, int on_off)
+{
+	u32 old_state = 0;
+	u32 new_state = 0;
+
+	if (TTY_FUNC->tiocmget) {
+		old_state = TTY_FUNC->tiocmget(tty);
+		if (on_off)
+			new_state = old_state | TIOCM_DTR;
+		else
+			new_state = old_state & ~TIOCM_DTR;
+		if (new_state == old_state)
+			return;
+		if (TTY_FUNC->tiocmset) {
+			if (on_off)
+				TTY_FUNC->tiocmset(tty, TIOCM_DTR, 0);  /* DTR ON */
+			else
+				TTY_FUNC->tiocmset(tty, 0, TIOCM_DTR);  /* DTR OFF */
+		}
+	}
+}
+
+static void set_break(struct tty_struct *tty, int on_off)
+{
+	if (TTY_FUNC->break_ctl) {
+		if (on_off)
+			TTY_FUNC->break_ctl(tty, -1); /* turn on break */
+		else
+			TTY_FUNC->break_ctl(tty, 0);  /* turn off break */
+	}
+}
+
+static int get_cts(struct tty_struct *tty)
+{
+	u32 state = 0;
+	int ret = -1;
+
+	if (TTY_FUNC->tiocmget) {
+		state = TTY_FUNC->tiocmget(tty);
+		if (state & TIOCM_CTS)
+			ret = 1;   /* CTS LOW */
+		else
+			ret = 0;   /* CTS HIGH */
+	}
+	return ret;
+}
+
+static void set_rts(struct tty_struct *tty, int on_off)
+{
+	u32 old_state = 0;
+	u32 new_state = 0;
+
+	if (TTY_FUNC->tiocmget) {
+		old_state = TTY_FUNC->tiocmget(tty);
+		if (on_off)
+			new_state = old_state | TIOCM_RTS;
+		else
+			new_state = old_state & ~TIOCM_RTS;
+		if (new_state == old_state)
+			return;
+		if (TTY_FUNC->tiocmset) {
+			if (on_off)
+				TTY_FUNC->tiocmset(tty, TIOCM_RTS, 0);    /* RTS ON */
+			else
+				TTY_FUNC->tiocmset(tty, 0, TIOCM_RTS);    /* RTS OFF */
+		}
+	}
+}
+
+static void ps_control(struct ps_data *data, u8 ps_state)
+{
+	struct hci_uart *hu = NULL;
+
+	if (data->ps_state == ps_state)
+		return;
+
+	if (data->tty) {
+		switch (data->cur_wakeupmode) {
+		case WAKEUP_METHOD_DTR:
+			if (ps_state == PS_STATE_AWAKE)
+				set_dtr(data->tty, 1);  /* DTR ON */
+			else
+				set_dtr(data->tty, 0);  /* DTR OFF */
+			break;
+		case WAKEUP_METHOD_BREAK:
+			if (ps_state == PS_STATE_AWAKE)
+				set_break(data->tty, 0); /* break OFF */
+			else
+				set_break(data->tty, 1); /* break ON */
+			break;
+		default:
+			break;
+		}
+		data->ps_state = ps_state;
+
+		if (ps_state == PS_STATE_AWAKE) {
+			hu = (struct hci_uart *)data->tty->disc_data;
+			if (hu)
+				hci_uart_tx_wakeup(hu);
+		}
+	}
+}
+
+static void ps_work_func(struct work_struct *work)
+{
+	struct ps_data *data = container_of(work, struct ps_data, work);
+
+	if (data->tty) {
+		if (data->ps_cmd == PS_CMD_ENTER_PS && data->cur_psmode == PS_MODE_ENABLE)
+			ps_control(data, PS_STATE_SLEEP);
+		else  if (data->ps_cmd == PS_CMD_EXIT_PS)
+			ps_control(data, PS_STATE_AWAKE);
+	}
+}
+
+static int ps_init_work(struct hci_uart *hu)
+{
+	struct ps_data *psdata = kzalloc(sizeof(*psdata), GFP_KERNEL);
+	struct nxp_struct *nxp = hu->priv;
+
+	if (!psdata) {
+		BT_ERR("Can't allocate control structure");
+		return -ENFILE;
+	}
+	nxp->psdata = psdata;
+
+	memset(psdata, 0, sizeof(*psdata));
+	psdata->interval = PS_DEFAULT_TIMEOUT_PERIOD;
+	psdata->tty = NULL;
+	psdata->ps_state = PS_STATE_AWAKE;
+	psdata->ps_mode = ps_mode;
+	switch (wakeupmode) {
+	case WAKEUP_METHOD_DTR:
+		psdata->wakeupmode =  WAKEUP_METHOD_DTR;
+		break;
+	case  WAKEUP_METHOD_BREAK:
+	default:
+		psdata->wakeupmode =  WAKEUP_METHOD_BREAK;
+		break;
+	}
+
+	psdata->cur_psmode = PS_MODE_DISABLE;
+	psdata->cur_wakeupmode = WAKEUP_METHOD_INVALID;
+
+	INIT_WORK(&psdata->work, ps_work_func);
+	return 0;
+}
+
+static void ps_init_timer(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+
+	psdata->timer_on = 0;
+	psdata->tty = hu->tty;
+	timer_setup(&psdata->ps_timer, ps_timeout_func, 0);
+}
+
+static void ps_cancel_timer(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+
+	if (psdata) {
+		flush_scheduled_work();
+	if (psdata->timer_on)
+		del_timer(&psdata->ps_timer);
+	psdata->tty = NULL;
+	kfree(psdata);
+	}
+}
+
+static int ps_wakeup(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+	int ret = 1;
+
+	if (psdata->ps_state == PS_STATE_AWAKE)
+		ret = 0;
+	psdata->ps_cmd = PS_CMD_EXIT_PS;
+	schedule_work(&psdata->work);
+	return ret;
+}
+
+/* Builds and sends a PS command packet to chip */
+static int send_ps_cmd(struct hci_dev *hdev, void *data)
+{
+	struct hci_uart *hu = (struct hci_uart *)data;
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+	u8 pcmd;
+	struct sk_buff *skb;
+	u8 *status;
+
+	if (psdata->ps_mode ==  PS_MODE_ENABLE)
+		pcmd = BT_PS_ENABLE;
+	else
+		pcmd = BT_PS_DISABLE;
+
+	psdata->driver_sent_cmd = 1;	/* set flag to prevent re-sending command in nxp_enqueue */
+	skb = __hci_cmd_sync(hdev, HCI_NXP_AUTO_SLEEP_MODE, 1, &pcmd, HCI_CMD_TIMEOUT);
+	psdata->driver_sent_cmd = 0;
+
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Setting Power Save mode failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	status = skb_pull_data(skb, 1);
+
+	if (status) {
+		if (!*status)
+			psdata->cur_psmode = psdata->ps_mode;
+		else
+			psdata->ps_mode = psdata->cur_psmode;
+		if (psdata->cur_psmode == PS_MODE_ENABLE)
+			ps_start_timer(hu);
+		else
+			ps_wakeup(hu);
+		BT_INFO("Power Save mode response: status=%d, ps_mode=%d",
+			*status, psdata->cur_psmode);
+	}
+
+	return 0;
+}
+
+/* Builds and sends an wake up method command packet to chip */
+static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
+{
+	struct hci_uart *hu = (struct hci_uart *)data;
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+	u8 pcmd[4];
+	struct sk_buff *skb;
+	u8 *status;
+
+	pcmd[0] = BT_HOST_WAKEUP_METHOD_NONE;
+	pcmd[1] = BT_HOST_WAKEUP_DEFAULT_GPIO;
+	switch (psdata->wakeupmode) {
+	case WAKEUP_METHOD_DTR:
+		pcmd[2] = BT_CTRL_WAKEUP_METHOD_DSR;
+		break;
+	case WAKEUP_METHOD_BREAK:
+	default:
+		pcmd[2] = BT_CTRL_WAKEUP_METHOD_BREAK;
+		break;
+	}
+	pcmd[3] = 0xFF;
+
+	psdata->driver_sent_cmd = 1;	/* set flag to prevent re-sending command in nxp_enqueue */
+	skb = __hci_cmd_sync(hdev, HCI_NXP_WAKEUP_METHOD, 4, pcmd, HCI_CMD_TIMEOUT);
+	psdata->driver_sent_cmd = 0;
+
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Setting wake-up method failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	status = skb_pull_data(skb, 1);
+
+	if (status) {
+		if (!*status)
+			psdata->cur_wakeupmode = psdata->wakeupmode;
+		else
+			psdata->wakeupmode = psdata->cur_wakeupmode;
+		BT_INFO("Set Wakeup Method response: status=%d, wakeupmode=%d",
+			*status, psdata->cur_wakeupmode);
+	}
+
+	return 0;
+}
+
+static void ps_init(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+	int mode = 0;
+
+	if (!psdata || !psdata->tty)
+		return;
+	if (get_cts(psdata->tty) != 1) {
+		/* CTS is not low, chip is either sleeping
+		 * or flow control is not enabled
+		 */
+		hci_uart_set_flow_control(hu, false);
+		hci_uart_set_flow_control(hu, true);
+
+		/* Wake up the chip */
+		mode = psdata->cur_wakeupmode;
+		if (mode == WAKEUP_METHOD_INVALID)
+			mode =  wakeupmode;
+		switch (mode) {
+		case WAKEUP_METHOD_BREAK:
+			set_rts(psdata->tty, 1);	/* set RTS */
+			set_break(psdata->tty, 1);	/* break on */
+			set_break(psdata->tty, 0);	/* break off */
+			mdelay(5);
+			break;
+		case WAKEUP_METHOD_DTR:
+			set_rts(psdata->tty, 1);	/* set RTS */
+			set_dtr(psdata->tty, 0);	/* dtr off */
+			set_dtr(psdata->tty, 1);	/* dtr on */
+			mdelay(5);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!is_device_ready(hu)) {
+		if (psdata->cur_wakeupmode != psdata->wakeupmode)
+			hci_cmd_sync_queue(hu->hdev, send_wakeup_method_cmd, hu, NULL);
+		if (psdata->cur_psmode != psdata->ps_mode)
+			hci_cmd_sync_queue(hu->hdev, send_ps_cmd, hu, NULL);
+	}
+}
+
+/* NXP proto */
+
+/* Initialize protocol */
+static int nxp_open(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp;
+
+	BT_DBG("hu %p", hu);
+
+	nxp = kzalloc(sizeof(*nxp), GFP_KERNEL);
+	if (!nxp)
+		return -ENOMEM;
+
+	skb_queue_head_init(&nxp->txq);
+
+	hu->priv = nxp;
+
+	if (ps_init_work(hu) == 0)
+		ps_init_timer(hu);
+
+	return 0;
+}
+
+/* Flush protocol data */
+static int nxp_flush(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	skb_queue_purge(&nxp->txq);
+
+	return 0;
+}
+
+/* Close protocol */
+static int nxp_close(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+
+	BT_DBG("hu %p", hu);
+
+	ps_cancel_timer(hu);
+
+	skb_queue_purge(&nxp->txq);
+
+	kfree_skb(nxp->rx_skb);
+
+	hu->priv = NULL;
+	kfree(nxp);
+
+	return 0;
+}
+
+/* Enqueue frame for transmission (padding, crc, etc) */
+static int nxp_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+	struct hci_command_hdr *hdr;
+	u8 *param;
+
+	BT_DBG("hu %p skb %p", hu, skb);
+
+	/* if commands are received from user space (e.g. hcitool), update
+	 *  psdata flags accordingly and ask driver to re-send the command
+	 */
+	if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT && !psdata->driver_sent_cmd) {
+		hdr = (struct hci_command_hdr *)skb->data;
+		param = skb->data + HCI_COMMAND_HDR_SIZE;
+		if (__le16_to_cpu(hdr->opcode) == HCI_NXP_AUTO_SLEEP_MODE && hdr->plen >= 1) {
+			if (param[0] == BT_PS_ENABLE)
+				psdata->ps_mode = PS_MODE_ENABLE;
+			else if (param[0] == BT_PS_DISABLE)
+				psdata->ps_mode = PS_MODE_DISABLE;
+			hci_cmd_sync_queue(hu->hdev, send_ps_cmd, hu, NULL);
+			kfree_skb(skb);
+			return 0;
+		}
+		if (__le16_to_cpu(hdr->opcode) == HCI_NXP_WAKEUP_METHOD  && hdr->plen >= 4) {
+			switch (param[2]) {
+			case BT_CTRL_WAKEUP_METHOD_DSR:
+				psdata->wakeupmode = WAKEUP_METHOD_DTR;
+				break;
+			case BT_CTRL_WAKEUP_METHOD_BREAK:
+			default:
+				psdata->wakeupmode = WAKEUP_METHOD_BREAK;
+				break;
+			}
+			hci_cmd_sync_queue(hu->hdev, send_wakeup_method_cmd, hu, NULL);
+			kfree_skb(skb);
+			return 0;
+		}
+	}
+
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+	skb_queue_tail(&nxp->txq, skb);
+
+	return 0;
+}
+
+static const struct h4_recv_pkt nxp_recv_pkts[] = {
+	{ H4_RECV_ACL,   .recv = hci_recv_frame },
+	{ H4_RECV_SCO,   .recv = hci_recv_frame },
+	{ H4_RECV_EVENT, .recv = hci_recv_frame },
+	{ H4_RECV_ISO,   .recv = hci_recv_frame },
+};
+
+static int nxp_recv(struct hci_uart *hu, const void *data, int count)
+{
+	struct nxp_struct *nxp = hu->priv;
+
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+
+	ps_start_timer(hu);
+
+	nxp->rx_skb = h4_recv_buf(hu->hdev, nxp->rx_skb, data, count,
+				  nxp_recv_pkts, ARRAY_SIZE(nxp_recv_pkts));
+	if (IS_ERR(nxp->rx_skb)) {
+		int err = PTR_ERR(nxp->rx_skb);
+
+		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
+		nxp->rx_skb = NULL;
+		return err;
+	}
+
+	return count;
+}
+
+static struct sk_buff *nxp_dequeue(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+
+	if (ps_wakeup(hu)) {
+		clear_bit(HCI_UART_SENDING, &hu->tx_state);
+		return 0;
+	}
+	ps_start_timer(hu);
+	return skb_dequeue(&nxp->txq);
+}
+
+static int nxp_setup(struct hci_uart *hu)
+{
+	ps_init(hu);
+	return 0;
+}
+
+static const struct hci_uart_proto nxpp = {
+	.id		= HCI_UART_NXP,
+	.name		= "NXP",
+	.open		= nxp_open,
+	.close		= nxp_close,
+	.recv		= nxp_recv,
+	.enqueue	= nxp_enqueue,
+	.dequeue	= nxp_dequeue,
+	.flush		= nxp_flush,
+	.setup		= nxp_setup,
+};
+
+int __init nxp_init(void)
+{
+	return hci_uart_register_proto(&nxpp);
+}
+
+int __exit nxp_deinit(void)
+{
+	return hci_uart_unregister_proto(&nxpp);
+}
diff --git a/drivers/bluetooth/hci_nxp.h b/drivers/bluetooth/hci_nxp.h
new file mode 100644
index 000000000000..c5c78b3d88b6
--- /dev/null
+++ b/drivers/bluetooth/hci_nxp.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  Bluetooth HCI UART driver
+ *  Copyright 2018-2022 NXP
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+#ifndef _HCI_NXP_H_
+#define _HCI_NXP_H_
+
+#define TTY_FUNC tty->ops
+
+struct ps_data {
+	u8    ps_mode;
+	u8    cur_psmode;
+	u8    ps_state;
+	u8    ps_cmd;
+	u8    wakeupmode;
+	u8    cur_wakeupmode;
+	u8    driver_sent_cmd;
+	u8    timer_on;
+	u32   interval;
+	struct work_struct work;
+	struct tty_struct *tty;
+	struct timer_list ps_timer;
+};
+
+struct nxp_struct {
+	struct sk_buff      *rx_skb;
+	struct sk_buff_head  txq;
+	struct list_head     nxp_list_head;
+	unsigned char        id;
+	struct ps_data      *psdata;
+};
+
+/* Default ps timeout period in milli-second */
+#define PS_DEFAULT_TIMEOUT_PERIOD     2000
+
+/* wakeup methods */
+#define WAKEUP_METHOD_DTR       0
+#define WAKEUP_METHOD_BREAK     1
+#define WAKEUP_METHOD_EXT_BREAK 2
+#define WAKEUP_METHOD_RTS       3
+#define WAKEUP_METHOD_INVALID   0xff
+
+/* ps mode disable */
+#define PS_MODE_DISABLE         0
+/* ps mode enable */
+#define PS_MODE_ENABLE          1
+
+/* PS Commands to ps_work_func  */
+#define PS_CMD_EXIT_PS          1
+#define PS_CMD_ENTER_PS         2
+
+/* ps state */
+#define PS_STATE_AWAKE          0
+#define PS_STATE_SLEEP          1
+
+/* Bluetooth vendor command : Sleep mode */
+#define HCI_NXP_AUTO_SLEEP_MODE	0xFC23
+/* Bluetooth vendor command : Wakeup method */
+#define HCI_NXP_WAKEUP_METHOD	0xFC53
+
+/* Bluetooth Power State : Vendor cmd params */
+#define BT_PS_ENABLE			0x02
+#define BT_PS_DISABLE			0x03
+
+/* Bluetooth Host Wakeup Methods */
+#define BT_HOST_WAKEUP_METHOD_NONE      0x00
+#define BT_HOST_WAKEUP_METHOD_DTR       0x01
+#define BT_HOST_WAKEUP_METHOD_BREAK     0x02
+#define BT_HOST_WAKEUP_METHOD_GPIO      0x03
+#define BT_HOST_WAKEUP_DEFAULT_GPIO     20
+
+/* Bluetooth Chip Wakeup Methods */
+#define BT_CTRL_WAKEUP_METHOD_DSR       0x00
+#define BT_CTRL_WAKEUP_METHOD_BREAK     0x01
+#define BT_CTRL_WAKEUP_METHOD_GPIO      0x02
+#define BT_CTRL_WAKEUP_METHOD_EXT_BREAK 0x04
+#define BT_CTRL_WAKEUP_METHOD_RTS       0x05
+#define BT_CTRL_WAKEUP_DEFAULT_GPIO     4
+
+#endif /* _HCI_UART_H_ */
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index fb4a2d0d8cc8..17d271ca9ee2 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -20,7 +20,7 @@
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 
 /* UART protocols */
-#define HCI_UART_MAX_PROTO	12
+#define HCI_UART_MAX_PROTO	13
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
@@ -34,6 +34,7 @@
 #define HCI_UART_AG6XX	9
 #define HCI_UART_NOKIA	10
 #define HCI_UART_MRVL	11
+#define HCI_UART_NXP	12
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
@@ -200,3 +201,8 @@ int ag6xx_deinit(void);
 int mrvl_init(void);
 int mrvl_deinit(void);
 #endif
+
+#ifdef CONFIG_BT_HCIUART_NXP
+int nxp_init(void);
+int nxp_deinit(void);
+#endif
-- 
2.34.1

