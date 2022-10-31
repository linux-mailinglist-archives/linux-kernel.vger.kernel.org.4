Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689006140C1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJaWkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJaWj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:39:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9825FE4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667255972; bh=iaIFSLNn0yklCqLnafJqQ+I6bFLTwxIwEcdTu4zodc8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=cHEJakU6fkM5wIsPEmw3aDN7OSZVbdkfWaMzkn94/Z6Qpgxqdr+SiSqw1GH/3QEUN
         2zk7KFS5WN3u2PJ0ER7hEq8nbRy4DOs0pKY1LOBL9sdeX85Cny4ajcFLiZ17Zd52lC
         N8C/BqFHunjXlIYn2sM4A8o0+Fod49xsYEsxH0ZZnyDTNOa87kmUiCU8zPeecVMyqs
         OsOYI60WaHD7GeX2xFM37IUoaD4UmLb4nzYWHw6Cdi9fnQ9MdbI/ERKjBgLBCLn8I1
         cmnuBZP650THyVNhSgxiNe3UAohjCepKdq4Wf7eobWTnpT5Z6E3aISyg5ZHo0Jok6e
         8gUtPZDQbMlVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.35.189.154]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp9Y-1oWuGO2FcS-00Y6YV; Mon, 31
 Oct 2022 23:39:32 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Hector Martin <marcan@marcan.st>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Conor Dooley <conor.dooley@microchip.com>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 RESEND] soc: nuvoton: Add SoC info driver for WPCM450
Date:   Mon, 31 Oct 2022 23:39:22 +0100
Message-Id: <20221031223926.241641-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ah+jqvgbx5xPMC9n7Czjp7kSIE65GdnQvjQ2bQ+HTbvy8OpTXm6
 iQvrZmyqpo7Sjz911FGrlbUurY5EXg39VsIC3xMLwMDo3PjU4k7JJMXV8xupx6j99k5O1K9
 BvgM+ZNvgIbkFOm1aPFtHrQ6IKUvIzLPZ4oWFueE8lDOEBR2jgZDutQ17zC2rT1pUenALzT
 B1xVaVh/EuGU38qBALnMA==
UI-OutboundReport: notjunk:1;M01:P0:XLF7s+/qqLs=;wNs07tZ2By4ZRVFnOMr+HEVEVZB
 fR87zVEth83LVIVPWPQLjtFd3nRfhcrJIHTQukzHt7+sSkcblZZ+Hku1BTQAJ2b5/gS8Mql12
 jcDWq4tQyXDFhXKo+DwjBVYFxRbzvY1+Rg0IwZRQSw2pkWr1cuChjVlKd2bvfTHtDJPHUtdtP
 9Qgf5tBSh+9xB2NR1DNlfhMJA0rQNKU2BSAdKeEtjK4851/5sgheFHrsxMgdf86EKIjOe7Do5
 hWpROpn6AgsxX0H4knKoutbmD3LlW51Xafob+bv4o0LBDHmnSiiGle4INWZW1acwTfXm/gFyp
 g334ISJ3/ZZlvi/+4lTTwYs9yu+MaPnY+RXFcOghJCBtNgsxSuOjFCDh147v1WsKoQwOqhyuK
 uCe26xlu7xQ3AM2MaItMQ4eBk6wkrVnwuFREdu58fJQs5cQ2de+bogOs4M0ymuMuzcL4a1xCt
 5GjvEAwJJnEHvFi8eVY63HvidOLFrWw33az+b63ScTym9OZVKa9+8xe1mz21tXXC4CUGegGCu
 tFPoRN3m0Gn3Rr2ZUw4uz3CXU8rNlBrkbyi+9KQtZ7qLee1wd/aD6jZMQDQsQjSI4SJamauc9
 fPGzcZLFTTysMTHU4ptY1HIFxwlWk8kgJ9iaOX4Mz/nk24mgcabUu+i9xiYeBQKOA9DwNKjtJ
 otvjT4cTOWA7a6Vu7CkoFGlpA99hBPEX9bIJAIbD7lNo/mga9R8x2kEWqTWvZSLeywtflSnUN
 7gss2h4Pf9zNuamRaybBZ24EPqI86ogF+9VqcYvWfJCcp+XwyZmQiusfj/83bX8+1k54vCpim
 aj9qDS1qN0z6yb1eecpnPfvIHH3kzmv7uCoy5H4tMMmmzc8T+NlL42UInm31Yy9cqNmZlWm1t
 KNGXypQSbN9WIeu5nv2onpi41pLYedKrVRliO73fwgNi67ihyNroiO//aCImF1w55x/aGwsfP
 A/WrcjcFt9APZAMV9dc0+v1dyCA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a SoC information driver for Nuvoton WPCM450 SoCs. It provides
information such as the SoC revision.

Usage example:

  # grep . /sys/devices/soc0/*
  /sys/devices/soc0/family:Nuvoton NPCM
  /sys/devices/soc0/revision:A3
  /sys/devices/soc0/soc_id:WPCM450

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
=2D--
v5:
- Change Kconfig option from bool to tristate

v4:
- rebase on 5.19-rc1

v3:
- Declare revisions array as static
- Change get_revision parameter to `unsigned int`
- Add Paul's R-b tag
- Add usage example
- Sort includes

v2:
- https://lore.kernel.org/lkml/20220409173319.2491196-1-j.neuschaefer@gmx.=
net/
- Add R-b tag
- rebase on 5.18-rc1

