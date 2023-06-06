Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939507248F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbjFFQXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbjFFQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:23:03 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA85C10F4;
        Tue,  6 Jun 2023 09:22:59 -0700 (PDT)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356G3feh006627;
        Tue, 6 Jun 2023 16:22:48 GMT
Received: from eur02-db5-obe.outbound.protection.outlook.com (mail-db5eur02lp2112.outbound.protection.outlook.com [104.47.11.112])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3r2804r2hw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 16:22:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFzalSxQwR6F3GhoO2pGHlarxArqU17CVwRVGWPX4WUUYCkaLt8n55H7JkG7qJAYB53gdxQPocPvbUNZvrPndhff4qGUfCGQ3tOrOMC/v3NwoB/+Mbl+48TKuumUJuHQhG8CM1waAa9wBemE+H2pOSV8Xqs46RXt7+rJEahZNIb0RW4lXMSmS//vcphGMxLSSE+Qa0n5JzsS4pUVG//zzVWy70pk/nd/4OkrgOtVPeSbGLJzcCM3GHlOA49NwfQXaKE/NT4halBZzGksmRTLw/XeUzkTMHF7raeXJdFmE0kqfstJK5NkLKSms9YKS95s5tfQ+OIczdRE9uVLbYU9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faOtSIQclsBzPLgaqj9sZP2ojMc6mCeoFaCdceBh4rI=;
 b=errdl5Hn/qkQniPV34M45oX95MvXh19m9AIyl0kYsGs68ZevM1pxbpOTC8KU5TkHM+01MvwqhoVEDsgp1mlzwCITeN40MJxadkmoElDQkOpv/ttoLzQi3Zi16KzofGz6+t84JMqVs/JsLMfBHs/f0FtlGszeb/NxnC7Oxq8zoW+VxLkBhgyf7r7UNldWRif85TfgjdqA+vxpRHS9W6wo+eA9VEab1EQp66U0x9Ed7PFzoPr2vgtvHNhlzgeq9sMf0NPjqPatK8RiEv055QPeN8MPaIbWPGavhixub+TVkEdfSa8B6r34hdu0RpuHYydL9ouLYvtJ5gvhVXSPXFzWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faOtSIQclsBzPLgaqj9sZP2ojMc6mCeoFaCdceBh4rI=;
 b=Sb7bYUfXRrOnMrmcvZ3gN618jujDg45cbiiuPVyl0IOmCoeSYFMtnFW3bRCSrFwddCkycCJ61oQsMisLU2BuFWVlPQld7anbZVI8aFdqYGe+rbMXW1lmabGGKayhEo8DXuzcX4Ms1p6IclL3GwLqI3PZOo9q0kGicAM+JWh9KAn0nadvN/Ti3Z4C45vflPxQqKdnVdJPnYwXR3buVIZ7pUEifxJYUKGtc1LR8I1je4Ev7jZDtE1HlkuIC9yEnKuYN3q/J3f7hKEtKAepV/3LyiEVTOnpfTZerkZEB/9quYQrrCIgW0K59eujqB+WnQGoCkWadn6rQ80Gzd7vgPKPow==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by PAVPR03MB9383.eurprd03.prod.outlook.com (2603:10a6:102:308::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 16:22:28 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 16:22:28 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [PATCH v3 3/4] pinctrl: Implementation of the generic scmi-pinctrl
 driver
Thread-Topic: [PATCH v3 3/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Index: AQHZmJMWFmItseqHB0qRWKbh+9Pp/A==
Date:   Tue, 6 Jun 2023 16:22:28 +0000
Message-ID: <43109a0f2f362222fca79e2afd15c46ed9a32977.1686063941.git.oleksii_moisieiev@epam.com>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1686063941.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|PAVPR03MB9383:EE_
x-ms-office365-filtering-correlation-id: be86b4b2-2c40-4ea9-a3f9-08db66aa389e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IYAzymepBfqUIl5G2UXND/XLG8zridnNB4NwZaAjntl3cwDuABFp13tD0Oemur6p9+g3P3qRZRD7hfAmj53O7spAa2Kgx50ixLniuBuEtDG7QIf84YSpUUnBLzTnY4QSHMB29qVSsiA5clI35HK9D+qyOKuBFaz51aPR4pFEjUrK43EusHnc1zIF1zWTWuRYJFWrIKdxtjz5q9TBtOHFgHlZLBBYilMKDkQTlm2yGJgsqO8swkzL3xGZLZO3cStN+/z9rlW7pGHhMXyG93SMxkBWBwNNXhN/VX5NT+f0P9ar75dxHKzOHlW5wPxG5A624P/oSD1BKUo9bFezNdV1cJTJkiFYsdHUf+tFmxT+T8wY+KhMhfDRRCjOoL8CneKlk1dn//4Y9vYi4FtQ3t+sYogPPcoG0+KOpVCMEFVlMx+44/2ef/KzgUwyKBOtoNJPvH4YFH4wkf6iqWiwCa7rDswqtWKi9w1zkKl2OUBl/OE4lrNTx10Ta3ct4mTKfcqaxaZSCXaETsuA0mPxunWBwerYnyWwgBAf8XvUZ77DWiiG0WRGhOgdMYlqLCW5ReX+lbk6wvqTET71rRQQED0oS5+mG3SGRwoMN2BR2M9qBK2d3fMBoT8GPlGvlkQUSFwTI5gSmzYQ4JQtbjnbHpXJqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(83380400001)(38100700002)(86362001)(38070700005)(122000001)(478600001)(91956017)(41300700001)(71200400001)(6486002)(54906003)(5660300002)(8676002)(66476007)(64756008)(66946007)(76116006)(6916009)(4326008)(8936002)(66446008)(66556008)(316002)(2906002)(30864003)(7416002)(2616005)(26005)(6506007)(6512007)(36756003)(186003)(41533002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4vdGYK8vMXdaOePQ8oXXgKZOL2WZ32TxVAEDDnsFImAjB3AUONGuyaQGT0?=
 =?iso-8859-1?Q?6OSFb0c4/miUiKkGl98mBxxKZLmLmSQC7gjBM+mz5A24qcjZTAnNEy9aPk?=
 =?iso-8859-1?Q?qhQBgr59fUFrv9O45ZyL1e8cIWee6XoMzO1TMrAnuwQ6dbeQIIjVO0TkDz?=
 =?iso-8859-1?Q?Onll27Gz/Uh+ypgPQ/oI8Vk1NEW+VbEGXNsIZtSSpjM/HvCZaUD09Fjyya?=
 =?iso-8859-1?Q?s/ggruzzMUuMEOQKhxGdtS3h0YDGXdfPJHvuJ6j3zuGq2TGnDB9L2/uNLA?=
 =?iso-8859-1?Q?bWuF2Z22yttP0zXsIR/B8u2B/9arKzQ4TtvOND445baSQcFyCk+JB1jvNS?=
 =?iso-8859-1?Q?4FQxGPP+XGCZ9iXMTtThWhpjVMeRm1kF0E3MyWo/SY3ZM2ZGagtw9qnNtT?=
 =?iso-8859-1?Q?TtxCVX/i0YqJskD2eLVf/mly3QnmauFuAceq8Jb739HKvauHxrRrZ2kiGF?=
 =?iso-8859-1?Q?WArA6UcWXBvX4SwCtTwyg+G9tgT/mh6z7Un642DdpfBUsjkTHKvh7WUFVE?=
 =?iso-8859-1?Q?iGN5Kp4QCiRwNcz+HvElzZry8bnyVQMSkMEAVAxhkA+xd6F46F/OE0MiSl?=
 =?iso-8859-1?Q?BmSqEdZdV8DOXXnQdEswuFlAhYWTrUG9tv0tCW5qMBhvCQmePyxc2VdiPN?=
 =?iso-8859-1?Q?jc84TgWllgfNRNwxdW7PbUwsmMsn4I7oh+TVuYYTOFa6NWCzOJTtlXa+kZ?=
 =?iso-8859-1?Q?TZewA49AJiMZ0ij4BCoi8zgYy1PIYtgqv3CmBVWdldvKQ9iz5qLd2QbE/K?=
 =?iso-8859-1?Q?JJ2OWaT8+9ggYj8fV9qULwJk9TsFc7Ccp198UKMw9JwEUdd/MjDPmb30IK?=
 =?iso-8859-1?Q?rCtj4KSTcK0kYgbLRJK76fNcAxL/dVtTMnjiGlCZBjRvSaeC4cpfmuSQF3?=
 =?iso-8859-1?Q?pbWkwHUAu/klUsA/MV+jDXxWXyJrU0Ame86MY+JgsyxrucIZqNXni+vitR?=
 =?iso-8859-1?Q?r81eYRJgpNylVdwCPkekphOGtmhh/plGU1TWmgDY3D/QtSrTT9DKVIo20Z?=
 =?iso-8859-1?Q?SzHcj3ADeWxxnUkaiaGmGFZLPtQmSVeWDQ1Fv6RRkxc/FBbvTgMiStzfyR?=
 =?iso-8859-1?Q?Wufkg5m9AwclYZXRjPr/AsAlxr1NChEt7zV/Yf2lR6F7TyXh932m7KQKuS?=
 =?iso-8859-1?Q?6tnzAW/zPwA1gZcanDJeQkA6jV7Yeh/KPjLQmW7M45DOjwu68kYaQU4vXV?=
 =?iso-8859-1?Q?KbEpalrXPWF/ErP43r1IWLQYIjc0h3MOatdv/aztzd/Gao8cSIqqls+qIW?=
 =?iso-8859-1?Q?one47vSDjLHv1OR1ozfzm+Ts1xXRqf63L9ViG2HvTfjRcKDbcbJcElNvzn?=
 =?iso-8859-1?Q?u1GZGtPi369jnz1hpOK5jdBcwC79fOzhCqlJRHIWsD4Hde9JA/gP8ffQRG?=
 =?iso-8859-1?Q?3RZiFkW1e6uSpBP3PPumoDFDSNDspPslyl22YV1v1+RYSjlbRX5oPEG0rW?=
 =?iso-8859-1?Q?IBeKC+vlal58rWO7Br8ZL3IlFXqQJkxZExS+JyUFVsvVn0lkz9l4QTvWFz?=
 =?iso-8859-1?Q?jIJEiK/JXNBpjxtMWUinaioTjKICeDJ+mSCdYNO//IhsnNlypay+cVzSUE?=
 =?iso-8859-1?Q?eqdEv4qJnREDa3vwXHkVhNZL6/2AW7m07BrhfyikPYjcd+jbjSAsPn1Mh6?=
 =?iso-8859-1?Q?jgCfKz2qFS/T4AyqF4yMa182sfkqUJBxqukju5nu0r1++xpA4VaiLfOQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be86b4b2-2c40-4ea9-a3f9-08db66aa389e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 16:22:28.3104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oN95VVAGXXI6j1uvBPAh/nFJfe/Hhglq6UuTBAPfiFfSmmlnwhIpBkzKdflGKbpPOcZcYhv/xpopcmLb7GBuBpwr/7JfEs84CLwCHeRdc88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9383
X-Proofpoint-GUID: wcNcKG9udto040MADMD3PaEdnqwDMELq
X-Proofpoint-ORIG-GUID: wcNcKG9udto040MADMD3PaEdnqwDMELq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060141
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
 drivers/pinctrl/Kconfig        |  11 +
 drivers/pinctrl/Makefile       |   1 +
 drivers/pinctrl/pinctrl-scmi.c | 554 +++++++++++++++++++++++++++++++++
 4 files changed, 567 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 297b2512963d..91883955fc1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20527,6 +20527,7 @@ M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 F:	drivers/firmware/arm_scmi/pinctrl.c
+F:	drivers/pinctrl/pinctrl-scmi.c
=20
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 5787c579dcf6..c4680a2c5e13 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -546,4 +546,15 @@ source "drivers/pinctrl/uniphier/Kconfig"
 source "drivers/pinctrl/visconti/Kconfig"
 source "drivers/pinctrl/vt8500/Kconfig"
=20
+config PINCTRL_SCMI
+	tristate "Pinctrl driver controlled via SCMI interface"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	select PINMUX
+	select GENERIC_PINCONF
+	help
+	  This driver provides support for pinctrl which is controlled
+	  by firmware that implements the SCMI interface.
+	  It uses SCMI Message Protocol to interact with the
+	  firmware providing all the pinctrl controls.
+
 endif
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index e196c6e324ad..b932a116e6a0 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_PINCTRL_SX150X)	+=3D pinctrl-sx150x.o
 obj-$(CONFIG_PINCTRL_TB10X)	+=3D pinctrl-tb10x.o
 obj-$(CONFIG_PINCTRL_ZYNQMP)	+=3D pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+=3D pinctrl-zynq.o
+obj-$(CONFIG_PINCTRL_SCMI)	+=3D pinctrl-scmi.o
=20
 obj-y				+=3D actions/
 obj-$(CONFIG_ARCH_ASPEED)	+=3D aspeed/
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.=
c
new file mode 100644
index 000000000000..e46dffa652c6
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * System Control and Power Interface (SCMI) Protocol based pinctrl driver
+ *
+ * Copyright (C) 2023 EPAM
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
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
+	devm_kfree(pmx->dev, pmx->functions[selector].groups);
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
+				      &config_value);
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
+				      config_type, &config_value);
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
+			goto err_free;
+		}
+	}
+
+	*pins =3D pmx->pins;
+	dev_dbg(pmx->dev, "got pins %d", *nr_pins);
+
+	return 0;
+ err_free:
+	devm_kfree(pmx->dev, pmx->pins);
+	pmx->nr_pins =3D 0;
+
+	return ret;
+}
+
+static const struct scmi_device_id scmi_id_table[] =3D {
+	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
+	{ }
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
+	pinctrl_ops =3D handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL, &p=
h);
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
+		return ret;
+
+	ret =3D devm_pinctrl_register_and_init(&sdev->dev, &pmx->pctl_desc, pmx,
+					     &pmx->pctldev);
+	if (ret) {
+		dev_err_probe(&sdev->dev, ret, "Failed to register pinctrl\n");
+		return ret;
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
+		if (!pmx->functions)
+			return -ENOMEM;
+	}
+
+	if (pmx->nr_groups) {
+		pmx->groups =3D
+			devm_kcalloc(&sdev->dev, pmx->nr_groups,
+				     sizeof(*pmx->groups),
+				     GFP_KERNEL);
+		if (!pmx->groups)
+			return -ENOMEM;
+	}
+
+	return pinctrl_enable(pmx->pctldev);
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
