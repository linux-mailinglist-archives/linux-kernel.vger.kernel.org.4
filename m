Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A616DCCA6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjDJVNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJVNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:13:15 -0400
Received: from mx0b-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8EC1FD7;
        Mon, 10 Apr 2023 14:13:13 -0700 (PDT)
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ACLOOr016428;
        Mon, 10 Apr 2023 16:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=PPS11062020;
 bh=CY0jAXNoi+LVkZEVoc3TmsyITEE/dW7sZcRIheP7r60=;
 b=MrlmJ+VNHjhElCbbOGub0vahC7escvIzs/fGmsuPkPvODaHTidTpdT42+Yrm3Lldbhd+
 fVrYJZBHrFKue7b7u41kp1xHOBaanxzqoY3jWvvY+JkA1Frr6tk2LDoO7huT2nA7sFNS
 7yfuNAJLnyOWKZySAUFCeyoAftP3b07VEcc6CjWvVHRF5qzrrPzzCHlsegC+4vFckqNZ
 +XyP6djY9HIZOfNE0Cy2ZCgYVamR6P7cdzjWmDrmkXuEK5+aEI6PIkaXdUq2jOcG+1c7
 3tkUVK5Z73PmQwwRlT/SPC6ayDuK2MI/7URWu+E8Qjb5OoHTFDX6PW/g+Ln+E6bTy/1b CQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00010702.pphosted.com (PPS) with ESMTPS id 3pu5sxbauv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 16:13:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kj/ntg0NMJppdcWJQNRTt8g0ap6Dc4E22s2aDMkcXDRROY4uRL//jHw5FPPrIF8btVsKR7T1qXCGFeVsxVIglQelcPekpTcYbjnolZIyY1qSY+RYjEnpQjBNu2XSUhaOZchwXz7A+b5O8bRRpBX7mz0J3LMOyz6Kjv48O3t20xNekT2ekzGlSxcziLwClNShUFYx8W8cDv7c7S8r05QooVzjxxqrIDtu3q9U3QcNkZN2LF8IACE7NI2omvX1OSaqjaqIMBVXKz+bCkt6SeYl+/66IISexxEXjBVnKK9sSMsUkXuMu9z5Tl1QHDbkvkA/yTgO6QAfgrlU3iFFHx7qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY0jAXNoi+LVkZEVoc3TmsyITEE/dW7sZcRIheP7r60=;
 b=g1yqdOsNXzgfYAkOXbxwLC01huve9ft9ofN8D5lHssjIVyIG4bK+SP2lvET3X0eMYgW9x64XF+BRO3gZfTNNIOGmlrfQNNz57EK3ZdRiLUwrnJN1CsUyWLdGo5vutYBQdr+31WipM7ibVvh4MKNXYmHEWWRL2xmyVgJSwo6eN/UTQoNB3wj+HKkptyJrCOo51Vz9Hs+3npy7AzIqNrXRFfjx7bpqo4mHFK1oHEQOMa9uaS2Jlb10ZYtjuNvfsJED30aJ0YSXswA39yn1gCHhuuxfytNmj2QPkKGlsZi8Deh27MGAYN5u2Mj5z2RrP+jMNLtXFkYKiEJbz5hGIU7uXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY0jAXNoi+LVkZEVoc3TmsyITEE/dW7sZcRIheP7r60=;
 b=s3e3mjf32gL8D/vJhOqEjh5rOBjGfD0VfyIyR22NFuBmQ0o6rU/qrtruQ7AsnnmgOmMUzx9GU1l+7Wxx/B8Oz5+nzl0Bbk7eibLngqyyFR0Ud0vNc6jjEtkvWE2+fLZtfRehEU2zpR7R86sXfw+aOzjAfzHDznnpqsnXI+qP440=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SJ0PR04MB8568.namprd04.prod.outlook.com (2603:10b6:a03:4e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Mon, 10 Apr
 2023 21:12:54 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::bb22:1910:9f48:1f00%7]) with mapi id 15.20.6254.033; Mon, 10 Apr 2023
 21:12:53 +0000
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
Subject: [PATCH v2 tty-next 2/2] serial: 8250: add driver for NI UARTs
Date:   Mon, 10 Apr 2023 16:11:51 -0500
Message-Id: <20230410211152.94332-3-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230410211152.94332-1-brenda.streiff@ni.com>
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230410211152.94332-1-brenda.streiff@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0104.namprd05.prod.outlook.com
 (2603:10b6:803:42::21) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|SJ0PR04MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa4d843-87a8-4139-bd9f-08db3a08596a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQ5elUH1hQCHwSMUBaWWmQTHoubK7lE1HKvVCs+n+bokdybnkR1gXq5NlKdx+/Gp7K7Ur01ahPpb5EKUD7Zpfxjt/ignJGZAxU/780iqT4zoy/O54N9EMIwTzYYjzz4jc8TBibGN/HcVN8CLcdHNsDKoefvyi0zFol97HRsdwkBV398hXYvvj6OYb0GIei5ihOidjK1Z0/Ryq/6V0UZ69IsJ0NRNdM3SUjd1e4FTJNk3qjrwq34JvqkDDzArjOUa2FcBGYn7wVMIJJ0a0IcKMyoH8AgCMoBJI5jR+LB9qwOvKLpz8JfrL/XBNLCdTp6VSdXQKUG4MEMG6DMO8I6Ef4N87pHoElL0u9ll6NLAu/aKMMYW9SnoB6JggSP5VLdiaikZLlr7VVn/qousEZ1LcJZnHq4BMQslrlmYdUlfMqavZyGPJki0CEXldTt5Oq92cFnVsMliXevcvnh3ZbNWazU7DzmC9kQ6+SEXZPzQvN/77p1BR/WLbr0SH/Aq2oyNqda7bHvOSoulwdPRIyHotUlaBteYcSihIGJhNdfC5S4KcGoJCx3+vVNjCWnPb8yHVGgMA8MelbsLtVG0t47YhoDafa0LJpgINacIgZZa+uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(109986019)(451199021)(83380400001)(30864003)(66476007)(66556008)(38100700002)(8676002)(66946007)(4326008)(5660300002)(2616005)(44832011)(8936002)(2906002)(41300700001)(54906003)(86362001)(26005)(186003)(316002)(36756003)(478600001)(1076003)(6486002)(6506007)(6512007)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxYLMLPr1vUqx/qvbhsiGhOxDcdgDUuGbU42q6D9YFNB5UK7KeqjHN3PgW/o?=
 =?us-ascii?Q?MYdQA8e80TPgmQYwL4mEVN1kXocvn+TeWdGgDnEGK8ukcJ2BM3dGFb6O1qlP?=
 =?us-ascii?Q?bZpTEslt1M60I7kfqjxcjjFbPjbgGMo+HY28kh00rqw9yGkuawBhO+oNS2jL?=
 =?us-ascii?Q?6zks0xyckDREg1wPM4tMv5t2eYX2HmdhtAjAcsAvN+qzR0h+hge4ymRxCY9/?=
 =?us-ascii?Q?9r2mjndrZnKU2uiXXSupKC/Lk7qJ1oaobBGcDpMA+K3KtG/CzOvktwLjoJra?=
 =?us-ascii?Q?CQfZiPQO3vtbbeaC4aLkAVreWVonJN2k/34tHD584X8HWM7W2B7g+uF52aj5?=
 =?us-ascii?Q?/KOomK5b9PDdIKbNx0dUg/PcsH+ACoOi0DhzOOcDLB3CWenEzJH5ZgYGWbwT?=
 =?us-ascii?Q?YrMqwWz8FqdbYyLZHjdJBQbjBa7ymQyNF+tipr71FFJmC9pWmnifPD0mv/6E?=
 =?us-ascii?Q?N797lCfKykQPJzgAT+lNrGR0ZxetppqC5VQdDObzF9Umylbajht5WCYv0mv0?=
 =?us-ascii?Q?OtPYwtO2frTe9Ty6kvTYaG9VI0qvJdCWWv4JtWkWzIBCVly+QibGPh4Ud6/s?=
 =?us-ascii?Q?3dH3gh/d/NVKbfkQwuR+ZGDUJoGbcdVDkwDkEQhfGCE+Bh/tBm+rgG3i0zpw?=
 =?us-ascii?Q?4QYksfpU/i7rLRdFLddeWAfA/8aaE/ssVQ7jYrYBtociUILaPmZOBoVZ5zZg?=
 =?us-ascii?Q?06hhDSTP2xMopOIsPs8JAIVgwsAvJAbcCe4Uxy0qDn4HNhBXgu0PX6pzhJbl?=
 =?us-ascii?Q?81Ap491zEela5rw7gHx7SbLPKZgB/Uuu60EcYR3DCuBUzEUvZmvsKg0RT+BD?=
 =?us-ascii?Q?HGLlbPyT/h3q1oxjIde5X6/STIjFWDMtqxR6BL+RvGzz1VdF/GheVeicFjZG?=
 =?us-ascii?Q?PvBPvDOiOX+TziJn5o1vA9E3edJ6twAUrcAkgiaLcSUHRgTu0HY0LLfIZ1Da?=
 =?us-ascii?Q?NSc7LjP2HCvYIzWhO1Dv879Q9aIwE8sfnlfBZ/PypdemH/JBQtpGHcPJZ6dE?=
 =?us-ascii?Q?WZs4b0U6Yu2UBvPMpy+Vi6W187Mc4VQcfn2NvByzFXTu1QV76IvuIw2HsRbR?=
 =?us-ascii?Q?LP9XXny3vhnnG/1KuXHSqH7vnRMp7zIuMvT/dk3KTOrkh+yEKLQ999kqcjT/?=
 =?us-ascii?Q?z+jW5C/IHHVUisHIklQYMbbDsO41oixy8Am01GnI3rTXFKuIV3ky8RVl96aI?=
 =?us-ascii?Q?cpjKCa/k+lb6JFAFKFjlKjzNMrydkEskkUsUXQJ8aJidv7K/yvj3aZ1mqTct?=
 =?us-ascii?Q?i17vP7pOPI5XHJVWJeyE1nLII1nz0DLg5t3/GOWJsbWzCy62YSQQigf4myX2?=
 =?us-ascii?Q?7zAnKK9a/2UYN6qQPmugi5/omPSGP1AlbbAsXK2U8ZijSeqqg6rrM40YU+Kl?=
 =?us-ascii?Q?Fg+kNSAuKyThrtT5dy8okHTGHa/366TjdxmNnNeQiPYHorIhxcGhbwYny7As?=
 =?us-ascii?Q?L2y5I+tBlxG0xZCeWW2xLjp2kh7WrZyFmw+pugp49Y6QnS71XAmHlEx1kOpd?=
 =?us-ascii?Q?ebsL4ioHKgjfiFNfjeS3sMo+Rm2Hy14uIw20WbzsS/PM1YHHwWWnL52uSMMp?=
 =?us-ascii?Q?3YhaOax3BjBGP2/i9hx/fz9eObsRCrm7AoQIWj8/?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa4d843-87a8-4139-bd9f-08db3a08596a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 21:12:53.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcuV12xLmJbc3v3NKSOWc1jDpZG0oIBiYCo/5lXUeDx6xQDhdT5aI+j4gSkInDpeaQKyFeV+m1BdbA+lryBt/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8568
