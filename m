Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B6A676A43
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 00:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjAUXDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 18:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAUXDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 18:03:23 -0500
X-Greylist: delayed 575 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 Jan 2023 15:03:18 PST
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51956CDEE;
        Sat, 21 Jan 2023 15:03:17 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id A258C7A00BF;
        Sat, 21 Jan 2023 23:53:39 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] pata_parport: add driver (PARIDE replacement)
Date:   Sat, 21 Jan 2023 23:53:14 +0100
Message-Id: <20230121225314.32459-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pata_parport is a libata-based replacement of the old PARIDE
subsystem - driver for parallel port IDE devices.
It uses the original paride low-level protocol drivers but does not
need the high-level drivers (pd, pcd, pf, pt, pg). The IDE devices
behind parallel port adapters are handled by the ATA layer.

This will allow paride and its high-level drivers to be removed.

Unfortunately, libata drivers cannot sleep so pata_parport claims
parport before activating the ata host and keeps it claimed (and
protocol connected) until the ata host is removed. This means that
no devices can be chained (neither other pata_parport devices nor
a printer).

paride and pata_parport are mutually exclusive because the compiled
protocol drivers are incompatible.

Tested with:
 - Imation SuperDisk LS-120 and HP C4381A (EPAT)
 - Freecom Parallel CD (FRPW)
 - Toshiba Mobile CD-RW 2793008 w/Freecom Parallel Cable rev.903 (FRIQ)
 - Backpack CD-RW 222011 and CD-RW 19350 (BPCK6)

The following bugs in low-level protocol drivers were found and will
be fixed later:

Note: EPP-32 mode is buggy in EPAT - and also in all other protocol
drivers - they don't handle non-multiple-of-4 block transfers
correctly. This causes problems with LS-120 drive.
There is also another bug in EPAT: EPP modes don't work unless a 4-bit
or 8-bit mode is used first (probably some initialization missing?).
Once the device is initialized, EPP works until power cycle.

So after device power on, you have to:
echo "parport0 epat 0" >/sys/bus/pata_parport/new_device
echo pata_parport.0 >/sys/bus/pata_parport/delete_device
echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
(autoprobe will initialize correctly as it tries the slowest modes
first but you'll get the broken EPP-32 mode)

Note: EPP modes are buggy in FRPW, only modes 0 and 1 work.
Signed-off-by: Ondrej Zary <linux@zary.sk>
---

Changes in v2:
 - keep device connected, remove disconnect timer

 Documentation/admin-guide/blockdev/paride.rst |  52 ++
 drivers/Makefile                              |   2 +-
 drivers/ata/Kconfig                           |  14 +
 drivers/ata/Makefile                          |   2 +
 drivers/ata/pata_parport.c                    | 783 ++++++++++++++++++
 drivers/block/paride/Kconfig                  |  32 +-
 drivers/block/paride/paride.h                 |  13 +
 include/linux/pata_parport.h                  | 106 +++
 8 files changed, 987 insertions(+), 17 deletions(-)
 create mode 100644 drivers/ata/pata_parport.c
 create mode 100644 include/linux/pata_parport.h

diff --git a/Documentation/admin-guide/blockdev/paride.rst b/Documentation/admin-guide/blockdev/paride.rst
index e1ce90af602a..e431a1ef41eb 100644
--- a/Documentation/admin-guide/blockdev/paride.rst
+++ b/Documentation/admin-guide/blockdev/paride.rst
@@ -2,6 +2,9 @@
 Linux and parallel port IDE devices
 ===================================
 
+Most of this document describes the old paride driver. For the new libata
+pata_parport drivrer, jump to the section 4 at the end.
+
 PARIDE v1.03   (c) 1997-8  Grant Guenther <grant@torque.net>
 
 1. Introduction
@@ -437,3 +440,52 @@ You might also find some useful information on the linux-parport
 web pages (although they are not always up to date) at
 
 	http://web.archive.org/web/%2E/http://www.torque.net/parport/
+
+4. pata_parport driver
+======================
+pata_parport is a libata-based driver that uses the same low-level protocol
+drivers as PARIDE but there are no high-level drivers (pd, pcd, pf, pt, pg).
+The IDE devices behind parallel port adapters are handled by the ATA layer.
+
+The device creation is also changed - no protocol numbers or parport I/O
+addresses are used.
+
+All parports and all protocol drivers are probed automatically unless probe=0
+parameter is used. So just "modprobe epat" is enough for a Imation SuperDisk
+drive to work.
+
+Manual device creation::
+
+	# echo "port protocol mode unit delay" >/sys/bus/pata_parport/new_device
+
+where:
+
+	======== ================================================
+	port	 parport name (or "auto" for all parports)
+	protocol protocol name (or "auto" for all protocols)
+	mode	 mode number (protocol-specific) or -1 for probe
+	unit	 unit number (see the paride documentation above)
+	delay	 I/O delay (see the paride documentation above)
+	======== ================================================
+
+If you omit the parameters from the end, defaults will be used, e.g.:
+
+Probe all parports with all protocols::
+
+	# echo auto >/sys/bus/pata_parport/new_device
+
+Probe parport0 using protocol epat and mode 4 (EPP-16)::
+
+	# echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
+
+Probe parport0 using all protocols::
+
+	# echo "parport0 auto" >/sys/bus/pata_parport/new_device
+
+Probe all parports using protoocol epat::
+
+	# echo "auto epat" >/sys/bus/pata_parport/new_device
+
+Deleting devices::
+
+	# echo pata_parport.0 >/sys/bus/pata_parport/delete_device
diff --git a/drivers/Makefile b/drivers/Makefile
index bdf1c66141c9..f1365608bc8c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -98,7 +98,7 @@ obj-$(CONFIG_DIO)		+= dio/
 obj-$(CONFIG_SBUS)		+= sbus/
 obj-$(CONFIG_ZORRO)		+= zorro/
 obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
-obj-$(CONFIG_PARIDE) 		+= block/paride/
+obj-y		 		+= block/paride/
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB_PHY)		+= usb/
 obj-$(CONFIG_USB)		+= usb/
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index eceaec33af65..fb646480635c 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1162,6 +1162,20 @@ config PATA_WINBOND_VLB
 	  Support for the Winbond W83759A controller on Vesa Local Bus
 	  systems.
 
