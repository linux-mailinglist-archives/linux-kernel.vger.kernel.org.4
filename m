Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAA740DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjF1JuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjF1J00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A572944;
        Wed, 28 Jun 2023 02:25:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF6F16123C;
        Wed, 28 Jun 2023 09:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A307BC433C0;
        Wed, 28 Jun 2023 09:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687944332;
        bh=eBWpOjj/wIeSHV9uxw/iNaFb3ABua3ZnQ4erBawo8BU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iu7KAsMVGDSCEitRJLb29pwqbzg71bXZclK5ZDTAtxJdRFHx6zLdmTQ/tjneDUXkk
         VrPxdrxmfkqC6oIp3GMmwPik4oACw11Jt4/mckGScllTSQXGh6OdythpKYXtedkQcD
         72IKjgb1TSceN+UNN2cZ3pfs49iJIU7btWfBAOAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.14.320
Date:   Wed, 28 Jun 2023 11:25:23 +0200
Message-ID: <2023062823-delegator-mandate-0cdf@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023062823-mulch-skeleton-4071@gregkh>
References: <2023062823-mulch-skeleton-4071@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 8581926e3401..62b3fec0a053 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 319
+SUBLEVEL = 320
 EXTRAVERSION =
 NAME = Petit Gorille
 
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 3bbf0dc5ecad..78d6f4bf117d 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -98,8 +98,14 @@
 				       (!!x)<<8 | 0x1f)
 
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
+#define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
+#define SYS_DC_IGDSW			sys_insn(1, 0, 7, 6, 6)
 #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
+#define SYS_DC_CGSW			sys_insn(1, 0, 7, 10, 4)
+#define SYS_DC_CGDSW			sys_insn(1, 0, 7, 10, 6)
 #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)
