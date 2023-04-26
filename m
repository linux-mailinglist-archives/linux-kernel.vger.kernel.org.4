Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647146EF57D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbjDZN1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbjDZN1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:27:05 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D4A211D;
        Wed, 26 Apr 2023 06:26:59 -0700 (PDT)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33Q9vWUC011543;
        Wed, 26 Apr 2023 13:26:47 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3q6uwpt2nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 13:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNDWANb1ZJ0bMmRG1qN4A2BWnSC929FRmIZM2HB/Tw1Mb+XyRbht2JwcMUfOZcfqdoUNLg8NBCPWgEvEs/4kMlKV2oSRrNa0RVhxNzdeEGa+0iY1MFR+TCSMbYXFEtei06YlpKlwLVGLyUJfDKzjFf76QHN9Ty2fvTIyj8s4ifmP7bgGkIdQMO6nB1RSTTSqWtQ04gFe9n0SlSP01l0jQh0vqf3fFujmx+9gDiWE9MqQrN3QGWN7MpPTxihTTTJPIULxl+U83EP0EqARbsE5Q/2C4oeZF2zJkxhk5Cvl5nmZKLgG6eeb2MTGGRb9owiJaS2eXQ3PIWpcA0OJaCpHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qW4b1SCsdschfJaSXBmABvUfHQ8tmNwE4/Hz+N7R/+U=;
 b=QVTV0Cmcfk4fVyYAYASKNoleNqQd/4pes9NiEvCyw+TiOJI+RlNIytwyCy15DN2EOYuWONNI9cS86JwRh0S0qpblrmhbwueVdEO5Fw2MCMvUIQ3pVtWyZMcI0Ntb34sOLfjCGvmvSUsEH+ftvGzBr8NFGF8nc7+da0556TZ9E5Vo5XoZCAsDfRs6PX9ocpkx5Jk9EaqUvxxhFWLSGUFQpsiuOW6pxGmoxEiUkWE1/xqMy6V8TAVs8Skvt9hw+fgdKMO/VslKpiB70OirCjyHbyirs5TdjFRHgOL1VSoGdsA354VLK7haFrzNHmNiJhAVYWGzlMfvkOOk65iBuc59+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qW4b1SCsdschfJaSXBmABvUfHQ8tmNwE4/Hz+N7R/+U=;
 b=HTW0OfABjGUGVGHxoaUo2+i0AjkWKKE2s+DUeG1cpWZWAqm+Dq+JeKR0AtkYFMOOoH7GUuM5c65TluTRNmvDcOHuDUBnLORq8SbsLFvQafwyqxI/VKfYeY6r/rITKkP8C+ReFt7Dsn0/Fs0OkhRaFeHGHamTxzYSXgzSTLV4WjblcBiM1RcFHU3X8hMPNnJlr9cUsZr83kROwB3dqrJ8sy6DFMUJ84K9kqod8x2x066MG+/B1dTAKj6/YYq8aZ9gFCumEOp0K7FYTEFqYXaweHYLnTQQc4j2brdV4q/kWZFEnyh+lA4aG60wqplbk50tL8OZPbdZwyaPir4Mac9bsQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by GV2PR03MB9380.eurprd03.prod.outlook.com (2603:10a6:150:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.54; Wed, 26 Apr
 2023 13:26:38 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%8]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 13:26:38 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Peng Fan <peng.fan@oss.nxp.com>,
        Michal Simek <michal.simek@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [RFC v2 2/3] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Thread-Topic: [RFC v2 2/3] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Thread-Index: AQHZeEK66Y+E4GsA3km+qVBMGvAGKw==
