Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4C56FF6C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbjEKQGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbjEKQGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:06:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97F159F3;
        Thu, 11 May 2023 09:06:31 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHGtm3GRfz67fjP;
        Fri, 12 May 2023 00:04:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 11 May
 2023 17:06:28 +0100
Date:   Thu, 11 May 2023 17:06:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 3/4] cxl: add a firmware update mechanism using the
 sysfs firmware loader
Message-ID: <20230511170627.00003a49@Huawei.com>
In-Reply-To: <20230421-vv-fw_update-v1-3-22468747d72f@intel.com>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
        <20230421-vv-fw_update-v1-3-22468747d72f@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 21:09:27 -0600
Vishal Verma <vishal.l.verma@intel.com> wrote:

> The sysfs based firmware loader mechanism was created to easily allow
> userspace to upload firmware images to FPGA cards. This also happens to
> be pretty suitable to create a user-initiated but kernel-controlled
> firmware update mechanism for CXL devices, using the CXL specified
> mailbox commands.
> 
> Since firmware update commands can be long-running, and can be processed
> in the background by the endpoint device, it is desirable to have the
> ability to chunk the firmware transfer down to smaller pieces, so that
> one operation does not monopolize the mailbox, locking out any other
> long running background commands entirely - e.g. security commands like
> 'sanitize' or poison scanning operations.
> 
> The firmware loader mechanism allows a natural way to perform this
> chunking, as after each mailbox command, that is restricted to the
> maximum mailbox payload size, the cxl memdev driver relinquishes control
> back to the fw_loader system and awaits the next chunk of data to
> transfer. This opens opportunities for other background commands to
> access the mailbox and send their own slices of background commands.
> 
> Add the necessary helpers and state tracking to be able to perform the
> 'Get FW Info', 'Transfer FW', and 'Activate FW' mailbox commands as
> described in the CXL spec. Wire these up to the firmware loader
> callbacks, and register with that system to create the memX/firmware/
> sysfs ABI.
> 
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Hi Vishal,

Various comments inline.

Thanks,

Jonathan

> ---
>  drivers/cxl/cxlmem.h                    |  79 ++++++++
>  drivers/cxl/core/mbox.c                 |   1 +
>  drivers/cxl/core/memdev.c               | 324 ++++++++++++++++++++++++++++++++
>  Documentation/ABI/testing/sysfs-bus-cxl |  11 ++
>  drivers/cxl/Kconfig                     |   1 +
>  5 files changed, 416 insertions(+)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8c3302fc7738..0ecee5b558f4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -48,6 +48,8 @@ struct cxl_memdev {
>  	struct work_struct detach_work;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_nvdimm *cxl_nvd;
> +	struct fw_upload *fwl;
> +	const char *fw_name;
>  	int id;
>  	int depth;
>  };
> @@ -220,6 +222,80 @@ struct cxl_event_state {
>  	struct mutex log_lock;
>  };
>  
> +/*
> + * Get Firmware Info

Odd though it is, Get FW Info
might be better to track with the spec abbreviation used
in the section title etc.
No idea why that got shortened.

> + * CXL rev 3.0 section 8.2.9.3.1; Table 8-56
> + */
> +struct cxl_mbox_get_fw_info {
> +	u8 num_slots;
> +	u8 slot_info;
> +	u8 activation_cap;
> +	u8 reserved[13];
> +	char slot_1_revision[0x10];
> +	char slot_2_revision[0x10];
> +	char slot_3_revision[0x10];
> +	char slot_4_revision[0x10];
> +} __packed;
> +
> +#define CXL_FW_INFO_CUR_SLOT_MASK	GENMASK(2, 0)
I'd like this associate by naming slot info field even if that's
a bit wordy.
	CXL_FW_INFO_SLOT_INFO_CUR_MASK perhaps?

> +#define CXL_FW_INFO_NEXT_SLOT_MASK	GENMASK(5, 3)
> +#define CXL_FW_INFO_NEXT_SLOT_SHIFT	3
> +#define CXL_FW_INFO_HAS_LIVE_ACTIVATE	BIT(0)
CXL_FW_INFO_ACTIVATION_CAP_HAS_LIVE_ACTIVATE

