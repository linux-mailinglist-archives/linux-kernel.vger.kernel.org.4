Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720496E6FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjDRWsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjDRWsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:48:12 -0400
Received: from mx0a-00010702.pphosted.com (mx0a-00010702.pphosted.com [148.163.156.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8B6213F;
        Tue, 18 Apr 2023 15:48:09 -0700 (PDT)
Received: from pps.filterd (m0239462.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IJrhk2002520;
        Tue, 18 Apr 2023 17:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=PPS11062020;
 bh=Tc7au/FDZvID8ET+5958bSs6gNufZbadg/SMW15jbmU=;
 b=ae+gZ883uKVsHSyIEBBeGRhxKsLYuqaw16FiE2Q5+2ApCVEuoCUdaGOu80RhKKraiYrf
 PNIWZUwUaYCoYngG4pHnbQ8GMlrsKrYJKTNzzThHwtrM5s4QcHX4e9brWIETbZHG3IrW
 lmJSBJI339P4BM2kxbgZTzw5VhMJl1otPwtSeV/4QM5XSZVA185O4ovxXAamVREsfm0M
 Wt2yFGxd0Pqn1QJfcmrsQwMEn/CxHIYDhcF91vz2uYIrPF38sIxwwLL5P64GbZCl7gpb
 fDvKUQwRypWmkHBP09lJH2mXjK7UHeplcNQiXqQHRyTPjwvyQ5gZ1iZ2Au5kyqWRdROs bQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3pyr0eq17m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 17:47:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPvDEpdl5xHOUrOGOZvmxx/PCneyK7DTBba/Kclj7yE7jxh6WikeHDfNyCndRSXnyaB2ggp+sJoF9Q82RVdbOXrM2zd/ONOxMpXpllwMICElxi10vXBTgcb8c+eyTiwykgGOZaIDMF9BvtsfrANLGy8jU9NgsAXRxUhvp79oalSHGps3gv/PPFr7V8L0akK7yJaEwNrGfIfA3c77PRsy39E5N56lFMNetAuzA0kCTn227IvJMzxU9H80JiYP34hGl52GGwxjvDNNNIl31EPyLUM7GjVEi+RrAtWk0bOEZi73Li9OIGZYR1wzRAONkjR1WAIkqh+h3kq6K2lfya+VCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc7au/FDZvID8ET+5958bSs6gNufZbadg/SMW15jbmU=;
 b=MAyBx3YXdo5pI1bqb7mlpeQfkGEnLfGLWkKLvSaQxPHdo5YUFT1hKYa9BCpy3cWLYzlSJG7MuoY0Le/ulSaucikXVFg131kHuCK2c+T3OkIdAsdfYUj6xqk25YfYyrI+lhKjZzR7sEMt3rKohxWW0uL8NlhQ4rhpJdbFRzv+MV4GyjctKhlcJo0aivAwrU2ECjUpNwciREsemO2GMhKbJsdew5/nDzqwR+vKQQabR2i/SZuoSQgAiP0rxr/SIO7wutnrSzIfvNugiFp86VqqN3UPgXMnt4Ah4iaT3o027e4kbwssCT33+8jlSR4fEyDQv9eseZiUc159WGCC9b++fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tc7au/FDZvID8ET+5958bSs6gNufZbadg/SMW15jbmU=;
 b=m0k/WYvkgXMMII4KjcWrtadbPeaRn6NpF1LFXhxZoGwvCa6EGdAQ678hEXV/9w0WBoQvJtvgznoKlIdTuIu0gqZ50EWnhW5uqv309w9WfkNoeIlQx027tayTCjMbfZWgpF/jz37X7jbALtqR9zXFw4t21Kw0ic6h8KEVrZAd/ao=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by DM6PR04MB6761.namprd04.prod.outlook.com (2603:10b6:5:243::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 22:47:56 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::f4d5:a7d3:adac:3654%5]) with mapi id 15.20.6319.020; Tue, 18 Apr 2023
 22:47:56 +0000
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
Subject: [PATCH v3 tty-next 2/2] serial: 8250: add driver for NI UARTs
Date:   Tue, 18 Apr 2023 17:38:00 -0500
Message-Id: <20230418223800.284601-3-brenda.streiff@ni.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418223800.284601-1-brenda.streiff@ni.com>
References: <20230410211152.94332-1-brenda.streiff@ni.com>
 <20230418223800.284601-1-brenda.streiff@ni.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:805:66::19) To SN6PR04MB4973.namprd04.prod.outlook.com
 (2603:10b6:805:91::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4973:EE_|DM6PR04MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff31cd7-8c39-44a6-bbe1-08db405ef396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Zz10KN95wW1foIhA6noxzoILMicFA73B04VIyCOLp41yFiX7AhogbzuiZJ/jZWz0ArEND1CAopPowIMN6F3PbX6lIy4ZbmQGTMSW90ha6Q8FusylDXnWPOelyeDZS6Dk1INSp1+ZJI3aY8YF+HbWfdVUrmwxS083jVZbOTMJOwOjBtSUbP4986/6QbsGyjzmaNM7ssXgSZN4Sqt9ApdUJ8Gwa315lxbYWsj24yhk8O+2jcJtfawMGebCaA/FfTqo80CqjO8FSnqdsLeteR3zfujDevi893+0vNM78Hj+0fGwOiY6pMJP7PkDHN8wnlEtTYW6I5L+/n3EcbrEtNDpHn80H5kFut5IhP4uZ3kEp+ChcUTTAiG/m4W9pohDJdvRJuGiwHPeC8RVmWLbeoOPcGI6D6CHzLBMjsotzMZ8vdL7PFmP4GwmuExF0mAgvVkvRWoekXEtXm3Tl71x417IcUh6zCd+v4W0uMqbyyTgSlmJO9jyblMl/BcoQc0wt8LFPW/kYYDkIBrwW3M3juZ0BYLLcVlShaKL5pv+zOWq2jGTp7s7ABV8ewYzBfC5c5+25FgSdbgSd3rm52IbVuEjTIboTEB+wCHjVuJ0TVyZQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4973.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(366004)(396003)(376002)(109986019)(451199021)(44832011)(36756003)(2906002)(5660300002)(8936002)(8676002)(30864003)(41300700001)(86362001)(38100700002)(478600001)(2616005)(26005)(1076003)(6506007)(6512007)(54906003)(186003)(6666004)(6486002)(4326008)(66476007)(66556008)(66946007)(83380400001)(316002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IpjUZLFzH5Sf67qKuv72HZzB3h5Stp4GUJwp0n0vVqmAwKhkriB3x4a9CLWb?=
 =?us-ascii?Q?9e+SwMbKG0iXhCJwYQ9M2ZZ1miDdvVL4VnAvV6Km2PZlMGMBur08ZurNkhJ+?=
 =?us-ascii?Q?SwALH8BuSAtd3PdUObTPo4uAFzCMZeJPMp91t5ARCRZssLPhSbYXqxkYoJtY?=
 =?us-ascii?Q?AlMSacZiddIerqdzcZVrYl8/5OROgDHnzHVIsKVwGlN5Rm/zx0wNkjPhQ08L?=
 =?us-ascii?Q?6xHXh7hMF792rSy5IolM5Den9YQH5M0ZGDCbeV0GUTf4dC4zLOumK71kettF?=
 =?us-ascii?Q?w7l3RaWIAcD3wlRflxGEtmdAmN8PJ65IbK94fKcMYBpfXiQXlvSRjIhNZ9A4?=
 =?us-ascii?Q?jSKlGz0u4MPWhS4TwPFmMza9TysUveeo2SgUJgftBPgtHW2SyDPzi8ZimV3F?=
 =?us-ascii?Q?o4pHx0P20GNfzjt44TA019+l9efUplLSCP41H7KHFfQFjZQTol4C6Nbmz5yL?=
 =?us-ascii?Q?xoKQUQA5vjZzX/VEdodk5ga9B5evyx39FukAf7befM1GRplfmijZ4tqkaRsC?=
 =?us-ascii?Q?6sCJV7REGAiPaNXQQu2GB9I0NiP3jVpPTeKsfSQKTpbbVJmBhWNzweA6MfnU?=
 =?us-ascii?Q?404KoYnEdO+jgCcA7AuPsxX5qLcFrb6GV0v8rt1ivJvw/DEBHMlHhKqN5Lp5?=
 =?us-ascii?Q?+Phqa18cbQhTQx9Y4tebQyVPZITfRgneQrmY37lcq6E55z2U8+KUYgNFKwyU?=
 =?us-ascii?Q?2QGeS3SyNulWg567TrAKQNlHwujgZMNZnaw4wgc6UBGrLURQE5ZXoLqyfQUl?=
 =?us-ascii?Q?gsiuXaxPeuRu/YJXAfm4fSP0NuLr26dRHXRDQewJNPWQWdO5mlEeUx67Fusm?=
 =?us-ascii?Q?DORNAw6oHjnoxJIQXbkYbNn3cn+rhhU2uqmYYPdGDfDR852Y2GAzkRtvXgH/?=
 =?us-ascii?Q?9KiwpPXh25bwgWWVFuSixKk801aFve0c2doF8zcoTiIHodQsSM2V3H3cIhC1?=
 =?us-ascii?Q?wpuOwfmSOhlrY5FryuGZy8XWbPK8AFkTG422Iqp+X9UsYjD86+p8O4RQZdbG?=
 =?us-ascii?Q?ZlFaJlo0OQ7Dt57RhUzcVtxA5/khZNPS1ck+0xsrK5t8MEdxR9ZtFxGmw6DH?=
 =?us-ascii?Q?YZgcJEMzFMqbtekvTqfrXxqsLAcpzt9NwwNTwoiG7/zrVwr4CbQ3+jT63+9x?=
 =?us-ascii?Q?ZmF3aBHv40ya1nMdv7uJUUTpcmMSIlALiXmMMeRv9XlJCsTQZp1aAMqhwfLF?=
 =?us-ascii?Q?HUaKTHw4eANPbLs3Qwt7f07+ciSJAfKCF98/1gJPzTH+KdAaZsVTijVrZ4QB?=
 =?us-ascii?Q?dDpYFoDmGhljOgvR6tCPBHz/laOvsyn8Q0lQfc/ty9RsgzEBQTJeG0JcjwF0?=
 =?us-ascii?Q?1EePFz3VcDqj9iVy5sUuIDG01bxwxLjWi6TdMkYZ9wrAjueydHZsBU5zIX+L?=
 =?us-ascii?Q?WO7nt3n1urwcdHbQXVyrRK05l5sxuYontuOeA2V7eJchvWpcp2TCBfpS5G1u?=
 =?us-ascii?Q?v/5gUb4kboo4Yj+Nad9Y04xTYqAGuEGP3aqApEO6sXKIpTpUq0At4KYYpzeP?=
 =?us-ascii?Q?ppFtlg2EPNw7V6ixI27ZT98GEDVZP8wP/ugHfizoMcZdHRuSe1khPsGOikob?=
 =?us-ascii?Q?Kku/b6eVqOxyaOq+CP2l9CdhfH1QkDKsUBeMV4LS?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff31cd7-8c39-44a6-bbe1-08db405ef396
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4973.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 22:47:56.5976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KC4QOSSmIar5QKrexZX9ySEgH9HIcApKVF6AauNhpPdPQYLE55S9ZoDi/GZ6ObhU7lpZv9iRYXoQ1lD2DqSVCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6761
X-Proofpoint-ORIG-GUID: k-RLDTOHp6248hwI6xx3OA8wd-1J1fnN
X-Proofpoint-GUID: k-RLDTOHp6248hwI6xx3OA8wd-1J1fnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_15,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304180191
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/tty/serial/8250/8250_ni.c | 468 ++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig   |  13 +
 drivers/tty/serial/8250/Makefile  |   1 +
 4 files changed, 489 insertions(+)
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
index 000000000000..92e8912c4875
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_ni.c
@@ -0,0 +1,468 @@
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
+	 * Declaration of the base clock frequency can come from one of:
+	 * - static declaration in this driver (for older ACPI IDs)
+	 * - a "clock-frquency" ACPI or OF device property
+	 * - an associated OF clock definition
+	 */
+	if (info->uartclk)
+		uart.port.uartclk = info->uartclk;
+	if (device_property_read_u32(dev, "clock-frequency",
+				     &uart.port.uartclk)) {
+		data->clk = devm_clk_get_optional_enabled(dev, "baudclk");
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