Date:   Wed, 26 Apr 2023 13:26:37 +0000
Message-ID: <812ae71d017b115c55648dbf0a4c3502715b1955.1682513390.git.oleksii_moisieiev@epam.com>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1682513390.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|GV2PR03MB9380:EE_
x-ms-office365-filtering-correlation-id: af4bd719-dea1-4f8e-4d3e-08db4659dd9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YJPv9cUxweyUNrIKLiixwJvGLlbTxF1wLSzZQ3MrpYlmfKZvGmBYnF/tCNtqJiEDqwAiEDO//JmTzm5/2+WQkBuLXY9KGVhW88Ucs+jND3bVA4qo+Z8XjngLRDRhwYlo385gewTfxOOlQN6nrRy/OPuH/kuXsmntpqqQOtwRwnY6ZSfq8ylfTFs7wNwiNP7gHzufDprBGe33BJ9ZGke8SpKZ1UhtpT07I5xqPeG5D0vqqADgi96f7wbrDLdzQDw4F82kQm+DmElVyS+cjSWj97YcYJMahdKedzIbh2acjh0mvUYFEaWsoG/UDXDopD/ntmhZ07SLMoHXTYq7EITCKuMXtx2RAgv9O0KPyeXZNySRN/Kgxpqvl1b24tVj0hxxq1FlMaAk2nkhUlpttnBrKOZsM0OQcBswpRGYC+FlCCcgiM459GEg+BtUnf1PCtmSJugIiJfLz/5Dkrnq558Vcdhg7BQBec5G00d+AH138BR4l4EzyFtff8kQKlfBDjFVzv8VJI0NPGzsbqdA1fN9EsMHxCcU39yReRYj5YI/Zdfp1Uw/HLW1PRcPGe9T14SNSsXiK8muSZNvVa4KK4SfPAb34QDu/OCXP/aFfVsqPogpE6Mv37626gmPLqcOm/ICJf1sFBwUiD6mWvl+4m/f8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(8936002)(2616005)(122000001)(8676002)(478600001)(36756003)(91956017)(316002)(76116006)(66946007)(71200400001)(66476007)(66446008)(41300700001)(6916009)(4326008)(66556008)(64756008)(6486002)(83380400001)(86362001)(54906003)(6506007)(26005)(6512007)(186003)(30864003)(2906002)(38070700005)(5660300002)(38100700002)(41533002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wLZ9DGLT1UDsj0ENet78dBo6HKZCYcezDjWDc414Si04cns5tBqcVgMCLP?=
 =?iso-8859-1?Q?dYKzlr/aDXQUzG/49i786wenFDtBixNHUmD2JCaSdDjH/ijJi1qWVb9Rk+?=
 =?iso-8859-1?Q?SdXnhuxGNrxlwDextQRHdSAWDuDDAS1y/wRgWQ2e6TKpx/lmuFOUFNArhh?=
 =?iso-8859-1?Q?OaOagW/CshhPD6QHuIwBlBizeawj3ULBp+aCgozksAAz62/rPBK9H1goxo?=
 =?iso-8859-1?Q?lKqEXmPNfP+gHIRYMkuWVuNHUVIicrXMxMbcDLLB9J00qxez5zuS4Wle+r?=
 =?iso-8859-1?Q?GqmQ/9SItMz6CX+IDCWFDDnPQqI4E62YRWaM7N2EJsl/2gZQtpPdlYauWp?=
 =?iso-8859-1?Q?qThoS1lWKI5hJnwAf5e71ulvz8pOkEUc92Yjcd479NZHKXz69Mu3KPzz2/?=
 =?iso-8859-1?Q?ZjZUub6kXE6Q9L3dHUzeu/0/z7wwWQU7gBI/QMYST7lTNY0vNz6BlHfnmg?=
 =?iso-8859-1?Q?UGTgZGzxcLiox4sWylZV3HnwJUgtd0lBq8mBfdKYYciezkq9EbiHGqspVi?=
 =?iso-8859-1?Q?Kf0a/icdAsCSYiciiKow4UAeak5UOtu0gVhEEIsEbWTPj7b7sWXrwZtIXU?=
 =?iso-8859-1?Q?WZRzLUIRDCczKk3yMMe7LqNeB09AaL2ovYKKPVK6J9ddVd2ttZ1XegfO27?=
 =?iso-8859-1?Q?NDvbg0Z3Klo1lLZoqQDcBKFuyr8n1OCthyYj7+7vhEo1SH9UH1G/IyD/M8?=
 =?iso-8859-1?Q?xLnmAUScd7Unwo8DQhI/H1JGYDbTIITK1lZlZjxEVEZA0a/oGD72+qctjc?=
 =?iso-8859-1?Q?gGMvaRz0CKeqeSLFeqKqteUi81u1kXOSUg36d4jhmtPSbVUtZ8g90gd9KL?=
 =?iso-8859-1?Q?gbPiIVVGhgwuxZU1KuzIpoqZgro3pDXXyNqUSbCjltt3uQCuJOdaZK/rkt?=
 =?iso-8859-1?Q?Ehi1AHFTXCidEJpP6BJTjQqYU/X/8ipKOsr1pfhLwaZRks4WaWQ4utYbRP?=
 =?iso-8859-1?Q?snh/eC8MBHewbXB41xnXJLRc6aMpx6V478pcVrsGT2Rjoz4EYd/aAWrlX6?=
 =?iso-8859-1?Q?rU5Hdz85Wwnp+ZVt7Sz0UnthOzsIO2wqqYL17uVJdG5ds5zOVLWJzNz4vV?=
 =?iso-8859-1?Q?AoNgzf8D/gE4WtPuQvx3X+9H9phndK3AhYO5n6q5hMuH76pHCs0JSAON62?=
 =?iso-8859-1?Q?D8efs5481UnRxSw8aDUFsuKM63NqU2QZFFvhChaoK8MpX/bKBMmmu5Sx5v?=
 =?iso-8859-1?Q?+//Qs4QecTdeF1BsofjJZpk4OhQDOwC3T2qgwITAG5861r8ZmqSbJwvPt0?=
 =?iso-8859-1?Q?DVmL9WYuNIdHcWGEp+f9aRENAm8d0zggrcwru3uLHp3sThBhV553CGdDl7?=
 =?iso-8859-1?Q?nOYigQ+8JrEMFBtnlSUlXo6FlT64+uGGSfjJOCJTmYj8kFbpR+3+MzAr3M?=
 =?iso-8859-1?Q?FpmSL4Kuu8XZtEzarvXaqQT1aN32tV8VZFCgTUPZh3wMFnjBgmSZ0CdbEb?=
 =?iso-8859-1?Q?ywD/m8/v7W/0p6h+H6KMdadFrp3CTHaPESWYupVVZHq2YDf/evG3h7//yb?=
 =?iso-8859-1?Q?7W+MQYSJTX0B882zIsGz3MKuo89ExagqOF86WtBb063MVhoRcLxjMfJguU?=
 =?iso-8859-1?Q?eqz4zlEflFCbAdl967gkXkrKnMpRzGeFGBi0qXr+nBDLcp8rYmUOCcuwno?=
 =?iso-8859-1?Q?O8S9pn0mkgY2umEBgru05iJ6AiUU63fUNfZ6gC+Pg/ByTw6zXqIVkTvQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4bd719-dea1-4f8e-4d3e-08db4659dd9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 13:26:37.9215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbuvGKWrOrjzbGei53MCY5/7Q3i4b9cfQsaQn31fmxUKdI0hdr9SZZ6gVuq3kab5nn0QaDnK5l7mDOsPikVUegqyf1x6l5ITDeHOlEV+HKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9380
