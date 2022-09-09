Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7495B39B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIINmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiIINlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:41:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC1BBD0B5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:40:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d2so2833922wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=x1sIAv0g5lJ7BD6ztHJ8LsE4l5XIJIwUbyF/bh6BeM4=;
        b=b3R3PFHjbkE/aiO+BIczem7tpNDOhKJgyO06x3UyRfncbCYSo/220ehkUQECA9G00N
         UrMQRTWiNJhAhxHkswAxk9ZsxJpXCqZg6SME4SQubq5r8kfHMAFBOus6org5KuJju0Hm
         Nko5B1fHFiecgvmhNWKmttOBYgaPIqUND9wuRHwyspjXz6Y19Fl9jcsEhMfQ7Vr4rXj7
         JHjvR1ou6u2/aoFjWtf8y7wwqecDZQQdpUmfWKrL6owTfd05bAqDtCw6dMqihpH0I/BE
         U832VS2Ap4+pksyIIyeZE+rmMEIQQXaTo8JP/o1+A1JbK99v5gi4eH9daotgOn0A/IWw
         tEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=x1sIAv0g5lJ7BD6ztHJ8LsE4l5XIJIwUbyF/bh6BeM4=;
        b=CnbynnGGi7E5y6Fg/3XMtV17y8kY9QRbBBdQCUrgB3IMclRHc/xotZgrD+TZyZFrLu
         sEDj4/KDk+tbkEIVpaKQArPBr/VRgvyuhLcklepefxpvTfCAfbjRF/m+b80apd/6AGU/
         uDpztkmirN0HvrrxDWNXpxFUj82AE9mXDXWSYGx/RdqJBPXl7NntYwdRvCeHeJLaaHCT
         Qed377ui/+sBAIzPvBsEm5VKsO8sijkx0T726hKTfuqoBumsYBSgcJ/NGvgshw0uo6bP
         CkRAe7/PWdDlSnlIxhGr4bcAgx3k3zpO7MiqqBu9h5rxbEZ+1V/3DBYNSshOZdb23uBb
         2s6A==
X-Gm-Message-State: ACgBeo28rfWlF0a9B0X54m3HrKXUdUJFNbqwScSr3J6RPPlCg8L87Ek1
        1do9YQnmwHY+5dcOBdPHxZtJMg==
X-Google-Smtp-Source: AA6agR6pYZob2OcPhYWbu76bYxu9m4mEHWEA0pg1EJTDE1hgWzvlk9bUgbSoa1Gtvrqtb/XCd7CErQ==
X-Received: by 2002:adf:fb8f:0:b0:225:2def:221e with SMTP id a15-20020adffb8f000000b002252def221emr8120438wrr.130.1662730849155;
        Fri, 09 Sep 2022 06:40:49 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q20-20020a1cf314000000b003a604a29a34sm660622wmq.35.2022.09.09.06.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:40:48 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 07/10] misc: fastrpc: Add support for audiopd
Date:   Fri,  9 Sep 2022 16:39:35 +0300
Message-Id: <20220909133938.3518520-8-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909133938.3518520-1-abel.vesa@linaro.org>
References: <20220909133938.3518520-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Changes since v2:
 * dropped blank line and unnecessary debug message, as Srinivas
   suggested
 * added mem assign rollback on invoke failure, as Srinivas suggested
 * changed the IOCTL number to 9, as Ekansh suggested (offline)

 drivers/misc/fastrpc.c      | 135 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |   7 ++
 2 files changed, 142 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1f6d63bf637d..6b2a552dbdba 100644
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
@@ -2183,6 +2315,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
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

