Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E37637E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiKXRwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiKXRvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:51:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F209A14A2ED
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v7so1822737wmn.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uJnnFI92/NPRiP6WIUFOR8d16yKk84qiKlemig/24Y=;
        b=WmiNc6ldia7GRs/sXSbOcmyBhED2RsdsBDLtIlWDdgtQzym8uQg4jacEy85AG4KPqk
         kn5z4dYKJ/f+p3F5jZ71qch0PE+zHW762REuGfHcnYOdT1iBuvO78kK7sJbbbrFQiQ0N
         FPRJXLS2RWxAVpHenpiZUM0hA4ERezYTjqPecunuYDtQ+InYSH9D/tB1feVeucjiODF/
         j3Z+R3FOEFxVKwVtmkgw7dNwSE/gccExpjwqk7bhas7pDBwy6RbISk37gxVIIjCywyPZ
         KVYEN0IwzoGMV+hU5O7SpWar8xWJRXeiXXf0blUciaGQQKjONIIsG7JkmN8Yst+0C616
         zXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uJnnFI92/NPRiP6WIUFOR8d16yKk84qiKlemig/24Y=;
        b=tp0x9PHDC0EKluJDzHfvbrvpYzxmByUxlTXqBddBTQI9sLkSQLGzBZEaL+WMKXD1u0
         nywrSOxswTl8G9je+YQJ98XARz+zzMTD8nfLxQvHRoKidmP6Ugux4rkuxvbH81xVfZCO
         Af+vwHV2fRB3/8FZ6H7Q9yKOzXVu8GgTeH2z57CVEyAx37OnrcHRQLBs1uuWrbgDOf42
         2F0+7q1sW14mV9J8vIASyACdTPBjeJ5UfBwhrIiki8zXCCORmTe5eUVOyCqPAptJP/mr
         1EFxe4oAEXBLRh6yI+EIrTmWGj02PvXlFjwIJckYMP81j1WfKcaT0bY0lgULiOCPSjkM
         iz9w==
X-Gm-Message-State: ANoB5pnXi07wJkoWZtcFdDg6nb55NP8j8mgg87LmvdIG2UgLKmJd57DZ
        VcCC2hJ/Soe97fm1Yg8UkYvicg==
X-Google-Smtp-Source: AA0mqf6laUILDqrp3T6xGVOmtQTAXM01STzH0hbg1pk8/aLrmYxY6qXoYSQLK+kLxDDLnHv+B3AmgA==
X-Received: by 2002:a1c:f401:0:b0:3c7:84d:72d with SMTP id z1-20020a1cf401000000b003c7084d072dmr10929864wma.181.1669312307522;
        Thu, 24 Nov 2022 09:51:47 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b003c701c12a17sm6394192wmb.12.2022.11.24.09.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:51:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/11] misc: fastrpc: Add support for audiopd
Date:   Thu, 24 Nov 2022 17:51:22 +0000
Message-Id: <20221124175125.418702-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
References: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

In order to be able to start the adsp listener for audiopd using adsprpcd,
we need to add the corresponding ioctl for creating a static process.
On that ioctl call we need to allocate the heap. Allocating the heap needs
to be happening only once and needs to be kept between different device
open calls, so attach it to the channel context to make sure that remains
until the RPMSG driver is removed. Then, if there are any VMIDs associated
with the static ADSP process, do a call to SCM to assign it.
And then, send all the necessary info related to heap to the DSP.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c      | 135 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |   7 ++
 2 files changed, 142 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9a373fcb4ba0..00e741fd6d91 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -38,8 +38,20 @@
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
 #define FASTRPC_CTXID_MASK (0xFF0)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
+#define INIT_FILE_NAMELEN_MAX (128)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
+
+/* Add memory to static PD pool, protection thru XPU */
+#define ADSP_MMAP_HEAP_ADDR  4
+/* MAP static DMA buffer on DSP User PD */
+#define ADSP_MMAP_DMA_BUFFER  6
+/* Add memory to static PD pool protection thru hypervisor */
+#define ADSP_MMAP_REMOTE_HEAP_ADDR  8
+/* Add memory to userPD pool, for user heap */
 #define ADSP_MMAP_ADD_PAGES 0x1000
+/* Add memory to userPD pool, for LLC heap */
+#define ADSP_MMAP_ADD_PAGES_LLC 0x3000,
+
 #define DSP_UNSUPPORTED_API (0x80000414)
 /* MAX NUMBER of DSP ATTRIBUTES SUPPORTED */
 #define FASTRPC_MAX_DSP_ATTRIBUTES (256)
@@ -73,6 +85,7 @@
 		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
 
 #define FASTRPC_CREATE_PROCESS_NARGS	6
+#define FASTRPC_CREATE_STATIC_PROCESS_NARGS	3
 /* Remote Method id table */
 #define FASTRPC_RMID_INIT_ATTACH	0
 #define FASTRPC_RMID_INIT_RELEASE	1
@@ -262,6 +275,7 @@ struct fastrpc_channel_ctx {
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
+	struct fastrpc_buf *remote_heap;
 	bool secure;
 	bool unsigned_support;
 };
@@ -1170,6 +1184,7 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		spin_unlock(&fl->lock);
 		fastrpc_context_put(ctx);
 	}
