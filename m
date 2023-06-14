Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E9B72201B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjFEHwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFEHwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:52:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DD6B7;
        Mon,  5 Jun 2023 00:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3715F61462;
        Mon,  5 Jun 2023 07:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204B3C433EF;
        Mon,  5 Jun 2023 07:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685951509;
        bh=J/fZR3sdHLuz9O+fUC/jVMJ85GKWrhIbHQQ7U375XUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wA0Wi+gazCtmvL5KRZuSYKmllJeBwkD0SrvOX43PhKBk8mVzDFN5yBWdMMoqsIiTC
         +D94Uxbw1cxe5filwcRBwcIGQZ8PzjdbnCwenJAOrIwOi87a1gcN25nqpSmG15lDcf
         M6dCDr3Lkz4CoRcNeeWzhp1vLi2WOfdK1FHStXHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.182
Date:   Mon,  5 Jun 2023 09:51:41 +0200
Message-ID: <2023060539-gangly-underwire-45cc@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023060538-patient-clapped-4b71@gregkh>
References: <2023060538-patient-clapped-4b71@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 4e8289113a81..2f0efde21902 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 181
+SUBLEVEL = 182
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 14b52718917f..0de49e33d422 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -104,6 +104,8 @@
 #define INTEL_FAM6_RAPTORLAKE_P		0xBA
 #define INTEL_FAM6_RAPTORLAKE_S		0xBF
 
+#define INTEL_FAM6_RAPTORLAKE		0xB7
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b403c7f063b0..dbae98f09658 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2267,24 +2267,23 @@ static void binder_deferred_fd_close(int fd)
 static void binder_transaction_buffer_release(struct binder_proc *proc,
 					      struct binder_thread *thread,
 					      struct binder_buffer *buffer,
-					      binder_size_t failed_at,
+					      binder_size_t off_end_offset,
 					      bool is_failure)
 {
 	int debug_id = buffer->debug_id;
-	binder_size_t off_start_offset, buffer_offset, off_end_offset;
+	binder_size_t off_start_offset, buffer_offset;
 
 	binder_debug(BINDER_DEBUG_TRANSACTION,
 		     "%d buffer release %d, size %zd-%zd, failed at %llx\n",
 		     proc->pid, buffer->debug_id,
 		     buffer->data_size, buffer->offsets_size,
-		     (unsigned long long)failed_at);
+		     (unsigned long long)off_end_offset);
 
 	if (buffer->target_node)
 		binder_dec_node(buffer->target_node, 1, 0);
 
 	off_start_offset = ALIGN(buffer->data_size, sizeof(void *));
-	off_end_offset = is_failure && failed_at ? failed_at :
-				off_start_offset + buffer->offsets_size;
+
 	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
 	     buffer_offset += sizeof(binder_size_t)) {
 		struct binder_object_header *hdr;
@@ -2444,6 +2443,21 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 	}
 }
 
+/* Clean up all the objects in the buffer */
+static inline void binder_release_entire_buffer(struct binder_proc *proc,
+						struct binder_thread *thread,
+						struct binder_buffer *buffer,
+						bool is_failure)
+{
+	binder_size_t off_end_offset;
+
+	off_end_offset = ALIGN(buffer->data_size, sizeof(void *));
+	off_end_offset += buffer->offsets_size;
+
+	binder_transaction_buffer_release(proc, thread, buffer,
+					  off_end_offset, is_failure);
+}
+
 static int binder_translate_binder(struct flat_binder_object *fp,
 				   struct binder_transaction *t,
 				   struct binder_thread *thread)
@@ -3926,7 +3940,7 @@ binder_free_buf(struct binder_proc *proc,
 		binder_node_inner_unlock(buf_node);
 	}
 	trace_binder_transaction_buffer_release(buffer);
-	binder_transaction_buffer_release(proc, thread, buffer, 0, is_failure);
+	binder_release_entire_buffer(proc, thread, buffer, is_failure);
 	binder_alloc_free_buf(&proc->alloc, buffer);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index abd066e95228..438be215bbd4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -3,6 +3,7 @@
 
 #include <linux/mlx5/vport.h>
 #include "lib/devcom.h"
+#include "mlx5_core.h"
 
 static LIST_HEAD(devcom_list);
 
@@ -14,7 +15,7 @@ static LIST_HEAD(devcom_list);
 struct mlx5_devcom_component {
 	struct {
 		void *data;
-	} device[MLX5_MAX_PORTS];
+	} device[MLX5_DEVCOM_PORTS_SUPPORTED];
 
 	mlx5_devcom_event_handler_t handler;
 	struct rw_semaphore sem;
