Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D716DAB5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbjDGKSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240427AbjDGKSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:18:44 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBB486A6;
        Fri,  7 Apr 2023 03:18:41 -0700 (PDT)
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3377AcPO012311;
        Fri, 7 Apr 2023 10:18:31 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03lp2173.outbound.protection.outlook.com [104.47.51.173])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3pt36rt822-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 10:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NExFDFrZZfv/RNR7g1cZsBvIMNoDkgwqnvvts1U+Fds7gfdk5bck6u41Oqp2PpQvfQ5jSBcOoDrAEtVmxFnL4IJ4X9Ql0u4N1wka7YbMU044iyz5BlTKAPsAWPG1qlw8qksorKsefjt9hTVIuKp6ZCfO5PMUTlvno6pJY2yAd3hN8pvlZALaxUgosDZY8YhOI302TuLz1XlPL5YDT6ASLMwDaHyTCmtUiguL3WW89qo8EkKFuqQUljbJwnkJHhNhua4HiLKxA8EqkaFujFPWg3F/H69l6J7TaphED6U8vXkhVvwBMmue6NGzVXNmFu7wFT3PMPpvWusvt6NzLowocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBNBzaR1XfDVGvLRPVP10xhV/ix0pCzxaXwqE3L1fhM=;
 b=GHC0w/FW9u/nEcFPXbsz9XUOPz0u7SRbh0wOJDl7eE34gbdFwfZDzF30k9dqzD6D174NLSZUEZ+uEJLyquY/70yvblEMyEDuu10Dcrha6Gi6paqgLeGTu/5rt1+wTyalifvHLzz5Sv8S8SJWdwVGO+AOFgPs9pT6PI/vKEf1bkRuatrW84GzukBMjIgGo+1SaND8FPnymNAUX/T+OSTF4lQDYSL5WlzcABKGgV9CJ3MkiImpUJJdihcQEpWylC+NvcIZExwZ0l7fK4mvPF1eRyLA8n2+F4YmPugisxU3T0uptTgF41Zbvp79JU/4vDdqxcJOb94QzREGnXEGismrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBNBzaR1XfDVGvLRPVP10xhV/ix0pCzxaXwqE3L1fhM=;
 b=EjbFiV1YaIPY9Zbe4Y+RtpKlw1qC+BUb6g0yokFHB54L2i51Wv3Q1B8ekEFaHzx8CEjBhwsIa6HET3FfjG8XkSJeGNvy+Veom5hU3QUUCOxjkUxdrXN5Xft2Rhph8gED5gLDrHdCFb/xccTbHCt4AASwFZiyRuWXv2R9858D1b6ddHvbMXvy9k6ypGKD4pUxAAZY4B/W5xwa23wl+krZ8iaimrQla0bsHYkFxYhG6jK0mBACiwCwQ4tiEEj2jdW2tK/LW0/LHs5MhYg86FRXqq1qUF9r1Ux8V3ydTql9pGKPnlqXVtrvfWI0T1LZ/nsbWHam4VtQiC0bOWrSCEZGFA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DU0PR03MB8743.eurprd03.prod.outlook.com (2603:10a6:10:3ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Fri, 7 Apr
 2023 10:18:28 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%9]) with mapi id 15.20.6277.033; Fri, 7 Apr 2023
 10:18:27 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [RFC v1 2/2] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Thread-Topic: [RFC v1 2/2] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Thread-Index: AQHZaTpLEGNMTFeGtkiPcS7WtixCbw==
