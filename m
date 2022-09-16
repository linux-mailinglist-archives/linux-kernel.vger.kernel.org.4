Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07545BB074
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiIPPlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIPPl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:41:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52ADAED9A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:41:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f20so27575702edf.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4Y49wO5if8dVXJUM/lLU/u2tbdHWf8HN21G4C2cOXAA=;
        b=J7+k6B90oXr8zKczMc+zpfIK32+koi+bD5JJU4f6MIDwrog16RfYsOpInUd1lcsecF
         sE37uoLmN76CbhVqFvHWJt6XpjIVCmEVTi9I6/IYhA/oKyLGYSgIKdaitUbHE4ohGEJ+
         bJQkgAhsBeAi3BnN2y3tOnVMssAdZoexjJasxsCAL62TULYNtXdAwsyShuqFAl73jPW8
         6lZ6PVSk5ZRAOKtcSgqTUR4pj6c5acam6MUDgwunD5BbU24v6RkP8ZSYpY9YlyxNi6ev
         c7qRD31yQ9rmkwOgPl5cke7fjou5Maw2d6aGiSG+e55UrWjc4HXpCDGmjvCT1C6ip74v
         cXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4Y49wO5if8dVXJUM/lLU/u2tbdHWf8HN21G4C2cOXAA=;
        b=QI2nGBlJEu2JeITTGmb9OMWyXFLm4BAZ7RAcQKGfayt2T+DHNfENd6T7gD8gOA5K6o
         L3HSYjJ8O3hPUqgoBzMHr+wkktqRFC2IKn1kPvPehihqtBgzYLQI2/tQrsL1yj3ajDNL
         ZwkxWynTjCWeXOjzx1a4WRxToyjPXQJxmhdPmwwD0GsKx7NwgmqFyraI6a/WD17RHwFJ
         MIwY51uWmVuhbo9is+Mu8/u+Y5Yeg99HbIXs2X/zqIG6d21gNMOzf7L25ZhtxAEjT8/G
         ag4exJMCXUCz+2aYhOsfgdkEonq2fBw/WAEGa+3jbRZbpVnC15cIopihQUesJpwGsklu
         wUSA==
X-Gm-Message-State: ACrzQf2UWDRZFUpa7r288/IQ+X3bQ1zxvlowC1InEA77LPXd/97ASN8e
        zBc117Zwx29yhJG4MkzWiAEUMw==
X-Google-Smtp-Source: AMsMyM7u6x3NnM/F4eV4mPF0Wen5ve56biEAvdUlKok5uYNh9//Y0Hus/jIOaK0OL7oq4oEOcc3JiA==
X-Received: by 2002:a05:6402:2694:b0:450:d537:f6d6 with SMTP id w20-20020a056402269400b00450d537f6d6mr4531642edd.344.1663342884196;
        Fri, 16 Sep 2022 08:41:24 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e10-20020a1709062c0a00b0073d638a7a89sm10567707ejh.99.2022.09.16.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:41:23 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/9] misc: fastrpc: Add support for audiopd
Date:   Fri, 16 Sep 2022 18:40:59 +0300
Message-Id: <20220916154102.1768088-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916154102.1768088-1-abel.vesa@linaro.org>
References: <20220916154102.1768088-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to start the adsp listener for audiopd using adsprpcd,
we need to add the corresponding ioctl for creating a static process.
On that ioctl call we need to allocate the heap. Allocating the heap needs
to be happening only once and needs to be kept between different device
open calls, so attach it to the channel context to make sure that remains
until the RPMSG driver is removed. Then, if there are any VMIDs associated
with the static ADSP process, do a call to SCM to assign it.
And then, send all the necessary info related to heap to the DSP.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c      | 135 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |   7 ++
 2 files changed, 142 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a1e916902deb..b123b6783920 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -37,8 +37,20 @@
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
@@ -72,6 +84,7 @@
 		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
 
 #define FASTRPC_CREATE_PROCESS_NARGS	6
+#define FASTRPC_CREATE_STATIC_PROCESS_NARGS	3
 /* Remote Method id table */
 #define FASTRPC_RMID_INIT_ATTACH	0
 #define FASTRPC_RMID_INIT_RELEASE	1
@@ -261,6 +274,7 @@ struct fastrpc_channel_ctx {
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
+	struct fastrpc_buf *remote_heap;
 	bool secure;
 	bool unsigned_support;
 };
@@ -1167,6 +1181,7 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		spin_unlock(&fl->lock);
 		fastrpc_context_put(ctx);
 	}
+
 	if (err)
 		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
 
@@ -1191,6 +1206,120 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
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
@@ -1918,6 +2047,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
 		err = fastrpc_init_attach(fl, SENSORS_PD);
 		break;
+	case FASTRPC_IOCTL_INIT_CREATE_STATIC:
+		err = fastrpc_init_create_static_process(fl, argp);
+		break;
 	case FASTRPC_IOCTL_INIT_CREATE:
 		err = fastrpc_init_create_process(fl, argp);
 		break;
@@ -2187,6 +2319,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
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
2.34.1

