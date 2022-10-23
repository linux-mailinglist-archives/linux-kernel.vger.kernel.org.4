Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3F5609200
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJWJ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJWJ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:29:09 -0400
Received: from smtp.smtpout.orange.fr (smtp-12.smtpout.orange.fr [80.12.242.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B74969F61
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 02:29:04 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id mXHuoJQyQvbzbmXHuoordZ; Sun, 23 Oct 2022 11:29:02 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 23 Oct 2022 11:29:02 +0200
X-ME-IP: 86.243.100.34
Message-ID: <6a2e5dec-ab54-a156-98f0-a8bff6a24700@wanadoo.fr>
Date:   Sun, 23 Oct 2022 11:28:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v10 3/7] media: chips-media: wave5: Add the vdi layer
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
Cc:     kernel@collabora.com, nas.chung@chipsnmedia.com,
        hverkuil@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        linux-kernel@vger.kernel.org, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, dafna@fastmail.com
References: <20221022000506.221933-1-sebastian.fricke@collabora.com>
 <20221022000506.221933-4-sebastian.fricke@collabora.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221022000506.221933-4-sebastian.fricke@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/10/2022 à 02:05, Sebastian Fricke a écrit :
> From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> 
> Add the vdi part of the wave5 codec driver. The wave5-vdi.h header
> defines common helper functions such as writing/reading register and
> handling endianness.
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Hi, a few nit below.

CJ

> ---
>   .../platform/chips-media/wave5/wave5-vdi.c    | 261 ++++++++++++++++++
>   .../platform/chips-media/wave5/wave5-vdi.h    |  67 +++++
>   .../platform/chips-media/wave5/wave5-vpuapi.h |   2 +-
>   3 files changed, 329 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vdi.c
>   create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vdi.h
> 
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> new file mode 100644
> index 000000000000..f85580dba294
> --- /dev/null
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * Wave5 series multi-standard codec IP - low level access functions
> + *
> + * Copyright (C) 2021 CHIPS&MEDIA INC
> + */
> +
> +#include <linux/bug.h>
> +#include "wave5-vdi.h"
> +#include "wave5-vpu.h"
> +#include "wave5-regdefine.h"
> +#include <linux/delay.h>
> +
> +#define VDI_SRAM_BASE_ADDR		0x00
> +
> +#define VDI_SYSTEM_ENDIAN		VDI_LITTLE_ENDIAN
> +#define VDI_128BIT_BUS_SYSTEM_ENDIAN	VDI_128BIT_LITTLE_ENDIAN
> +
> +static int wave5_vdi_allocate_common_memory(struct device *dev)
> +{
> +	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
> +
> +	if (!vpu_dev->common_mem.vaddr) {
> +		int ret;
> +
> +		vpu_dev->common_mem.size = SIZE_COMMON;
> +		ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vpu_dev->common_mem);
> +		if (ret) {
> +			dev_err(dev, "unable to allocate common buffer\n");
> +			return ret;
> +		}
> +	}
> +
> +	dev_dbg(dev, "[VDI] common_mem: daddr=%pad size=%zu vaddr=0x%p\n",
> +		&vpu_dev->common_mem.daddr, vpu_dev->common_mem.size, vpu_dev->common_mem.vaddr);
> +
> +	return 0;
> +}
> +
> +int wave5_vdi_init(struct device *dev)
> +{
> +	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = wave5_vdi_allocate_common_memory(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "[VDI] failed to get vpu common buffer from driver\n");
> +		return ret;
> +	}
> +
> +	if (!PRODUCT_CODE_W_SERIES(vpu_dev->product_code)) {
> +		WARN_ONCE(1, "unsupported product code: 0x%x\n", vpu_dev->product_code);
> +		return 0;
> +	}
> +
> +	// if BIT processor is not running.
> +	if (wave5_vdi_readl(vpu_dev, W5_VCPU_CUR_PC) == 0) {
> +		int i;
> +
> +		for (i = 0; i < 64; i++)
> +			wave5_vdi_write_register(vpu_dev, (i * 4) + 0x100, 0x0);
> +	}
> +
> +	dev_dbg(dev, "[VDI] driver initialized successfully\n");
> +
> +	return 0;
> +}
> +
> +int wave5_vdi_release(struct device *dev)
> +{
> +	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
> +
> +	vpu_dev->vdb_register = NULL;
> +	wave5_vdi_free_dma_memory(vpu_dev, &vpu_dev->common_mem);
> +
> +	return 0;
> +}
> +
> +void wave5_vdi_write_register(struct vpu_device *vpu_dev, u32 addr, u32 data)
> +{
> +	writel(data, vpu_dev->vdb_register + addr);
> +}
> +
> +unsigned int wave5_vdi_readl(struct vpu_device *vpu_dev, u32 addr)
> +{
> +	return readl(vpu_dev->vdb_register + addr);
> +}
> +
> +int wave5_vdi_clear_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb)
> +{
> +	if (!vb || !vb->vaddr) {
> +		dev_err(vpu_dev->dev, "%s: unable to clear unmapped buffer\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	memset(vb->vaddr, 0, vb->size);
> +	return vb->size;
> +}
> +
> +static void wave5_swap_endian(struct vpu_device *vpu_dev, u8 *data, size_t len,
> +			      unsigned int endian);
> +
> +int wave5_vdi_write_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb, size_t offset,
> +			   u8 *data, size_t len, unsigned int endian)
> +{
> +	if (!vb || !vb->vaddr) {
> +		dev_err(vpu_dev->dev, "%s: unable to write to unmapped buffer\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (offset > vb->size || len > vb->size || offset + len > vb->size) {
> +		dev_err(vpu_dev->dev, "%s: buffer too small\n", __func__);
> +		return -ENOSPC;
> +	}
> +
> +	wave5_swap_endian(vpu_dev, data, len, endian);
> +	memcpy(vb->vaddr + offset, data, len);
> +
> +	return len;
> +}
> +
> +int wave5_vdi_allocate_dma_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb)
> +{
> +	void *vaddr;
> +	dma_addr_t daddr;
> +
> +	if (!vb->size) {
> +		dev_err(vpu_dev->dev, "%s: requested size==0\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	vaddr = dma_alloc_coherent(vpu_dev->dev, vb->size, &daddr, GFP_KERNEL);
> +	if (!vaddr)
> +		return -ENOMEM;
> +	vb->vaddr = vaddr;
> +	vb->daddr = daddr;
> +
> +	return 0;
> +}
> +
> +void wave5_vdi_free_dma_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb)
> +{
> +	if (vb->size == 0)
> +		return;
> +
> +	if (!vb->vaddr)
> +		dev_err(vpu_dev->dev, "%s: requested free of unmapped buffer\n", __func__);
> +	else
> +		dma_free_coherent(vpu_dev->dev, vb->size, vb->vaddr, vb->daddr);
> +
> +	memset(vb, 0, sizeof(*vb));
> +}
> +
> +unsigned int wave5_vdi_convert_endian(struct vpu_device *vpu_dev, unsigned int endian)
> +{
> +	if (PRODUCT_CODE_W_SERIES(vpu_dev->product_code)) {
> +		switch (endian) {
> +		case VDI_LITTLE_ENDIAN:
> +			endian = 0x00;
> +			break;
> +		case VDI_BIG_ENDIAN:
> +			endian = 0x0f;
> +			break;
> +		case VDI_32BIT_LITTLE_ENDIAN:
> +			endian = 0x04;
> +			break;
> +		case VDI_32BIT_BIG_ENDIAN:
> +			endian = 0x03;
> +			break;
> +		}
> +	}
> +
> +	return (endian & 0x0f);
> +}
> +
> +static void byte_swap(unsigned char *data, size_t len)
> +{
> +	u8 temp;
> +	unsigned int i;
> +
> +	for (i = 0; i < len; i += 2) {
> +		temp = data[i];
> +		data[i] = data[i + 1];
> +		data[i + 1] = temp;

swap(ptr[i], ptr[i + 1]);
?

> +	}
> +}
> +
> +static void word_swap(unsigned char *data, size_t len)
> +{
> +	u16 temp;
> +	u16 *ptr = (u16 *)data;
> +	unsigned int i;
> +	size_t size = len / sizeof(uint16_t);
> +
> +	for (i = 0; i < size; i += 2) {
> +		temp = ptr[i];
> +		ptr[i] = ptr[i + 1];
> +		ptr[i + 1] = temp;

swap(ptr[i], ptr[i + 1]);
?

> +	}
> +}
> +
> +static void dword_swap(unsigned char *data, size_t len)
> +{
> +	u32 temp;
> +	u32 *ptr = (u32 *)data;
> +	size_t size = len / sizeof(u32);
> +	unsigned int i;
> +
> +	for (i = 0; i < size; i += 2) {
> +		temp = ptr[i];
> +		ptr[i] = ptr[i + 1];
> +		ptr[i + 1] = temp;

swap(ptr[i], ptr[i + 1]);
?

> +	}
> +}
> +
> +static void lword_swap(unsigned char *data, size_t len)
> +{
> +	u64 temp;
> +	u64 *ptr = (u64 *)data;
> +	size_t size = len / sizeof(uint64_t);
> +	unsigned int i;
> +
> +	for (i = 0; i < size; i += 2) {
> +		temp = ptr[i];
> +		ptr[i] = ptr[i + 1];
> +		ptr[i + 1] = temp;

swap(ptr[i], ptr[i + 1]);
?

> +	}
> +}
> +
> +static void wave5_swap_endian(struct vpu_device *vpu_dev, u8 *data, size_t len,
> +			      unsigned int endian)
> +{
> +	int changes;
> +	unsigned int sys_endian = VDI_128BIT_BUS_SYSTEM_ENDIAN;
> +	bool byte_change, word_change, dword_change, lword_change;
> +
> +	if (!PRODUCT_CODE_W_SERIES(vpu_dev->product_code)) {
> +		dev_err(vpu_dev->dev, "unknown product id: %08x\n", vpu_dev->product_code);
> +		return;
> +	}
> +
> +	endian = wave5_vdi_convert_endian(vpu_dev, endian);
> +	sys_endian = wave5_vdi_convert_endian(vpu_dev, sys_endian);
> +	if (endian == sys_endian)
> +		return;
> +
> +	changes = endian ^ sys_endian;
> +	byte_change = changes & 0x01;
> +	word_change = ((changes & 0x02) == 0x02);
> +	dword_change = ((changes & 0x04) == 0x04);
> +	lword_change = ((changes & 0x08) == 0x08);
> +
> +	if (byte_change)
> +		byte_swap(data, len);
> +	if (word_change)
> +		word_swap(data, len);
> +	if (dword_change)
> +		dword_swap(data, len);
> +	if (lword_change)
> +		lword_swap(data, len);
> +}
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.h b/drivers/media/platform/chips-media/wave5/wave5-vdi.h
> new file mode 100644
> index 000000000000..8e1d09331d5c
> --- /dev/null
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/*
> + * Wave5 series multi-standard codec IP - low level access functions
> + *
> + * Copyright (C) 2021 CHIPS&MEDIA INC
> + */
> +
> +#ifndef _VDI_H_
> +#define _VDI_H_
> +
> +#include "wave5-vpuconfig.h"
> +#include <linux/string.h>
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +
> +/************************************************************************/
> +/* COMMON REGISTERS */
> +/************************************************************************/
> +#define VPU_PRODUCT_CODE_REGISTER 0x1044
> +
> +/* system register write */
> +#define vpu_write_reg(VPU_INST, ADDR, DATA) wave5_vdi_write_register(VPU_INST, ADDR, DATA)
> +// system register read

The style of comment is not the same as the line above.

> +#define vpu_read_reg(CORE, ADDR) wave5_vdi_readl(CORE, ADDR)
> +
> +struct vpu_buf {
> +	size_t size;
> +	dma_addr_t daddr;
> +	void *vaddr;
> +};
> +
> +struct dma_vpu_buf {
> +	size_t size;
> +	dma_addr_t daddr;
> +};
> +
> +enum endian_mode {
> +	VDI_LITTLE_ENDIAN = 0, /* 64bit LE */
> +	VDI_BIG_ENDIAN, /* 64bit BE */
> +	VDI_32BIT_LITTLE_ENDIAN,
> +	VDI_32BIT_BIG_ENDIAN,
> +	/* WAVE PRODUCTS */
> +	VDI_128BIT_LITTLE_ENDIAN = 16,
> +	VDI_128BIT_LE_BYTE_SWAP,
> +	VDI_128BIT_LE_WORD_SWAP,
> +	VDI_128BIT_LE_WORD_BYTE_SWAP,
> +	VDI_128BIT_LE_DWORD_SWAP,
> +	VDI_128BIT_LE_DWORD_BYTE_SWAP,
> +	VDI_128BIT_LE_DWORD_WORD_SWAP,
> +	VDI_128BIT_LE_DWORD_WORD_BYTE_SWAP,
> +	VDI_128BIT_BE_DWORD_WORD_BYTE_SWAP,
> +	VDI_128BIT_BE_DWORD_WORD_SWAP,
> +	VDI_128BIT_BE_DWORD_BYTE_SWAP,
> +	VDI_128BIT_BE_DWORD_SWAP,
> +	VDI_128BIT_BE_WORD_BYTE_SWAP,
> +	VDI_128BIT_BE_WORD_SWAP,
> +	VDI_128BIT_BE_BYTE_SWAP,
> +	VDI_128BIT_BIG_ENDIAN = 31,
> +	VDI_ENDIAN_MAX
> +};
> +
> +#define VDI_128BIT_ENDIAN_MASK 0xf
> +
> +int wave5_vdi_init(struct device *dev);
> +int wave5_vdi_release(struct device *dev);	//this function may be called only at system off.
> +
> +#endif //#ifndef _VDI_H_
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> index 8b36c7196526..ef930408d977 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> @@ -1159,7 +1159,7 @@ int wave5_vdi_clear_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb);
>   int wave5_vdi_allocate_dma_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb);
>   int wave5_vdi_write_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb, size_t offset,
>   			   u8 *data, size_t len, unsigned int endian);
> -int wave5_vdi_convert_endian(struct vpu_device *vpu_dev, unsigned int endian);
> +unsigned int wave5_vdi_convert_endian(struct vpu_device *vpu_dev, unsigned int endian);

wave5_vdi_convert_endian() seems to be already declared and used in 
patch 2, but not defined there.

>   void wave5_vdi_free_dma_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb);
>   
>   int wave5_vpu_init_with_bitcode(struct device *dev, u8 *bitcode, size_t size);