@@ -25,7 +26,7 @@ struct mlx5_devcom_list {
 	struct list_head list;
 
 	struct mlx5_devcom_component components[MLX5_DEVCOM_NUM_COMPONENTS];
-	struct mlx5_core_dev *devs[MLX5_MAX_PORTS];
+	struct mlx5_core_dev *devs[MLX5_DEVCOM_PORTS_SUPPORTED];
 };
 
 struct mlx5_devcom {
@@ -74,13 +75,16 @@ struct mlx5_devcom *mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 
 	if (!mlx5_core_is_pf(dev))
 		return NULL;
+	if (MLX5_CAP_GEN(dev, num_lag_ports) != MLX5_DEVCOM_PORTS_SUPPORTED)
+		return NULL;
 
+	mlx5_dev_list_lock();
 	sguid0 = mlx5_query_nic_system_image_guid(dev);
 	list_for_each_entry(iter, &devcom_list, list) {
 		struct mlx5_core_dev *tmp_dev = NULL;
 
 		idx = -1;
-		for (i = 0; i < MLX5_MAX_PORTS; i++) {
+		for (i = 0; i < MLX5_DEVCOM_PORTS_SUPPORTED; i++) {
 			if (iter->devs[i])
 				tmp_dev = iter->devs[i];
 			else
@@ -100,8 +104,10 @@ struct mlx5_devcom *mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 
 	if (!priv) {
 		priv = mlx5_devcom_list_alloc();
-		if (!priv)
-			return ERR_PTR(-ENOMEM);
+		if (!priv) {
+			devcom = ERR_PTR(-ENOMEM);
+			goto out;
+		}
 
 		idx = 0;
 		new_priv = true;
@@ -112,12 +118,14 @@ struct mlx5_devcom *mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 	if (!devcom) {
 		if (new_priv)
 			kfree(priv);
-		return ERR_PTR(-ENOMEM);
+		devcom = ERR_PTR(-ENOMEM);
+		goto out;
 	}
 
 	if (new_priv)
 		list_add(&priv->list, &devcom_list);
-
+out:
+	mlx5_dev_list_unlock();
 	return devcom;
 }
 
@@ -130,20 +138,23 @@ void mlx5_devcom_unregister_device(struct mlx5_devcom *devcom)
 	if (IS_ERR_OR_NULL(devcom))
 		return;
 
+	mlx5_dev_list_lock();
 	priv = devcom->priv;
 	priv->devs[devcom->idx] = NULL;
 
 	kfree(devcom);
 
-	for (i = 0; i < MLX5_MAX_PORTS; i++)
+	for (i = 0; i < MLX5_DEVCOM_PORTS_SUPPORTED; i++)
 		if (priv->devs[i])
 			break;
 
-	if (i != MLX5_MAX_PORTS)
-		return;
+	if (i != MLX5_DEVCOM_PORTS_SUPPORTED)
+		goto out;
 
 	list_del(&priv->list);
 	kfree(priv);
+out:
+	mlx5_dev_list_unlock();
 }
 
 void mlx5_devcom_register_component(struct mlx5_devcom *devcom,
@@ -192,7 +203,7 @@ int mlx5_devcom_send_event(struct mlx5_devcom *devcom,
 
 	comp = &devcom->priv->components[id];
 	down_write(&comp->sem);
-	for (i = 0; i < MLX5_MAX_PORTS; i++)
+	for (i = 0; i < MLX5_DEVCOM_PORTS_SUPPORTED; i++)
 		if (i != devcom->idx && comp->device[i].data) {
 			err = comp->handler(event, comp->device[i].data,
 					    event_data);
@@ -240,7 +251,7 @@ void *mlx5_devcom_get_peer_data(struct mlx5_devcom *devcom,
 		return NULL;
 	}
 
-	for (i = 0; i < MLX5_MAX_PORTS; i++)
+	for (i = 0; i < MLX5_DEVCOM_PORTS_SUPPORTED; i++)
 		if (i != devcom->idx)
 			break;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index 939d5bf1581b..94313c18bb64 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -6,6 +6,8 @@
 
 #include <linux/mlx5/driver.h>
 
+#define MLX5_DEVCOM_PORTS_SUPPORTED 2
+
 enum mlx5_devcom_components {
 	MLX5_DEVCOM_ESW_OFFLOADS,
 
diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index c2023f93c0b2..79117d281c1e 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -175,6 +175,7 @@ enum rgmii_clock_delay {
 #define VSC8502_RGMII_CNTL		  20
 #define VSC8502_RGMII_RX_DELAY_MASK	  0x0070
 #define VSC8502_RGMII_TX_DELAY_MASK	  0x0007
+#define VSC8502_RGMII_RX_CLK_DISABLE	  0x0800
 
 #define MSCC_PHY_WOL_LOWER_MAC_ADDR	  21
 #define MSCC_PHY_WOL_MID_MAC_ADDR	  22
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index ffac713afa55..c64ac142509a 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -527,14 +527,27 @@ static int vsc85xx_mac_if_set(struct phy_device *phydev,
  *  * 2.0 ns (which causes the data to be sampled at exactly half way between
  *    clock transitions at 1000 Mbps) if delays should be enabled
  */
-static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
-				   u16 rgmii_rx_delay_mask,
-				   u16 rgmii_tx_delay_mask)
+static int vsc85xx_update_rgmii_cntl(struct phy_device *phydev, u32 rgmii_cntl,
+				     u16 rgmii_rx_delay_mask,
+				     u16 rgmii_tx_delay_mask)
 {
 	u16 rgmii_rx_delay_pos = ffs(rgmii_rx_delay_mask) - 1;
 	u16 rgmii_tx_delay_pos = ffs(rgmii_tx_delay_mask) - 1;
 	u16 reg_val = 0;
-	int rc;
+	u16 mask = 0;
+	int rc = 0;
+
+	/* For traffic to pass, the VSC8502 family needs the RX_CLK disable bit
+	 * to be unset for all PHY modes, so do that as part of the paged
+	 * register modification.
+	 * For some family members (like VSC8530/31/40/41) this bit is reserved
+	 * and read-only, and the RX clock is enabled by default.
+	 */
+	if (rgmii_cntl == VSC8502_RGMII_CNTL)
+		mask |= VSC8502_RGMII_RX_CLK_DISABLE;
+
+	if (phy_interface_is_rgmii(phydev))
+		mask |= rgmii_rx_delay_mask | rgmii_tx_delay_mask;
 
 	mutex_lock(&phydev->lock);
 
@@ -545,10 +558,9 @@ static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
 	    phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
 		reg_val |= RGMII_CLK_DELAY_2_0_NS << rgmii_tx_delay_pos;
 
-	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_2,
-			      rgmii_cntl,
-			      rgmii_rx_delay_mask | rgmii_tx_delay_mask,
-			      reg_val);
+	if (mask)
+		rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_2,
+				      rgmii_cntl, mask, reg_val);
 
 	mutex_unlock(&phydev->lock);
 
@@ -557,19 +569,11 @@ static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
 
 static int vsc85xx_default_config(struct phy_device *phydev)
 {
-	int rc;
-
 	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
 
-	if (phy_interface_mode_is_rgmii(phydev->interface)) {
-		rc = vsc85xx_rgmii_set_skews(phydev, VSC8502_RGMII_CNTL,
-					     VSC8502_RGMII_RX_DELAY_MASK,
-					     VSC8502_RGMII_TX_DELAY_MASK);
-		if (rc)
-			return rc;
-	}
-
-	return 0;
+	return vsc85xx_update_rgmii_cntl(phydev, VSC8502_RGMII_CNTL,
+					 VSC8502_RGMII_RX_DELAY_MASK,
+					 VSC8502_RGMII_TX_DELAY_MASK);
 }
 
 static int vsc85xx_get_tunable(struct phy_device *phydev,
@@ -1646,13 +1650,11 @@ static int vsc8584_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (phy_interface_is_rgmii(phydev)) {
-		ret = vsc85xx_rgmii_set_skews(phydev, VSC8572_RGMII_CNTL,
-					      VSC8572_RGMII_RX_DELAY_MASK,
-					      VSC8572_RGMII_TX_DELAY_MASK);
-		if (ret)
-			return ret;
-	}
+	ret = vsc85xx_update_rgmii_cntl(phydev, VSC8572_RGMII_CNTL,
+					VSC8572_RGMII_RX_DELAY_MASK,
+					VSC8572_RGMII_TX_DELAY_MASK);
+	if (ret)
+		return ret;
 
 	ret = genphy_soft_reset(phydev);
 	if (ret)
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 338dd82007e4..5769b36851c3 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1203,8 +1203,19 @@ static void bq24190_input_current_limit_work(struct work_struct *work)
 	struct bq24190_dev_info *bdi =
 		container_of(work, struct bq24190_dev_info,
 			     input_current_limit_work.work);
+	union power_supply_propval val;
+	int ret;
 
-	power_supply_set_input_current_limit_from_supplier(bdi->charger);
+	ret = power_supply_get_property_from_supplier(bdi->charger,
+						      POWER_SUPPLY_PROP_CURRENT_MAX,
+						      &val);
+	if (ret)
+		return;
+
+	bq24190_charger_set_property(bdi->charger,
+				     POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+				     &val);
+	power_supply_changed(bdi->charger);
 }
 
 /* Sync the input-current-limit with our parent supply (if we have one) */
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index c08dd4e6d35a..235647b21af7 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1507,14 +1507,6 @@ static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di, u8 reg)
  */
 static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info *di)
 {
-	int flags;
-
-	if (di->opts & BQ27XXX_O_ZERO) {
-		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
-		if (flags >= 0 && (flags & BQ27000_FLAG_CI))
-			return -ENODATA;
-	}
-
 	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_NAC);
 }
 
@@ -1668,6 +1660,18 @@ static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
 		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
 }
 
+/*
+ * Returns true if reported battery capacity is inaccurate
+ */
+static bool bq27xxx_battery_capacity_inaccurate(struct bq27xxx_device_info *di,
+						 u16 flags)
+{
+	if (di->opts & BQ27XXX_O_HAS_CI)
+		return (flags & BQ27000_FLAG_CI);
+	else
+		return false;
+}
+
 static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 {
 	/* Unlikely but important to return first */
@@ -1677,14 +1681,89 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 		return POWER_SUPPLY_HEALTH_COLD;
 	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
 		return POWER_SUPPLY_HEALTH_DEAD;
+	if (unlikely(bq27xxx_battery_capacity_inaccurate(di, di->cache.flags)))
+		return POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
 
 	return POWER_SUPPLY_HEALTH_GOOD;
 }
 
+static bool bq27xxx_battery_is_full(struct bq27xxx_device_info *di, int flags)
+{
+	if (di->opts & BQ27XXX_O_ZERO)
+		return (flags & BQ27000_FLAG_FC);
+	else if (di->opts & BQ27Z561_O_BITS)
+		return (flags & BQ27Z561_FLAG_FC);
+	else
+		return (flags & BQ27XXX_FLAG_FC);
+}
+
+/*
+ * Return the battery average current in µA and the status
+ * Note that current can be negative signed as well
+ * Or 0 if something fails.
+ */
+static int bq27xxx_battery_current_and_status(
+	struct bq27xxx_device_info *di,
+	union power_supply_propval *val_curr,
+	union power_supply_propval *val_status,
+	struct bq27xxx_reg_cache *cache)
+{
+	bool single_flags = (di->opts & BQ27XXX_O_ZERO);
+	int curr;
+	int flags;
+
+	curr = bq27xxx_read(di, BQ27XXX_REG_AI, false);
+	if (curr < 0) {
+		dev_err(di->dev, "error reading current\n");
+		return curr;
+	}
+
+	if (cache) {
+		flags = cache->flags;
+	} else {
+		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
+		if (flags < 0) {
+			dev_err(di->dev, "error reading flags\n");
+			return flags;
+		}
+	}
+
+	if (di->opts & BQ27XXX_O_ZERO) {
+		if (!(flags & BQ27000_FLAG_CHGS)) {
+			dev_dbg(di->dev, "negative current!\n");
+			curr = -curr;
+		}
+
+		curr = curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
+	} else {
+		/* Other gauges return signed value */
+		curr = (int)((s16)curr) * 1000;
+	}
+
+	if (val_curr)
+		val_curr->intval = curr;
+
+	if (val_status) {
+		if (curr > 0) {
+			val_status->intval = POWER_SUPPLY_STATUS_CHARGING;
+		} else if (curr < 0) {
+			val_status->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		} else {
+			if (bq27xxx_battery_is_full(di, flags))
+				val_status->intval = POWER_SUPPLY_STATUS_FULL;
+			else
+				val_status->intval =
+					POWER_SUPPLY_STATUS_NOT_CHARGING;
+		}
+	}
+
+	return 0;
+}
+
 static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 {
+	union power_supply_propval status = di->last_status;
 	struct bq27xxx_reg_cache cache = {0, };
-	bool has_ci_flag = di->opts & BQ27XXX_O_HAS_CI;
 	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
 
 	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
@@ -1692,41 +1771,40 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 		cache.flags = -1; /* read error */
 	if (cache.flags >= 0) {
 		cache.temperature = bq27xxx_battery_read_temperature(di);
-		if (has_ci_flag && (cache.flags & BQ27000_FLAG_CI)) {
-			dev_info_once(di->dev, "battery is not calibrated! ignoring capacity values\n");
-			cache.capacity = -ENODATA;
-			cache.energy = -ENODATA;
-			cache.time_to_empty = -ENODATA;
-			cache.time_to_empty_avg = -ENODATA;
-			cache.time_to_full = -ENODATA;
-			cache.charge_full = -ENODATA;
-			cache.health = -ENODATA;
-		} else {
-			if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
-				cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
-			if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
-				cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
-			if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
-				cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
-
-			cache.charge_full = bq27xxx_battery_read_fcc(di);
-			cache.capacity = bq27xxx_battery_read_soc(di);
-			if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
-				cache.energy = bq27xxx_battery_read_energy(di);
-			di->cache.flags = cache.flags;
-			cache.health = bq27xxx_battery_read_health(di);
-		}
+		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
+			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
+		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
+			cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
+		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
+			cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
+
+		cache.charge_full = bq27xxx_battery_read_fcc(di);
+		cache.capacity = bq27xxx_battery_read_soc(di);
+		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
+			cache.energy = bq27xxx_battery_read_energy(di);
+		di->cache.flags = cache.flags;
+		cache.health = bq27xxx_battery_read_health(di);
 		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
 			cache.cycle_count = bq27xxx_battery_read_cyct(di);
 
+		/*
+		 * On gauges with signed current reporting the current must be
+		 * checked to detect charging <-> discharging status changes.
+		 */
+		if (!(di->opts & BQ27XXX_O_ZERO))
+			bq27xxx_battery_current_and_status(di, NULL, &status, &cache);
+
 		/* We only have to read charge design full once */
 		if (di->charge_design_full <= 0)
 			di->charge_design_full = bq27xxx_battery_read_dcap(di);
 	}
 
 	if ((di->cache.capacity != cache.capacity) ||
-	    (di->cache.flags != cache.flags))
+	    (di->cache.flags != cache.flags) ||
+	    (di->last_status.intval != status.intval)) {
+		di->last_status.intval = status.intval;
 		power_supply_changed(di->bat);
+	}
 
 	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
 		di->cache = cache;
@@ -1754,39 +1832,6 @@ static void bq27xxx_battery_poll(struct work_struct *work)
 	bq27xxx_battery_update(di);
 }
 
-/*
- * Return the battery average current in µA
- * Note that current can be negative signed as well
- * Or 0 if something fails.
- */
-static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
-				   union power_supply_propval *val)
-{
-	int curr;
-	int flags;
-
-	curr = bq27xxx_read(di, BQ27XXX_REG_AI, false);
-	if (curr < 0) {
-		dev_err(di->dev, "error reading current\n");
-		return curr;
-	}
-
-	if (di->opts & BQ27XXX_O_ZERO) {
-		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
-		if (flags & BQ27000_FLAG_CHGS) {
-			dev_dbg(di->dev, "negative current!\n");
-			curr = -curr;
-		}
-
-		val->intval = curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
-	} else {
-		/* Other gauges return signed value */
-		val->intval = (int)((s16)curr) * 1000;
-	}
-
-	return 0;
-}
-
 /*
  * Get the average power in µW
  * Return < 0 if something fails.
@@ -1813,43 +1858,6 @@ static int bq27xxx_battery_pwr_avg(struct bq27xxx_device_info *di,
 	return 0;
 }
 
-static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
-				  union power_supply_propval *val)
-{
-	int status;
-
-	if (di->opts & BQ27XXX_O_ZERO) {
-		if (di->cache.flags & BQ27000_FLAG_FC)
-			status = POWER_SUPPLY_STATUS_FULL;
-		else if (di->cache.flags & BQ27000_FLAG_CHGS)
-			status = POWER_SUPPLY_STATUS_CHARGING;
-		else
-			status = POWER_SUPPLY_STATUS_DISCHARGING;
-	} else if (di->opts & BQ27Z561_O_BITS) {
-		if (di->cache.flags & BQ27Z561_FLAG_FC)
-			status = POWER_SUPPLY_STATUS_FULL;
-		else if (di->cache.flags & BQ27Z561_FLAG_DIS_CH)
-			status = POWER_SUPPLY_STATUS_DISCHARGING;
-		else
-			status = POWER_SUPPLY_STATUS_CHARGING;
-	} else {
-		if (di->cache.flags & BQ27XXX_FLAG_FC)
-			status = POWER_SUPPLY_STATUS_FULL;
-		else if (di->cache.flags & BQ27XXX_FLAG_DSC)
-			status = POWER_SUPPLY_STATUS_DISCHARGING;
-		else
-			status = POWER_SUPPLY_STATUS_CHARGING;
-	}
-
-	if ((status == POWER_SUPPLY_STATUS_DISCHARGING) &&
-	    (power_supply_am_i_supplied(di->bat) > 0))
-		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-
-	val->intval = status;
-
-	return 0;
-}
-
 static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
 					  union power_supply_propval *val)
 {
@@ -1935,7 +1943,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		ret = bq27xxx_battery_status(di, val);
+		ret = bq27xxx_battery_current_and_status(di, NULL, val, NULL);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = bq27xxx_battery_voltage(di, val);
@@ -1944,7 +1952,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		val->intval = di->cache.flags < 0 ? 0 : 1;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		ret = bq27xxx_battery_current(di, val);
+		ret = bq27xxx_battery_current_and_status(di, val, NULL, NULL);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
 		ret = bq27xxx_simple_value(di->cache.capacity, val);
@@ -2014,8 +2022,8 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 {
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
 
-	cancel_delayed_work_sync(&di->work);
-	schedule_delayed_work(&di->work, 0);
+	/* After charger plug in/out wait 0.5s for things to stabilize */
+	mod_delayed_work(system_wq, &di->work, HZ / 2);
 }
 
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 2b644590fa8e..53e5b3e04be1 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -375,46 +375,49 @@ int power_supply_is_system_supplied(void)
 }
 EXPORT_SYMBOL_GPL(power_supply_is_system_supplied);
 
