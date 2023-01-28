Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BADA67F818
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjA1NdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjA1NdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:33:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AEF6387D;
        Sat, 28 Jan 2023 05:32:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4968660C04;
        Sat, 28 Jan 2023 13:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1F0C433EF;
        Sat, 28 Jan 2023 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674912754;
        bh=4ZNmTjvYL6nUJa5jienE9WwE8Jvsufk/WrNevkgrD0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovZAnX+QaD0JmZc9z/6cxgP1v4E268VwLrt/y+N05tTYl/DniyD4wqzwZYeQj/3GW
         99RRJI6MG+CfWbLXADCfhDSmNbRoZ4Fu405jfiuOKYTyCGX13b3kohnvuh8fJkFVFV
         WEztNn8kYmjD7kOFJ7D9RItBMZ57uG84roRvSOLs=
Date:   Sat, 28 Jan 2023 14:32:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
        broonie@kernel.org, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH v2 16/22] sound: usb: Introduce QC USB SND offloading
 support
Message-ID: <Y9Uj7/RIHsJvebzG@kroah.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-17-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126031424.14582-17-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 07:14:18PM -0800, Wesley Cheng wrote:
> Several Qualcomm SoCs have a dedicated audio DSP, which has the ability to
> support USB sound devices.  This vendor driver will implement the required
> handshaking with the DSP, in order to pass along required resources that
> will be utilized by the DSP's USB SW.  The communication channel used for
> this handshaking will be using the QMI protocol.  Required resources
> include:
> - Allocated secondary event ring address
> - EP transfer ring address
> - Interrupter number
> 
> The above information will allow for the audio DSP to execute USB transfers
> over the USB bus.  It will also be able to support devices that have an
> implicit feedback and sync endpoint as well.  Offloading these data
> transfers will allow the main/applications processor to enter lower CPU
> power modes, and sustain a longer duration in those modes.
> 
> Audio offloading is initiated with the following sequence:
> 1. Userspace configures to route audio playback to USB backend and starts
> playback on the platform soundcard.
> 2. The Q6DSP AFE will communicate to the audio DSP to start the USB AFE
> port.
> 3. This results in a QMI packet with a STREAM enable command.
> 4. The QC audio offload driver will fetch the required resources, and pass
> this information as part of the QMI response to the STREAM enable command.
> 5. Once the QMI response is received the audio DSP will start queuing data
> on the USB bus.

A real driver, finally!!!  Thank you for posting this.

That being said, some comments:

> --- /dev/null
> +++ b/sound/usb/qcom/qc_audio_offload.c
> @@ -0,0 +1,1775 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.

It's 2023 :)