Wordy but makes it clear which field of the message this goes in.

> +
> +/*
> + * Transfer Firmware Input Payload

As above, Transfer FW Input Payload
for spec alignment?

> + * CXL rev 3.0 section 8.2.9.3.2; Table 8-57
> + */
> +struct cxl_mbox_transfer_fw {
> +	u8 action;
> +	u8 slot;
> +	u8 reserved[2];
> +	__le32 offset;
> +	u8 reserved2[0x78];
> +	u8 data[];
> +} __packed;
> +
> +#define CXL_FW_TRANSFER_ACTION_FULL	0x0
> +#define CXL_FW_TRANSFER_ACTION_START	0x1

Initiate isn't that bad and more obviously matches spec than start.

> +#define CXL_FW_TRANSFER_ACTION_CONTINUE	0x2
> +#define CXL_FW_TRANSFER_ACTION_END	0x3
> +#define CXL_FW_TRANSFER_ACTION_ABORT	0x4
> +#define CXL_FW_TRANSFER_OFFSET_ALIGN	128

This looks like a field definition but it isn't.
Can we rename it or add a comment to make that clear.

> +
> +/*
> + * Activate Firmware Input Payload
> + * CXL rev 3.0 section 8.2.9.3.3; Table 8-58
> + */
> +struct cxl_mbox_activate_fw {
> +	u8 action;
> +	u8 slot;
> +} __packed;
> +
> +#define CXL_FW_ACTIVATE_ONLINE		0x0
> +#define CXL_FW_ACTIVATE_OFFLINE		0x1
> +
> +/**
> + * struct cxl_fw_state - Firmware upload / activation state
> + *
> + * @fw_mutex: Mutex to serialize fw update requests
> + * @clear_to_send: Initial checks done, ready to start FW transfer
> + * @cancel: Cancel any in-progress FW upload
> + * @next_slot: Slot number for the new firmware
> + * @info: Get FW Info structure
> + * @activate: Activate FW structure
> + * @transfer: Transfer FW Info structure
> + */
> +struct cxl_fw_state {
> +	struct mutex fw_mutex;
> +	bool clear_to_send;
> +	bool oneshot;
> +	bool cancel;
> +	int next_slot;
> +	struct cxl_mbox_get_fw_info info;
> +	struct cxl_mbox_activate_fw activate;

Not seeing why activate or transfer should be in here.
Even info could be replaced with just the fields we care about outside
of the command itself.

> +	struct cxl_mbox_transfer_fw *transfer;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -256,6 +332,7 @@ struct cxl_event_state {
>   * @serial: PCIe Device Serial Number
>   * @doe_mbs: PCI DOE mailbox array
>   * @event: event log driver state
> + * @fw: firmware upload / activation state
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -295,6 +372,7 @@ struct cxl_dev_state {
>  	struct xarray doe_mbs;
>  
>  	struct cxl_event_state event;
> +	struct cxl_fw_state fw;
>  
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
> @@ -307,6 +385,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
>  	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> +	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4b0c7564d350..bdeb5495d1cc 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1120,6 +1120,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  
>  	mutex_init(&cxlds->mbox_mutex);
>  	mutex_init(&cxlds->event.log_lock);
> +	mutex_init(&cxlds->fw.fw_mutex);
>  	cxlds->dev = dev;
>  
>  	return cxlds;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 28a05f2fe32d..8f61b1e526ae 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. */
>  
> +#include <linux/firmware.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
> @@ -214,6 +215,8 @@ static void cxl_memdev_unregister(void *_cxlmd)
>  	struct cxl_memdev *cxlmd = _cxlmd;
>  	struct device *dev = &cxlmd->dev;
>  
> +	firmware_upload_unregister(cxlmd->fwl);
> +	kfree(cxlmd->fw_name);
>  	cxl_memdev_shutdown(dev);
>  	cdev_device_del(&cxlmd->cdev, dev);
>  	put_device(dev);
> @@ -315,6 +318,320 @@ static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +/**
> + * cxl_mem_get_fw_info - Get Firmware info
> + * @cxlds: The device data for the operation
> + *
> + * Retrieve firmware info for the device specified.
> + *
> + * Return: 0 if no error: or the result of the mailbox command.
> + *
> + * See CXL-3.0 8.2.9.3.1 Get FW Info
> + */
> +static int cxl_mem_get_fw_info(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_mbox_get_fw_info *info = &cxlds->fw.info;

> +	struct cxl_mbox_cmd mbox_cmd;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_FW_INFO,
> +		.size_out = sizeof(*info),
> +		.payload_out = info,
> +	};
> +
> +	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +}
> +
> +/**
> + * cxl_mem_activate_fw - Activate Firmware
> + * @cxlds: The device data for the operation
> + * @slot: slot number to activate
> + *
> + * Activate firmware in a given slot for the device specified.
> + *
> + * Return: 0 if no error: or the result of the mailbox command.
> + *
> + * See CXL-3.0 8.2.9.3.3 Activate FW
> + */
> +static int cxl_mem_activate_fw(struct cxl_dev_state *cxlds, int slot)
> +{
> +	struct cxl_mbox_activate_fw *activate = &cxlds->fw.activate;

I'd put this on the stack locally.  Doesn't need to be allocated
all the time.

> +	struct cxl_mbox_cmd mbox_cmd;
> +
> +	if (slot == 0 || slot > cxlds->fw.info.num_slots)
> +		return -EINVAL;
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_ACTIVATE_FW,
> +		.size_in = sizeof(*activate),
> +		.payload_in = activate,
> +	};
> +
> +	/* Only offline activation supported for now */
> +	activate->action = CXL_FW_ACTIVATE_OFFLINE;
> +	activate->slot = slot;
> +
> +	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +}
> +
> +/**
> + * cxl_mem_abort_fw_xfer - Abort an in-progress FW transfer
> + * @cxlds: The device data for the operation
> + *
> + * Abort an in-progress firmware transfer for the device specified.
> + *
> + * Return: 0 if no error: or the result of the mailbox command.
> + *
> + * See CXL-3.0 8.2.9.3.2 Transfer FW
> + */
> +static int cxl_mem_abort_fw_xfer(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_mbox_transfer_fw *transfer;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	transfer = kzalloc(sizeof(*transfer), GFP_KERNEL);

Even though the extra part is size 0 I'd use
struct_size() to make that explicit.

> +	if (!transfer)
> +		return -ENOMEM;
> +
> +	/* Set a 1s poll interval and a total wait time of 5 minutes */
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_TRANSFER_FW,
> +		.size_in = sizeof(*transfer),
> +		.payload_in = transfer,
> +		.poll_interval = 1000,
> +		.poll_count = 300,
> +	};
> +
> +	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	kfree(transfer);
> +	return rc;
> +}
> +

