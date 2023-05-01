Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B44A6F2D57
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjEADLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjEADKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:10:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633F32137;
        Sun, 30 Apr 2023 20:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6062F6170A;
        Mon,  1 May 2023 03:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8285C433EF;
        Mon,  1 May 2023 03:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910180;
        bh=dR9PklygolTqH8imwIcPA8LbTdW6fOKb0nJV97565/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVGtpDldsapqD3Z2l0ZE1qxsY+R7IPOhIMI/92iTK0jsIAJMiO4Z5y6BJhtdtgsPy
         P80d8e0OHHWs5DsdgcQSRkvj+Csf6E9DJzvBTen4m0jFxbt3F15lb30cnwaZLqu8y6
         KomOtHz2TqcL/rAIJPs1nWrrrlnHyNd1q9Oyza0Zb5rTRXHwoJXoY9Us2miaVlGKfu
         trpUYJQPchOtc3nn20pAsXPcPVAnY4939ebtw0gC3h+fKXRv13TxrTXGxgeqIkT+5W
         MyYpsUG6218bqFvwxvH7ctyuGjIwbwNbpx+pVctmXIDkLnV05s4Xe6zyv2tlSqnQYw
         QNKDh53u32eIg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sasha Levin <sashal@kernel.org>, andersson@kernel.org,
        shawnguo@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 08/33] remoteproc: imx_dsp_rproc: Add custom memory copy implementation for i.MX DSP Cores
Date:   Sun, 30 Apr 2023 23:02:02 -0400
Message-Id: <20230501030227.3254266-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030227.3254266-1-sashal@kernel.org>
References: <20230501030227.3254266-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

[ Upstream commit 408ec1ff0caa340c57eecf4cbd14ef0132036a50 ]

The IRAM is part of the HiFi DSP.
According to hardware specification only 32-bits write are allowed
otherwise we get a Kernel panic.

Therefore add a custom memory copy and memset functions to deal with
the above restriction.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Link: https://lore.kernel.org/r/20230221170356.27923-1-iuliana.prodan@oss.nxp.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/imx_dsp_rproc.c | 187 ++++++++++++++++++++++++++++-
 1 file changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 95da1cbefacf0..6255864442a2b 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -715,6 +715,191 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
 		dev_err(dev, "%s: failed (%d, err:%d)\n", __func__, vqid, err);
 }
 