> + */
> +
> +#include <linux/ctype.h>
> +#include <linux/moduleparam.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +#include <linux/init.h>
> +#include <linux/usb/hcd.h>
> +#include <linux/usb/xhci-intr.h>
> +#include <linux/usb/quirks.h>
> +#include <linux/usb/audio.h>
> +#include <linux/usb/audio-v2.h>
> +#include <linux/usb/audio-v3.h>
> +#include <linux/soc/qcom/qmi.h>
> +#include <linux/iommu.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-map-ops.h>
> +#include <sound/q6usboffload.h>
> +
> +#include <sound/control.h>
> +#include <sound/core.h>
> +#include <sound/info.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/initval.h>
> +
> +#include <sound/soc.h>
> +#include <sound/soc-usb.h>
> +#include "../usbaudio.h"
> +#include "../card.h"
> +#include "../midi.h"
> +#include "../mixer.h"
> +#include "../proc.h"
> +#include "../quirks.h"
> +#include "../endpoint.h"
> +#include "../helper.h"
> +#include "../pcm.h"
> +#include "../format.h"
> +#include "../power.h"
> +#include "../stream.h"
> +#include "../media.h"
> +#include "usb_audio_qmi_v01.h"
> +
> +/* Stream disable request timeout during USB device disconnect */
> +#define DEV_RELEASE_WAIT_TIMEOUT 10000 /* in ms */
> +
> +/* Data interval calculation parameters */
> +#define BUS_INTERVAL_FULL_SPEED 1000 /* in us */
> +#define BUS_INTERVAL_HIGHSPEED_AND_ABOVE 125 /* in us */
> +#define MAX_BINTERVAL_ISOC_EP 16
> +
> +#define SND_PCM_CARD_NUM_MASK 0xffff0000
> +#define SND_PCM_DEV_NUM_MASK 0xff00
> +#define SND_PCM_STREAM_DIRECTION 0xff
> +
> +/* iommu resource parameters and management */
> +#define PREPEND_SID_TO_IOVA(iova, sid) ((u64)(((u64)(iova)) | \
> +					(((u64)sid) << 32)))
> +#define IOVA_BASE 0x1000
> +#define IOVA_XFER_RING_BASE (IOVA_BASE + PAGE_SIZE * (SNDRV_CARDS + 1))
> +#define IOVA_XFER_BUF_BASE (IOVA_XFER_RING_BASE + PAGE_SIZE * SNDRV_CARDS * 32)
> +#define IOVA_XFER_RING_MAX (IOVA_XFER_BUF_BASE - PAGE_SIZE)
> +#define IOVA_XFER_BUF_MAX (0xfffff000 - PAGE_SIZE)
> +
> +#define MAX_XFER_BUFF_LEN (24 * PAGE_SIZE)
> +
> +struct iova_info {
> +	struct list_head list;
> +	unsigned long start_iova;
> +	size_t size;
> +	bool in_use;
> +};
> +
> +struct intf_info {
> +	unsigned long data_xfer_ring_va;
> +	size_t data_xfer_ring_size;
> +	unsigned long sync_xfer_ring_va;
> +	size_t sync_xfer_ring_size;
> +	unsigned long xfer_buf_va;
> +	size_t xfer_buf_size;
> +	phys_addr_t xfer_buf_pa;
> +	unsigned int data_ep_pipe;
> +	unsigned int sync_ep_pipe;
> +	u8 *xfer_buf;
> +	u8 intf_num;
> +	u8 pcm_card_num;
> +	u8 pcm_dev_num;
> +	u8 direction;
> +	bool in_use;
> +};
> +
> +struct uaudio_qmi_dev {
> +	struct device *dev;
> +	u32 sid;
> +	u32 intr_num;
> +	struct xhci_interrupter *ir;
> +	struct xhci_ring *sec_ring;
> +	struct iommu_domain *domain;
> +
> +	/* list to keep track of available iova */
> +	struct list_head xfer_ring_list;
> +	size_t xfer_ring_iova_size;
> +	unsigned long curr_xfer_ring_iova;
> +	struct list_head xfer_buf_list;
> +	size_t xfer_buf_iova_size;
> +	unsigned long curr_xfer_buf_iova;
> +
> +	/* bit fields representing pcm card enabled */
> +	unsigned long card_slot;
> +	/* indicate event ring mapped or not */
> +	bool er_mapped;
> +	/* reference count to number of possible consumers */
> +	atomic_t qdev_in_use;
> +	/* idx to last udev card number plugged in */
> +	unsigned int last_card_num;
> +};
> +
> +struct uaudio_dev {
> +	struct usb_device *udev;
> +	/* audio control interface */
> +	struct usb_host_interface *ctrl_intf;
> +	unsigned int card_num;
> +	unsigned int usb_core_id;
> +	atomic_t in_use;

Why is this atomic?  What happens if it changes right after you read it?

> +	struct kref kref;

Why is this structure not a "real" device?  Why are you faking it out?
It should be in the device tree as you have a reference count and a
lifespan, don't make it harder by trying to roll your own logic here.


> +	wait_queue_head_t disconnect_wq;
> +
> +	/* interface specific */
> +	int num_intf;
> +	struct intf_info *info;
> +	struct snd_usb_audio *chip;
> +};
> +
> +static struct uaudio_dev uadev[SNDRV_CARDS];
> +static struct uaudio_qmi_dev *uaudio_qdev;
> +static struct uaudio_qmi_svc *uaudio_svc;

Why are these all limited?  These should all be dynamic and tied to the
device that the driver is bound to.  No static limits here please.

> +static DEFINE_MUTEX(qdev_mutex);

What does this lock?