v1:
- https://lore.kernel.org/lkml/20220129143316.2321460-1-j.neuschaefer@gmx.=
net/
=2D--
 drivers/soc/Kconfig               |   1 +
 drivers/soc/Makefile              |   1 +
 drivers/soc/nuvoton/Kconfig       |  11 +++
 drivers/soc/nuvoton/Makefile      |   2 +
 drivers/soc/nuvoton/wpcm450-soc.c | 109 ++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+)
 create mode 100644 drivers/soc/nuvoton/Kconfig
 create mode 100644 drivers/soc/nuvoton/Makefile
 create mode 100644 drivers/soc/nuvoton/wpcm450-soc.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 86ccf5970bc1b..cca3dfa5c6aea 100644
=2D-- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -14,6 +14,7 @@ source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/litex/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/microchip/Kconfig"
+source "drivers/soc/nuvoton/Kconfig"
 source "drivers/soc/pxa/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 919716e0e7001..b9eb3c75e551a 100644
=2D-- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_SOC_XWAY)		+=3D lantiq/
 obj-$(CONFIG_LITEX_SOC_CONTROLLER) +=3D litex/
 obj-y				+=3D mediatek/
 obj-y				+=3D microchip/
+obj-y				+=3D nuvoton/
 obj-y				+=3D pxa/
 obj-y				+=3D amlogic/
 obj-y				+=3D qcom/
diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
new file mode 100644
index 0000000000000..df46182088ec2
=2D-- /dev/null
+++ b/drivers/soc/nuvoton/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+menuconfig WPCM450_SOC
+	tristate "Nuvoton WPCM450 SoC driver"
+	default y if ARCH_WPCM450
+	select SOC_BUS
+	help
+	  Say Y here to compile the SoC information driver for Nuvoton
+	  WPCM450 SoCs.
+
+	  This driver provides information such as the SoC model and
+	  revision.
diff --git a/drivers/soc/nuvoton/Makefile b/drivers/soc/nuvoton/Makefile
new file mode 100644
index 0000000000000..e30317b4e8290
=2D-- /dev/null
+++ b/drivers/soc/nuvoton/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_WPCM450_SOC)	+=3D wpcm450-soc.o
diff --git a/drivers/soc/nuvoton/wpcm450-soc.c b/drivers/soc/nuvoton/wpcm4=
50-soc.c
new file mode 100644
index 0000000000000..c5e0d11c383b1
=2D-- /dev/null
+++ b/drivers/soc/nuvoton/wpcm450-soc.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Nuvoton WPCM450 SoC Identification
+ *
+ * Copyright (C) 2022 Jonathan Neusch=C3=A4fer
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define GCR_PDID	0
+#define PDID_CHIP(x)	((x) & 0x00ffffff)
+#define CHIP_WPCM450	0x926450
+#define PDID_REV(x)	((x) >> 24)
+
+struct revision {
+	u8 number;
+	const char *name;
+};
+
+static const struct revision revisions[] __initconst =3D {
+	{ 0x00, "Z1" },
+	{ 0x03, "Z2" },
+	{ 0x04, "Z21" },
+	{ 0x08, "A1" },
+	{ 0x09, "A2" },
+	{ 0x0a, "A3" },
+	{}
+};
+
+static const char * __init get_revision(unsigned int rev)
+{
+	int i;
+
+	for (i =3D 0; revisions[i].name; i++)
+		if (revisions[i].number =3D=3D rev)
+			return revisions[i].name;
+	return NULL;
+}
+
+static struct soc_device_attribute *wpcm450_attr;
+static struct soc_device *wpcm450_soc;
+
+static int __init wpcm450_soc_init(void)
+{
+	struct soc_device_attribute *attr;
+	struct soc_device *soc;
+	const char *revision;
+	struct regmap *gcr;
+	u32 pdid;
+	int ret;
+
+	if (!of_machine_is_compatible("nuvoton,wpcm450"))
+		return 0;
+
+	gcr =3D syscon_regmap_lookup_by_compatible("nuvoton,wpcm450-gcr");
+	if (IS_ERR(gcr))
+		return PTR_ERR(gcr);
+	ret =3D regmap_read(gcr, GCR_PDID, &pdid);
+	if (ret)
+		return ret;
+
+	if (PDID_CHIP(pdid) !=3D CHIP_WPCM450) {
+		pr_warn("Unknown chip ID in GCR.PDID: 0x%06x\n", PDID_CHIP(pdid));
+		return -ENODEV;
+	}
+
+	revision =3D get_revision(PDID_REV(pdid));
+	if (!revision) {
+		pr_warn("Unknown chip revision in GCR.PDID: 0x%02x\n", PDID_REV(pdid));
+		return -ENODEV;
+	}
+
+	attr =3D kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	attr->family =3D "Nuvoton NPCM";
+	attr->soc_id =3D "WPCM450";
+	attr->revision =3D revision;
+	soc =3D soc_device_register(attr);
+	if (IS_ERR(soc)) {
+		kfree(attr);
+		pr_warn("Could not register SoC device\n");
+		return PTR_ERR(soc);
+	}
+
+	wpcm450_soc =3D soc;
+	wpcm450_attr =3D attr;
+	return 0;
+}
+module_init(wpcm450_soc_init);
+
+static void __exit wpcm450_soc_exit(void)
+{
+	if (wpcm450_soc) {
+		soc_device_unregister(wpcm450_soc);
+		wpcm450_soc =3D NULL;
+		kfree(wpcm450_attr);
+	}
+}
+module_exit(wpcm450_soc_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jonathan Neusch=C3=A4fer");
+MODULE_DESCRIPTION("Nuvoton WPCM450 SoC Identification driver");
=2D-
2.35.1

