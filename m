Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2EC7184F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbjEaO2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbjEaO2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7F4132;
        Wed, 31 May 2023 07:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0231862E53;
        Wed, 31 May 2023 14:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C80C433EF;
        Wed, 31 May 2023 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685543297;
        bh=INiwjZyN6HvJRVa9p1JVo5pE0hFi3DcFXYCoy4D6pGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WrhrrsdIQnSxfoAYWqgfEGhvzZ5U3Dm4QU2iiI+yjHkARZa/BrP2HoI3K+gvdthlq
         ZHAWK6nhRE92UR5iKo+dW92SHgp1gHSRAYR9O5TAvEEWZ8WUQv7wdgULa6psEWqUiA
         eeUgCRFOsCrxCTgWPyqqHMFiIPMXlfTxFgdnqGivX8VgQ2kL1cU+XMPn4t48WlY7a9
         1rtf4Dvg9qbm5XO6/lFGTaxiwsJxcWZQdJtFWSK4koTv+HfLlFNyPs1FExYEdmvCY+
         mfGWoH/Irkba+PSKEtW/+atNa4sM+b2+aKeuQ+06WeL8/6/VAaGhNbtzK6xfDy11+D
         Ho21CtcDJBVOQ==
Date:   Wed, 31 May 2023 19:58:03 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>, kuba@kernel.org
Cc:     mani@kernel.org, gregkh@linuxfoundation.org, andersson@kernel.org,
        daniel@ffwll.ch, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Subject: Re: [PATCH] bus: mhi: host: Add userspace character interface
Message-ID: <20230531142803.GH7968@thinkpad>
References: <20230522190459.13790-1-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522190459.13790-1-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jakub (who NACKed the previous submission of UCI driver)
Link to previous submission: https://lore.kernel.org/all/1606533966-22821-1-git-send-email-hemantk@codeaurora.org/

On Mon, May 22, 2023 at 01:04:59PM -0600, Jeffrey Hugo wrote:
> From: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> 
> I2C, USB, and PCIe are examples of buses which have a mechanism to give
> userspace direct access to a device on those buses. The MHI userspace
> character interface (uci) is the MHI bus analogue.
> 
> The MHI bus devices are MHI channels which ferry blocks of data from one
> end to the other. With this simple purpose, we can define a simple
> interface to userspace - a character device that supports open/close/read/
> write/poll operations. Since bus devices can only have a single consumer
> we encode a whitelist of MHI channels to be exported to userspace so as
> to avoid conflicts.
> 
> We also make this mechanism open to any device that implements MHI.
> Today this includes WLAN (Wi-Fi), WWAN (4G/5G cellular), and ML/AI
> devices. More devices are expected in the future.
> 
> In addition to implementing the framework for uci, we include an initial
> usecase - the QAIC Sahara device.
> 
> Sahara is a file transfer protocol that is commonly used for two purposes
> when interacting with a device - transferring firmware to the device and
> transferring crashdumps from the device. The Sahara protocol puts the
> receiver of the data in control of the transfer. A firmware transfer
> operation would have the device requesting the specific firmware images
> that the device wants, and the host satisfying those requests.
> 
> In most cases, including for AIC100, Sahara is used as part of a two stage
> loading process. The device will boot a very limited bootloader that does
> the base minimum initialization and jump to the next stage. A simple, one-
> shot protocol like BHI is used to send the next stage bootloader to the
> device. This second stage bootloader contains more functionality and
> implements the Sahara protocol. The second stage determines from various
> inputs what set of runtime firmware is required to boot the device into an
> operational status, and requests those pieces from the host.  With those
> images transferred over, the device can funnly initialize.
> 
> Each AIC100 instance (currently, up to 16) in a system will create a
> MHI device for QAIC_SAHARA. MHI_uci will consume each of these and create
> a unique chardev which will be found as
> /dev/<mhi instance>_QAIC_SAHARA
> For example - /dev/mhi0_QAIC_SAHARA
> 
> An open userspace application that can consume these devices for firmware
> transfers is located at https://github.com/andersson/qdl
> 
> Signed-off-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> [jhugo: Rename to uci, plumb to mhi, rewrite commit text]
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

