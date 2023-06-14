Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4559472F97F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbjFNJk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244198AbjFNJj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2BB270C;
        Wed, 14 Jun 2023 02:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB3C463FCA;
        Wed, 14 Jun 2023 09:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19416C433C0;
        Wed, 14 Jun 2023 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686735523;
        bh=K1ElrOqVh0SQ/cgEEbenl3ln6UvQuqE9Cloif8TQAFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNu25bqcWS6caqftOlRorH9Uy02Hz8cyTYtsrSaQVtoiQukS8X2jcQauCYjV/8K1h
         tXw6iUHKuqeKJSt89h1XcfpcR4o+p1WeyycxXjvAneuMvbI5RaytfJARJe32wZXntL
         hf/heEF0mdCxhmFewCVM6aUfnWgdN+MmZ3yqVrsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.34
Date:   Wed, 14 Jun 2023 11:38:31 +0200
Message-ID: <2023061431-traps-oink-a198@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023061431-modular-data-8489@gregkh>
References: <2023061431-modular-data-8489@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/mm/page_table_check.rst b/Documentation/mm/page_table_check.rst
index 1a09472f10a3..d19ca356b7bf 100644
--- a/Documentation/mm/page_table_check.rst
+++ b/Documentation/mm/page_table_check.rst
@@ -54,3 +54,22 @@ Build kernel with:
 
 Optionally, build kernel with PAGE_TABLE_CHECK_ENFORCED in order to have page
 table support without extra kernel parameter.
+
+Implementation notes
+====================
+
+We specifically decided not to use VMA information in order to avoid relying on
+MM states (except for limited "struct page" info). The page table check is a
+separate from Linux-MM state machine that verifies that the user accessible
+pages are not falsely shared.
+
+PAGE_TABLE_CHECK depends on EXCLUSIVE_SYSTEM_RAM. The reason is that without
+EXCLUSIVE_SYSTEM_RAM, users are allowed to map arbitrary physical memory
+regions into the userspace via /dev/mem. At the same time, pages may change
+their properties (e.g., from anonymous pages to named pages) while they are
+still being mapped in the userspace, leading to "corruption" detected by the
+page table check.
+
+Even with EXCLUSIVE_SYSTEM_RAM, I/O pages may be still allowed to be mapped via
+/dev/mem. However, these pages are always considered as named pages, so they
+won't break the logic used in the page table check.
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 4ecb549fd052..3301288a7c69 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1247,8 +1247,8 @@ ping_group_range - 2 INTEGERS
 	Restrict ICMP_PROTO datagram sockets to users in the group range.
 	The default is "1 0", meaning, that nobody (not even root) may
 	create ping sockets.  Setting it to "100 100" would grant permissions
-	to the single group. "0 4294967295" would enable it for the world, "100
-	4294967295" would enable it for the users, but not daemons.
+	to the single group. "0 4294967294" would enable it for the world, "100
+	4294967294" would enable it for the users, but not daemons.
 
 tcp_early_demux - BOOLEAN
 	Enable early demux for established TCP sockets.
diff --git a/Makefile b/Makefile
index 6be79c5c934f..bc7cc17b0e75 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 33
+SUBLEVEL = 34
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 3b25c67795dd..4af8a1c96ed6 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -789,7 +789,7 @@ &sdmmc2 {
 };
 
 &shdwc {
-	atmel,shdwc-debouncer = <976>;
+	debounce-delay-us = <976>;
 	status = "okay";
 
 	input@0 {
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 60dc56d8acfb..437dd0352fd4 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -334,16 +334,14 @@ static bool at91_pm_eth_quirk_is_valid(struct at91_pm_quirk_eth *eth)
 		pdev = of_find_device_by_node(eth->np);
 		if (!pdev)
 			return false;
+		/* put_device(eth->dev) is called at the end of suspend. */
 		eth->dev = &pdev->dev;
 	}
 
 	/* No quirks if device isn't a wakeup source. */
-	if (!device_may_wakeup(eth->dev)) {
-		put_device(eth->dev);
+	if (!device_may_wakeup(eth->dev))
 		return false;
-	}
 
-	/* put_device(eth->dev) is called at the end of suspend. */
 	return true;
 }
 
@@ -439,14 +437,14 @@ static int at91_pm_config_quirks(bool suspend)
 				pr_err("AT91: PM: failed to enable %s clocks\n",
 				       j == AT91_PM_G_ETH ? "geth" : "eth");
 			}
-		} else {
-			/*
-			 * Release the reference to eth->dev taken in
-			 * at91_pm_eth_quirk_is_valid().
-			 */
-			put_device(eth->dev);
-			eth->dev = NULL;
 		}
+
+		/*
+		 * Release the reference to eth->dev taken in
+		 * at91_pm_eth_quirk_is_valid().
+		 */
+		put_device(eth->dev);
+		eth->dev = NULL;
 	}
 
 	return ret;
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index d7b4229bb4a2..9ad56aaf19b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -26,6 +26,8 @@ lpuart0: serial@5a060000 {
 		clocks = <&uart0_lpcg IMX_LPCG_CLK_4>,
 			 <&uart0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_0>;
 		status = "disabled";
 	};
@@ -36,6 +38,8 @@ lpuart1: serial@5a070000 {
 		clocks = <&uart1_lpcg IMX_LPCG_CLK_4>,
 			 <&uart1_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_UART_1 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_1>;
 		status = "disabled";
 	};
@@ -46,6 +50,8 @@ lpuart2: serial@5a080000 {
 		clocks = <&uart2_lpcg IMX_LPCG_CLK_4>,
 			 <&uart2_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_UART_2 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_2>;
 		status = "disabled";
 	};