+config PATA_PARPORT
+	tristate "Parallel port IDE device support"
+	depends on PARPORT_PC && PARIDE=n
+	help
+	  There are many external CD-ROM and disk devices that connect through
+	  your computer's parallel port. Most of them are actually IDE devices
+	  using a parallel port IDE adapter. This option enables the
+	  PATA_PARPORT subsystem which contains drivers for many of these
+	  external drives.
+	  Read <file:Documentation/admin-guide/blockdev/paride.rst> for more
+	  information.
+
+	  Use the old PARIDE protocol modules.
+
 comment "Generic fallback / legacy drivers"
 
 config PATA_ACPI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index d2e36d367274..23588738cff0 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -114,6 +114,8 @@ obj-$(CONFIG_PATA_SAMSUNG_CF)	+= pata_samsung_cf.o
 
 obj-$(CONFIG_PATA_PXA)		+= pata_pxa.o
 
+obj-$(CONFIG_PATA_PARPORT)	+= pata_parport.o
+
 # Should be last but two libata driver
 obj-$(CONFIG_PATA_ACPI)		+= pata_acpi.o
 # Should be last but one libata driver
diff --git a/drivers/ata/pata_parport.c b/drivers/ata/pata_parport.c
new file mode 100644
index 000000000000..1c583e54d083
--- /dev/null
+++ b/drivers/ata/pata_parport.c
@@ -0,0 +1,783 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Ondrej Zary
+ * based on paride.c by Grant R. Guenther <grant@torque.net>
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/parport.h>
+#include <linux/pata_parport.h>
+
+#define DRV_NAME "pata_parport"
+
+static DEFINE_IDR(parport_list);
+static DEFINE_IDR(protocols);
+static DEFINE_IDA(pata_parport_bus_dev_ids);
+static DEFINE_MUTEX(pi_mutex);
+
+static bool probe = true;
+module_param(probe, bool, 0644);
+MODULE_PARM_DESC(probe, "Enable automatic device probing (0=off, 1=on [default])");
+
+static bool verbose;
+module_param(verbose, bool, 0644);
+MODULE_PARM_DESC(verbose, "Enable verbose messages (0=off [default], 1=on)");
+
+#define DISCONNECT_TIMEOUT	(HZ / 10)
+
+/* libata drivers cannot sleep so this driver claims parport before activating
+ * the ata host and keeps it claimed (and protocol connected) until the ata
+ * host is removed. Unfortunately, this means that you cannot use any chained
+ * devices (neither other pata_parport devices nor a printer).
+ */
+static void pi_connect(struct pi_adapter *pi)
+{
+	parport_claim_or_block(pi->pardev);
+	pi->proto->connect(pi);
+}
+
+static void pi_disconnect(struct pi_adapter *pi)
+{
+	pi->proto->disconnect(pi);
+	parport_release(pi->pardev);
+}
+
+/* functions taken from libata-sff.c and converted from direct port I/O */
+static void pata_parport_dev_select(struct ata_port *ap, unsigned int device)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+	u8 tmp;
+
+	if (device == 0)
+		tmp = ATA_DEVICE_OBS;
+	else
+		tmp = ATA_DEVICE_OBS | ATA_DEV1;
+
+	pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tmp);
+	ata_sff_pause(ap);
+}
+
+static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+	u8 nsect, lbal;
+
+	pata_parport_dev_select(ap, device);
+
+	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0x55);
+	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
+
+	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0xaa);
+	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0x55);
+
+	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 055);
+	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
+
+	nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
+	lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
+
+	if ((nsect == 0x55) && (lbal == 0xaa))
+		return true;	/* we found a device */
+
+	return false;		/* nothing found */
+}
+
+static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
+				      unsigned long deadline)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+
+	/* software reset.  causes dev0 to be selected */
+	pi->proto->write_regr(pi, 1, 6, ap->ctl);
+	udelay(20);
+	pi->proto->write_regr(pi, 1, 6, ap->ctl | ATA_SRST);
+	udelay(20);
+	pi->proto->write_regr(pi, 1, 6, ap->ctl);
+	ap->last_ctl = ap->ctl;
+
+	/* wait the port to become ready */
+	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
+}
+
+static int pata_parport_softreset(struct ata_link *link, unsigned int *classes,
+				  unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	unsigned int devmask = 0;
+	int rc;
+	u8 err;
+
+	/* determine if device 0/1 are present */
+	if (pata_parport_devchk(ap, 0))
+		devmask |= (1 << 0);
+	if (pata_parport_devchk(ap, 1))
+		devmask |= (1 << 1);
+
+	/* select device 0 again */
+	pata_parport_dev_select(ap, 0);
+
+	/* issue bus reset */
+	rc = pata_parport_bus_softreset(ap, devmask, deadline);
+	if (rc && rc != -ENODEV) {
+		ata_link_err(link, "SRST failed (errno=%d)\n", rc);
+		return rc;
+	}
+
+	/* determine by signature whether we have ATA or ATAPI devices */
+	classes[0] = ata_sff_dev_classify(&link->device[0],
+					  devmask & (1 << 0), &err);
+	if (err != 0x81)
+		classes[1] = ata_sff_dev_classify(&link->device[1],
+						  devmask & (1 << 1), &err);
+
+	return 0;
+}
+
+static u8 pata_parport_check_status(struct ata_port *ap)
+{
+	u8 status;
+	struct pi_adapter *pi = ap->host->private_data;
+
+	status = pi->proto->read_regr(pi, 0, ATA_REG_STATUS);
+
+	return status;
+}
+
+static u8 pata_parport_check_altstatus(struct ata_port *ap)
+{
+	u8 altstatus;
+	struct pi_adapter *pi = ap->host->private_data;
+
+	altstatus = pi->proto->read_regr(pi, 1, 6);
+
+	return altstatus;
+}
+
+static void pata_parport_tf_load(struct ata_port *ap,
+				 const struct ata_taskfile *tf)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+
+	if (tf->ctl != ap->last_ctl) {
+		pi->proto->write_regr(pi, 1, 6, tf->ctl);
+		ap->last_ctl = tf->ctl;
+		ata_wait_idle(ap);
+	}
+
+	if (tf->flags & ATA_TFLAG_ISADDR) {
+		if (tf->flags & ATA_TFLAG_LBA48) {
+			pi->proto->write_regr(pi, 0, ATA_REG_FEATURE,
+					      tf->hob_feature);
+			pi->proto->write_regr(pi, 0, ATA_REG_NSECT,
+					      tf->hob_nsect);
+			pi->proto->write_regr(pi, 0, ATA_REG_LBAL,
+					      tf->hob_lbal);
+			pi->proto->write_regr(pi, 0, ATA_REG_LBAM,
+					      tf->hob_lbam);
+			pi->proto->write_regr(pi, 0, ATA_REG_LBAH,
+					      tf->hob_lbah);
+		}
+		pi->proto->write_regr(pi, 0, ATA_REG_FEATURE, tf->feature);
+		pi->proto->write_regr(pi, 0, ATA_REG_NSECT, tf->nsect);
+		pi->proto->write_regr(pi, 0, ATA_REG_LBAL, tf->lbal);
+		pi->proto->write_regr(pi, 0, ATA_REG_LBAM, tf->lbam);
+		pi->proto->write_regr(pi, 0, ATA_REG_LBAH, tf->lbah);
+	}
+
+	if (tf->flags & ATA_TFLAG_DEVICE)
+		pi->proto->write_regr(pi, 0, ATA_REG_DEVICE, tf->device);
+
+	ata_wait_idle(ap);
+}
+
+static void pata_parport_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+
+	tf->status = pi->proto->read_regr(pi, 0, ATA_REG_STATUS);
+	tf->error = pi->proto->read_regr(pi, 0, ATA_REG_ERR);
+	tf->nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
+	tf->lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
+	tf->lbam = pi->proto->read_regr(pi, 0, ATA_REG_LBAM);
+	tf->lbah = pi->proto->read_regr(pi, 0, ATA_REG_LBAH);
+	tf->device = pi->proto->read_regr(pi, 0, ATA_REG_DEVICE);
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		pi->proto->write_regr(pi, 1, 6, tf->ctl | ATA_HOB);
+		tf->hob_feature = pi->proto->read_regr(pi, 0, ATA_REG_ERR);
+		tf->hob_nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
+		tf->hob_lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
+		tf->hob_lbam = pi->proto->read_regr(pi, 0, ATA_REG_LBAM);
+		tf->hob_lbah = pi->proto->read_regr(pi, 0, ATA_REG_LBAH);
+		pi->proto->write_regr(pi, 1, 6, tf->ctl);
+		ap->last_ctl = tf->ctl;
+	}
+}
+
+static void pata_parport_exec_command(struct ata_port *ap,
+				      const struct ata_taskfile *tf)
+{
+	struct pi_adapter *pi = ap->host->private_data;
+
+	pi->proto->write_regr(pi, 0, ATA_REG_CMD, tf->command);
+	ata_sff_pause(ap);
+}
+
+static unsigned int pata_parport_data_xfer(struct ata_queued_cmd *qc,
+				unsigned char *buf, unsigned int buflen, int rw)
+{
+	struct ata_port *ap = qc->dev->link->ap;
+	struct pi_adapter *pi = ap->host->private_data;
+
+	if (rw == READ)
+		pi->proto->read_block(pi, buf, buflen);
+	else
+		pi->proto->write_block(pi, buf, buflen);
+
+	return buflen;
+}
+
+static void pata_parport_drain_fifo(struct ata_queued_cmd *qc)
+{
+	int count;
+	struct ata_port *ap;
+	struct pi_adapter *pi;
+	char junk[2];
+
+	/* We only need to flush incoming data when a command was running */
+	if (qc == NULL || qc->dma_dir == DMA_TO_DEVICE)
+		return;
+
+	ap = qc->ap;
+	pi = ap->host->private_data;
+	/* Drain up to 64K of data before we give up this recovery method */
+	for (count = 0; (pata_parport_check_status(ap) & ATA_DRQ)
+						&& count < 65536; count += 2) {
+		pi->proto->read_block(pi, junk, 2);
+	}
+
+	if (count)
+		ata_port_dbg(ap, "drained %d bytes to clear DRQ\n", count);
+}
+
+static struct ata_port_operations pata_parport_port_ops = {
+	.inherits		= &ata_sff_port_ops,
+
+	.softreset		= pata_parport_softreset,
+	.hardreset		= NULL,
+
+	.sff_dev_select		= pata_parport_dev_select,
+	.sff_check_status	= pata_parport_check_status,
+	.sff_check_altstatus	= pata_parport_check_altstatus,
+	.sff_tf_load		= pata_parport_tf_load,
+	.sff_tf_read		= pata_parport_tf_read,
+	.sff_exec_command	= pata_parport_exec_command,
+	.sff_data_xfer		= pata_parport_data_xfer,
+	.sff_drain_fifo		= pata_parport_drain_fifo,
+};
+
+static const struct ata_port_info pata_parport_port_info = {
+	.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_POLLING,
+	.pio_mask	= ATA_PIO0,
+	/* No DMA */
+	.port_ops	= &pata_parport_port_ops,
+};
+
+static void pi_release(struct pi_adapter *pi)
+{
+	parport_unregister_device(pi->pardev);
+	if (pi->proto->release_proto)
+		pi->proto->release_proto(pi);
+	module_put(pi->proto->owner);
+}
+
+static int default_test_proto(struct pi_adapter *pi, char *scratch)
+{
+	int j, k;
+	int e[2] = { 0, 0 };
+
+	pi->proto->connect(pi);
+
+	for (j = 0; j < 2; j++) {
+		pi->proto->write_regr(pi, 0, 6, 0xa0 + j * 0x10);
+		for (k = 0; k < 256; k++) {
+			pi->proto->write_regr(pi, 0, 2, k ^ 0xaa);
+			pi->proto->write_regr(pi, 0, 3, k ^ 0x55);
+			if (pi->proto->read_regr(pi, 0, 2) != (k ^ 0xaa))
+				e[j]++;
+		}
+	}
+	pi->proto->disconnect(pi);
+
+	if (verbose)
+		dev_info(&pi->dev, "%s: port 0x%x, mode %d, test=(%d,%d)\n",
+		       pi->proto->name, pi->port,
+		       pi->mode, e[0], e[1]);
+
+	return e[0] && e[1];	/* not here if both > 0 */
+}
+
+static int pi_test_proto(struct pi_adapter *pi, char *scratch)
+{
+	int res;
+
+	parport_claim_or_block(pi->pardev);
+	if (pi->proto->test_proto)
+		res = pi->proto->test_proto(pi, scratch, verbose);
+	else
+		res = default_test_proto(pi, scratch);
+	parport_release(pi->pardev);
+
+	return res;
+}
+
+static bool pi_probe_mode(struct pi_adapter *pi, int max, char *scratch)
+{
+	int best, range;
+
+	if (pi->mode != -1) {
+		if (pi->mode >= max)
+			return false;
+		range = 3;
+		if (pi->mode >= pi->proto->epp_first)
+			range = 8;
+		if (range == 8 && pi->port % 8)
+			return false;
+		return !pi_test_proto(pi, scratch);
+	}
+	best = -1;
+	for (pi->mode = 0; pi->mode < max; pi->mode++) {
+		range = 3;
+		if (pi->mode >= pi->proto->epp_first)
+			range = 8;
+		if (range == 8 && pi->port % 8)
+			break;
+		if (!pi_test_proto(pi, scratch))
+			best = pi->mode;
+	}
+	pi->mode = best;
+	return best > -1;
+}
+
+static bool pi_probe_unit(struct pi_adapter *pi, int unit, char *scratch)
+{
+	int max, s, e;
+
+	s = unit;
+	e = s + 1;
+
+	if (s == -1) {
+		s = 0;
+		e = pi->proto->max_units;
+	}
+
+	if (pi->proto->test_port) {
+		parport_claim_or_block(pi->pardev);
+		max = pi->proto->test_port(pi);
+		parport_release(pi->pardev);
+	} else {
+		max = pi->proto->max_mode;
+	}
+
+	if (pi->proto->probe_unit) {
+		parport_claim_or_block(pi->pardev);
+		for (pi->unit = s; pi->unit < e; pi->unit++) {
+			if (pi->proto->probe_unit(pi)) {
+				parport_release(pi->pardev);
+				return pi_probe_mode(pi, max, scratch);
+			}
+		}
+		parport_release(pi->pardev);
+		return false;
+	}
+
+	return pi_probe_mode(pi, max, scratch);
+}
+
+static void pata_parport_dev_release(struct device *dev)
+{
+	struct pi_adapter *pi = container_of(dev, struct pi_adapter, dev);
+
+	kfree(pi);
+}
+
+static void pata_parport_bus_release(struct device *dev)
+{
+	/* nothing to do here but required to avoid warning on device removal */
+}
+
+static struct bus_type pata_parport_bus_type = {
+	.name = DRV_NAME,
+};
+
+static struct device pata_parport_bus = {
+	.init_name = DRV_NAME,
+	.release = pata_parport_bus_release,
+};
+
+/* temporary for old paride protocol modules */
+static struct scsi_host_template pata_parport_sht = {
+	PATA_PARPORT_SHT("pata_parport")
+};
+
+struct pi_device_match {
+	struct parport *parport;
+	struct pi_protocol *proto;
+};
+
+static int pi_find_dev(struct device *dev, void *data)
+{
+	struct pi_adapter *pi = container_of(dev, struct pi_adapter, dev);
+	struct pi_device_match *match = data;
+
+	return pi->pardev->port == match->parport && pi->proto == match->proto;
+}
+
+static struct pi_adapter *pi_init_one(struct parport *parport,
+			struct pi_protocol *pr, int mode, int unit, int delay)
+{
+	struct pardev_cb par_cb = { };
+	char scratch[512];
+	const struct ata_port_info *ppi[] = { &pata_parport_port_info };
+	struct ata_host *host;
+	struct pi_adapter *pi;
+	struct pi_device_match match = { .parport = parport, .proto = pr };
+
+	/*
+	 * Abort if there's a device already registered on the same parport
+	 * using the same protocol.
+	 */
+	if (bus_for_each_dev(&pata_parport_bus_type, NULL, &match, pi_find_dev))
+		return NULL;
+
+	pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
+	if (!pi)
+		return NULL;
+
+	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
+	pi->dev.parent = &pata_parport_bus;
+	pi->dev.bus = &pata_parport_bus_type;
+	pi->dev.driver = &pr->driver;
+	pi->dev.release = pata_parport_dev_release;
+	pi->dev.id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
+	if (pi->dev.id < 0)
+		return NULL; /* pata_parport_dev_release will do kfree(pi) */
+	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
+	if (device_register(&pi->dev)) {
+		put_device(&pi->dev);
+		goto out_ida_free;
+	}
+
+	pi->proto = pr;
+
+	if (!try_module_get(pi->proto->owner))
+		goto out_unreg_dev;
+	if (pi->proto->init_proto && pi->proto->init_proto(pi) < 0)
+		goto out_module_put;
+
+	pi->delay = (delay == -1) ? pi->proto->default_delay : delay;
+	pi->mode = mode;
+	pi->port = parport->base;
+
+	par_cb.private = pi;
+	pi->pardev = parport_register_dev_model(parport, DRV_NAME, &par_cb,
+						pi->dev.id);
+	if (!pi->pardev)
+		goto out_module_put;
+
+	if (!pi_probe_unit(pi, unit, scratch)) {
+		dev_info(&pi->dev, "Adapter not found\n");
+		goto out_unreg_parport;
+	}
+
+	pi->proto->log_adapter(pi, scratch, verbose);
+
+	host = ata_host_alloc_pinfo(&pi->pardev->dev, ppi, 1);
+	if (!host)
+		goto out_unreg_parport;
+	dev_set_drvdata(&pi->dev, host);
+	host->private_data = pi;
+
+	ata_port_desc(host->ports[0], "port %s", pi->pardev->port->name);
+	ata_port_desc(host->ports[0], "protocol %s", pi->proto->name);
+
+	pi_connect(pi);
+	if (ata_host_activate(host, 0, NULL, 0, &pata_parport_sht))
+		goto out_unreg_parport;
+
+	return pi;
+
+out_unreg_parport:
+	pi_disconnect(pi);
+	parport_unregister_device(pi->pardev);
+	if (pi->proto->release_proto)
+		pi->proto->release_proto(pi);
+out_module_put:
+	module_put(pi->proto->owner);
+out_unreg_dev:
+	device_unregister(&pi->dev);
+out_ida_free:
+	ida_free(&pata_parport_bus_dev_ids, pi->dev.id);
+	return NULL;
+}
+
+int pata_parport_register_driver(struct pi_protocol *pr)
+{
+	int error;
+	struct parport *parport;
+	int port_num;
+
+	pr->driver.bus = &pata_parport_bus_type;
+	pr->driver.name = pr->name;
+	error = driver_register(&pr->driver);
+	if (error)
+		return error;
+
+	mutex_lock(&pi_mutex);
+	error = idr_alloc(&protocols, pr, 0, 0, GFP_KERNEL);
+	if (error < 0) {
+		driver_unregister(&pr->driver);
+		mutex_unlock(&pi_mutex);
+		return error;
+	}
+
+	pr_info("pata_parport: protocol %s registered\n", pr->name);
+
+	if (probe) {
+		/* probe all parports using this protocol */
+		idr_for_each_entry(&parport_list, parport, port_num)
+			pi_init_one(parport, pr, -1, 0, -1);
+	}
+	mutex_unlock(&pi_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(pata_parport_register_driver);
+
+void pata_parport_unregister_driver(struct pi_protocol *pr)
+{
+	struct pi_protocol *pr_iter;
+	int id = -1;
+
+	mutex_lock(&pi_mutex);
+	idr_for_each_entry(&protocols, pr_iter, id) {
+		if (pr_iter == pr)
+			break;
+	}
+	idr_remove(&protocols, id);
+	mutex_unlock(&pi_mutex);
+	driver_unregister(&pr->driver);
+}
+EXPORT_SYMBOL(pata_parport_unregister_driver);
+
+static ssize_t new_device_store(struct bus_type *bus, const char *buf,
+				size_t count)
+{
+	char port[12] = "auto";
+	char protocol[8] = "auto";
+	int mode = -1, unit = -1, delay = -1;
+	struct pi_protocol *pr, *pr_wanted;
+	struct device_driver *drv;
+	struct parport *parport;
+	int port_num, port_wanted, pr_num;
+	bool ok = false;
+
+	if (sscanf(buf, "%11s %7s %d %d %d",
+			port, protocol, &mode, &unit, &delay) < 1)
+		return -EINVAL;
+
+	if (sscanf(port, "parport%u", &port_wanted) < 1) {
+		if (!strcmp(port, "auto")) {
+			port_wanted = -1;
+		} else {
+			pr_err("invalid port name %s\n", port);
+			return -EINVAL;
+		}
+	}
+
+	drv = driver_find(protocol, &pata_parport_bus_type);
+	if (!drv) {
+		if (!strcmp(protocol, "auto")) {
+			pr_wanted = NULL;
+		} else {
+			pr_err("protocol %s not found\n", protocol);
+			return -EINVAL;
+		}
+	} else {
+		pr_wanted = container_of(drv, struct pi_protocol, driver);
+	}
+
+	mutex_lock(&pi_mutex);
+	/* walk all parports */
+	idr_for_each_entry(&parport_list, parport, port_num) {
+		if (port_num == port_wanted || port_wanted == -1) {
+			parport = parport_find_number(port_num);
+			if (!parport) {
+				pr_err("no such port %s\n", port);
+				mutex_unlock(&pi_mutex);
+				return -ENODEV;
+			}
+			/* walk all protocols */
+			idr_for_each_entry(&protocols, pr, pr_num) {
+				if (pr == pr_wanted || !pr_wanted)
+					if (pi_init_one(parport, pr, mode, unit,
+							delay))
+						ok = true;
+			}
+			parport_put_port(parport);
+		}
+	}
+	mutex_unlock(&pi_mutex);
+	if (!ok)
+		return -ENODEV;
+
+	return count;
+}
+static BUS_ATTR_WO(new_device);
+
+static void pi_remove_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct pi_adapter *pi = host->private_data;
+
+	ata_host_detach(host);
+	pi_disconnect(pi);
+	pi_release(pi);
+	device_unregister(dev);
+	ida_free(&pata_parport_bus_dev_ids, dev->id);
+	/* pata_parport_dev_release will do kfree(pi) */
+}
+
+static ssize_t delete_device_store(struct bus_type *bus, const char *buf,
+				   size_t count)
+{
+	struct device *dev;
+	char device_name[32];
+
+	if (sscanf(buf, "%31s", device_name) < 1)
+		return -EINVAL;
+
+	mutex_lock(&pi_mutex);
+	dev = bus_find_device_by_name(bus, NULL, device_name);
+	if (!dev) {
+		mutex_unlock(&pi_mutex);
+		return -ENODEV;
+	}
+
+	pi_remove_one(dev);
+	mutex_unlock(&pi_mutex);
+
+	return count;
+}
+static BUS_ATTR_WO(delete_device);
+
+static void pata_parport_attach(struct parport *port)
+{
+	struct pi_protocol *pr;
+	int pr_num, id;
+
+	mutex_lock(&pi_mutex);
+	id = idr_alloc(&parport_list, port, port->number, port->number,
+		       GFP_KERNEL);
+	if (id < 0) {
+		mutex_unlock(&pi_mutex);
+		return;
+	}
+
+	if (probe) {
+		/* probe this port using all protocols */
+		idr_for_each_entry(&protocols, pr, pr_num)
+			pi_init_one(port, pr, -1, 0, -1);
+	}
+	mutex_unlock(&pi_mutex);
+}
+
+static int pi_remove_port(struct device *dev, void *p)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct pi_adapter *pi = host->private_data;
+
+	if (pi->pardev->port == p)
+		pi_remove_one(dev);
+
+	return 0;
+}
+
+static void pata_parport_detach(struct parport *port)
+{
+	mutex_lock(&pi_mutex);
+	bus_for_each_dev(&pata_parport_bus_type, NULL, port, pi_remove_port);
+	idr_remove(&parport_list, port->number);
+	mutex_unlock(&pi_mutex);
+}
+
+static struct parport_driver pata_parport_driver = {
+	.name = DRV_NAME,
+	.match_port = pata_parport_attach,
+	.detach = pata_parport_detach,
+	.devmodel = true,
+};
+
+static __init int pata_parport_init(void)
+{
+	int error;
+
+	error = bus_register(&pata_parport_bus_type);
+	if (error) {
+		pr_err("failed to register pata_parport bus, error: %d\n", error);
+		return error;
+	}
+
+	error = device_register(&pata_parport_bus);
+	if (error) {
+		pr_err("failed to register pata_parport bus, error: %d\n", error);
+		goto out_unregister_bus;
+	}
+
+	error = bus_create_file(&pata_parport_bus_type, &bus_attr_new_device);
+	if (error) {
+		pr_err("unable to create sysfs file, error: %d\n", error);
+		goto out_unregister_dev;
+	}
+
+	error = bus_create_file(&pata_parport_bus_type, &bus_attr_delete_device);
+	if (error) {
+		pr_err("unable to create sysfs file, error: %d\n", error);
+		goto out_remove_new;
+	}
+
+	error = parport_register_driver(&pata_parport_driver);
+	if (error) {
+		pr_err("unable to register parport driver, error: %d\n", error);
+		goto out_remove_del;
+	}
+
+	return 0;
+
+out_remove_del:
+	bus_remove_file(&pata_parport_bus_type, &bus_attr_delete_device);
+out_remove_new:
+	bus_remove_file(&pata_parport_bus_type, &bus_attr_new_device);
+out_unregister_dev:
+	device_unregister(&pata_parport_bus);
+out_unregister_bus:
+	bus_unregister(&pata_parport_bus_type);
+	return error;
+}
+
+static __exit void pata_parport_exit(void)
+{
+	parport_unregister_driver(&pata_parport_driver);
+	bus_remove_file(&pata_parport_bus_type, &bus_attr_new_device);
+	bus_remove_file(&pata_parport_bus_type, &bus_attr_delete_device);
+	device_unregister(&pata_parport_bus);
+	bus_unregister(&pata_parport_bus_type);
+}
+
+MODULE_AUTHOR("Ondrej Zary");
+MODULE_DESCRIPTION("driver for parallel port ATA adapters");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("paride");
+
+module_init(pata_parport_init);
+module_exit(pata_parport_exit);
diff --git a/drivers/block/paride/Kconfig b/drivers/block/paride/Kconfig
index a295634597ba..01e4ef3655c1 100644
--- a/drivers/block/paride/Kconfig
+++ b/drivers/block/paride/Kconfig
@@ -92,11 +92,11 @@ config PARIDE_PG
 	  later fully support this driver.
 
 comment "Parallel IDE protocol modules"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 
 config PARIDE_ATEN
 	tristate "ATEN EH-100 protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the ATEN EH-100 parallel port IDE
 	  protocol. This protocol is used in some inexpensive low performance