+/*
+ * Custom memory copy implementation for i.MX DSP Cores
+ *
+ * The IRAM is part of the HiFi DSP.
+ * According to hw specs only 32-bits writes are allowed.
+ */
+static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
+{
+	const u8 *src_byte = src;
+	const u32 *source = src;
+	u32 affected_mask;
+	u32 *dst = dest;
+	int i, q, r;
+	u32 tmp;
+
+	/* destination must be 32bit aligned */
+	if (!IS_ALIGNED((uintptr_t)dest, 4))
+		return -EINVAL;
+
+	q = size / 4;
+	r = size % 4;
+
+	/* copy data in units of 32 bits at a time */
+	for (i = 0; i < q; i++)
+		writel(source[i], &dst[i]);
+
+	if (r) {
+		affected_mask = GENMASK(8 * r, 0);
+
+		/*
+		 * first read the 32bit data of dest, then change affected
+		 * bytes, and write back to dest.
+		 * For unaffected bytes, it should not be changed
+		 */
+		tmp = readl(dest + q * 4);
+		tmp &= ~affected_mask;
+
+		/* avoid reading after end of source */
+		for (i = 0; i < r; i++)
+			tmp |= (src_byte[q * 4 + i] << (8 * i));
+
+		writel(tmp, dest + q * 4);
+	}
+
+	return 0;
+}
+
+/*
+ * Custom memset implementation for i.MX DSP Cores
+ *
+ * The IRAM is part of the HiFi DSP.
+ * According to hw specs only 32-bits writes are allowed.
+ */
+static int imx_dsp_rproc_memset(void *addr, u8 value, size_t size)
+{
+	u32 tmp_val = value;
+	u32 *tmp_dst = addr;
+	u32 affected_mask;
+	int q, r;
+	u32 tmp;
+
+	/* destination must be 32bit aligned */
+	if (!IS_ALIGNED((uintptr_t)addr, 4))
+		return -EINVAL;
+
+	tmp_val |= tmp_val << 8;
+	tmp_val |= tmp_val << 16;
+
+	q = size / 4;
+	r = size % 4;
+
+	while (q--)
+		writel(tmp_val, tmp_dst++);
+
+	if (r) {
+		affected_mask = GENMASK(8 * r, 0);
+
+		/*
+		 * first read the 32bit data of addr, then change affected
+		 * bytes, and write back to addr.
+		 * For unaffected bytes, it should not be changed
+		 */
+		tmp = readl(tmp_dst);
+		tmp &= ~affected_mask;
+
+		tmp |= (tmp_val & affected_mask);
+		writel(tmp, tmp_dst);
+	}
+
+	return 0;
+}
+
+/*
+ * imx_dsp_rproc_elf_load_segments() - load firmware segments to memory
+ * @rproc: remote processor which will be booted using these fw segments
+ * @fw: the ELF firmware image
+ *
+ * This function loads the firmware segments to memory, where the remote
+ * processor expects them.
+ *
+ * Return: 0 on success and an appropriate error code otherwise
+ */
+static int imx_dsp_rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
+{
+	struct device *dev = &rproc->dev;
+	const void *ehdr, *phdr;
+	int i, ret = 0;
+	u16 phnum;
+	const u8 *elf_data = fw->data;
+	u8 class = fw_elf_get_class(fw);
+	u32 elf_phdr_get_size = elf_size_of_phdr(class);
+
+	ehdr = elf_data;
+	phnum = elf_hdr_get_e_phnum(class, ehdr);
+	phdr = elf_data + elf_hdr_get_e_phoff(class, ehdr);
+
+	/* go through the available ELF segments */
+	for (i = 0; i < phnum; i++, phdr += elf_phdr_get_size) {
+		u64 da = elf_phdr_get_p_paddr(class, phdr);
+		u64 memsz = elf_phdr_get_p_memsz(class, phdr);
+		u64 filesz = elf_phdr_get_p_filesz(class, phdr);
+		u64 offset = elf_phdr_get_p_offset(class, phdr);
+		u32 type = elf_phdr_get_p_type(class, phdr);
+		void *ptr;
+
+		if (type != PT_LOAD || !memsz)
+			continue;
+
+		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
+			type, da, memsz, filesz);
+
+		if (filesz > memsz) {
+			dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
+				filesz, memsz);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (offset + filesz > fw->size) {
+			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
+				offset + filesz, fw->size);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (!rproc_u64_fit_in_size_t(memsz)) {
+			dev_err(dev, "size (%llx) does not fit in size_t type\n",
+				memsz);
+			ret = -EOVERFLOW;
+			break;
+		}
+
+		/* grab the kernel address for this device address */
+		ptr = rproc_da_to_va(rproc, da, memsz, NULL);
+		if (!ptr) {
+			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
+				memsz);
+			ret = -EINVAL;
+			break;
+		}
+
+		/* put the segment where the remote processor expects it */
+		if (filesz) {
+			ret = imx_dsp_rproc_memcpy(ptr, elf_data + offset, filesz);
+			if (ret) {
+				dev_err(dev, "memory copy failed for da 0x%llx memsz 0x%llx\n",
+					da, memsz);
+				break;
+			}
+		}
+
+		/* zero out remaining memory for this segment */
+		if (memsz > filesz) {
+			ret = imx_dsp_rproc_memset(ptr + filesz, 0, memsz - filesz);
+			if (ret) {
+				dev_err(dev, "memset failed for da 0x%llx memsz 0x%llx\n",
+					da, memsz);
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
 static int imx_dsp_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 {
 	if (rproc_elf_load_rsc_table(rproc, fw))
@@ -729,7 +914,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
 	.start		= imx_dsp_rproc_start,
 	.stop		= imx_dsp_rproc_stop,
 	.kick		= imx_dsp_rproc_kick,
-	.load		= rproc_elf_load_segments,
+	.load		= imx_dsp_rproc_elf_load_segments,
 	.parse_fw	= imx_dsp_rproc_parse_fw,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
-- 
2.39.2