+#define SYS_DC_CIGSW			sys_insn(1, 0, 7, 14, 4)
+#define SYS_DC_CIGDSW			sys_insn(1, 0, 7, 14, 6)
 
 #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
 #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 98716a4be0a7..fb9abdfc364d 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -95,7 +95,10 @@ static void init_x2apic_ldr(void)
 
 static int x2apic_phys_probe(void)
 {
-	if (x2apic_mode && (x2apic_phys || x2apic_fadt_phys()))
+	if (!x2apic_mode)
+		return 0;
+
+	if (x2apic_phys || x2apic_fadt_phys())
 		return 1;
 
 	return apic == &apic_x2apic_phys;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 9effe40f5fa5..ddfcf22a883d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1387,7 +1387,7 @@ int exynos_g2d_exec_ioctl(struct drm_device *drm_dev, void *data,
 	/* Let the runqueue know that there is work to do. */
 	queue_work(g2d->g2d_workq, &g2d->runqueue_work);
 
-	if (runqueue_node->async)
+	if (req->async)
 		goto out;
 
 	wait_for_completion(&runqueue_node->complete);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 53e03f8af3d5..f36d4df4d481 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -480,8 +480,6 @@ static int vidi_remove(struct platform_device *pdev)
 	if (ctx->raw_edid != (struct edid *)fake_edid_info) {
 		kfree(ctx->raw_edid);
 		ctx->raw_edid = NULL;
-
-		return -EINVAL;
 	}
 
 	component_del(&pdev->dev, &vidi_component_ops);
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index ac467b80edc7..59ad0a4e2fd5 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -376,7 +376,6 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 	struct radeon_device *rdev = dev->dev_private;
 	struct drm_radeon_gem_set_domain *args = data;
 	struct drm_gem_object *gobj;
-	struct radeon_bo *robj;
 	int r;
 
 	/* for now if someone requests domain CPU -
@@ -389,13 +388,12 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 		up_read(&rdev->exclusive_lock);
 		return -ENOENT;
 	}
-	robj = gem_to_radeon_bo(gobj);
 
 	r = radeon_gem_set_domain(gobj, args->read_domains, args->write_domain);
 
 	drm_gem_object_put_unlocked(gobj);
 	up_read(&rdev->exclusive_lock);
-	r = radeon_gem_handle_lockup(robj->rdev, r);
+	r = radeon_gem_handle_lockup(rdev, r);
 	return r;
 }
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 3d521f289984..28e7a4950b74 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2251,8 +2251,13 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		goto fail_quirks;
 	}
 
-	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
+	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
 		error = hid_hw_open(hdev);
+		if (error) {
+			hid_err(hdev, "hw open failed\n");
+			goto fail_quirks;
+		}
+	}
 
 	wacom_set_shared_values(wacom_wac);
 	devres_close_group(&hdev->dev, wacom);
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index bd79d958f7d6..3f2641563a24 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -803,11 +803,22 @@ static void vmbus_wait_for_unload(void)
 		if (completion_done(&vmbus_connection.unload_event))
 			goto completed;
 
-		for_each_online_cpu(cpu) {
+		for_each_present_cpu(cpu) {
 			struct hv_per_cpu_context *hv_cpu
 				= per_cpu_ptr(hv_context.cpu_context, cpu);
 
+			/*
+			 * In a CoCo VM the synic_message_page is not allocated
+			 * in hv_synic_alloc(). Instead it is set/cleared in
+			 * hv_synic_enable_regs() and hv_synic_disable_regs()
+			 * such that it is set only when the CPU is online. If
+			 * not all present CPUs are online, the message page
+			 * might be NULL, so skip such CPUs.
+			 */
 			page_addr = hv_cpu->synic_message_page;
+			if (!page_addr)
+				continue;
+
 			msg = (struct hv_message *)page_addr
 				+ VMBUS_MESSAGE_SINT;
 
@@ -841,11 +852,14 @@ static void vmbus_wait_for_unload(void)
 	 * maybe-pending messages on all CPUs to be able to receive new
 	 * messages after we reconnect.
 	 */
-	for_each_online_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		page_addr = hv_cpu->synic_message_page;
+		if (!page_addr)
+			continue;
+
 		msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
 		msg->header.message_type = HVMSG_NONE;
 	}
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 511d332f4732..526f2f887129 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -215,8 +215,8 @@ static void lpi2c_imx_stop(struct lpi2c_imx_struct *lpi2c_imx)
 /* CLKLO = I2C_CLK_RATIO * CLKHI, SETHOLD = CLKHI, DATAVD = CLKHI/2 */
 static int lpi2c_imx_config(struct lpi2c_imx_struct *lpi2c_imx)
 {
-	u8 prescale, filt, sethold, clkhi, clklo, datavd;
-	unsigned int clk_rate, clk_cycle;
+	u8 prescale, filt, sethold, datavd;
+	unsigned int clk_rate, clk_cycle, clkhi, clklo;
 	enum lpi2c_imx_pincfg pincfg;
 	unsigned int temp;
 
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index e51a62cff5ec..3c77469df73b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1663,7 +1663,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		ret = -EINVAL;
+		ret = host->irq;
 		goto host_free;
 	}
 
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index f11245a0521c..1d3c668ab446 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1348,7 +1348,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENXIO;
+		return irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->virt_base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ea12712bd2c3..36e8f0be7051 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2023,9 +2023,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (res == NULL || irq < 0)
+	if (!res)
 		return -ENXIO;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index d27ee9eb2eac..27459eab0ed0 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1749,8 +1749,10 @@ static int usdhi6_probe(struct platform_device *pdev)
 	irq_cd = platform_get_irq_byname(pdev, "card detect");
 	irq_sd = platform_get_irq_byname(pdev, "data");
 	irq_sdio = platform_get_irq_byname(pdev, "SDIO");
-	if (irq_sd < 0 || irq_sdio < 0)
-		return -ENODEV;
+	if (irq_sd < 0)
+		return irq_sd;
+	if (irq_sdio < 0)
+		return irq_sdio;
 
 	mmc = mmc_alloc_host(sizeof(struct usdhi6_host), dev);
 	if (!mmc)
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 43ae124cabff..f8541d0c7bd5 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1129,8 +1129,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	eth_hdr_len = ntohs(skb->protocol) == ETH_P_8021Q ?
 						VLAN_ETH_HLEN : ETH_HLEN;
 	if (skb->len <= 60 &&
-	    (lancer_chip(adapter) || skb_vlan_tag_present(skb)) &&
-	    is_ipv4_pkt(skb)) {
+	    (lancer_chip(adapter) || BE3_chip(adapter) ||
+	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
 		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
 	}
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 1ca1f72474ab..0c454eeb3bd8 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -553,8 +553,7 @@ qcaspi_spi_thread(void *data)
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if ((qca->intr_req == qca->intr_svc) &&
-		    (qca->txr.skb[qca->txr.head] == NULL) &&
-		    (qca->sync == QCASPI_SYNC_READY))
+		    !qca->txr.skb[qca->txr.head])
 			schedule();
 
 		set_current_state(TASK_RUNNING);
diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index 533e3aa6275c..cf07b366500e 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -345,10 +345,6 @@ static struct dentry *nfcsim_debugfs_root;
 static void nfcsim_debugfs_init(void)
 {
 	nfcsim_debugfs_root = debugfs_create_dir("nfcsim", NULL);
-
-	if (!nfcsim_debugfs_root)
-		pr_err("Could not create debugfs entry\n");
-
 }
 
 static void nfcsim_debugfs_remove(void)
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index d2203cd17813..6721e984782d 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1357,6 +1357,7 @@ void ccw_device_set_notoper(struct ccw_device *cdev)
 enum io_sch_action {
 	IO_SCH_UNREG,
 	IO_SCH_ORPH_UNREG,
+	IO_SCH_UNREG_CDEV,
 	IO_SCH_ATTACH,
 	IO_SCH_UNREG_ATTACH,
 	IO_SCH_ORPH_ATTACH,
@@ -1389,7 +1390,7 @@ static enum io_sch_action sch_get_action(struct subchannel *sch)
 	}
 	if ((sch->schib.pmcw.pam & sch->opm) == 0) {
 		if (ccw_device_notify(cdev, CIO_NO_PATH) != NOTIFY_OK)
-			return IO_SCH_UNREG;
+			return IO_SCH_UNREG_CDEV;
 		return IO_SCH_DISC;
 	}
 	if (device_is_disconnected(cdev))
@@ -1451,6 +1452,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 	case IO_SCH_ORPH_ATTACH:
 		ccw_device_set_disconnected(cdev);
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 	case IO_SCH_UNREG:
 		if (!cdev)
@@ -1484,6 +1486,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 		if (rc)
 			goto out;
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 		spin_lock_irqsave(sch->lock, flags);
 		if (cdev->private->flags.resuming) {
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 07335357418c..d94f711afee0 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -1067,6 +1067,7 @@ int iscsi_target_locate_portal(
 	iscsi_target_set_sock_callbacks(conn);
 
 	login->np = np;
+	conn->tpg = NULL;
 
 	login_req = (struct iscsi_login_req *) login->req;
 	payload_length = ntoh24(login_req->dlength);
@@ -1136,7 +1137,6 @@ int iscsi_target_locate_portal(
 	 */
 	sessiontype = strncmp(s_buf, DISCOVERY, 9);
 	if (!sessiontype) {
-		conn->tpg = iscsit_global->discovery_tpg;
 		if (!login->leading_connection)
 			goto get_target;
 
@@ -1153,9 +1153,11 @@ int iscsi_target_locate_portal(
 		 * Serialize access across the discovery struct iscsi_portal_group to
 		 * process login attempt.
 		 */
+		conn->tpg = iscsit_global->discovery_tpg;
 		if (iscsit_access_np(np, conn->tpg) < 0) {
 			iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
 				ISCSI_LOGIN_STATUS_SVC_UNAVAILABLE);
+			conn->tpg = NULL;
 			ret = -1;
 			goto out;
 		}
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 22df94f107e5..3be36bcd69e0 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -263,6 +263,7 @@ lqasc_err_int(int irq, void *_port)
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
+	ltq_w32(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
 	/* clear any pending interrupts */
 	ltq_w32_mask(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
 		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
diff --git a/drivers/usb/gadget/udc/amd5536udc_pci.c b/drivers/usb/gadget/udc/amd5536udc_pci.c
index 73413c1211cb..8849fc3030bd 100644
--- a/drivers/usb/gadget/udc/amd5536udc_pci.c
+++ b/drivers/usb/gadget/udc/amd5536udc_pci.c
@@ -175,6 +175,9 @@ static int udc_pci_probe(
 		retval = -ENODEV;
 		goto err_probe;
 	}
+
+	udc = dev;
+
 	return 0;
 
 err_probe:
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index ecdcf358ad5e..6589d5f0a5a4 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1452,9 +1452,13 @@ static void init_imstt(struct fb_info *info)
 	              FBINFO_HWACCEL_FILLRECT |
 	              FBINFO_HWACCEL_YPAN;
 
-	fb_alloc_cmap(&info->cmap, 0, 0);
+	if (fb_alloc_cmap(&info->cmap, 0, 0)) {
+		framebuffer_release(info);
+		return -ENODEV;
+	}
 
 	if (register_framebuffer(info) < 0) {
+		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
 		return;
 	}
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 884c2452e60d..d67b711f9c0d 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -382,7 +382,15 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			struct page *page = pvec.pages[i];
 
 			lock_page(page);
-			nilfs_clear_dirty_page(page, silent);
+
+			/*
+			 * This page may have been removed from the address
+			 * space by truncation or invalidation when the lock
+			 * was acquired.  Skip processing in that case.
+			 */
+			if (likely(page->mapping == mapping))
+				nilfs_clear_dirty_page(page, silent);
+
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 6c5009cc4e6f..4d108707625a 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -110,6 +110,12 @@ int nilfs_segbuf_extend_segsum(struct nilfs_segment_buffer *segbuf)
 	if (unlikely(!bh))
 		return -ENOMEM;
 
+	lock_buffer(bh);
+	if (!buffer_uptodate(bh)) {
+		memset(bh->b_data, 0, bh->b_size);
+		set_buffer_uptodate(bh);
+	}
+	unlock_buffer(bh);
 	nilfs_segbuf_add_segsum_buffer(segbuf, bh);
 	return 0;
 }
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index bc0f8f837c37..6d297562b48d 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -997,10 +997,13 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 	unsigned int isz, srsz;
 
 	bh_sr = NILFS_LAST_SEGBUF(&sci->sc_segbufs)->sb_super_root;
+
+	lock_buffer(bh_sr);
 	raw_sr = (struct nilfs_super_root *)bh_sr->b_data;
 	isz = nilfs->ns_inode_size;
 	srsz = NILFS_SR_BYTES(isz);
 
+	raw_sr->sr_sum = 0;  /* Ensure initialization within this update */
 	raw_sr->sr_bytes = cpu_to_le16(srsz);
 	raw_sr->sr_nongc_ctime
 		= cpu_to_le64(nilfs_doing_gc() ?
@@ -1014,6 +1017,8 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 	nilfs_write_inode_common(nilfs->ns_sufile, (void *)raw_sr +
 				 NILFS_SR_SUFILE_OFFSET(isz), 1);
 	memset((void *)raw_sr + srsz, 0, nilfs->ns_blocksize - srsz);
+	set_buffer_uptodate(bh_sr);
+	unlock_buffer(bh_sr);
 }
 
 static void nilfs_redirty_inodes(struct list_head *head)
@@ -1791,6 +1796,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 	list_for_each_entry(segbuf, logs, sb_list) {
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
+			clear_buffer_uptodate(bh);
 			if (bh->b_page != bd_page) {
 				if (bd_page)
 					end_page_writeback(bd_page);
@@ -1802,6 +1808,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 				    b_assoc_buffers) {
 			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
+				clear_buffer_uptodate(bh);
 				if (bh->b_page != bd_page) {
 					end_page_writeback(bd_page);
 					bd_page = bh->b_page;
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 363cde0c77ee..e21a4f90934b 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -384,10 +384,31 @@ static int nilfs_move_2nd_super(struct super_block *sb, loff_t sb2off)
 		goto out;
 	}
 	nsbp = (void *)nsbh->b_data + offset;
-	memset(nsbp, 0, nilfs->ns_blocksize);
 
+	lock_buffer(nsbh);
 	if (sb2i >= 0) {
+		/*
+		 * The position of the second superblock only changes by 4KiB,
+		 * which is larger than the maximum superblock data size
+		 * (= 1KiB), so there is no need to use memmove() to allow
+		 * overlap between source and destination.
+		 */
 		memcpy(nsbp, nilfs->ns_sbp[sb2i], nilfs->ns_sbsize);
+
+		/*
+		 * Zero fill after copy to avoid overwriting in case of move
+		 * within the same block.
+		 */
+		memset(nsbh->b_data, 0, offset);
+		memset((void *)nsbp + nilfs->ns_sbsize, 0,
+		       nsbh->b_size - offset - nilfs->ns_sbsize);
+	} else {
+		memset(nsbh->b_data, 0, nsbh->b_size);
+	}
+	set_buffer_uptodate(nsbh);
+	unlock_buffer(nsbh);
+
+	if (sb2i >= 0) {
 		brelse(nilfs->ns_sbh[sb2i]);
 		nilfs->ns_sbh[sb2i] = nsbh;
 		nilfs->ns_sbp[sb2i] = nsbp;
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index aa1bd482da84..ec71a333f26a 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -384,6 +384,18 @@ unsigned long nilfs_nrsvsegs(struct the_nilfs *nilfs, unsigned long nsegs)
 				  100));
 }
 
+/**
+ * nilfs_max_segment_count - calculate the maximum number of segments
+ * @nilfs: nilfs object
+ */
+static u64 nilfs_max_segment_count(struct the_nilfs *nilfs)
+{
+	u64 max_count = U64_MAX;
+
+	do_div(max_count, nilfs->ns_blocks_per_segment);
+	return min_t(u64, max_count, ULONG_MAX);
+}
+
 void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 {
 	nilfs->ns_nsegments = nsegs;
@@ -393,6 +405,8 @@ void nilfs_set_nsegments(struct the_nilfs *nilfs, unsigned long nsegs)
 static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 				   struct nilfs_super_block *sbp)
 {
+	u64 nsegments, nblocks;
+
 	if (le32_to_cpu(sbp->s_rev_level) < NILFS_MIN_SUPP_REV) {
 		nilfs_msg(nilfs->ns_sb, KERN_ERR,
 			  "unsupported revision (superblock rev.=%d.%d, current rev.=%d.%d). Please check the version of mkfs.nilfs(2).",
@@ -439,7 +453,35 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 		return -EINVAL;
 	}
 
-	nilfs_set_nsegments(nilfs, le64_to_cpu(sbp->s_nsegments));
+	nsegments = le64_to_cpu(sbp->s_nsegments);
+	if (nsegments > nilfs_max_segment_count(nilfs)) {
+		nilfs_msg(nilfs->ns_sb, KERN_ERR,
+			  "segment count %llu exceeds upper limit (%llu segments)",
+			  (unsigned long long)nsegments,
+			  (unsigned long long)nilfs_max_segment_count(nilfs));
+		return -EINVAL;
+	}
+
+	nblocks = (u64)i_size_read(nilfs->ns_sb->s_bdev->bd_inode) >>
+		nilfs->ns_sb->s_blocksize_bits;
+	if (nblocks) {
+		u64 min_block_count = nsegments * nilfs->ns_blocks_per_segment;
+		/*
+		 * To avoid failing to mount early device images without a
+		 * second superblock, exclude that block count from the
+		 * "min_block_count" calculation.
+		 */
+
+		if (nblocks < min_block_count) {
+			nilfs_msg(nilfs->ns_sb, KERN_ERR,
+				  "total number of segment blocks %llu exceeds device size (%llu blocks)",
+				  (unsigned long long)min_block_count,
+				  (unsigned long long)nblocks);
+			return -EINVAL;
+		}
+	}
+
+	nilfs_set_nsegments(nilfs, nsegments);
 	nilfs->ns_crc_seed = le32_to_cpu(sbp->s_crc_seed);
 	return 0;
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4b835deab3d1..ac971e3f5a58 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1600,7 +1600,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 {
 	struct cgroup *dcgrp = &dst_root->cgrp;
 	struct cgroup_subsys *ss;
-	int ssid, i, ret;
+	int ssid, ret;
 	u16 dfl_disable_ss_mask = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
@@ -1644,7 +1644,8 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		struct cgroup_root *src_root = ss->root;
 		struct cgroup *scgrp = &src_root->cgrp;
 		struct cgroup_subsys_state *css = cgroup_css(scgrp, ss);
-		struct css_set *cset;
+		struct css_set *cset, *cset_pos;
+		struct css_task_iter *it;
 
 		WARN_ON(!css || cgroup_css(dcgrp, ss));
 
@@ -1662,9 +1663,22 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
-		hash_for_each(css_set_table, i, cset, hlist)
+		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
+		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
+					 e_cset_node[ss->id]) {
 			list_move_tail(&cset->e_cset_node[ss->id],
 				       &dcgrp->e_csets[ss->id]);
+			/*
+			 * all css_sets of scgrp together in same order to dcgrp,
+			 * patch in-flight iterators to preserve correct iteration.
+			 * since the iterator is always advanced right away and
+			 * finished when it->cset_pos meets it->cset_head, so only
+			 * update it->cset_head is enough here.
+			 */
+			list_for_each_entry(it, &cset->task_iters, iters_node)
+				if (it->cset_head == &scgrp->e_csets[ss->id])
+					it->cset_head = &dcgrp->e_csets[ss->id];
+		}
 		spin_unlock_irq(&css_set_lock);
 
 		/* default hierarchy doesn't enable controllers by default */
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 29b333a62ab0..5be59ccb61aa 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -268,6 +268,9 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 
 	secpath_reset(skb);
 
+	if (skb_needs_linearize(skb, skb->dev->features) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
 	return 0;
 }
 
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index a50d1943dd62..7c72b85c9339 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -304,6 +304,9 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 
 	secpath_reset(skb);
 
+	if (skb_needs_linearize(skb, skb->dev->features) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
 	return 0;
 }
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 241a3032d0e6..e091c552b0b9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4220,7 +4220,8 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 			return PTR_ERR(set);
 	}
 
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
@@ -4399,7 +4400,9 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 				   genmask);
 	if (IS_ERR(set))
 		return PTR_ERR(set);
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	if (nla[NFTA_SET_ELEM_LIST_ELEMENTS] == NULL) {