-static int __power_supply_get_supplier_max_current(struct device *dev,
-						   void *data)
+struct psy_get_supplier_prop_data {
+	struct power_supply *psy;
+	enum power_supply_property psp;
+	union power_supply_propval *val;
+};
+
+static int __power_supply_get_supplier_property(struct device *dev, void *_data)
 {
-	union power_supply_propval ret = {0,};
 	struct power_supply *epsy = dev_get_drvdata(dev);
-	struct power_supply *psy = data;
+	struct psy_get_supplier_prop_data *data = _data;
 
-	if (__power_supply_is_supplied_by(epsy, psy))
-		if (!epsy->desc->get_property(epsy,
-					      POWER_SUPPLY_PROP_CURRENT_MAX,
-					      &ret))
-			return ret.intval;
+	if (__power_supply_is_supplied_by(epsy, data->psy))
+		if (!epsy->desc->get_property(epsy, data->psp, data->val))
+			return 1; /* Success */
 
-	return 0;
+	return 0; /* Continue iterating */
 }
 
-int power_supply_set_input_current_limit_from_supplier(struct power_supply *psy)
+int power_supply_get_property_from_supplier(struct power_supply *psy,
+					    enum power_supply_property psp,
+					    union power_supply_propval *val)
 {
-	union power_supply_propval val = {0,};
-	int curr;
-
-	if (!psy->desc->set_property)
-		return -EINVAL;
+	struct psy_get_supplier_prop_data data = {
+		.psy = psy,
+		.psp = psp,
+		.val = val,
+	};
+	int ret;
 
 	/*
 	 * This function is not intended for use with a supply with multiple
-	 * suppliers, we simply pick the first supply to report a non 0
-	 * max-current.
+	 * suppliers, we simply pick the first supply to report the psp.
 	 */
-	curr = class_for_each_device(power_supply_class, NULL, psy,
-				      __power_supply_get_supplier_max_current);
-	if (curr <= 0)
-		return (curr == 0) ? -ENODEV : curr;
-
-	val.intval = curr;
+	ret = class_for_each_device(power_supply_class, NULL, &data,
+				    __power_supply_get_supplier_property);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		return -ENODEV;
 
-	return psy->desc->set_property(psy,
-				POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
+	return 0;
 }
-EXPORT_SYMBOL_GPL(power_supply_set_input_current_limit_from_supplier);
+EXPORT_SYMBOL_GPL(power_supply_get_property_from_supplier);
 
 int power_supply_set_battery_charged(struct power_supply *psy)
 {
diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index e4bb09bbd3fa..a356f84b1285 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -879,3 +879,68 @@ bool regulator_is_equal(struct regulator *reg1, struct regulator *reg2)
 	return reg1->rdev == reg2->rdev;
 }
 EXPORT_SYMBOL_GPL(regulator_is_equal);
+
+static int find_closest_bigger(unsigned int target, const unsigned int *table,
+			       unsigned int num_sel, unsigned int *sel)
+{
+	unsigned int s, tmp, max, maxsel = 0;
+	bool found = false;
+
+	max = table[0];
+
+	for (s = 0; s < num_sel; s++) {
+		if (table[s] > max) {
+			max = table[s];
+			maxsel = s;
+		}
+		if (table[s] >= target) {
+			if (!found || table[s] - target < tmp - target) {
+				tmp = table[s];
+				*sel = s;
+				found = true;
+				if (tmp == target)
+					break;
+			}
+		}
+	}
+
+	if (!found) {
+		*sel = maxsel;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * regulator_set_ramp_delay_regmap - set_ramp_delay() helper
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the ramp_reg
+ * and ramp_mask fields in their descriptor and then use this as their
+ * set_ramp_delay operation, saving some code.
+ */
+int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay)
+{
+	int ret;
+	unsigned int sel;
+
+	if (!rdev->desc->n_ramp_values)
+		return -EINVAL;
+
+	ret = find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
+				  rdev->desc->n_ramp_values, &sel);
+
+	if (ret) {
+		dev_warn(rdev_get_dev(rdev),
+			 "Can't set ramp-delay %u, setting %u\n", ramp_delay,
+			 rdev->desc->ramp_delay_table[sel]);
+	}
+
+	sel <<= ffs(rdev->desc->ramp_mask) - 1;
+
+	return regmap_update_bits(rdev->regmap, rdev->desc->ramp_reg,
+				  rdev->desc->ramp_mask, sel);
+}
+EXPORT_SYMBOL_GPL(regulator_set_ramp_delay_regmap);
diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index d38109cc3a01..b3d206ebb289 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -65,32 +65,9 @@ static const struct regmap_config pca9450_regmap_config = {
  * 10: 25mV/4usec
  * 11: 25mV/8usec
  */
-static int pca9450_dvs_set_ramp_delay(struct regulator_dev *rdev,
-				      int ramp_delay)
-{
-	int id = rdev_get_id(rdev);
-	unsigned int ramp_value;
-
-	switch (ramp_delay) {
-	case 1 ... 3125:
-		ramp_value = BUCK1_RAMP_3P125MV;
-		break;
-	case 3126 ... 6250:
-		ramp_value = BUCK1_RAMP_6P25MV;
-		break;
-	case 6251 ... 12500:
-		ramp_value = BUCK1_RAMP_12P5MV;
-		break;
-	case 12501 ... 25000:
-		ramp_value = BUCK1_RAMP_25MV;
-		break;
-	default:
-		ramp_value = BUCK1_RAMP_25MV;
-	}
-
-	return regmap_update_bits(rdev->regmap, PCA9450_REG_BUCK1CTRL + id * 3,
-				  BUCK1_RAMP_MASK, ramp_value << 6);
-}
+static const unsigned int pca9450_dvs_buck_ramp_table[] = {
+	25000, 12500, 6250, 3125
+};
 
 static const struct regulator_ops pca9450_dvs_buck_regulator_ops = {
 	.enable = regulator_enable_regmap,
@@ -100,7 +77,7 @@ static const struct regulator_ops pca9450_dvs_buck_regulator_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
-	.set_ramp_delay = pca9450_dvs_set_ramp_delay,
+	.set_ramp_delay	= regulator_set_ramp_delay_regmap,
 };
 
 static const struct regulator_ops pca9450_buck_regulator_ops = {
@@ -251,6 +228,10 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK1OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK1CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK1CTRL,
+			.ramp_mask = BUCK1_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -275,7 +256,11 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK2CTRL,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -301,6 +286,10 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.vsel_mask = BUCK3OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK3CTRL,
 			.enable_mask = BUCK3_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK3CTRL,
+			.ramp_mask = BUCK3_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -477,6 +466,10 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_mask = BUCK1OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK1CTRL,
 			.enable_mask = BUCK1_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK1CTRL,
+			.ramp_mask = BUCK1_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
@@ -501,7 +494,11 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
+			.ramp_reg = PCA9450_REG_BUCK2CTRL,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
 			.owner = THIS_MODULE,
 			.of_parse_cb = pca9450_set_dvs_levels,
 		},
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 705b94bd091e..63964196a436 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_BQ27X00_BATTERY_H__
 #define __LINUX_BQ27X00_BATTERY_H__
 
+#include <linux/power_supply.h>
+
 enum bq27xxx_chip {
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
@@ -69,6 +71,7 @@ struct bq27xxx_device_info {
 	int charge_design_full;
 	bool removed;
 	unsigned long last_update;
+	union power_supply_propval last_status;
 	struct delayed_work work;
 	struct power_supply *bat;
 	struct list_head list;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 81a55e974feb..e6fe2f581bda 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -413,8 +413,9 @@ power_supply_temp2resist_simple(struct power_supply_resistance_temp_table *table
 				int table_len, int temp);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
-extern int power_supply_set_input_current_limit_from_supplier(
-					 struct power_supply *psy);
+int power_supply_get_property_from_supplier(struct power_supply *psy,
+					    enum power_supply_property psp,
+					    union power_supply_propval *val);
 extern int power_supply_set_battery_charged(struct power_supply *psy);
 
 #ifdef CONFIG_POWER_SUPPLY
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 11cade73726c..633e7a2ab01d 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -370,6 +370,10 @@ struct regulator_desc {
 	unsigned int pull_down_reg;
 	unsigned int pull_down_mask;
 	unsigned int pull_down_val_on;
+	unsigned int ramp_reg;
+	unsigned int ramp_mask;
+	const unsigned int *ramp_delay_table;
+	unsigned int n_ramp_values;
 
 	unsigned int enable_time;
 
@@ -532,6 +536,7 @@ int regulator_set_current_limit_regmap(struct regulator_dev *rdev,
 				       int min_uA, int max_uA);
 int regulator_get_current_limit_regmap(struct regulator_dev *rdev);
 void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
+int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay);
 
 /*
  * Helper functions intended to be used by regulator drivers prior registering
diff --git a/include/net/ip.h b/include/net/ip.h
index 4b775af57268..8d1173577fb5 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -75,6 +75,7 @@ struct ipcm_cookie {
 	__be32			addr;
 	int			oif;
 	struct ip_options_rcu	*opt;
+	__u8			protocol;
 	__u8			ttl;
 	__s16			tos;
 	char			priority;
@@ -95,6 +96,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 	ipcm->sockc.tsflags = inet->sk.sk_tsflags;
 	ipcm->oif = inet->sk.sk_bound_dev_if;
 	ipcm->addr = inet->inet_saddr;
+	ipcm->protocol = inet->inet_num;
 }
 
 #define IPCB(skb) ((struct inet_skb_parm*)((skb)->cb))
diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index d1b327036ae4..3960bc3da6b3 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -159,6 +159,8 @@ struct in_addr {
 #define MCAST_MSFILTER			48
 #define IP_MULTICAST_ALL		49
 #define IP_UNICAST_IF			50
+#define IP_LOCAL_PORT_RANGE		51
+#define IP_PROTOCOL			52
 
 #define MCAST_EXCLUDE	0
 #define MCAST_INCLUDE	1
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 4dcc1a8a8954..eafb2bebc12c 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -980,6 +980,34 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 
 	BT_DBG("cmd %x arg %lx", cmd, arg);
 
+	/* Make sure the cmd is valid before doing anything */
+	switch (cmd) {
+	case HCIGETDEVLIST:
+	case HCIGETDEVINFO:
+	case HCIGETCONNLIST:
+	case HCIDEVUP:
+	case HCIDEVDOWN:
+	case HCIDEVRESET:
+	case HCIDEVRESTAT:
+	case HCISETSCAN:
+	case HCISETAUTH:
+	case HCISETENCRYPT:
+	case HCISETPTYPE:
+	case HCISETLINKPOL:
+	case HCISETLINKMODE:
+	case HCISETACLMTU:
+	case HCISETSCOMTU:
+	case HCIINQUIRY:
+	case HCISETRAW:
+	case HCIGETCONNINFO:
+	case HCIGETAUTHINFO:
+	case HCIBLOCKADDR:
+	case HCIUNBLOCKADDR:
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
 	lock_sock(sk);
 
 	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 4cc39c62af55..1b35afd326b8 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -317,7 +317,14 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
 			ipc->tos = val;
 			ipc->priority = rt_tos2priority(ipc->tos);
 			break;
-
+		case IP_PROTOCOL:
+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(int)))
+				return -EINVAL;
+			val = *(int *)CMSG_DATA(cmsg);
+			if (val < 1 || val > 255)
+				return -EINVAL;
+			ipc->protocol = val;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1724,6 +1731,9 @@ static int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MINTTL:
 		val = inet->min_ttl;
 		break;
+	case IP_PROTOCOL:
+		val = inet_sk(sk)->inet_num;
+		break;
 	default:
 		release_sock(sk);
 		return -ENOPROTOOPT;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 4899ebe569eb..650da4d8f7ad 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -559,6 +559,9 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	ipcm_init_sk(&ipc, inet);
+	/* Keep backward compat */
+	if (hdrincl)
+		ipc.protocol = IPPROTO_RAW;
 
 	if (msg->msg_controllen) {
 		err = ip_cmsg_send(sk, msg, &ipc, false);
@@ -626,7 +629,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark, tos,
 			   RT_SCOPE_UNIVERSE,
-			   hdrincl ? IPPROTO_RAW : sk->sk_protocol,
+			   hdrincl ? ipc.protocol : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk) |
 			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
 			   daddr, saddr, 0, 0, sk->sk_uid);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 69f0f9c05d02..7ff06fa7ed19 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -828,7 +828,8 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 		if (!proto)
 			proto = inet->inet_num;
-		else if (proto != inet->inet_num)
+		else if (proto != inet->inet_num &&
+			 inet->inet_num != IPPROTO_RAW)
 			return -EINVAL;
 
 		if (proto > 255)
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index c9ca857f1068..6a055a221683 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1493,9 +1493,6 @@ static const struct nla_policy ct_nla_policy[CTA_MAX+1] = {
 
 static int ctnetlink_flush_iterate(struct nf_conn *ct, void *data)
 {
-	if (test_bit(IPS_OFFLOAD_BIT, &ct->status))
-		return 0;
-
 	return ctnetlink_filter_match(ct, data);
 }
 
@@ -1561,11 +1558,6 @@ static int ctnetlink_del_conntrack(struct net *net, struct sock *ctnl,
 
 	ct = nf_ct_tuplehash_to_ctrack(h);
 
-	if (test_bit(IPS_OFFLOAD_BIT, &ct->status)) {
-		nf_ct_put(ct);
-		return -EBUSY;
-	}
-
 	if (cda[CTA_ID]) {
 		__be32 id = nla_get_be32(cda[CTA_ID]);
 