@@ -56,6 +62,8 @@ lpuart3: serial@5a090000 {
 		clocks = <&uart3_lpcg IMX_LPCG_CLK_4>,
 			 <&uart3_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_UART_3 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <80000000>;
 		power-domains = <&pd IMX_SC_R_UART_3>;
 		status = "disabled";
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 9e82069c941f..5a1f7c30afe5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -81,7 +81,7 @@ sound {
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_espi2>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	eeprom@0 {
@@ -202,7 +202,7 @@ pinctrl_espi2: espi2grp {
 			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x82
 			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x82
 			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x82
-			MX8MN_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x41
+			MX8MN_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x41
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index ce9d3f0b98fc..607cd6b4e972 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -82,8 +82,8 @@ &usdhc2 {
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	bus-width = <4>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
-	cd-gpios = <&lsio_gpio4 22 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&lsio_gpio4 21 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&lsio_gpio5 22 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&lsio_gpio5 21 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
index d8ed1d7b4ec7..4b306a59d9be 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
@@ -16,3 +16,11 @@ &cpu6_opp11 {
 &cpu6_opp12 {
 	opp-peak-kBps = <8532000 23347200>;
 };
+
+&cpu6_opp13 {
+	opp-peak-kBps = <8532000 23347200>;
+};
+
+&cpu6_opp14 {
+	opp-peak-kBps = <8532000 23347200>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index ba684d980cf2..1afc960bab5c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1727,6 +1727,7 @@ apps_rsc: rsc@18200000 {
 			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>, <CONTROL_TCS 1>;
 			label = "apps_rsc";
+			power-domains = <&CLUSTER_PD>;
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 06b9b2f60b9f..a85bbe28dcf4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -25,6 +25,7 @@ config RISCV
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2aeaf8e3a4ab..59bb53da473d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -165,8 +165,7 @@ extern struct pt_alloc_ops pt_ops __initdata;
 					 _PAGE_EXEC | _PAGE_WRITE)
 
 #define PAGE_COPY		PAGE_READ
-#define PAGE_COPY_EXEC		PAGE_EXEC
-#define PAGE_COPY_READ_EXEC	PAGE_READ_EXEC
+#define PAGE_COPY_EXEC		PAGE_READ_EXEC
 #define PAGE_SHARED		PAGE_WRITE
 #define PAGE_SHARED_EXEC	PAGE_WRITE_EXEC
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2b9906ed2d1d..d8d97df80190 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -286,7 +286,7 @@ static const pgprot_t protection_map[16] = {
 	[VM_EXEC]					= PAGE_EXEC,
 	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
 	[VM_EXEC | VM_WRITE]				= PAGE_COPY_EXEC,
-	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_READ_EXEC,
+	[VM_EXEC | VM_WRITE | VM_READ]			= PAGE_COPY_EXEC,
 	[VM_SHARED]					= PAGE_NONE,
 	[VM_SHARED | VM_READ]				= PAGE_READ,
 	[VM_SHARED | VM_WRITE]				= PAGE_SHARED,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1ab41fbca094..add013d5bbda 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -685,6 +685,10 @@ static void __blk_mq_free_request(struct request *rq)
 	blk_crypto_free_request(rq);
 	blk_pm_mark_last_busy(rq);
 	rq->mq_hctx = NULL;
+
+	if (rq->rq_flags & RQF_MQ_INFLIGHT)
+		__blk_mq_dec_active_requests(hctx);
+
 	if (rq->tag != BLK_MQ_NO_TAG)
 		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
 	if (sched_tag != BLK_MQ_NO_TAG)
@@ -696,15 +700,11 @@ static void __blk_mq_free_request(struct request *rq)
 void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	if ((rq->rq_flags & RQF_ELVPRIV) &&
 	    q->elevator->type->ops.finish_request)
 		q->elevator->type->ops.finish_request(rq);
 
-	if (rq->rq_flags & RQF_MQ_INFLIGHT)
-		__blk_mq_dec_active_requests(hctx);
-
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->disk->bdi);
 
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 60aed196a2e5..e009f480675d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1334,14 +1334,30 @@ static bool rbd_obj_is_tail(struct rbd_obj_request *obj_req)
 /*
  * Must be called after rbd_obj_calc_img_extents().
  */
-static bool rbd_obj_copyup_enabled(struct rbd_obj_request *obj_req)
+static void rbd_obj_set_copyup_enabled(struct rbd_obj_request *obj_req)
 {
-	if (!obj_req->num_img_extents ||
-	    (rbd_obj_is_entire(obj_req) &&
-	     !obj_req->img_request->snapc->num_snaps))
-		return false;
+	rbd_assert(obj_req->img_request->snapc);
 
-	return true;
+	if (obj_req->img_request->op_type == OBJ_OP_DISCARD) {
+		dout("%s %p objno %llu discard\n", __func__, obj_req,
+		     obj_req->ex.oe_objno);
+		return;
+	}
+
+	if (!obj_req->num_img_extents) {
+		dout("%s %p objno %llu not overlapping\n", __func__, obj_req,
+		     obj_req->ex.oe_objno);
+		return;
+	}
+
+	if (rbd_obj_is_entire(obj_req) &&
+	    !obj_req->img_request->snapc->num_snaps) {
+		dout("%s %p objno %llu entire\n", __func__, obj_req,
+		     obj_req->ex.oe_objno);
+		return;
+	}
+
+	obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
 }
 
 static u64 rbd_obj_img_extents_bytes(struct rbd_obj_request *obj_req)
@@ -1442,6 +1458,7 @@ __rbd_obj_add_osd_request(struct rbd_obj_request *obj_req,
 static struct ceph_osd_request *
 rbd_obj_add_osd_request(struct rbd_obj_request *obj_req, int num_ops)
 {
+	rbd_assert(obj_req->img_request->snapc);
 	return __rbd_obj_add_osd_request(obj_req, obj_req->img_request->snapc,
 					 num_ops);
 }
@@ -1578,15 +1595,18 @@ static void rbd_img_request_init(struct rbd_img_request *img_request,
 	mutex_init(&img_request->state_mutex);
 }
 
+/*
+ * Only snap_id is captured here, for reads.  For writes, snapshot
+ * context is captured in rbd_img_object_requests() after exclusive
+ * lock is ensured to be held.
+ */
 static void rbd_img_capture_header(struct rbd_img_request *img_req)
 {
 	struct rbd_device *rbd_dev = img_req->rbd_dev;
 
 	lockdep_assert_held(&rbd_dev->header_rwsem);
 
-	if (rbd_img_is_write(img_req))
-		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
-	else
+	if (!rbd_img_is_write(img_req))
 		img_req->snap_id = rbd_dev->spec->snap_id;
 
 	if (rbd_dev_parent_get(rbd_dev))
@@ -2233,9 +2253,6 @@ static int rbd_obj_init_write(struct rbd_obj_request *obj_req)
 	if (ret)
 		return ret;
 
-	if (rbd_obj_copyup_enabled(obj_req))
-		obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
-
 	obj_req->write_state = RBD_OBJ_WRITE_START;
 	return 0;
 }
@@ -2341,8 +2358,6 @@ static int rbd_obj_init_zeroout(struct rbd_obj_request *obj_req)
 	if (ret)
 		return ret;
 
-	if (rbd_obj_copyup_enabled(obj_req))
-		obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
 	if (!obj_req->num_img_extents) {
 		obj_req->flags |= RBD_OBJ_FLAG_NOOP_FOR_NONEXISTENT;
 		if (rbd_obj_is_entire(obj_req))
@@ -3287,6 +3302,7 @@ static bool rbd_obj_advance_write(struct rbd_obj_request *obj_req, int *result)
 	case RBD_OBJ_WRITE_START:
 		rbd_assert(!*result);
 
+		rbd_obj_set_copyup_enabled(obj_req);
 		if (rbd_obj_write_is_noop(obj_req))
 			return true;
 
@@ -3473,9 +3489,19 @@ static int rbd_img_exclusive_lock(struct rbd_img_request *img_req)
 
 static void rbd_img_object_requests(struct rbd_img_request *img_req)
 {
+	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	struct rbd_obj_request *obj_req;
 
 	rbd_assert(!img_req->pending.result && !img_req->pending.num_pending);
+	rbd_assert(!need_exclusive_lock(img_req) ||
+		   __rbd_is_lock_owner(rbd_dev));
+
+	if (rbd_img_is_write(img_req)) {
+		rbd_assert(!img_req->snapc);
+		down_read(&rbd_dev->header_rwsem);
+		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
+		up_read(&rbd_dev->header_rwsem);
+	}
 
 	for_each_obj_request(img_req, obj_req) {
 		int result = 0;
@@ -3493,7 +3519,6 @@ static void rbd_img_object_requests(struct rbd_img_request *img_req)
 
 static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
 {
-	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	int ret;
 
 again:
@@ -3514,9 +3539,6 @@ static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
 		if (*result)
 			return true;
 
-		rbd_assert(!need_exclusive_lock(img_req) ||
-			   __rbd_is_lock_owner(rbd_dev));
-
 		rbd_img_object_requests(img_req);
 		if (!img_req->pending.num_pending) {
 			*result = img_req->pending.result;
@@ -3978,6 +4000,10 @@ static int rbd_post_acquire_action(struct rbd_device *rbd_dev)
 {
 	int ret;
 
+	ret = rbd_dev_refresh(rbd_dev);
+	if (ret)
+		return ret;
+
 	if (rbd_dev->header.features & RBD_FEATURE_OBJECT_MAP) {
 		ret = rbd_object_map_open(rbd_dev);
 		if (ret)
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7b9fd5f10433..45dffd2cbc71 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -78,7 +78,8 @@ enum qca_flags {
 	QCA_HW_ERROR_EVENT,
 	QCA_SSR_TRIGGERED,
 	QCA_BT_OFF,
-	QCA_ROM_FW
+	QCA_ROM_FW,
+	QCA_DEBUGFS_CREATED,
 };
 
 enum qca_capabilities {
@@ -635,6 +636,9 @@ static void qca_debugfs_init(struct hci_dev *hdev)
 	if (!hdev->debugfs)
 		return;
 
+	if (test_and_set_bit(QCA_DEBUGFS_CREATED, &qca->flags))
+		return;
+
 	ibs_dir = debugfs_create_dir("ibs", hdev->debugfs);
 
 	/* read only */
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 5904a679d351..c37e82359005 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -505,6 +505,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		ep_mem_access->flag = 0;
 		ep_mem_access->reserved = 0;
 	}
+	mem_region->handle = 0;
 	mem_region->reserved_0 = 0;
 	mem_region->reserved_1 = 0;
 	mem_region->ep_count = args->nattrs;
diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index cff68f31a09f..803676e307d7 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -717,8 +717,10 @@ static char **gpio_sim_make_line_names(struct gpio_sim_bank *bank,
 	if (!line_names)
 		return ERR_PTR(-ENOMEM);
 
-	list_for_each_entry(line, &bank->line_list, siblings)
-		line_names[line->offset] = line->name;
+	list_for_each_entry(line, &bank->line_list, siblings) {
+		if (line->name && (line->offset <= max_offset))
+			line_names[line->offset] = line->name;
+	}
 
 	return line_names;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4feedf518a19..ad8cb9e6d1ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -79,9 +79,10 @@ static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
 static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
-	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo *shadow_bo = ttm_to_amdgpu_bo(tbo), *bo;
 	struct amdgpu_bo_vm *vmbo;
 
+	bo = shadow_bo->parent;
 	vmbo = to_amdgpu_bo_vm(bo);
 	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
 	if (!list_empty(&vmbo->shadow_list)) {
@@ -691,11 +692,6 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 		return r;
 
 	*vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
-	INIT_LIST_HEAD(&(*vmbo_ptr)->shadow_list);
-	/* Set destroy callback to amdgpu_bo_vm_destroy after vmbo->shadow_list
-	 * is initialized.
-	 */
-	bo_ptr->tbo.destroy = &amdgpu_bo_vm_destroy;
 	return r;
 }
 
@@ -712,6 +708,8 @@ void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo)
 
 	mutex_lock(&adev->shadow_list_lock);
 	list_add_tail(&vmbo->shadow_list, &adev->shadow_list);
+	vmbo->shadow->parent = amdgpu_bo_ref(&vmbo->bo);
+	vmbo->shadow->tbo.destroy = &amdgpu_bo_vm_destroy;
 	mutex_unlock(&adev->shadow_list_lock);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 01e42bdd8e4e..4642cff0e1a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -564,7 +564,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return r;
 	}
 
-	(*vmbo)->shadow->parent = amdgpu_bo_ref(bo);
 	amdgpu_bo_add_to_shadow_list(*vmbo);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 75c80c557b6e..16594a0a6d18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -799,7 +799,7 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 {
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct drm_buddy *mm = &mgr->mm;
-	struct drm_buddy_block *block;
+	struct amdgpu_vram_reservation *rsv;
 
 	drm_printf(printer, "  vis usage:%llu\n",
 		   amdgpu_vram_mgr_vis_usage(mgr));
@@ -811,8 +811,9 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 	drm_buddy_print(mm, printer);
 
 	drm_printf(printer, "reserved:\n");
-	list_for_each_entry(block, &mgr->reserved_pages, link)
-		drm_buddy_block_print(mm, block, printer);
+	list_for_each_entry(rsv, &mgr->reserved_pages, blocks)
+		drm_printf(printer, "%#018llx-%#018llx: %llu\n",
+			rsv->start, rsv->start + rsv->size, rsv->size);
 	mutex_unlock(&mgr->lock);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index d6c37c90c628..53a3bb7fc9c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -542,8 +542,15 @@ static u32 vi_get_xclk(struct amdgpu_device *adev)
 	u32 reference_clock = adev->clock.spll.reference_freq;
 	u32 tmp;
 
-	if (adev->flags & AMD_IS_APU)
-		return reference_clock;
+	if (adev->flags & AMD_IS_APU) {
+		switch (adev->asic_type) {
+		case CHIP_STONEY:
+			/* vbios says 48Mhz, but the actual freq is 100Mhz */
+			return 10000;
+		default:
+			return reference_clock;
+		}
+	}
 
 	tmp = RREG32_SMC(ixCG_CLKPIN_CNTL_2);
 	if (REG_GET_FIELD(tmp, CG_CLKPIN_CNTL_2, MUX_TCLK_TO_XCLK))
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index d2b184fdd7e0..f28caece5f90 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -137,7 +137,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
 	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-	.pct_ideal_sdp_bw_after_urgent = 100.0,
+	.pct_ideal_sdp_bw_after_urgent = 90.0,
 	.pct_ideal_fabric_bw_after_urgent = 67.0,
 	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 20.0,
 	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0, // N/A, for now keep as is until DML implemented
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 75f18681e984..85d53597eb07 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2067,33 +2067,94 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 	return ret;
 }
 
+static void sienna_cichlid_get_override_pcie_settings(struct smu_context *smu,
+						      uint32_t *gen_speed_override,
+						      uint32_t *lane_width_override)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	*gen_speed_override = 0xff;
+	*lane_width_override = 0xff;
+
+	switch (adev->pdev->device) {
+	case 0x73A0:
+	case 0x73A1:
+	case 0x73A2:
+	case 0x73A3:
+	case 0x73AB:
+	case 0x73AE:
+		/* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 to x32 */
+		*lane_width_override = 6;
+		break;
+	case 0x73E0:
+	case 0x73E1:
+	case 0x73E3:
+		*lane_width_override = 4;
+		break;
+	case 0x7420:
+	case 0x7421:
+	case 0x7422:
+	case 0x7423:
+	case 0x7424:
+		*lane_width_override = 3;
+		break;
+	default:
+		break;
+	}
+}
+
+#define MAX(a, b)	((a) > (b) ? (a) : (b))
+
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_gen_cap,
 					 uint32_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-
-	uint32_t smu_pcie_arg;
+	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
+	uint32_t gen_speed_override, lane_width_override;
 	uint8_t *table_member1, *table_member2;
+	uint32_t min_gen_speed, max_gen_speed;
+	uint32_t min_lane_width, max_lane_width;
+	uint32_t smu_pcie_arg;
 	int ret, i;
 
 	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
 	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
 
-	/* lclk dpm table setup */
-	for (i = 0; i < MAX_PCIE_CONF; i++) {
-		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = table_member1[i];
-		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = table_member2[i];
+	sienna_cichlid_get_override_pcie_settings(smu,
+						  &gen_speed_override,
+						  &lane_width_override);
+
+	/* PCIE gen speed override */
+	if (gen_speed_override != 0xff) {
+		min_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
+		max_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
+	} else {
+		min_gen_speed = MAX(0, table_member1[0]);
+		max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
+		min_gen_speed = min_gen_speed > max_gen_speed ?
+				max_gen_speed : min_gen_speed;
 	}
+	pcie_table->pcie_gen[0] = min_gen_speed;
+	pcie_table->pcie_gen[1] = max_gen_speed;
+
+	/* PCIE lane width override */
+	if (lane_width_override != 0xff) {
+		min_lane_width = MIN(pcie_width_cap, lane_width_override);
+		max_lane_width = MIN(pcie_width_cap, lane_width_override);
+	} else {
+		min_lane_width = MAX(1, table_member2[0]);
+		max_lane_width = MIN(pcie_width_cap, table_member2[1]);
+		min_lane_width = min_lane_width > max_lane_width ?
+				 max_lane_width : min_lane_width;
+	}
+	pcie_table->pcie_lane[0] = min_lane_width;
+	pcie_table->pcie_lane[1] = max_lane_width;
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
-		smu_pcie_arg = (i << 16) |
-			((table_member1[i] <= pcie_gen_cap) ?
-			 (table_member1[i] << 8) :
-			 (pcie_gen_cap << 8)) |
-			((table_member2[i] <= pcie_width_cap) ?
-			 table_member2[i] :
-			 pcie_width_cap);
+		smu_pcie_arg = (i << 16 |
+				pcie_table->pcie_gen[i] << 8 |
+				pcie_table->pcie_lane[i]);
 
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 				SMU_MSG_OverridePcieParameters,
@@ -2101,11 +2162,6 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 				NULL);
 		if (ret)
 			return ret;
-
-		if (table_member1[i] > pcie_gen_cap)
-			dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pcie_gen_cap;
-		if (table_member2[i] > pcie_width_cap)
-			dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pcie_width_cap;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 479cbf05c331..5143b4df2cc1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -582,11 +582,11 @@ int smu_v13_0_init_power(struct smu_context *smu)
 	if (smu_power->power_context || smu_power->power_context_size != 0)
 		return -EINVAL;
 
-	smu_power->power_context = kzalloc(sizeof(struct smu_13_0_dpm_context),
+	smu_power->power_context = kzalloc(sizeof(struct smu_13_0_power_context),
 					   GFP_KERNEL);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_13_0_dpm_context);
+	smu_power->power_context_size = sizeof(struct smu_13_0_power_context);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/i915/display/intel_dp_aux.c
index 7f3f2d50e6cd..ab357161ccc3 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
@@ -119,6 +119,32 @@ static u32 skl_get_aux_clock_divider(struct intel_dp *intel_dp, int index)
 	return index ? 0 : 1;
 }
 
+static int intel_dp_aux_sync_len(void)
+{
+	int precharge = 16; /* 10-16 */
+	int preamble = 16;
+
+	return precharge + preamble;
+}
+
+static int intel_dp_aux_fw_sync_len(void)
+{
+	int precharge = 10; /* 10-16 */
+	int preamble = 8;
+
+	return precharge + preamble;
+}
+
+static int g4x_dp_aux_precharge_len(void)
+{
+	int precharge_min = 10;
+	int preamble = 16;
+
+	/* HW wants the length of the extra precharge in 2us units */
+	return (intel_dp_aux_sync_len() -
+		precharge_min - preamble) / 2;
+}
+
 static u32 g4x_get_aux_send_ctl(struct intel_dp *intel_dp,
 				int send_bytes,
 				u32 aux_clock_divider)
@@ -141,7 +167,7 @@ static u32 g4x_get_aux_send_ctl(struct intel_dp *intel_dp,
 	       timeout |
 	       DP_AUX_CH_CTL_RECEIVE_ERROR |
 	       (send_bytes << DP_AUX_CH_CTL_MESSAGE_SIZE_SHIFT) |
-	       (3 << DP_AUX_CH_CTL_PRECHARGE_2US_SHIFT) |
+	       (g4x_dp_aux_precharge_len() << DP_AUX_CH_CTL_PRECHARGE_2US_SHIFT) |
 	       (aux_clock_divider << DP_AUX_CH_CTL_BIT_CLOCK_2X_SHIFT);
 }
 
@@ -165,8 +191,8 @@ static u32 skl_get_aux_send_ctl(struct intel_dp *intel_dp,
 	      DP_AUX_CH_CTL_TIME_OUT_MAX |
 	      DP_AUX_CH_CTL_RECEIVE_ERROR |
 	      (send_bytes << DP_AUX_CH_CTL_MESSAGE_SIZE_SHIFT) |
-	      DP_AUX_CH_CTL_FW_SYNC_PULSE_SKL(24) |
-	      DP_AUX_CH_CTL_SYNC_PULSE_SKL(32);
+	      DP_AUX_CH_CTL_FW_SYNC_PULSE_SKL(intel_dp_aux_fw_sync_len()) |
+	      DP_AUX_CH_CTL_SYNC_PULSE_SKL(intel_dp_aux_sync_len());
 
 	if (intel_tc_port_in_tbt_alt_mode(dig_port))
 		ret |= DP_AUX_CH_CTL_TBT_IO;
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
index c6ad67b90e8a..a4858be12ee7 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
@@ -179,97 +179,108 @@ static int live_nop_switch(void *arg)
 }
 
 struct parallel_switch {
-	struct task_struct *tsk;
+	struct kthread_worker *worker;
+	struct kthread_work work;
 	struct intel_context *ce[2];
+	int result;
 };
 
-static int __live_parallel_switch1(void *data)
+static void __live_parallel_switch1(struct kthread_work *work)
 {
-	struct parallel_switch *arg = data;
+	struct parallel_switch *arg =
+		container_of(work, typeof(*arg), work);
 	IGT_TIMEOUT(end_time);
 	unsigned long count;
 
 	count = 0;
+	arg->result = 0;
 	do {
 		struct i915_request *rq = NULL;
-		int err, n;
+		int n;
 
-		err = 0;
-		for (n = 0; !err && n < ARRAY_SIZE(arg->ce); n++) {
+		for (n = 0; !arg->result && n < ARRAY_SIZE(arg->ce); n++) {
 			struct i915_request *prev = rq;
 
 			rq = i915_request_create(arg->ce[n]);
 			if (IS_ERR(rq)) {
 				i915_request_put(prev);
-				return PTR_ERR(rq);
+				arg->result = PTR_ERR(rq);
+				break;
 			}
 
 			i915_request_get(rq);
 			if (prev) {
-				err = i915_request_await_dma_fence(rq, &prev->fence);
+				arg->result =
+					i915_request_await_dma_fence(rq,
+								     &prev->fence);
 				i915_request_put(prev);
 			}
 
 			i915_request_add(rq);
 		}
+
+		if (IS_ERR_OR_NULL(rq))
+			break;
+
 		if (i915_request_wait(rq, 0, HZ) < 0)
-			err = -ETIME;
+			arg->result = -ETIME;
+
 		i915_request_put(rq);
-		if (err)
-			return err;
 
 		count++;
-	} while (!__igt_timeout(end_time, NULL));
+	} while (!arg->result && !__igt_timeout(end_time, NULL));
 
-	pr_info("%s: %lu switches (sync)\n", arg->ce[0]->engine->name, count);
-	return 0;
+	pr_info("%s: %lu switches (sync) <%d>\n",
+		arg->ce[0]->engine->name, count, arg->result);
 }
 
-static int __live_parallel_switchN(void *data)
+static void __live_parallel_switchN(struct kthread_work *work)
 {
-	struct parallel_switch *arg = data;
+	struct parallel_switch *arg =
+		container_of(work, typeof(*arg), work);
 	struct i915_request *rq = NULL;
 	IGT_TIMEOUT(end_time);
 	unsigned long count;
 	int n;
 
 	count = 0;
+	arg->result = 0;
 	do {
-		for (n = 0; n < ARRAY_SIZE(arg->ce); n++) {
+		for (n = 0; !arg->result && n < ARRAY_SIZE(arg->ce); n++) {
 			struct i915_request *prev = rq;
-			int err = 0;
 
 			rq = i915_request_create(arg->ce[n]);
 			if (IS_ERR(rq)) {
 				i915_request_put(prev);
-				return PTR_ERR(rq);
+				arg->result = PTR_ERR(rq);
+				break;
 			}
 
 			i915_request_get(rq);
 			if (prev) {
-				err = i915_request_await_dma_fence(rq, &prev->fence);
+				arg->result =
+					i915_request_await_dma_fence(rq,
+								     &prev->fence);
 				i915_request_put(prev);
 			}
 
 			i915_request_add(rq);
-			if (err) {
-				i915_request_put(rq);
-				return err;
-			}
 		}
 
 		count++;
-	} while (!__igt_timeout(end_time, NULL));
-	i915_request_put(rq);
+	} while (!arg->result && !__igt_timeout(end_time, NULL));
 
-	pr_info("%s: %lu switches (many)\n", arg->ce[0]->engine->name, count);
-	return 0;
+	if (!IS_ERR_OR_NULL(rq))
+		i915_request_put(rq);
+
+	pr_info("%s: %lu switches (many) <%d>\n",
+		arg->ce[0]->engine->name, count, arg->result);
 }
 
 static int live_parallel_switch(void *arg)
 {
 	struct drm_i915_private *i915 = arg;
-	static int (* const func[])(void *arg) = {
+	static void (* const func[])(struct kthread_work *) = {
 		__live_parallel_switch1,
 		__live_parallel_switchN,
 		NULL,
@@ -277,7 +288,7 @@ static int live_parallel_switch(void *arg)
 	struct parallel_switch *data = NULL;
 	struct i915_gem_engines *engines;
 	struct i915_gem_engines_iter it;
-	int (* const *fn)(void *arg);
+	void (* const *fn)(struct kthread_work *);
 	struct i915_gem_context *ctx;
 	struct intel_context *ce;
 	struct file *file;
@@ -335,8 +346,10 @@ static int live_parallel_switch(void *arg)
 				continue;
 
 			ce = intel_context_create(data[m].ce[0]->engine);
-			if (IS_ERR(ce))
+			if (IS_ERR(ce)) {
+				err = PTR_ERR(ce);
 				goto out;
+			}
 
 			err = intel_context_pin(ce);
 			if (err) {
@@ -348,9 +361,24 @@ static int live_parallel_switch(void *arg)
 		}
 	}
 
+	for (n = 0; n < count; n++) {
+		struct kthread_worker *worker;
+
+		if (!data[n].ce[0])
+			continue;
+
+		worker = kthread_create_worker(0, "igt/parallel:%s",
+					       data[n].ce[0]->engine->name);
+		if (IS_ERR(worker)) {
+			err = PTR_ERR(worker);
+			goto out;
+		}
+
+		data[n].worker = worker;
+	}
+
 	for (fn = func; !err && *fn; fn++) {
 		struct igt_live_test t;
-		int n;
 
 		err = igt_live_test_begin(&t, i915, __func__, "");
 		if (err)
@@ -360,34 +388,23 @@ static int live_parallel_switch(void *arg)
 			if (!data[n].ce[0])
 				continue;
 
-			data[n].tsk = kthread_run(*fn, &data[n],
-						  "igt/parallel:%s",
-						  data[n].ce[0]->engine->name);
-			if (IS_ERR(data[n].tsk)) {
-				err = PTR_ERR(data[n].tsk);
-				break;
-			}
-			get_task_struct(data[n].tsk);
+			data[n].result = 0;
+			kthread_init_work(&data[n].work, *fn);
+			kthread_queue_work(data[n].worker, &data[n].work);
 		}
 
-		yield(); /* start all threads before we kthread_stop() */
-
 		for (n = 0; n < count; n++) {
-			int status;
-
-			if (IS_ERR_OR_NULL(data[n].tsk))
-				continue;
-
-			status = kthread_stop(data[n].tsk);
-			if (status && !err)
-				err = status;
-
-			put_task_struct(data[n].tsk);
-			data[n].tsk = NULL;
+			if (data[n].ce[0]) {
+				kthread_flush_work(&data[n].work);
+				if (data[n].result && !err)
+					err = data[n].result;
+			}
 		}
 
-		if (igt_live_test_end(&t))
-			err = -EIO;
+		if (igt_live_test_end(&t)) {
+			err = err ?: -EIO;
+			break;
+		}
 	}
 
 out:
@@ -399,6 +416,9 @@ static int live_parallel_switch(void *arg)
 			intel_context_unpin(data[n].ce[m]);
 			intel_context_put(data[n].ce[m]);
 		}
+
+		if (data[n].worker)
+			kthread_destroy_worker(data[n].worker);
 	}
 	kfree(data);
 out_file:
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 1e08b2473b99..b370411d4362 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -1532,8 +1532,8 @@ static int live_busywait_preempt(void *arg)
 	struct drm_i915_gem_object *obj;
 	struct i915_vma *vma;
 	enum intel_engine_id id;
-	int err = -ENOMEM;
 	u32 *map;
+	int err;
 
 	/*
 	 * Verify that even without HAS_LOGICAL_RING_PREEMPTION, we can
@@ -1541,13 +1541,17 @@ static int live_busywait_preempt(void *arg)
 	 */
 
 	ctx_hi = kernel_context(gt->i915, NULL);
-	if (!ctx_hi)
-		return -ENOMEM;
+	if (IS_ERR(ctx_hi))
+		return PTR_ERR(ctx_hi);
+
 	ctx_hi->sched.priority = I915_CONTEXT_MAX_USER_PRIORITY;
 
 	ctx_lo = kernel_context(gt->i915, NULL);
-	if (!ctx_lo)
+	if (IS_ERR(ctx_lo)) {
+		err = PTR_ERR(ctx_lo);
 		goto err_ctx_hi;
+	}
+
 	ctx_lo->sched.priority = I915_CONTEXT_MIN_USER_PRIORITY;
 
 	obj = i915_gem_object_create_internal(gt->i915, PAGE_SIZE);
@@ -3475,12 +3479,14 @@ static int random_priority(struct rnd_state *rnd)
 
 struct preempt_smoke {
 	struct intel_gt *gt;
+	struct kthread_work work;
 	struct i915_gem_context **contexts;
 	struct intel_engine_cs *engine;
 	struct drm_i915_gem_object *batch;
 	unsigned int ncontext;
 	struct rnd_state prng;
 	unsigned long count;
+	int result;
 };
 
 static struct i915_gem_context *smoke_context(struct preempt_smoke *smoke)
@@ -3540,34 +3546,31 @@ static int smoke_submit(struct preempt_smoke *smoke,
 	return err;
 }
 
-static int smoke_crescendo_thread(void *arg)
+static void smoke_crescendo_work(struct kthread_work *work)
 {
-	struct preempt_smoke *smoke = arg;
+	struct preempt_smoke *smoke = container_of(work, typeof(*smoke), work);
 	IGT_TIMEOUT(end_time);
 	unsigned long count;
 
 	count = 0;
 	do {
 		struct i915_gem_context *ctx = smoke_context(smoke);
-		int err;
 
-		err = smoke_submit(smoke,
-				   ctx, count % I915_PRIORITY_MAX,
-				   smoke->batch);
-		if (err)
-			return err;
+		smoke->result = smoke_submit(smoke, ctx,
+					     count % I915_PRIORITY_MAX,
+					     smoke->batch);
 
 		count++;
-	} while (count < smoke->ncontext && !__igt_timeout(end_time, NULL));
+	} while (!smoke->result && count < smoke->ncontext &&
+		 !__igt_timeout(end_time, NULL));
 
 	smoke->count = count;
-	return 0;
 }
 
 static int smoke_crescendo(struct preempt_smoke *smoke, unsigned int flags)
 #define BATCH BIT(0)
 {
-	struct task_struct *tsk[I915_NUM_ENGINES] = {};
+	struct kthread_worker *worker[I915_NUM_ENGINES] = {};
 	struct preempt_smoke *arg;
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
@@ -3578,6 +3581,8 @@ static int smoke_crescendo(struct preempt_smoke *smoke, unsigned int flags)
 	if (!arg)
 		return -ENOMEM;
 
+	memset(arg, 0, I915_NUM_ENGINES * sizeof(*arg));
+
 	for_each_engine(engine, smoke->gt, id) {
 		arg[id] = *smoke;
 		arg[id].engine = engine;
@@ -3585,31 +3590,28 @@ static int smoke_crescendo(struct preempt_smoke *smoke, unsigned int flags)
 			arg[id].batch = NULL;
 		arg[id].count = 0;
 
-		tsk[id] = kthread_run(smoke_crescendo_thread, arg,
-				      "igt/smoke:%d", id);
-		if (IS_ERR(tsk[id])) {
-			err = PTR_ERR(tsk[id]);
+		worker[id] = kthread_create_worker(0, "igt/smoke:%d", id);
+		if (IS_ERR(worker[id])) {
+			err = PTR_ERR(worker[id]);
 			break;
 		}
-		get_task_struct(tsk[id]);
-	}
 
-	yield(); /* start all threads before we kthread_stop() */
+		kthread_init_work(&arg[id].work, smoke_crescendo_work);
+		kthread_queue_work(worker[id], &arg[id].work);
+	}
 
 	count = 0;
 	for_each_engine(engine, smoke->gt, id) {
-		int status;
-
-		if (IS_ERR_OR_NULL(tsk[id]))
+		if (IS_ERR_OR_NULL(worker[id]))
 			continue;
 
-		status = kthread_stop(tsk[id]);
-		if (status && !err)
-			err = status;
+		kthread_flush_work(&arg[id].work);
+		if (arg[id].result && !err)
+			err = arg[id].result;
 
 		count += arg[id].count;
 
-		put_task_struct(tsk[id]);
+		kthread_destroy_worker(worker[id]);
 	}
 
 	pr_info("Submitted %lu crescendo:%x requests across %d engines and %d contexts\n",
diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
index 7f3bb1d34dfb..71263058a7b0 100644
--- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
@@ -866,10 +866,13 @@ static int igt_reset_active_engine(void *arg)
 }
 
 struct active_engine {
-	struct task_struct *task;
+	struct kthread_worker *worker;
+	struct kthread_work work;
 	struct intel_engine_cs *engine;
 	unsigned long resets;
 	unsigned int flags;
+	bool stop;
+	int result;
 };
 
 #define TEST_ACTIVE	BIT(0)
@@ -900,10 +903,10 @@ static int active_request_put(struct i915_request *rq)
 	return err;
 }
 
-static int active_engine(void *data)
+static void active_engine(struct kthread_work *work)
 {
 	I915_RND_STATE(prng);
-	struct active_engine *arg = data;
+	struct active_engine *arg = container_of(work, typeof(*arg), work);
 	struct intel_engine_cs *engine = arg->engine;
 	struct i915_request *rq[8] = {};
 	struct intel_context *ce[ARRAY_SIZE(rq)];
@@ -913,16 +916,17 @@ static int active_engine(void *data)
 	for (count = 0; count < ARRAY_SIZE(ce); count++) {
 		ce[count] = intel_context_create(engine);
 		if (IS_ERR(ce[count])) {
-			err = PTR_ERR(ce[count]);
-			pr_err("[%s] Create context #%ld failed: %d!\n", engine->name, count, err);
+			arg->result = PTR_ERR(ce[count]);
+			pr_err("[%s] Create context #%ld failed: %d!\n",
+			       engine->name, count, arg->result);
 			while (--count)
 				intel_context_put(ce[count]);
-			return err;
+			return;
 		}
 	}
 
 	count = 0;
-	while (!kthread_should_stop()) {
+	while (!READ_ONCE(arg->stop)) {
 		unsigned int idx = count++ & (ARRAY_SIZE(rq) - 1);
 		struct i915_request *old = rq[idx];
 		struct i915_request *new;
@@ -967,7 +971,7 @@ static int active_engine(void *data)
 		intel_context_put(ce[count]);
 	}
 
-	return err;
+	arg->result = err;
 }
 
 static int __igt_reset_engines(struct intel_gt *gt,
@@ -1022,7 +1026,7 @@ static int __igt_reset_engines(struct intel_gt *gt,
 
 		memset(threads, 0, sizeof(*threads) * I915_NUM_ENGINES);
 		for_each_engine(other, gt, tmp) {
-			struct task_struct *tsk;
+			struct kthread_worker *worker;
 
 			threads[tmp].resets =
 				i915_reset_engine_count(global, other);
@@ -1036,19 +1040,21 @@ static int __igt_reset_engines(struct intel_gt *gt,
 			threads[tmp].engine = other;
 			threads[tmp].flags = flags;
 
-			tsk = kthread_run(active_engine, &threads[tmp],
-					  "igt/%s", other->name);
-			if (IS_ERR(tsk)) {
-				err = PTR_ERR(tsk);
-				pr_err("[%s] Thread spawn failed: %d!\n", engine->name, err);
+			worker = kthread_create_worker(0, "igt/%s",
+						       other->name);
+			if (IS_ERR(worker)) {
+				err = PTR_ERR(worker);
+				pr_err("[%s] Worker create failed: %d!\n",
+				       engine->name, err);
 				goto unwind;
 			}
 
-			threads[tmp].task = tsk;
-			get_task_struct(tsk);
-		}
+			threads[tmp].worker = worker;
 
-		yield(); /* start all threads before we begin */
+			kthread_init_work(&threads[tmp].work, active_engine);
+			kthread_queue_work(threads[tmp].worker,
+					   &threads[tmp].work);
+		}
 
 		st_engine_heartbeat_disable_no_pm(engine);
 		GEM_BUG_ON(test_and_set_bit(I915_RESET_ENGINE + id,
@@ -1197,17 +1203,20 @@ static int __igt_reset_engines(struct intel_gt *gt,
 		for_each_engine(other, gt, tmp) {
 			int ret;
 
-			if (!threads[tmp].task)
+			if (!threads[tmp].worker)
 				continue;
 
-			ret = kthread_stop(threads[tmp].task);
+			WRITE_ONCE(threads[tmp].stop, true);
+			kthread_flush_work(&threads[tmp].work);
+			ret = READ_ONCE(threads[tmp].result);
 			if (ret) {
 				pr_err("kthread for other engine %s failed, err=%d\n",
 				       other->name, ret);
 				if (!err)
 					err = ret;
 			}
-			put_task_struct(threads[tmp].task);
+
+			kthread_destroy_worker(threads[tmp].worker);
 
 			/* GuC based resets are not logged per engine */
 			if (!using_guc) {
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index 818a4909c1f3..a46350c37e9d 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -299,9 +299,18 @@ __live_request_alloc(struct intel_context *ce)
 	return intel_context_create_request(ce);
 }
 
-static int __igt_breadcrumbs_smoketest(void *arg)
+struct smoke_thread {
+	struct kthread_worker *worker;
+	struct kthread_work work;
+	struct smoketest *t;
+	bool stop;
+	int result;
+};
+
+static void __igt_breadcrumbs_smoketest(struct kthread_work *work)
 {
-	struct smoketest *t = arg;
+	struct smoke_thread *thread = container_of(work, typeof(*thread), work);
+	struct smoketest *t = thread->t;
 	const unsigned int max_batch = min(t->ncontexts, t->max_batch) - 1;
 	const unsigned int total = 4 * t->ncontexts + 1;
 	unsigned int num_waits = 0, num_fences = 0;
@@ -320,8 +329,10 @@ static int __igt_breadcrumbs_smoketest(void *arg)
 	 */
 
 	requests = kcalloc(total, sizeof(*requests), GFP_KERNEL);
-	if (!requests)
-		return -ENOMEM;
+	if (!requests) {
+		thread->result = -ENOMEM;
+		return;
+	}
 
 	order = i915_random_order(total, &prng);
 	if (!order) {
@@ -329,7 +340,7 @@ static int __igt_breadcrumbs_smoketest(void *arg)
 		goto out_requests;
 	}
 
-	while (!kthread_should_stop()) {
+	while (!READ_ONCE(thread->stop)) {
 		struct i915_sw_fence *submit, *wait;
 		unsigned int n, count;
 
@@ -437,7 +448,7 @@ static int __igt_breadcrumbs_smoketest(void *arg)
 	kfree(order);
 out_requests:
 	kfree(requests);
-	return err;
+	thread->result = err;
 }
 
 static int mock_breadcrumbs_smoketest(void *arg)
@@ -450,7 +461,7 @@ static int mock_breadcrumbs_smoketest(void *arg)
 		.request_alloc = __mock_request_alloc
 	};
 	unsigned int ncpus = num_online_cpus();
-	struct task_struct **threads;
+	struct smoke_thread *threads;
 	unsigned int n;
 	int ret = 0;
 
@@ -479,28 +490,37 @@ static int mock_breadcrumbs_smoketest(void *arg)
 	}
 
 	for (n = 0; n < ncpus; n++) {
-		threads[n] = kthread_run(__igt_breadcrumbs_smoketest,
-					 &t, "igt/%d", n);
-		if (IS_ERR(threads[n])) {
-			ret = PTR_ERR(threads[n]);
+		struct kthread_worker *worker;
+
+		worker = kthread_create_worker(0, "igt/%d", n);
+		if (IS_ERR(worker)) {
+			ret = PTR_ERR(worker);
 			ncpus = n;
 			break;
 		}
 
-		get_task_struct(threads[n]);
+		threads[n].worker = worker;
+		threads[n].t = &t;
+		threads[n].stop = false;
+		threads[n].result = 0;
+
+		kthread_init_work(&threads[n].work,
+				  __igt_breadcrumbs_smoketest);
+		kthread_queue_work(worker, &threads[n].work);
 	}
 
-	yield(); /* start all threads before we begin */
 	msleep(jiffies_to_msecs(i915_selftest.timeout_jiffies));
 
 	for (n = 0; n < ncpus; n++) {
 		int err;
 
-		err = kthread_stop(threads[n]);
+		WRITE_ONCE(threads[n].stop, true);
+		kthread_flush_work(&threads[n].work);
+		err = READ_ONCE(threads[n].result);
 		if (err < 0 && !ret)
 			ret = err;
 
-		put_task_struct(threads[n]);
+		kthread_destroy_worker(threads[n].worker);
 	}
 	pr_info("Completed %lu waits for %lu fence across %d cpus\n",
 		atomic_long_read(&t.num_waits),
@@ -1419,9 +1439,18 @@ static int live_sequential_engines(void *arg)
 	return err;
 }
 
-static int __live_parallel_engine1(void *arg)
+struct parallel_thread {
+	struct kthread_worker *worker;
+	struct kthread_work work;
+	struct intel_engine_cs *engine;
+	int result;
+};
+
+static void __live_parallel_engine1(struct kthread_work *work)
 {
-	struct intel_engine_cs *engine = arg;
+	struct parallel_thread *thread =
+		container_of(work, typeof(*thread), work);
+	struct intel_engine_cs *engine = thread->engine;
 	IGT_TIMEOUT(end_time);
 	unsigned long count;
 	int err = 0;
@@ -1452,12 +1481,14 @@ static int __live_parallel_engine1(void *arg)
 	intel_engine_pm_put(engine);
 
 	pr_info("%s: %lu request + sync\n", engine->name, count);
-	return err;
+	thread->result = err;
 }
 
-static int __live_parallel_engineN(void *arg)
+static void __live_parallel_engineN(struct kthread_work *work)
 {
-	struct intel_engine_cs *engine = arg;
+	struct parallel_thread *thread =
+		container_of(work, typeof(*thread), work);
+	struct intel_engine_cs *engine = thread->engine;
 	IGT_TIMEOUT(end_time);
 	unsigned long count;
 	int err = 0;
@@ -1479,7 +1510,7 @@ static int __live_parallel_engineN(void *arg)
 	intel_engine_pm_put(engine);
 
 	pr_info("%s: %lu requests\n", engine->name, count);
-	return err;
+	thread->result = err;
 }
 
 static bool wake_all(struct drm_i915_private *i915)
@@ -1505,9 +1536,11 @@ static int wait_for_all(struct drm_i915_private *i915)
 	return -ETIME;
 }
 
-static int __live_parallel_spin(void *arg)
+static void __live_parallel_spin(struct kthread_work *work)
 {
-	struct intel_engine_cs *engine = arg;
+	struct parallel_thread *thread =
+		container_of(work, typeof(*thread), work);
+	struct intel_engine_cs *engine = thread->engine;
 	struct igt_spinner spin;
 	struct i915_request *rq;
 	int err = 0;
@@ -1520,7 +1553,8 @@ static int __live_parallel_spin(void *arg)
 
 	if (igt_spinner_init(&spin, engine->gt)) {
 		wake_all(engine->i915);
-		return -ENOMEM;
+		thread->result = -ENOMEM;
+		return;
 	}
 
 	intel_engine_pm_get(engine);
@@ -1553,22 +1587,22 @@ static int __live_parallel_spin(void *arg)
 
 out_spin:
 	igt_spinner_fini(&spin);
-	return err;
+	thread->result = err;
 }
 
 static int live_parallel_engines(void *arg)
 {
 	struct drm_i915_private *i915 = arg;
-	static int (* const func[])(void *arg) = {
+	static void (* const func[])(struct kthread_work *) = {
 		__live_parallel_engine1,
 		__live_parallel_engineN,
 		__live_parallel_spin,
 		NULL,
 	};
 	const unsigned int nengines = num_uabi_engines(i915);
+	struct parallel_thread *threads;
 	struct intel_engine_cs *engine;
-	int (* const *fn)(void *arg);
-	struct task_struct **tsk;
+	void (* const *fn)(struct kthread_work *);
 	int err = 0;
 
 	/*
@@ -1576,8 +1610,8 @@ static int live_parallel_engines(void *arg)
 	 * tests that we load up the system maximally.
 	 */
 
-	tsk = kcalloc(nengines, sizeof(*tsk), GFP_KERNEL);
-	if (!tsk)
+	threads = kcalloc(nengines, sizeof(*threads), GFP_KERNEL);
+	if (!threads)
 		return -ENOMEM;
 
 	for (fn = func; !err && *fn; fn++) {
@@ -1594,37 +1628,44 @@ static int live_parallel_engines(void *arg)
 
 		idx = 0;
 		for_each_uabi_engine(engine, i915) {
-			tsk[idx] = kthread_run(*fn, engine,
-					       "igt/parallel:%s",
-					       engine->name);
-			if (IS_ERR(tsk[idx])) {
-				err = PTR_ERR(tsk[idx]);
+			struct kthread_worker *worker;
+
+			worker = kthread_create_worker(0, "igt/parallel:%s",
+						       engine->name);
+			if (IS_ERR(worker)) {
+				err = PTR_ERR(worker);
 				break;
 			}
-			get_task_struct(tsk[idx++]);
-		}
 
-		yield(); /* start all threads before we kthread_stop() */
+			threads[idx].worker = worker;
+			threads[idx].result = 0;
+			threads[idx].engine = engine;
+
+			kthread_init_work(&threads[idx].work, *fn);
+			kthread_queue_work(worker, &threads[idx].work);
+			idx++;
+		}
 
 		idx = 0;
 		for_each_uabi_engine(engine, i915) {
 			int status;
 
-			if (IS_ERR(tsk[idx]))
+			if (!threads[idx].worker)
 				break;
 
-			status = kthread_stop(tsk[idx]);
+			kthread_flush_work(&threads[idx].work);
+			status = READ_ONCE(threads[idx].result);
 			if (status && !err)
 				err = status;
 
-			put_task_struct(tsk[idx++]);
+			kthread_destroy_worker(threads[idx++].worker);
 		}
 
 		if (igt_live_test_end(&t))
 			err = -EIO;
 	}
 
-	kfree(tsk);
+	kfree(threads);
 	return err;
 }
 
@@ -1672,7 +1713,7 @@ static int live_breadcrumbs_smoketest(void *arg)
 	const unsigned int ncpus = num_online_cpus();
 	unsigned long num_waits, num_fences;
 	struct intel_engine_cs *engine;
-	struct task_struct **threads;
+	struct smoke_thread *threads;
 	struct igt_live_test live;
 	intel_wakeref_t wakeref;
 	struct smoketest *smoke;
@@ -1746,23 +1787,26 @@ static int live_breadcrumbs_smoketest(void *arg)
 			 smoke[idx].max_batch, engine->name);
 
 		for (n = 0; n < ncpus; n++) {
-			struct task_struct *tsk;
+			unsigned int i = idx * ncpus + n;
+			struct kthread_worker *worker;
 
-			tsk = kthread_run(__igt_breadcrumbs_smoketest,
-					  &smoke[idx], "igt/%d.%d", idx, n);
-			if (IS_ERR(tsk)) {
-				ret = PTR_ERR(tsk);
+			worker = kthread_create_worker(0, "igt/%d.%d", idx, n);
+			if (IS_ERR(worker)) {
+				ret = PTR_ERR(worker);
 				goto out_flush;
 			}
 
-			get_task_struct(tsk);
-			threads[idx * ncpus + n] = tsk;
+			threads[i].worker = worker;
+			threads[i].t = &smoke[idx];
+
+			kthread_init_work(&threads[i].work,
+					  __igt_breadcrumbs_smoketest);
+			kthread_queue_work(worker, &threads[i].work);
 		}
 
 		idx++;
 	}
 
-	yield(); /* start all threads before we begin */
 	msleep(jiffies_to_msecs(i915_selftest.timeout_jiffies));
 
 out_flush:
@@ -1771,17 +1815,19 @@ static int live_breadcrumbs_smoketest(void *arg)
 	num_fences = 0;
 	for_each_uabi_engine(engine, i915) {
 		for (n = 0; n < ncpus; n++) {
-			struct task_struct *tsk = threads[idx * ncpus + n];
+			unsigned int i = idx * ncpus + n;
 			int err;
 
-			if (!tsk)
+			if (!threads[i].worker)
 				continue;
 
-			err = kthread_stop(tsk);
+			WRITE_ONCE(threads[i].stop, true);
+			kthread_flush_work(&threads[i].work);
+			err = READ_ONCE(threads[i].result);
 			if (err < 0 && !ret)
 				ret = err;
 
-			put_task_struct(tsk);
+			kthread_destroy_worker(threads[i].worker);
 		}
 
 		num_waits += atomic_long_read(&smoke[idx].num_waits);
@@ -2891,9 +2937,18 @@ static int perf_series_engines(void *arg)
 	return err;
 }
 
-static int p_sync0(void *arg)
+struct p_thread {
+	struct perf_stats p;
+	struct kthread_worker *worker;
+	struct kthread_work work;
+	struct intel_engine_cs *engine;
+	int result;
+};
+
+static void p_sync0(struct kthread_work *work)
 {
-	struct perf_stats *p = arg;
+	struct p_thread *thread = container_of(work, typeof(*thread), work);
+	struct perf_stats *p = &thread->p;
 	struct intel_engine_cs *engine = p->engine;
 	struct intel_context *ce;
 	IGT_TIMEOUT(end_time);
@@ -2902,13 +2957,16 @@ static int p_sync0(void *arg)
 	int err = 0;
 
 	ce = intel_context_create(engine);
-	if (IS_ERR(ce))
-		return PTR_ERR(ce);
+	if (IS_ERR(ce)) {
+		thread->result = PTR_ERR(ce);
+		return;
+	}
 
 	err = intel_context_pin(ce);
 	if (err) {
 		intel_context_put(ce);
-		return err;
+		thread->result = err;
+		return;
 	}
 
 	if (intel_engine_supports_stats(engine)) {
@@ -2958,12 +3016,13 @@ static int p_sync0(void *arg)
 
 	intel_context_unpin(ce);
 	intel_context_put(ce);
-	return err;
+	thread->result = err;
 }
 
-static int p_sync1(void *arg)
+static void p_sync1(struct kthread_work *work)
 {
-	struct perf_stats *p = arg;
+	struct p_thread *thread = container_of(work, typeof(*thread), work);
+	struct perf_stats *p = &thread->p;
 	struct intel_engine_cs *engine = p->engine;
 	struct i915_request *prev = NULL;
 	struct intel_context *ce;
@@ -2973,13 +3032,16 @@ static int p_sync1(void *arg)
 	int err = 0;
 
 	ce = intel_context_create(engine);
-	if (IS_ERR(ce))
-		return PTR_ERR(ce);
+	if (IS_ERR(ce)) {
+		thread->result = PTR_ERR(ce);
+		return;
+	}
 
 	err = intel_context_pin(ce);
 	if (err) {
 		intel_context_put(ce);
-		return err;
+		thread->result = err;
+		return;
 	}
 
 	if (intel_engine_supports_stats(engine)) {
@@ -3031,12 +3093,13 @@ static int p_sync1(void *arg)
 
 	intel_context_unpin(ce);
 	intel_context_put(ce);
-	return err;
+	thread->result = err;
 }
 
-static int p_many(void *arg)
+static void p_many(struct kthread_work *work)
 {
-	struct perf_stats *p = arg;
+	struct p_thread *thread = container_of(work, typeof(*thread), work);
+	struct perf_stats *p = &thread->p;
 	struct intel_engine_cs *engine = p->engine;
 	struct intel_context *ce;
 	IGT_TIMEOUT(end_time);
@@ -3045,13 +3108,16 @@ static int p_many(void *arg)
 	bool busy;
 
 	ce = intel_context_create(engine);
-	if (IS_ERR(ce))
-		return PTR_ERR(ce);
+	if (IS_ERR(ce)) {
+		thread->result = PTR_ERR(ce);
+		return;
+	}
 
 	err = intel_context_pin(ce);
 	if (err) {
 		intel_context_put(ce);
-		return err;
+		thread->result = err;
+		return;
 	}
 
 	if (intel_engine_supports_stats(engine)) {
@@ -3092,26 +3158,23 @@ static int p_many(void *arg)
 
 	intel_context_unpin(ce);
 	intel_context_put(ce);
-	return err;
+	thread->result = err;
 }
 
 static int perf_parallel_engines(void *arg)
 {
 	struct drm_i915_private *i915 = arg;
-	static int (* const func[])(void *arg) = {
+	static void (* const func[])(struct kthread_work *) = {
 		p_sync0,
 		p_sync1,
 		p_many,
 		NULL,
 	};
 	const unsigned int nengines = num_uabi_engines(i915);
+	void (* const *fn)(struct kthread_work *);
 	struct intel_engine_cs *engine;
-	int (* const *fn)(void *arg);
 	struct pm_qos_request qos;
-	struct {
-		struct perf_stats p;
-		struct task_struct *tsk;
-	} *engines;
+	struct p_thread *engines;
 	int err = 0;
 
 	engines = kcalloc(nengines, sizeof(*engines), GFP_KERNEL);
@@ -3134,36 +3197,45 @@ static int perf_parallel_engines(void *arg)
 
 		idx = 0;
 		for_each_uabi_engine(engine, i915) {
+			struct kthread_worker *worker;
+
 			intel_engine_pm_get(engine);
 
 			memset(&engines[idx].p, 0, sizeof(engines[idx].p));
-			engines[idx].p.engine = engine;
 
-			engines[idx].tsk = kthread_run(*fn, &engines[idx].p,
-						       "igt:%s", engine->name);
-			if (IS_ERR(engines[idx].tsk)) {
-				err = PTR_ERR(engines[idx].tsk);
+			worker = kthread_create_worker(0, "igt:%s",
+						       engine->name);
+			if (IS_ERR(worker)) {
+				err = PTR_ERR(worker);
 				intel_engine_pm_put(engine);
 				break;
 			}
-			get_task_struct(engines[idx++].tsk);
-		}
+			engines[idx].worker = worker;
+			engines[idx].result = 0;
+			engines[idx].p.engine = engine;
+			engines[idx].engine = engine;
 
-		yield(); /* start all threads before we kthread_stop() */
+			kthread_init_work(&engines[idx].work, *fn);
+			kthread_queue_work(worker, &engines[idx].work);
+			idx++;
+		}
 
 		idx = 0;
 		for_each_uabi_engine(engine, i915) {
 			int status;
 
-			if (IS_ERR(engines[idx].tsk))
+			if (!engines[idx].worker)
 				break;
 
-			status = kthread_stop(engines[idx].tsk);
+			kthread_flush_work(&engines[idx].work);
+			status = READ_ONCE(engines[idx].result);
 			if (status && !err)
 				err = status;
 
 			intel_engine_pm_put(engine);
-			put_task_struct(engines[idx++].tsk);
+
+			kthread_destroy_worker(engines[idx].worker);
+			idx++;
 		}
 
 		if (igt_live_test_end(&t))
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 047dfef7a657..878c076ebdc6 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -520,6 +520,17 @@ mv64xxx_i2c_intr(int irq, void *dev_id)
 
 	while (readl(drv_data->reg_base + drv_data->reg_offsets.control) &
 						MV64XXX_I2C_REG_CONTROL_IFLG) {
+		/*
+		 * It seems that sometime the controller updates the status
+		 * register only after it asserts IFLG in control register.
+		 * This may result in weird bugs when in atomic mode. A delay
+		 * of 100 ns before reading the status register solves this
+		 * issue. This bug does not seem to appear when using
+		 * interrupts.
+		 */
+		if (drv_data->atomic)
+			ndelay(100);
+
 		status = readl(drv_data->reg_base + drv_data->reg_offsets.status);
 		mv64xxx_i2c_fsm(drv_data, status);
 		mv64xxx_i2c_do_action(drv_data);
diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 4fe15cd78907..ffc54fbf814d 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -576,12 +576,14 @@ static int sprd_i2c_remove(struct platform_device *pdev)
 	struct sprd_i2c *i2c_dev = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(i2c_dev->dev);
+	ret = pm_runtime_get_sync(i2c_dev->dev);
 	if (ret < 0)
-		return ret;
+		dev_err(&pdev->dev, "Failed to resume device (%pe)\n", ERR_PTR(ret));
 
 	i2c_del_adapter(&i2c_dev->adap);
-	clk_disable_unprepare(i2c_dev->clk);
+
+	if (ret >= 0)
+		clk_disable_unprepare(i2c_dev->clk);
 
 	pm_runtime_put_noidle(i2c_dev->dev);
 	pm_runtime_disable(i2c_dev->dev);
diff --git a/drivers/input/input.c b/drivers/input/input.c
index ebb2b7f0f8ff..8b6a922f8470 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -701,7 +701,7 @@ void input_close_device(struct input_handle *handle)
 
 	__input_release_device(handle);
 
-	if (!dev->inhibited && !--dev->users) {
+	if (!--dev->users && !dev->inhibited) {
 		if (dev->poller)
 			input_dev_poller_stop(dev->poller);
 		if (dev->close)
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index cd36cf716542..76cbcca13c9e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -282,7 +282,6 @@ static const struct xpad_device {
 	{ 0x1430, 0xf801, "RedOctane Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0604, "Bigben Interactive DAIJA Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
-	{ 0x1532, 0x0037, "Razer Sabertooth", 0, XTYPE_XBOX360 },
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index ece97f8c6a3e..2118b2075f43 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -674,10 +674,11 @@ static void process_packet_head_v4(struct psmouse *psmouse)
 	struct input_dev *dev = psmouse->dev;
 	struct elantech_data *etd = psmouse->private;
 	unsigned char *packet = psmouse->packet;
-	int id = ((packet[3] & 0xe0) >> 5) - 1;
+	int id;
 	int pres, traces;
 
-	if (id < 0)
+	id = ((packet[3] & 0xe0) >> 5) - 1;
+	if (id < 0 || id >= ETP_MAX_FINGERS)
 		return;
 
 	etd->mt[id].x = ((packet[1] & 0x0f) << 8) | packet[2];
@@ -707,7 +708,7 @@ static void process_packet_motion_v4(struct psmouse *psmouse)
 	int id, sid;
 
 	id = ((packet[0] & 0xe0) >> 5) - 1;
-	if (id < 0)
+	if (id < 0 || id >= ETP_MAX_FINGERS)
 		return;
 
 	sid = ((packet[3] & 0xe0) >> 5) - 1;
@@ -728,7 +729,7 @@ static void process_packet_motion_v4(struct psmouse *psmouse)
 	input_report_abs(dev, ABS_MT_POSITION_X, etd->mt[id].x);
 	input_report_abs(dev, ABS_MT_POSITION_Y, etd->mt[id].y);
 
-	if (sid >= 0) {
+	if (sid >= 0 && sid < ETP_MAX_FINGERS) {
 		etd->mt[sid].x += delta_x2 * weight;
 		etd->mt[sid].y -= delta_y2 * weight;
 		input_mt_slot(dev, sid);
diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index f0a7531f354c..2d240bfa819f 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -6,6 +6,7 @@ config EEPROM_AT24
 	depends on I2C && SYSFS
 	select NVMEM
 	select NVMEM_SYSFS
+	select REGMAP
 	select REGMAP_I2C
 	help
 	  Enable this driver to get read/write support to most I2C EEPROMs
diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 2e270b479143..a08e7cbb23c9 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1199,8 +1199,6 @@ static int lan9303_port_fdb_add(struct dsa_switch *ds, int port,
 	struct lan9303 *chip = ds->priv;
 
 	dev_dbg(chip->dev, "%s(%d, %pM, %d)\n", __func__, port, addr, vid);
-	if (vid)
-		return -EOPNOTSUPP;
 
 	return lan9303_alr_add_port(chip, addr, port, false);
 }
@@ -1212,8 +1210,6 @@ static int lan9303_port_fdb_del(struct dsa_switch *ds, int port,
 	struct lan9303 *chip = ds->priv;
 
 	dev_dbg(chip->dev, "%s(%d, %pM, %d)\n", __func__, port, addr, vid);
-	if (vid)
-		return -EOPNOTSUPP;
 	lan9303_alr_del_port(chip, addr, port);
 
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e3e5a427222f..6469fb8a42a8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2389,6 +2389,9 @@ static int bnxt_async_event_process(struct bnxt *bp,
 				struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 				u64 ns;
 
+				if (!ptp)
+					goto async_event_process_exit;
+
 				spin_lock_bh(&ptp->ptp_lock);
 				bnxt_ptp_update_current_time(bp);
 				ns = (((u64)BNXT_EVENT_PHC_RTC_UPDATE(data1) <<
@@ -4787,6 +4790,9 @@ int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap, int bmap_size,
 		if (event_id == ASYNC_EVENT_CMPL_EVENT_ID_ERROR_RECOVERY &&
 		    !(bp->fw_cap & BNXT_FW_CAP_ERROR_RECOVERY))
 			continue;
+		if (event_id == ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE &&
+		    !bp->ptp_cfg)
+			continue;
 		__set_bit(bnxt_async_events_arr[i], async_events_bmap);
 	}
 	if (bmap && bmap_size) {
@@ -8808,6 +8814,9 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		goto err_out;
 	}
 
+	if (BNXT_VF(bp))
+		bnxt_hwrm_func_qcfg(bp);
+
 	rc = bnxt_setup_vnic(bp, 0);
 	if (rc)
 		goto err_out;
@@ -11573,6 +11582,7 @@ static void bnxt_tx_timeout(struct net_device *dev, unsigned int txqueue)
 static void bnxt_fw_health_check(struct bnxt *bp)
 {
 	struct bnxt_fw_health *fw_health = bp->fw_health;
+	struct pci_dev *pdev = bp->pdev;
 	u32 val;
 
 	if (!fw_health->enabled || test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
@@ -11586,7 +11596,7 @@ static void bnxt_fw_health_check(struct bnxt *bp)
 	}
 
 	val = bnxt_fw_health_readl(bp, BNXT_FW_HEARTBEAT_REG);
-	if (val == fw_health->last_fw_heartbeat) {
+	if (val == fw_health->last_fw_heartbeat && pci_device_is_present(pdev)) {
 		fw_health->arrests++;
 		goto fw_reset;
 	}
@@ -11594,7 +11604,7 @@ static void bnxt_fw_health_check(struct bnxt *bp)
 	fw_health->last_fw_heartbeat = val;
 
 	val = bnxt_fw_health_readl(bp, BNXT_FW_RESET_CNT_REG);
-	if (val != fw_health->last_fw_reset_cnt) {
+	if (val != fw_health->last_fw_reset_cnt && pci_device_is_present(pdev)) {
 		fw_health->discoveries++;
 		goto fw_reset;
 	}
@@ -12998,26 +13008,37 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 
 #endif /* CONFIG_RFS_ACCEL */
 
-static int bnxt_udp_tunnel_sync(struct net_device *netdev, unsigned int table)
+static int bnxt_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
+				    unsigned int entry, struct udp_tunnel_info *ti)
 {
 	struct bnxt *bp = netdev_priv(netdev);
-	struct udp_tunnel_info ti;
 	unsigned int cmd;
 
-	udp_tunnel_nic_get_port(netdev, table, 0, &ti);
-	if (ti.type == UDP_TUNNEL_TYPE_VXLAN)
+	if (ti->type == UDP_TUNNEL_TYPE_VXLAN)
 		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN;
 	else
 		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE;
 
-	if (ti.port)
-		return bnxt_hwrm_tunnel_dst_port_alloc(bp, ti.port, cmd);
+	return bnxt_hwrm_tunnel_dst_port_alloc(bp, ti->port, cmd);
+}
+
+static int bnxt_udp_tunnel_unset_port(struct net_device *netdev, unsigned int table,
+				      unsigned int entry, struct udp_tunnel_info *ti)
+{
+	struct bnxt *bp = netdev_priv(netdev);
+	unsigned int cmd;
+
+	if (ti->type == UDP_TUNNEL_TYPE_VXLAN)
+		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN;
+	else
+		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE;
 
 	return bnxt_hwrm_tunnel_dst_port_free(bp, cmd);
 }
 
 static const struct udp_tunnel_nic_info bnxt_udp_tunnels = {
-	.sync_table	= bnxt_udp_tunnel_sync,
+	.set_port	= bnxt_udp_tunnel_set_port,
+	.unset_port	= bnxt_udp_tunnel_unset_port,
 	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP |
 			  UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
 	.tables		= {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index b2d531e014c5..89f046ce1373 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3727,7 +3727,7 @@ static int bnxt_reset(struct net_device *dev, u32 *flags)
 		}
 	}
 
-	if (req & BNXT_FW_RESET_AP) {
+	if (!BNXT_CHIP_P4_PLUS(bp) && (req & BNXT_FW_RESET_AP)) {
 		/* This feature is not supported in older firmware versions */
 		if (bp->hwrm_spec_code >= 0x10803) {
 			if (!bnxt_firmware_reset_ap(dev)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 2132ce63193c..4faaa9a50f4b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -929,6 +929,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 	} else {
 		bnxt_ptp_timecounter_init(bp, true);
 	}
+	bnxt_hwrm_func_drv_rgtr(bp, NULL, 0, true);
 
 	ptp->ptp_info = bnxt_ptp_caps;
 	if ((bp->fw_cap & BNXT_FW_CAP_PTP_PPS)) {
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 4da2becfa950..1ae082eb9e90 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1290,7 +1290,8 @@ static void bcmgenet_get_ethtool_stats(struct net_device *dev,
 	}
 }
 
-static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
+			     bool tx_lpi_enabled)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	u32 off = priv->hw_params->tbuf_offset + TBUF_ENERGY_CTRL;
@@ -1310,7 +1311,7 @@ static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 
 	/* Enable EEE and switch to a 27Mhz clock automatically */
 	reg = bcmgenet_readl(priv->base + off);
-	if (enable)
+	if (tx_lpi_enabled)
 		reg |= TBUF_EEE_EN | TBUF_PM_EN;
 	else
 		reg &= ~(TBUF_EEE_EN | TBUF_PM_EN);
@@ -1331,6 +1332,7 @@ static void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 
 	priv->eee.eee_enabled = enable;
 	priv->eee.eee_active = enable;
+	priv->eee.tx_lpi_enabled = tx_lpi_enabled;
 }
 
 static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_eee *e)
@@ -1346,6 +1348,7 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_eee *e)
 
 	e->eee_enabled = p->eee_enabled;
 	e->eee_active = p->eee_active;
+	e->tx_lpi_enabled = p->tx_lpi_enabled;
 	e->tx_lpi_timer = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);
 
 	return phy_ethtool_get_eee(dev->phydev, e);
@@ -1355,7 +1358,6 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_eee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct ethtool_eee *p = &priv->eee;
-	int ret = 0;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
@@ -1366,16 +1368,11 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_eee *e)
 	p->eee_enabled = e->eee_enabled;
 
 	if (!p->eee_enabled) {
-		bcmgenet_eee_enable_set(dev, false);
+		bcmgenet_eee_enable_set(dev, false, false);
 	} else {
-		ret = phy_init_eee(dev->phydev, false);
-		if (ret) {
-			netif_err(priv, hw, dev, "EEE initialization failed\n");
-			return ret;
-		}
-
+		p->eee_active = phy_init_eee(dev->phydev, false) >= 0;
 		bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
-		bcmgenet_eee_enable_set(dev, true);
+		bcmgenet_eee_enable_set(dev, p->eee_active, e->tx_lpi_enabled);
 	}
 
 	return phy_ethtool_set_eee(dev->phydev, e);
@@ -4274,9 +4271,6 @@ static int bcmgenet_resume(struct device *d)
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
 
-	if (priv->eee.eee_enabled)
-		bcmgenet_eee_enable_set(dev, true);
-
 	bcmgenet_netif_start(dev);
 
 	netif_device_attach(dev);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 946f6e283c4e..1985c0ec4da2 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -703,4 +703,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 			       enum bcmgenet_power_mode mode);
 
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
+			     bool tx_lpi_enabled);
+
 #endif /* __BCMGENET_H__ */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index ded0e64a9f6a..bf9e246784b6 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -88,6 +88,11 @@ static void bcmgenet_mac_config(struct net_device *dev)
 		reg |= CMD_TX_EN | CMD_RX_EN;
 	}
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+
+	priv->eee.eee_active = phy_init_eee(phydev, 0) >= 0;
+	bcmgenet_eee_enable_set(dev,
+				priv->eee.eee_enabled && priv->eee.eee_active,
+				priv->eee.tx_lpi_enabled);
 }
 
 /* setup netdev link state when PHY link status change and
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e96449eedfb5..25c303406e6b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1209,7 +1209,13 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 		if (!skb)
 			break;
 
-		rx_byte_cnt += skb->len;
+		/* When set, the outer VLAN header is extracted and reported
+		 * in the receive buffer descriptor. So rx_byte_cnt should
+		 * add the length of the extracted VLAN header.
+		 */
+		if (bd_status & ENETC_RXBD_FLAG_VLAN)
+			rx_byte_cnt += VLAN_HLEN;
+		rx_byte_cnt += skb->len + ETH_HLEN;
 		rx_frm_cnt++;
 
 		napi_gro_receive(napi, skb);
@@ -1532,6 +1538,14 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 		enetc_build_xdp_buff(rx_ring, bd_status, &rxbd, &i,
 				     &cleaned_cnt, &xdp_buff);
 
+		/* When set, the outer VLAN header is extracted and reported
+		 * in the receive buffer descriptor. So rx_byte_cnt should
+		 * add the length of the extracted VLAN header.
+		 */
+		if (bd_status & ENETC_RXBD_FLAG_VLAN)
+			rx_byte_cnt += VLAN_HLEN;
+		rx_byte_cnt += xdp_get_buff_len(&xdp_buff);
+
 		xdp_act = bpf_prog_run_xdp(prog, &xdp_buff);
 
 		switch (xdp_act) {
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 2edd6bf64a3c..7776d3bdd459 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -1903,7 +1903,7 @@ void qed_get_vport_stats(struct qed_dev *cdev, struct qed_eth_stats *stats)
 {
 	u32 i;
 
-	if (!cdev) {
+	if (!cdev || cdev->recov_in_prog) {
 		memset(stats, 0, sizeof(*stats));
 		return;
 	}
diff --git a/drivers/net/ethernet/qlogic/qede/qede.h b/drivers/net/ethernet/qlogic/qede/qede.h
index f90dcfe9ee68..8a63f99d499c 100644
--- a/drivers/net/ethernet/qlogic/qede/qede.h
+++ b/drivers/net/ethernet/qlogic/qede/qede.h
@@ -271,6 +271,10 @@ struct qede_dev {
 #define QEDE_ERR_WARN			3
 
 	struct qede_dump_info		dump_info;
+	struct delayed_work		periodic_task;
+	unsigned long			stats_coal_ticks;
+	u32				stats_coal_usecs;
+	spinlock_t			stats_lock; /* lock for vport stats access */
 };
 
 enum QEDE_STATE {
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 8034d812d5a0..d0a3395b2bc1 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -430,6 +430,8 @@ static void qede_get_ethtool_stats(struct net_device *dev,
 		}
 	}
 
+	spin_lock(&edev->stats_lock);
+
 	for (i = 0; i < QEDE_NUM_STATS; i++) {
 		if (qede_is_irrelevant_stat(edev, i))
 			continue;
@@ -439,6 +441,8 @@ static void qede_get_ethtool_stats(struct net_device *dev,
 		buf++;
 	}
 
+	spin_unlock(&edev->stats_lock);
+
 	__qede_unlock(edev);
 }
 
@@ -830,6 +834,7 @@ static int qede_get_coalesce(struct net_device *dev,
 
 	coal->rx_coalesce_usecs = rx_coal;
 	coal->tx_coalesce_usecs = tx_coal;
+	coal->stats_block_coalesce_usecs = edev->stats_coal_usecs;
 
 	return rc;
 }
@@ -843,6 +848,19 @@ int qede_set_coalesce(struct net_device *dev, struct ethtool_coalesce *coal,
 	int i, rc = 0;
 	u16 rxc, txc;
 
+	if (edev->stats_coal_usecs != coal->stats_block_coalesce_usecs) {
+		edev->stats_coal_usecs = coal->stats_block_coalesce_usecs;
+		if (edev->stats_coal_usecs) {
+			edev->stats_coal_ticks = usecs_to_jiffies(edev->stats_coal_usecs);
+			schedule_delayed_work(&edev->periodic_task, 0);
+
+			DP_INFO(edev, "Configured stats coal ticks=%lu jiffies\n",
+				edev->stats_coal_ticks);
+		} else {
+			cancel_delayed_work_sync(&edev->periodic_task);
+		}
+	}
+
 	if (!netif_running(dev)) {
 		DP_INFO(edev, "Interface is down\n");
 		return -EINVAL;
@@ -2253,7 +2271,8 @@ static int qede_get_per_coalesce(struct net_device *dev,
 }
 
 static const struct ethtool_ops qede_ethtool_ops = {
-	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS,
+	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
+					  ETHTOOL_COALESCE_STATS_BLOCK_USECS,
 	.get_link_ksettings		= qede_get_link_ksettings,
 	.set_link_ksettings		= qede_set_link_ksettings,
 	.get_drvinfo			= qede_get_drvinfo,
@@ -2304,7 +2323,8 @@ static const struct ethtool_ops qede_ethtool_ops = {
 };
 
 static const struct ethtool_ops qede_vf_ethtool_ops = {
-	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS,
+	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
+					  ETHTOOL_COALESCE_STATS_BLOCK_USECS,
 	.get_link_ksettings		= qede_get_link_ksettings,
 	.get_drvinfo			= qede_get_drvinfo,
 	.get_msglevel			= qede_get_msglevel,
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 89d64a5a4951..e8d427c7d1cf 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -308,6 +308,8 @@ void qede_fill_by_demand_stats(struct qede_dev *edev)
 
 	edev->ops->get_vport_stats(edev->cdev, &stats);
 
+	spin_lock(&edev->stats_lock);
+
 	p_common->no_buff_discards = stats.common.no_buff_discards;
 	p_common->packet_too_big_discard = stats.common.packet_too_big_discard;
 	p_common->ttl0_discard = stats.common.ttl0_discard;
@@ -405,6 +407,8 @@ void qede_fill_by_demand_stats(struct qede_dev *edev)
 		p_ah->tx_1519_to_max_byte_packets =
 		    stats.ah.tx_1519_to_max_byte_packets;
 	}
+
+	spin_unlock(&edev->stats_lock);
 }
 
 static void qede_get_stats64(struct net_device *dev,
@@ -413,9 +417,10 @@ static void qede_get_stats64(struct net_device *dev,
 	struct qede_dev *edev = netdev_priv(dev);
 	struct qede_stats_common *p_common;
 
-	qede_fill_by_demand_stats(edev);
 	p_common = &edev->stats.common;
 
+	spin_lock(&edev->stats_lock);
+
 	stats->rx_packets = p_common->rx_ucast_pkts + p_common->rx_mcast_pkts +
 			    p_common->rx_bcast_pkts;
 	stats->tx_packets = p_common->tx_ucast_pkts + p_common->tx_mcast_pkts +
@@ -435,6 +440,8 @@ static void qede_get_stats64(struct net_device *dev,
 		stats->collisions = edev->stats.bb.tx_total_collisions;
 	stats->rx_crc_errors = p_common->rx_crc_errors;
 	stats->rx_frame_errors = p_common->rx_align_errors;
+
+	spin_unlock(&edev->stats_lock);
 }
 
 #ifdef CONFIG_QED_SRIOV
@@ -1061,6 +1068,23 @@ static void qede_unlock(struct qede_dev *edev)
 	rtnl_unlock();
 }
 
+static void qede_periodic_task(struct work_struct *work)
+{
+	struct qede_dev *edev = container_of(work, struct qede_dev,
+					     periodic_task.work);
+
+	qede_fill_by_demand_stats(edev);
+	schedule_delayed_work(&edev->periodic_task, edev->stats_coal_ticks);
+}
+
+static void qede_init_periodic_task(struct qede_dev *edev)
+{
+	INIT_DELAYED_WORK(&edev->periodic_task, qede_periodic_task);
+	spin_lock_init(&edev->stats_lock);
+	edev->stats_coal_usecs = USEC_PER_SEC;
+	edev->stats_coal_ticks = usecs_to_jiffies(USEC_PER_SEC);
+}
+
 static void qede_sp_task(struct work_struct *work)
 {
 	struct qede_dev *edev = container_of(work, struct qede_dev,
@@ -1080,6 +1104,7 @@ static void qede_sp_task(struct work_struct *work)
 	 */
 
 	if (test_and_clear_bit(QEDE_SP_RECOVERY, &edev->sp_flags)) {
+		cancel_delayed_work_sync(&edev->periodic_task);
 #ifdef CONFIG_QED_SRIOV
 		/* SRIOV must be disabled outside the lock to avoid a deadlock.
 		 * The recovery of the active VFs is currently not supported.
@@ -1270,6 +1295,7 @@ static int __qede_probe(struct pci_dev *pdev, u32 dp_module, u8 dp_level,
 		 */
 		INIT_DELAYED_WORK(&edev->sp_task, qede_sp_task);
 		mutex_init(&edev->qede_lock);
+		qede_init_periodic_task(edev);
 
 		rc = register_netdev(edev->ndev);
 		if (rc) {
@@ -1294,6 +1320,11 @@ static int __qede_probe(struct pci_dev *pdev, u32 dp_module, u8 dp_level,
 	edev->rx_copybreak = QEDE_RX_HDR_SIZE;
 
 	qede_log_probe(edev);
+
+	/* retain user config (for example - after recovery) */
+	if (edev->stats_coal_usecs)
+		schedule_delayed_work(&edev->periodic_task, 0);
+
 	return 0;
 
 err4:
@@ -1362,6 +1393,7 @@ static void __qede_remove(struct pci_dev *pdev, enum qede_remove_mode mode)
 		unregister_netdev(ndev);
 
 		cancel_delayed_work_sync(&edev->sp_task);
+		cancel_delayed_work_sync(&edev->periodic_task);
 
 		edev->ops->common->set_power_state(cdev, PCI_D0);
 
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 766f86bdc4a0..9b1403291d92 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2199,6 +2199,11 @@ static void sfp_sm_module(struct sfp *sfp, unsigned int event)
 			break;
 		}
 
+		/* Force a poll to re-read the hardware signal state after
+		 * sfp_sm_mod_probe() changed state_hw_mask.
+		 */
+		mod_delayed_work(system_wq, &sfp->poll, 1);
+
 		err = sfp_hwmon_insert(sfp);
 		if (err)
 			dev_warn(sfp->dev, "hwmon probe failed: %pe\n",
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 47788f093551..fae302c5b0a9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -200,6 +200,8 @@ struct control_buf {
 	__virtio16 vid;
 	__virtio64 offloads;
 	struct virtio_net_ctrl_rss rss;
+	struct virtio_net_ctrl_coal_tx coal_tx;
+	struct virtio_net_ctrl_coal_rx coal_rx;
 };
 
 struct virtnet_info {
@@ -2786,12 +2788,10 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 				       struct ethtool_coalesce *ec)
 {
 	struct scatterlist sgs_tx, sgs_rx;
-	struct virtio_net_ctrl_coal_tx coal_tx;
-	struct virtio_net_ctrl_coal_rx coal_rx;
 
-	coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
-	coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
-	sg_init_one(&sgs_tx, &coal_tx, sizeof(coal_tx));
+	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
+	vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
+	sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
@@ -2802,9 +2802,9 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
 	vi->tx_usecs = ec->tx_coalesce_usecs;
 	vi->tx_max_packets = ec->tx_max_coalesced_frames;
 
-	coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
-	coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
-	sg_init_one(&sgs_rx, &coal_rx, sizeof(coal_rx));
+	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
+	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
+	sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index c876e81437fe..2748459d1227 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2724,17 +2724,13 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 		if (wowlan_info_ver < 2) {
 			struct iwl_wowlan_info_notif_v1 *notif_v1 = (void *)pkt->data;
 
-			notif = kmemdup(notif_v1,
-					offsetofend(struct iwl_wowlan_info_notif,
-						    received_beacons),
-					GFP_ATOMIC);
-
+			notif = kmemdup(notif_v1, sizeof(*notif), GFP_ATOMIC);
 			if (!notif)
 				return false;
 
 			notif->tid_tear_down = notif_v1->tid_tear_down;
 			notif->station_id = notif_v1->station_id;
-
+			memset_after(notif, 0, station_id);
 		} else {
 			notif = (void *)pkt->data;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index faed43b11ec9..40c80d09d108 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -921,7 +921,10 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 
 		msta = list_first_entry(&sta_poll_list, struct mt7615_sta,
 					poll_list);
+
+		spin_lock_bh(&dev->sta_poll_lock);
 		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
 
 		addr = mt7615_mac_wtbl_addr(dev, msta->wcid.idx) + 19 * 4;
 
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 62fb28f14c94..fabca307867a 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -88,15 +88,6 @@ static int rtw_ops_config(struct ieee80211_hw *hw, u32 changed)
 		}
 	}
 
-	if (changed & IEEE80211_CONF_CHANGE_PS) {
-		if (hw->conf.flags & IEEE80211_CONF_PS) {
-			rtwdev->ps_enabled = true;
-		} else {
-			rtwdev->ps_enabled = false;
-			rtw_leave_lps(rtwdev);
-		}
-	}
-
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
 		rtw_set_channel(rtwdev);
 
@@ -206,6 +197,7 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->bcn_ctrl = bcn_ctrl;
 	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
+	rtw_recalc_lps(rtwdev, vif);
 
 	mutex_unlock(&rtwdev->mutex);
 
@@ -236,6 +228,7 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 	rtwvif->bcn_ctrl = 0;
 	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
+	rtw_recalc_lps(rtwdev, NULL);
 
 	mutex_unlock(&rtwdev->mutex);
 }
@@ -428,6 +421,9 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ERP_SLOT)
 		rtw_conf_tx(rtwdev, rtwvif);
 
+	if (changed & BSS_CHANGED_PS)
+		rtw_recalc_lps(rtwdev, NULL);
+
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 
 	mutex_unlock(&rtwdev->mutex);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 8080ace5ed51..4c8164db4a9e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -248,8 +248,8 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	 * more than two stations associated to the AP, then we can not enter
 	 * lps, because fw does not handle the overlapped beacon interval
 	 *
-	 * mac80211 should iterate vifs and determine if driver can enter
-	 * ps by passing IEEE80211_CONF_PS to us, all we need to do is to
+	 * rtw_recalc_lps() iterate vifs and determine if driver can enter
+	 * ps by vif->type and vif->cfg.ps, all we need to do here is to
 	 * get that vif and check if device is having traffic more than the
 	 * threshold.
 	 */
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index dc0d85218245..7ac35c368d7a 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -299,3 +299,46 @@ void rtw_leave_lps_deep(struct rtw_dev *rtwdev)
 
 	__rtw_leave_lps_deep(rtwdev);
 }
+
+struct rtw_vif_recalc_lps_iter_data {
+	struct rtw_dev *rtwdev;
+	struct ieee80211_vif *found_vif;
+	int count;
+};
+
+static void __rtw_vif_recalc_lps(struct rtw_vif_recalc_lps_iter_data *data,
+				 struct ieee80211_vif *vif)
+{
+	if (data->count < 0)
+		return;
+
+	if (vif->type != NL80211_IFTYPE_STATION) {
+		data->count = -1;
+		return;
+	}
+
+	data->count++;
+	data->found_vif = vif;
+}
+
+static void rtw_vif_recalc_lps_iter(void *data, u8 *mac,
+				    struct ieee80211_vif *vif)
+{
+	__rtw_vif_recalc_lps(data, vif);
+}
+
+void rtw_recalc_lps(struct rtw_dev *rtwdev, struct ieee80211_vif *new_vif)
+{
+	struct rtw_vif_recalc_lps_iter_data data = { .rtwdev = rtwdev };
+
+	if (new_vif)
+		__rtw_vif_recalc_lps(&data, new_vif);
+	rtw_iterate_vifs(rtwdev, rtw_vif_recalc_lps_iter, &data);
+
+	if (data.count == 1 && data.found_vif->cfg.ps) {
+		rtwdev->ps_enabled = true;
+	} else {
+		rtwdev->ps_enabled = false;
+		rtw_leave_lps(rtwdev);
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index c194386f6db5..5ae83d2526cf 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -23,4 +23,6 @@ void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id);
 void rtw_leave_lps(struct rtw_dev *rtwdev);
 void rtw_leave_lps_deep(struct rtw_dev *rtwdev);
 enum rtw_lps_deep_mode rtw_get_lps_deep_mode(struct rtw_dev *rtwdev);
+void rtw_recalc_lps(struct rtw_dev *rtwdev, struct ieee80211_vif *new_vif);
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a296bfa8188f..a8f478f0cde9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -78,15 +78,6 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
 	    !(hw->conf.flags & IEEE80211_CONF_IDLE))
 		rtw89_leave_ips(rtwdev);
 
-	if (changed & IEEE80211_CONF_CHANGE_PS) {
-		if (hw->conf.flags & IEEE80211_CONF_PS) {
-			rtwdev->lps_enabled = true;
-		} else {
-			rtw89_leave_lps(rtwdev);
-			rtwdev->lps_enabled = false;
-		}
-	}
-
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 		rtw89_config_entity_chandef(rtwdev, RTW89_SUB_ENTITY_0,
 					    &hw->conf.chandef);
@@ -142,6 +133,8 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtw89_core_txq_init(rtwdev, vif->txq);
 
 	rtw89_btc_ntfy_role_info(rtwdev, rtwvif, NULL, BTC_ROLE_START);
+
+	rtw89_recalc_lps(rtwdev);
 out:
 	mutex_unlock(&rtwdev->mutex);
 
@@ -165,6 +158,8 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 	rtw89_mac_remove_vif(rtwdev, rtwvif);
 	rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif->port);
 	list_del_init(&rtwvif->list);
+	rtw89_recalc_lps(rtwdev);
+
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -411,6 +406,9 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_P2P_PS)
 		rtw89_process_p2p_ps(rtwdev, vif);
 
+	if (changed & BSS_CHANGED_PS)
+		rtw89_recalc_lps(rtwdev);
+
 	mutex_unlock(&rtwdev->mutex);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index bf41a1141679..7cf9f80c7a93 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -244,3 +244,29 @@ void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 	rtw89_p2p_disable_all_noa(rtwdev, vif);
 	rtw89_p2p_update_noa(rtwdev, vif);
 }
+
+void rtw89_recalc_lps(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_vif *vif, *found_vif = NULL;
+	struct rtw89_vif *rtwvif;
+	int count = 0;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		vif = rtwvif_to_vif(rtwvif);
+
+		if (vif->type != NL80211_IFTYPE_STATION) {
+			count = 0;
+			break;
+		}
+
+		count++;
+		found_vif = vif;
+	}
+
+	if (count == 1 && found_vif->cfg.ps) {
+		rtwdev->lps_enabled = true;
+	} else {
+		rtw89_leave_lps(rtwdev);
+		rtwdev->lps_enabled = false;
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index 0feae3991623..49fb9d8b6546 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -13,5 +13,6 @@ void rtw89_enter_ips(struct rtw89_dev *rtwdev);
 void rtw89_leave_ips(struct rtw89_dev *rtwdev);
 void rtw89_set_coex_ctrl_lps(struct rtw89_dev *rtwdev, bool btc_ctrl);
 void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
+void rtw89_recalc_lps(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index 7bfecdfba177..d249a035c2b9 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -400,6 +400,7 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GPIO_GROUP(GPIOA_15),
 	GPIO_GROUP(GPIOA_16),
 	GPIO_GROUP(GPIOA_17),
+	GPIO_GROUP(GPIOA_18),
 	GPIO_GROUP(GPIOA_19),
 	GPIO_GROUP(GPIOA_20),
 
diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index c6537a1b3a2e..30cea324ff95 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -825,7 +825,7 @@ static int ssam_cplt_init(struct ssam_cplt *cplt, struct device *dev)
 
 	cplt->dev = dev;
 
-	cplt->wq = create_workqueue(SSAM_CPLT_WQ_NAME);
+	cplt->wq = alloc_workqueue(SSAM_CPLT_WQ_NAME, WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	if (!cplt->wq)
 		return -ENOMEM;
 
diff --git a/drivers/platform/surface/surface_aggregator_tabletsw.c b/drivers/platform/surface/surface_aggregator_tabletsw.c
index 27d95a6a7851..af8b547cffdc 100644
--- a/drivers/platform/surface/surface_aggregator_tabletsw.c
+++ b/drivers/platform/surface/surface_aggregator_tabletsw.c
@@ -201,6 +201,7 @@ enum ssam_kip_cover_state {
 	SSAM_KIP_COVER_STATE_LAPTOP        = 0x03,
 	SSAM_KIP_COVER_STATE_FOLDED_CANVAS = 0x04,
 	SSAM_KIP_COVER_STATE_FOLDED_BACK   = 0x05,
+	SSAM_KIP_COVER_STATE_BOOK          = 0x06,
 };
 
 static const char *ssam_kip_cover_state_name(struct ssam_tablet_sw *sw, u32 state)
@@ -221,6 +222,9 @@ static const char *ssam_kip_cover_state_name(struct ssam_tablet_sw *sw, u32 stat
 	case SSAM_KIP_COVER_STATE_FOLDED_BACK:
 		return "folded-back";
 
+	case SSAM_KIP_COVER_STATE_BOOK:
+		return "book";
+
 	default:
 		dev_warn(&sw->sdev->dev, "unknown KIP cover state: %u\n", state);
 		return "<unknown>";
@@ -233,6 +237,7 @@ static bool ssam_kip_cover_state_is_tablet_mode(struct ssam_tablet_sw *sw, u32 s
 	case SSAM_KIP_COVER_STATE_DISCONNECTED:
 	case SSAM_KIP_COVER_STATE_FOLDED_CANVAS:
 	case SSAM_KIP_COVER_STATE_FOLDED_BACK:
+	case SSAM_KIP_COVER_STATE_BOOK:
 		return true;
 
 	case SSAM_KIP_COVER_STATE_CLOSED:
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 9327dcdd6e5e..8fca725b3dae 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -552,10 +552,10 @@ static int __dasd_ioctl_information(struct dasd_block *block,
 
 	memcpy(dasd_info->type, base->discipline->name, 4);
 
-	spin_lock_irqsave(&block->queue_lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
 	list_for_each(l, &base->ccw_queue)
 		dasd_info->chanq_len++;
-	spin_unlock_irqrestore(&block->queue_lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 	return 0;
 }
 
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index af22ffa8f6a2..1475f3e259c1 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3323,7 +3323,7 @@ static void megasas_prepare_secondRaid1_IO(struct megasas_instance *instance,
 	/* copy the io request frame as well as 8 SGEs data for r1 command*/
 	memcpy(r1_cmd->io_request, cmd->io_request,
 	       (sizeof(struct MPI2_RAID_SCSI_IO_REQUEST)));
-	memcpy(&r1_cmd->io_request->SGL, &cmd->io_request->SGL,
+	memcpy(r1_cmd->io_request->SGLs, cmd->io_request->SGLs,
 	       (fusion->max_sge_in_main_msg * sizeof(union MPI2_SGE_IO_UNION)));
 	/*sense buffer is different for r1 command*/
 	r1_cmd->io_request->SenseBufferLowAddress =
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
index 49e9a9048ee7..b677d80e5874 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -526,7 +526,10 @@ struct MPI2_RAID_SCSI_IO_REQUEST {
 	__le32			Control;                        /* 0x3C */
 	union MPI2_SCSI_IO_CDB_UNION  CDB;			/* 0x40 */
 	union RAID_CONTEXT_UNION RaidContext;  /* 0x60 */
-	union MPI2_SGE_IO_UNION       SGL;			/* 0x80 */
+	union {
+		union MPI2_SGE_IO_UNION       SGL;		/* 0x80 */
+		DECLARE_FLEX_ARRAY(union MPI2_SGE_IO_UNION, SGLs);
+	};
 };
 
 /*
diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index d07be3700db6..7829549993c9 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -603,12 +603,12 @@ static int bwmon_probe(struct platform_device *pdev)
 	bwmon->max_bw_kbps = UINT_MAX;
 	opp = dev_pm_opp_find_bw_floor(dev, &bwmon->max_bw_kbps, 0);
 	if (IS_ERR(opp))
-		return dev_err_probe(dev, ret, "failed to find max peak bandwidth\n");
+		return dev_err_probe(dev, PTR_ERR(opp), "failed to find max peak bandwidth\n");
 
 	bwmon->min_bw_kbps = 0;
 	opp = dev_pm_opp_find_bw_ceil(dev, &bwmon->min_bw_kbps, 0);
 	if (IS_ERR(opp))
-		return dev_err_probe(dev, ret, "failed to find min peak bandwidth\n");
+		return dev_err_probe(dev, PTR_ERR(opp), "failed to find min peak bandwidth\n");
 
 	bwmon->dev = dev;
 
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index bd502368339e..b10ea69a638e 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -2019,8 +2019,10 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 
 skip_alloc_master_rt:
 	s_rt = sdw_slave_rt_find(slave, stream);
-	if (s_rt)
+	if (s_rt) {
+		alloc_slave_rt = false;
 		goto skip_alloc_slave_rt;
+	}
 
 	s_rt = sdw_slave_rt_alloc(slave, m_rt);
 	if (!s_rt) {
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 9eab6c20dbc5..6e95efb50acb 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1275,6 +1275,9 @@ static int mtk_spi_remove(struct platform_device *pdev)
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	int ret;
 
+	if (mdata->use_spimem && !completion_done(&mdata->spimem_done))
+		complete(&mdata->spimem_done);
+
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 205e54f157b4..fb6b7738b4f5 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1029,23 +1029,8 @@ static int spi_qup_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	ret = clk_prepare_enable(cclk);
-	if (ret) {
-		dev_err(dev, "cannot enable core clock\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(iclk);
-	if (ret) {
-		clk_disable_unprepare(cclk);
-		dev_err(dev, "cannot enable iface clock\n");
-		return ret;
-	}
-
 	master = spi_alloc_master(dev, sizeof(struct spi_qup));
 	if (!master) {
-		clk_disable_unprepare(cclk);
-		clk_disable_unprepare(iclk);
 		dev_err(dev, "cannot allocate master\n");
 		return -ENOMEM;
 	}
@@ -1093,6 +1078,19 @@ static int spi_qup_probe(struct platform_device *pdev)
 	spin_lock_init(&controller->lock);
 	init_completion(&controller->done);
 
+	ret = clk_prepare_enable(cclk);
+	if (ret) {
+		dev_err(dev, "cannot enable core clock\n");
+		goto error_dma;
+	}
+
+	ret = clk_prepare_enable(iclk);
+	if (ret) {
+		clk_disable_unprepare(cclk);
+		dev_err(dev, "cannot enable iface clock\n");
+		goto error_dma;
+	}
+
 	iomode = readl_relaxed(base + QUP_IO_M_MODES);
 
 	size = QUP_IO_M_OUTPUT_BLOCK_SIZE(iomode);
@@ -1122,7 +1120,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
 	if (ret) {
 		dev_err(dev, "cannot set RESET state\n");
-		goto error_dma;
+		goto error_clk;
 	}
 
 	writel_relaxed(0, base + QUP_OPERATIONAL);
@@ -1146,7 +1144,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, irq, spi_qup_qup_irq,
 			       IRQF_TRIGGER_HIGH, pdev->name, controller);
 	if (ret)
-		goto error_dma;
+		goto error_clk;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
@@ -1161,11 +1159,12 @@ static int spi_qup_probe(struct platform_device *pdev)
 
 disable_pm:
 	pm_runtime_disable(&pdev->dev);
+error_clk:
+	clk_disable_unprepare(cclk);
+	clk_disable_unprepare(iclk);
 error_dma:
 	spi_qup_release_dma(master);
 error:
-	clk_disable_unprepare(cclk);
-	clk_disable_unprepare(iclk);
 	spi_master_put(master);
 	return ret;
 }
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 7e11364d718b..c1e50084172d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -48,9 +48,9 @@ static const struct rtl819x_ops rtl819xp_ops = {
 };
 
 static struct pci_device_id rtl8192_pci_id_tbl[] = {
-	{PCI_DEVICE(0x10ec, 0x8192)},
-	{PCI_DEVICE(0x07aa, 0x0044)},
-	{PCI_DEVICE(0x07aa, 0x0047)},
+	{RTL_PCI_DEVICE(0x10ec, 0x8192, rtl819xp_ops)},
+	{RTL_PCI_DEVICE(0x07aa, 0x0044, rtl819xp_ops)},
+	{RTL_PCI_DEVICE(0x07aa, 0x0047, rtl819xp_ops)},
 	{}
 };
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 50f1ec78cc45..7021f9c435d9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -55,6 +55,11 @@
 #define IS_HARDWARE_TYPE_8192SE(_priv)		\
 	(((struct r8192_priv *)rtllib_priv(dev))->card_8192 == NIC_8192SE)
 
+#define RTL_PCI_DEVICE(vend, dev, cfg) \
+	.vendor = (vend), .device = (dev), \
+	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
+	.driver_data = (kernel_ulong_t)&(cfg)
+
 #define TOTAL_CAM_ENTRY		32
 #define CAM_CONTENT_COUNT	8
 
diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee_if.h
index ff48c3e47375..e2014e21530a 100644
--- a/drivers/tee/amdtee/amdtee_if.h
+++ b/drivers/tee/amdtee/amdtee_if.h
@@ -118,16 +118,18 @@ struct tee_cmd_unmap_shared_mem {
 
 /**
  * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TEE
- * @low_addr:    [in] bits [31:0] of the physical address of the TA binary
- * @hi_addr:     [in] bits [63:32] of the physical address of the TA binary
- * @size:        [in] size of TA binary in bytes
- * @ta_handle:   [out] return handle of the loaded TA
+ * @low_addr:       [in] bits [31:0] of the physical address of the TA binary
+ * @hi_addr:        [in] bits [63:32] of the physical address of the TA binary
+ * @size:           [in] size of TA binary in bytes
+ * @ta_handle:      [out] return handle of the loaded TA
+ * @return_origin:  [out] origin of return code after TEE processing
  */
 struct tee_cmd_load_ta {
 	u32 low_addr;
 	u32 hi_addr;
 	u32 size;
 	u32 ta_handle;
+	u32 return_origin;
 };
 
 /**
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index cec6e70f0ac9..8a02c5fe33a6 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -423,19 +423,23 @@ int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
 	if (ret) {
 		arg->ret_origin = TEEC_ORIGIN_COMMS;
 		arg->ret = TEEC_ERROR_COMMUNICATION;
-	} else if (arg->ret == TEEC_SUCCESS) {
-		ret = get_ta_refcount(load_cmd.ta_handle);
-		if (!ret) {
-			arg->ret_origin = TEEC_ORIGIN_COMMS;
-			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
-
-			/* Unload the TA on error */
-			unload_cmd.ta_handle = load_cmd.ta_handle;
-			psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
-					    (void *)&unload_cmd,
-					    sizeof(unload_cmd), &ret);
-		} else {
-			set_session_id(load_cmd.ta_handle, 0, &arg->session);
+	} else {
+		arg->ret_origin = load_cmd.return_origin;
+
+		if (arg->ret == TEEC_SUCCESS) {
+			ret = get_ta_refcount(load_cmd.ta_handle);
+			if (!ret) {
+				arg->ret_origin = TEEC_ORIGIN_COMMS;
+				arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+
+				/* Unload the TA on error */
+				unload_cmd.ta_handle = load_cmd.ta_handle;
+				psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
+						    (void *)&unload_cmd,
+						    sizeof(unload_cmd), &ret);
+			} else {
+				set_session_id(load_cmd.ta_handle, 0, &arg->session);
+			}
 		}
 	}
 	mutex_unlock(&ta_refcount_mutex);
diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index fbb087b728dc..268ccbec88f9 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -172,3 +172,44 @@ void hcd_buffer_free(
 	}
 	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
 }
+
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd,
+		size_t size, gfp_t mem_flags, dma_addr_t *dma)
+{
+	if (size == 0)
+		return NULL;
+
+	if (hcd->localmem_pool)
+		return gen_pool_dma_alloc_align(hcd->localmem_pool,
+				size, dma, PAGE_SIZE);
+
+	/* some USB hosts just use PIO */
+	if (!hcd_uses_dma(hcd)) {
+		*dma = DMA_MAPPING_ERROR;
+		return (void *)__get_free_pages(mem_flags,
+				get_order(size));
+	}
+
+	return dma_alloc_coherent(hcd->self.sysdev,
+			size, dma, mem_flags);
+}
+
+void hcd_buffer_free_pages(struct usb_hcd *hcd,
+		size_t size, void *addr, dma_addr_t dma)
+{
+	if (!addr)
+		return;
+
+	if (hcd->localmem_pool) {
+		gen_pool_free(hcd->localmem_pool,
+				(unsigned long)addr, size);
+		return;
+	}
+
+	if (!hcd_uses_dma(hcd)) {
+		free_pages((unsigned long)addr, get_order(size));
+		return;
+	}
+
+	dma_free_coherent(hcd->self.sysdev, size, addr, dma);
+}
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 837f3e57f580..984de3f5e8eb 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -186,6 +186,7 @@ static int connected(struct usb_dev_state *ps)
 static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
 {
 	struct usb_dev_state *ps = usbm->ps;
+	struct usb_hcd *hcd = bus_to_hcd(ps->dev->bus);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ps->lock, flags);
@@ -194,8 +195,8 @@ static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
 		list_del(&usbm->memlist);
 		spin_unlock_irqrestore(&ps->lock, flags);
 
-		usb_free_coherent(ps->dev, usbm->size, usbm->mem,
-				usbm->dma_handle);
+		hcd_buffer_free_pages(hcd, usbm->size,
+				usbm->mem, usbm->dma_handle);
 		usbfs_decrease_memory_usage(
 			usbm->size + sizeof(struct usb_memory));
 		kfree(usbm);
@@ -234,7 +235,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	size_t size = vma->vm_end - vma->vm_start;
 	void *mem;
 	unsigned long flags;
-	dma_addr_t dma_handle;
+	dma_addr_t dma_handle = DMA_MAPPING_ERROR;
 	int ret;
 
 	ret = usbfs_increase_memory_usage(size + sizeof(struct usb_memory));
@@ -247,8 +248,8 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 		goto error_decrease_mem;
 	}
 
-	mem = usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN,
-			&dma_handle);
+	mem = hcd_buffer_alloc_pages(hcd,
+			size, GFP_USER | __GFP_NOWARN, &dma_handle);
 	if (!mem) {
 		ret = -ENOMEM;
 		goto error_free_usbm;
@@ -264,7 +265,14 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	usbm->vma_use_count = 1;
 	INIT_LIST_HEAD(&usbm->memlist);
 
-	if (hcd->localmem_pool || !hcd_uses_dma(hcd)) {
+	/*
+	 * In DMA-unavailable cases, hcd_buffer_alloc_pages allocates
+	 * normal pages and assigns DMA_MAPPING_ERROR to dma_handle. Check
+	 * whether we are in such cases, and then use remap_pfn_range (or
+	 * dma_mmap_coherent) to map normal (or DMA) pages into the user
+	 * space, respectively.
+	 */
+	if (dma_handle == DMA_MAPPING_ERROR) {
 		if (remap_pfn_range(vma, vma->vm_start,
 				    virt_to_phys(usbm->mem) >> PAGE_SHIFT,
 				    size, vma->vm_page_prot) < 0) {
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 31017ebc4d7c..72f924ec4658 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1443,6 +1443,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
 	if (config->vq_num > 0xffff)
 		return false;
 
+	if (!config->name[0])
+		return false;
+
 	if (!device_is_allowed(config->device_id))
 		return false;
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 6f532da59e08..d591f77961aa 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -549,7 +549,14 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		if (r)
 			return r;
 
-		vq->last_avail_idx = vq_state.split.avail_index;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq->last_avail_idx = vq_state.packed.last_avail_idx |
+					     (vq_state.packed.last_avail_counter << 15);
+			vq->last_used_idx = vq_state.packed.last_used_idx |
+					    (vq_state.packed.last_used_counter << 15);
+		} else {
+			vq->last_avail_idx = vq_state.split.avail_index;
+		}
 		break;
 	}
 
@@ -567,9 +574,15 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		break;
 
 	case VHOST_SET_VRING_BASE:
-		vq_state.split.avail_index = vq->last_avail_idx;
-		if (ops->set_vq_state(vdpa, idx, &vq_state))
-			r = -EINVAL;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq_state.packed.last_avail_idx = vq->last_avail_idx & 0x7fff;
+			vq_state.packed.last_avail_counter = !!(vq->last_avail_idx & 0x8000);
+			vq_state.packed.last_used_idx = vq->last_used_idx & 0x7fff;
+			vq_state.packed.last_used_counter = !!(vq->last_used_idx & 0x8000);
+		} else {
+			vq_state.split.avail_index = vq->last_avail_idx;
+		}
+		r = ops->set_vq_state(vdpa, idx, &vq_state);
 		break;
 
 	case VHOST_SET_VRING_CALL:
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 43c9770b86e5..1a059b028c50 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1633,17 +1633,25 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 			r = -EFAULT;
 			break;
 		}
-		if (s.num > 0xffff) {
-			r = -EINVAL;
-			break;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+			vq->last_avail_idx = s.num & 0xffff;
+			vq->last_used_idx = (s.num >> 16) & 0xffff;
+		} else {
+			if (s.num > 0xffff) {
+				r = -EINVAL;
+				break;
+			}
+			vq->last_avail_idx = s.num;
 		}
-		vq->last_avail_idx = s.num;
 		/* Forget the cached index value. */
 		vq->avail_idx = vq->last_avail_idx;
 		break;
 	case VHOST_GET_VRING_BASE:
 		s.index = idx;
-		s.num = vq->last_avail_idx;
+		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+			s.num = (u32)vq->last_avail_idx | ((u32)vq->last_used_idx << 16);
+		else
+			s.num = vq->last_avail_idx;
 		if (copy_to_user(argp, &s, sizeof s))
 			r = -EFAULT;
 		break;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 790b296271f1..5e17c4aa7374 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -85,13 +85,17 @@ struct vhost_virtqueue {
 	/* The routine to call when the Guest pings us, or timeout. */
 	vhost_work_fn_t handle_kick;
 
-	/* Last available index we saw. */
+	/* Last available index we saw.
+	 * Values are limited to 0x7fff, and the high bit is used as
+	 * a wrap counter when using VIRTIO_F_RING_PACKED. */
 	u16 last_avail_idx;
 
 	/* Caches available index value from user. */
 	u16 avail_idx;
 
-	/* Last index we used. */
+	/* Last index we used.
+	 * Values are limited to 0x7fff, and the high bit is used as
+	 * a wrap counter when using VIRTIO_F_RING_PACKED. */
 	u16 last_used_idx;
 
 	/* Used flags */
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index f73b2f62afaa..07dc4ec73520 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1357,6 +1357,7 @@ static int afs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	op->dentry	= dentry;
 	op->create.mode	= S_IFDIR | mode;
 	op->create.reason = afs_edit_dir_for_mkdir;
+	op->mtime	= current_time(dir);
 	op->ops		= &afs_mkdir_operation;
 	return afs_do_sync_operation(op);
 }
@@ -1660,6 +1661,7 @@ static int afs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	op->dentry	= dentry;
 	op->create.mode	= S_IFREG | mode;
 	op->create.reason = afs_edit_dir_for_create;
+	op->mtime	= current_time(dir);
 	op->ops		= &afs_create_operation;
 	return afs_do_sync_operation(op);
 
@@ -1795,6 +1797,7 @@ static int afs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	op->ops			= &afs_symlink_operation;
 	op->create.reason	= afs_edit_dir_for_symlink;
 	op->create.symlink	= content;
+	op->mtime		= current_time(dir);
 	return afs_do_sync_operation(op);
 
 error:
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index faf117802112..cdb26aadae12 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1626,6 +1626,7 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 	struct inode *inode = &ci->netfs.inode;
 	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
 	struct ceph_mds_session *session = NULL;
+	bool need_put = false;
 	int mds;
 
 	dout("ceph_flush_snaps %p\n", inode);
@@ -1670,8 +1671,13 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 		ceph_put_mds_session(session);
 	/* we flushed them all; remove this inode from the queue */
 	spin_lock(&mdsc->snap_flush_lock);
+	if (!list_empty(&ci->i_snap_flush_item))
+		need_put = true;
 	list_del_init(&ci->i_snap_flush_item);
 	spin_unlock(&mdsc->snap_flush_lock);
+
+	if (need_put)
+		iput(inode);
 }
 
 /*
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 0b236ebd989f..2e73ba62bd7a 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -693,8 +693,10 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 	     capsnap->size);
 
 	spin_lock(&mdsc->snap_flush_lock);
-	if (list_empty(&ci->i_snap_flush_item))
+	if (list_empty(&ci->i_snap_flush_item)) {
+		ihold(inode);
 		list_add_tail(&ci->i_snap_flush_item, &mdsc->snap_flush_list);
+	}
 	spin_unlock(&mdsc->snap_flush_lock);
 	return 1;  /* caller may want to ceph_flush_snaps */
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5db1060b8684..760249d9152d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6341,7 +6341,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	struct ext4_mount_options old_opts;
 	ext4_group_t g;
 	int err = 0;
-	int enable_rw = 0;
 #ifdef CONFIG_QUOTA
 	int enable_quota = 0;
 	int i, j;
@@ -6528,7 +6527,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 			if (err)
 				goto restore_opts;
 
-			enable_rw = 1;
+			sb->s_flags &= ~SB_RDONLY;
 			if (ext4_has_feature_mmp(sb)) {
 				err = ext4_multi_mount_protect(sb,
 						le64_to_cpu(es->s_mmp_block));
@@ -6575,9 +6574,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
-	if (enable_rw)
-		sb->s_flags &= ~SB_RDONLY;
-
 	/*
 	 * Reinitialize lazy itable initialization thread based on
 	 * current settings
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index fddde5045d0c..51d642a95bd2 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2006,8 +2006,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			else {
 				u32 ref;
 
+#ifdef EXT4_XATTR_DEBUG
 				WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 				/* The old block is released after updating
 				   the inode. */
 				error = dquot_alloc_block(inode,
@@ -2070,8 +2071,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			/* We need to allocate a new block */
 			ext4_fsblk_t goal, block;
 
+#ifdef EXT4_XATTR_DEBUG
 			WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 			goal = ext4_group_first_block_no(sb,
 						EXT4_I(inode)->i_block_group);
 			block = ext4_new_meta_blocks(handle, inode, goal, 0,
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index b371754540f9..bf8531b80a18 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -296,6 +296,9 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 	return true;
 }
 
+#define SMB1_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb_hdr))
+#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr) + 4)
+
 /**
  * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
  * @p:		connection instance
@@ -352,6 +355,9 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > MAX_STREAM_PROT_LEN)
 			break;
 
+		if (pdu_size < SMB1_MIN_SUPPORTED_HEADER_SIZE)
+			break;
+
 		/* 4 for rfc1002 length field */
 		/* 1 for implied bcc[0] */
 		size = pdu_size + 4 + 1;
@@ -379,6 +385,12 @@ int ksmbd_conn_handler_loop(void *p)
 			continue;
 		}
 
+		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
+		    SMB2_PROTO_NUMBER) {
+			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
+				break;
+		}
+
 		if (!default_conn_ops.process_fn) {
 			pr_err("No connection request callback\n");
 			break;
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index cbfed03a1e5c..4b210cdd7556 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1415,56 +1415,38 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
  */
 struct lease_ctx_info *parse_lease_state(void *open_req)
 {
-	char *data_offset;
 	struct create_context *cc;
-	unsigned int next = 0;
-	char *name;
-	bool found = false;
 	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
-	struct lease_ctx_info *lreq = kzalloc(sizeof(struct lease_ctx_info),
-		GFP_KERNEL);
+	struct lease_ctx_info *lreq;
+
+	cc = smb2_find_context_vals(req, SMB2_CREATE_REQUEST_LEASE, 4);
+	if (IS_ERR_OR_NULL(cc))
+		return NULL;
+
+	lreq = kzalloc(sizeof(struct lease_ctx_info), GFP_KERNEL);
 	if (!lreq)
 		return NULL;
 
-	data_offset = (char *)req + le32_to_cpu(req->CreateContextsOffset);
-	cc = (struct create_context *)data_offset;
-	do {
-		cc = (struct create_context *)((char *)cc + next);
-		name = le16_to_cpu(cc->NameOffset) + (char *)cc;
-		if (le16_to_cpu(cc->NameLength) != 4 ||
-		    strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
-			next = le32_to_cpu(cc->Next);
-			continue;
-		}
-		found = true;
-		break;
-	} while (next != 0);
+	if (sizeof(struct lease_context_v2) == le32_to_cpu(cc->DataLength)) {
+		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
-	if (found) {
-		if (sizeof(struct lease_context_v2) == le32_to_cpu(cc->DataLength)) {
-			struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
-
-			memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-			lreq->req_state = lc->lcontext.LeaseState;
-			lreq->flags = lc->lcontext.LeaseFlags;
-			lreq->duration = lc->lcontext.LeaseDuration;
-			memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
-			       SMB2_LEASE_KEY_SIZE);
-			lreq->version = 2;
-		} else {
-			struct create_lease *lc = (struct create_lease *)cc;
+		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
+		lreq->req_state = lc->lcontext.LeaseState;
+		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->duration = lc->lcontext.LeaseDuration;
+		memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
+				SMB2_LEASE_KEY_SIZE);
+		lreq->version = 2;
+	} else {
+		struct create_lease *lc = (struct create_lease *)cc;
 
-			memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-			lreq->req_state = lc->lcontext.LeaseState;
-			lreq->flags = lc->lcontext.LeaseFlags;
-			lreq->duration = lc->lcontext.LeaseDuration;
-			lreq->version = 1;
-		}
-		return lreq;
+		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
+		lreq->req_state = lc->lcontext.LeaseState;
+		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->duration = lc->lcontext.LeaseDuration;
+		lreq->version = 1;
 	}
-
-	kfree(lreq);
-	return NULL;
+	return lreq;
 }
 
 /**
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 01887570efe8..56f661e5ef62 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -979,13 +979,13 @@ static void decode_sign_cap_ctxt(struct ksmbd_conn *conn,
 
 static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 				      struct smb2_negotiate_req *req,
-				      int len_of_smb)
+				      unsigned int len_of_smb)
 {
 	/* +4 is to account for the RFC1001 len field */
 	struct smb2_neg_context *pctx = (struct smb2_neg_context *)req;
 	int i = 0, len_of_ctxts;
-	int offset = le32_to_cpu(req->NegotiateContextOffset);
-	int neg_ctxt_cnt = le16_to_cpu(req->NegotiateContextCount);
+	unsigned int offset = le32_to_cpu(req->NegotiateContextOffset);
+	unsigned int neg_ctxt_cnt = le16_to_cpu(req->NegotiateContextCount);
 	__le32 status = STATUS_INVALID_PARAMETER;
 
 	ksmbd_debug(SMB, "decoding %d negotiate contexts\n", neg_ctxt_cnt);
@@ -999,7 +999,7 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 	while (i++ < neg_ctxt_cnt) {
 		int clen, ctxt_len;
 
-		if (len_of_ctxts < sizeof(struct smb2_neg_context))
+		if (len_of_ctxts < (int)sizeof(struct smb2_neg_context))
 			break;
 
 		pctx = (struct smb2_neg_context *)((char *)pctx + offset);
@@ -1054,9 +1054,8 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 		}
 
 		/* offsets must be 8 byte aligned */
-		clen = (clen + 7) & ~0x7;
-		offset = clen + sizeof(struct smb2_neg_context);
-		len_of_ctxts -= clen + sizeof(struct smb2_neg_context);
+		offset = (ctxt_len + 7) & ~0x7;
+		len_of_ctxts -= offset;
 	}
 	return status;
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index eac51e22a52a..d5eb3ab8e38f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -609,7 +609,7 @@ struct netdev_queue {
 	netdevice_tracker	dev_tracker;
 
 	struct Qdisc __rcu	*qdisc;
-	struct Qdisc		*qdisc_sleeping;
+	struct Qdisc __rcu	*qdisc_sleeping;
 #ifdef CONFIG_SYSFS
 	struct kobject		kobj;
 #endif
@@ -757,8 +757,11 @@ static inline void rps_record_sock_flow(struct rps_sock_flow_table *table,
 		/* We only give a hint, preemption can change CPU under us */
 		val |= raw_smp_processor_id();
 
-		if (table->ents[index] != val)
-			table->ents[index] = val;
+		/* The following WRITE_ONCE() is paired with the READ_ONCE()
+		 * here, and another one in get_rps_cpu().
+		 */
+		if (READ_ONCE(table->ents[index]) != val)
+			WRITE_ONCE(table->ents[index], val);
 	}
 }
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0b0ae5084e60..59314d228ec3 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -631,6 +631,12 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * Please note that, confusingly, "page_mapping" refers to the inode
  * address_space which maps the page from disk; whereas "page_mapped"
  * refers to user virtual address space into which the page is mapped.
+ *
+ * For slab pages, since slab reuses the bits in struct page to store its
+ * internal states, the page->mapping does not exist as such, nor do these
+ * flags below.  So in order to avoid testing non-existent bits, please
+ * make sure that PageSlab(page) actually evaluates to false before calling
+ * the following functions (e.g., PageAnon).  See mm/slab.h.
  */
 #define PAGE_MAPPING_ANON	0x1
 #define PAGE_MAPPING_MOVABLE	0x2
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 78cd566ee238..5a89928ea953 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -500,6 +500,11 @@ void *hcd_buffer_alloc(struct usb_bus *bus, size_t size,
 void hcd_buffer_free(struct usb_bus *bus, size_t size,
 	void *addr, dma_addr_t dma);
 
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd,
+		size_t size, gfp_t mem_flags, dma_addr_t *dma);
+void hcd_buffer_free_pages(struct usb_hcd *hcd,
+		size_t size, void *addr, dma_addr_t dma);
+
 /* generic bus glue, needed for host controllers that don't use PCI */
 extern irqreturn_t usb_hcd_irq(int irq, void *__hcd);
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b350d92136c8..a674221d151d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -350,6 +350,7 @@ enum {
 enum {
 	HCI_SETUP,
 	HCI_CONFIG,
+	HCI_DEBUGFS_CREATED,
 	HCI_AUTO_OFF,
 	HCI_RFKILLED,
 	HCI_MGMT,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 061fec6fd015..84c5ce57eab6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -513,6 +513,7 @@ struct hci_dev {
 	struct work_struct	cmd_sync_work;
 	struct list_head	cmd_sync_work_list;
 	struct mutex		cmd_sync_work_lock;
+	struct mutex		unregister_lock;
 	struct work_struct	cmd_sync_cancel_work;
 	struct work_struct	reenable_adv_work;
 
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 2f2a6023fb0e..94a1599824d8 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -180,7 +180,7 @@ struct pneigh_entry {
 	netdevice_tracker	dev_tracker;
 	u32			flags;
 	u8			protocol;
-	u8			key[];
+	u32			key[];
 };
 
 /*
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index b4af4837d80b..f6e6a3ab9148 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -53,7 +53,7 @@ struct netns_sysctl_ipv6 {
 	int seg6_flowlabel;
 	u32 ioam6_id;
 	u64 ioam6_id_wide;
-	bool skip_notify_on_dev_down;
+	int skip_notify_on_dev_down;
 	u8 fib_notify_on_flag_change;
 };
 
diff --git a/include/net/ping.h b/include/net/ping.h
index 9233ad3de0ad..bc7779262e60 100644
--- a/include/net/ping.h
+++ b/include/net/ping.h
@@ -16,11 +16,7 @@
 #define PING_HTABLE_SIZE 	64
 #define PING_HTABLE_MASK 	(PING_HTABLE_SIZE-1)
 
-/*
- * gid_t is either uint or ushort.  We want to pass it to
- * proc_dointvec_minmax(), so it must not be larger than MAX_INT
- */
-#define GID_T_MAX (((gid_t)~0U) >> 1)
+#define GID_T_MAX (((gid_t)~0U) - 1)
 
 /* Compatibility glue so we can support IPv6 when it's compiled as a module */
 struct pingv6_ops {
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 38207873eda6..8ab75128512a 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -128,6 +128,8 @@ static inline void qdisc_run(struct Qdisc *q)
 	}
 }
 
+extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
+
 /* Calculate maximal size of packet seen by hard_start_xmit
    routine of this device.
  */
diff --git a/include/net/rpl.h b/include/net/rpl.h
index 308ef0a05cae..30fe780d1e7c 100644
--- a/include/net/rpl.h
+++ b/include/net/rpl.h
@@ -23,9 +23,6 @@ static inline int rpl_init(void)
 static inline void rpl_exit(void) {}
 #endif
 
-/* Worst decompression memory usage ipv6 address (16) + pad 7 */
-#define IPV6_RPL_SRH_WORST_SWAP_SIZE (sizeof(struct in6_addr) + 7)
-
 size_t ipv6_rpl_srh_size(unsigned char n, unsigned char cmpri,
 			 unsigned char cmpre);
 
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index af4aa66aaa4e..989eb972fcae 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -543,7 +543,7 @@ static inline struct Qdisc *qdisc_root_bh(const struct Qdisc *qdisc)
 
 static inline struct Qdisc *qdisc_root_sleeping(const struct Qdisc *qdisc)
 {
-	return qdisc->dev_queue->qdisc_sleeping;
+	return rcu_dereference_rtnl(qdisc->dev_queue->qdisc_sleeping);
 }
 
 static inline spinlock_t *qdisc_root_sleeping_lock(const struct Qdisc *qdisc)
@@ -752,7 +752,9 @@ static inline bool qdisc_tx_changing(const struct net_device *dev)
 
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		struct netdev_queue *txq = netdev_get_tx_queue(dev, i);
-		if (rcu_access_pointer(txq->qdisc) != txq->qdisc_sleeping)
+
+		if (rcu_access_pointer(txq->qdisc) !=
+		    rcu_access_pointer(txq->qdisc_sleeping))
 			return true;
 	}
 	return false;
diff --git a/include/net/sock.h b/include/net/sock.h
index f11b98bd0244..2f35b82a123f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1148,8 +1148,12 @@ static inline void sock_rps_record_flow(const struct sock *sk)
 		 * OR	an additional socket flag
 		 * [1] : sk_state and sk_prot are in the same cache line.
 		 */
-		if (sk->sk_state == TCP_ESTABLISHED)
-			sock_rps_record_flow_hash(sk->sk_rxhash);
+		if (sk->sk_state == TCP_ESTABLISHED) {
+			/* This READ_ONCE() is paired with the WRITE_ONCE()
+			 * from sock_rps_save_rxhash() and sock_rps_reset_rxhash().
+			 */
+			sock_rps_record_flow_hash(READ_ONCE(sk->sk_rxhash));
+		}
 	}
 #endif
 }
@@ -1158,15 +1162,19 @@ static inline void sock_rps_save_rxhash(struct sock *sk,
 					const struct sk_buff *skb)
 {
 #ifdef CONFIG_RPS
-	if (unlikely(sk->sk_rxhash != skb->hash))
-		sk->sk_rxhash = skb->hash;
+	/* The following WRITE_ONCE() is paired with the READ_ONCE()
+	 * here, and another one in sock_rps_record_flow().
+	 */
+	if (unlikely(READ_ONCE(sk->sk_rxhash) != skb->hash))
+		WRITE_ONCE(sk->sk_rxhash, skb->hash);
 #endif
 }
 
 static inline void sock_rps_reset_rxhash(struct sock *sk)
 {
 #ifdef CONFIG_RPS
-	sk->sk_rxhash = 0;
+	/* Paired with READ_ONCE() in sock_rps_record_flow() */
+	WRITE_ONCE(sk->sk_rxhash, 0);
 #endif
 }
 
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 135205d0d560..8e87f69aae60 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -61,9 +61,13 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	/* Misc members not needed in bpf_map_meta_equal() check. */
 	inner_map_meta->ops = inner_map->ops;
 	if (inner_map->ops == &array_map_ops) {
+		struct bpf_array *inner_array_meta =
+			container_of(inner_map_meta, struct bpf_array, map);
+		struct bpf_array *inner_array = container_of(inner_map, struct bpf_array, map);
+
+		inner_array_meta->index_mask = inner_array->index_mask;
+		inner_array_meta->elem_size = inner_array->elem_size;
 		inner_map_meta->bypass_spec_v1 = inner_map->bypass_spec_v1;
-		container_of(inner_map_meta, struct bpf_array, map)->index_mask =
-		     container_of(inner_map, struct bpf_array, map)->index_mask;
 	}
 
 	fdput(f);
diff --git a/kernel/fork.c b/kernel/fork.c
index ec913b13c5ed..6bb91fbbf73c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -559,6 +559,7 @@ void free_task(struct task_struct *tsk)
 	arch_release_task_struct(tsk);
 	if (tsk->flags & PF_KTHREAD)
 		free_kthread_struct(tsk);
+	bpf_task_storage_free(tsk);
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -843,7 +844,6 @@ void __put_task_struct(struct task_struct *tsk)
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
 	security_task_free(tsk);
-	bpf_task_storage_free(tsk);
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9d4163abadf4..1642548892a8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -903,13 +903,23 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
 
 BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 {
+	struct path copy;
 	long len;
 	char *p;
 
 	if (!sz)
 		return 0;
 
-	p = d_path(path, buf, sz);
+	/*
+	 * The path pointer is verified as trusted and safe to use,
+	 * but let's double check it's valid anyway to workaround
+	 * potentially broken verifier.
+	 */
+	len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
+	if (len < 0)
+		return len;
+
+	p = d_path(&copy, buf, sz);
 	if (IS_ERR(p)) {
 		len = PTR_ERR(p);
 	} else {
diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index e77f12bb3c77..1833ad73de6f 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -268,8 +268,8 @@ static void irq_cpu_rmap_release(struct kref *ref)
 	struct irq_glue *glue =
 		container_of(ref, struct irq_glue, notify.kref);
 
-	cpu_rmap_put(glue->rmap);
 	glue->rmap->obj[glue->index] = NULL;
+	cpu_rmap_put(glue->rmap);
 	kfree(glue);
 }
 
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index ce8dded36de9..32c2df12a5ec 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -98,6 +98,7 @@ config PAGE_OWNER
 config PAGE_TABLE_CHECK
 	bool "Check for invalid mappings in user page tables"
 	depends on ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	depends on EXCLUSIVE_SYSTEM_RAM
 	select PAGE_EXTENSION
 	help
 	  Check that anonymous page is not being mapped twice with read write
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 433dbce13fe1..4d0506537621 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -69,6 +69,8 @@ static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
 
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
+
+	BUG_ON(PageSlab(page));
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -105,6 +107,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
+
+	BUG_ON(PageSlab(page));
 	anon = PageAnon(page);
 
 	for (i = 0; i < pgcnt; i++) {
@@ -131,6 +135,8 @@ void __page_table_check_zero(struct page *page, unsigned int order)
 	struct page_ext *page_ext;
 	unsigned long i;
 
+	BUG_ON(PageSlab(page));
+
 	page_ext = page_ext_get(page);
 	BUG_ON(!page_ext);
 	for (i = 0; i < (1ul << order); i++) {
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index fefb51a5f606..a0233252032d 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -101,7 +101,6 @@ static void batadv_dat_purge(struct work_struct *work);
  */
 static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
 {
-	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->dat.work,
 			   msecs_to_jiffies(10000));
 }
@@ -819,6 +818,7 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->dat.hash)
 		return -ENOMEM;
 
+	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	batadv_dat_start_timer(bat_priv);
 
 	batadv_tvlv_handler_register(bat_priv, batadv_dat_tvlv_ogm_handler_v1,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c2c6dea01cc9..ab9f00252dc2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -966,6 +966,8 @@ static void cis_cleanup(struct hci_conn *conn)
 	/* Check if ISO connection is a CIS and remove CIG if there are
 	 * no other connections using it.
 	 */
+	hci_conn_hash_list_state(hdev, find_cis, ISO_LINK, BT_BOUND, &d);
+	hci_conn_hash_list_state(hdev, find_cis, ISO_LINK, BT_CONNECT, &d);
 	hci_conn_hash_list_state(hdev, find_cis, ISO_LINK, BT_CONNECTED, &d);
 	if (d.count)
 		return;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 334e308451f5..ca42129f8f91 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1416,10 +1416,10 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 {
-	struct smp_ltk *k;
+	struct smp_ltk *k, *tmp;
 	int removed = 0;
 
-	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->bdaddr_type != bdaddr_type)
 			continue;
 
@@ -1435,9 +1435,9 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
 {
-	struct smp_irk *k;
+	struct smp_irk *k, *tmp;
 
-	list_for_each_entry_rcu(k, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->addr_type != addr_type)
 			continue;
 
@@ -2685,7 +2685,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 {
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
+	mutex_lock(&hdev->unregister_lock);
 	hci_dev_set_flag(hdev, HCI_UNREGISTER);
+	mutex_unlock(&hdev->unregister_lock);
 
 	write_lock(&hci_dev_list_lock);
 	list_del(&hdev->list);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e8b78104a407..1805ddee0cd0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -629,6 +629,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
 	INIT_LIST_HEAD(&hdev->cmd_sync_work_list);
 	mutex_init(&hdev->cmd_sync_work_lock);
+	mutex_init(&hdev->unregister_lock);
 
 	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
 	INIT_WORK(&hdev->reenable_adv_work, reenable_adv);
@@ -688,14 +689,19 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	struct hci_cmd_sync_work_entry *entry;
+	int err = 0;
 
-	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
-		return -ENODEV;
+	mutex_lock(&hdev->unregister_lock);
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+		err = -ENODEV;
+		goto unlock;
+	}
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
-
+	if (!entry) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 	entry->func = func;
 	entry->data = data;
 	entry->destroy = destroy;
@@ -706,7 +712,9 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 
 	queue_work(hdev->req_workqueue, &hdev->cmd_sync_work);
 
-	return 0;
+unlock:
+	mutex_unlock(&hdev->unregister_lock);
+	return err;
 }
 EXPORT_SYMBOL(hci_cmd_sync_queue);
 
@@ -4484,6 +4492,9 @@ static int hci_init_sync(struct hci_dev *hdev)
 	    !hci_dev_test_flag(hdev, HCI_CONFIG))
 		return 0;
 
+	if (hci_dev_test_and_set_flag(hdev, HCI_DEBUGFS_CREATED))
+		return 0;
+
 	hci_debugfs_create_common(hdev);
 
 	if (lmp_bredr_capable(hdev))
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ee8f806534df..02fc9961464c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4307,6 +4307,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 	result = __le16_to_cpu(rsp->result);
 	status = __le16_to_cpu(rsp->status);
 
+	if (result == L2CAP_CR_SUCCESS && (dcid < L2CAP_CID_DYN_START ||
+					   dcid > L2CAP_CID_DYN_END))
+		return -EPROTO;
+
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x",
 	       dcid, scid, result, status);
 
@@ -4338,6 +4342,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
+		if (__l2cap_get_chan_by_dcid(conn, dcid)) {
+			err = -EBADSLT;
+			break;
+		}
+
 		l2cap_state_change(chan, BT_CONFIG);
 		chan->ident = 0;
 		chan->dcid = dcid;
@@ -4664,7 +4673,9 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	chan->ops->set_shutdown(chan);
 
+	l2cap_chan_unlock(chan);
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNRESET);
 	mutex_unlock(&conn->chan_lock);
 
@@ -4703,7 +4714,9 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_unlock(chan);
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, 0);
 	mutex_unlock(&conn->chan_lock);
 
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 821d4ff303b3..ecff1c947d68 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -126,7 +126,7 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 #define J1939_CAN_ID CAN_EFF_FLAG
 #define J1939_CAN_MASK (CAN_EFF_FLAG | CAN_RTR_FLAG)
 
-static DEFINE_SPINLOCK(j1939_netdev_lock);
+static DEFINE_MUTEX(j1939_netdev_lock);
 
 static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 {
@@ -220,7 +220,7 @@ static void __j1939_rx_release(struct kref *kref)
 	j1939_can_rx_unregister(priv);
 	j1939_ecu_unmap_all(priv);
 	j1939_priv_set(priv->ndev, NULL);
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 }
 
 /* get pointer to priv without increasing ref counter */
@@ -248,9 +248,9 @@ static struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev)
 {
 	struct j1939_priv *priv;
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv = j1939_priv_get_by_ndev_locked(ndev);
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 
 	return priv;
 }
@@ -260,14 +260,14 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 	struct j1939_priv *priv, *priv_new;
 	int ret;
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv = j1939_priv_get_by_ndev_locked(ndev);
 	if (priv) {
 		kref_get(&priv->rx_kref);
-		spin_unlock(&j1939_netdev_lock);
+		mutex_unlock(&j1939_netdev_lock);
 		return priv;
 	}
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 
 	priv = j1939_priv_create(ndev);
 	if (!priv)
@@ -277,29 +277,31 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 	spin_lock_init(&priv->j1939_socks_lock);
 	INIT_LIST_HEAD(&priv->j1939_socks);
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv_new = j1939_priv_get_by_ndev_locked(ndev);
 	if (priv_new) {
 		/* Someone was faster than us, use their priv and roll
 		 * back our's.
 		 */
 		kref_get(&priv_new->rx_kref);
-		spin_unlock(&j1939_netdev_lock);
+		mutex_unlock(&j1939_netdev_lock);
 		dev_put(ndev);
 		kfree(priv);
 		return priv_new;
 	}
 	j1939_priv_set(ndev, priv);
-	spin_unlock(&j1939_netdev_lock);
 
 	ret = j1939_can_rx_register(priv);
 	if (ret < 0)
 		goto out_priv_put;
 
+	mutex_unlock(&j1939_netdev_lock);
 	return priv;
 
  out_priv_put:
 	j1939_priv_set(ndev, NULL);
+	mutex_unlock(&j1939_netdev_lock);
+
 	dev_put(ndev);
 	kfree(priv);
 
@@ -308,7 +310,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 
 void j1939_netdev_stop(struct j1939_priv *priv)
 {
-	kref_put_lock(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
+	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
 	j1939_priv_put(priv);
 }
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 4fb3a99b5f67..9c828067b448 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1088,6 +1088,11 @@ void j1939_sk_errqueue(struct j1939_session *session,
 
 void j1939_sk_send_loop_abort(struct sock *sk, int err)
 {
+	struct j1939_sock *jsk = j1939_sk(sk);
+
+	if (jsk->state & J1939_SOCK_ERRQUEUE)
+		return;
+
 	sk->sk_err = err;
 
 	sk_error_report(sk);
diff --git a/net/core/dev.c b/net/core/dev.c
index 93d430693ca0..a2e3c6470ab3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4483,8 +4483,10 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		u32 next_cpu;
 		u32 ident;
 
-		/* First check into global flow table if there is a match */
-		ident = sock_flow_table->ents[hash & sock_flow_table->mask];
+		/* First check into global flow table if there is a match.
+		 * This READ_ONCE() pairs with WRITE_ONCE() from rps_record_sock_flow().
+		 */
+		ident = READ_ONCE(sock_flow_table->ents[hash & sock_flow_table->mask]);
 		if ((ident ^ hash) & ~rps_cpu_mask)
 			goto try_rps;
 
@@ -10516,7 +10518,7 @@ struct netdev_queue *dev_ingress_queue_create(struct net_device *dev)
 		return NULL;
 	netdev_init_one_queue(dev, queue, NULL);
 	RCU_INIT_POINTER(queue->qdisc, &noop_qdisc);
-	queue->qdisc_sleeping = &noop_qdisc;
+	RCU_INIT_POINTER(queue->qdisc_sleeping, &noop_qdisc);
 	rcu_assign_pointer(dev->ingress_queue, queue);
 #endif
 	return queue;
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 9e0f69451563..65fb6f5b21b2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1205,7 +1205,8 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 		rcu_read_lock();
 		psock = sk_psock(sk);
-		psock->saved_data_ready(sk);
+		if (psock)
+			psock->saved_data_ready(sk);
 		rcu_read_unlock();
 	}
 }
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 39dbeb607196..f68762ce4d8a 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -34,8 +34,8 @@ static int ip_ttl_min = 1;
 static int ip_ttl_max = 255;
 static int tcp_syn_retries_min = 1;
 static int tcp_syn_retries_max = MAX_TCP_SYNCNT;
-static int ip_ping_group_range_min[] = { 0, 0 };
-static int ip_ping_group_range_max[] = { GID_T_MAX, GID_T_MAX };
+static unsigned long ip_ping_group_range_min[] = { 0, 0 };
+static unsigned long ip_ping_group_range_max[] = { GID_T_MAX, GID_T_MAX };
 static u32 u32_max_div_HZ = UINT_MAX / HZ;
 static int one_day_secs = 24 * 3600;
 static u32 fib_multipath_hash_fields_all_mask __maybe_unused =
@@ -162,7 +162,7 @@ static int ipv4_ping_group_range(struct ctl_table *table, int write,
 {
 	struct user_namespace *user_ns = current_user_ns();
 	int ret;
-	gid_t urange[2];
+	unsigned long urange[2];
 	kgid_t low, high;
 	struct ctl_table tmp = {
 		.data = &urange,
@@ -175,7 +175,7 @@ static int ipv4_ping_group_range(struct ctl_table *table, int write,
 	inet_get_ping_group_range_table(table, &low, &high);
 	urange[0] = from_kgid_munged(user_ns, low);
 	urange[1] = from_kgid_munged(user_ns, high);
-	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+	ret = proc_doulongvec_minmax(&tmp, write, buffer, lenp, ppos);
 
 	if (write && ret == 0) {
 		low = make_kgid(user_ns, urange[0]);
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 45dda7889387..4851211aa60d 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -60,12 +60,12 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	struct tcphdr *th;
 	unsigned int thlen;
 	unsigned int seq;
-	__be32 delta;
 	unsigned int oldlen;
 	unsigned int mss;
 	struct sk_buff *gso_skb = skb;
 	__sum16 newcheck;
 	bool ooo_okay, copy_destructor;
+	__wsum delta;
 
 	th = tcp_hdr(skb);
 	thlen = th->doff * 4;
@@ -75,7 +75,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, thlen))
 		goto out;
 
-	oldlen = (u16)~skb->len;
+	oldlen = ~skb->len;
 	__skb_pull(skb, thlen);
 
 	mss = skb_shinfo(skb)->gso_size;
@@ -110,7 +110,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (skb_is_gso(segs))
 		mss *= skb_shinfo(segs)->gso_segs;
 
-	delta = htonl(oldlen + (thlen + mss));
+	delta = (__force __wsum)htonl(oldlen + thlen + mss);
 
 	skb = segs;
 	th = tcp_hdr(skb);
@@ -119,8 +119,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_SW_TSTAMP))
 		tcp_gso_tstamp(segs, skb_shinfo(gso_skb)->tskey, seq, mss);
 
-	newcheck = ~csum_fold((__force __wsum)((__force u32)th->check +
-					       (__force u32)delta));
+	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 
 	while (skb->next) {
 		th->fin = th->psh = 0;
@@ -165,11 +164,11 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 			WARN_ON_ONCE(refcount_sub_and_test(-delta, &skb->sk->sk_wmem_alloc));
 	}
 
-	delta = htonl(oldlen + (skb_tail_pointer(skb) -
-				skb_transport_header(skb)) +
-		      skb->data_len);
-	th->check = ~csum_fold((__force __wsum)((__force u32)th->check +
-				(__force u32)delta));
+	delta = (__force __wsum)htonl(oldlen +
+				      (skb_tail_pointer(skb) -
+				       skb_transport_header(skb)) +
+				      skb->data_len);
+	th->check = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 	if (skb->ip_summed == CHECKSUM_PARTIAL)
 		gso_reset_checksum(skb, ~th->check);
 	else
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index a8d961d3a477..5fa0e37305d9 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -569,24 +569,6 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 		return -1;
 	}
 
-	if (skb_cloned(skb)) {
-		if (pskb_expand_head(skb, IPV6_RPL_SRH_WORST_SWAP_SIZE, 0,
-				     GFP_ATOMIC)) {
-			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
-					IPSTATS_MIB_OUTDISCARDS);
-			kfree_skb(skb);
-			return -1;
-		}
-	} else {
-		err = skb_cow_head(skb, IPV6_RPL_SRH_WORST_SWAP_SIZE);
-		if (unlikely(err)) {
-			kfree_skb(skb);
-			return -1;
-		}
-	}
-
-	hdr = (struct ipv6_rpl_sr_hdr *)skb_transport_header(skb);
-
 	if (!pskb_may_pull(skb, ipv6_rpl_srh_size(n, hdr->cmpri,
 						  hdr->cmpre))) {
 		kfree_skb(skb);
@@ -630,6 +612,17 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	skb_pull(skb, ((hdr->hdrlen + 1) << 3));
 	skb_postpull_rcsum(skb, oldhdr,
 			   sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) << 3));
+	if (unlikely(!hdr->segments_left)) {
+		if (pskb_expand_head(skb, sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3), 0,
+				     GFP_ATOMIC)) {
+			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
+			kfree_skb(skb);
+			kfree(buf);
+			return -1;
+		}
+
+		oldhdr = ipv6_hdr(skb);
+	}
 	skb_push(skb, ((chdr->hdrlen + 1) << 3) + sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
 	skb_mac_header_rebuild(skb);
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 729f261520c7..0322abae0825 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -3,7 +3,7 @@
  * HE handling
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 - 2022 Intel Corporation
+ * Copyright(c) 2019 - 2023 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -114,6 +114,7 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct link_sta_info *link_sta)
 {
 	struct ieee80211_sta_he_cap *he_cap = &link_sta->pub->he_cap;
+	const struct ieee80211_sta_he_cap *own_he_cap_ptr;
 	struct ieee80211_sta_he_cap own_he_cap;
 	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
 	u8 he_ppe_size;
@@ -123,12 +124,16 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	memset(he_cap, 0, sizeof(*he_cap));
 
-	if (!he_cap_ie ||
-	    !ieee80211_get_he_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif)))
+	if (!he_cap_ie)
 		return;
 
-	own_he_cap = sband->iftype_data->he_cap;
+	own_he_cap_ptr =
+		ieee80211_get_he_iftype_cap(sband,
+					    ieee80211_vif_type_p2p(&sdata->vif));
+	if (!own_he_cap_ptr)
+		return;
+
+	own_he_cap = *own_he_cap_ptr;
 
 	/* Make sure size is OK */
 	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap_ie_elem);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0125b3e6175b..dc9e7eb7dd85 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1143,6 +1143,7 @@ static void ieee80211_add_non_inheritance_elem(struct sk_buff *skb,
 					       const u16 *inner)
 {
 	unsigned int skb_len = skb->len;
+	bool at_extension = false;
 	bool added = false;
 	int i, j;
 	u8 *len, *list_len = NULL;
@@ -1154,7 +1155,6 @@ static void ieee80211_add_non_inheritance_elem(struct sk_buff *skb,
 	for (i = 0; i < PRESENT_ELEMS_MAX && outer[i]; i++) {
 		u16 elem = outer[i];
 		bool have_inner = false;
-		bool at_extension = false;
 
 		/* should at least be sorted in the sense of normal -> ext */
 		WARN_ON(at_extension && elem < PRESENT_ELEM_EXT_OFFS);
@@ -1183,8 +1183,14 @@ static void ieee80211_add_non_inheritance_elem(struct sk_buff *skb,
 		}
 		*list_len += 1;
 		skb_put_u8(skb, (u8)elem);
+		added = true;
 	}
 
+	/* if we added a list but no extension list, make a zero-len one */
+	if (added && (!at_extension || !list_len))
+		skb_put_u8(skb, 0);
+
+	/* if nothing added remove extension element completely */
 	if (!added)
 		skb_trim(skb, skb_len);
 	else
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 44e407e1a14c..0f81492da0b4 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4857,7 +4857,9 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 	}
 
 	if (unlikely(rx->sta && rx->sta->sta.mlo) &&
-	    is_unicast_ether_addr(hdr->addr1)) {
+	    is_unicast_ether_addr(hdr->addr1) &&
+	    !ieee80211_is_probe_resp(hdr->frame_control) &&
+	    !ieee80211_is_beacon(hdr->frame_control)) {
 		/* translate to MLD addresses */
 		if (ether_addr_equal(link->conf->addr, hdr->addr1))
 			ether_addr_copy(hdr->addr1, rx->sdata->vif.addr);
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 70f0ced3ca86..10c288a0cb0c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -87,8 +87,15 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	unsigned int subflows_max;
 	int ret = 0;
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_active(msk);
+	if (mptcp_pm_is_userspace(msk)) {
+		if (mptcp_userspace_pm_active(msk)) {
+			spin_lock_bh(&pm->lock);
+			pm->subflows++;
+			spin_unlock_bh(&pm->lock);
+			return true;
+		}
+		return false;
+	}
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
@@ -181,8 +188,16 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool update_subflows;
 
-	update_subflows = (subflow->request_join || subflow->mp_join) &&
-			  mptcp_pm_is_kernel(msk);
+	update_subflows = subflow->request_join || subflow->mp_join;
+	if (mptcp_pm_is_userspace(msk)) {
+		if (update_subflows) {
+			spin_lock_bh(&pm->lock);
+			pm->subflows--;
+			spin_unlock_bh(&pm->lock);
+		}
+		return;
+	}
+
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1c69e476f4ad..01d34ee4525e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1550,6 +1550,24 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		remove_anno_list_by_saddr(msk, &entry->addr);
+		if (alist.nr < MPTCP_RM_IDS_MAX)
+			alist.ids[alist.nr++] = entry->addr.id;
+	}
+
+	if (alist.nr) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, &alist);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+}
+
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list)
 {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c1d6cd5b188c..8a2aa63caa51 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -69,6 +69,7 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
+		msk->pm.local_addr_used++;
 		ret = e->addr.id;
 	} else if (match) {
 		ret = entry->addr.id;
@@ -78,6 +79,31 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+/* If the subflow is closed from the other peer (not via a
+ * subflow destroy command then), we want to keep the entry
+ * not to assign the same ID to another address and to be
+ * able to send RM_ADDR after the removal of the subflow.
+ */
+static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
+						struct mptcp_pm_addr_entry *addr)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
+			/* TODO: a refcount is needed because the entry can
+			 * be used multiple times (e.g. fullmesh mode).
+			 */
+			list_del_rcu(&entry->list);
+			kfree(entry);
+			msk->pm.local_addr_used--;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
@@ -170,6 +196,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 	}
@@ -231,7 +258,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	list_move(&match->list, &free_list);
 
-	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+	mptcp_pm_remove_addrs(msk, &free_list);
 
 	release_sock((struct sock *)msk);
 
@@ -250,6 +277,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_pm_addr_entry local = { 0 };
 	struct mptcp_addr_info addr_r;
 	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
@@ -301,12 +329,26 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	local.addr = addr_l;
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	if (err < 0) {
+		GENL_SET_ERR_MSG(info, "did not match address and id");
+		goto create_err;
+	}
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
 
 	release_sock(sk);
 
+	spin_lock_bh(&msk->pm.lock);
+	if (err)
+		mptcp_userspace_pm_delete_local_addr(msk, &local);
+	else
+		msk->pm.subflows++;
+	spin_unlock_bh(&msk->pm.lock);
+
  create_err:
 	sock_put((struct sock *)msk);
 	return err;
@@ -419,7 +461,11 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
 
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_userspace_pm_delete_local_addr(msk, &entry);
+		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 55fc5e42082e..fc00dd587a29 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -820,6 +820,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 46ebee9400da..9a6b64779e64 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1694,6 +1694,14 @@ call_ad(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 	bool eexist = flags & IPSET_FLAG_EXIST, retried = false;
 
 	do {
+		if (retried) {
+			__ip_set_get(set);
+			nfnl_unlock(NFNL_SUBSYS_IPSET);
+			cond_resched();
+			nfnl_lock(NFNL_SUBSYS_IPSET);
+			__ip_set_put(set);
+		}
+
 		ip_set_lock(set);
 		ret = set->variant->uadt(set, tb, adt, &lineno, flags, retried);
 		ip_set_unlock(set);
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index a0e9c7af0846..796026296609 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2277,6 +2277,9 @@ static int nf_confirm_cthelper(struct sk_buff *skb, struct nf_conn *ct,
 		return 0;
 
 	helper = rcu_dereference(help->helper);
+	if (!helper)
+		return 0;
+
 	if (!(helper->flags & NF_CT_HELPER_F_USERSPACE))
 		return 0;
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 31775d54f4b4..437891cb8c41 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8723,7 +8723,7 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 				continue;
 			}
 
-			if (WARN_ON_ONCE(data + expr->ops->size > data_boundary))
+			if (WARN_ON_ONCE(data + size + expr->ops->size > data_boundary))
 				return -ENOMEM;
 
 			memcpy(data + size, expr, expr->ops->size);
diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index e6e402b247d0..b84312df9aa1 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -322,7 +322,7 @@ static bool nft_bitwise_reduce(struct nft_regs_track *track,
 	dreg = priv->dreg;
 	regcount = DIV_ROUND_UP(priv->len, NFT_REG32_SIZE);
 	for (i = 0; i < regcount; i++, dreg++)
-		track->regs[priv->dreg].bitwise = expr;
+		track->regs[dreg].bitwise = expr;
 
 	return false;
 }
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 0adb26e366a7..94be21378e7c 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -355,23 +355,23 @@ static int tcf_police_dump(struct sk_buff *skb, struct tc_action *a,
 	opt.burst = PSCHED_NS2TICKS(p->tcfp_burst);
 	if (p->rate_present) {
 		psched_ratecfg_getrate(&opt.rate, &p->rate);
-		if ((police->params->rate.rate_bytes_ps >= (1ULL << 32)) &&
+		if ((p->rate.rate_bytes_ps >= (1ULL << 32)) &&
 		    nla_put_u64_64bit(skb, TCA_POLICE_RATE64,
-				      police->params->rate.rate_bytes_ps,
+				      p->rate.rate_bytes_ps,
 				      TCA_POLICE_PAD))
 			goto nla_put_failure;
 	}
 	if (p->peak_present) {
 		psched_ratecfg_getrate(&opt.peakrate, &p->peak);
-		if ((police->params->peak.rate_bytes_ps >= (1ULL << 32)) &&
+		if ((p->peak.rate_bytes_ps >= (1ULL << 32)) &&
 		    nla_put_u64_64bit(skb, TCA_POLICE_PEAKRATE64,
-				      police->params->peak.rate_bytes_ps,
+				      p->peak.rate_bytes_ps,
 				      TCA_POLICE_PAD))
 			goto nla_put_failure;
 	}
 	if (p->pps_present) {
 		if (nla_put_u64_64bit(skb, TCA_POLICE_PKTRATE64,
-				      police->params->ppsrate.rate_pkts_ps,
+				      p->ppsrate.rate_pkts_ps,
 				      TCA_POLICE_PAD))
 			goto nla_put_failure;
 		if (nla_put_u64_64bit(skb, TCA_POLICE_PKTBURST64,
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 7b2aa04a7cdf..abaf75300497 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -41,8 +41,6 @@
 #include <net/tc_act/tc_gate.h>
 #include <net/flow_offload.h>
 
-extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
-
 /* The list of all installed classifier types */
 static LIST_HEAD(tcf_proto_base);
 
@@ -2782,6 +2780,7 @@ static int tc_chain_tmplt_add(struct tcf_chain *chain, struct net *net,
 		return PTR_ERR(ops);
 	if (!ops->tmplt_create || !ops->tmplt_destroy || !ops->tmplt_dump) {
 		NL_SET_ERR_MSG(extack, "Chain templates are not supported with specified classifier");
+		module_put(ops->owner);
 		return -EOPNOTSUPP;
 	}
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index f6a7b876d595..6fb345ec2264 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -308,7 +308,7 @@ struct Qdisc *qdisc_lookup(struct net_device *dev, u32 handle)
 
 	if (dev_ingress_queue(dev))
 		q = qdisc_match_from_root(
-			dev_ingress_queue(dev)->qdisc_sleeping,
+			rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping),
 			handle);
 out:
 	return q;
@@ -327,7 +327,8 @@ struct Qdisc *qdisc_lookup_rcu(struct net_device *dev, u32 handle)
 
 	nq = dev_ingress_queue_rcu(dev);
 	if (nq)
-		q = qdisc_match_from_root(nq->qdisc_sleeping, handle);
+		q = qdisc_match_from_root(rcu_dereference(nq->qdisc_sleeping),
+					  handle);
 out:
 	return q;
 }
@@ -633,8 +634,13 @@ EXPORT_SYMBOL(qdisc_watchdog_init);
 void qdisc_watchdog_schedule_range_ns(struct qdisc_watchdog *wd, u64 expires,
 				      u64 delta_ns)
 {
-	if (test_bit(__QDISC_STATE_DEACTIVATED,
-		     &qdisc_root_sleeping(wd->qdisc)->state))
+	bool deactivated;
+
+	rcu_read_lock();
+	deactivated = test_bit(__QDISC_STATE_DEACTIVATED,
+			       &qdisc_root_sleeping(wd->qdisc)->state);
+	rcu_read_unlock();
+	if (deactivated)
 		return;
 
 	if (hrtimer_is_queued(&wd->timer)) {
@@ -1473,7 +1479,7 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				}
 				q = qdisc_leaf(p, clid);
 			} else if (dev_ingress_queue(dev)) {
-				q = dev_ingress_queue(dev)->qdisc_sleeping;
+				q = rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping);
 			}
 		} else {
 			q = rtnl_dereference(dev->qdisc);
@@ -1559,7 +1565,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				}
 				q = qdisc_leaf(p, clid);
 			} else if (dev_ingress_queue_create(dev)) {
-				q = dev_ingress_queue(dev)->qdisc_sleeping;
+				q = rtnl_dereference(dev_ingress_queue(dev)->qdisc_sleeping);
 			}
 		} else {
 			q = rtnl_dereference(dev->qdisc);
@@ -1800,8 +1806,8 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 
 		dev_queue = dev_ingress_queue(dev);
 		if (dev_queue &&
-		    tc_dump_qdisc_root(dev_queue->qdisc_sleeping, skb, cb,
-				       &q_idx, s_q_idx, false,
+		    tc_dump_qdisc_root(rtnl_dereference(dev_queue->qdisc_sleeping),
+				       skb, cb, &q_idx, s_q_idx, false,
 				       tca[TCA_DUMP_INVISIBLE]) < 0)
 			goto done;
 
@@ -2239,8 +2245,8 @@ static int tc_dump_tclass(struct sk_buff *skb, struct netlink_callback *cb)
 
 	dev_queue = dev_ingress_queue(dev);
 	if (dev_queue &&
-	    tc_dump_tclass_root(dev_queue->qdisc_sleeping, skb, tcm, cb,
-				&t, s_t, false) < 0)
+	    tc_dump_tclass_root(rtnl_dereference(dev_queue->qdisc_sleeping),
+				skb, tcm, cb, &t, s_t, false) < 0)
 		goto done;
 
 done:
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 6980796d435d..591d87d5e5c0 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -201,6 +201,11 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	return NET_XMIT_CN;
 }
 
+static struct netlink_range_validation fq_pie_q_range = {
+	.min = 1,
+	.max = 1 << 20,
+};
+
 static const struct nla_policy fq_pie_policy[TCA_FQ_PIE_MAX + 1] = {
 	[TCA_FQ_PIE_LIMIT]		= {.type = NLA_U32},
 	[TCA_FQ_PIE_FLOWS]		= {.type = NLA_U32},
@@ -208,7 +213,8 @@ static const struct nla_policy fq_pie_policy[TCA_FQ_PIE_MAX + 1] = {
 	[TCA_FQ_PIE_TUPDATE]		= {.type = NLA_U32},
 	[TCA_FQ_PIE_ALPHA]		= {.type = NLA_U32},
 	[TCA_FQ_PIE_BETA]		= {.type = NLA_U32},
-	[TCA_FQ_PIE_QUANTUM]		= {.type = NLA_U32},
+	[TCA_FQ_PIE_QUANTUM]		=
+			NLA_POLICY_FULL_RANGE(NLA_U32, &fq_pie_q_range),
 	[TCA_FQ_PIE_MEMORY_LIMIT]	= {.type = NLA_U32},
 	[TCA_FQ_PIE_ECN_PROB]		= {.type = NLA_U32},
 	[TCA_FQ_PIE_ECN]		= {.type = NLA_U32},
@@ -373,6 +379,7 @@ static void fq_pie_timer(struct timer_list *t)
 	spinlock_t *root_lock; /* to lock qdisc for probability calculations */
 	u32 idx;
 
+	rcu_read_lock();
 	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 
@@ -385,6 +392,7 @@ static void fq_pie_timer(struct timer_list *t)
 		mod_timer(&q->adapt_timer, jiffies + q->p_params.tupdate);
 
 	spin_unlock(root_lock);
+	rcu_read_unlock();
 }
 
 static int fq_pie_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index a9aadc4e6858..ee43e8ac039e 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -648,7 +648,7 @@ struct Qdisc_ops noop_qdisc_ops __read_mostly = {
 
 static struct netdev_queue noop_netdev_queue = {
 	RCU_POINTER_INITIALIZER(qdisc, &noop_qdisc),
-	.qdisc_sleeping	=	&noop_qdisc,
+	RCU_POINTER_INITIALIZER(qdisc_sleeping, &noop_qdisc),
 };
 
 struct Qdisc noop_qdisc = {
@@ -1103,7 +1103,7 @@ EXPORT_SYMBOL(qdisc_put_unlocked);
 struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev_queue,
 			      struct Qdisc *qdisc)
 {
-	struct Qdisc *oqdisc = dev_queue->qdisc_sleeping;
+	struct Qdisc *oqdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	spinlock_t *root_lock;
 
 	root_lock = qdisc_lock(oqdisc);
@@ -1112,7 +1112,7 @@ struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev_queue,
 	/* ... and graft new one */
 	if (qdisc == NULL)
 		qdisc = &noop_qdisc;
-	dev_queue->qdisc_sleeping = qdisc;
+	rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc);
 	rcu_assign_pointer(dev_queue->qdisc, &noop_qdisc);
 
 	spin_unlock_bh(root_lock);
@@ -1125,12 +1125,12 @@ static void shutdown_scheduler_queue(struct net_device *dev,
 				     struct netdev_queue *dev_queue,
 				     void *_qdisc_default)
 {
-	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
+	struct Qdisc *qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	struct Qdisc *qdisc_default = _qdisc_default;
 
 	if (qdisc) {
 		rcu_assign_pointer(dev_queue->qdisc, qdisc_default);
-		dev_queue->qdisc_sleeping = qdisc_default;
+		rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc_default);
 
 		qdisc_put(qdisc);
 	}
@@ -1154,7 +1154,7 @@ static void attach_one_default_qdisc(struct net_device *dev,
 
 	if (!netif_is_multiqueue(dev))
 		qdisc->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
-	dev_queue->qdisc_sleeping = qdisc;
+	rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc);
 }
 
 static void attach_default_qdiscs(struct net_device *dev)
@@ -1167,7 +1167,7 @@ static void attach_default_qdiscs(struct net_device *dev)
 	if (!netif_is_multiqueue(dev) ||
 	    dev->priv_flags & IFF_NO_QUEUE) {
 		netdev_for_each_tx_queue(dev, attach_one_default_qdisc, NULL);
-		qdisc = txq->qdisc_sleeping;
+		qdisc = rtnl_dereference(txq->qdisc_sleeping);
 		rcu_assign_pointer(dev->qdisc, qdisc);
 		qdisc_refcount_inc(qdisc);
 	} else {
@@ -1186,7 +1186,7 @@ static void attach_default_qdiscs(struct net_device *dev)
 		netdev_for_each_tx_queue(dev, shutdown_scheduler_queue, &noop_qdisc);
 		dev->priv_flags |= IFF_NO_QUEUE;
 		netdev_for_each_tx_queue(dev, attach_one_default_qdisc, NULL);
-		qdisc = txq->qdisc_sleeping;
+		qdisc = rtnl_dereference(txq->qdisc_sleeping);
 		rcu_assign_pointer(dev->qdisc, qdisc);
 		qdisc_refcount_inc(qdisc);
 		dev->priv_flags ^= IFF_NO_QUEUE;
@@ -1202,7 +1202,7 @@ static void transition_one_qdisc(struct net_device *dev,
 				 struct netdev_queue *dev_queue,
 				 void *_need_watchdog)
 {
-	struct Qdisc *new_qdisc = dev_queue->qdisc_sleeping;
+	struct Qdisc *new_qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	int *need_watchdog_p = _need_watchdog;
 
 	if (!(new_qdisc->flags & TCQ_F_BUILTIN))
@@ -1272,7 +1272,7 @@ static void dev_reset_queue(struct net_device *dev,
 	struct Qdisc *qdisc;
 	bool nolock;
 
-	qdisc = dev_queue->qdisc_sleeping;
+	qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	if (!qdisc)
 		return;
 
@@ -1303,7 +1303,7 @@ static bool some_qdisc_is_busy(struct net_device *dev)
 		int val;
 
 		dev_queue = netdev_get_tx_queue(dev, i);
-		q = dev_queue->qdisc_sleeping;
+		q = rtnl_dereference(dev_queue->qdisc_sleeping);
 
 		root_lock = qdisc_lock(q);
 		spin_lock_bh(root_lock);
@@ -1379,7 +1379,7 @@ EXPORT_SYMBOL(dev_deactivate);
 static int qdisc_change_tx_queue_len(struct net_device *dev,
 				     struct netdev_queue *dev_queue)
 {
-	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
+	struct Qdisc *qdisc = rtnl_dereference(dev_queue->qdisc_sleeping);
 	const struct Qdisc_ops *ops = qdisc->ops;
 
 	if (ops->change_tx_queue_len)
@@ -1404,7 +1404,7 @@ void mq_change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx)
 	unsigned int i;
 
 	for (i = new_real_tx; i < dev->real_num_tx_queues; i++) {
-		qdisc = netdev_get_tx_queue(dev, i)->qdisc_sleeping;
+		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, i)->qdisc_sleeping);
 		/* Only update the default qdiscs we created,
 		 * qdiscs with handles are always hashed.
 		 */
@@ -1412,7 +1412,7 @@ void mq_change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx)
 			qdisc_hash_del(qdisc);
 	}
 	for (i = dev->real_num_tx_queues; i < new_real_tx; i++) {
-		qdisc = netdev_get_tx_queue(dev, i)->qdisc_sleeping;
+		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, i)->qdisc_sleeping);
 		if (qdisc != &noop_qdisc && !qdisc->handle)
 			qdisc_hash_add(qdisc, false);
 	}
@@ -1449,7 +1449,7 @@ static void dev_init_scheduler_queue(struct net_device *dev,
 	struct Qdisc *qdisc = _qdisc;
 
 	rcu_assign_pointer(dev_queue->qdisc, qdisc);
-	dev_queue->qdisc_sleeping = qdisc;
+	rcu_assign_pointer(dev_queue->qdisc_sleeping, qdisc);
 }
 
 void dev_init_scheduler(struct net_device *dev)
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index d0bc660d7401..c860119a8f09 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -141,7 +141,7 @@ static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
 	 * qdisc totals are added at end.
 	 */
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
-		qdisc = netdev_get_tx_queue(dev, ntx)->qdisc_sleeping;
+		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
 		spin_lock_bh(qdisc_lock(qdisc));
 
 		gnet_stats_add_basic(&sch->bstats, qdisc->cpu_bstats,
@@ -202,7 +202,7 @@ static struct Qdisc *mq_leaf(struct Qdisc *sch, unsigned long cl)
 {
 	struct netdev_queue *dev_queue = mq_queue_get(sch, cl);
 
-	return dev_queue->qdisc_sleeping;
+	return rtnl_dereference(dev_queue->qdisc_sleeping);
 }
 
 static unsigned long mq_find(struct Qdisc *sch, u32 classid)
@@ -221,7 +221,7 @@ static int mq_dump_class(struct Qdisc *sch, unsigned long cl,
 
 	tcm->tcm_parent = TC_H_ROOT;
 	tcm->tcm_handle |= TC_H_MIN(cl);
-	tcm->tcm_info = dev_queue->qdisc_sleeping->handle;
+	tcm->tcm_info = rtnl_dereference(dev_queue->qdisc_sleeping)->handle;
 	return 0;
 }
 
@@ -230,7 +230,7 @@ static int mq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 {
 	struct netdev_queue *dev_queue = mq_queue_get(sch, cl);
 
-	sch = dev_queue->qdisc_sleeping;
+	sch = rtnl_dereference(dev_queue->qdisc_sleeping);
 	if (gnet_stats_copy_basic(d, sch->cpu_bstats, &sch->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, sch) < 0)
 		return -1;
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 4c68abaa289b..9f26fb7d5823 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -399,7 +399,7 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	 * qdisc totals are added at end.
 	 */
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
-		qdisc = netdev_get_tx_queue(dev, ntx)->qdisc_sleeping;
+		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
 		spin_lock_bh(qdisc_lock(qdisc));
 
 		gnet_stats_add_basic(&sch->bstats, qdisc->cpu_bstats,
@@ -449,7 +449,7 @@ static struct Qdisc *mqprio_leaf(struct Qdisc *sch, unsigned long cl)
 	if (!dev_queue)
 		return NULL;
 
-	return dev_queue->qdisc_sleeping;
+	return rtnl_dereference(dev_queue->qdisc_sleeping);
 }
 
 static unsigned long mqprio_find(struct Qdisc *sch, u32 classid)
@@ -482,7 +482,7 @@ static int mqprio_dump_class(struct Qdisc *sch, unsigned long cl,
 		tcm->tcm_parent = (tc < 0) ? 0 :
 			TC_H_MAKE(TC_H_MAJ(sch->handle),
 				  TC_H_MIN(tc + TC_H_MIN_PRIORITY));
-		tcm->tcm_info = dev_queue->qdisc_sleeping->handle;
+		tcm->tcm_info = rtnl_dereference(dev_queue->qdisc_sleeping)->handle;
 	} else {
 		tcm->tcm_parent = TC_H_ROOT;
 		tcm->tcm_info = 0;
@@ -538,7 +538,7 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	} else {
 		struct netdev_queue *dev_queue = mqprio_queue_get(sch, cl);
 
-		sch = dev_queue->qdisc_sleeping;
+		sch = rtnl_dereference(dev_queue->qdisc_sleeping);
 		if (gnet_stats_copy_basic(d, sch->cpu_bstats,
 					  &sch->bstats, true) < 0 ||
 		    qdisc_qstats_copy(d, sch) < 0)
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 265c238047a4..b60b31ef71cc 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -421,8 +421,10 @@ static void pie_timer(struct timer_list *t)
 {
 	struct pie_sched_data *q = from_timer(q, t, adapt_timer);
 	struct Qdisc *sch = q->sch;
-	spinlock_t *root_lock = qdisc_lock(qdisc_root_sleeping(sch));
+	spinlock_t *root_lock;
 
+	rcu_read_lock();
+	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 	pie_calculate_probability(&q->params, &q->vars, sch->qstats.backlog);
 
@@ -430,6 +432,7 @@ static void pie_timer(struct timer_list *t)
 	if (q->params.tupdate)
 		mod_timer(&q->adapt_timer, jiffies + q->params.tupdate);
 	spin_unlock(root_lock);
+	rcu_read_unlock();
 }
 
 static int pie_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 98129324e157..16277b6a0238 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -321,12 +321,15 @@ static inline void red_adaptative_timer(struct timer_list *t)
 {
 	struct red_sched_data *q = from_timer(q, t, adapt_timer);
 	struct Qdisc *sch = q->sch;
-	spinlock_t *root_lock = qdisc_lock(qdisc_root_sleeping(sch));
+	spinlock_t *root_lock;
 
+	rcu_read_lock();
+	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 	red_adaptative_algo(&q->parms, &q->vars);
 	mod_timer(&q->adapt_timer, jiffies + HZ/2);
 	spin_unlock(root_lock);
+	rcu_read_unlock();
 }
 
 static int red_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index abd436307d6a..66dcb18638fe 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -606,10 +606,12 @@ static void sfq_perturbation(struct timer_list *t)
 {
 	struct sfq_sched_data *q = from_timer(q, t, perturb_timer);
 	struct Qdisc *sch = q->sch;
-	spinlock_t *root_lock = qdisc_lock(qdisc_root_sleeping(sch));
+	spinlock_t *root_lock;
 	siphash_key_t nkey;
 
 	get_random_bytes(&nkey, sizeof(nkey));
+	rcu_read_lock();
+	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 	q->perturbation = nkey;
 	if (!q->filter_list && q->tail)
@@ -618,6 +620,7 @@ static void sfq_perturbation(struct timer_list *t)
 
 	if (q->perturb_period)
 		mod_timer(&q->perturb_timer, jiffies + q->perturb_period);
+	rcu_read_unlock();
 }
 
 static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index c322a61eaeea..a274a9332f33 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2050,7 +2050,7 @@ static struct Qdisc *taprio_leaf(struct Qdisc *sch, unsigned long cl)
 	if (!dev_queue)
 		return NULL;
 
-	return dev_queue->qdisc_sleeping;
+	return rtnl_dereference(dev_queue->qdisc_sleeping);
 }
 
 static unsigned long taprio_find(struct Qdisc *sch, u32 classid)
@@ -2069,7 +2069,7 @@ static int taprio_dump_class(struct Qdisc *sch, unsigned long cl,
 
 	tcm->tcm_parent = TC_H_ROOT;
 	tcm->tcm_handle |= TC_H_MIN(cl);
-	tcm->tcm_info = dev_queue->qdisc_sleeping->handle;
+	tcm->tcm_info = rtnl_dereference(dev_queue->qdisc_sleeping)->handle;
 
 	return 0;
 }
@@ -2081,7 +2081,7 @@ static int taprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 {
 	struct netdev_queue *dev_queue = taprio_queue_get(sch, cl);
 
-	sch = dev_queue->qdisc_sleeping;
+	sch = rtnl_dereference(dev_queue->qdisc_sleeping);
 	if (gnet_stats_copy_basic(d, NULL, &sch->bstats, true) < 0 ||
 	    qdisc_qstats_copy(d, sch) < 0)
 		return -1;
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 16f9238aa51d..7721239c185f 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -297,7 +297,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 		struct net_device *slave = qdisc_dev(q);
 		struct netdev_queue *slave_txq = netdev_get_tx_queue(slave, 0);
 
-		if (slave_txq->qdisc_sleeping != q)
+		if (rcu_access_pointer(slave_txq->qdisc_sleeping) != q)
 			continue;
 		if (netif_xmit_stopped(netdev_get_tx_queue(slave, subq)) ||
 		    !netif_running(slave)) {
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 3008dfdf7c55..760f8bbff822 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -851,6 +851,8 @@ static int smc_llc_add_link_cont(struct smc_link *link,
 	addc_llc->num_rkeys = *num_rkeys_todo;
 	n = *num_rkeys_todo;
 	for (i = 0; i < min_t(u8, n, SMC_LLC_RKEYS_PER_CONT_MSG); i++) {
+		while (*buf_pos && !(*buf_pos)->used)
+			*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
 		if (!*buf_pos) {
 			addc_llc->num_rkeys = addc_llc->num_rkeys -
 					      *num_rkeys_todo;
@@ -867,8 +869,6 @@ static int smc_llc_add_link_cont(struct smc_link *link,
 
 		(*num_rkeys_todo)--;
 		*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
-		while (*buf_pos && !(*buf_pos)->used)
-			*buf_pos = smc_llc_get_next_rmb(lgr, buf_lst, *buf_pos);
 	}
 	addc_llc->hd.common.llc_type = SMC_LLC_ADD_LINK_CONT;
 	addc_llc->hd.length = sizeof(struct smc_llc_msg_add_link_cont);
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 5b0c4d5b80cf..b3ec9eaec36b 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -368,12 +368,12 @@ static void cfg80211_sched_scan_stop_wk(struct work_struct *work)
 	rdev = container_of(work, struct cfg80211_registered_device,
 			   sched_scan_stop_wk);
 
-	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	list_for_each_entry_safe(req, tmp, &rdev->sched_scan_req_list, list) {
 		if (req->nl_owner_dead)
 			cfg80211_stop_sched_scan_req(rdev, req, false);
 	}
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 }
 
 static void cfg80211_propagate_radar_detect_wk(struct work_struct *work)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7320d676ce3a..087c0c442e23 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10542,6 +10542,8 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 		if (!info->attrs[NL80211_ATTR_MLD_ADDR])
 			return -EINVAL;
 		req.ap_mld_addr = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
+		if (!is_valid_ether_addr(req.ap_mld_addr))
+			return -EINVAL;
 	}
 
 	req.bss = cfg80211_get_bss(&rdev->wiphy, chan, bssid, ssid, ssid_len,
diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index 230f65a0e4b0..388db5fb65bd 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -892,10 +892,10 @@ int snd_gf1_pcm_new(struct snd_gus_card *gus, int pcm_dev, int control_index)
 		kctl = snd_ctl_new1(&snd_gf1_pcm_volume_control1, gus);
 	else
 		kctl = snd_ctl_new1(&snd_gf1_pcm_volume_control, gus);
+	kctl->id.index = control_index;
 	err = snd_ctl_add(card, kctl);
 	if (err < 0)
 		return err;
-	kctl->id.index = control_index;
 
 	return 0;
 }
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 727db6d43391..6d25c12d9ef0 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -2688,20 +2688,20 @@ static int snd_cmipci_mixer_new(struct cmipci *cm, int pcm_spdif_device)
 		}
 		if (cm->can_ac3_hw) {
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_default, cm);
+			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				return err;
-			kctl->id.device = pcm_spdif_device;
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_mask, cm);
+			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				return err;
-			kctl->id.device = pcm_spdif_device;
 			kctl = snd_ctl_new1(&snd_cmipci_spdif_stream, cm);
+			kctl->id.device = pcm_spdif_device;
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				return err;
-			kctl->id.device = pcm_spdif_device;
 		}
 		if (cm->chip_version <= 37) {
 			sw = snd_cmipci_old_mixer_switches;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 9f79c0ac2bda..bd19f92aeeec 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2458,10 +2458,14 @@ int snd_hda_create_dig_out_ctls(struct hda_codec *codec,
 		   type == HDA_PCM_TYPE_HDMI) {
 		/* suppose a single SPDIF device */
 		for (dig_mix = dig_mixes; dig_mix->name; dig_mix++) {
+			struct snd_ctl_elem_id id;
+
 			kctl = find_mixer_ctl(codec, dig_mix->name, 0, 0);
 			if (!kctl)
 				break;
-			kctl->id.index = spdif_index;
+			id = kctl->id;
+			id.index = spdif_index;
+			snd_ctl_rename_id(codec->card, &kctl->id, &id);
 		}
 		bus->primary_dig_out_type = HDA_PCM_TYPE_HDMI;
 	}
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7b5f194513c7..48a0e87136f1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9547,6 +9547,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1b11, "ASUS UX431DA", ALC294_FIXUP_ASUS_COEF_1B),
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
+	SND_PCI_QUIRK(0x1043, 0x1b93, "ASUS G614JVR/JIR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
@@ -9565,6 +9566,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1f12, "ASUS UM5302", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
+	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3a50, "ASUS G834JYR/JZR", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3a60, "ASUS G634JYR/JZR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
@@ -9636,6 +9642,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x5101, "Clevo S510WU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x5157, "Clevo W517GU1", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x51a1, "Clevo NS50MU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x51b1, "Clevo NS50AU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x5630, "Clevo NP50RNJS", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70a1, "Clevo NB70T[HJK]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70b3, "Clevo NK70SB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
@@ -11694,6 +11701,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
+	SND_PCI_QUIRK(0x103c, 0x8768, "HP Slim Desktop S01", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x1043, 0x1080, "Asus UX501VW", ALC668_FIXUP_HEADSET_MODE),
@@ -11715,6 +11723,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x14cd, 0x5003, "USI", ALC662_FIXUP_USI_HEADSET_MODE),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC662_FIXUP_LENOVO_MULTI_CODECS),
 	SND_PCI_QUIRK(0x17aa, 0x1057, "Lenovo P360", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x1064, "Lenovo P3 Tower", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32ca, "Lenovo ThinkCentre M80", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
diff --git a/sound/pci/ice1712/aureon.c b/sound/pci/ice1712/aureon.c
index 40a0e0095030..4b59f94ec348 100644
--- a/sound/pci/ice1712/aureon.c
+++ b/sound/pci/ice1712/aureon.c
@@ -1903,11 +1903,12 @@ static int aureon_add_controls(struct snd_ice1712 *ice)
 		else {
 			for (i = 0; i < ARRAY_SIZE(cs8415_controls); i++) {
 				struct snd_kcontrol *kctl;
-				err = snd_ctl_add(ice->card, (kctl = snd_ctl_new1(&cs8415_controls[i], ice)));
-				if (err < 0)
-					return err;
+				kctl = snd_ctl_new1(&cs8415_controls[i], ice);
 				if (i > 1)
 					kctl->id.device = ice->pcm->device;
+				err = snd_ctl_add(ice->card, kctl);
+				if (err < 0)
+					return err;
 			}
 		}
 	}
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index a5241a287851..3b0c3e70987b 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2371,22 +2371,26 @@ int snd_ice1712_spdif_build_controls(struct snd_ice1712 *ice)
 
 	if (snd_BUG_ON(!ice->pcm_pro))
 		return -EIO;
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_ice1712_spdif_default, ice));
+	kctl = snd_ctl_new1(&snd_ice1712_spdif_default, ice);
+	kctl->id.device = ice->pcm_pro->device;
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
+	kctl = snd_ctl_new1(&snd_ice1712_spdif_maskc, ice);
 	kctl->id.device = ice->pcm_pro->device;
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_ice1712_spdif_maskc, ice));
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
+	kctl = snd_ctl_new1(&snd_ice1712_spdif_maskp, ice);
 	kctl->id.device = ice->pcm_pro->device;
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_ice1712_spdif_maskp, ice));
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
+	kctl = snd_ctl_new1(&snd_ice1712_spdif_stream, ice);
 	kctl->id.device = ice->pcm_pro->device;
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_ice1712_spdif_stream, ice));
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
-	kctl->id.device = ice->pcm_pro->device;
 	ice->spdif.stream_ctl = kctl;
 	return 0;
 }
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 6fab2ad85bbe..1dc776acd637 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2392,23 +2392,27 @@ static int snd_vt1724_spdif_build_controls(struct snd_ice1712 *ice)
 	if (err < 0)
 		return err;
 
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_vt1724_spdif_default, ice));
+	kctl = snd_ctl_new1(&snd_vt1724_spdif_default, ice);
+	kctl->id.device = ice->pcm->device;
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
+	kctl = snd_ctl_new1(&snd_vt1724_spdif_maskc, ice);
 	kctl->id.device = ice->pcm->device;
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_vt1724_spdif_maskc, ice));
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
+	kctl = snd_ctl_new1(&snd_vt1724_spdif_maskp, ice);
 	kctl->id.device = ice->pcm->device;
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_vt1724_spdif_maskp, ice));
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
-	kctl->id.device = ice->pcm->device;
 #if 0 /* use default only */
-	err = snd_ctl_add(ice->card, kctl = snd_ctl_new1(&snd_vt1724_spdif_stream, ice));
+	kctl = snd_ctl_new1(&snd_vt1724_spdif_stream, ice);
+	kctl->id.device = ice->pcm->device;
+	err = snd_ctl_add(ice->card, kctl);
 	if (err < 0)
 		return err;
-	kctl->id.device = ice->pcm->device;
 	ice->spdif.stream_ctl = kctl;
 #endif
 	return 0;
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index b492c32ce070..f629b3956a69 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -1827,20 +1827,20 @@ int snd_ymfpci_mixer(struct snd_ymfpci *chip, int rear_switch)
 	if (snd_BUG_ON(!chip->pcm_spdif))
 		return -ENXIO;
 	kctl = snd_ctl_new1(&snd_ymfpci_spdif_default, chip);
+	kctl->id.device = chip->pcm_spdif->device;
 	err = snd_ctl_add(chip->card, kctl);
 	if (err < 0)
 		return err;
-	kctl->id.device = chip->pcm_spdif->device;
 	kctl = snd_ctl_new1(&snd_ymfpci_spdif_mask, chip);
+	kctl->id.device = chip->pcm_spdif->device;
 	err = snd_ctl_add(chip->card, kctl);
 	if (err < 0)
 		return err;
-	kctl->id.device = chip->pcm_spdif->device;
 	kctl = snd_ctl_new1(&snd_ymfpci_spdif_stream, chip);
+	kctl->id.device = chip->pcm_spdif->device;
 	err = snd_ctl_add(chip->card, kctl);
 	if (err < 0)
 		return err;
-	kctl->id.device = chip->pcm_spdif->device;
 	chip->spdif_pcm_ctl = kctl;
 
 	/* direct recording source */
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 046843b57b03..264ec05a3c67 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -648,7 +648,6 @@ static struct regmap_config wsa881x_regmap_config = {
 	.readable_reg = wsa881x_readable_register,
 	.reg_format_endian = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.can_multi_write = true,
 };
 
 enum {
diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 6e9a64c5948e..b152f4e5c4f2 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -950,7 +950,6 @@ static struct regmap_config wsa883x_regmap_config = {
 	.writeable_reg = wsa883x_writeable_register,
 	.reg_format_endian = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
-	.can_multi_write = true,
 	.use_single_read = true,
 };
 
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index be69bbc47f81..8811321717fb 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -335,7 +335,7 @@ int asoc_simple_startup(struct snd_pcm_substream *substream)
 		}
 		ret = snd_pcm_hw_constraint_minmax(substream->runtime, SNDRV_PCM_HW_PARAM_RATE,
 			fixed_rate, fixed_rate);
-		if (ret)
+		if (ret < 0)
 			goto codec_err;
 	}
 
diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-clk.c b/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
index 9ca2cb8c8a9c..f35318ae0739 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-clk.c
@@ -410,11 +410,6 @@ int mt8195_afe_init_clock(struct mtk_base_afe *afe)
 	return 0;
 }
 
-void mt8195_afe_deinit_clock(struct mtk_base_afe *afe)
-{
-	mt8195_audsys_clk_unregister(afe);
-}
-
 int mt8195_afe_enable_clk(struct mtk_base_afe *afe, struct clk *clk)
 {
 	int ret;
diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-clk.h b/sound/soc/mediatek/mt8195/mt8195-afe-clk.h
index 40663e31becd..a08c0ee6c860 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-clk.h
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-clk.h
@@ -101,7 +101,6 @@ int mt8195_afe_get_mclk_source_clk_id(int sel);
 int mt8195_afe_get_mclk_source_rate(struct mtk_base_afe *afe, int apll);
 int mt8195_afe_get_default_mclk_source_by_rate(int rate);
 int mt8195_afe_init_clock(struct mtk_base_afe *afe);
-void mt8195_afe_deinit_clock(struct mtk_base_afe *afe);
 int mt8195_afe_enable_clk(struct mtk_base_afe *afe, struct clk *clk);
 void mt8195_afe_disable_clk(struct mtk_base_afe *afe, struct clk *clk);
 int mt8195_afe_prepare_clk(struct mtk_base_afe *afe, struct clk *clk);
diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 72b2c6d629b9..03dabc056b91 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -3253,18 +3253,13 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mt8195_afe_pcm_dev_remove(struct platform_device *pdev)
+static void mt8195_afe_pcm_dev_remove(struct platform_device *pdev)
 {
-	struct mtk_base_afe *afe = platform_get_drvdata(pdev);
-
 	snd_soc_unregister_component(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt8195_afe_runtime_suspend(&pdev->dev);
-
-	mt8195_afe_deinit_clock(afe);
-	return 0;
 }
 
 static const struct of_device_id mt8195_afe_pcm_dt_match[] = {
@@ -3285,7 +3280,7 @@ static struct platform_driver mt8195_afe_pcm_driver = {
 		   .pm = &mt8195_afe_pm_ops,
 	},
 	.probe = mt8195_afe_pcm_dev_probe,
-	.remove = mt8195_afe_pcm_dev_remove,
+	.remove_new = mt8195_afe_pcm_dev_remove,
 };
 
 module_platform_driver(mt8195_afe_pcm_driver);
diff --git a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c
index e0670e0dbd5b..38594bc3f2f7 100644
--- a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c
+++ b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.c
@@ -148,6 +148,29 @@ static const struct afe_gate aud_clks[CLK_AUD_NR_CLK] = {
 	GATE_AUD6(CLK_AUD_GASRC19, "aud_gasrc19", "top_asm_h", 19),
 };
 
+static void mt8195_audsys_clk_unregister(void *data)
+{
+	struct mtk_base_afe *afe = data;
+	struct mt8195_afe_private *afe_priv = afe->platform_priv;
+	struct clk *clk;
+	struct clk_lookup *cl;
+	int i;
+
+	if (!afe_priv)
+		return;
+
+	for (i = 0; i < CLK_AUD_NR_CLK; i++) {
+		cl = afe_priv->lookup[i];
+		if (!cl)
+			continue;
+
+		clk = cl->clk;
+		clk_unregister_gate(clk);
+
+		clkdev_drop(cl);
+	}
+}
+
 int mt8195_audsys_clk_register(struct mtk_base_afe *afe)
 {
 	struct mt8195_afe_private *afe_priv = afe->platform_priv;
@@ -188,27 +211,5 @@ int mt8195_audsys_clk_register(struct mtk_base_afe *afe)
 		afe_priv->lookup[i] = cl;
 	}
 
-	return 0;
-}
-
-void mt8195_audsys_clk_unregister(struct mtk_base_afe *afe)
-{
-	struct mt8195_afe_private *afe_priv = afe->platform_priv;
-	struct clk *clk;
-	struct clk_lookup *cl;
-	int i;
-
-	if (!afe_priv)
-		return;
-
-	for (i = 0; i < CLK_AUD_NR_CLK; i++) {
-		cl = afe_priv->lookup[i];
-		if (!cl)
-			continue;
-
-		clk = cl->clk;
-		clk_unregister_gate(clk);
-
-		clkdev_drop(cl);
-	}
+	return devm_add_action_or_reset(afe->dev, mt8195_audsys_clk_unregister, afe);
 }
diff --git a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.h b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.h
index 239d31016ba7..69db2dd1c9e0 100644
--- a/sound/soc/mediatek/mt8195/mt8195-audsys-clk.h
+++ b/sound/soc/mediatek/mt8195/mt8195-audsys-clk.h
@@ -10,6 +10,5 @@
 #define _MT8195_AUDSYS_CLK_H_
 
 int mt8195_audsys_clk_register(struct mtk_base_afe *afe);
-void mt8195_audsys_clk_unregister(struct mtk_base_afe *afe);
 
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 60d952719d27..05d0e07da394 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -3,6 +3,7 @@
 #include "cgroup_helpers.h"
 
 #include <linux/tcp.h>
+#include <linux/netlink.h>
 #include "sockopt_sk.skel.h"
 
 #ifndef SOL_TCP
@@ -183,6 +184,33 @@ static int getsetsockopt(void)
 		goto err;
 	}
 
+	/* optval=NULL case is handled correctly */
+
+	close(fd);
+	fd = socket(AF_NETLINK, SOCK_RAW, 0);
+	if (fd < 0) {
+		log_err("Failed to create AF_NETLINK socket");
+		return -1;
+	}
+
+	buf.u32 = 1;
+	optlen = sizeof(__u32);
+	err = setsockopt(fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP, &buf, optlen);
+	if (err) {
+		log_err("Unexpected getsockopt(NETLINK_ADD_MEMBERSHIP) err=%d errno=%d",
+			err, errno);
+		goto err;
+	}
+
+	optlen = 0;
+	err = getsockopt(fd, SOL_NETLINK, NETLINK_LIST_MEMBERSHIPS, NULL, &optlen);
+	if (err) {
+		log_err("Unexpected getsockopt(NETLINK_LIST_MEMBERSHIPS) err=%d errno=%d",
+			err, errno);
+		goto err;
+	}
+	ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value");
+
 	free(big_buf);
 	close(fd);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index c8d810010a94..fe1df4cd206e 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -32,6 +32,12 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval_end = ctx->optval_end;
 	__u8 *optval = ctx->optval;
 	struct sockopt_sk *storage;
+	struct bpf_sock *sk;
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		return 1;
 
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
@@ -131,6 +137,12 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval_end = ctx->optval_end;
 	__u8 *optval = ctx->optval;
 	struct sockopt_sk *storage;
+	struct bpf_sock *sk;
+
+	/* Bypass AF_NETLINK. */
+	sk = ctx->sk;
+	if (sk && sk->family == AF_NETLINK)
+		return 1;
 
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c7da2bd7c328..6be19b103824 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -851,7 +851,15 @@ do_transfer()
 				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns1")
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
 				sleep 1
+				sp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				da=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				dp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
+							lport $sp rip $da rport $dp token $tk
 			fi
 
 			counter=$((counter + 1))
@@ -917,6 +925,7 @@ do_transfer()
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
 			fi
@@ -2999,7 +3008,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 0 1
+		chk_rm_nr 1 1
 	fi
 }
 