> +
> +static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
> +					 u32 size)
> +{
> +	struct cxl_memdev *cxlmd = fwl->dd_handle;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	if (!size)
> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> +
> +	if (size + sizeof(struct cxl_mbox_transfer_fw) < cxlds->payload_size)
> +		cxlds->fw.oneshot = true;
> +	else
> +		cxlds->fw.oneshot = false;

	cxlds->fw.oneshot = struct_size(..) < cxlds->payload_size;

> +
> +	if (cxl_mem_get_fw_info(cxlds))
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +
> +	if (cxlds->fw.cancel) {
> +		cxl_fw_cleanup(fwl);
> +		return FW_UPLOAD_ERR_CANCELED;
> +	}
> +
> +	cxlds->fw.clear_to_send = true;
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
> +				       u32 offset, u32 size, u32 *written)
> +{
> +	struct cxl_memdev *cxlmd = fwl->dd_handle;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_transfer_fw *transfer;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc, num_slots, cur_slot;
> +	u32 cur_size, remaining;
> +	size_t size_in;
> +
> +	*written = 0;
> +
> +	/* Offset has to be aligned to 128B (CXL-3.0 8.2.9.3.2 Table 8-57) */
> +	if (offset % CXL_FW_TRANSFER_OFFSET_ALIGN) {
> +		dev_err(&cxlmd->dev,
> +			"misaligned offset for FW transfer slice (%u)\n",
> +			offset);
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	}
> +
> +	/* Pick transfer size based on cxlds->payload_size */
> +	cur_size = ALIGN_DOWN(min((size_t)size,
> +				  cxlds->payload_size - sizeof(*transfer)),
> +			      CXL_FW_TRANSFER_OFFSET_ALIGN);
> +	remaining = size - cur_size;
> +	size_in = cur_size + sizeof(*transfer);

struct_size()?

> +
> +	mutex_lock(&cxlds->fw.fw_mutex);
> +	if (!cxlds->fw.clear_to_send) {
> +		dev_err(&cxlmd->dev, "firmware_loader prep not done\n");
> +		rc = FW_UPLOAD_ERR_BUSY;
> +		goto out_unlock;
> +	}
> +
> +	if (cxlds->fw.cancel) {
> +		rc = cxl_mem_abort_fw_xfer(cxlds);
> +		if (rc < 0)
> +			dev_err(&cxlmd->dev, "Error aborting FW transfer: %d\n",
> +				rc);
> +		cxl_fw_cleanup(fwl);
> +		rc = FW_UPLOAD_ERR_CANCELED;
> +		goto out_unlock;
> +	}
> +
> +	/* Determine next slot from fw_info */
> +	num_slots = cxlds->fw.info.num_slots;
> +	cur_slot = FIELD_GET(CXL_FW_INFO_CUR_SLOT_MASK,
> +			     cxlds->fw.info.slot_info);
> +
> +	/*
> +	 * Slot numbers are 1-indexed
> +	 * cur_slot is the 0-indexed next_slot (i.e. 'cur_slot - 1 + 1')
> +	 * Check for rollover using modulo, and 1-index it by adding 1
> +	 */
> +	cxlds->fw.next_slot = (cur_slot % num_slots) + 1;
> +
> +	/* Do the transfer via mailbox cmd */
> +	transfer = kzalloc(size_in, GFP_KERNEL);
> +	if (!transfer) {
> +		rc = FW_UPLOAD_ERR_RW_ERROR;
> +		goto out_unlock;
> +	}
> +
> +	transfer->offset = cpu_to_le32(offset / CXL_FW_TRANSFER_OFFSET_ALIGN);
> +	memcpy(transfer->data, data + offset, cur_size);
> +	if (cxlds->fw.oneshot) {
> +		transfer->action = CXL_FW_TRANSFER_ACTION_FULL;
> +		transfer->slot = cxlds->fw.next_slot;
> +	} else {
> +		if (offset == 0) {
> +			transfer->action = CXL_FW_TRANSFER_ACTION_START;
> +		} else if (remaining == 0) {
> +			transfer->action = CXL_FW_TRANSFER_ACTION_END;
> +			transfer->slot = cxlds->fw.next_slot;
> +		} else {
> +			transfer->action = CXL_FW_TRANSFER_ACTION_CONTINUE;
> +		}
> +	}
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_TRANSFER_FW,
> +		.size_in = size_in,
> +		.payload_in = transfer,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc < 0) {
> +		kfree(transfer);

Where is this freed in non error paths?

> +		rc = FW_UPLOAD_ERR_RW_ERROR;
> +		goto out_unlock;
> +	}
> +
> +	*written = cur_size;
> +
> +	/* Activate FW if oneshot or if the last slice was written */
> +	if (cxlds->fw.oneshot || remaining == 0) {
> +		dev_dbg(&cxlmd->dev, "Activating firmware slot: %d\n",
> +			cxlds->fw.next_slot);
> +		rc = cxl_mem_activate_fw(cxlds, cxlds->fw.next_slot);
> +		if (rc < 0) {
> +			dev_err(&cxlmd->dev, "Error activating firmware: %d\n",
> +				rc);
> +			rc = FW_UPLOAD_ERR_HW_ERROR;
> +			goto out_unlock;
> +		}
> +	}
> +
> +	rc = FW_UPLOAD_ERR_NONE;
> +
> +out_unlock:
> +	mutex_unlock(&cxlds->fw.fw_mutex);
> +	return rc;
> +}
> +
> +static enum fw_upload_err cxl_fw_poll_complete(struct fw_upload *fwl)
> +{
> +	struct cxl_memdev *cxlmd = fwl->dd_handle;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	int rc;
> +
> +	/*
> +	 * cxl_internal_send_cmd() handles background operations synchronously.
> +	 * No need to wait for completions here - any errors would've been
> +	 * reported and handled during the ->write() call(s).
> +	 * Just check if a cancel request was received, and return success.
> +	 */
> +	mutex_lock(&cxlds->fw.fw_mutex);
> +	if (cxlds->fw.cancel) {
> +		rc = cxl_mem_abort_fw_xfer(cxlds);
> +		if (rc < 0)
> +			dev_err(&cxlmd->dev, "Error aborting FW transfer: %d\n",
> +				rc);
> +		cxl_fw_cleanup(fwl);
> +		rc = FW_UPLOAD_ERR_CANCELED;
> +		goto out_unlock;
> +	}
> +
> +	rc = FW_UPLOAD_ERR_NONE;

maybe use an else and drop the goto?

> +
> +out_unlock:
> +	mutex_unlock(&cxlds->fw.fw_mutex);
> +	return rc;
> +}
> +
> +static void cxl_fw_cancel(struct fw_upload *fwl)
> +{
> +	struct cxl_memdev *cxlmd = fwl->dd_handle;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	mutex_lock(&cxlds->fw.fw_mutex);

Local variable for fw perhaps? Lots of cxlds->fw otherwise.
Same in some places above as well.


> +	cxlds->fw.cancel = true;
> +	mutex_unlock(&cxlds->fw.fw_mutex);
> +}
> +
> +static const struct fw_upload_ops cxl_memdev_fw_ops = {
> +        .prepare = cxl_fw_prepare,
> +        .write = cxl_fw_write,
> +        .poll_complete = cxl_fw_poll_complete,
> +        .cancel = cxl_fw_cancel,
> +        .cleanup = cxl_fw_cleanup,
> +};
> +
> +static int cxl_memdev_setup_fw_upload(struct cxl_memdev *cxlmd)
> +{
> +	const char *fw_name, *truncate;
> +	struct fw_upload *fwl;
> +	unsigned int len;
> +
> +	fw_name = dev_name(&cxlmd->dev);
> +	truncate = strstr(fw_name, ".auto");
> +	len = (truncate) ? truncate - fw_name : strlen(fw_name);

Why first set of brackets?

> +	cxlmd->fw_name = kmemdup_nul(fw_name, len, GFP_KERNEL);

Can fail in theory, does that matter?

> +
> +	fwl = firmware_upload_register(THIS_MODULE, &cxlmd->dev, cxlmd->fw_name,
> +				       &cxl_memdev_fw_ops, cxlmd);
> +	if (IS_ERR(fwl)) {
> +		dev_err(&cxlmd->dev, "Failed to register firmware loader\n");
> +		kfree(cxlmd->fw_name);
> +		return PTR_ERR(fwl);
> +	}
> +
> +	cxlmd->fwl = fwl;
> +	return 0;
> +}
> +
>  static const struct file_operations cxl_memdev_fops = {
>  	.owner = THIS_MODULE,
>  	.unlocked_ioctl = cxl_memdev_ioctl,
> @@ -352,11 +669,18 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	if (rc)
>  		goto err;
>  
> +	rc = cxl_memdev_setup_fw_upload(cxlmd);

I'd expect this to be side effect free on error.  And it seems to be...
So why the cleanup below?  Looks like fw_name freed twice...

I'd be tempted to push one or more explicit devm_add_action_or_reset() calls into
there so that we can keep the setup and cleanup local in the code.  Also don't need
to do the kfree by hand above. Pity there is no devm_kmemdup_nul()



> +	if (rc)
> +		goto err_fw;
> +
>  	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
>  	if (rc)
>  		return ERR_PTR(rc);

>  	return cxlmd;
>  
> +err_fw:
> +	firmware_upload_unregister(cxlmd->fwl);
If you need to call this on firmware_upload_register() failing I'd be somewhat surprised...

> +	kfree(cxlmd->fw_name);
>  err:
>  	/*
>  	 * The cdev was briefly live, shutdown any ioctl operations that