+
 	if (err)
 		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
 
@@ -1194,6 +1209,120 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
 	return false;
 }
 
+static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
+					      char __user *argp)
+{
+	struct fastrpc_init_create_static init;
+	struct fastrpc_invoke_args *args;
+	struct fastrpc_phy_page pages[1];
+	char *name;
+	int err;
+	struct {
+		int pgid;
+		u32 namelen;
+		u32 pageslen;
+	} inbuf;
+	u32 sc;
+
+	args = kcalloc(FASTRPC_CREATE_STATIC_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
+	if (!args)
+		return -ENOMEM;
+
+	if (copy_from_user(&init, argp, sizeof(init))) {
+		err = -EFAULT;
+		goto err;
+	}
+
+	if (init.namelen > INIT_FILE_NAMELEN_MAX) {
+		err = -EINVAL;
+		goto err;
+	}
+
+	name = kzalloc(init.namelen, GFP_KERNEL);
+	if (!name) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	if (copy_from_user(name, (void __user *)(uintptr_t)init.name, init.namelen)) {
+		err = -EFAULT;
+		goto err_name;
+	}
+
+	if (!fl->cctx->remote_heap) {
+		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
+						&fl->cctx->remote_heap);
+		if (err)
+			goto err_name;
+
+		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
+		if (fl->cctx->vmcount) {
+			unsigned int perms = BIT(QCOM_SCM_VMID_HLOS);
+
+			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
+							(u64)fl->cctx->remote_heap->size, &perms,
+							fl->cctx->vmperms, fl->cctx->vmcount);
+			if (err) {
+				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
+					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
+				goto err_map;
+			}
+		}
+	}
+
+	inbuf.pgid = fl->tgid;
+	inbuf.namelen = init.namelen;
+	inbuf.pageslen = 0;
+	fl->pd = USER_PD;
+
+	args[0].ptr = (u64)(uintptr_t)&inbuf;
+	args[0].length = sizeof(inbuf);
+	args[0].fd = -1;
+
+	args[1].ptr = (u64)(uintptr_t)name;
+	args[1].length = inbuf.namelen;
+	args[1].fd = -1;
+
+	pages[0].addr = fl->cctx->remote_heap->phys;
+	pages[0].size = fl->cctx->remote_heap->size;
+
+	args[2].ptr = (u64)(uintptr_t) pages;
+	args[2].length = sizeof(*pages);
+	args[2].fd = -1;
+
+	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
+
+	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
+				      sc, args);
+	if (err)
+		goto err_invoke;
+
+	kfree(args);
+
+	return 0;
+err_invoke:
+	if (fl->cctx->vmcount) {
+		struct qcom_scm_vmperm perm;
+
+		perm.vmid = QCOM_SCM_VMID_HLOS;
+		perm.perm = QCOM_SCM_PERM_RWX;
+		err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
+						(u64)fl->cctx->remote_heap->size,
+						&(fl->cctx->vmperms[0].vmid), &perm, 1);
+		if (err)
+			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
+	}
+err_map:
+	fastrpc_buf_free(fl->cctx->remote_heap);
+err_name:
+	kfree(name);
+err:
+	kfree(args);
+
+	return err;
+}
+
 static int fastrpc_init_create_process(struct fastrpc_user *fl,
 					char __user *argp)
 {
@@ -1921,6 +2050,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
 		err = fastrpc_init_attach(fl, SENSORS_PD);
 		break;
+	case FASTRPC_IOCTL_INIT_CREATE_STATIC:
+		err = fastrpc_init_create_static_process(fl, argp);
+		break;
 	case FASTRPC_IOCTL_INIT_CREATE:
 		err = fastrpc_init_create_process(fl, argp);
 		break;
@@ -2190,6 +2322,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
+	if (cctx->remote_heap)
+		fastrpc_buf_free(cctx->remote_heap);
+
 	of_platform_depopulate(&rpdev->dev);
 
 	cctx->rpdev = NULL;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 5e29f2cfa42d..f33d914d8f46 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -13,6 +13,7 @@
 #define FASTRPC_IOCTL_MMAP		_IOWR('R', 6, struct fastrpc_req_mmap)
 #define FASTRPC_IOCTL_MUNMAP		_IOWR('R', 7, struct fastrpc_req_munmap)
 #define FASTRPC_IOCTL_INIT_ATTACH_SNS	_IO('R', 8)
+#define FASTRPC_IOCTL_INIT_CREATE_STATIC _IOWR('R', 9, struct fastrpc_init_create_static)
 #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
 #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
 #define FASTRPC_IOCTL_GET_DSP_INFO	_IOWR('R', 13, struct fastrpc_ioctl_capability)
@@ -87,6 +88,12 @@ struct fastrpc_init_create {
 	__u64 file;	/* pointer to elf file */
 };
 
+struct fastrpc_init_create_static {
+	__u32 namelen;	/* length of pd process name */
+	__u32 memlen;
+	__u64 name;	/* pd process name */
+};
+
 struct fastrpc_alloc_dma_buf {
 	__s32 fd;	/* fd */
 	__u32 flags;	/* flags to map with */
-- 
2.25.1

