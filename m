Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B92572F964
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244068AbjFNJjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244109AbjFNJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4472116;
        Wed, 14 Jun 2023 02:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97A6563FB0;
        Wed, 14 Jun 2023 09:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B71DC433C0;
        Wed, 14 Jun 2023 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686735502;
        bh=I2a624C7yZRyHt2cRKs9eF5yUL+MlYnwVz3/nhcBTpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7flGuJm40rqKFnvKp0Mb+Ubhk2RxfPi+rwMKvKQmeRaCy9i+FYm1RizOI+idOFnQ
         UYYogCEKIhiJvNP2BaGD2xsf5sLHPg23gZl9qYEaVKRlr6SiNMU3T8SsI+JJGPBrBf
         yulGkUKG/MDhpLYHrbEvHgmuQyJGeTaS2gO+K0Yc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.247
Date:   Wed, 14 Jun 2023 11:38:12 +0200
Message-ID: <2023061412-sixfold-unisexual-7878@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023061412-sketch-scarf-c272@gregkh>
References: <2023061412-sketch-scarf-c272@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index c2358bb2f211..bf5120214e81 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 246
+SUBLEVEL = 247
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 4fdc8858a69a..e7d5aafa5e99 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -248,7 +248,9 @@ enum {
 
 	/* 1/64k is granular enough and can easily be handled w/ u32 */
 	HWEIGHT_WHOLE		= 1 << 16,
+};
 
