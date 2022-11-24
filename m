Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE5637866
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiKXMDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKXMDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:03:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C26A201B2;
        Thu, 24 Nov 2022 04:02:58 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:02:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrWypTd34XTV+bmjVZiRAyb7NUe3syRkmIqxmrrR2Cs=;
        b=IWQsIL8hAL0tz+sWe99ArGM5FhcpNbfog/LHGP8UNwBr+AToPkwgkNRO3W5gYlu6vSnjcI
        Rc5PrSL3A94qcSaYuaviHDc0hkZqB4AyIlL9OgMRmAbdbBWBFMGZz+Ut8lwlaYJ6hyGVoB
        3PUmWmPhVs8dNo7fKsBmaVnRyEeZZ/dlI4NwGALamQDfLTzSDrhRWgMsJDxOfXRBMfSvLb
        Jm4WcYeEtT76g6wQrT+iIq4HaSeRBM/F3dwJlCbUomWOGCFOgniXgFcW+SDWDNXCxI1OOe
        xFv9dTqwq4nNr9NPA79XP29a1J1PyBUuHkyYfAZ3t5+mRQGKSKUgMqjZ30n5Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrWypTd34XTV+bmjVZiRAyb7NUe3syRkmIqxmrrR2Cs=;
        b=c/zh4mSxykSEJlFyKotth87TYIUJ+pXtGCZpMvJiy9bNkMvhPSHFNgHoU5TPdedm889oFm
        2HsgCtVkGN+BC4AQ==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Enable UPI topology discovery
 for Skylake Server
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221117122833.3103580-7-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-7-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <166929137586.4906.1269545634674160986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4cfce57fa42d277497cd2c425021312eae2f223c
Gitweb:        https://git.kernel.org/tip/4cfce57fa42d277497cd2c425021312eae2=
f223c
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Thu, 17 Nov 2022 12:28:28=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:22 +01:00

perf/x86/intel/uncore: Enable UPI topology discovery for Skylake Server

UPI topology discovery relies on data from KTILP0 (offset 0x94) and
KTIPCSTS (offset 0x120) registers which reside under IIO bus(3) on
SKX/CLX.

This patch enable UPI topology discovery on Skylake Server. Topology is
exposed through attributes /sys/devices/uncore_upi_<pmu_idx>/dieX,
where dieX is file which holds "upi_<idx1>:die_<idx2>" connected to
this UPI link.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20221117122833.3103580-7-alexander.antonov@li=
nux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 130 ++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index 254ba0a..f682a9a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4253,6 +4253,132 @@ static struct intel_uncore_ops skx_upi_uncore_pci_ops=
 =3D {
 	.read_counter	=3D snbep_uncore_pci_read_counter,
 };
