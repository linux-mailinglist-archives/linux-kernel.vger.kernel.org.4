Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B52633A11
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiKVK1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiKVK1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:27:11 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8A5CD13;
        Tue, 22 Nov 2022 02:24:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbKBOQzQNs8aU+gYYh+IyHTskyKAf8A0TC0lxnyurL8U6GfSrwgRoB0IE/rcmLbhXhlk3j56V4C5oAQee5mpeHurTB/VJUA2g9S1hN9pSCEqIyrcXVYdI4PGX7yjHbT8hVvf53WlWqLh6GKrlLTJ/ByKivG/slJ82Ac4epDjArcjtfIfBfF7aCUD3OV3VtkiUm/xiulH0O/aVookPvXM6lSHCybsELJoN/wzH7ecyrrnmhJ29BKLk03vziEHQDDbXNmMgDXNQIg1AP9GOfQQIoAObit9sfUIHioQFW9KLsCNpphkJTuyC6sID/juMy8H5R16wG2lfsHKCajcLvLJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU/haBwAUp4TxARFP/GBOzuLJKiNHrgW7iIgEr2JBKQ=;
 b=V2RCMELYvwYqOmhkhuh0l2cGXaeC/o6Oq28lBlaqAfRFBuR6XJt6KOS8xrrIJgdzv93uy8rxt1ghnTyJ5+I/dQpWTPF7UI0N5VInONQr0k2Z2pju3JTU/FRfC5AeRB4yzso84TrufnuFUsTiZWLwbysquzXe2y69h+AcM9GIu0ui+fxLUPD268uA65aTkf2vm3q9Ja6rKDHbpAvLiepO1YddIc9qmPpWip/RmB1bZROvX+LwxFV8ZJJcFEVSvTQyYFeYyBXtHRy8f5QVnRENUKCDgH3WrxbrX5WuV3uqjMexZxApf+3+vHS8IdRgTq9zRYK3OzwGPpMT17upK+/oag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU/haBwAUp4TxARFP/GBOzuLJKiNHrgW7iIgEr2JBKQ=;
 b=fi6ZkF8i6B93AhzUETBihvM9PcN27ACVuvcYuHZmFi36CFV1lqYBzYVbX/r37Hh2XvcUoNiiQbKxKyk/8gxfTc4IHKH+8R5rBj21CVJixq/vtuLW4sQlch8iD/W1wSyhrLKmPGlX/gNGwMmJpSqPY9ZkRCu9WUQjWQmI+96nZ4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by DB9PR04MB9703.eurprd04.prod.outlook.com (2603:10a6:10:302::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Tue, 22 Nov
 2022 10:24:02 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 10:24:02 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Add hci_nxp to hci_uart module to support NXP BT chipsets
Date:   Tue, 22 Nov 2022 15:53:02 +0530
Message-Id: <1669112583-29804-1-git-send-email-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|DB9PR04MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: 86961817-f086-4346-aba6-08dacc73abb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJFrUxO5XtbT3vMXyqR8PZZm+y7+yMf9D4cE5Uka7HgwZwEk/kJ+cOY8t84taM7woqRg5qCwRyW6KbSNLsKm2CK9bwFEGdUlVGWIhluCRA8O0BOY38sEcvKDvl8amPPJzGschCkk1KDdMeSu/CGfCjj1YSEympr+02RZYl0chaHNgFsX2nADrmYNWApXypArDRqdptklHBGqPhjbozBYRkHXgd3Yntit3pbmv1Xd7BdTHHRp/IpW4KUt5Inx1RPUdPRfP9LDAlbMxlAUAR56u53kKTgal+8RPljchh/xxEeFAdMcXg8X3lQdUEQ7OutWMob5GTcVaQ9qfD3nyu8aubgXA6fDYaej5/rzP8wmgMwNuTdjRZdSTEEjM1MpSy/OQqFJB2oxvqyHSPtq1MYpUpYJPLdVGnzDHMAKB2PAY1iNDvn6C/3H6QumQFLYeGcgK4NQH/rG6Q2FmjE/Fh0Nk2MLZOPNEKY33ZoFOIDufB/FMeiuhJqxGlah/LD04+DgDXjwYmqlyYGPvorrRgLNdZBslcOJfuNQxD3ce0Cydrdjc40jyg4tqHaa4kHFwV0qujU03oZ+3pNU2uv/yxRbPfBCFCChGvv/Ak/If5h9+0X+4J0R369FtabySIvXsxX45+8SBw3GVFHu6BbF/sdU1wtbM29Lw1wLuh0sBFBtKIT6Ot4mURWANekDILVNw3ctoXYoXQpHXp3ipzOupPCj7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199015)(2906002)(26005)(8936002)(5660300002)(4326008)(6512007)(6506007)(55236004)(41300700001)(30864003)(86362001)(8676002)(66946007)(66476007)(66556008)(52116002)(36756003)(316002)(6486002)(38350700002)(6636002)(478600001)(38100700002)(83380400001)(186003)(2616005)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZusjBzr73OFAXJO6H6TjFs1p2BMBRW1AmcNfSAymtmnX5HqoAeqT2cQHrZWu?=
 =?us-ascii?Q?UjFvy4Jn95LXUR3R6CcRkkLcKBJ+9b3gwRJsBCdzPT/n5J3eI3Fv1Ir1UJSW?=
 =?us-ascii?Q?se58b+vMYmV7J+byyrMPj+2RTTZaxDZBB1gMratyEWaJp4c8SZDpedk+mHZk?=
 =?us-ascii?Q?Rjfn0ujQJZbfv+oz6wjsKN9QbjwVCpUyDzIZA2IV00vhsNYwZtm77ccgmATN?=
 =?us-ascii?Q?P/U2TiamcTpQ36pcuE2x8hGpbwKOEAm1/sSlNo9JZuL5P41jEtcZ+ESoBcgA?=
 =?us-ascii?Q?XLK7Zown8oi+QtmD+AL9klcBQxB/RP7tAQsTckFgM6ceQ15yZfYN6Y4ktk2K?=
 =?us-ascii?Q?t7HblPE/b6DGp3e9Uim8Q9vfF3t0Civqptbx8KvCv2g31xWOcc2ZKOvqFT18?=
 =?us-ascii?Q?Q1tdDQS6etZ2P1VZJTnY5y67ynNYQDQ2L5oGVU6dqe2fE2qIrd4r9DzMWROG?=
 =?us-ascii?Q?HIASk8Xr3QXv7axiTcJXPQs0WVpLZcyUzKee41dt5vyetSzdT4tdgnyXTTxn?=
 =?us-ascii?Q?OeP85U1MhzSdRNphm3fc4Hv1LDaB9b8eepQ6jCRCejF59Zlh5O2Er9fiyWXs?=
 =?us-ascii?Q?xkONeMarASPAznmRQgvBogIYeoH/MmakRUs2+1IX3MB0FLREvh1mBOGej+ES?=
 =?us-ascii?Q?sknCmB9qKUTVic0PCufLCNDQaBk8elImcMsPkj7yjPcZlZtPW4eduDnz2aCS?=
 =?us-ascii?Q?hJ+bLXTBTs1PZ75+k3Q8v9CJ8JvmxIMPqBLYzLXDOadiDWTGNo0kekYAN5x3?=
 =?us-ascii?Q?kDCz92ORGga2nS6NMBhPRt4f20JDMjjq4Bojgrk1wNdBqE3XS9h48EPDwdtY?=
 =?us-ascii?Q?E3wluoQh6Wv5YhL4/TvYP0YsvXg+2PpRregoBir3jineIl0MZd9pmfbGD7BJ?=
 =?us-ascii?Q?eUilO5nbMOH031gy4xMYuvNyNkOCbzs4jm4drLHzaNxmLjKoNXXzd183lENn?=
 =?us-ascii?Q?iA6Xymf/MHgN5aqCS5+N0RPyrt8jky0cevbC4jN+jEp5m5DK+v7TTzORmeqQ?=
 =?us-ascii?Q?QuZyacl281Xr0OnOy9ptz+HZL46uj8cYaYuRnMNmbxMflnC+cwKH1pM2Zfzy?=
 =?us-ascii?Q?GBA6qIgNpyLXV1mXqlHge8W2nzpZe+iNScQWFkmpiR86Z3nhE/OKO0KOvj4Z?=
 =?us-ascii?Q?l3o1yyWuqyiTH3bHkvLrezhoewkkRhm58vN7ahWjOFnH0mTGKF/xMxHVuWu5?=
 =?us-ascii?Q?/C12xb8341NSvCm17r1+HORTAoCd2dOZ+dsEBDL9cH9Y5AwYP8U630gBT5z9?=
 =?us-ascii?Q?v+cvspyaMFbFFYnpKr4+6r/LrGzTBzOguKng5kKCY5d97PGurZp45AF9CUCl?=
 =?us-ascii?Q?4WzFewy2ulExAoNUchbYGq9BrS234Epp53jL3vTUkGDB90hKvs9DprjbOd3U?=
 =?us-ascii?Q?tmKqO5cl+h9iPgmZLNAMAFPPUzhP1Njw+yh7Sn41ExTeKeXSCsngoOrb4FC8?=
 =?us-ascii?Q?uA5jVs0AhXSygtVbKfWKnREMK3WpwCnFqO6I1/4QebuF8tDKFRsxOwIFzSbI?=
 =?us-ascii?Q?MppNSM3yAmyglSSFje68SBZupfqYoviQb6GN1RixUFMxtXKKtJiNs0nvNLh6?=
 =?us-ascii?Q?fASBVvx9RegtXNO2NcxvI+mMa0I1NgKRf4yqQ/DIYWzv0AXE0Pf/CkSLsj60?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86961817-f086-4346-aba6-08dacc73abb6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 10:24:02.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReMVy9OJkDcMhqtowHWbJ27KmbZjSLMEXhMDNFfYf5P8CaS6tUL2bF7tXvS0QN6b3RODjXhHvDppbIqSdvCy9axzdV5qvgWBjjEVsZTUhIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9703
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
of commands:
hcitool -i hci0 cmd 3F 23 02 00 00    (disable Power Save)
hcitool -i hci0 cmd 3F 23 03 00 00    (enable Power Save)
where,
OGF = 0x3F (vendor specific command)
OCF = 0x23 (command to set Power Save state)
arg[0] = 0x02 (disable Power Save)
arg[0] = 0x03 (enable Power Save)
arg[1,2,...] = XX (don't care)

The sleep/wake-up source can be configured with the following set
of commands:
hcitool -i hci0 cmd 3F 53 03 14 01 FF    (set UART break method)
hcitool -i hci0 cmd 3F 53 03 14 02 15    (set chip's GPIO[21] method)
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
arg[2] = 0x02 (Host to chip method GPIO)
arg[2] = 0x03 (Host to chip method UART RTS)
arg[3] = 0x15 (Host to chip GPIO[21] if arg[2] is 0x02, else 0xFF)

By default, the hci_nxp sets power save enable, chip to host wake-up
source as GPIO and host to chip sleep and wake-up source as UART
break during driver initialization, by sending the respective
commands to the chip.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Changed the subject/summary lines and added more details in the description. (Paul Menzel)
---

 MAINTAINERS                   |   6 +
 drivers/bluetooth/Kconfig     |  10 +
 drivers/bluetooth/Makefile    |   1 +
 drivers/bluetooth/hci_ldisc.c |   6 +
 drivers/bluetooth/hci_nxp.c   | 763 ++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/hci_nxp.h   | 118 +++++++
 drivers/bluetooth/hci_uart.h  |   8 +-
 7 files changed, 911 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bluetooth/hci_nxp.c
 create mode 100644 drivers/bluetooth/hci_nxp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e55a4d4..6b2c264 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22591,6 +22591,12 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/zswap.c
 
+NXP BLUETOOTH WIRELESS DRIVERS
+M:	amitkumar.karwar@nxp.com
+M:	neeraj.sanjaykale@nxp.com
+S:	Maintained
+F:	drivers/bluetooth/hci_nxp*
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 89b4d47..7f6d1dc 100644
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
index 3321a8a..bc80329 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -48,4 +48,5 @@ hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
 hci_uart-$(CONFIG_BT_HCIUART_QCA)	+= hci_qca.o
 hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+= hci_ag6xx.o
 hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
+hci_uart-$(CONFIG_BT_HCIUART_NXP)	+= hci_nxp.o
 hci_uart-objs				:= $(hci_uart-y)
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 865112e..f3c85c2 100644
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
index 0000000..58911a1
--- /dev/null
+++ b/drivers/bluetooth/hci_nxp.c
@@ -0,0 +1,763 @@
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
+/** NXP Power Save Feature **/
+struct BT_CMD {
+	u16	ocf_ogf;
+	u8	length;
+	u8	data[4];
+} __packed;
+
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
+/* Builds and sends an PS command packet */
+static int send_ps_cmd(u8 cmd, struct hci_uart *hu)
+{
+	int err = 0;
+	struct sk_buff *skb = NULL;
+	struct BT_CMD *pcmd;
+
+	/* allocate packet */
+	skb = bt_skb_alloc(sizeof(struct BT_CMD), GFP_ATOMIC);
+	if (!skb) {
+		BT_ERR("cannot allocate memory for HCILL packet");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	pcmd = (struct BT_CMD *)skb->data;
+	pcmd->ocf_ogf =  (OGF << 10) | BT_CMD_AUTO_SLEEP_MODE;
+	pcmd->length = 1;
+	if (cmd ==  PS_MODE_ENABLE)
+		pcmd->data[0] = BT_PS_ENABLE;
+	else
+		pcmd->data[0] = BT_PS_DISABLE;
+
+	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+	skb_put(skb, sizeof(struct BT_CMD) - 4 + pcmd->length);
+	skb->dev = (void *)hu->hdev;
+
+	/* send packet */
+	hu->proto->enqueue(hu, skb);
+	hci_uart_tx_wakeup(hu);
+
+out:
+	return err;
+}
+
+/* Builds and sends an wake up method command packet */
+static int send_wakeup_method_cmd(u8 cmd, struct hci_uart *hu)
+{
+	int err = 0;
+	struct sk_buff *skb = NULL;
+	struct BT_CMD *pcmd;
+
+	/* allocate packet */
+	skb = bt_skb_alloc(sizeof(struct BT_CMD), GFP_ATOMIC);
+	if (!skb) {
+		BT_ERR("cannot allocate memory for HCILL packet");
+		err = -ENOMEM;
+		goto out;
+	}
+
+	pcmd = (struct BT_CMD *)skb->data;
+	pcmd->ocf_ogf =  (OGF << 10) | BT_CMD_WAKEUP_METHOD;
+	pcmd->length = 4;
+	pcmd->data[0] = BT_HOST_WAKEUP_METHOD_NONE;
+	pcmd->data[1] = BT_HOST_WAKEUP_DEFAULT_GPIO;
+	switch (cmd) {
+	case WAKEUP_METHOD_DTR:
+		pcmd->data[2] = BT_CTRL_WAKEUP_METHOD_DSR;
+		break;
+	case WAKEUP_METHOD_BREAK:
+	default:
+		pcmd->data[2] = BT_CTRL_WAKEUP_METHOD_BREAK;
+		break;
+	}
+	pcmd->data[3] = BT_CTRL_WAKEUP_DEFAULT_GPIO;
+
+	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+
+	skb_put(skb, sizeof(struct BT_CMD) - 4 + pcmd->length);
+	skb->dev = (void *)hu->hdev;
+
+	/* send packet */
+	hu->proto->enqueue(hu, skb);
+	hci_uart_tx_wakeup(hu);
+
+out:
+	return err;
+}
+
+void ps_timeout_func(struct timer_list *t)
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
+
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
+	if (data->tty) {
+		switch (data->cur_wakeupmode) {
+		case WAKEUP_METHOD_DTR:
+			if (ps_state == PS_STATE_AWAKE)
+				set_dtr(data->tty, 1);  /* DTR ON */
+			else
+				set_dtr(data->tty, 0);  /* DTR OFF */
+			data->ps_state = ps_state;
+			break;
+		case WAKEUP_METHOD_BREAK:
+			if (ps_state == PS_STATE_AWAKE)
+				set_break(data->tty, 0); /* break OFF */
+			else
+				set_break(data->tty, 1); /* break ON */
+			data->ps_state = ps_state;
+			break;
+		default:
+			break;
+		}
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
+int ps_init_work(struct hci_uart *hu)
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
+	psdata->interval = DEFAULT_TIME_PERIOD;
+	psdata->timer_on    = 0;
+	psdata->tty = NULL;
+	psdata->ps_state = PS_STATE_AWAKE;
+	psdata->ps_mode = ps_mode;
+	psdata->ps_cmd = 0;
+	psdata->send_cmd = 0;
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
+void ps_init_timer(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+
+	psdata->timer_on = 0;
+	psdata->tty = hu->tty;
+	timer_setup(&psdata->ps_timer, ps_timeout_func, 0);
+}
+
+void ps_start_timer(struct hci_uart *hu)
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
+void ps_cancel_timer(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+
+	if (psdata) {
+		flush_scheduled_work();
+	if (psdata->timer_on)
+		del_timer(&psdata->ps_timer);
+	if (psdata->cur_psmode ==  PS_MODE_ENABLE &&
+	    psdata->cur_wakeupmode ==  WAKEUP_METHOD_BREAK) {
+		/* set_break off */
+		set_break(psdata->tty, 0);
+	}
+	psdata->tty = NULL;
+	kfree(psdata);
+	}
+}
+
+int ps_wakeup(struct hci_uart *hu)
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
+void ps_init(struct hci_uart *hu)
+{
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+	int mode = 0;
+	struct ktermios old_termios;
+
+	if (!psdata || !psdata->tty)
+		return;
+	if (get_cts(psdata->tty) != 1) {
+		/* firmware is sleeping */
+		mode = psdata->cur_wakeupmode;
+		if (mode == WAKEUP_METHOD_INVALID)
+			mode =  wakeupmode;
+		switch (mode) {
+		case WAKEUP_METHOD_BREAK:
+			/* set RTS */
+			set_rts(psdata->tty, 1);
+			/* break on */
+			set_break(psdata->tty, 1);
+			/* break off */
+			set_break(psdata->tty, 0);
+			mdelay(5);
+			break;
+		case WAKEUP_METHOD_DTR:
+			/* set RTS */
+			set_rts(psdata->tty, 1);
+			set_dtr(psdata->tty, 0);
+			set_dtr(psdata->tty, 1);
+			mdelay(5);
+			break;
+		default:
+			break;
+		}
+		old_termios = psdata->tty->termios;
+		psdata->tty->termios.c_cflag &= ~CRTSCTS;  /* Clear the flow control */
+		psdata->TTY_FUNC->set_termios(psdata->tty, &old_termios);
+		old_termios = psdata->tty->termios;
+		psdata->tty->termios.c_cflag |= CRTSCTS;  /* Enable the flow control */
+		psdata->TTY_FUNC->set_termios(psdata->tty, &old_termios);
+	}
+
+	psdata->send_cmd = 0;
+	if (!is_device_ready(hu)) {
+		if (psdata->cur_wakeupmode != psdata->wakeupmode) {
+			psdata->send_cmd |= SEND_WAKEUP_METHOD_CMD;
+			send_wakeup_method_cmd(psdata->wakeupmode, hu);
+		}
+		if (psdata->cur_psmode != psdata->ps_mode) {
+			psdata->send_cmd |= SEND_AUTO_SLEEP_MODE_CMD;
+			send_ps_cmd(psdata->ps_mode, hu);
+		}
+	}
+}
+
+void ps_check_event_packet(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (void *)skb->data;
+	struct hci_ev_cmd_complete *ev = NULL;
+	u8 event = hdr->evt;
+	u16 opcode;
+	u8 status = 0;
+	struct nxp_struct *nxp = hu->priv;
+	struct ps_data *psdata = nxp->psdata;
+
+	if (event == HCI_EV_CMD_COMPLETE) {
+		ev = (void *)(skb->data + sizeof(struct hci_event_hdr));
+		opcode = __le16_to_cpu(ev->opcode);
+		switch (opcode) {
+		case HCI_OP_AUTO_SLEEP_MODE:
+			status = *((u8 *)ev + sizeof(struct hci_ev_cmd_complete));
+			/* if hci_nxp has sent the command internally */
+			if (psdata->send_cmd) {
+				if (!status)
+					psdata->cur_psmode = psdata->ps_mode;
+				else
+					psdata->ps_mode = psdata->cur_psmode;
+				psdata->send_cmd &= ~SEND_AUTO_SLEEP_MODE_CMD;
+			} else {
+				if (!status)
+					psdata->cur_psmode = psdata->ps_mode;
+			}
+			if (psdata->cur_psmode == PS_MODE_ENABLE)
+				ps_start_timer(hu);
+			else
+				ps_wakeup(hu);
+			BT_INFO("Power Save mode response: status=%d, ps_mode=%d",
+				status, psdata->cur_psmode);
+			break;
+		case HCI_OP_WAKEUP_METHOD:
+			status = *((u8 *)ev + sizeof(struct hci_ev_cmd_complete));
+			/* if hci_nxp has sent the command internally */
+			if (psdata->send_cmd) {
+				psdata->send_cmd &= ~SEND_WAKEUP_METHOD_CMD;
+				if (!status)
+					psdata->cur_wakeupmode = psdata->wakeupmode;
+				else
+					psdata->wakeupmode = psdata->cur_wakeupmode;
+			} else {
+				psdata->cur_wakeupmode = ev->ncmd;
+			}
+			BT_INFO("Set Wakeup Method response: status=%d, wakeupmode=%d",
+				status, psdata->cur_wakeupmode);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+/** NXP proto **/
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
+	struct BT_CMD *pcmd = (struct BT_CMD *)skb->data;
+
+	BT_DBG("hu %p skb %p", hu, skb);
+
+	if (bt_cb(skb)->pkt_type == HCI_COMMAND_PKT) {
+		if (pcmd->ocf_ogf == ((OGF << 10) | BT_CMD_AUTO_SLEEP_MODE)) {
+			if (pcmd->data[0] == BT_PS_ENABLE)
+				psdata->ps_mode = PS_MODE_ENABLE;
+			else if (pcmd->data[0] == BT_PS_DISABLE)
+				psdata->ps_mode = PS_MODE_DISABLE;
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
+static struct sk_buff *nxp_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
+				    const unsigned char *buffer, int count,
+						const struct h4_recv_pkt *pkts,
+						int pkts_count)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	u8 alignment = hu->alignment ? hu->alignment : 1;
+
+	/* Check for error from previous call */
+	if (IS_ERR(skb))
+		skb = NULL;
+
+	while (count) {
+		int i, len;
+
+		/* remove padding bytes from buffer */
+		for (; hu->padding && count > 0; hu->padding--) {
+			count--;
+			buffer++;
+		}
+		if (!count)
+			break;
+
+		if (!skb) {
+			for (i = 0; i < pkts_count; i++) {
+				if (buffer[0] != (&pkts[i])->type)
+					continue;
+
+				skb = bt_skb_alloc((&pkts[i])->maxlen,
+						   GFP_ATOMIC);
+				if (!skb)
+					return ERR_PTR(-ENOMEM);
+
+				hci_skb_pkt_type(skb) = (&pkts[i])->type;
+				hci_skb_expect(skb) = (&pkts[i])->hlen;
+				break;
+			}
+
+			/* Check for invalid packet type */
+			if (!skb)
+				return ERR_PTR(-EILSEQ);
+
+			count -= 1;
+			buffer += 1;
+		}
+
+		len = min_t(uint, hci_skb_expect(skb) - skb->len, count);
+		skb_put_data(skb, buffer, len);
+
+		count -= len;
+		buffer += len;
+
+		/* Check for partial packet */
+		if (skb->len < hci_skb_expect(skb))
+			continue;
+
+		for (i = 0; i < pkts_count; i++) {
+			if (hci_skb_pkt_type(skb) == (&pkts[i])->type)
+				break;
+		}
+
+		if (i >= pkts_count) {
+			kfree_skb(skb);
+			return ERR_PTR(-EILSEQ);
+		}
+
+		if (skb->len == (&pkts[i])->hlen) {
+			u16 dlen;
+
+			switch ((&pkts[i])->lsize) {
+			case 0:
+				/* No variable data length */
+				dlen = 0;
+				break;
+			case 1:
+				/* Single octet variable length */
+				dlen = skb->data[(&pkts[i])->loff];
+				hci_skb_expect(skb) += dlen;
+
+				if (skb_tailroom(skb) < dlen) {
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+				break;
+			case 2:
+				/* Double octet variable length */
+				dlen = get_unaligned_le16(skb->data +
+							  (&pkts[i])->loff);
+				hci_skb_expect(skb) += dlen;
+
+				if (skb_tailroom(skb) < dlen) {
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+				break;
+			default:
+				/* Unsupported variable length */
+				kfree_skb(skb);
+				return ERR_PTR(-EILSEQ);
+			}
+
+			if (!dlen) {
+				hu->padding = (skb->len - 1) % alignment;
+				hu->padding = (alignment - hu->padding) % alignment;
+
+				/* No more data, complete frame */
+				if (hci_skb_pkt_type(skb) == HCI_EVENT_PKT)
+					ps_check_event_packet(hu, skb);
+				(&pkts[i])->recv(hdev, skb);
+				skb = NULL;
+			}
+		} else {
+			hu->padding = (skb->len - 1) % alignment;
+			hu->padding = (alignment - hu->padding) % alignment;
+
+			/* Complete frame */
+			if (hci_skb_pkt_type(skb) == HCI_EVENT_PKT)
+				ps_check_event_packet(hu, skb);
+			(&pkts[i])->recv(hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	return skb;
+}
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
+	nxp->rx_skb = nxp_recv_buf(hu->hdev, nxp->rx_skb, data, count,
+				   nxp_recv_pkts, ARRAY_SIZE(nxp_recv_pkts));
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
index 0000000..8cd0f3c
--- /dev/null
+++ b/drivers/bluetooth/hci_nxp.h
@@ -0,0 +1,118 @@
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
+	u32    ps_mode;
+	u32    cur_psmode;
+	u32    ps_state;
+	u32    ps_cmd;
+	u32    interval;
+	u32    wakeupmode;
+	u32    cur_wakeupmode;
+	u32    send_cmd;
+	struct work_struct work;
+	struct tty_struct *tty;
+	struct timer_list ps_timer;
+	u32    timer_on;
+};
+
+struct nxp_struct {
+	struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+	struct list_head        nxp_list_head;
+	unsigned char           id;
+	struct ps_data          *psdata;
+};
+
+/** Default ps timeout period in milli-second */
+#define DEFAULT_TIME_PERIOD     2000
+
+/** wakeup method DTR */
+#define WAKEUP_METHOD_DTR       0
+/** wakeup method break */
+#define WAKEUP_METHOD_BREAK     1
+/** wake up method EX break */
+#define WAKEUP_METHOD_EXT_BREAK  2
+/** wake up method RTS */
+#define WAKEUP_METHOD_RTS       3
+/** wakeup method invalid */
+#define  WAKEUP_METHOD_INVALID  0xff
+
+/** ps mode disable */
+#define PS_MODE_DISABLE         0
+/** ps mode enable */
+#define PS_MODE_ENABLE          1
+
+/** ps cmd exit ps  */
+#define PS_CMD_EXIT_PS          1
+/** ps cmd enter ps */
+#define PS_CMD_ENTER_PS         2
+
+/** ps state awake */
+#define PS_STATE_AWAKE          0
+/** ps state SLEEP */
+#define PS_STATE_SLEEP          1
+
+/** OGF */
+#define OGF				        0x3F
+/** Bluetooth command : Sleep mode */
+#define BT_CMD_AUTO_SLEEP_MODE		0x23
+/** Bluetooth command: Wakeup method */
+#define BT_CMD_WAKEUP_METHOD    0x53
+
+/** Bluetooth Power State : Enable */
+#define BT_PS_ENABLE			0x02
+/** Bluetooth Power State : Disable */
+#define BT_PS_DISABLE			0x03
+
+/** Bluetooth Host Wakeup Methods **/
+#define BT_HOST_WAKEUP_METHOD_NONE      0x00
+#define BT_HOST_WAKEUP_METHOD_DTR       0x01
+#define BT_HOST_WAKEUP_METHOD_BREAK     0x02
+#define BT_HOST_WAKEUP_METHOD_GPIO      0x03
+#define BT_HOST_WAKEUP_DEFAULT_GPIO     5
+
+/** Bluetooth Chip Wakeup Methods **/
+#define BT_CTRL_WAKEUP_METHOD_DSR       0x00
+#define BT_CTRL_WAKEUP_METHOD_BREAK     0x01
+#define BT_CTRL_WAKEUP_METHOD_GPIO      0x02
+#define BT_CTRL_WAKEUP_METHOD_EXT_BREAK  0x04
+#define BT_CTRL_WAKEUP_METHOD_RTS       0x05
+#define BT_CTRL_WAKEUP_DEFAULT_GPIO     4
+
+#define  HCI_OP_AUTO_SLEEP_MODE         0xfc23
+#define  HCI_OP_WAKEUP_METHOD           0xfc53
+
+/** send cmd flags **/
+#define SEND_WAKEUP_METHOD_CMD          0x01
+#define SEND_AUTO_SLEEP_MODE_CMD        0x02
+
+int ps_init_work(struct hci_uart *hu);
+void ps_init_timer(struct hci_uart *hu);
+void ps_start_timer(struct hci_uart *hu);
+void ps_cancel_timer(struct hci_uart *hu);
+int ps_wakeup(struct hci_uart *hu);
+void ps_init(struct hci_uart *hu);
+void ps_check_event_packet(struct hci_uart *hu, struct sk_buff *skb);
+
+#endif /* _HCI_UART_H_ */
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index fb4a2d0..17d271c 100644
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
2.7.4

