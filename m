Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D01F730172
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245483AbjFNOPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245489AbjFNOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:14:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0339D10D8;
        Wed, 14 Jun 2023 07:14:21 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qh6ml0TPXz6J7Z5;
        Wed, 14 Jun 2023 22:11:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 15:14:18 +0100
Date:   Wed, 14 Jun 2023 15:14:17 +0100
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
Subject: Re: [PATCH v3 1/4] cxl: add a firmware update mechanism using the
 sysfs firmware loader
Message-ID: <20230614151417.00002f46@Huawei.com>
In-Reply-To: <20230602-vv-fw_update-v3-1-869f82069c95@intel.com>
References: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
        <20230602-vv-fw_update-v3-1-869f82069c95@intel.com>
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
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 00:55:56 -0600
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
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

One issue and one trivial comment inline.
With those fixed up and subject to the fact I haven't looked at the firmware
class before...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 057a43267290..3234885ad804 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1,6 +1,7 @@


> +
> +static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
> +				       u32 offset, u32 size, u32 *written)
> +{
> +	struct cxl_dev_state *cxlds = fwl->dd_handle;
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct cxl_mbox_transfer_fw *transfer;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u32 cur_size, remaining;
> +	size_t size_in;
> +	int rc;
> +
> +	*written = 0;
> +
> +	/* Offset has to be aligned to 128B (CXL-3.0 8.2.9.3.2 Table 8-57) */
> +	if (!IS_ALIGNED(offset, CXL_FW_TRANSFER_ALIGNMENT)) {
> +		dev_err(&cxlmd->dev,
> +			"misaligned offset for FW transfer slice (%u)\n",
> +			offset);
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +	}
> +
> +	/*
> +	 * Pick transfer size based on cxlds->payload_size
> +	 * @size must bw 128-byte aligned, ->payload_size is a power of 2
> +	 * starting at 256 bytes, and sizeof(*transfer) is 128.
> +	 * These constraints imply that @cur_size will always be 128b aligned.
> +	 */
> +	cur_size = min_t(size_t, size, cxlds->payload_size - sizeof(*transfer));
> +
> +	remaining = size - cur_size;
> +	size_in = struct_size(transfer, data, cur_size);
> +
> +	if (test_and_clear_bit(CXL_FW_CANCEL, cxlds->fw.state))
> +		return cxl_fw_do_cancel(fwl);
> +
> +	/*
> +	 * Slot numbers are 1-indexed
> +	 * cur_slot is the 0-indexed next_slot (i.e. 'cur_slot - 1 + 1')
> +	 * Check for rollover using modulo, and 1-index it by adding 1
> +	 */
> +	cxlds->fw.next_slot = (cxlds->fw.cur_slot % cxlds->fw.num_slots) + 1;
> +
> +	/* Do the transfer via mailbox cmd */
> +	transfer = kzalloc(size_in, GFP_KERNEL);
> +	if (!transfer)
> +		return FW_UPLOAD_ERR_RW_ERROR;
> +
> +	transfer->offset = cpu_to_le32(offset / CXL_FW_TRANSFER_ALIGNMENT);
> +	memcpy(transfer->data, data + offset, cur_size);
> +	if (cxlds->fw.oneshot) {
> +		transfer->action = CXL_FW_TRANSFER_ACTION_FULL;
> +		transfer->slot = cxlds->fw.next_slot;
> +	} else {
> +		if (offset == 0) {
> +			transfer->action = CXL_FW_TRANSFER_ACTION_INITIATE;
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
> +		.poll_interval_ms = 1000,
> +		.poll_count = 30,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc < 0) {
> +		kfree(transfer);

Double free.  Drop this one.

> +		rc = FW_UPLOAD_ERR_RW_ERROR;
> +		goto out_free;
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
> +			goto out_free;
> +		}
> +	}
> +
> +	rc = FW_UPLOAD_ERR_NONE;
> +
> +out_free:
> +	kfree(transfer);
> +	return rc;
> +}



>  static const struct file_operations cxl_memdev_fops = {
>  	.owner = THIS_MODULE,
>  	.unlocked_ioctl = cxl_memdev_ioctl,
> @@ -582,6 +891,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
>  	if (rc)
>  		return ERR_PTR(rc);
> +

What is this stray white space change I see before me? :)


>  	return cxlmd;
>  
>  err:

