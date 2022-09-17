Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169205BB6F2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIQHYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:08 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F3813CDD
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:04 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220917072359epoutp0253500df326610f1dad80e209365b5005~VlPo8S7ja3089630896epoutp02e
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:23:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220917072359epoutp0253500df326610f1dad80e209365b5005~VlPo8S7ja3089630896epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399439;
        bh=7yWBJ/9IHKdlYcm4v5OsHGyN/js81fAPMnvaCu5X7H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ClbsdrFNazPK5hGeUh02KtQCefXrLC61v9mk/EdYs9ECV+7j8SRgKfiHxcaLoECFz
         qTrQF9MFX7Oo54ddZ/zyVUYpOc8DUcBtsKRWgUUy6b0G/lkAR53JEeYE2EH8Tp4SJu
         MHU960742dds+LEvGIYqw/NrqgQqwPG+yVMD0P/g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220917072359epcas1p49b7d9928999f60f8df79eebae569038e~VlPoQGD5y1033410334epcas1p4i;
        Sat, 17 Sep 2022 07:23:59 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.145]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MV2Vk1T4lz4x9Pt; Sat, 17 Sep
        2022 07:23:58 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.1D.57013.E0675236; Sat, 17 Sep 2022 16:23:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epcas1p4a5b3939adbe5e24c11bd2541f76f23f6~VlPmuRd1F2768227682epcas1p40;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220917072357epsmtrp22b139e55cce4ed635b250ab29f412aeb~VlPmteaMQ1654916549epsmtrp2u;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
X-AuditID: b6c32a37-ff5fb7000001deb5-18-6325760ea1e0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.45.14392.D0675236; Sat, 17 Sep 2022 16:23:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epsmtip23cc9d7a40f7046462ccc1658e218e819~VlPmeTcBh3200932009epsmtip2W;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 03/13] trinity: Add IDU feature
Date:   Sat, 17 Sep 2022 16:23:46 +0900
Message-Id: <20220917072356.2255620-4-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdljTQJevTDXZ4MI0Vou/k46xW0x9+ITN
        onnxejaL9927mS32vt7KbnF51xw2i9uNK9gs9vV8ZLR4Pu06iwOnx+9fkxg9Nq3qZPO4c20P
        m8f+uWvYPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
        LzE31VbJxSdA1y0zB+gqJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJu
        cWleul5eaomVoYGBkSlQYUJ2xu7ebraC6V2MFbv7e5gbGK8VdDFycEgImEgs/1rUxcjFISSw
        g1FixesTbBDOJ0aJHRNb2CGcb4wSq6Z9A8pwgnXsuD+PBSKxl1GiddIZJgjnM6PEkU/XGUGq
        2ARUJWbOWMMOYosIlEs0bzwBZjML5Eg8udPEDGILCxhJbJ/eADaVBah+/sejTCA38QpYS3xY
        CRbmFLCRuLmpiQXE5hUQlDg58wkLxBh5ieats5khDvrILnH3fTGE7SIxZ9I/JghbWOLV8S3s
        ELaUxOd3e6EeyJaY0rGIBcIukDj3fCszJCiMJS6uSAExmQU0Jdbv0oeoUJTY+XsuI8RWPol3
        X3tYIap5JTrahCBKlCSW/DkMtUhCYuqMb1AHeEhcv7gQGoT9jBJ7u7ewTGCUn4XkmVlInpmF
        sHkBI/MqRrHUguLc9NRiwwJjeJwm5+duYgSnSy3zHYzT3n7QO8TIxMF4iFGCg1lJhFfVUyVZ
        iDclsbIqtSg/vqg0J7X4EKMpMHQnMkuJJucDE3ZeSbyhiaWBiZmRsYmFoZmhkjivnjZjspBA
        emJJanZqakFqEUwfEwenVAPTSZc/Nmuf19+b95fFffYPNsuOL38T7CWqZ9+awMP5cMvOFd9/
        G6n8MtVY+m/O+iyDfZ2qHHmX2EPYLnJ8OrGwOKss+CmPaJ3a2p1Ve/YvWJ532Ca27M/77jsh
        keZ1Gis0e3xe50QeOh50bbmAzfq6rXq5Hr8YDurdqHpXtLNCSsZbwzLys3yykKe5sO9663dT
        yjtrzROfdP0qkn/p9/rfbuecI/MEGkWuTq6TMuuW3CXmofJhjn4Mk8LUnCkf52WdsDm25/8c
        +RAj+Q2SWe912lt5Tf60C3lfvGk88Zogr3lWRn6Oqsc1pb73U88m6i7YfzuTK4Vh7b6Nu5bo
        /Mmcvnzr7LsMpcE3Z4jwa01QYinOSDTUYi4qTgQAPpTeliAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSvC5vmWqywacmcYu/k46xW0x9+ITN
        onnxejaL9927mS32vt7KbnF51xw2i9uNK9gs9vV8ZLR4Pu06iwOnx+9fkxg9Nq3qZPO4c20P
        m8f+uWvYPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStjd283W8H0LsaK3f09zA2M1wq6GDk5
        JARMJHbcn8fSxcjFISSwm1Fiw4RLzBAJCYlN95YD2RxAtrDE4cPFEDUfGSUOTb/KBFLDJqAq
        MXPGGnYQW0SgVuLg0flgvcwCBRKzn85kAbGFBYwktk9vYAOxWYDq5388ygQyk1fAWuLDSrAw
        p4CNxM1NTWDlQkDh2dPngo3nFRCUODnzCQvESHmJ5q2zmScw8s9CkpqFJLWAkWkVo2RqQXFu
        em6xYYFhXmq5XnFibnFpXrpecn7uJkZwaGtp7mDcvuqD3iFGJg7GQ4wSHMxKIryqnirJQrwp
        iZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTCFLJJOSlLt+dN4
        K6H0jbBATr3zfD0nhblveu/vUNt5snvRq4hdK5s+yloGM0gpXN7LLyxQEd1/qndHf3fs7Qdn
        WdedPKr/Simr61ToCpP1PjxT0haL8rUE7kvtmvcpXGvfdwlZHRmD/j+Ch+elrDB8WJT3t7zq
        p3TFvcXbA8zWGe6oqlq6LDRpVoD4y6Ct3ZF1HTNrU0W5eJdMtM1lXCI3feNsRWvOF9Hitb80
        gmdUe77juFoXG6Kc3f7N+r/ZnVCeuotTrFbV7HuWtNRCImOV3u5/LXFnJ99+Fpi6S+DktE5x
        ZY3rFaYKTb8i1QOYp3/RCS/4rNYi4t32nJN3t49Qal/b3jv1fwXT/GIfK7EUZyQaajEXFScC
        AMrW++rcAgAA
X-CMS-MailID: 20220917072357epcas1p4a5b3939adbe5e24c11bd2541f76f23f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p4a5b3939adbe5e24c11bd2541f76f23f6
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072357epcas1p4a5b3939adbe5e24c11bd2541f76f23f6@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements IDU set/unset works.

Samsung NPU loads Instruction Decoder Unit (IDU) program,
which can decode binary code generated by NPU compiler.
The IDU program is loaded with ioctl mannager, and the NPU
starts to execute the codes of compiled decoder binary.
Then, all operations of the NPU is working with the decoder
program which can fetch and execute predefined virtual ISA.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/trinity.c             |  44 ++
 drivers/misc/trinity/trinity_vision2_drv.c | 466 +++++++++++++++++++++
 2 files changed, 510 insertions(+)

diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
index 3a492eef011f..3e8157dd4664 100644
--- a/drivers/misc/trinity/trinity.c
+++ b/drivers/misc/trinity/trinity.c
@@ -36,6 +36,50 @@ int trinity_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+/**
+ * trinity_set_pause() - Pause trinity device
+ *
+ * @drv: an instance of trinity driver
+ *
+ * Returns 0 on success. Otherwise, returns negative error.
+ */
+int trinity_set_pause(struct trinity_driver *drv)
+{
+	drv->desc->set_state(drv, TRINITY_STATE_PAUSE);
+
+	return 0;
+}
+
+/**
+ * trinity_wait_ready() - Wait until trinity is ready state
+ *
+ * @drv: an instance of trinity driver
+ *
+ * Returns 0 on success. Otherwise, returns negative error.
+ */
+int trinity_wait_ready(struct trinity_driver *drv)
+{
+	const unsigned long time_out = HZ / 100UL; /* 1/100 seconds*/
+	const unsigned int max_retry = 10;
+	unsigned int retry = 0;
+	wait_queue_head_t wq;
+
+	drv->desc->set_state(drv, TRINITY_STATE_READY);
+
+	init_waitqueue_head(&wq);
+	/* try to ensure that NPU is in the ready state */
+	while (wait_event_timeout(
+		       wq, drv->desc->get_state(drv) == TRINITY_STATE_READY,
+		       time_out) == 0) {
+		/* regarded as failure */
+		if (retry == max_retry)
+			return -ETIMEDOUT;
+		retry++;
+	}
+
+	return 0;
+}
+
 /**
  * trinity_open() - A common callback for open() in file_operations for a Trinity
  *		device node. If device-specific open() is required, this
diff --git a/drivers/misc/trinity/trinity_vision2_drv.c b/drivers/misc/trinity/trinity_vision2_drv.c
index bc43cafa39fb..4bfc7f97769c 100644
--- a/drivers/misc/trinity/trinity_vision2_drv.c
+++ b/drivers/misc/trinity/trinity_vision2_drv.c
@@ -88,6 +88,7 @@ struct triv2_cmd_info {
 
 	struct triv2_req *reqs[TRIV2_MAX_CMDSLOTS];
 	struct triv2_cmd cur_cmd;
+	struct trinity_dma buf;
 };
 
 struct triv2_hashed_cmd_info {
@@ -107,6 +108,8 @@ struct triv2_kernel_req {
 struct triv2_req {
 	struct trinity_req req;
 
+	struct trinity_hwmem_import *seg_import;
+
 	int cmd_slot;
 
 	/** kernel requets */
@@ -120,13 +123,102 @@ struct triv2_req {
 	uint32_t total_segment_size;
 };
 
+struct triv2_idu {
+	phys_addr_t *addrs;
+	size_t addr_num;
+	struct trinity_hwmem_import data;
+	struct trinity_hwmem_import code;
+	dma_addr_t dspm;
+};
+
 struct triv2_pdata {
 	struct trinity_driver *drv;
 
+	/* idu info */
+	struct triv2_idu idu_cp;
+	struct triv2_idu idu_dsp;
+	uint32_t idu_version;
+
 	/* command info */
 	struct triv2_cmd_info cmd_info;
+
+	/* back buffer for context switching */
+	struct trinity_dma back_buf;
 };
 
+static void triv2_idu_setup(struct trinity_driver *drv);
+static void triv2_idu_unset(struct trinity_driver *drv);
+static int32_t triv2_idu_set(struct trinity_driver *drv,
+			struct trinity_ioctl_idu *config);
+
+/**
+ * triv2_get_state() - Get state (TRINITY_STATE_READY/TRINITY_STATE_PAUSE) of the device.
+ * @returns (enum triv2_state) TRINITY_STATE_READY (i.e., 1) or TRINITY_STATE_PAUSE (i.e., 0 )
+ * according to the state of the device
+ */
+int32_t triv2_get_state(const struct trinity_driver *drv)
+{
+	if (ioread32(drv->mmreg_vaddr[0] + OFFSET_NPU_CMD_READY) == 1)
+		return TRINITY_STATE_READY;
+
+	return TRINITY_STATE_PAUSE;
+}
+
+/**
+ * triv2_set_state() - Set state of the device to TRINITY_STATE_READY (1) or TRINITY_STATE_PAUSE (0)
+ */
+static void triv2_set_state(const struct trinity_driver *drv,
+			    enum trinity_state state)
+{
+	void __iomem *addr;
+
+	switch (state) {
+	case TRINITY_STATE_PAUSE:
+		/* CP */
+		addr = trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+					      OFFSET_CP_PROC_SET);
+		trinity_set_bit(BIT_SET_PAUSE, addr);
+		iowrite32(0, addr);
+
+		/* DSP */
+		addr = trinity_get_iomem_addr(drv->mmreg_vaddr[1],
+					      OFFSET_DSP_PROC_SET);
+		trinity_set_bit(BIT_SET_PAUSE, addr);
+		iowrite32(0, addr);
+
+		break;
+	case TRINITY_STATE_READY:
+		/* CP */
+		addr = trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+					      OFFSET_CP_PROC_CLR);
+		trinity_set_bit(BIT_CLR_PAUSE, addr);
+		iowrite32(0, addr);
+
+		/* DSP */
+		addr = trinity_get_iomem_addr(drv->mmreg_vaddr[1],
+					      OFFSET_DSP_PROC_CLR);
+		trinity_set_bit(BIT_CLR_PAUSE, addr);
+		iowrite32(0, addr);
+
+		/* Performance Counter */
+		addr = trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+					      OFFSET_CP_CNT_CFG);
+		trinity_set_bit(BIT_CNT_IST_EN | BIT_CNT_FR_EN, addr);
+		break;
+	default:
+		dev_err(drv_to_dev_ptr(drv),
+			"failed to set state of the NPU state: %d", state);
+	}
+}
+
+static void triv2_wakeup_cp(const struct trinity_driver *drv)
+{
+	void *addr =
+		trinity_get_iomem_addr(drv->mmreg_vaddr[0], OFFSET_CP_PROC_SET);
+
+	trinity_set_bit(BIT_SET_SEND_EVT1, addr);
+}
+
 static void triv2_reset(struct trinity_driver *drv)
 {
 	struct triv2_pdata *pdata = drv->pdata;
@@ -136,6 +228,9 @@ static void triv2_reset(struct trinity_driver *drv)
 	triv2_cancel_reqs(pdata->drv);
 	msleep(100);
 
+	triv2_setup_buffers(drv);
+	triv2_idu_unset(drv);
+
 	mutex_unlock(&pdata->drv->lock);
 }
 
@@ -159,15 +254,254 @@ static int triv2_release(struct inode *inode, struct file *f)
 
 static const struct file_operations triv2_fops = {
 	.owner = THIS_MODULE,
+	.unlocked_ioctl = triv2_ioctl,
 	.open = triv2_open,
 	.release = triv2_release,
 	.llseek = noop_llseek,
 };
 
+static void triv2_setup_cp(struct trinity_driver *drv, phys_addr_t paddr)
+{
+	iowrite32(TRIV2_IDU_ADDR(paddr) >> 4,
+		  drv->mmreg_vaddr[0] + OFFSET_CP_IMIF_BASE);
+	iowrite32(TRIV2_IDU_ADDR(drv->mmreg_paddr[2]),
+		  drv->mmreg_vaddr[0] + OFFSET_NPU_CBOX_BASE);
+}
+
+static void triv2_setup_dsp(struct trinity_driver *drv, phys_addr_t paddr)
+{
+	iowrite32(TRIV2_IDU_ADDR(paddr) >> 4,
+		  drv->mmreg_vaddr[1] + OFFSET_DSP_IMIF_BASE);
+}
+
+static void triv2_idu_free(struct device *dev,
+			struct trinity_hwmem_import *import)
+{
+	if (!import->addr)
+		return;
+
+	trinity_hwmem_import_dmabuf_end(import);
+	import->addr = NULL;
+}
+
+static int triv2_idu_version(struct trinity_driver *drv, uint32_t *major,
+			     uint32_t *minor, uint32_t *extra)
+{
+	struct triv2_pdata *pdata;
+	uint32_t val;
+
+	if (!drv || !major || !minor || !extra)
+		return -EINVAL;
+
+	pdata = TRIV2_DRV_GET_PDATA(drv);
+	val = pdata->idu_version;
+	if (val != 0) {
+		*major = (val & TRIV2_IDU_MASK_MAJOR) >> TRIV2_IDU_SHIFT_MAJOR;
+		*minor = (val & TRIV2_IDU_MASK_MINOR) >> TRIV2_IDU_SHIFT_MINOR;
+		*extra = val & TRIV2_IDU_MASK_EXTRA;
+	} else {
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static void triv2_idu_check(struct trinity_driver *drv)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct device *dev = drv_to_dev_ptr(drv);
+	uint32_t major, minor, extra;
+
+	if (trinity_wait_ready(drv) != 0) {
+		dev_warn(dev, "Unable to load IDU properly");
+		return;
+	}
+
+	pdata->idu_version =
+		ioread32(drv->mmreg_vaddr[0] + OFFSET_NPU_IDU_VERSION);
+	if (triv2_idu_version(drv, &major, &minor, &extra) == 0)
+		dev_info(dev,
+			 "Instruction Decoder Unit (IDU) v%u.%u.%u detected",
+			 major, minor, extra);
+
+	/* paused until request created */
+	triv2_set_state(drv, TRINITY_STATE_PAUSE);
+}
+
+static void triv2_idu_fill_zero(struct trinity_driver *drv, phys_addr_t paddr,
+				size_t size)
+{
+	void *__iomem vaddr;
+
+	vaddr = memremap(paddr, PAGE_ALIGN(size), MEMREMAP_WT);
+	if (vaddr == NULL) {
+		dev_err(drv_to_dev_ptr(drv), "Failed to do ioremap() for 0x%lx",
+			(unsigned long)paddr);
+		return;
+	}
+	memset(vaddr, 0, size);
+
+	memunmap(vaddr);
+}
+
+static void triv2_idu_fill_data(struct trinity_driver *drv, phys_addr_t paddr,
+				struct trinity_hwmem_import *data)
+{
+	void *__iomem vaddr;
+
+	vaddr = memremap(paddr, PAGE_ALIGN(data->buf->size), MEMREMAP_WT);
+	if (vaddr == NULL) {
+		dev_err(drv_to_dev_ptr(drv), "Failed to do ioremap() for 0x%lx",
+			(unsigned long)paddr);
+		return;
+	}
+	memcpy(vaddr, data->addr, data->buf->size);
+
+	memunmap(vaddr);
+}
+
+static void triv2_idu_setup(struct trinity_driver *drv)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct triv2_idu *idu_cp;
+	struct triv2_idu *idu_dsp;
+
+	idu_cp = &pdata->idu_cp;
+	idu_dsp = &pdata->idu_dsp;
+
+	triv2_setup_cp(drv, idu_cp->addrs[TRIV2_IDU_CODEIDX]);
+
+	if (idu_dsp->addrs)
+		triv2_setup_dsp(drv, idu_dsp->addrs[TRIV2_IDU_CODEIDX]);
+
+	triv2_idu_check(drv);
+
+	drv->idu_set = true;
+}
+
+static void triv2_idu_unset(struct trinity_driver *drv)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+
+	triv2_idu_free(dev, &pdata->idu_cp.data);
+	triv2_idu_free(dev, &pdata->idu_dsp.data);
+
+	triv2_idu_free(dev, &pdata->idu_cp.code);
+	triv2_idu_free(dev, &pdata->idu_dsp.code);
+
+	drv->idu_set = false;
+}
+
+static int32_t triv2_idu_set(struct trinity_driver *drv,
+			struct trinity_ioctl_idu *config)
+{
+	struct device *dev;
+	struct triv2_pdata *pdata;
+	struct iommu_domain *domain;
+	struct triv2_idu *idu_cp;
+	struct triv2_idu *idu_dsp;
+	int ret;
+
+	if (!drv | !config)
+		return -EINVAL;
+
+	dev = drv_to_dev_ptr(drv);
+	pdata = TRIV2_DRV_GET_PDATA(drv);
+	domain = iommu_get_domain_for_dev(dev);
+
+	idu_cp = &pdata->idu_cp;
+	idu_dsp = &pdata->idu_dsp;
+
+	triv2_idu_unset(drv);
+
+	ret = trinity_hwmem_import_dmabuf_begin(dev, config->dbuf_cp_data,
+				  &idu_cp->data);
+	if (ret < 0)
+		return -EINVAL;
+	ret = trinity_hwmem_import_dmabuf_begin(dev, config->dbuf_cp_code,
+				  &idu_cp->code);
+	if (ret < 0)
+		return -EINVAL;
+	ret = trinity_hwmem_import_dmabuf_begin(dev, config->dbuf_dsp_data,
+				  &idu_dsp->data);
+	if (ret < 0)
+		return -EINVAL;
+	ret = trinity_hwmem_import_dmabuf_begin(dev, config->dbuf_dsp_code,
+				  &idu_dsp->code);
+	if (ret < 0)
+		return -EINVAL;
+
+	idu_cp->addrs[TRIV2_IDU_CODEIDX] =
+		trinity_get_paddr(domain, idu_cp->code.dma_addr);
+	triv2_idu_fill_zero(drv, idu_cp->addrs[TRIV2_IDU_ZEROIDX],
+			TRIV2_IDU_CP_DSPM_SIZE);
+	triv2_idu_fill_data(drv, idu_cp->addrs[TRIV2_IDU_DATAIDX],
+			&idu_cp->data);
+
+	/* DSP is optional */
+	if (idu_dsp->addrs) {
+		idu_dsp->addrs[TRIV2_IDU_CODEIDX] =
+			trinity_get_paddr(domain, idu_dsp->code.dma_addr);
+		triv2_idu_fill_zero(drv, idu_dsp->addrs[TRIV2_IDU_ZEROIDX],
+				drv->dspm + TRIV2_DSP_DSPM_OFFSET);
+		triv2_idu_fill_data(drv, idu_dsp->addrs[TRIV2_IDU_DATAIDX],
+				&idu_dsp->data);
+	}
+
+	triv2_idu_setup(drv);
+
+	/* iommu mapping for dspm segment */
+	if (drv->dspm > 0) {
+		phys_addr_t paddr;
+		dma_addr_t daddr;
+
+		domain = iommu_get_domain_for_dev(dev);
+		if (!domain)
+			return 0;
+
+		paddr = idu_dsp->addrs[0] + TRIV2_DSP_DSPM_OFFSET;
+		daddr = dma_map_resource(dev, paddr, drv->dspm,
+					 DMA_BIDIRECTIONAL, 0);
+		idu_dsp->dspm = daddr;
+	}
+
+	return 0;
+}
+
+static void triv2_setup_buffers(struct trinity_driver *drv)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct iommu_domain *domain;
+	struct trinity_dma *cmd_buf;
+	struct trinity_dma *back_buf;
+	phys_addr_t paddr;
+
+	domain = iommu_get_domain_for_dev(dev);
+	cmd_buf = TRIV2_DRV_GET_CMD_BUF(drv);
+	back_buf = TRIV2_DRV_GET_BACK_BUF(drv);
+
+	/* command */
+	paddr = trinity_get_paddr(domain, cmd_buf->dma_handle);
+	iowrite32(TRIV2_IDU_ADDR(paddr),
+		  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+					 OFFSET_NPU_CMD_BASE));
+	/* backup */
+	iowrite32(TRIV2_IDU_ADDR(back_buf->dma_handle),
+		  trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+					 OFFSET_NPU_BACK_ADDR));
+	iowrite32(back_buf->size, trinity_get_iomem_addr(drv->mmreg_vaddr[0],
+							 OFFSET_NPU_BACK_SIZE));
+}
+
 static int32_t triv2_init_pdata(struct trinity_driver *drv)
 {
+	struct device *dev = drv_to_dev_ptr(drv);
 	struct triv2_pdata *pdata;
 	struct triv2_cmd_info *cmd_info;
+	struct trinity_dma *cmd_buf;
+	struct trinity_dma *back_buf;
+	int status;
 
 	pdata = kzalloc(sizeof(struct triv2_pdata), GFP_KERNEL);
 	if (!pdata)
@@ -177,11 +511,105 @@ static int32_t triv2_init_pdata(struct trinity_driver *drv)
 	pdata->drv = drv;
 
 	cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+	cmd_buf = TRIV2_DRV_GET_CMD_BUF(drv);
+	back_buf = TRIV2_DRV_GET_BACK_BUF(drv);
 
 	spin_lock_init(&cmd_info->lock);
 	/* init cmd bitmap */
 	bitmap_zero(cmd_info->bitmap, TRIV2_MAX_CMDSLOTS);
 
+	/* alloc command buffer */
+	status = trinity_dma_alloc(dev, PAGE_SIZE, cmd_buf);
+	if (status < 0) {
+		dev_err(dev, "Couldn't allocate memory for cmd slots");
+		goto free_pdata;
+	}
+	/* ensure cmd buffer is null-initialized, which is visible in NPU as well */
+	memset(cmd_buf->addr, '\x00', PAGE_SIZE);
+
+	/* alloc backup buffer for preemption (GBUF + DSPM) */
+	status = trinity_dma_alloc(dev, TRIV2_DLA_GBUFFER_SIZE + drv->dspm, back_buf);
+	if (status < 0) {
+		dev_err(dev,
+			"Couldn't allocate memory for context backup buffer");
+		trinity_dma_free(dev, cmd_buf);
+		goto free_pdata;
+	}
+
+	triv2_setup_buffers(drv);
+
+	return 0;
+
+free_pdata:
+	kfree(drv->pdata);
+	drv->pdata = NULL;
+
+	return status;
+}
+
+static int32_t parse_idu_property(struct device *dev,
+				  const struct device_node *np,
+				  const char *prop_name, struct triv2_idu *idu)
+{
+	struct property *prop;
+	u64 values[TRIV2_IDU_MAX_SECTORS];
+	size_t size;
+	int i, err;
+
+	memset(idu, '\x00', sizeof(*idu));
+
+	prop = of_find_property(np, prop_name, NULL);
+	if (!prop)
+		return -EINVAL;
+
+	size = prop->length / sizeof(u64);
+	if (size != TRIV2_IDU_MAX_SECTORS) {
+		dev_err(dev, "idu requires %d values", TRIV2_IDU_MAX_SECTORS);
+		return -EINVAL;
+	}
+
+	idu->addr_num = size;
+	idu->addrs = devm_kcalloc(dev, size, sizeof(*idu->addrs), GFP_KERNEL);
+	if (!idu->addrs) {
+		dev_err(dev, "failed to allocate memory for idu values");
+		return -ENOMEM;
+	}
+
+	err = of_property_read_u64_array(np, prop_name, values, size);
+	if (err < 0) {
+		dev_err(dev, "failed to read property u64 array: %d", err);
+		return err;
+	}
+
+	for (i = 0; i < TRIV2_IDU_MAX_SECTORS; i++)
+		idu->addrs[i] = (unsigned long)values[i];
+
+	return 0;
+}
+
+/**
+ * triv2_setup_idu() - Setup IDU (e.g., CP, DSP) sections for this device
+ */
+static int triv2_setup_idu(struct trinity_driver *drv)
+{
+	struct triv2_pdata *pdata = TRIV2_DRV_GET_PDATA(drv);
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct device_node *np = dev->of_node;
+	int err;
+
+	/* get Instruction Decode Unit (IDU) property */
+	err = parse_idu_property(dev, np, "samsung,idu_cp", &pdata->idu_cp);
+	if (err < 0) {
+		dev_err(dev, "Failed to parse idu property: samsung,idu_cp");
+		return err;
+	}
+
+	err = parse_idu_property(dev, np, "samsung,idu_dsp", &pdata->idu_dsp);
+	if (err < 0) {
+		dev_err(dev, "DSP is not supported");
+		pdata->idu_dsp.addrs = NULL;
+	}
+
 	return 0;
 }
 
@@ -190,9 +618,24 @@ static int32_t triv2_init_pdata(struct trinity_driver *drv)
  */
 static void triv2_cleanup(struct trinity_driver *drv)
 {
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct trinity_dma *cmd_buf;
+	struct trinity_dma *back_buf;
+
 	if (!drv->pdata)
 		return;
 
+	triv2_idu_unset(drv);
+
+	cmd_buf = TRIV2_DRV_GET_CMD_BUF(drv);
+	back_buf = TRIV2_DRV_GET_BACK_BUF(drv);
+
+	if (cmd_buf->addr)
+		trinity_dma_free(dev, cmd_buf);
+
+	if (back_buf->addr)
+		trinity_dma_free(dev, back_buf);
+
 	kfree(drv->pdata);
 	drv->pdata = NULL;
 }
@@ -203,6 +646,11 @@ static struct trinity_desc triv2_desc = {
 	.fops = &triv2_fops,
 	/* device management */
 	.reset = triv2_reset,
+	.idu_set = triv2_idu_set,
+	.idu_unset = triv2_idu_unset,
+	.idu_version = triv2_idu_version,
+	.get_state = triv2_get_state,
+	.set_state = triv2_set_state,
 	/* req management */
 	.alloc_req = triv2_alloc_req,
 	.dealloc_req = triv2_dealloc_req,
@@ -229,10 +677,28 @@ static int trinity_triv2_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
+	drv = platform_get_drvdata(pdev);
+	if (drv->dspm > 0) {
+		/* DSPM's some region is reserved for DSP kernel operations */
+		if (drv->dspm < TRIV2_DSP_DSPM_OFFSET) {
+			dev_err(drv_to_dev_ptr(drv),
+				"Too small DSPM size.. wrong device tree?");
+			err = -EINVAL;
+			goto out_remove;
+		}
+		drv->dspm -= TRIV2_DSP_DSPM_OFFSET;
+	}
+
 	err = triv2_init_pdata(drv);
 	if (err < 0)
 		goto out_remove;
 
+	err = triv2_setup_idu(drv);
+	if (err < 0) {
+		triv2_cleanup(drv);
+		goto out_remove;
+	}
+
 	err = trinity_create_node(drv);
 	if (err < 0) {
 		triv2_cleanup(drv);
-- 
2.25.1