> +
> +struct uaudio_qmi_svc {
> +	struct qmi_handle *uaudio_svc_hdl;
> +	struct work_struct qmi_disconnect_work;
> +	struct workqueue_struct *uaudio_wq;
> +	struct sockaddr_qrtr client_sq;
> +	bool client_connected;
> +};
> +
> +enum mem_type {
> +	MEM_EVENT_RING,
> +	MEM_XFER_RING,
> +	MEM_XFER_BUF,
> +};
> +
> +/* Supported audio formats */
> +enum usb_qmi_audio_format {
> +	USB_QMI_PCM_FORMAT_S8 = 0,
> +	USB_QMI_PCM_FORMAT_U8,
> +	USB_QMI_PCM_FORMAT_S16_LE,
> +	USB_QMI_PCM_FORMAT_S16_BE,
> +	USB_QMI_PCM_FORMAT_U16_LE,
> +	USB_QMI_PCM_FORMAT_U16_BE,
> +	USB_QMI_PCM_FORMAT_S24_LE,
> +	USB_QMI_PCM_FORMAT_S24_BE,
> +	USB_QMI_PCM_FORMAT_U24_LE,
> +	USB_QMI_PCM_FORMAT_U24_BE,
> +	USB_QMI_PCM_FORMAT_S24_3LE,
> +	USB_QMI_PCM_FORMAT_S24_3BE,
> +	USB_QMI_PCM_FORMAT_U24_3LE,
> +	USB_QMI_PCM_FORMAT_U24_3BE,
> +	USB_QMI_PCM_FORMAT_S32_LE,
> +	USB_QMI_PCM_FORMAT_S32_BE,
> +	USB_QMI_PCM_FORMAT_U32_LE,
> +	USB_QMI_PCM_FORMAT_U32_BE,
> +};
> +
> +static void uaudio_iommu_unmap(enum mem_type mtype, unsigned long va,
> +	size_t iova_size, size_t mapped_iova_size);
> +static void uaudio_dev_cleanup(struct uaudio_dev *dev);
> +static void disable_audio_stream(struct snd_usb_substream *subs);
> +static struct snd_usb_substream *find_substream(unsigned int card_num,
> +	unsigned int pcm_idx, unsigned int direction);

Why not reorder the code to not need predeclarations?