Date:   Fri, 7 Apr 2023 10:18:27 +0000
Message-ID: <6ac2f85213c3e79de7daabe9ca3a5f471cf8d370.1680793130.git.oleksii_moisieiev@epam.com>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1680793130.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DU0PR03MB8743:EE_
x-ms-office365-filtering-correlation-id: c3a291d2-2545-4efa-4853-08db37516df2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CF0DJD3w6lVOBiv7J5bTH1t/8mb1HfbGYJbykuzAUMr8Fk1q7Dx14CkhVszClhtwT7vNPeLk/RXV57BC5dW+nLz5T2nsOYcCgKNsG2p2uM6pbQOWXaT+czgo/sENKP7XN6/JqxkiKRIXcBNNhoS2GxuQ4amdWYV847TRy+ZNm/0WZwpzFOdmZejeVjZPH3ud/yjJtLjN4aQ43V/FfcYtC2FoDWibDip5kuTAapmr9WOxa8Etrtf6PW8/44GWef66Y5PbLHU6zgFpcItihN3RTPhjCLOqFgA1c6dPjGNtB2CadEbS9H29f2IOl19bj47EBK8NfggEqgu+5VYr2PpGeUwqJ8a0u99owmbuKH035o7AMqsrdYNRo1KlR0q6t24OTDDk6qL+K3w4cJ9jDDmbqW5KW+am++NQwmNEiK9S7cS37du9RTDlzCtSrP1qf8g6KvrbyNJLRR1+FstPAhPUFjWcVPdbk763DIX+TsuC9zZV2v18ztCx8COfUrj+blK75cfFPbDaF7m6lR3ldiGuq+1hHY6KcWHBYie582sqdom1S5O1gdBr6xBAOEAnK4wXl87Zy3sA2z3YjR1lMlzmXaBYyqn/se36/YuIEuEYs0GrDLq/JJQfFkin/Dj2eJTwmvszzfVmNrTc7y1ftvCBig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(316002)(6512007)(6506007)(186003)(83380400001)(26005)(30864003)(54906003)(122000001)(5660300002)(2906002)(2616005)(6486002)(38100700002)(8936002)(38070700005)(71200400001)(86362001)(41300700001)(36756003)(4326008)(6916009)(8676002)(64756008)(66446008)(66556008)(66946007)(76116006)(66476007)(91956017)(478600001)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p/oQb8vh4zOqcpZFN32cA4x9G21ulG3xh74ToT6sm5kzUGurTEpbnE6pIh?=
 =?iso-8859-1?Q?ikpHhfnCCwMz02HL8OAlVXvlfswPUwdG2saWgiZFuQ04lf3FubpXrCQefG?=
 =?iso-8859-1?Q?vVTUCR4pAMovJgptJPD7QHv694spAs8SCiPyCGT/FrLYzMcdzCasQmc1FB?=
 =?iso-8859-1?Q?LgbfK/duF8iXAvpT6rGl9GJWdDaLRSvHFbtVvzqvbWu/2n5kr3j/X5H+hU?=
 =?iso-8859-1?Q?WXic4uHyt/l31CzLIxTcjhxc/wTyil11A+8/46n7SGzypixyy/NKHbVFAq?=
 =?iso-8859-1?Q?YmERGpLbbkVKQWV2L+0EVmdiHdvhZvURwxePpL3uRmpyhq6VDjU2uqEzw1?=
 =?iso-8859-1?Q?1I7OMjDbP5/BNgUb1L76LNwxXbe3rBOS8YyAM1kge6X2zSWGalf0rFMltM?=
 =?iso-8859-1?Q?rE5k+feLnOXbD/0RTxWYAV2tT0l5xwCPGTPQ7CQ9tYQRZGBiePi74Ab0qN?=
 =?iso-8859-1?Q?MhDBxq9MLVmQURRdUXiibfmFEtCkm2O/ypkzL+S2XwGlntL8USZa35dHFt?=
 =?iso-8859-1?Q?6+O84AdUav8G9itYOMGzz6bD5awRm9aYdQGS7WvEccrhLjrhFbQqgNhgdc?=
 =?iso-8859-1?Q?wMJ52Q2ARJnAmLaBI8WdFQQdlNoSFyw1Yu8CuIimK2xBEhrIO1gW6qzmSm?=
 =?iso-8859-1?Q?rjIjK8Cball+3x5JrbTj5bopM7nEj2d3G1ubdf7rdZZ3ioerfVsSr/3MXS?=
 =?iso-8859-1?Q?zdDnu5lPkzui2rgr9PIqEZGWSyg8Zh3RdmqogVXhH52YyRZ+/GVkenDJ6a?=
 =?iso-8859-1?Q?mvOGIJ4Wua/oDz5tWuk6sHeRmi+iyCkBiDXQNSH0g7a4WPwM4ePdSuvGoW?=
 =?iso-8859-1?Q?S4NiqfSGW2blR3XHlfCa4d+0SWYFH//pIsm132GAY1iJfRVYxjHFB0OnDp?=
 =?iso-8859-1?Q?o9Y9IjGdj39lP+b2LlYlszekTwwcoiXSmyY6J+jol5rA6UNNj3J77RXTOC?=
 =?iso-8859-1?Q?1Q3B9Aywt8WjY21SZQIhnCgA0x8esPmmYDtoFWrUh15I/GahcDhW+rqZt/?=
 =?iso-8859-1?Q?nAWZCPqvdYkZJO8ftUuiySURYnJGXRTpLBMpI0AElNoOJ69E1El+6bvU3E?=
 =?iso-8859-1?Q?M/+NZouBk2vRF7gxIwD3/H9DumuDBi8/1UWj8z6gYSAQu7llUEt68QGsNA?=
 =?iso-8859-1?Q?EP37Pwmd74IEEGZwPss66snG0HTLdIF9oZnIikzodrT+yy7q1F6MNGnlJq?=
 =?iso-8859-1?Q?7t9DOZqTUYWeyZeHrTruKe/GPnFZLheJxI+Qb2IBJl52Z116lIh/8RdOUJ?=
 =?iso-8859-1?Q?hdTWswCJZTAcJ3w4CGJmSwq0uV+rkyAd+rKjCt5kHahq6Wig2kD6C4oRRY?=
 =?iso-8859-1?Q?hy5Oyko/JGh/asws9uk3f/5y6Jg84ihq9tr1I0BVVQ96rU17QDdvXZ7efA?=
 =?iso-8859-1?Q?fEFnFnrVq7MinBskBYBj0cQiKBjK/2PIPKHmg7zOdzmvA3SHI4bL4V1vPZ?=
 =?iso-8859-1?Q?Jf0ojo/TmsuerJwJWjGd+CaYjnYMk1uZ5r2RSlon+bHxnM1MVKokvYsnFO?=
 =?iso-8859-1?Q?Mic8lDIkn1ZZPU3tEQ5rG0XCZT/qi5/CbaCUBTpoe74moTDAh8Zs2+l7wc?=
 =?iso-8859-1?Q?Dcg24DPzyIR9qp/7vAOFFnusfmFPlSl17qVRSGc2S8EGFyufkrOf9FxkKi?=
 =?iso-8859-1?Q?2Yy7xoMXSO/rZr2DK7RO9spfz1smqdz04puLj1w2Bum5SIUVvkLLg+Ig?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a291d2-2545-4efa-4853-08db37516df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 10:18:27.8310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBqhJxwW/ulM5IwYxcQddap5laQ3TPYTFM6/DdrLeSyQJo8w2X2ZXFHn6nZrwSFAHLeCFxGV8JY8q01aGEJsegYtbkT9BRWle2wgXPOLD8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8743