The previous attempt on adding UCI driver was NACKed by Jakub. For merging this
patch, I need an ACK from Jakub.

- Mani

> ---
> 
> Previous uci proposal - https://lore.kernel.org/all/1609958656-15064-1-git-send-email-hemantk@codeaurora.org/
> 
>  drivers/bus/mhi/host/Makefile   |   2 +-
>  drivers/bus/mhi/host/init.c     |  13 +-
>  drivers/bus/mhi/host/internal.h |   4 +
>  drivers/bus/mhi/host/uci.c      | 566 ++++++++++++++++++++++++++++++++
>  4 files changed, 583 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/bus/mhi/host/uci.c
> 
> diff --git a/drivers/bus/mhi/host/Makefile b/drivers/bus/mhi/host/Makefile
> index 859c2f38451c..7e446355680b 100644
> --- a/drivers/bus/mhi/host/Makefile
> +++ b/drivers/bus/mhi/host/Makefile
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_MHI_BUS) += mhi.o
> -mhi-y := init.o main.o pm.o boot.o
> +mhi-y := init.o main.o pm.o boot.o uci.o
>  mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
>  
>  obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index f72fcb66f408..ed4b345d8222 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -1447,13 +1447,24 @@ struct bus_type mhi_bus_type = {
>  
>  static int __init mhi_init(void)
>  {
> +	int ret;
> +
>  	mhi_debugfs_init();
> -	return bus_register(&mhi_bus_type);
> +	ret = bus_register(&mhi_bus_type);
> +	if (ret)
> +		return ret;
> +
> +	ret = mhi_uci_init();
> +	if (ret)
> +		bus_unregister(&mhi_bus_type);
> +
> +	return ret;
>  }
>  
>  static void __exit mhi_exit(void)
>  {
>  	mhi_debugfs_exit();
> +	mhi_uci_exit();
>  	bus_unregister(&mhi_bus_type);
>  }
>  
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 2e139e76de4c..52ddaaab81fc 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -380,4 +380,8 @@ void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
>  void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
>  			     struct mhi_buf_info *buf_info);
>  
> +/* UCI hooks */
> +int mhi_uci_init(void);
> +void mhi_uci_exit(void);
> +
>  #endif /* _MHI_INT_H */
> diff --git a/drivers/bus/mhi/host/uci.c b/drivers/bus/mhi/host/uci.c
> new file mode 100644
> index 000000000000..e67fc6f7d8db
> --- /dev/null
> +++ b/drivers/bus/mhi/host/uci.c
> @@ -0,0 +1,566 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved. */
> +
> +#include <linux/kernel.h>
> +#include <linux/mhi.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/poll.h>
> +#include <linux/xarray.h>
> +#include <uapi/linux/eventpoll.h>
> +
> +#define MHI_UCI_DRIVER_NAME		"mhi_uci"
> +#define MHI_UCI_MAX_MINORS		128
> +#define MHI_MAX_MTU			0xffff
> +static DEFINE_XARRAY_ALLOC(uci_xa);
> +static struct class *uci_dev_class;
> +static int uci_dev_major;
> +
> +/**
> + * struct uci_buf - Buffer structure used to receive data from device
> + * @data: Address of data to read from
> + * @odata: Original address returned from *alloc() API. Used to free this buf.
> + * @len: Length of data in byte
> + * @node: This buffer will be part of list managed in struct uci_dev
> + */
> +struct uci_buf {
> +	void *data;
> +	void *odata;
> +	size_t len;
> +	struct list_head node;
> +};
> +
> +/**
> + * struct uci_dev - MHI UCI Device
> + * @minor: uci device node minor number
> + * @mhi_dev: Associated mhi device object
> + * @mtu: Max TRE buffer length
> + * @enabled: Flag to track the state of the uci device
> + * @lock: Mutex lock to serialize access to open_count
> + * @read_lock: Mutex lock to serialize readers
> + * @write_lock: Mutex lock to serialize writers
> + * @ul_wq: Wait queue for writers
> + * @dl_wq: Wait queue for readers
> + * @dl_queue_lock: Spin lock to serialize access to download queue
> + * @dl_queue: Queue of downloaded buffers
> + * @open_count: Track open counts
> + * @ref_count: Reference count for this structure
> + */
> +struct uci_dev {
> +	uint32_t minor;
> +	struct mhi_device *mhi_dev;
> +	size_t mtu;
> +	bool enabled;
> +	struct mutex lock;
> +	struct mutex read_lock;
> +	struct mutex write_lock;
> +	wait_queue_head_t ul_wq;
> +	wait_queue_head_t dl_wq;
> +	spinlock_t dl_queue_lock;
> +	struct list_head dl_queue;
> +	unsigned int open_count;
> +	struct kref ref_count;
> +};
> +
> +static void uci_dev_release(struct kref *ref)
> +{
> +	struct uci_dev *ucidev = container_of(ref, struct uci_dev, ref_count);
> +
> +	mutex_destroy(&ucidev->read_lock);
> +	mutex_destroy(&ucidev->write_lock);
> +	mutex_destroy(&ucidev->lock);
> +	kfree(ucidev);
> +}
> +
> +static int mhi_uci_fill_dl_queue(struct uci_dev *ucidev)
> +{
> +	struct mhi_device *mhi_dev = ucidev->mhi_dev;
> +	struct uci_buf *ucibuf;
> +	int rx_budget;
> +	int ret = 0;
> +	void *data;
> +
> +	rx_budget = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
> +	if (rx_budget < 0)
> +		return -EIO;
> +
> +	while (rx_budget--) {
> +		data = kzalloc(ucidev->mtu + sizeof(*ucibuf), GFP_KERNEL);
> +		if (!data)
> +			return -ENOMEM;
> +
> +		ucibuf = data + ucidev->mtu;
> +		ucibuf->odata = data;
> +
> +		ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, data, ucidev->mtu, MHI_EOT);
> +		if (ret) {
> +			kfree(data);
> +			dev_err(&mhi_dev->dev, "Failed to queue buffer\n");
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int mhi_uci_dev_start_chan(struct uci_dev *ucidev)
> +{
> +	struct device *dev = &ucidev->mhi_dev->dev;
> +	int ret = 0;
> +
> +	ret = mutex_lock_interruptible(&ucidev->lock);
> +	if (ret)
> +		return ret;
> +	if (!ucidev->enabled) {
> +		ret = -ENODEV;
> +		goto release_dev_lock;
> +	}
> +	if (!ucidev->open_count) {
> +		ret = mhi_prepare_for_transfer(ucidev->mhi_dev);
> +		if (ret) {
> +			dev_err(dev, "Error starting transfer channels\n");
> +			goto release_dev_lock;
> +		}
> +
> +		ret = mhi_uci_fill_dl_queue(ucidev);
> +		if (ret) {
> +			dev_err(dev, "Error filling download queue.\n");
> +			goto mhi_unprepare;
> +		}
> +	}
> +	ucidev->open_count++;
> +	mutex_unlock(&ucidev->lock);
> +
> +	return 0;
> +
> +mhi_unprepare:
> +	mhi_unprepare_from_transfer(ucidev->mhi_dev);
> +release_dev_lock:
> +	mutex_unlock(&ucidev->lock);
> +	return ret;
> +}
> +
> +static struct uci_dev *uci_dev_get_by_minor(unsigned int minor)
> +{
> +	struct uci_dev *ucidev;
> +
> +	xa_lock(&uci_xa);
> +	ucidev = xa_load(&uci_xa, minor);
> +	if (ucidev)
> +		kref_get(&ucidev->ref_count);
> +	xa_unlock(&uci_xa);
> +
> +	return ucidev;
> +}
> +
> +static int mhi_uci_open(struct inode *inode, struct file *filp)
> +{
> +	struct uci_dev *ucidev;
> +	int ret;
> +
> +	ucidev = uci_dev_get_by_minor(iminor(inode));
> +	if (!ucidev) {
> +		pr_debug("mqc: minor %d not found\n", iminor(inode));
> +		return -EINVAL;
> +	}
> +
> +	ret = mhi_uci_dev_start_chan(ucidev);
> +	if (ret) {
> +		kref_put(&ucidev->ref_count, uci_dev_release);
> +		return ret;
> +	}
> +
> +	filp->private_data = ucidev;
> +
> +	return 0;
> +}
> +
> +static void mhi_uci_buf_free(struct uci_buf *ucibuf)
> +{
> +	list_del(&ucibuf->node);
> +	kfree(ucibuf->odata);
> +}
> +
> +static void __mhi_uci_release(struct uci_dev *ucidev)
> +{
> +	struct uci_buf *ucibuf, *tmp;
> +
> +	mhi_unprepare_from_transfer(ucidev->mhi_dev);
> +	wake_up_interruptible(&ucidev->ul_wq);
> +	wake_up_interruptible(&ucidev->dl_wq);
> +	/*
> +	 * Free the dl_queue. As we have already unprepared mhi transfers, we
> +	 * do not expect any callback functions that update dl_queue hence no need
> +	 * to grab dl_queue lock.
> +	 */
> +	mutex_lock(&ucidev->read_lock);
> +	list_for_each_entry_safe(ucibuf, tmp, &ucidev->dl_queue, node)
> +		mhi_uci_buf_free(ucibuf);
> +	mutex_unlock(&ucidev->read_lock);
> +}
> +
> +static int mhi_uci_release(struct inode *inode, struct file *file)
> +{
> +	struct uci_dev *ucidev = file->private_data;
> +
> +	mutex_lock(&ucidev->lock);
> +	ucidev->open_count--;
> +	if (!ucidev->open_count && ucidev->enabled)
> +		__mhi_uci_release(ucidev);
> +	mutex_unlock(&ucidev->lock);
> +
> +	kref_put(&ucidev->ref_count, uci_dev_release);
> +
> +	return 0;
> +}
> +
> +static __poll_t mhi_uci_poll(struct file *file, poll_table *wait)
> +{
> +	struct uci_dev *ucidev = file->private_data;
> +	struct mhi_device *mhi_dev;
> +	__poll_t mask = 0;
> +
> +	mhi_dev = ucidev->mhi_dev;
> +
> +	poll_wait(file, &ucidev->ul_wq, wait);
> +	poll_wait(file, &ucidev->dl_wq, wait);
> +
> +	mutex_lock(&ucidev->lock);
> +	if (!ucidev->enabled) {
> +		mutex_unlock(&ucidev->lock);
> +		return EPOLLERR;
> +	}
> +
> +	spin_lock_bh(&ucidev->dl_queue_lock);
> +	if (!list_empty(&ucidev->dl_queue))
> +		mask |= EPOLLIN | EPOLLRDNORM;
> +	spin_unlock_bh(&ucidev->dl_queue_lock);
> +
> +	if (mutex_lock_interruptible(&ucidev->write_lock)) {
> +		mutex_unlock(&ucidev->lock);
> +		return EPOLLERR;
> +	}
> +	if (mhi_get_free_desc_count(mhi_dev, DMA_TO_DEVICE) > 0)
> +		mask |= EPOLLOUT | EPOLLWRNORM;
> +	mutex_unlock(&ucidev->write_lock);
> +	mutex_unlock(&ucidev->lock);
> +
> +	dev_dbg(&mhi_dev->dev, "Client attempted to poll, returning mask 0x%x\n", mask);
> +
> +	return mask;
> +}
> +
> +static int mhi_uci_tx(struct uci_dev *ucidev)
> +{
> +	int ret;
> +
> +	ret = wait_event_interruptible(ucidev->ul_wq, (!ucidev->enabled ||
> +				       mhi_get_free_desc_count(ucidev->mhi_dev,
> +							       DMA_TO_DEVICE) > 0));
> +
> +	if (!ucidev->enabled)
> +		return -ENODEV;
> +
> +	return ret;
> +}
> +
> +static ssize_t mhi_uci_write(struct file *file, const char __user *buf, size_t count, loff_t *offp)
> +{
> +	struct uci_dev *ucidev = file->private_data;
> +	struct mhi_device *mhi_dev;
> +	size_t bytes_xfered = 0;
> +	struct device *dev;
> +	int ret, nr_desc;
> +
> +	mhi_dev = ucidev->mhi_dev;
> +	dev = &mhi_dev->dev;
> +
> +	if (!mhi_dev->ul_chan)
> +		return -EOPNOTSUPP;
> +
> +	if (!buf || !count)
> +		return -EINVAL;
> +
> +	dev_dbg(dev, "Request to transfer %zu bytes\n", count);
> +
> +	ret = mhi_uci_tx(ucidev);
> +	if (ret)
> +		return ret;
> +
> +	if (mutex_lock_interruptible(&ucidev->write_lock))
> +		return -EINTR;
> +
> +	nr_desc = mhi_get_free_desc_count(mhi_dev, DMA_TO_DEVICE);
> +	if (nr_desc * ucidev->mtu < count) {
> +		ret = -EMSGSIZE;
> +		dev_dbg(dev, "Buffer too big to transfer\n");
> +		goto unlock_mutex;
> +	}
> +
> +	while (count != bytes_xfered) {
> +		enum mhi_flags flags;
> +		size_t to_copy;
> +		void *kbuf;
> +
> +		to_copy = min_t(size_t, count - bytes_xfered, ucidev->mtu);
> +		kbuf = kmalloc(to_copy, GFP_KERNEL);
> +		if (!kbuf) {
> +			ret = -ENOMEM;
> +			goto unlock_mutex;
> +		}
> +
> +		ret = copy_from_user(kbuf, buf + bytes_xfered, to_copy);
> +		if (ret) {
> +			kfree(kbuf);
> +			ret = -EFAULT;
> +			goto unlock_mutex;
> +		}
> +
> +		if (bytes_xfered + to_copy == count)
> +			flags = MHI_EOT;
> +		else
> +			flags = MHI_CHAIN;
> +
> +		ret = mhi_queue_buf(mhi_dev, DMA_TO_DEVICE, kbuf, to_copy, flags);
> +		if (ret) {
> +			kfree(kbuf);
> +			dev_err(dev, "Failed to queue buf of size %zu\n", to_copy);
> +			goto unlock_mutex;
> +		}
> +
> +		bytes_xfered += to_copy;
> +	}
> +
> +	mutex_unlock(&ucidev->write_lock);
> +	dev_dbg(dev, "bytes xferred: %zu\n", bytes_xfered);
> +
> +	return bytes_xfered;
> +
> +unlock_mutex:
> +	mutex_unlock(&ucidev->write_lock);
> +	return ret;
> +}
> +
> +static int mhi_uci_rx(struct uci_dev *ucidev)
> +{
> +	int ret;
> +
> +	ret = wait_event_interruptible(ucidev->dl_wq, (!ucidev->enabled ||
> +				       !list_empty(&ucidev->dl_queue)));
> +
> +	if (!ucidev->enabled)
> +		return -ENODEV;
> +
> +	return ret;
> +}
> +
> +static ssize_t mhi_uci_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> +{
> +	struct uci_dev *ucidev = file->private_data;
> +	struct uci_buf *ucibuf;
> +	size_t to_copy;
> +	int ret;
> +
> +	if (!ucidev->mhi_dev->dl_chan)
> +		return -EOPNOTSUPP;
> +
> +	ret = mhi_uci_rx(ucidev);
> +	if (ret)
> +		return ret;
> +
> +	if (mutex_lock_interruptible(&ucidev->read_lock))
> +		return -EINTR;
> +
> +	ucibuf = list_first_entry_or_null(&ucidev->dl_queue, struct uci_buf, node);
> +	if (!ucibuf) {
> +		mutex_unlock(&ucidev->read_lock);
> +		ret = -ENODEV;
> +		goto error_out;
> +	}
> +
> +	to_copy = min_t(size_t, count, ucibuf->len);
> +	if (copy_to_user(buf, ucibuf->data, to_copy)) {
> +		mutex_unlock(&ucidev->read_lock);
> +		dev_dbg(&ucidev->mhi_dev->dev, "Failed to copy data to user buffer\n");
> +		ret = -EFAULT;
> +		goto error_out;
> +	}
> +
> +	ucibuf->len -= to_copy;
> +	ucibuf->data += to_copy;
> +
> +	if (!ucibuf->len) {
> +		spin_lock_bh(&ucidev->dl_queue_lock);
> +		mhi_uci_buf_free(ucibuf);
> +		spin_unlock_bh(&ucidev->dl_queue_lock);
> +		mhi_uci_fill_dl_queue(ucidev);
> +		dev_dbg(&ucidev->mhi_dev->dev, "Read buf freed\n");
> +	}
> +
> +	mutex_unlock(&ucidev->read_lock);
> +	return to_copy;
> +
> +error_out:
> +	mutex_unlock(&ucidev->read_lock);
> +	return ret;
> +}
> +
> +static const struct file_operations mhidev_fops = {
> +	.owner = THIS_MODULE,
> +	.open = mhi_uci_open,
> +	.release = mhi_uci_release,
> +	.read = mhi_uci_read,
> +	.write = mhi_uci_write,
> +	.poll = mhi_uci_poll,
> +};
> +
> +static void mhi_uci_ul_xfer_cb(struct mhi_device *mhi_dev, struct mhi_result *mhi_result)
> +{
> +	struct uci_dev *ucidev = dev_get_drvdata(&mhi_dev->dev);
> +
> +	dev_dbg(&mhi_dev->dev, "%s: status: %d xfer_len: %zu\n", __func__,
> +		mhi_result->transaction_status, mhi_result->bytes_xferd);
> +
> +	kfree(mhi_result->buf_addr);
> +
> +	if (!mhi_result->transaction_status)
> +		wake_up_interruptible(&ucidev->ul_wq);
> +}
> +
> +static void mhi_uci_dl_xfer_cb(struct mhi_device *mhi_dev, struct mhi_result *mhi_result)
> +{
> +	struct uci_dev *ucidev = dev_get_drvdata(&mhi_dev->dev);
> +	struct uci_buf *ucibuf;
> +
> +	dev_dbg(&mhi_dev->dev, "%s: status: %d receive_len: %zu\n", __func__,
> +		mhi_result->transaction_status, mhi_result->bytes_xferd);
> +
> +	if (mhi_result->transaction_status &&
> +	    mhi_result->transaction_status != -EOVERFLOW) {
> +		kfree(mhi_result->buf_addr);
> +		return;
> +	}
> +
> +	ucibuf = mhi_result->buf_addr + ucidev->mtu;
> +	ucibuf->data = mhi_result->buf_addr;
> +	ucibuf->len = mhi_result->bytes_xferd;
> +	spin_lock_bh(&ucidev->dl_queue_lock);
> +	list_add_tail(&ucibuf->node, &ucidev->dl_queue);
> +	spin_unlock_bh(&ucidev->dl_queue_lock);
> +
> +	wake_up_interruptible(&ucidev->dl_wq);
> +}
> +
> +static int mhi_uci_probe(struct mhi_device *mhi_dev, const struct mhi_device_id *id)
> +{
> +	struct uci_dev *ucidev;
> +	struct device *dev;
> +	int ret;
> +
> +	ucidev = kzalloc(sizeof(*ucidev), GFP_KERNEL);
> +	if (!ucidev)
> +		return -ENOMEM;
> +
> +	kref_init(&ucidev->ref_count);
> +	mutex_init(&ucidev->lock);
> +	ucidev->mhi_dev = mhi_dev;
> +
> +	ret = xa_alloc(&uci_xa, &ucidev->minor, ucidev, XA_LIMIT(0, MHI_UCI_MAX_MINORS),
> +		       GFP_KERNEL);
> +	if (ret) {
> +		kfree(ucidev);
> +		return ret;
> +	}
> +
> +	init_waitqueue_head(&ucidev->ul_wq);
> +	init_waitqueue_head(&ucidev->dl_wq);
> +	mutex_init(&ucidev->read_lock);
> +	mutex_init(&ucidev->write_lock);
> +	spin_lock_init(&ucidev->dl_queue_lock);
> +	INIT_LIST_HEAD(&ucidev->dl_queue);
> +	ucidev->mtu = min_t(size_t, id->driver_data, MHI_MAX_MTU);
> +	ucidev->enabled = true;
> +	ucidev->open_count = 0;
> +	dev_set_drvdata(&mhi_dev->dev, ucidev);
> +
> +	dev = device_create(uci_dev_class, &mhi_dev->dev, MKDEV(uci_dev_major, ucidev->minor),
> +			    ucidev, "%s", dev_name(&mhi_dev->dev));
> +	if (IS_ERR(dev)) {
> +		xa_erase(&uci_xa, ucidev->minor);
> +		dev_set_drvdata(&mhi_dev->dev, NULL);
> +		kfree(ucidev);
> +		return PTR_ERR(dev);
> +	}
> +
> +	return 0;
> +};
> +
> +static void mhi_uci_remove(struct mhi_device *mhi_dev)
> +{
> +	struct uci_dev *ucidev = dev_get_drvdata(&mhi_dev->dev);
> +
> +	device_destroy(uci_dev_class, MKDEV(uci_dev_major, ucidev->minor));
> +
> +	mutex_lock(&ucidev->lock);
> +	ucidev->enabled = false;
> +	if (ucidev->open_count)
> +		__mhi_uci_release(ucidev);
> +	mutex_unlock(&ucidev->lock);
> +
> +	xa_erase(&uci_xa, ucidev->minor);
> +	kref_put(&ucidev->ref_count, uci_dev_release);
> +}
> +
> +/* .driver_data stores max mtu */
> +static const struct mhi_device_id mhi_uci_match_table[] = {
> +	{ .chan = "QAIC_SAHARA", .driver_data = SZ_32K},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(mhi, mhi_uci_match_table);
> +
> +static struct mhi_driver mhi_uci_driver = {
> +	.id_table = mhi_uci_match_table,
> +	.remove = mhi_uci_remove,
> +	.probe = mhi_uci_probe,
> +	.ul_xfer_cb = mhi_uci_ul_xfer_cb,
> +	.dl_xfer_cb = mhi_uci_dl_xfer_cb,
> +	.driver = {
> +		.name = MHI_UCI_DRIVER_NAME,
> +	},
> +};
> +
> +int mhi_uci_init(void)
> +{
> +	int ret;
> +
> +	ret = register_chrdev(0, MHI_UCI_DRIVER_NAME, &mhidev_fops);
> +	if (ret < 0)
> +		return ret;
> +
> +	uci_dev_major = ret;
> +	uci_dev_class = class_create(MHI_UCI_DRIVER_NAME);
> +	if (IS_ERR(uci_dev_class)) {
> +		ret = PTR_ERR(uci_dev_class);
> +		goto unregister_chrdev;
> +	}
> +
> +	ret = mhi_driver_register(&mhi_uci_driver);
> +	if (ret)
> +		goto destroy_class;
> +
> +	return 0;
> +
> +destroy_class:
> +	class_destroy(uci_dev_class);
> +unregister_chrdev:
> +	unregister_chrdev(uci_dev_major, MHI_UCI_DRIVER_NAME);
> +	return ret;
> +}
> +
> +void mhi_uci_exit(void)
> +{
> +	mhi_driver_unregister(&mhi_uci_driver);
> +	class_destroy(uci_dev_class);
> +	unregister_chrdev(uci_dev_major, MHI_UCI_DRIVER_NAME);
> +	xa_destroy(&uci_xa);
> +}
> -- 
> 2.40.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
