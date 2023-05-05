Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D347F6F8B34
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjEEVkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjEEVkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:40:13 -0400
Received: from mx0b-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DF049D4;
        Fri,  5 May 2023 14:40:07 -0700 (PDT)
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345L1hlt014213;
        Fri, 5 May 2023 16:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=PPS11062020;
 bh=1gPt1N6+lDKBLdvHJcLcUaujY8y6MYXZxgmT/wt75UE=;
 b=oMTCj77GwWrwdlhU73MyI30wmoX3XQp+2tuwrDkLy3f7Z6R5uOLc4QODSFUD0O7Lmq/S
 kjLGz6n3GG+mRBz8shhXOOdiEa3fRj3ZXOn+9KJ/ic4CO2YnlO5zKKuHLAUdBHIS0Ic9
 H1qgDikaw1ITXMEA6G8ELNEHnN122amJydKCg/x1VlpWwfClY0JK62q+RF1JIc37jPUn
 DNVsduoZaVwlCn89dZpUw9R1HL0hmTx9PlP1cjk0EBePjyQiRB2k99VLv1J0vTMWn6z+
 jWcBobHbOQ49WfppqodJjLVzCDNhrlk2IS3RAi515ZViNHbwgMmdFjRNWSqk4VOpJa1G bA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00010702.pphosted.com (PPS) with ESMTPS id 3q90rwcv3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 16:39:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esA4id1BaG60eyYOqe457bni5mLzHsIP4v9rUjTzDMlmdBPEAKGs8+90SHQbDjz7o35dJu7sj1OC186fvuJKSANefhhKXHvRDIbUV2QjVb42ya6TcdThTFCZw+UEW+dnzkHCNKb4qEJPUdfMd3vhoavRlLGDSaxkMMQJzZRno7Ak3dgZ1SSJcR0Ha0sWy5PIgZjOzLQHpa0iqNzPFiCmRT5SaTxAzDMlKAJ1KNXmjECyU4NyT9Dgr8mbWIb1PuOqA30qSk9DbIfIvgLH2X8fX9xSnXq/bdTFQxrmjai1nIjSEqlM+MD7RS9XtbukHh0MC4LjVFvvs/dbqM5LGY8rYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gPt1N6+lDKBLdvHJcLcUaujY8y6MYXZxgmT/wt75UE=;
 b=izqy/bNH7HuwYu8RQvLs5KKHnxG5zeIEyumGidJtUXI7bFyIH2ufaUex6J5VciEVEKw7uxzIgCCfvuXhLLW0CP0p+g6LN+tltuAdHS83o0/MHZISWXzBQvm3O7S9MdQcqGjFip85H++Ewyob67Pqk8FDCo0MiqppPauqMe1LWu57GDaUPC6qTUP60PQlzBBq7THD9BURchGhjOwOy25wLh+bCprEO27jj1qmsqQPeFKffByL9sIhh9+n7/ri+jbu4Qe7mWAPP46922a6xv91EgL2muVYrHJrtllhK43FkQSiPuSev2vrsiW8Yk5eH0lLd8b6UILri2S49i3denTQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gPt1N6+lDKBLdvHJcLcUaujY8y6MYXZxgmT/wt75UE=;
 b=NkjmUcRldaikBrSJMr18CbRKwVRdMhLFbw1X0XdGyvOTmq25zjwOOcLiZRrIUW1bpFqVqy2hDNdZ/9Ssq5VmCKD5wPa9jMXc+kJ2lfVLf4iKZYYDDqYLxCR5h0M8me2bLrYXy/RCBCJHqdjtPlo/HhsCx0WrKrS3d/GrqWDdIV8=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SJ0PR04MB7341.namprd04.prod.outlook.com (2603:10b6:a03:29e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 21:39:25 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654%5]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 21:39:25 +0000
From:   Brenda Streiff <brenda.streiff@ni.com>
Cc:     ilpo.jarvinen@linux.intel.com,
        Brenda Streiff <brenda.streiff@ni.com>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 tty-next 2/2] serial: 8250: add driver for NI UARTs
