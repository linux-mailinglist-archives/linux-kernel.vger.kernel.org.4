Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73F2748B0E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjGERyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjGERyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:54:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC271BD6;
        Wed,  5 Jul 2023 10:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 977D5616A1;
        Wed,  5 Jul 2023 17:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3ADC433C7;
        Wed,  5 Jul 2023 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688579661;
        bh=fKRbvR6q/29a+YeeN9A0NaOw7LWocAbQSSS+d+/T8yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQPIYt9g+gtI1xyqUBy2lTJPyMVsUYK+U7vPm5gJh+IcT8JGpB+Cop1DgRCpofaqK
         HU+2DW21YNDdYZU2al5B5uEO1WLugysjFE+PTQbiyzez9dMMS/03ooG2sMsO6t3LuR
         scWtpvjaZ2ngznoJFVqNKHEgVQYjMR+2ybAdHPYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.3.12
Date:   Wed,  5 Jul 2023 18:54:09 +0100
Message-ID: <2023070509-lugged-manila-4902@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023070509-lubricate-object-151d@gregkh>
References: <2023070509-lubricate-object-151d@gregkh>
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

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index ef540865ad22..a9ef00509c9b 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -60,6 +60,7 @@ openssl & libcrypto    1.0.0            openssl version
 bc                     1.06.95          bc --version
 Sphinx\ [#f1]_         1.7              sphinx-build --version
 cpio                   any              cpio --version
+gtags (optional)       6.6.5            gtags --version
 ====================== ===============  ========================================
 
 .. [#f1] Sphinx is needed only to build the Kernel documentation
@@ -174,6 +175,12 @@ You will need openssl to build kernels 3.7 and higher if module signing is
 enabled.  You will also need openssl development packages to build kernels 4.3
 and higher.
 
+gtags / GNU GLOBAL (optional)
+-----------------------------
+
+The kernel build requires GNU GLOBAL version 6.6.5 or later to generate
+tag files through ``make gtags``.  This is due to its use of the gtags
+``-C (--directory)`` flag.
 
 System utilities
 ****************
diff --git a/Makefile b/Makefile
index 34349623a76a..7b6c66b7b004 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 3
-SUBLEVEL = 11
+SUBLEVEL = 12
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2055d0b9d4af..730edbd36311 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -308,36 +308,17 @@ static void disable_hdm(void *_cxlhdm)
 	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 }
 
-int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
+static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
 {
-	void __iomem *hdm;
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	u32 global_ctrl;
 
-	/*
-	 * If the hdm capability was not mapped there is nothing to enable and
-	 * the caller is responsible for what happens next.  For example,
-	 * emulate a passthrough decoder.
-	 */
-	if (IS_ERR(cxlhdm))
-		return 0;
-
-	hdm = cxlhdm->regs.hdm_decoder;
 	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
-
-	/*
-	 * If the HDM decoder capability was enabled on entry, skip
-	 * registering disable_hdm() since this decode capability may be
-	 * owned by platform firmware.
-	 */
-	if (global_ctrl & CXL_HDM_DECODER_ENABLE)
-		return 0;
-
 	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
 	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 
-	return devm_add_action_or_reset(&port->dev, disable_hdm, cxlhdm);
+	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_enable_hdm, CXL);
 
 int cxl_dvsec_rr_decode(struct device *dev, int d,
 			struct cxl_endpoint_dvsec_info *info)
@@ -511,7 +492,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (info->mem_enabled)
 		return 0;
 
-	rc = devm_cxl_enable_hdm(port, cxlhdm);
+	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f93a28538962..044a92d9813e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -710,7 +710,6 @@ struct cxl_endpoint_dvsec_info {
 struct cxl_hdm;
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 				   struct cxl_endpoint_dvsec_info *info);
-int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm);
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c23b6164e1c0..07c5ac598da1 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -60,17 +60,13 @@ static int discover_region(struct device *dev, void *root)
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
-	int rc, nr_dports;
-
-	nr_dports = devm_cxl_port_enumerate_dports(port);
-	if (nr_dports < 0)
-		return nr_dports;
+	int rc;
 
-	cxlhdm = devm_cxl_setup_hdm(port, NULL);
-	rc = devm_cxl_enable_hdm(port, cxlhdm);
-	if (rc)
+	rc = devm_cxl_port_enumerate_dports(port);
+	if (rc < 0)
 		return rc;
 
+	cxlhdm = devm_cxl_setup_hdm(port, NULL);
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
 
@@ -79,7 +75,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 		return PTR_ERR(cxlhdm);
 	}
 