> +
> +/* QMI service disconnect handlers */
> +static void qmi_disconnect_work(struct work_struct *w)
> +{
> +	struct intf_info *info;
> +	int idx, if_idx;
> +	struct snd_usb_substream *subs;
> +	struct snd_usb_audio *chip;
> +
> +	/* find all active intf for set alt 0 and cleanup usb audio dev */
> +	for (idx = 0; idx < SNDRV_CARDS; idx++) {
> +		if (!atomic_read(&uadev[idx].in_use))
> +			continue;
> +
> +		chip = uadev[idx].chip;
> +		for (if_idx = 0; if_idx < uadev[idx].num_intf; if_idx++) {
> +			if (!uadev[idx].info || !uadev[idx].info[if_idx].in_use)
> +				continue;
> +			info = &uadev[idx].info[if_idx];
> +			subs = find_substream(info->pcm_card_num,
> +						info->pcm_dev_num,
> +						info->direction);
> +			if (!subs || !chip || atomic_read(&chip->shutdown)) {
> +				dev_err(&subs->dev->dev,
> +					"no sub for c#%u dev#%u dir%u\n",
> +					info->pcm_card_num,
> +					info->pcm_dev_num,
> +					info->direction);
> +				continue;
> +			}
> +			disable_audio_stream(subs);
> +		}
> +		atomic_set(&uadev[idx].in_use, 0);
> +		mutex_lock(&chip->mutex);
> +		uaudio_dev_cleanup(&uadev[idx]);
> +		mutex_unlock(&chip->mutex);
> +	}
> +}
> +
> +/**
> + * qmi_bye_cb() - qmi bye message callback
> + * @handle: QMI handle
> + * @node: id of the dying node
> + *
> + * This callback is invoked when the QMI bye control message is received
> + * from the QMI client.  Handle the message accordingly by ensuring that
> + * the USB offload path is disabled and cleaned up.  At this point, ADSP
> + * is not utilizing the USB bus.
> + *
> + */
> +static void qmi_bye_cb(struct qmi_handle *handle, unsigned int node)
> +{
> +	struct uaudio_qmi_svc *svc = uaudio_svc;
> +
> +	if (svc->uaudio_svc_hdl != handle)
> +		return;
> +
> +	if (svc->client_connected && svc->client_sq.sq_node == node) {
> +		queue_work(svc->uaudio_wq, &svc->qmi_disconnect_work);
> +		svc->client_sq.sq_node = 0;
> +		svc->client_sq.sq_port = 0;
> +		svc->client_sq.sq_family = 0;
> +		svc->client_connected = false;
> +	}
> +}
> +
> +/**
> + * qmi_svc_disconnect_cb() - qmi client disconnected
> + * @handle: QMI handle
> + * @node: id of the dying node
> + * @port: port of the dying client
> + *
> + * Invoked when the remote QMI client is disconnected.  Handle this event
> + * the same way as when the QMI bye message is received.  This will ensure
> + * the USB offloading path is disabled and cleaned up.
> + *
> + */
> +static void qmi_svc_disconnect_cb(struct qmi_handle *handle,
> +				  unsigned int node, unsigned int port)
> +{
> +	struct uaudio_qmi_svc *svc;
> +
> +	if (uaudio_svc == NULL)
> +		return;
> +
> +	svc = uaudio_svc;
> +	if (svc->uaudio_svc_hdl != handle)
> +		return;
> +
> +	if (svc->client_connected && svc->client_sq.sq_node == node &&
> +			svc->client_sq.sq_port == port) {
> +		queue_work(svc->uaudio_wq, &svc->qmi_disconnect_work);
> +		svc->client_sq.sq_node = 0;
> +		svc->client_sq.sq_port = 0;
> +		svc->client_sq.sq_family = 0;
> +		svc->client_connected = false;
> +	}
> +}
> +
> +/* QMI client callback handlers from QMI interface */
> +static struct qmi_ops uaudio_svc_ops_options = {
> +	.bye = qmi_bye_cb,
> +	.del_client = qmi_svc_disconnect_cb,
> +};
> +
> +static enum usb_audio_device_speed_enum_v01
> +get_speed_info(enum usb_device_speed udev_speed)
> +{
> +	switch (udev_speed) {
> +	case USB_SPEED_LOW:
> +		return USB_AUDIO_DEVICE_SPEED_LOW_V01;
> +	case USB_SPEED_FULL:
> +		return USB_AUDIO_DEVICE_SPEED_FULL_V01;
> +	case USB_SPEED_HIGH:
> +		return USB_AUDIO_DEVICE_SPEED_HIGH_V01;
> +	case USB_SPEED_SUPER:
> +		return USB_AUDIO_DEVICE_SPEED_SUPER_V01;
> +	case USB_SPEED_SUPER_PLUS:
> +		return USB_AUDIO_DEVICE_SPEED_SUPER_PLUS_V01;
> +	default:
> +		return USB_AUDIO_DEVICE_SPEED_INVALID_V01;
> +	}
> +}
> +
> +/* Offloading IOMMU management */
> +static unsigned long uaudio_get_iova(unsigned long *curr_iova,
> +	size_t *curr_iova_size, struct list_head *head, size_t size)
> +{
> +	struct iova_info *info, *new_info = NULL;
> +	struct list_head *curr_head;
> +	unsigned long va = 0;
> +	size_t tmp_size = size;
> +	bool found = false;
> +
> +	if (size % PAGE_SIZE) {
> +		dev_err(uaudio_qdev->dev, "size %zu is not page size multiple\n",
> +			size);
> +		goto done;
> +	}
> +
> +	if (size > *curr_iova_size) {
> +		dev_err(uaudio_qdev->dev, "size %zu > curr size %zu\n",
> +			size, *curr_iova_size);
> +		goto done;
> +	}
> +	if (*curr_iova_size == 0) {
> +		dev_err(uaudio_qdev->dev, "iova mapping is full\n");
> +		goto done;
> +	}
> +
> +	list_for_each_entry(info, head, list) {
> +		/* exact size iova_info */
> +		if (!info->in_use && info->size == size) {
> +			info->in_use = true;
> +			va = info->start_iova;
> +			*curr_iova_size -= size;
> +			found = true;
> +			dev_dbg(uaudio_qdev->dev, "exact size: %zu found\n", size);
> +			goto done;
> +		} else if (!info->in_use && tmp_size >= info->size) {
> +			if (!new_info)
> +				new_info = info;
> +			dev_dbg(uaudio_qdev->dev, "partial size: %zu found\n",
> +					info->size);
> +			tmp_size -= info->size;
> +			if (tmp_size)
> +				continue;
> +
> +			va = new_info->start_iova;
> +			for (curr_head = &new_info->list; curr_head !=
> +			&info->list; curr_head = curr_head->next) {
> +				new_info = list_entry(curr_head, struct
> +						iova_info, list);
> +				new_info->in_use = true;
> +			}
> +			info->in_use = true;
> +			*curr_iova_size -= size;
> +			found = true;
> +			goto done;
> +		} else {
> +			/* iova region in use */
> +			new_info = NULL;
> +			tmp_size = size;
> +		}
> +	}
> +
> +	info = kzalloc(sizeof(struct iova_info), GFP_KERNEL);
> +	if (!info) {
> +		va = 0;
> +		goto done;
> +	}
> +
> +	va = info->start_iova = *curr_iova;
> +	info->size = size;
> +	info->in_use = true;
> +	*curr_iova += size;
> +	*curr_iova_size -= size;
> +	found = true;
> +	list_add_tail(&info->list, head);
> +
> +done:
> +	if (!found)
> +		dev_err(uaudio_qdev->dev, "unable to find %zu size iova\n",
> +			size);
> +	else
> +		dev_dbg(uaudio_qdev->dev,
> +			"va:0x%08lx curr_iova:0x%08lx curr_iova_size:%zu\n",
> +			va, *curr_iova, *curr_iova_size);
> +
> +	return va;
> +}
> +
> +/**
> + * uaudio_iommu_map() - maps iommu memory for adsp
> + * @mtype: ring type
> + * @dma_coherent: dma coherent
> + * @pa: physical address for ring/buffer
> + * @size: size of memory region
> + * @sgt: sg table for memory region
> + *
> + * Maps the XHCI related resources to a memory region that is assigned to be
> + * used by the adsp.  This will be mapped to the domain, which is created by
> + * the ASoC USB backend driver.
> + *
> + */
> +static unsigned long uaudio_iommu_map(enum mem_type mtype, bool dma_coherent,
> +		phys_addr_t pa, size_t size, struct sg_table *sgt)
> +{
> +	unsigned long va_sg, va = 0;
> +	bool map = true;
> +	int i, ret;
> +	size_t sg_len, total_len = 0;
> +	struct scatterlist *sg;
> +	phys_addr_t pa_sg;
> +	int prot = IOMMU_READ | IOMMU_WRITE;
> +
> +	if (dma_coherent)
> +		prot |= IOMMU_CACHE;
> +
> +	switch (mtype) {
> +	case MEM_EVENT_RING:
> +		va = IOVA_BASE;
> +		/* er already mapped */
> +		if (uaudio_qdev->er_mapped)
> +			map = false;
> +		break;
> +	case MEM_XFER_RING:
> +		va = uaudio_get_iova(&uaudio_qdev->curr_xfer_ring_iova,
> +		&uaudio_qdev->xfer_ring_iova_size, &uaudio_qdev->xfer_ring_list,
> +		size);
> +		break;
> +	case MEM_XFER_BUF:
> +		va = uaudio_get_iova(&uaudio_qdev->curr_xfer_buf_iova,
> +		&uaudio_qdev->xfer_buf_iova_size, &uaudio_qdev->xfer_buf_list,
> +		size);
> +		break;
> +	default:
> +		dev_err(uaudio_qdev->dev, "unknown mem type %d\n", mtype);
> +	}
> +
> +	if (!va || !map)
> +		goto done;
> +
> +	if (!sgt)
> +		goto skip_sgt_map;
> +
> +	va_sg = va;
> +	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +		sg_len = PAGE_ALIGN(sg->offset + sg->length);
> +		pa_sg = page_to_phys(sg_page(sg));
> +		ret = iommu_map(uaudio_qdev->domain, va_sg, pa_sg, sg_len,
> +								prot);
> +		if (ret) {
> +			dev_err(uaudio_qdev->dev, "mapping failed ret%d\n", ret);
> +			dev_err(uaudio_qdev->dev,
> +				"type:%d, pa:%pa iova:0x%08lx sg_len:%zu\n",
> +				mtype, &pa_sg, va_sg, sg_len);
> +			uaudio_iommu_unmap(MEM_XFER_BUF, va, size, total_len);
> +			va = 0;
> +			goto done;
> +		}
> +		dev_dbg(uaudio_qdev->dev,
> +			"type:%d map pa:%pa to iova:0x%08lx len:%zu offset:%u\n",
> +			mtype, &pa_sg, va_sg, sg_len, sg->offset);
> +		va_sg += sg_len;
> +		total_len += sg_len;
> +	}
> +
> +	if (size != total_len) {
> +		dev_err(uaudio_qdev->dev, "iova size %zu != mapped iova size %zu\n",
> +			size, total_len);
> +		uaudio_iommu_unmap(MEM_XFER_BUF, va, size, total_len);
> +		va = 0;
> +	}
> +	return va;
> +
> +skip_sgt_map:
> +	dev_dbg(uaudio_qdev->dev, "type:%d map pa:%pa to iova:0x%08lx size:%zu\n",
> +		mtype, &pa, va, size);
> +
> +	ret = iommu_map(uaudio_qdev->domain, va, pa, size, prot);
> +	if (ret)
> +		dev_err(uaudio_qdev->dev,
> +			"failed to map pa:%pa iova:0x%lx type:%d ret:%d\n",
> +			&pa, va, mtype, ret);
> +done:
> +	return va;
> +}
> +
> +static void uaudio_put_iova(unsigned long va, size_t size, struct list_head
> +	*head, size_t *curr_iova_size)
> +{
> +	struct iova_info *info;
> +	size_t tmp_size = size;
> +	bool found = false;
> +
> +	list_for_each_entry(info, head, list) {
> +		if (info->start_iova == va) {
> +			if (!info->in_use) {
> +				dev_err(uaudio_qdev->dev, "va %lu is not in use\n",
> +					va);
> +				return;
> +			}
> +			found = true;
> +			info->in_use = false;
> +			if (info->size == size)
> +				goto done;
> +		}
> +
> +		if (found && tmp_size >= info->size) {
> +			info->in_use = false;
> +			tmp_size -= info->size;
> +			if (!tmp_size)
> +				goto done;
> +		}
> +	}
> +
> +	if (!found) {
> +		dev_err(uaudio_qdev->dev, "unable to find the va %lu\n", va);
> +		return;
> +	}
> +done:
> +	*curr_iova_size += size;
> +	dev_dbg(uaudio_qdev->dev, "curr_iova_size %zu\n", *curr_iova_size);
> +}
> +
> +/**
> + * uaudio_iommu_unmap() - unmaps iommu memory for adsp
> + * @mtype: ring type
> + * @va: virtual address to unmap
> + * @iova_size: region size
> + * @mapped_iova_size: mapped region size
> + *
> + * Unmaps the memory region that was previously assigned to the adsp.
> + *
> + */
> +static void uaudio_iommu_unmap(enum mem_type mtype, unsigned long va,
> +	size_t iova_size, size_t mapped_iova_size)
> +{
> +	size_t umap_size;
> +	bool unmap = true;
> +
> +	if (!va || !iova_size)
> +		return;
> +
> +	switch (mtype) {
> +	case MEM_EVENT_RING:
> +		if (uaudio_qdev->er_mapped)
> +			uaudio_qdev->er_mapped = false;
> +		else
> +			unmap = false;
> +		break;
> +
> +	case MEM_XFER_RING:
> +		uaudio_put_iova(va, iova_size, &uaudio_qdev->xfer_ring_list,
> +		&uaudio_qdev->xfer_ring_iova_size);
> +		break;
> +	case MEM_XFER_BUF:
> +		uaudio_put_iova(va, iova_size, &uaudio_qdev->xfer_buf_list,
> +		&uaudio_qdev->xfer_buf_iova_size);
> +		break;
> +	default:
> +		dev_err(uaudio_qdev->dev, "unknown mem type %d\n", mtype);
> +		unmap = false;
> +	}
> +
> +	if (!unmap || !mapped_iova_size)
> +		return;
> +
> +	dev_dbg(uaudio_qdev->dev, "type %d: unmap iova 0x%08lx size %zu\n",
> +		mtype, va, mapped_iova_size);
> +
> +	umap_size = iommu_unmap(uaudio_qdev->domain, va, mapped_iova_size);
> +	if (umap_size != mapped_iova_size)
> +		dev_err(uaudio_qdev->dev,
> +			"unmapped size %zu for iova 0x%08lx of mapped size %zu\n",
> +			umap_size, va, mapped_iova_size);
> +}
> +
> +/* looks up alias, if any, for controller DT node and returns the index */
> +static int usb_get_controller_id(struct usb_device *udev)
> +{
> +	if (udev->bus->sysdev && udev->bus->sysdev->of_node)
> +		return of_alias_get_id(udev->bus->sysdev->of_node, "usb");
> +
> +	return -ENODEV;
> +}
> +
> +/**
> + * uaudio_dev_intf_cleanup() - cleanup transfer resources
> + * @udev: usb device
> + * @info: usb offloading interface
> + *
> + * Cleans up the transfer ring related resources which are assigned per
> + * endpoint from XHCI.  This is invoked when the USB endpoints are no
> + * longer in use by the adsp.
> + *
> + */
> +static void uaudio_dev_intf_cleanup(struct usb_device *udev,
> +	struct intf_info *info)
> +{
> +	uaudio_iommu_unmap(MEM_XFER_RING, info->data_xfer_ring_va,
> +		info->data_xfer_ring_size, info->data_xfer_ring_size);
> +	info->data_xfer_ring_va = 0;
> +	info->data_xfer_ring_size = 0;
> +
> +	uaudio_iommu_unmap(MEM_XFER_RING, info->sync_xfer_ring_va,
> +		info->sync_xfer_ring_size, info->sync_xfer_ring_size);
> +	info->sync_xfer_ring_va = 0;
> +	info->sync_xfer_ring_size = 0;
> +
> +	uaudio_iommu_unmap(MEM_XFER_BUF, info->xfer_buf_va,
> +		info->xfer_buf_size, info->xfer_buf_size);
> +	info->xfer_buf_va = 0;
> +
> +	usb_free_coherent(udev, info->xfer_buf_size,
> +		info->xfer_buf, info->xfer_buf_pa);
> +	info->xfer_buf_size = 0;
> +	info->xfer_buf = NULL;
> +	info->xfer_buf_pa = 0;
> +
> +	info->in_use = false;
> +}
> +
> +/**
> + * uaudio_event_ring_cleanup_free() - cleanup secondary event ring
> + * @dev: usb offload device
> + *
> + * Cleans up the secondary event ring that was requested.  This will
> + * occur when the adsp is no longer transferring data on the USB bus
> + * across all endpoints.
> + *
> + */
> +static void uaudio_event_ring_cleanup_free(struct uaudio_dev *dev)
> +{
> +	struct usb_hcd *hcd = bus_to_hcd(dev->udev->bus);
> +
> +	clear_bit(dev->card_num, &uaudio_qdev->card_slot);
> +	/* all audio devices are disconnected */
> +	if (!uaudio_qdev->card_slot) {
> +		uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE,
> +			PAGE_SIZE);
> +		xhci_remove_secondary_interrupter(hcd, uaudio_qdev->ir);
> +		uaudio_qdev->ir = NULL;
> +	}
> +}
> +
> +/* kref release callback when all streams are disabled */
> +static void uaudio_dev_release(struct kref *kref)
> +{
> +	struct uaudio_dev *dev = container_of(kref, struct uaudio_dev, kref);
> +
> +	uaudio_event_ring_cleanup_free(dev);
> +	atomic_set(&dev->in_use, 0);
> +	wake_up(&dev->disconnect_wq);
> +}
> +
> +static struct snd_usb_substream *find_substream(unsigned int card_num,
> +	unsigned int pcm_idx, unsigned int direction)
> +{
> +	struct snd_usb_stream *as;
> +	struct snd_usb_substream *subs = NULL;
> +	struct snd_usb_audio *chip;
> +
> +	chip = uadev[card_num].chip;
> +	if (!chip || atomic_read(&chip->shutdown))
> +		goto done;

What happens if this atomic value changes right after you read it?

See, don't use them, use a proper lock correctly, it's much simpler and
will actually work.

thanks,

greg k-h