@@ -109,7 +109,7 @@ config PARIDE_ATEN
 
 config PARIDE_BPCK
 	tristate "MicroSolutions backpack (Series 5) protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the Micro Solutions BACKPACK
 	  parallel port Series 5 IDE protocol.  (Most BACKPACK drives made
@@ -127,7 +127,7 @@ config PARIDE_BPCK
 
 config PARIDE_BPCK6
 	tristate "MicroSolutions backpack (Series 6) protocol"
-	depends on PARIDE && !64BIT
+	depends on (PARIDE || PATA_PARPORT) && !64BIT
 	help
 	  This option enables support for the Micro Solutions BACKPACK
 	  parallel port Series 6 IDE protocol.  (Most BACKPACK drives made
@@ -146,7 +146,7 @@ config PARIDE_BPCK6
 
 config PARIDE_COMM
 	tristate "DataStor Commuter protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the Commuter parallel port IDE
 	  protocol from DataStor. If you chose to build PARIDE support
@@ -157,7 +157,7 @@ config PARIDE_COMM
 
 config PARIDE_DSTR
 	tristate "DataStor EP-2000 protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the EP-2000 parallel port IDE
 	  protocol from DataStor. If you chose to build PARIDE support
@@ -168,7 +168,7 @@ config PARIDE_DSTR
 
 config PARIDE_FIT2
 	tristate "FIT TD-2000 protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the TD-2000 parallel port IDE
 	  protocol from Fidelity International Technology. This is a simple
@@ -181,7 +181,7 @@ config PARIDE_FIT2
 
 config PARIDE_FIT3
 	tristate "FIT TD-3000 protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the TD-3000 parallel port IDE
 	  protocol from Fidelity International Technology. This protocol is
@@ -194,7 +194,7 @@ config PARIDE_FIT3
 
 config PARIDE_EPAT
 	tristate "Shuttle EPAT/EPEZ protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the EPAT parallel port IDE protocol.
 	  EPAT is a parallel port IDE adapter manufactured by Shuttle
@@ -216,7 +216,7 @@ config PARIDE_EPATC8
 
 config PARIDE_EPIA
 	tristate "Shuttle EPIA protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the (obsolete) EPIA parallel port
 	  IDE protocol from Shuttle Technology. This adapter can still be
@@ -228,7 +228,7 @@ config PARIDE_EPIA
 
 config PARIDE_FRIQ
 	tristate "Freecom IQ ASIC-2 protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for version 2 of the Freecom IQ parallel
 	  port IDE adapter.  This adapter is used by the Maxell Superdisk
@@ -240,7 +240,7 @@ config PARIDE_FRIQ
 
 config PARIDE_FRPW
 	tristate "FreeCom power protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the Freecom power parallel port IDE
 	  protocol. If you chose to build PARIDE support into your kernel, you
@@ -251,7 +251,7 @@ config PARIDE_FRPW
 
 config PARIDE_KBIC
 	tristate "KingByte KBIC-951A/971A protocols"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the KBIC-951A and KBIC-971A parallel
 	  port IDE protocols from KingByte Information Corp. KingByte's
@@ -264,7 +264,7 @@ config PARIDE_KBIC
 
 config PARIDE_KTTI
 	tristate "KT PHd protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the "PHd" parallel port IDE protocol
 	  from KT Technology. This is a simple (low speed) adapter that is
@@ -277,7 +277,7 @@ config PARIDE_KTTI
 
 config PARIDE_ON20
 	tristate "OnSpec 90c20 protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the (obsolete) 90c20 parallel port
 	  IDE protocol from OnSpec (often marketed under the ValuStore brand
@@ -289,7 +289,7 @@ config PARIDE_ON20
 
 config PARIDE_ON26
 	tristate "OnSpec 90c26 protocol"
-	depends on PARIDE
+	depends on PARIDE || PATA_PARPORT
 	help
 	  This option enables support for the 90c26 parallel port IDE protocol
 	  from OnSpec Electronics (often marketed under the ValuStore brand
diff --git a/drivers/block/paride/paride.h b/drivers/block/paride/paride.h
index ddb9e589da7f..24dcfadb782d 100644
--- a/drivers/block/paride/paride.h
+++ b/drivers/block/paride/paride.h
@@ -1,3 +1,15 @@
+/*
+ * The low-level protocol modules are used by either paride or pata_parport.
+ * These two are mutually exclusive because the compiled low-level protocol
+ * modules are not compatible.
+ * When PATA_PARPORT is enabled, include pata_parport.h instead of the rest
+ * of this file.
+ */
+
+#if IS_ENABLED(CONFIG_PATA_PARPORT)
+#include <linux/pata_parport.h>
+
+#else
 #ifndef __DRIVERS_PARIDE_H__
 #define __DRIVERS_PARIDE_H__
 
@@ -170,3 +182,4 @@ void pi_unregister_driver(void *);
 
 #endif /* __DRIVERS_PARIDE_H__ */
 /* end of paride.h */
+#endif /* IS_ENABLED(CONFIG_PATA_PARPORT) */
diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
new file mode 100644
index 000000000000..913f49ff1fad
--- /dev/null
+++ b/include/linux/pata_parport.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *	pata_parport.h	(c) 1997-8  Grant R. Guenther <grant@torque.net>
+ *				    Under the terms of the GPL.
+ *
+ * This file defines the interface for parallel port IDE adapter chip drivers.
+ */
+
+#include <linux/libata.h>
+
+#define PI_PCD	1	/* dummy for paride protocol modules */
+
+struct pi_adapter {
+	struct device dev;
+	struct pi_protocol *proto;	/* adapter protocol */
+	int port;			/* base address of parallel port */
+	int mode;			/* transfer mode in use */
+	int delay;			/* adapter delay setting */
+	int devtype;			/* dummy for paride protocol modules */
+	char *device;			/* dummy for paride protocol modules */
+	int unit;			/* unit number for chained adapters */
+	int saved_r0;			/* saved port state */
+	int saved_r2;			/* saved port state */
+	unsigned long private;		/* for protocol module */
+	struct pardevice *pardev;	/* pointer to pardevice */
+};
+
+typedef struct pi_adapter PIA;	/* for paride protocol modules */
+
+/* registers are addressed as (cont,regr)
+ *	cont: 0 for command register file, 1 for control register(s)
+ *	regr: 0-7 for register number.
+ */
+
+/* macros and functions exported to the protocol modules */
+#define delay_p			(pi->delay ? udelay(pi->delay) : (void)0)
+#define out_p(offs, byte)	do { outb(byte, pi->port + offs); delay_p; } while (0)
+#define in_p(offs)		(delay_p, inb(pi->port + offs))
+
+#define w0(byte)		out_p(0, byte)
+#define r0()			in_p(0)
+#define w1(byte)		out_p(1, byte)
+#define r1()			in_p(1)
+#define w2(byte)		out_p(2, byte)
+#define r2()			in_p(2)
+#define w3(byte)		out_p(3, byte)
+#define w4(byte)		out_p(4, byte)
+#define r4()			in_p(4)
+#define w4w(data)		do { outw(data, pi->port + 4); delay_p; } while (0)
+#define w4l(data)		do { outl(data, pi->port + 4); delay_p; } while (0)
+#define r4w()			(delay_p, inw(pi->port + 4))
+#define r4l()			(delay_p, inl(pi->port + 4))
+
+static inline u16 pi_swab16(char *b, int k)
+{
+	union { u16 u; char t[2]; } r;
+
+	r.t[0] = b[2 * k + 1]; r.t[1] = b[2 * k];
+	return r.u;
+}
+
+static inline u32 pi_swab32(char *b, int k)
+{
+	union { u32 u; char f[4]; } r;
+
+	r.f[0] = b[4 * k + 1]; r.f[1] = b[4 * k];
+	r.f[2] = b[4 * k + 3]; r.f[3] = b[4 * k + 2];
+	return r.u;
+}
+
+struct pi_protocol {
+	char name[8];
+
+	int max_mode;
+	int epp_first;		/* modes >= this use 8 ports */
+
+	int default_delay;
+	int max_units;		/* max chained units probed for */
+
+	void (*write_regr)(struct pi_adapter *pi, int cont, int regr, int val);
+	int (*read_regr)(struct pi_adapter *pi, int cont, int regr);
+	void (*write_block)(struct pi_adapter *pi, char *buf, int count);
+	void (*read_block)(struct pi_adapter *pi, char *buf, int count);
+
+	void (*connect)(struct pi_adapter *pi);
+	void (*disconnect)(struct pi_adapter *pi);
+
+	int (*test_port)(struct pi_adapter *pi);
+	int (*probe_unit)(struct pi_adapter *pi);
+	int (*test_proto)(struct pi_adapter *pi, char *scratch, int verbose);
+	void (*log_adapter)(struct pi_adapter *pi, char *scratch, int verbose);
+
+	int (*init_proto)(struct pi_adapter *pi);
+	void (*release_proto)(struct pi_adapter *pi);
+	struct module *owner;
+	struct device_driver driver;
+	struct scsi_host_template sht;
+};
+
+#define PATA_PARPORT_SHT ATA_PIO_SHT
+
+int pata_parport_register_driver(struct pi_protocol *pr);
+void pata_parport_unregister_driver(struct pi_protocol *pr);
+/* defines for old paride protocol modules */
+#define paride_register pata_parport_register_driver
+#define paride_unregister pata_parport_unregister_driver
-- 
Ondrej Zary