X-Proofpoint-ORIG-GUID: kli-DuRYMp6Crc3Wubeyly5bJKxDf2th
X-Proofpoint-GUID: kli-DuRYMp6Crc3Wubeyly5bJKxDf2th
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_06,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scmi-pinctrl driver implements pinctrl driver interface and using
SCMI protocol to redirect messages from pinctrl subsystem SDK to
SCP firmware, which does the changes in HW.

This setup expects SCP firmware (or similar system, such as ATF)
to be installed on the platform, which implements pinctrl driver
for the specific platform.

SCMI-Pinctrl driver should be configured from the device-tree and uses
generic device-tree mappings for the configuration.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 MAINTAINERS                    |   1 +
 drivers/pinctrl/Kconfig        |   9 +
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 578 +++++++++++++++++++++++++++++++++
 4 files changed, 589 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d251ebac437..ba9e3aea6176 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20322,6 +20322,7 @@ M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	drivers/firmware/arm_scmi/pinctrl.c
+F:	drivers/pinctrl/pinctrl-scmi.c
=20
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index dcb53c4a9584..16bf2c67f095 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -552,4 +552,13 @@ source "drivers/pinctrl/uniphier/Kconfig"
 source "drivers/pinctrl/visconti/Kconfig"
 source "drivers/pinctrl/vt8500/Kconfig"