Date:   Fri,  5 May 2023 16:38:50 -0500
Message-Id: <20230505213850.829639-3-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230505213850.829639-1-brenda.streiff@ni.com>
References: <20230505213850.829639-1-brenda.streiff@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::23) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|SJ0PR04MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: d14c8a0d-200f-4457-844c-08db4db1322c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWo58eReZNgz3Zt7yCXtdLebysfkWgE9dOfa+lcJqpj0hGrk21fd7ExqNcE9Am/Ofe5dk5+PKIfcW5gz7vuV/NlhPMJNtlxqMqajAiMXz8JxR5PlETN33q7nm2yybYkUqREUP68+KhP50ZxRzqm8n0pP7WIa3NuNQ/yuwSim7cVCJzwggXPRelWnuAZXw0Q31Go7xkpeFJGxJYQupDAi9tQ61rcKGZCe8d9v124xm49fnlJ6ZACU4Syg3vwd0R6vtKpyRkfESOZbzn45PCinu8CVYieLbmAPOjoSwwrrG3vjmSOnpf5+zulPqxxt1vA7RtdStTOYff8bG2kgAUBoomwKu+lpFt1gSjH+fDKMneaSf4Qj2A42REF0AHLe/h981lbBh2gKiHrdMQCdGXqZs/8350zUEpBWRsBcNfs304+k+z8AYe1G9eqabwv/5/fqjsm5Bz5L+UXNk1R0GVCEHOK0nbBkd+FGryQRla/r8oudzhA6Gl3HtSNHhqucxP2whDwHeHtAJ9jJBcxX2qg2RUNFjYbizbVZvTfRXEK3TZWElC3eHFa/zgGz98SHnI75uvE8iAkD1i00oGc+Hlp2D/5K19TkIDaXld06tFChpUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(366004)(39860400002)(376002)(109986019)(451199021)(8936002)(30864003)(8676002)(2906002)(478600001)(54906003)(5660300002)(41300700001)(44832011)(66476007)(66556008)(316002)(66946007)(4326008)(36756003)(6506007)(1076003)(186003)(26005)(83380400001)(6512007)(86362001)(2616005)(6666004)(6486002)(38100700002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WH5vQS7f1L9/ynQ/VrLI7pcNGUCjTWb3v3e0cl2/V1U+BpnbWwya7M1Y+jiX?=
 =?us-ascii?Q?HEzQMuosDPW6aIM7JZCyu/FGhpKbsWFUkqGkYO+uGt50TNS5wRZaOKjcz5y0?=
 =?us-ascii?Q?iuSdO3e8t7QmX/OBjriVcA9aVR5sgFehyTvYu1WkfEPh+fgOR22nNg4FcX5z?=
 =?us-ascii?Q?AvH+01ojr6nGTYlAu/304uYNIBRziLgwdywELjmUteKzLo7msDMpzwqgBFcG?=
 =?us-ascii?Q?/y40KfyEricmB34rN8QZfMrWUwl4HazPX9oPI8jWkSCNfslzv682IJWfW/Od?=
 =?us-ascii?Q?0YNqbz/iXNg0UeS+0miVt05p1M13QhMQwIcRKFXVa91kIw+Y4MCNS6VKl0jt?=
 =?us-ascii?Q?8QheZevJzjw7hxC3xzbFR8HH64MBkJTVRPlTp3o2efSwwEHu8N1RVWeE+YOv?=
 =?us-ascii?Q?qrqc403Mk4m2KOgdF6kiWDN+JwEZnjqdvNsZxfnyjfkZ9vVCUlg/2343etJX?=
 =?us-ascii?Q?OJ0I/allgRB1x32Kxq1vkatzVdyJYWCJSrUzO/AJ7hK3Y0J3jSCx2ytnNscE?=
 =?us-ascii?Q?UC+sfluPbSTUO356T8v1mi/0zudx5aI35hUwfb+63liHkf0zJxDuyeG+2uKV?=
 =?us-ascii?Q?HoL810UgB/zHasQFZIYxT3RE/DP3BjIgxXp5NM9AUj6f12qEF8olr7sDuG3Y?=
 =?us-ascii?Q?haL2ymf8NVeR8WJjNrOLnijKyfSHwBPmi+f76uYh5d8lNZTMQczSvEvhqwO7?=
 =?us-ascii?Q?5qIGFEmQWsHY9w7mdgLZbXmOcbI3XDT4o5LuV0IpWE/mTZklTtvrJe3lWdK4?=
 =?us-ascii?Q?edbOFhY+YgJhZFmFpa8M3JJcMPYpcuMx0lP6svqJlCn6Ah9ac5NHraRFg83S?=
 =?us-ascii?Q?OYjEu771xdW4pL23yVdpCsmgmsH6ndcTk8YKNOkXG9SS8nyOrYx7q4zEltWl?=
 =?us-ascii?Q?Dzoqwmyuj882C8cQ976GaAbAQ3VLVseRENtoEFAkfJIBGD/gpdr39djsID6U?=
 =?us-ascii?Q?+g3MYdAQ4SSTbldnjKPPv2RAKfEowMl1ZwSU28FXrcQlx76f2EZgcn0O31N2?=
 =?us-ascii?Q?HDU5teVxvrCV/kYNMoqxqPRdNd9N/m7O5pUXofvx3r0zPEjIQ0mpdqND8+2n?=
 =?us-ascii?Q?oug1oHnWmDMg/lOqXwKlrwR23l9BqAoLpdkQce5c+mFAu+Pdv5+s12vYtc57?=
 =?us-ascii?Q?52quXQmaxOagmkRE4/iHl08sDdwAcSOypdAC5m7u8UUFR7RTiJSs9D32Q0KC?=
 =?us-ascii?Q?DcYmEIJN94SeVqo6BLi2DWc4nMqSLeVNObevgNT7FnXuWBdMlwTNER5lW2Vs?=
 =?us-ascii?Q?rIdS+QHYMwv2nqS4jiPXX3AJZZO/D1moHPWZHe569F5+aZR7w4GQsA9UBq1R?=
 =?us-ascii?Q?6o8lQxHXBQuQSYqIXMnHHARLepnW6Qq89YEhDKzPfp5myeZd08jkL4F3MrxW?=
 =?us-ascii?Q?qchBNb0bousVGYqBJCbW9PctbVIVvTnqrrRao5fJWo6+Ng4MlToyxAk6aNup?=
 =?us-ascii?Q?2qeX2hxeibaoo6H/0iltAy9C5W2+Czevmj7XF0+pO1KVU3fowvFzdGYelkfb?=
 =?us-ascii?Q?O9y4j4egwmFs14/2sPzcVLtKa0HHZvtewrvJStavLvchYzztMwLiYCBXeSeq?=
 =?us-ascii?Q?py5rIE/XHvjUSu75SrLcKfepy9zuzchTnay29Hgd?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14c8a0d-200f-4457-844c-08db4db1322c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 21:39:25.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gN+eZhd7xYONBPnLFNv/nd3OrPrrPbM2oMBJyVpGRNoy41hxuLdoKzUqJJH4Ef3bOJoWiVpvxmTVpLOx15AWjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7341
X-Proofpoint-GUID: -Kk_FvPh-1Ax_yLI4NDV33PZOwP6aprr
X-Proofpoint-ORIG-GUID: -Kk_FvPh-1Ax_yLI4NDV33PZOwP6aprr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_27,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305050175
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The National Instruments (NI) 16550 is a 16550-like UART with larger
FIFOs and embedded RS-232/RS-485 transceiver control circuitry. This
patch adds a driver that can operate this UART, which is used for
onboard serial ports in several NI embedded controller designs.

Portions of this driver were originally written by Jaeden Amero and
Karthik Manamcheri, with extensive cleanups and refactors since.

Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
Cc: Gratian Crisan <gratian.crisan@ni.com>
Cc: Jason Smith <jason.smith@ni.com>
---
 MAINTAINERS                       |   7 +
 drivers/tty/serial/8250/8250_ni.c | 470 ++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig   |  13 +
 drivers/tty/serial/8250/Makefile  |   1 +
 4 files changed, 491 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_ni.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..4d44622da6cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14323,6 +14323,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
 F:	drivers/mtd/nand/
 F:	include/linux/mtd/*nand*.h
 
+NATIONAL INSTRUMENTS SERIAL DRIVER
+M:	Brenda Streiff <brenda.streiff@ni.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/serial/ni,ni16550.yaml
+F:	drivers/tty/serial/8250/8250_ni.c
+
 NATIVE INSTRUMENTS USB SOUND INTERFACE DRIVER
 M:	Daniel Mack <zonque@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
new file mode 100644
index 000000000000..b33861d5a431
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -0,0 +1,470 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * NI 16550 UART Driver
+ *
+ * The National Instruments (NI) 16550 is a UART that is compatible with the
+ * TL16C550C and OX16C950B register interfaces, but has additional functions
+ * for RS-485 transceiver control. This driver implements support for the
+ * additional functionality on top of the standard serial8250 core.
+ *
+ * Copyright 2012-2023 National Instruments Corporation
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/clk.h>
+
+#include "8250.h"
+
+/* Extra bits in UART_ACR */
+#define NI16550_ACR_AUTO_DTR_EN			BIT(4)
+
+/* TFS - TX FIFO Size */
+#define NI16550_TFS_OFFSET	0x0C
+/* RFS - RX FIFO Size */
+#define NI16550_RFS_OFFSET	0x0D
+
+/* PMR - Port Mode Register */
+#define NI16550_PMR_OFFSET	0x0E
+/* PMR[1:0] - Port Capabilities */
+#define NI16550_PMR_CAP_MASK			GENMASK(1, 0)
+#define NI16550_PMR_NOT_IMPL			0x00 /* not implemented */
+#define NI16550_PMR_CAP_RS232			0x01 /* RS-232 capable */
+#define NI16550_PMR_CAP_RS485			0x02 /* RS-485 capable */
+#define NI16550_PMR_CAP_DUAL			0x03 /* dual-port */
+/* PMR[4] - Interface Mode */
+#define NI16550_PMR_MODE_MASK			GENMASK(4, 4)
+#define NI16550_PMR_MODE_RS232			0x00 /* currently 232 */
+#define NI16550_PMR_MODE_RS485			0x10 /* currently 485 */
+
+/* PCR - Port Control Register */
+#define NI16550_PCR_OFFSET	0x0F
+#define NI16550_PCR_RS422			0x00
+#define NI16550_PCR_ECHO_RS485			0x01
+#define NI16550_PCR_DTR_RS485			0x02
+#define NI16550_PCR_AUTO_RS485			0x03
+#define NI16550_PCR_WIRE_MODE_MASK		GENMASK(1, 0)
+#define NI16550_PCR_TXVR_ENABLE_BIT		BIT(3)
+#define NI16550_PCR_RS485_TERMINATION_BIT	BIT(6)
+
+/* flags for ni16550_device_info */
+#define NI_HAS_PMR		BIT(0)
+
+struct ni16550_device_info {
+	u32 uartclk;
+	u8 prescaler;
+	u8 flags;
+};
+
+struct ni16550_data {
+	int line;
+	struct clk *clk;
+};
+
+static int ni16550_enable_transceivers(struct uart_port *port)
+{
+	u8 pcr;
+
+	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
+	pcr |= NI16550_PCR_TXVR_ENABLE_BIT;
+	dev_dbg(port->dev, "enable transceivers: write pcr: 0x%02x\n", pcr);
+	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
+
+	return 0;
+}
+
+static int ni16550_disable_transceivers(struct uart_port *port)
+{
+	u8 pcr;
+
+	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
+	pcr &= ~NI16550_PCR_TXVR_ENABLE_BIT;
+	dev_dbg(port->dev, "disable transceivers: write pcr: 0x%02x\n", pcr);
+	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
+
+	return 0;
+}
+
+static int ni16550_rs485_config(struct uart_port *port,
+				struct ktermios *termios,
+				struct serial_rs485 *rs485)
+{
+	struct uart_8250_port *up = container_of(port, struct uart_8250_port, port);
+	u8 pcr;
+
+	pcr = serial_in(up, NI16550_PCR_OFFSET);
+	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* RS-485 */
+		dev_dbg(port->dev, "2-wire Auto\n");
+		pcr |= NI16550_PCR_AUTO_RS485;
+		up->acr |= NI16550_ACR_AUTO_DTR_EN;
+	} else {
+		/* RS-422 */
+		dev_dbg(port->dev, "4-wire\n");
+		pcr |= NI16550_PCR_RS422;
+		up->acr &= ~NI16550_ACR_AUTO_DTR_EN;
+	}
+
+	dev_dbg(port->dev, "config rs485: write pcr: 0x%02x, acr: %02x\n", pcr, up->acr);
+	serial_out(up, NI16550_PCR_OFFSET, pcr);
+	serial_icr_write(up, UART_ACR, up->acr);
+
+	return 0;
+}
+
+static bool is_pmr_rs232_mode(struct uart_8250_port *up)
+{
+	u8 pmr = serial_in(up, NI16550_PMR_OFFSET);
+	u8 pmr_mode = pmr & NI16550_PMR_MODE_MASK;
+	u8 pmr_cap = pmr & NI16550_PMR_CAP_MASK;
+
+	/*
+	 * If the PMR is not implemented, then by default NI UARTs are
+	 * connected to RS-485 transceivers
+	 */
+	if (pmr_cap == NI16550_PMR_NOT_IMPL)
+		return false;
+
+	if (pmr_cap == NI16550_PMR_CAP_DUAL)
+		/*
+		 * If the port is dual-mode capable, then read the mode bit
+		 * to know the current mode
+		 */
+		return pmr_mode == NI16550_PMR_MODE_RS232;
+	/*
+	 * If it is not dual-mode capable, then decide based on the
+	 * capability
+	 */
+	return pmr_cap == NI16550_PMR_CAP_RS232;
+}
+
+static void ni16550_config_prescaler(struct uart_8250_port *up,
+				     u8 prescaler)
+{
+	/*
+	 * Page in the Enhanced Mode Registers
+	 * Sets EFR[4] for Enhanced Mode.
+	 */
+	u8 lcr_value;
+	u8 efr_value;
+
+	lcr_value = serial_in(up, UART_LCR);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+
+	efr_value = serial_in(up, UART_EFR);
+	efr_value |= UART_EFR_ECB;
+
+	serial_out(up, UART_EFR, efr_value);
+
+	/* Page out the Enhanced Mode Registers */
+	serial_out(up, UART_LCR, lcr_value);
+
+	/* Set prescaler to CPR register. */
+	serial_out(up, UART_SCR, UART_CPR);
+	serial_out(up, UART_ICR, prescaler);
+}
+
+static const struct serial_rs485 ni16550_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
+	/*
+	 * delay_rts_* and RX_DURING_TX are not supported.
+	 *
+	 * RTS_{ON,AFTER}_SEND are supported, but ignored; the transceiver
+	 * is connected in only one way and we don't need userspace to tell
+	 * us, but want to retain compatibility with applications that do.
+	 */
+};
+
+static void ni16550_rs485_setup(struct uart_port *port)
+{
+	port->rs485_config = ni16550_rs485_config;
+	port->rs485_supported = ni16550_rs485_supported;
+	/*
+	 * The hardware comes up by default in 2-wire auto mode and we
+	 * set the flags to represent that
+	 */
+	port->rs485.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
+}
+
+static int ni16550_port_startup(struct uart_port *port)
+{
+	int ret;
+
+	ret = serial8250_do_startup(port);
+	if (ret)
+		return ret;
+
+	return ni16550_enable_transceivers(port);
+}
+
+static void ni16550_port_shutdown(struct uart_port *port)
+{
+	ni16550_disable_transceivers(port);
+
+	serial8250_do_shutdown(port);
+}
+
+static int ni16550_get_regs(struct platform_device *pdev,
+			    struct uart_port *port)
+{
+	struct resource *regs;
+
+	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (regs) {
+		port->iotype = UPIO_PORT;
+		port->iobase = regs->start;
+
+		return 0;
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (regs) {
+		port->iotype = UPIO_MEM;
+		port->mapbase = regs->start;
+		port->mapsize = resource_size(regs);
+		port->flags |= UPF_IOREMAP;
+
+		port->membase = devm_ioremap(&pdev->dev, port->mapbase,
+					     port->mapsize);
+		if (!port->membase)
+			return -ENOMEM;
+
+		return 0;
+	}
+
+	dev_err(&pdev->dev, "no registers defined\n");
+	return -EINVAL;
+}
+
+static u8 ni16550_read_fifo_size(struct uart_8250_port *uart, int reg)
+{
+	/*
+	 * Very old implementations don't have the TFS or RFS registers
+	 * defined, so we may read all-0s or all-1s. For such devices,
+	 * assume a FIFO size of 128.
+	 */
+	u8 value = serial_in(uart, reg);
+
+	if (value == 0x00 || value == 0xFF)
+		return 128;
+
+	return value;
+}
+
+static void ni16550_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	mctrl |= UART_MCR_CLKSEL;
+
+	serial8250_do_set_mctrl(port, mctrl);
+}
+
+static int ni16550_probe(struct platform_device *pdev)
+{
+	const struct ni16550_device_info *info;
+	struct device *dev = &pdev->dev;
+	struct uart_8250_port uart = {};
+	struct ni16550_data *data;
+	const char *portmode;
+	unsigned int prescaler;
+	int txfifosz, rxfifosz;
+	int rs232_property;
+	int ret;
+	int irq;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&uart.port.lock);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = ni16550_get_regs(pdev, &uart.port);
+	if (ret < 0)
+		return ret;
+
+	/* early setup so that serial_in()/serial_out() work */
+	serial8250_set_defaults(&uart);
+
+	info = device_get_match_data(dev);
+
+	uart.port.dev		= dev;
+	uart.port.irq		= irq;
+	uart.port.irqflags	= IRQF_SHARED;
+	uart.port.flags		= UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
+					| UPF_FIXED_PORT | UPF_FIXED_TYPE;
+	uart.port.startup	= ni16550_port_startup;
+	uart.port.shutdown	= ni16550_port_shutdown;
+
+	/*
+	 * Hardware instantiation of FIFO sizes are held in registers.
+	 */
+	txfifosz = ni16550_read_fifo_size(&uart, NI16550_TFS_OFFSET);
+	rxfifosz = ni16550_read_fifo_size(&uart, NI16550_RFS_OFFSET);
+
+	dev_dbg(dev, "NI 16550 has TX FIFO size %d, RX FIFO size %d\n",
+		txfifosz, rxfifosz);
+
+	uart.port.type		= PORT_16550A;
+	uart.port.fifosize	= txfifosz;
+	uart.tx_loadsz		= txfifosz;
+	uart.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
+	uart.capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
+
+	/*
+	 * Declaration of the base clock frequency can come from one of:
+	 * - static declaration in this driver (for older ACPI IDs)
+	 * - a "clock-frquency" ACPI or OF device property
+	 * - an associated OF clock definition
+	 */
+	if (info->uartclk)
+		uart.port.uartclk = info->uartclk;
+	if (device_property_read_u32(dev, "clock-frequency",
+				     &uart.port.uartclk)) {
+		data->clk = devm_clk_get_optional_enabled(dev, NULL);
+		if (data->clk)
+			uart.port.uartclk = clk_get_rate(data->clk);
+	}
+
+	if (!uart.port.uartclk) {
+		dev_err(dev, "unable to determine clock frequency!\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	if (info->prescaler)
+		prescaler = info->prescaler;
+	device_property_read_u32(dev, "clock-prescaler", &prescaler);
+
+	if (prescaler != 0) {
+		uart.port.set_mctrl = ni16550_set_mctrl;
+		ni16550_config_prescaler(&uart, (u8)prescaler);
+	}
+
+	/*
+	 * The determination of whether or not this is an RS-485 or RS-232 port
+	 * can come from a device property (if present), or it can come from
+	 * the PMR (if present), and otherwise we're solely an RS-485 port.
+	 *
+	 * This is a device-specific property, and thus has a vendor-prefixed
+	 * "ni,serial-port-mode" form as a devicetree binding. However, there
+	 * are old devices in the field using "transceiver" as an ACPI device
+	 * property, so we have to check for that as well.
+	 */
+	if (!device_property_read_string(dev, "ni,serial-port-mode",
+					 &portmode) ||
+	    !device_property_read_string(dev, "transceiver", &portmode)) {
+		rs232_property = strncmp(portmode, "RS-232", 6) == 0;
+
+		dev_dbg(dev, "port is in %s mode (via device property)",
+			(rs232_property ? "RS-232" : "RS-485"));
+	} else if (info->flags & NI_HAS_PMR) {
+		rs232_property = is_pmr_rs232_mode(&uart);
+
+		dev_dbg(dev, "port is in %s mode (via PMR)",
+			(rs232_property ? "RS-232" : "RS-485"));
+	} else {
+		rs232_property = 0;
+
+		dev_dbg(dev, "port is fixed as RS-485");
+	}
+
+	if (!rs232_property) {
+		/*
+		 * Neither the 'transceiver' property nor the PMR indicate
+		 * that this is an RS-232 port, so it must be an RS-485 one.
+		 */
+		ni16550_rs485_setup(&uart.port);
+	}
+
+	ret = serial8250_register_8250_port(&uart);
+	if (ret < 0)
+		goto err;
+	data->line = ret;
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+
+err:
+	clk_disable_unprepare(data->clk);
+	return ret;
+}
+
+static int ni16550_remove(struct platform_device *pdev)
+{
+	struct ni16550_data *data = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(data->clk);
+	serial8250_unregister_port(data->line);
+	return 0;
+}
+
+static const struct ni16550_device_info ni16550_default = { };
+
+static const struct of_device_id ni16550_of_match[] = {
+	{ .compatible = "ni,ni16550", .data = &ni16550_default },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ni16550_of_match);
+
+/* NI 16550 RS-485 Interface */
+static const struct ni16550_device_info nic7750 = {
+	.uartclk = 33333333,
+};
+
+/* NI CVS-145x RS-485 Interface */
+static const struct ni16550_device_info nic7772 = {
+	.uartclk = 1843200,
+	.flags = NI_HAS_PMR,
+};
+
+/* NI cRIO-904x RS-485 Interface */
+static const struct ni16550_device_info nic792b = {
+	/* Sets UART clock rate to 22.222 MHz with 1.125 prescale */
+	.uartclk = 22222222,
+	.prescaler = 0x09,
+};
+
+/* NI sbRIO 96x8 RS-232/485 Interfaces */
+static const struct ni16550_device_info nic7a69 = {
+	/* Set UART clock rate to 29.629 MHz with 1.125 prescale */
+	.uartclk = 29629629,
+	.prescaler = 0x09,
+};
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id ni16550_acpi_match[] = {
+	{ "NIC7750",	(kernel_ulong_t)&nic7750 },
+	{ "NIC7772",	(kernel_ulong_t)&nic7772 },
+	{ "NIC792B",	(kernel_ulong_t)&nic792b },
+	{ "NIC7A69",	(kernel_ulong_t)&nic7a69 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ni16550_acpi_match);
+#endif
+
+static struct platform_driver ni16550_driver = {
+	.driver = {
+		.name = "ni16550",
+		.of_match_table = ni16550_of_match,
+		.acpi_match_table = ACPI_PTR(ni16550_acpi_match),
+	},
+	.probe = ni16550_probe,
+	.remove = ni16550_remove,
+};
+
+module_platform_driver(ni16550_driver);
+
+MODULE_AUTHOR("Jaeden Amero <jaeden.amero@ni.com>");
+MODULE_AUTHOR("Karthik Manamcheri <karthik.manamcheri@ni.com>");
+MODULE_DESCRIPTION("NI 16550 Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 5313aa31930f..2d9f917e96a0 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -565,6 +565,19 @@ config SERIAL_8250_BCM7271
 	  including DMA support and high accuracy BAUD rates, say
 	  Y to this option. If unsure, say N.
 
+config SERIAL_8250_NI
+	tristate "NI 16550 based serial port"
+	depends on SERIAL_8250
+	depends on (X86 && ACPI) || (ARCH_ZYNQ && OF) || COMPILE_TEST
+	help
+	  This driver supports the integrated serial ports on National
+	  Instruments (NI) controller hardware. This is required for all NI
+	  controller models with onboard RS-485 or dual-mode RS-485/RS-232
+	  ports.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 8250_ni.
+
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 4fc2fc1f41b6..58dc1b5ff054 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_SERIAL_8250_PERICOM)	+= 8250_pericom.o
 obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
 obj-$(CONFIG_SERIAL_8250_TEGRA)		+= 8250_tegra.o
 obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
+obj-$(CONFIG_SERIAL_8250_NI)		+= 8250_ni.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
-- 
2.30.2