X-Proofpoint-GUID: RawWp8wFUAxQ3Bdvk6Ab86MseESYR3Jl
X-Proofpoint-ORIG-GUID: RawWp8wFUAxQ3Bdvk6Ab86MseESYR3Jl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070095
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 555 +++++++++++++++++++++++++++++++++
 3 files changed, 557 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index abc543fd7544..f7559b3b5967 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16966,6 +16966,7 @@ M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	drivers/firmware/arm_scmi/pinctrl.c
+F:	drivers/pinctrl/pinctrl-scmi.c
=20
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index f53933b2ff02..163fe8a06878 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_PINCTRL_INGENIC)	+=3D pinctrl-ingenic.o
 obj-$(CONFIG_PINCTRL_RK805)	+=3D pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_OCELOT)	+=3D pinctrl-ocelot.o
 obj-$(CONFIG_PINCTRL_EQUILIBRIUM)   +=3D pinctrl-equilibrium.o
+obj-$(CONFIG_PINCTRL_SCMI)	+=3D pinctrl-scmi.o
=20
 obj-y				+=3D actions/
 obj-$(CONFIG_ARCH_ASPEED)	+=3D aspeed/
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.=
c
new file mode 100644
index 000000000000..9b0e884a2829
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,555 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Power Interface (SCMI) Protocol based clock driver
+ *
+ * Copyright (C) 2021 EPAM.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/module.h>
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
+struct scmi_pinctrl_funcs {
+	unsigned int num_groups;
+	const char **groups;
+};
+
+struct scmi_pinctrl {
+	struct device *dev;
+	struct scmi_handle *handle;
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
+	const struct scmi_handle *handle;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->handle)
+		return -EINVAL;
+
+	handle =3D pmx->handle;
+
+	return handle->pinctrl_ops->get_groups_count(handle);
+}
+
+static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev=
,
+					       unsigned int selector)
+{
+	int ret;
+	const char *name;
+	const struct scmi_handle *handle;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return NULL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->handle)
+		return NULL;
+
+	handle =3D pmx->handle;
+
+	ret =3D handle->pinctrl_ops->get_group_name(handle, selector, &name);
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
+	const struct scmi_handle *handle;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->handle)
+		return -EINVAL;
+
+	handle =3D pmx->handle;
+
+	return handle->pinctrl_ops->get_group_pins(handle, selector,
+						   pins, num_pins);
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
+	const struct scmi_handle *handle;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->handle)
+		return -EINVAL;
+
+	handle =3D pmx->handle;
+
+	return handle->pinctrl_ops->get_functions_count(handle);
+}
+
+static const char *pinctrl_scmi_get_function_name(struct pinctrl_dev *pctl=
dev,
+						  unsigned int selector)
+{
+	int ret;
+	const char *name;
+	const struct scmi_handle *handle;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return NULL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->handle)
+		return NULL;
+
+	handle =3D pmx->handle;
+
+	ret =3D handle->pinctrl_ops->get_function_name(handle, selector, &name);
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
+	const struct scmi_handle *handle;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->handle || !groups || !num_groups)
+		return -EINVAL;
+
+	handle =3D pmx->handle;
+
+	if ((selector < pmx->nr_functions)
+		&& (pmx->functions[selector].num_groups)) {
+		*groups =3D (const char * const *)pmx->functions[selector].groups;
+		*num_groups =3D pmx->functions[selector].num_groups;
+		return 0;
+	}
+
+	ret =3D handle->pinctrl_ops->get_function_groups(handle, selector,
+						       &pmx->functions[selector].num_groups,
+						       &group_ids);
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
+		devm_kmalloc_array(pmx->dev, *num_groups,
+			sizeof(*pmx->functions[selector].groups),
+			GFP_KERNEL | __GFP_ZERO);
+	if (!pmx->functions[selector].groups)
+		return -ENOMEM;
+
+	for (i =3D 0; i < *num_groups; i++) {
+		pmx->functions[selector].groups[i]
+			=3D pinctrl_scmi_get_group_name(pmx->pctldev,
+						      group_ids[i]);
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
+	const struct scmi_handle *handle;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->handle)
+		return -EINVAL;
+
+	handle =3D pmx->handle;
+
+	return handle->pinctrl_ops->set_mux(handle, selector, group);
+}
+
+static int pinctrl_scmi_request(struct pinctrl_dev *pctldev,
+				unsigned int offset)
+{
+	const struct scmi_handle *handle;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->handle)
+		return -EINVAL;
+
+	handle =3D pmx->handle;
+
+	return handle->pinctrl_ops->request_pin(handle, offset);
+}
+
+static int pinctrl_scmi_free(struct pinctrl_dev *pctldev, unsigned int off=
set)
+{
+	const struct scmi_handle *handle;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->handle)
+		return -EINVAL;
+
+	handle =3D pmx->handle;
+
+	return handle->pinctrl_ops->free_pin(handle, offset);
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
+	const struct scmi_handle *handle;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->handle || !config)
+		return -EINVAL;
+
+	handle =3D pmx->handle;
+
+	return handle->pinctrl_ops->get_config(handle, _pin, (u32 *)config);
+}
+
+static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
+				    unsigned int _pin,
+				    unsigned long *configs,
+				    unsigned int num_configs)
+{
+	const struct scmi_handle *handle;
+	int i, ret;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->handle || !configs || num_configs =3D=3D 0)
+		return -EINVAL;
+
+	handle =3D pmx->handle;
+
+	for (i =3D 0; i < num_configs; i++) {
+		ret =3D handle->pinctrl_ops->set_config(handle, _pin, configs[i]);
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
+	const struct scmi_handle *handle;
+	int i, ret;
+	struct scmi_pinctrl *pmx;
+
+	if (!pctldev)
+		return -EINVAL;
+
+	pmx =3D pinctrl_dev_get_drvdata(pctldev);
+
+	if (!pmx || !pmx->handle || !configs || num_configs =3D=3D 0)
+		return -EINVAL;
+
+	handle =3D pmx->handle;
+
+	for (i =3D 0; i < num_configs; i++) {
+		ret =3D handle->pinctrl_ops->set_config_group(handle, group,
+							    configs[i]);
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
+static const struct pinconf_ops pinctrl_scmi_pinconf_ops =3D {
+	.is_generic =3D true,
+	.pin_config_get =3D pinctrl_scmi_pinconf_get,
+	.pin_config_set =3D pinctrl_scmi_pinconf_set,
+	.pin_config_group_set =3D pinctrl_scmi_pinconf_group_set,
+	.pin_config_config_dbg_show =3D pinconf_generic_dump_config,
+};
+
+static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
+				 unsigned int *nr_pins,
+				 const struct pinctrl_pin_desc **pins)
+{
+	int ret, i;
+	struct scmi_handle *handle;
+
+	if (!pmx)
+		return -EINVAL;
+
+	handle =3D pmx->handle;
+
+	if (!handle || !pins || !nr_pins)
+		return -EINVAL;
+
+	if (pmx->nr_pins) {
+		*pins =3D pmx->pins;
+		*nr_pins =3D pmx->nr_pins;
+		return 0;
+	}
+
+	*nr_pins =3D handle->pinctrl_ops->get_pins_count(handle);
+
+	pmx->nr_pins =3D *nr_pins;
+	pmx->pins =3D devm_kmalloc_array(pmx->dev, *nr_pins, sizeof(*pmx->pins),
+				       GFP_KERNEL);
+	if (!pmx->pins)
+		return -ENOMEM;
+
+	for (i =3D 0; i < *nr_pins; i++) {
+		pmx->pins[i].number =3D i;
+		ret =3D handle->pinctrl_ops->get_pin_name(handle, i,
+							&pmx->pins[i].name);
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
+
+	if (!sdev || !sdev->handle)
+		return -EINVAL;
+
+	pmx =3D devm_kzalloc(&sdev->dev, sizeof(*pmx), GFP_KERNEL);
+	if (!pmx)
+		return -ENOMEM;
+
+	pmx->handle =3D sdev->handle;
+	if (!pmx->handle) {
+		ret =3D -ENOMEM;
+		goto clean;
+	}
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
+			devm_kmalloc_array(&sdev->dev, pmx->nr_functions,
+					   sizeof(*pmx->functions),
+					   GFP_KERNEL | __GFP_ZERO);
+		if (!pmx->functions) {
+			ret =3D -ENOMEM;
+			goto clean;
+		}
+	}
+
+	if (pmx->nr_groups) {
+		pmx->groups =3D
+			devm_kmalloc_array(&sdev->dev, pmx->nr_groups,
+					   sizeof(*pmx->groups),
+					   GFP_KERNEL | __GFP_ZERO);
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
+MODULE_LICENSE("GPL v2");
--=20
2.25.1