X-Proofpoint-ORIG-GUID: fvbeRi-33l8_OkJ9KaCktWpZan4MQvXc
X-Proofpoint-GUID: fvbeRi-33l8_OkJ9KaCktWpZan4MQvXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_15,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304100184
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/tty/serial/8250/8250_ni.c | 455 ++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig   |  13 +
 drivers/tty/serial/8250/Makefile  |   1 +
 4 files changed, 476 insertions(+)
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
index 000000000000..65203b27c74a
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -0,0 +1,455 @@
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
+#define NI16550_PMR_CAP_MASK			0x03
+#define NI16550_PMR_NOT_IMPL			0x00 /* not implemented */
+#define NI16550_PMR_CAP_RS232			0x01 /* RS-232 capable */
+#define NI16550_PMR_CAP_RS485			0x02 /* RS-485 capable */
+#define NI16550_PMR_CAP_DUAL			0x03 /* dual-port */
+/* PMR[4] - Interface Mode */
+#define NI16550_PMR_MODE_MASK			0x10
+#define NI16550_PMR_MODE_RS232			0x00 /* currently 232 */
+#define NI16550_PMR_MODE_RS485			0x10 /* currently 485 */
+
+/* PCR - Port Control Register */
+#define NI16550_PCR_OFFSET	0x0F
+#define NI16550_PCR_RS422			0x00
+#define NI16550_PCR_ECHO_RS485			0x01
+#define NI16550_PCR_DTR_RS485			0x02
+#define NI16550_PCR_AUTO_RS485			0x03
+#define NI16550_PCR_WIRE_MODE_MASK		0x03
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
+	struct uart_8250_port *up = container_of(port, struct uart_8250_port,
+						 port);
+	u8 pcr;
+
+	/* "rs485" should be given to us non-NULL. */
+	if (WARN_ON(rs485 == NULL))
+		return -EINVAL;
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
+		port->iotype  = UPIO_MEM;
+		port->mapbase = regs->start;
+		port->mapsize = resource_size(regs);
+		port->flags   |= UPF_IOREMAP;
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
+	 * OF device-tree and NIC7A69 ACPI can declare clock-frequency,
+	 * but may be missing for other instantiations, so this is optional.
+	 * If present, override what we've defined in this driver.
+	 */
+	if (info->uartclk)
+		uart.port.uartclk = info->uartclk;
+	device_property_read_u32(dev, "clock-frequency", &uart.port.uartclk);
+	if (!uart.port.uartclk) {
+		dev_err(dev, "unable to determine clock frequency!\n");
+		return -ENODEV;
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
+		return ret;
+
+	data->line = ret;
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int ni16550_remove(struct platform_device *pdev)
+{
+	struct ni16550_data *data = platform_get_drvdata(pdev);
+
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
+	.uartclk = 25000000,
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
index 5313aa31930f..c650566fc71d 100644
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
+          Instruments (NI) controller hardware. This is required for all NI
+          controller models with onboard RS-485 or dual-mode RS-485/RS-232
+          ports.
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