-	if (nr_dports == 1) {
+	if (rc == 1) {
 		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
 		return devm_cxl_add_passthrough_decoder(port);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b9441ab457ea..587879f3ac2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2371,6 +2371,10 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	int r;
 
+	/* No valid flags defined yet */
+	if (args->in.flags)
+		return -EINVAL;
+
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index eab53d6317c9..9ec0a343efad 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -400,6 +400,14 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 {
 	int i;
 
+	/*
+	 * Don't adjust DRR while there's bandwidth optimizations pending to
+	 * avoid conflicting with firmware updates.
+	 */
+	if (dc->ctx->dce_version > DCE_VERSION_MAX)
+		if (dc->optimized_required || dc->wm_optimized_required)
+			return false;
+
 	stream->adjust.v_total_max = adjust->v_total_max;
 	stream->adjust.v_total_mid = adjust->v_total_mid;
 	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
@@ -2201,27 +2209,33 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 
 	post_surface_trace(dc);
 
-	if (dc->ctx->dce_version >= DCE_VERSION_MAX)
-		TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
-	else
+	/*
+	 * Only relevant for DCN behavior where we can guarantee the optimization
+	 * is safe to apply - retain the legacy behavior for DCE.
+	 */
+
+	if (dc->ctx->dce_version < DCE_VERSION_MAX)
 		TRACE_DCE_CLOCK_STATE(&context->bw_ctx.bw.dce);
+	else {
+		TRACE_DCN_CLOCK_STATE(&context->bw_ctx.bw.dcn.clk);
 
-	if (is_flip_pending_in_pipes(dc, context))
-		return;
+		if (is_flip_pending_in_pipes(dc, context))
+			return;
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++)
-		if (context->res_ctx.pipe_ctx[i].stream == NULL ||
-		    context->res_ctx.pipe_ctx[i].plane_state == NULL) {
-			context->res_ctx.pipe_ctx[i].pipe_idx = i;
-			dc->hwss.disable_plane(dc, &context->res_ctx.pipe_ctx[i]);
-		}
+		for (i = 0; i < dc->res_pool->pipe_count; i++)
+			if (context->res_ctx.pipe_ctx[i].stream == NULL ||
+					context->res_ctx.pipe_ctx[i].plane_state == NULL) {
+				context->res_ctx.pipe_ctx[i].pipe_idx = i;
+				dc->hwss.disable_plane(dc, &context->res_ctx.pipe_ctx[i]);
+			}
 
-	process_deferred_updates(dc);
+		process_deferred_updates(dc);
 
-	dc->hwss.optimize_bandwidth(dc, context);
+		dc->hwss.optimize_bandwidth(dc, context);
 
-	if (dc->debug.enable_double_buffered_dsc_pg_support)
-		dc->hwss.update_dsc_pg(dc, context, true);
+		if (dc->debug.enable_double_buffered_dsc_pg_support)
+			dc->hwss.update_dsc_pg(dc, context, true);
+	}
 
 	dc->optimized_required = false;
 	dc->wm_optimized_required = false;
@@ -4203,12 +4217,9 @@ void dc_commit_updates_for_stream(struct dc *dc,
 			if (new_pipe->plane_state && new_pipe->plane_state != old_pipe->plane_state)
 				new_pipe->plane_state->force_full_update = true;
 		}
-	} else if (update_type == UPDATE_TYPE_FAST && dc_ctx->dce_version >= DCE_VERSION_MAX) {
+	} else if (update_type == UPDATE_TYPE_FAST) {
 		/*
 		 * Previous frame finished and HW is ready for optimization.
-		 *
-		 * Only relevant for DCN behavior where we can guarantee the optimization
-		 * is safe to apply - retain the legacy behavior for DCE.
 		 */
 		dc_post_update_surfaces_to_stream(dc);
 	}
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 7d5c9c582ed2..0d2fa7f86a54 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1830,30 +1830,36 @@ static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags)
  * As well as checking the version compatibility this always
  * copies the kernel interface version out.
  */