+enum {
 	/*
 	 * As vtime is used to calculate the cost of each IO, it needs to
 	 * be fairly high precision.  For example, it should be able to
@@ -271,6 +273,11 @@ enum {
 	VRATE_MIN		= VTIME_PER_USEC * VRATE_MIN_PPM / MILLION,
 	VRATE_CLAMP_ADJ_PCT	= 4,
 
+	/* switch iff the conditions are met for longer than this */
+	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
+};
+
+enum {
 	/* if IOs end up waiting for requests, issue less */
 	RQ_WAIT_BUSY_PCT	= 5,
 
@@ -288,9 +295,6 @@ enum {
 	SURPLUS_SCALE_ABS	= HWEIGHT_WHOLE / 50,	/* + 2% */
 	SURPLUS_MIN_ADJ_DELTA	= HWEIGHT_WHOLE / 33,	/* 3% */
 
-	/* switch iff the conditions are met for longer than this */
-	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
-
 	/*
 	 * Count IO size in 4k pages.  The 12bit shift helps keeping
 	 * size-proportional components of cost calculation in closer
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8517a231bf5a..9d21f90f93f0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1493,14 +1493,30 @@ static bool rbd_obj_is_tail(struct rbd_obj_request *obj_req)
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
@@ -1599,6 +1615,7 @@ __rbd_obj_add_osd_request(struct rbd_obj_request *obj_req,
 static struct ceph_osd_request *
 rbd_obj_add_osd_request(struct rbd_obj_request *obj_req, int num_ops)
 {
+	rbd_assert(obj_req->img_request->snapc);
 	return __rbd_obj_add_osd_request(obj_req, obj_req->img_request->snapc,
 					 num_ops);
 }
@@ -1727,11 +1744,14 @@ static bool rbd_dev_parent_get(struct rbd_device *rbd_dev)
  * Caller is responsible for filling in the list of object requests
  * that comprises the image request, and the Linux request pointer
  * (if there is one).
+ *
+ * Only snap_id is captured here, for reads.  For writes, snapshot
+ * context is captured in rbd_img_object_requests() after exclusive
+ * lock is ensured to be held.
  */
 static struct rbd_img_request *rbd_img_request_create(
 					struct rbd_device *rbd_dev,
-					enum obj_operation_type op_type,
-					struct ceph_snap_context *snapc)
+					enum obj_operation_type op_type)
 {
 	struct rbd_img_request *img_request;
 
@@ -1743,8 +1763,6 @@ static struct rbd_img_request *rbd_img_request_create(
 	img_request->op_type = op_type;
 	if (!rbd_img_is_write(img_request))
 		img_request->snap_id = rbd_dev->spec->snap_id;
-	else
-		img_request->snapc = snapc;
 
 	if (rbd_dev_parent_get(rbd_dev))
 		img_request_layered_set(img_request);
@@ -2389,9 +2407,6 @@ static int rbd_obj_init_write(struct rbd_obj_request *obj_req)
 	if (ret)
 		return ret;
 
-	if (rbd_obj_copyup_enabled(obj_req))
-		obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
-
 	obj_req->write_state = RBD_OBJ_WRITE_START;
 	return 0;
 }
@@ -2497,8 +2512,6 @@ static int rbd_obj_init_zeroout(struct rbd_obj_request *obj_req)
 	if (ret)
 		return ret;
 
-	if (rbd_obj_copyup_enabled(obj_req))
-		obj_req->flags |= RBD_OBJ_FLAG_COPYUP_ENABLED;
 	if (!obj_req->num_img_extents) {
 		obj_req->flags |= RBD_OBJ_FLAG_NOOP_FOR_NONEXISTENT;
 		if (rbd_obj_is_entire(obj_req))
@@ -2935,7 +2948,7 @@ static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req)
 	int ret;
 
 	child_img_req = rbd_img_request_create(img_req->rbd_dev->parent,
-					       OBJ_OP_READ, NULL);
+					       OBJ_OP_READ);
 	if (!child_img_req)
 		return -ENOMEM;
 
@@ -3439,6 +3452,7 @@ static bool rbd_obj_advance_write(struct rbd_obj_request *obj_req, int *result)
 	case RBD_OBJ_WRITE_START:
 		rbd_assert(!*result);
 
+		rbd_obj_set_copyup_enabled(obj_req);
 		if (rbd_obj_write_is_noop(obj_req))
 			return true;
 
@@ -3625,9 +3639,19 @@ static int rbd_img_exclusive_lock(struct rbd_img_request *img_req)
 
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
@@ -3645,7 +3669,6 @@ static void rbd_img_object_requests(struct rbd_img_request *img_req)
 
 static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
 {
-	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	int ret;
 
 again:
@@ -3666,9 +3689,6 @@ static bool rbd_img_advance(struct rbd_img_request *img_req, int *result)
 		if (*result)
 			return true;
 
-		rbd_assert(!need_exclusive_lock(img_req) ||
-			   __rbd_is_lock_owner(rbd_dev));
-
 		rbd_img_object_requests(img_req);
 		if (!img_req->pending.num_pending) {
 			*result = img_req->pending.result;
@@ -4130,6 +4150,10 @@ static int rbd_post_acquire_action(struct rbd_device *rbd_dev)
 {
 	int ret;
 
+	ret = rbd_dev_refresh(rbd_dev);
+	if (ret)
+		return ret;
+
 	if (rbd_dev->header.features & RBD_FEATURE_OBJECT_MAP) {
 		ret = rbd_object_map_open(rbd_dev);
 		if (ret)
@@ -4788,7 +4812,6 @@ static void rbd_queue_workfn(struct work_struct *work)
 	struct request *rq = blk_mq_rq_from_pdu(work);
 	struct rbd_device *rbd_dev = rq->q->queuedata;
 	struct rbd_img_request *img_request;
-	struct ceph_snap_context *snapc = NULL;
 	u64 offset = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
 	u64 length = blk_rq_bytes(rq);
 	enum obj_operation_type op_type;
@@ -4853,10 +4876,6 @@ static void rbd_queue_workfn(struct work_struct *work)
 
 	down_read(&rbd_dev->header_rwsem);
 	mapping_size = rbd_dev->mapping.size;
-	if (op_type != OBJ_OP_READ) {
-		snapc = rbd_dev->header.snapc;
-		ceph_get_snap_context(snapc);
-	}
 	up_read(&rbd_dev->header_rwsem);
 
 	if (offset + length > mapping_size) {
@@ -4866,13 +4885,12 @@ static void rbd_queue_workfn(struct work_struct *work)
 		goto err_rq;
 	}
 
-	img_request = rbd_img_request_create(rbd_dev, op_type, snapc);
+	img_request = rbd_img_request_create(rbd_dev, op_type);
 	if (!img_request) {
 		result = -ENOMEM;
 		goto err_rq;
 	}
 	img_request->rq = rq;
-	snapc = NULL; /* img_request consumes a ref */
 
 	dout("%s rbd_dev %p img_req %p %s %llu~%llu\n", __func__, rbd_dev,
 	     img_request, obj_op_name(op_type), offset, length);
@@ -4894,7 +4912,6 @@ static void rbd_queue_workfn(struct work_struct *work)
 	if (result)
 		rbd_warn(rbd_dev, "%s %llx at %llx result %d",
 			 obj_op_name(op_type), length, offset, result);
-	ceph_put_snap_context(snapc);
 err:
 	blk_mq_end_request(rq, errno_to_blk_status(result));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 5f8c8786cac5..e985d1cdc142 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -329,8 +329,15 @@ static u32 vi_get_xclk(struct amdgpu_device *adev)
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
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 7a26bfb5329c..000fc820638a 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -75,15 +75,17 @@ int drm_atomic_set_mode_for_crtc(struct drm_crtc_state *state,
 	state->mode_blob = NULL;
 
 	if (mode) {
+		struct drm_property_blob *blob;
+
 		drm_mode_convert_to_umode(&umode, mode);
-		state->mode_blob =
-			drm_property_create_blob(state->crtc->dev,
-		                                 sizeof(umode),
-		                                 &umode);
-		if (IS_ERR(state->mode_blob))
-			return PTR_ERR(state->mode_blob);
+		blob = drm_property_create_blob(crtc->dev,
+						sizeof(umode), &umode);
+		if (IS_ERR(blob))
+			return PTR_ERR(blob);
 
 		drm_mode_copy(&state->mode, mode);
+
+		state->mode_blob = blob;
 		state->enable = true;
 		DRM_DEBUG_ATOMIC("Set [MODE:%s] for [CRTC:%d:%s] state %p\n",
 				 mode->name, crtc->base.id, crtc->name, state);
diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 92ba0183fd8a..ef0dc06a3778 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -577,12 +577,14 @@ static int sprd_i2c_remove(struct platform_device *pdev)
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
diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index 6d6719fa7e46..44d65b11a36e 100644
--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -411,9 +411,8 @@ void i40iw_manage_arp_cache(struct i40iw_device *iwdev,
 			    bool ipv4,
 			    u32 action);
 
-int i40iw_manage_apbvt(struct i40iw_device *iwdev,
-		       u16 accel_local_port,
-		       bool add_port);
+enum i40iw_status_code i40iw_manage_apbvt(struct i40iw_device *iwdev,
+					  u16 accel_local_port, bool add_port);
 
 struct i40iw_cqp_request *i40iw_get_cqp_request(struct i40iw_cqp *cqp, bool wait);
 void i40iw_free_cqp_request(struct i40iw_cqp *cqp, struct i40iw_cqp_request *cqp_request);
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 0bd55e1fca37..b99318fb58dc 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -262,7 +262,6 @@ static const struct xpad_device {
 	{ 0x1430, 0xf801, "RedOctane Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0604, "Bigben Interactive DAIJA Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
-	{ 0x1532, 0x0037, "Razer Sabertooth", 0, XTYPE_XBOX360 },
 	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
 	{ 0x15e4, 0x3f00, "Power A Mini Pro Elite", 0, XTYPE_XBOX360 },
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 3e78c2602581..53debe75ae6b 100644
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
index 0f791bfdc1f5..c92f2cdf4026 100644
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
diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 21def3f8fb36..bbb1d68bce4a 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -116,6 +116,22 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35LF2GE4AD", 0x26,
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35LF4GE4AD", 0x37,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 };
 
 static int macronix_spinand_detect(struct spinand_device *spinand)
diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index 625db92792da..67f8faa22783 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1187,8 +1187,6 @@ static int lan9303_port_fdb_add(struct dsa_switch *ds, int port,
 	struct lan9303 *chip = ds->priv;
 
 	dev_dbg(chip->dev, "%s(%d, %pM, %d)\n", __func__, port, addr, vid);
-	if (vid)
-		return -EOPNOTSUPP;
 
 	return lan9303_alr_add_port(chip, addr, port, false);
 }
@@ -1200,8 +1198,6 @@ static int lan9303_port_fdb_del(struct dsa_switch *ds, int port,
 	struct lan9303 *chip = ds->priv;
 
 	dev_dbg(chip->dev, "%s(%d, %pM, %d)\n", __func__, port, addr, vid);
-	if (vid)
-		return -EOPNOTSUPP;
 	lan9303_alr_del_port(chip, addr, port);
 
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2c71e838fa3d..7f8531574400 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7781,6 +7781,9 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		goto err_out;
 	}
 
+	if (BNXT_VF(bp))
+		bnxt_hwrm_func_qcfg(bp);
+
 	rc = bnxt_setup_vnic(bp, 0);
 	if (rc)
 		goto err_out;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_alloc.h b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
index cb8689222c8b..55ba6b690ab6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
@@ -20,16 +20,11 @@ enum i40e_memory_type {
 };
 
 /* prototype for functions used for dynamic memory allocation */
-i40e_status i40e_allocate_dma_mem(struct i40e_hw *hw,
-					    struct i40e_dma_mem *mem,
-					    enum i40e_memory_type type,
-					    u64 size, u32 alignment);
-i40e_status i40e_free_dma_mem(struct i40e_hw *hw,
-					struct i40e_dma_mem *mem);
-i40e_status i40e_allocate_virt_mem(struct i40e_hw *hw,
-					     struct i40e_virt_mem *mem,
-					     u32 size);
-i40e_status i40e_free_virt_mem(struct i40e_hw *hw,
-					 struct i40e_virt_mem *mem);
+int i40e_allocate_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem,
+			  enum i40e_memory_type type, u64 size, u32 alignment);
+int i40e_free_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem);
+int i40e_allocate_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem,
+			   u32 size);
+int i40e_free_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem);
 
 #endif /* _I40E_ALLOC_H_ */
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
index ad502eda4afa..89ce65e5309f 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
@@ -400,6 +400,7 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
 	GPIO_GROUP(GPIOA_15),
 	GPIO_GROUP(GPIOA_16),
 	GPIO_GROUP(GPIOA_17),
+	GPIO_GROUP(GPIOA_18),
 	GPIO_GROUP(GPIOA_19),
 	GPIO_GROUP(GPIOA_20),
 
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index ebcf9f4d5679..94aa51d91b06 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1030,23 +1030,8 @@ static int spi_qup_probe(struct platform_device *pdev)
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
@@ -1092,6 +1077,19 @@ static int spi_qup_probe(struct platform_device *pdev)
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
@@ -1121,7 +1119,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
 	if (ret) {
 		dev_err(dev, "cannot set RESET state\n");
-		goto error_dma;
+		goto error_clk;
 	}
 
 	writel_relaxed(0, base + QUP_OPERATIONAL);
@@ -1145,7 +1143,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, irq, spi_qup_qup_irq,
 			       IRQF_TRIGGER_HIGH, pdev->name, controller);
 	if (ret)
-		goto error_dma;
+		goto error_clk;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
@@ -1160,11 +1158,12 @@ static int spi_qup_probe(struct platform_device *pdev)
 
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
index ca3cea27489b..be377e75703b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -50,9 +50,9 @@ static const struct rtl819x_ops rtl819xp_ops = {
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
index 7bbd884aa5f1..736f1a824cd2 100644
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
 
diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index 6cf22c27f2d2..be8738750948 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -170,3 +170,44 @@ void hcd_buffer_free(
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
index d037deb95884..44922e6381da 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -173,6 +173,7 @@ static int connected(struct usb_dev_state *ps)
 static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
 {
 	struct usb_dev_state *ps = usbm->ps;
+	struct usb_hcd *hcd = bus_to_hcd(ps->dev->bus);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ps->lock, flags);
@@ -181,8 +182,8 @@ static void dec_usb_memory_use_count(struct usb_memory *usbm, int *count)
 		list_del(&usbm->memlist);
 		spin_unlock_irqrestore(&ps->lock, flags);
 
-		usb_free_coherent(ps->dev, usbm->size, usbm->mem,
-				usbm->dma_handle);
+		hcd_buffer_free_pages(hcd, usbm->size,
+				usbm->mem, usbm->dma_handle);
 		usbfs_decrease_memory_usage(
 			usbm->size + sizeof(struct usb_memory));
 		kfree(usbm);
@@ -221,7 +222,7 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	size_t size = vma->vm_end - vma->vm_start;
 	void *mem;
 	unsigned long flags;
-	dma_addr_t dma_handle;
+	dma_addr_t dma_handle = DMA_MAPPING_ERROR;
 	int ret;
 
 	ret = usbfs_increase_memory_usage(size + sizeof(struct usb_memory));
@@ -234,8 +235,8 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 		goto error_decrease_mem;
 	}
 
-	mem = usb_alloc_coherent(ps->dev, size, GFP_USER | __GFP_NOWARN,
-			&dma_handle);
+	mem = hcd_buffer_alloc_pages(hcd,
+			size, GFP_USER | __GFP_NOWARN, &dma_handle);
 	if (!mem) {
 		ret = -ENOMEM;
 		goto error_free_usbm;
@@ -251,7 +252,14 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
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
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ba68b0b41dff..e603cc8c141e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2511,7 +2511,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -4102,8 +4102,12 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+
+	ret = btrfs_commit_transaction(trans);
+	if (ret)
+		unset_reloc_control(rc);
+
+	return ret;
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -4263,7 +4267,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 06e9b26bf277..7def75d5b00c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1558,6 +1558,7 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 	struct inode *inode = &ci->vfs_inode;
 	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
 	struct ceph_mds_session *session = NULL;
+	bool need_put = false;
 	int mds;
 
 	dout("ceph_flush_snaps %p\n", inode);
@@ -1609,8 +1610,13 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 	}
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
index 96c79d5e9f7e..4df068bdba68 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -644,8 +644,10 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
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
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 6c8dd7c0b83a..d8d9d9061544 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -469,8 +469,7 @@ static void reconn_inval_dfs_target(struct TCP_Server_Info *server,
 }
 
 static inline int reconn_setup_dfs_targets(struct cifs_sb_info *cifs_sb,
-					   struct dfs_cache_tgt_list *tl,
-					   struct dfs_cache_tgt_iterator **it)
+					   struct dfs_cache_tgt_list *tl)
 {
 	if (!cifs_sb->origin_fullpath)
 		return -EOPNOTSUPP;
@@ -514,11 +513,13 @@ cifs_reconnect(struct TCP_Server_Info *server)
 		sb = NULL;
 	} else {
 		cifs_sb = CIFS_SB(sb);
-
-		rc = reconn_setup_dfs_targets(cifs_sb, &tgt_list, &tgt_it);
-		if (rc && (rc != -EOPNOTSUPP)) {
-			cifs_server_dbg(VFS, "%s: no target servers for DFS failover\n",
-				 __func__);
+		rc = reconn_setup_dfs_targets(cifs_sb, &tgt_list);
+		if (rc) {
+			cifs_sb = NULL;
+			if (rc != -EOPNOTSUPP) {
+				cifs_server_dbg(VFS, "%s: no target servers for DFS failover\n",
+						__func__);
+			}
 		} else {
 			server->nr_targets = dfs_cache_get_nr_tgts(&tgt_list);
 		}
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 3440cddb5ffb..79d13811c5be 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2016,8 +2016,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			else {
 				u32 ref;
 
+#ifdef EXT4_XATTR_DEBUG
 				WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 				/* The old block is released after updating
 				   the inode. */
 				error = dquot_alloc_block(inode,
@@ -2079,8 +2080,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			/* We need to allocate a new block */
 			ext4_fsblk_t goal, block;
 
+#ifdef EXT4_XATTR_DEBUG
 			WARN_ON_ONCE(dquot_initialize_needed(inode));
-
+#endif
 			goal = ext4_group_first_block_no(sb,
 						EXT4_I(inode)->i_block_group);
 			block = ext4_new_meta_blocks(handle, inode, goal, 0,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 125542f305fa..f6a5a866ea70 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -732,8 +732,11 @@ static inline void rps_record_sock_flow(struct rps_sock_flow_table *table,
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
 
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index a400e86f6218..0cfd540e7d06 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -503,6 +503,11 @@ void *hcd_buffer_alloc(struct usb_bus *bus, size_t size,
 void hcd_buffer_free(struct usb_bus *bus, size_t size,
 	void *addr, dma_addr_t dma);
 
+void *hcd_buffer_alloc_pages(struct usb_hcd *hcd,
+		size_t size, gfp_t mem_flags, dma_addr_t *dma);
+void hcd_buffer_free_pages(struct usb_hcd *hcd,
+		size_t size, void *addr, dma_addr_t dma);
+
 /* generic bus glue, needed for host controllers that don't use PCI */
 extern irqreturn_t usb_hcd_irq(int irq, void *__hcd);
 
diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
index 2d3c48281886..b4234b0300c7 100644
--- a/include/net/bond_alb.h
+++ b/include/net/bond_alb.h
@@ -156,8 +156,8 @@ int bond_alb_init_slave(struct bonding *bond, struct slave *slave);
 void bond_alb_deinit_slave(struct bonding *bond, struct slave *slave);
 void bond_alb_handle_link_change(struct bonding *bond, struct slave *slave, char link);
 void bond_alb_handle_active_change(struct bonding *bond, struct slave *new_slave);
-int bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
-int bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
+netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
+netdev_tx_t bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
 void bond_alb_monitor(struct work_struct *);
 int bond_alb_set_mac_address(struct net_device *bond_dev, void *addr);
 void bond_alb_clear_vlan(struct bonding *bond, unsigned short vlan_id);
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index b6494e87c897..e595e944ebfc 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -174,7 +174,7 @@ struct pneigh_entry {
 	struct net_device	*dev;
 	u8			flags;
 	u8			protocol;
-	u8			key[0];
+	u32			key[];
 };
 
 /*
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index d1585b54fb0b..2d932834ed5b 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -124,6 +124,8 @@ static inline void qdisc_run(struct Qdisc *q)
 	}
 }
 
+extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
+
 /* Calculate maximal size of packet seen by hard_start_xmit
    routine of this device.
  */
diff --git a/include/net/sock.h b/include/net/sock.h
index 06fdb8f207b6..87e57f81ee82 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -997,8 +997,12 @@ static inline void sock_rps_record_flow(const struct sock *sk)
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
@@ -1007,15 +1011,19 @@ static inline void sock_rps_save_rxhash(struct sock *sk,
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
 
diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index 920403fa5b0d..51621fde0b48 100644
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
 
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index ec7bf5a4a9fc..dda62dcd59c8 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -102,7 +102,6 @@ static void batadv_dat_purge(struct work_struct *work);
  */
 static void batadv_dat_start_timer(struct batadv_priv *bat_priv)
 {
-	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	queue_delayed_work(batadv_event_workqueue, &bat_priv->dat.work,
 			   msecs_to_jiffies(10000));
 }
@@ -817,6 +816,7 @@ int batadv_dat_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->dat.hash)
 		return -ENOMEM;
 
+	INIT_DELAYED_WORK(&bat_priv->dat.work, batadv_dat_purge);
 	batadv_dat_start_timer(bat_priv);
 
 	batadv_tvlv_handler_register(bat_priv, batadv_dat_tvlv_ogm_handler_v1,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index eb5b2f45deec..21469934fc3c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2572,10 +2572,10 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 {
-	struct smp_ltk *k;
+	struct smp_ltk *k, *tmp;
 	int removed = 0;
 
-	list_for_each_entry_rcu(k, &hdev->long_term_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->bdaddr_type != bdaddr_type)
 			continue;
 
@@ -2591,9 +2591,9 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 
 void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
 {
-	struct smp_irk *k;
+	struct smp_irk *k, *tmp;
 
-	list_for_each_entry_rcu(k, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
 		if (bacmp(bdaddr, &k->bdaddr) || k->addr_type != addr_type)
 			continue;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5f53e75d8302..e56863587ea2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4024,6 +4024,10 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 	result = __le16_to_cpu(rsp->result);
 	status = __le16_to_cpu(rsp->status);
 
+	if (result == L2CAP_CR_SUCCESS && (dcid < L2CAP_CID_DYN_START ||
+					   dcid > L2CAP_CID_DYN_END))
+		return -EPROTO;
+
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x",
 	       dcid, scid, result, status);
 
@@ -4055,6 +4059,11 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 
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
@@ -4380,7 +4389,9 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	chan->ops->set_shutdown(chan);
 
+	l2cap_chan_unlock(chan);
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNRESET);
 	mutex_unlock(&conn->chan_lock);
 
@@ -4419,7 +4430,9 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 		return 0;
 	}
 
+	l2cap_chan_unlock(chan);
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, 0);
 	mutex_unlock(&conn->chan_lock);
 
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 9da8fbc81c04..9169ef174ff0 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -122,7 +122,7 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 #define J1939_CAN_ID CAN_EFF_FLAG
 #define J1939_CAN_MASK (CAN_EFF_FLAG | CAN_RTR_FLAG)
 
-static DEFINE_SPINLOCK(j1939_netdev_lock);
+static DEFINE_MUTEX(j1939_netdev_lock);
 
 static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 {
@@ -216,7 +216,7 @@ static void __j1939_rx_release(struct kref *kref)
 	j1939_can_rx_unregister(priv);
 	j1939_ecu_unmap_all(priv);
 	j1939_priv_set(priv->ndev, NULL);
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 }
 
 /* get pointer to priv without increasing ref counter */
@@ -244,9 +244,9 @@ static struct j1939_priv *j1939_priv_get_by_ndev(struct net_device *ndev)
 {
 	struct j1939_priv *priv;
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv = j1939_priv_get_by_ndev_locked(ndev);
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 
 	return priv;
 }
@@ -256,14 +256,14 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
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
@@ -273,29 +273,31 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
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
 
@@ -304,7 +306,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 
 void j1939_netdev_stop(struct j1939_priv *priv)
 {
-	kref_put_lock(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
+	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
 	j1939_priv_put(priv);
 }
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 904b167b07cf..4c7e95982170 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1013,6 +1013,11 @@ void j1939_sk_errqueue(struct j1939_session *session,
 
 void j1939_sk_send_loop_abort(struct sock *sk, int err)
 {
+	struct j1939_sock *jsk = j1939_sk(sk);
+
+	if (jsk->state & J1939_SOCK_ERRQUEUE)
+		return;
+
 	sk->sk_err = err;
 
 	sk->sk_error_report(sk);
diff --git a/net/core/dev.c b/net/core/dev.c
index 0cc0809628b0..92ae373475c9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4002,8 +4002,10 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
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
 
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 16ae770f049d..e3c14f8890a8 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1539,6 +1539,14 @@ call_ad(struct sock *ctnl, struct sk_buff *skb, struct ip_set *set,
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
index d9b6f2001d00..fb1f12bb0ff2 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1943,6 +1943,9 @@ static int nf_confirm_cthelper(struct sk_buff *skb, struct nf_conn *ct,
 		return 0;
 
 	helper = rcu_dereference(help->helper);
+	if (!helper)
+		return 0;
+
 	if (!(helper->flags & NF_CT_HELPER_F_USERSPACE))
 		return 0;
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 49777da9f263..a4cf718bdb8a 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -40,8 +40,6 @@
 #include <net/tc_act/tc_mpls.h>
 #include <net/flow_offload.h>
 
-extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
-
 /* The list of all installed classifier types */
 static LIST_HEAD(tcf_proto_base);
 
@@ -2734,6 +2732,7 @@ static int tc_chain_tmplt_add(struct tcf_chain *chain, struct net *net,
 		return PTR_ERR(ops);
 	if (!ops->tmplt_create || !ops->tmplt_destroy || !ops->tmplt_dump) {
 		NL_SET_ERR_MSG(extack, "Chain templates are not supported with specified classifier");
+		module_put(ops->owner);
 		return -EOPNOTSUPP;
 	}
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 31f5ff74bb1c..9c95c3032976 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10345,6 +10345,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
+	SND_PCI_QUIRK(0x103c, 0x8768, "HP Slim Desktop S01", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x1043, 0x1080, "Asus UX501VW", ALC668_FIXUP_HEADSET_MODE),
@@ -10366,6 +10367,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x14cd, 0x5003, "USI", ALC662_FIXUP_USI_HEADSET_MODE),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC662_FIXUP_LENOVO_MULTI_CODECS),
 	SND_PCI_QUIRK(0x17aa, 0x1057, "Lenovo P360", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x1064, "Lenovo P3 Tower", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32ca, "Lenovo ThinkCentre M80", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