=20
+static umode_t
+skx_upi_mapping_visible(struct kobject *kobj, struct attribute *attr, int di=
e)
+{
+	struct intel_uncore_pmu *pmu =3D dev_to_uncore_pmu(kobj_to_dev(kobj));
+
+	return pmu->type->topology[die][pmu->pmu_idx].upi->enabled ? attr->mode : 0;
+}
+
+static ssize_t skx_upi_mapping_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct intel_uncore_pmu *pmu =3D dev_to_uncore_pmu(dev);
+	struct dev_ext_attribute *ea =3D to_dev_ext_attribute(attr);
+	long die =3D (long)ea->var;
+	struct uncore_upi_topology *upi =3D pmu->type->topology[die][pmu->pmu_idx].=
upi;
+
+	return sysfs_emit(buf, "upi_%d,die_%d\n", upi->pmu_idx_to, upi->die_to);
+}
+
+#define SKX_UPI_REG_DID			0x2058
+#define SKX_UPI_REGS_ADDR_DEVICE_LINK0	0x0e
+#define SKX_UPI_REGS_ADDR_FUNCTION	0x00
+
+/*
+ * UPI Link Parameter 0
+ * |  Bit  |  Default  |  Description
+ * | 19:16 |     0h    | base_nodeid - The NodeID of the sending socket.
+ * | 12:8  |    00h    | sending_port - The processor die port number of the=
 sending port.
+ */
+#define SKX_KTILP0_OFFSET	0x94
+
+/*
+ * UPI Pcode Status. This register is used by PCode to store the link traini=
ng status.
+ * |  Bit  |  Default  |  Description
+ * |   4   |     0h    | ll_status_valid =E2=80=94 Bit indicates the valid t=
raining status
+ *                       logged from PCode to the BIOS.
+ */
+#define SKX_KTIPCSTS_OFFSET	0x120
+
+static int upi_fill_topology(struct pci_dev *dev, struct intel_uncore_topolo=
gy *tp,
+			     int pmu_idx)
+{
+	int ret;
+	u32 upi_conf;
+	struct uncore_upi_topology *upi =3D tp->upi;
+
+	tp->pmu_idx =3D pmu_idx;
+	ret =3D pci_read_config_dword(dev, SKX_KTIPCSTS_OFFSET, &upi_conf);
+	if (ret) {
+		ret =3D pcibios_err_to_errno(ret);
+		goto err;
+	}
+	upi->enabled =3D (upi_conf >> 4) & 1;
+	if (upi->enabled) {
+		ret =3D pci_read_config_dword(dev, SKX_KTILP0_OFFSET,
+					    &upi_conf);
+		if (ret) {
+			ret =3D pcibios_err_to_errno(ret);
+			goto err;
+		}
+		upi->die_to =3D (upi_conf >> 16) & 0xf;
+		upi->pmu_idx_to =3D (upi_conf >> 8) & 0x1f;
+	}
+err:
+	return ret;
+}
+
+static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
+				int die, u64 cpu_bus_msr)
+{
+	int idx, ret;
+	struct intel_uncore_topology *upi;
+	unsigned int devfn;
+	struct pci_dev *dev =3D NULL;
+	u8 bus =3D cpu_bus_msr >> (3 * BUS_NUM_STRIDE);
+
+	for (idx =3D 0; idx < type->num_boxes; idx++) {
+		upi =3D &type->topology[die][idx];
+		devfn =3D PCI_DEVFN(SKX_UPI_REGS_ADDR_DEVICE_LINK0 + idx,
+				  SKX_UPI_REGS_ADDR_FUNCTION);
+		dev =3D pci_get_domain_bus_and_slot(segment, bus, devfn);
+		if (dev) {
+			ret =3D upi_fill_topology(dev, upi, idx);
+			if (ret)
+				break;
+		}
+	}
+
+	pci_dev_put(dev);
+	return ret;
+}
+
+static int skx_upi_get_topology(struct intel_uncore_type *type)
+{
+	/* CPX case is not supported */
+	if (boot_cpu_data.x86_stepping =3D=3D 11)
+		return -EPERM;
+
+	return skx_pmu_get_topology(type, skx_upi_topology_cb);
+}
+
+static struct attribute_group skx_upi_mapping_group =3D {
+	.is_visible	=3D skx_upi_mapping_visible,
+};
+
+static const struct attribute_group *skx_upi_attr_update[] =3D {
+	&skx_upi_mapping_group,
+	NULL
+};
+
+static int
+pmu_upi_set_mapping(struct intel_uncore_type *type, struct attribute_group *=
ag)
+{
+	return pmu_set_mapping(type, ag, skx_upi_mapping_show, UPI_TOPOLOGY_TYPE);
+}
+
+static int skx_upi_set_mapping(struct intel_uncore_type *type)
+{
+	return pmu_upi_set_mapping(type, &skx_upi_mapping_group);
+}
+
+static void skx_upi_cleanup_mapping(struct intel_uncore_type *type)
+{
+	pmu_cleanup_mapping(type, &skx_upi_mapping_group);
+}
+
 static struct intel_uncore_type skx_uncore_upi =3D {
 	.name		=3D "upi",
 	.num_counters   =3D 4,
@@ -4265,6 +4391,10 @@ static struct intel_uncore_type skx_uncore_upi =3D {
 	.box_ctl	=3D SKX_UPI_PCI_PMON_BOX_CTL,
 	.ops		=3D &skx_upi_uncore_pci_ops,
 	.format_group	=3D &skx_upi_uncore_format_group,
+	.attr_update	=3D skx_upi_attr_update,
+	.get_topology	=3D skx_upi_get_topology,
+	.set_mapping	=3D skx_upi_set_mapping,
+	.cleanup_mapping =3D skx_upi_cleanup_mapping,
 };
=20
 static void skx_m2m_uncore_pci_init_box(struct intel_uncore_box *box)