=20
+config PINCTRL_SCMI
+	bool "Pinctrl driver controlled via SCMI interface"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	help
+	  This driver provides support for pinctrl which is controlled
+	  by firmware that implements the SCMI interface.
+	  It uses SCMI Message Protocol to interact with the
+	  firmware providing all the pinctrl controls.
+
 endif
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index d5939840bb2a..21366db4f4f4 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_PINCTRL_TB10X)	+=3D pinctrl-tb10x.o
 obj-$(CONFIG_PINCTRL_THUNDERBAY) +=3D pinctrl-thunderbay.o
 obj-$(CONFIG_PINCTRL_ZYNQMP)	+=3D pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+=3D pinctrl-zynq.o
+obj-$(CONFIG_PINCTRL_SCMI)	+=3D pinctrl-scmi.o
=20
 obj-y				+=3D actions/
 obj-$(CONFIG_ARCH_ASPEED)	+=3D aspeed/
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.=
c
new file mode 100644
index 000000000000..8401db1d030b
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Power Interface (SCMI) Protocol based pinctrl driver
+ *
+ * Copyright (C) 2023 EPAM
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include "pinctrl-utils.h"
+#include "core.h"
+#include "pinconf.h"
+
+#define DRV_NAME "scmi-pinctrl"
+
+static const struct scmi_pinctrl_proto_ops *pinctrl_ops;
+
+struct scmi_pinctrl_funcs {
+	unsigned int num_groups;
+	const char **groups;
+};
+
+struct scmi_pinctrl {
+	struct device *dev;
+	struct scmi_protocol_handle *ph;
+	struct pinctrl_dev *pctldev;
+	struct pinctrl_desc pctl_desc;
+	struct scmi_pinctrl_funcs *functions;
+	unsigned int nr_functions;
+	char **groups;
+	unsigned int nr_groups;
+	struct pinctrl_pin_desc *pins;
+	unsigned int nr_pins;
+};
+
+static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph)
+		return -EINVAL;
+
+	return pinctrl_ops->get_count(pmx->ph, GROUP_TYPE);
+}
+
+static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev=
,
+					       unsigned int selector)
+{
+	int ret;
+	const char *name;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return NULL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph)
+		return NULL;
+
+	ret =3D pinctrl_ops->get_name(pmx->ph, selector, GROUP_TYPE, &name);
+	if (ret) {
+		dev_err(pmx->dev, "get name failed with err %d", ret);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int pinctrl_scmi_get_group_pins(struct pinctrl_dev *pctldev,
+				       unsigned int selector,
+				       const unsigned int **pins,
+				       unsigned int *num_pins)
+{
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph)
+		return -EINVAL;
+
+	return pinctrl_ops->get_group_pins(pmx->ph, selector,
+					   pins, num_pins);
+}
+
+static void pinctrl_scmi_pin_dbg_show(struct pinctrl_dev *pctldev,
+				      struct seq_file *s,
+				      unsigned int offset)
+{
+	seq_puts(s, DRV_NAME);
+}
+
+#ifdef CONFIG_OF
+static int pinctrl_scmi_dt_node_to_map(struct pinctrl_dev *pctldev,
+				       struct device_node *np_config,
+				       struct pinctrl_map **map,
+				       u32 *num_maps)
+{
+	return pinconf_generic_dt_node_to_map(pctldev, np_config, map,
+					      num_maps, PIN_MAP_TYPE_INVALID);
+}
+
+static void pinctrl_scmi_dt_free_map(struct pinctrl_dev *pctldev,
+				     struct pinctrl_map *map, u32 num_maps)
+{
+	kfree(map);
+}
+
+#endif /* CONFIG_OF */
+
+static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops =3D {
+	.get_groups_count =3D pinctrl_scmi_get_groups_count,
+	.get_group_name =3D pinctrl_scmi_get_group_name,
+	.get_group_pins =3D pinctrl_scmi_get_group_pins,
+	.pin_dbg_show =3D pinctrl_scmi_pin_dbg_show,
+#ifdef CONFIG_OF
+	.dt_node_to_map =3D pinctrl_scmi_dt_node_to_map,
+	.dt_free_map =3D pinctrl_scmi_dt_free_map,
+#endif
+};
+
+static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph)
+		return -EINVAL;
+
+	return pinctrl_ops->get_count(pmx->ph, FUNCTION_TYPE);
+}
+
+static const char *pinctrl_scmi_get_function_name(struct pinctrl_dev *pctl=
dev,
+						  unsigned int selector)
+{
+	int ret;
+	const char *name;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return NULL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph)
+		return NULL;
+
+	ret =3D pinctrl_ops->get_name(pmx->ph, selector, FUNCTION_TYPE, &name);
+	if (ret) {
+		dev_err(pmx->dev, "get name failed with err %d", ret);
+		return NULL;
+	}
+
+	return name;
+}
+
+static int pinctrl_scmi_get_function_groups(struct pinctrl_dev *pctldev,
+					    unsigned int selector,
+					    const char * const **groups,
+					    unsigned int * const num_groups)
+{
+	const unsigned int *group_ids;
+	int ret, i;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph || !groups || !num_groups)
+		return -EINVAL;
+
+	if (selector < pmx->nr_functions &&
+	    pmx->functions[selector].num_groups) {
+		*groups =3D (const char * const *)pmx->functions[selector].groups;
+		*num_groups =3D pmx->functions[selector].num_groups;
+		return 0;
+	}
+
+	ret =3D pinctrl_ops->get_function_groups(pmx->ph, selector,
+					       &pmx->functions[selector].num_groups,
+					       &group_ids);
+	if (ret) {
+		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
+		return ret;
+	}
+
+	*num_groups =3D pmx->functions[selector].num_groups;
+	if (!*num_groups)
+		return -EINVAL;
+
+	pmx->functions[selector].groups =3D
+		devm_kcalloc(pmx->dev, *num_groups,
+			     sizeof(*pmx->functions[selector].groups),
+			     GFP_KERNEL);
+	if (!pmx->functions[selector].groups)
+		return -ENOMEM;
+
+	for (i =3D 0; i < *num_groups; i++) {
+		pmx->functions[selector].groups[i] =3D
+			pinctrl_scmi_get_group_name(pmx->pctldev,
+						    group_ids[i]);
+		if (!pmx->functions[selector].groups[i]) {
+			ret =3D -ENOMEM;
+			goto error;
+		}
+	}
+
+	*groups =3D (const char * const *)pmx->functions[selector].groups;
+
+	return 0;
+
+error:
+	kfree(pmx->functions[selector].groups);
+
+	return ret;
+}
+
+static int pinctrl_scmi_func_set_mux(struct pinctrl_dev *pctldev,
+				     unsigned int selector, unsigned int group)
+{
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph)
+		return -EINVAL;
+
+	return pinctrl_ops->set_mux(pmx->ph, selector, group);
+}
+
+static int pinctrl_scmi_request(struct pinctrl_dev *pctldev,
+				unsigned int offset)
+{
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph)
+		return -EINVAL;
+
+	return pinctrl_ops->request_pin(pmx->ph, offset);
+}
+
+static int pinctrl_scmi_free(struct pinctrl_dev *pctldev, unsigned int off=
set)
+{
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph)
+		return -EINVAL;
+
+	return pinctrl_ops->free_pin(pmx->ph, offset);
+}
+
+static const struct pinmux_ops pinctrl_scmi_pinmux_ops =3D {
+	.request =3D pinctrl_scmi_request,
+	.free =3D pinctrl_scmi_free,
+	.get_functions_count =3D pinctrl_scmi_get_functions_count,
+	.get_function_name =3D pinctrl_scmi_get_function_name,
+	.get_function_groups =3D pinctrl_scmi_get_function_groups,
+	.set_mux =3D pinctrl_scmi_func_set_mux,
+};
+
+static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev,
+				    unsigned int _pin,
+				    unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx;
+	enum pin_config_param config_type;
+	unsigned long config_value;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph || !config)
+		return -EINVAL;
+
+	config_type =3D pinconf_to_config_param(*config);
+
+	ret =3D pinctrl_ops->get_config(pmx->ph, _pin, PIN_TYPE, config_type,
+				      (u32 *)&config_value);
+	if (ret)
+		return ret;
+
+	*config =3D pinconf_to_config_packed(config_type, config_value);
+
+	return 0;
+}
+
+static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
+				    unsigned int _pin,
+				    unsigned long *configs,
+				    unsigned int num_configs)
+{
+	int i, ret;
+	struct scmi_pinctrl *pmx;
+	enum pin_config_param config_type;
+	unsigned long config_value;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph || !configs || num_configs =3D=3D 0)
+		return -EINVAL;
+
+	for (i =3D 0; i < num_configs; i++) {
+		config_type =3D pinconf_to_config_param(configs[i]);
+		config_value =3D pinconf_to_config_argument(configs[i]);
+
+		ret =3D pinctrl_ops->set_config(pmx->ph, _pin, PIN_TYPE, config_type,
+					      config_value);
+		if (ret) {
+			dev_err(pmx->dev, "Error parsing config %ld\n",
+				configs[i]);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int pinctrl_scmi_pinconf_group_set(struct pinctrl_dev *pctldev,
+					  unsigned int group,
+					  unsigned long *configs,
+					  unsigned int num_configs)
+{
+	int i, ret;
+	struct scmi_pinctrl *pmx;
+	enum pin_config_param config_type;
+	unsigned long config_value;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph || !configs || num_configs =3D=3D 0)
+		return -EINVAL;
+
+	for (i =3D 0; i < num_configs; i++) {
+		config_type =3D pinconf_to_config_param(configs[i]);
+		config_value =3D pinconf_to_config_argument(configs[i]);
+
+		ret =3D pinctrl_ops->set_config(pmx->ph, group, GROUP_TYPE,
+					      config_type, config_value);
+		if (ret) {
+			dev_err(pmx->dev, "Error parsing config =3D %ld",
+				configs[i]);
+			break;
+		}
+	}
+
+	return ret;
+};
+
+static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
+					  unsigned int _pin,
+					  unsigned long *config)
+{
+	int ret;
+	struct scmi_pinctrl *pmx;
+	enum pin_config_param config_type;
+	unsigned long config_value;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->ph || !config)
+		return -EINVAL;
+
+	config_type =3D pinconf_to_config_param(*config);
+
+	ret =3D pinctrl_ops->get_config(pmx->ph, _pin, GROUP_TYPE,
+				      config_type, (u32 *)&config_value);
+	if (ret)
+		return ret;
+
+	*config =3D pinconf_to_config_packed(config_type, config_value);
+
+	return 0;
+}
+
+static const struct pinconf_ops pinctrl_scmi_pinconf_ops =3D {
+	.is_generic =3D true,
+	.pin_config_get =3D pinctrl_scmi_pinconf_get,
+	.pin_config_set =3D pinctrl_scmi_pinconf_set,
+	.pin_config_group_set =3D pinctrl_scmi_pinconf_group_set,
+	.pin_config_group_get =3D pinctrl_scmi_pinconf_group_get,
+	.pin_config_config_dbg_show =3D pinconf_generic_dump_config,
+};
+
+static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
+				 unsigned int *nr_pins,
+				 const struct pinctrl_pin_desc **pins)
+{
+	int ret, i;
+
+	if (!pmx || !pmx->ph)
+		return -EINVAL;
+
+	if (!pins || !nr_pins)
+		return -EINVAL;
+
+	if (pmx->nr_pins) {
+		*pins =3D pmx->pins;
+		*nr_pins =3D pmx->nr_pins;
+		return 0;
+	}
+
+	*nr_pins =3D pinctrl_ops->get_count(pmx->ph, PIN_TYPE);
+
+	pmx->nr_pins =3D *nr_pins;
+	pmx->pins =3D devm_kmalloc_array(pmx->dev, *nr_pins, sizeof(*pmx->pins),
+				       GFP_KERNEL);
+	if (!pmx->pins)
+		return -ENOMEM;
+
+	for (i =3D 0; i < *nr_pins; i++) {
+		pmx->pins[i].number =3D i;
+		ret =3D pinctrl_ops->get_name(pmx->ph, i, PIN_TYPE,
+					    &pmx->pins[i].name);
+		if (ret) {
+			dev_err(pmx->dev, "Can't get name for pin %d: rc %d",
+				i, ret);
+			goto err;
+		}
+	}
+
+	*pins =3D pmx->pins;
+	dev_dbg(pmx->dev, "got pins %d", *nr_pins);
+
+	return 0;
+ err:
+	kfree(pmx->pins);
+	pmx->nr_pins =3D 0;
+
+	return ret;
+}
+
+static const struct scmi_device_id scmi_id_table[] =3D {
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static int scmi_pinctrl_probe(struct scmi_device *sdev)
+{
+	int ret;
+	struct scmi_pinctrl *pmx;
+	const struct scmi_handle *handle;
+	struct scmi_protocol_handle *ph;
+
+	if (!sdev || !sdev->handle)
+		return -EINVAL;
+
+	handle =3D sdev->handle;
+
+	pinctrl_ops =3D handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL,
+						&ph);
+	if (IS_ERR(pinctrl_ops))
+		return PTR_ERR(pinctrl_ops);
+
+	pmx =3D devm_kzalloc(&sdev->dev, sizeof(*pmx), GFP_KERNEL);
+	if (!pmx)
+		return -ENOMEM;
+
+	pmx->ph =3D ph;
+
+	pmx->dev =3D &sdev->dev;
+	pmx->pctl_desc.name =3D DRV_NAME;
+	pmx->pctl_desc.owner =3D THIS_MODULE;
+	pmx->pctl_desc.pctlops =3D &pinctrl_scmi_pinctrl_ops;
+	pmx->pctl_desc.pmxops =3D &pinctrl_scmi_pinmux_ops;
+	pmx->pctl_desc.confops =3D &pinctrl_scmi_pinconf_ops;
+
+	ret =3D pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
+				    &pmx->pctl_desc.pins);
+	if (ret)
+		goto clean;
+
+	ret =3D devm_pinctrl_register_and_init(&sdev->dev, &pmx->pctl_desc, pmx,
+					     &pmx->pctldev);
+	if (ret) {
+		dev_err(&sdev->dev, "could not register: %i\n", ret);
+		goto clean;
+	}
+
+	pmx->nr_functions =3D pinctrl_scmi_get_functions_count(pmx->pctldev);
+	pmx->nr_groups =3D pinctrl_scmi_get_groups_count(pmx->pctldev);
+
+	if (pmx->nr_functions) {
+		pmx->functions =3D
+			devm_kcalloc(&sdev->dev, pmx->nr_functions,
+				     sizeof(*pmx->functions),
+				     GFP_KERNEL);
+		if (!pmx->functions) {
+			ret =3D -ENOMEM;
+			goto clean;
+		}
+	}
+
+	if (pmx->nr_groups) {
+		pmx->groups =3D
+			devm_kcalloc(&sdev->dev, pmx->nr_groups,
+				     sizeof(*pmx->groups),
+				     GFP_KERNEL);
+		if (!pmx->groups) {
+			ret =3D -ENOMEM;
+			goto clean;
+		}
+	}
+
+	return pinctrl_enable(pmx->pctldev);
+
+clean:
+	if (pmx) {
+		kfree(pmx->functions);
+		kfree(pmx->groups);
+	}
+
+	kfree(pmx);
+
+	return ret;
+}
+
+static struct scmi_driver scmi_pinctrl_driver =3D {
+	.name =3D DRV_NAME,
+	.probe =3D scmi_pinctrl_probe,
+	.id_table =3D scmi_id_table,
+};
+module_scmi_driver(scmi_pinctrl_driver);
+
+MODULE_AUTHOR("Oleksii Moisieiev <oleksii_moisieiev@epam.com>");
+MODULE_DESCRIPTION("ARM SCMI pin controller driver");
+MODULE_LICENSE("GPL");
--=20
2.25.1