-static int check_version(unsigned int cmd, struct dm_ioctl __user *user)
+static int check_version(unsigned int cmd, struct dm_ioctl __user *user,
+			 struct dm_ioctl *kernel_params)
 {
-	uint32_t version[3];
 	int r = 0;
 
-	if (copy_from_user(version, user->version, sizeof(version)))
+	/* Make certain version is first member of dm_ioctl struct */
+	BUILD_BUG_ON(offsetof(struct dm_ioctl, version) != 0);
+
+	if (copy_from_user(kernel_params->version, user->version, sizeof(kernel_params->version)))
 		return -EFAULT;
 
-	if ((version[0] != DM_VERSION_MAJOR) ||
-	    (version[1] > DM_VERSION_MINOR)) {
+	if ((kernel_params->version[0] != DM_VERSION_MAJOR) ||
+	    (kernel_params->version[1] > DM_VERSION_MINOR)) {
 		DMERR("ioctl interface mismatch: kernel(%u.%u.%u), user(%u.%u.%u), cmd(%d)",
 		      DM_VERSION_MAJOR, DM_VERSION_MINOR,
 		      DM_VERSION_PATCHLEVEL,
-		      version[0], version[1], version[2], cmd);
+		      kernel_params->version[0],
+		      kernel_params->version[1],
+		      kernel_params->version[2],
+		      cmd);
 		r = -EINVAL;
 	}
 
 	/*
 	 * Fill in the kernel version.
 	 */
-	version[0] = DM_VERSION_MAJOR;
-	version[1] = DM_VERSION_MINOR;
-	version[2] = DM_VERSION_PATCHLEVEL;
-	if (copy_to_user(user->version, version, sizeof(version)))
+	kernel_params->version[0] = DM_VERSION_MAJOR;
+	kernel_params->version[1] = DM_VERSION_MINOR;
+	kernel_params->version[2] = DM_VERSION_PATCHLEVEL;
+	if (copy_to_user(user->version, kernel_params->version, sizeof(kernel_params->version)))
 		return -EFAULT;
 
 	return r;
@@ -1879,7 +1885,10 @@ static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kern
 	const size_t minimum_data_size = offsetof(struct dm_ioctl, data);
 	unsigned int noio_flag;
 
-	if (copy_from_user(param_kernel, user, minimum_data_size))
+	/* check_version() already copied version from userspace, avoid TOCTOU */
+	if (copy_from_user((char *)param_kernel + sizeof(param_kernel->version),
+			   (char __user *)user + sizeof(param_kernel->version),
+			   minimum_data_size - sizeof(param_kernel->version)))
 		return -EFAULT;
 
 	if (param_kernel->data_size < minimum_data_size) {
@@ -1991,7 +2000,7 @@ static int ctl_ioctl(struct file *file, uint command, struct dm_ioctl __user *us
 	 * Check the interface version passed in.  This also
 	 * writes out the kernel's interface version.
 	 */
-	r = check_version(cmd, user);
+	r = check_version(cmd, user, &param_kernel);
 	if (r)
 		return r;
 
diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
index 1fd667852271..cd4bd06cf309 100644
--- a/drivers/nubus/proc.c
+++ b/drivers/nubus/proc.c
@@ -137,6 +137,18 @@ static int nubus_proc_rsrc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int nubus_rsrc_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, nubus_proc_rsrc_show, inode);
+}
+
+static const struct proc_ops nubus_rsrc_proc_ops = {
+	.proc_open	= nubus_rsrc_proc_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= single_release,
+};
+
 void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,
 			     const struct nubus_dirent *ent,
 			     unsigned int size)
@@ -152,8 +164,8 @@ void nubus_proc_add_rsrc_mem(struct proc_dir_entry *procdir,
 		pded = nubus_proc_alloc_pde_data(nubus_dirptr(ent), size);
 	else
 		pded = NULL;
-	proc_create_single_data(name, S_IFREG | 0444, procdir,
-			nubus_proc_rsrc_show, pded);
+	proc_create_data(name, S_IFREG | 0444, procdir,
+			 &nubus_rsrc_proc_ops, pded);
 }
 
 void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
@@ -166,9 +178,9 @@ void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
 		return;
 
 	snprintf(name, sizeof(name), "%x", ent->type);
-	proc_create_single_data(name, S_IFREG | 0444, procdir,
-			nubus_proc_rsrc_show,
-			nubus_proc_alloc_pde_data(data, 0));
+	proc_create_data(name, S_IFREG | 0444, procdir,
+			 &nubus_rsrc_proc_ops,
+			 nubus_proc_alloc_pde_data(data, 0));
 }
 
 /*
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 052a611081ec..a05350a4e49c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1043,6 +1043,16 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	return false;
 }
 
+static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
+{
+	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
+	int ret = acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
+				    ACPI_ADR_SPACE_PCI_CONFIG, val);
+	if (ret)
+		pci_dbg(dev, "ACPI _REG %s evaluation failed (%d)\n",
+			enable ? "connect" : "disconnect", ret);
+}
+
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
@@ -1053,32 +1063,49 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 		[PCI_D3hot] = ACPI_STATE_D3_HOT,
 		[PCI_D3cold] = ACPI_STATE_D3_COLD,
 	};
-	int error = -EINVAL;
+	int error;
 
 	/* If the ACPI device has _EJ0, ignore the device */
 	if (!adev || acpi_has_method(adev->handle, "_EJ0"))
 		return -ENODEV;
 
 	switch (state) {
-	case PCI_D3cold:
-		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
-				PM_QOS_FLAGS_ALL) {
-			error = -EBUSY;
-			break;
-		}
-		fallthrough;
 	case PCI_D0:
 	case PCI_D1:
 	case PCI_D2:
 	case PCI_D3hot:
-		error = acpi_device_set_power(adev, state_conv[state]);
+	case PCI_D3cold:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (state == PCI_D3cold) {
+		if (dev_pm_qos_flags(&dev->dev, PM_QOS_FLAG_NO_POWER_OFF) ==
+				PM_QOS_FLAGS_ALL)
+			return -EBUSY;
+
+		/* Notify AML lack of PCI config space availability */
+		acpi_pci_config_space_access(dev, false);
 	}
 
-	if (!error)
-		pci_dbg(dev, "power state changed by ACPI to %s\n",
-		        acpi_power_state_string(adev->power.state));
+	error = acpi_device_set_power(adev, state_conv[state]);
+	if (error)
+		return error;
 
-	return error;
+	pci_dbg(dev, "power state changed by ACPI to %s\n",
+	        acpi_power_state_string(adev->power.state));
+
+	/*
+	 * Notify AML of PCI config space availability.  Config space is
+	 * accessible in all states except D3cold; the only transitions
+	 * that change availability are transitions to D3cold and from
+	 * D3cold to D0.
+	 */
+	if (state == PCI_D0)
+		acpi_pci_config_space_access(dev, true);
+
+	return 0;
 }
 
 pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 222a28320e1c..83851078ce46 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -845,7 +845,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	request_mask &= STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
 			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
-			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTIME |
+			STATX_INO | STATX_SIZE | STATX_BLOCKS |
 			STATX_CHANGE_COOKIE;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 53bec6d4297b..e9cf8dcd4b83 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -384,7 +384,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
 
 /* Bits set in the VMA until the stack is in its final location */
-#define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
+#define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
 
 #define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
 
@@ -406,8 +406,10 @@ extern unsigned int kobjsize(const void *objp);
 
 #ifdef CONFIG_STACK_GROWSUP
 #define VM_STACK	VM_GROWSUP
+#define VM_STACK_EARLY	VM_GROWSDOWN
 #else
 #define VM_STACK	VM_GROWSDOWN
+#define VM_STACK_EARLY	0
 #endif
 
 #define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
diff --git a/mm/nommu.c b/mm/nommu.c
index 07a3af6a94ea..4e0c28644ffa 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -637,8 +637,13 @@ EXPORT_SYMBOL(find_vma);
 struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
 			unsigned long addr, struct pt_regs *regs)
 {
+	struct vm_area_struct *vma;
+
 	mmap_read_lock(mm);
-	return vma_lookup(mm, addr);
+	vma = vma_lookup(mm, addr);
+	if (!vma)
+		mmap_read_unlock(mm);
+	return vma;
 }
 
 /*
diff --git a/scripts/tags.sh b/scripts/tags.sh
index ea31640b2671..f6b3c7cd39c7 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -32,6 +32,13 @@ else
 	tree=${srctree}/
 fi
 
+# gtags(1) refuses to index any file outside of its current working dir.
+# If gtags indexing is requested and the build output directory is not
+# the kernel source tree, index all files in absolute-path form.
+if [[ "$1" == "gtags" && -n "${tree}" ]]; then
+	tree=$(realpath "$tree")/
+fi
+
 # Detect if ALLSOURCE_ARCHS is set. If not, we assume SRCARCH
 if [ "${ALLSOURCE_ARCHS}" = "" ]; then
 	ALLSOURCE_ARCHS=${SRCARCH}
@@ -131,7 +138,7 @@ docscope()
 
 dogtags()
 {
-	all_target_sources | gtags -i -f -
+	all_target_sources | gtags -i -C "${tree:-.}" -f - "$PWD"
 }
 
 # Basic regular expressions with an optional /kind-spec/ for ctags and
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6f9347ade82c..fba7bec96acd 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -6,7 +6,6 @@ ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=devm_cxl_port_enumerate_dports
 ldflags-y += --wrap=devm_cxl_setup_hdm
-ldflags-y += --wrap=devm_cxl_enable_hdm
 ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
 ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 652b7dae1feb..c4e53f22e421 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -149,21 +149,6 @@ struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_setup_hdm, CXL);
 
-int __wrap_devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
-{
-	int index, rc;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_port(port->uport))
-		rc = 0;
-	else
-		rc = devm_cxl_enable_hdm(port, cxlhdm);
-	put_cxl_mock_ops(index);
-
-	return rc;
-}
-EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_enable_hdm, CXL);
-
 int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
 	int rc, index;
