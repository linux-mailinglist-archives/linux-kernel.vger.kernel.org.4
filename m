Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50DA618AA5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiKCVf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiKCVfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:35:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE94220E8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667511277; bh=kzvI8y8uyM4os1o1QQC1oIapo3BRq4VS8eS4U1rhvTM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZtddkZuh3XHgOl8eSNEbAUrcTmwId+LG15klWehfO/WrvqNzcGNYuxdd4RYAeP6AR
         /vKBkDajkJXj8BXobe+5IwaRLF9/8gMCZ8ZDT1WsEdGFumuR/JATy/w4KPPoKr37iB
         xygbQff1BJdmbXhA0Zobt1biFtHk/INF8xs9mK3z3GhyP38RyAQuZZ2AsMX8SHA4r7
         wCg5uBCtS+TbyPHonG73e8U0o9iEkiPKSwg3NgX80wJf72jGe2iG2zu1qvDIYP8Q0S
         JkRUVSUQ0BeqfEnKWytcnMR4ff3PupAVkyd6+G67YHGMSFXVStt06dJyAiw+FZXAwA
         amOnh5rktfkuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([78.34.126.36]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1pCLTm3q0U-00x6sK; Thu, 03
 Nov 2022 22:34:37 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Tomer Maimon <tmaimon77@gmail.com>
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Hector Martin <marcan@marcan.st>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org
Subject: [PATCH v6] soc: nuvoton: Add SoC info driver for WPCM450
Date:   Thu,  3 Nov 2022 22:34:15 +0100
Message-Id: <20221103213420.1395507-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w29psqiulMSZj+SLdxY1H/PPfAOFhgD1+jy8eUUJFMbeDpzEN8m
 NIarEjQq2taE5HjOnkez9yoDksjdqN6slxeWdk70XzwxtMg8BJM0Jly3+7bxqzzl8bhWtoC
 Jj0oKAnBjZsv0B6MX/HyXcLJm3DYvRksuEXaw0psGlkX7rjYdvSsuSYCvQfTIfDzcMLcatq
 3XkqucMeXkuXeb3G4eLDg==
UI-OutboundReport: notjunk:1;M01:P0:VPgmaCQTlTI=;iCu9aIj7cBcl8adXrHitFBPYnjm
 vm7s+PsxP824T1iTmcLDdsC/yxVqKnPyy3QqLDoWJY8guUey76BZbn4mYDdY9u0QR+7eBzmhu
 pQ23b/viv7/NLCG8PHq9/aQeIRTZg4pa/nV1yrRdQ4WZGXRH0OI8FYG4zAV2zfibc7zbUWzL4
 oOle8slvDST8OZIKjullfAHd7cVbHtL1JEWqV9aYi/IPumnyvoRWDUxiS1Ts0ng81oenn/hgA
 BvkoavxAPCAuzp6pdSSk7lCigRqnnxieYxP9mpe4fhQJsMUbrzLJiRNuFdytSdzau6cYog19P
 g3DHtjQik1VF5GLvB3/ND/sg4QHtSzC0+ozGfipZauSzLDXfWdvqmzf0++HSBo6195qsIuI6t
 7TULPM0waQOAqLuB3f/iTkpaBfjIHTKk+QVD4qWJL36Uw8NvAksf0RMYVXPtLD/JzPCduwfvo
 G2c0R7jsj7sLg7hh7QGaWrRsozHumyfbDJr77W8wQGQAWBTrMbxhuIxkb6jxHjrP+FqqtRQzW
 qRfh6qv4eIxp8m5jrP8x7SlPMFXLdq7GUTlVqGIdThidgCtQCtv6Yt8XenoI/psmv+UFLiAax
 YcHc1OqnAxBZhWG8DKLXd0lKTVVeScPu+RsTWq3KiQzl18heJzjStYmHs9HVfxZwzXV8Iqx75
 2hAGStN9pkqrcIe9aNHHULOzuN3L2v5GtOWA7MIoYwn3aLAXpW4Sgj03LXt9wuaal3FV8TNZT
 dR840+RuzWYXvlkaskqoeIs5Vi7VyX12RY8C47w7a06trBzaOvKfAvMgZ/3DZkXRUP5j0xwZL
 7ll2nQuKS3Gx56q6WC9R1A6ZihYPoKKA8kC5ObgH97GcBPDnm9JDbFOeZQN8EagmS9nRoK/jB
 XR5ZSErZnz04HIiqI1lKymGfyH4+5g+d1sv0FrLltuhieLKwBgyMED0+2Ok6YOanLifcTlZxI
 SKezQw==
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
v6:
- Select REGMAP
- Rearrange Kconfig structure a bit

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
 drivers/soc/nuvoton/Kconfig       |  17 +++++
 drivers/soc/nuvoton/Makefile      |   2 +
 drivers/soc/nuvoton/wpcm450-soc.c | 109 ++++++++++++++++++++++++++++++
 5 files changed, 130 insertions(+)
 create mode 100644 drivers/soc/nuvoton/Kconfig
 create mode 100644 drivers/soc/nuvoton/Makefile
 create mode 100644 drivers/soc/nuvoton/wpcm450-soc.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index e461c071189b4..f17764a7e5884 100644
=2D-- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -15,6 +15,7 @@ source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/litex/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/microchip/Kconfig"
+source "drivers/soc/nuvoton/Kconfig"
 source "drivers/soc/pxa/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/renesas/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 69ba6508cf2c1..9f92506854852 100644
=2D-- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SOC_XWAY)		+=3D lantiq/
 obj-$(CONFIG_LITEX_SOC_CONTROLLER) +=3D litex/
 obj-y				+=3D mediatek/
 obj-y				+=3D microchip/
+obj-y				+=3D nuvoton/
 obj-y				+=3D pxa/
 obj-y				+=3D amlogic/
 obj-y				+=3D qcom/
diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
new file mode 100644
index 0000000000000..2167d3d739d84
=2D-- /dev/null
+++ b/drivers/soc/nuvoton/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+menu "Nuvoton SoC drivers"
+	depends on ARCH_NPCM || COMPILE_TEST
+
+config WPCM450_SOC
+	tristate "Nuvoton WPCM450 SoC driver"
+	default y if ARCH_WPCM450
+	select SOC_BUS
+	select REGMAP
+	help
+	  Say Y here to compile the SoC information driver for Nuvoton
+	  WPCM450 SoCs.
+
+	  This driver provides information such as the SoC model and
+	  revision.
+
+endmenu
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

