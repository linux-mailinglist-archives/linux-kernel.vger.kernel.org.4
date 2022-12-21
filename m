Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6D6652CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiLUGM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiLUGM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:12:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54209DEC7;
        Tue, 20 Dec 2022 22:12:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4AEAB811F0;
        Wed, 21 Dec 2022 06:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB9CC433EF;
        Wed, 21 Dec 2022 06:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671603172;
        bh=ouzG0ASu9zkHuopyu7pm0lPS+6rGfN1KNntOaqDCBwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFrglzEs7S+BVcQBS6FOEhku1nLbdRVJqNzHgBJ0Lg5CWf5ndz5vnUqlkdB/rSnHV
         Gxqr0F9Wxltp2N7di7sJtewRUZ0CsvVncLY+OLMux5LNR4xE7qBI66M0JDhk1TRO0C
         Uq5DEc58mgpyXB0jthVaes4YfQCn9LleAV//HWlA=
Date:   Wed, 21 Dec 2022 07:12:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com,
        Kwame Adwere <kwame.adwere@nxp.com>
Subject: Re: [PATCH v6 2/2] misc: nxp-sr1xx: UWB driver support for sr1xx
 series chip
Message-ID: <Y6Kj4VlnJFFrzYW9@kroah.com>
References: <20221220154747.2372597-1-manjunatha.venkatesh@nxp.com>
 <20221220154747.2372597-3-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220154747.2372597-3-manjunatha.venkatesh@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 09:17:47PM +0530, Manjunatha Venkatesh wrote:
> Ultra-wideband (UWB) is a short-range wireless communication protocol.
> 
> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> Firmware Download on every device boot. More details on the SR1XX Family
> can be found at https://www.nxp.com/products/:UWB-TRIMENSION
> 
> The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> Interface (UCI).  The corresponding details are available in the FiRa
> Consortium Website (https://www.firaconsortium.org/).
> 
> Internally driver will handle two modes of operation.
> 1.HBCI mode (sr1xx BootROM Code Interface)
>   Firmware download uses HBCI ptotocol packet structure which is
>   Nxp proprietary,Firmware File(.bin) stored in user space context
>   and during device init sequence pick the firmware packet in chunk
>   and send it to the driver with write() api call.
> 
>   After the firmware download sequence at the end UWBS will
>   send device status notification and its indication of device entered
>   UCI mode.
>   Here after any command/response/notification will follow
>   UCI packet structure.
> 
> 2.UCI mode (UWB Command interface)
>   Once Firmware download finishes sr1xx will switch to UCI mode.
>   Then driver exchange command/response/notification as per the FIRA UCI
>   standard format between user space and sr1xx device.
>   Any response or notification received from sr1xx through SPI line
>   will convey to user space.
> 
>   Its Interrupt based driver and IO Handshake needed with SR1XX Family of
>   SOCs.
>   This driver needs dts config update as per the sr1xx data sheet.
>   Corresponding document available in Documentation/devicetree/bindings/uwb
> 
> Link: https://lore.kernel.org/r/dfe167cf-5d4e-6fc7-c954-25f719b1e843@nxp.com

Why is this here pointing to an old version of the patch?

> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> Signed-off-by: Kwame Adwere <kwame.adwere@nxp.com>
> ---
> Changes since v5:
>   - Moved ioctl command definitions into header file.
>   - Version 5 patch review comments addressed.
>   - Corporate lawyer sign-off updated.

Again, you are not documenting _WHY_ you want a dual license here, which
is what I asked for yesterday, why ignore that and ask us to review this
again?

> +#define UCI_HEADER_LEN 4
> +#define HBCI_HEADER_LEN 4
> +#define UCI_PAYLOAD_LEN_OFFSET 3
> +
> +#define UCI_EXT_PAYLOAD_LEN_IND_OFFSET 1
> +#define UCI_EXT_PAYLOAD_LEN_IND_OFFSET_MASK 0x80
> +#define UCI_EXT_PAYLOAD_LEN_OFFSET 2
> +#define UCI_MT_MASK 0xE0
> +
> +#define SR1XX_TXBUF_SIZE 4200
> +#define SR1XX_RXBUF_SIZE 4200
> +#define SR1XX_MAX_TX_BUF_SIZE 4200
> +
> +#define MAX_RETRY_COUNT_FOR_IRQ_CHECK 100
> +#define MAX_RETRY_COUNT_FOR_HANDSHAKE 1000

Please use tabs.

> +/* Macro to define SPI clock frequency */
> +#define SR1XX_SPI_CLOCK 16000000L
> +#define WAKEUP_SRC_TIMEOUT (2000)
> +
> +/* Maximum UCI packet size supported from the driver */
> +#define MAX_UCI_PKT_SIZE 4200
> +
> +/* Device specific macro and structure */
> +struct sr1xx_dev {
> +	wait_queue_head_t read_wq; /* Wait queue for read interrupt */
> +	struct spi_device *spi; /* Spi device structure */
> +	struct miscdevice sr1xx_device; /* Char device as misc driver */
> +	unsigned int ce_gpio; /* SW reset gpio */
> +	unsigned int irq_gpio; /* SR1XX will interrupt host for any ntf */
> +	unsigned int spi_handshake_gpio; /* Host ready to read data */
> +	bool irq_enabled; /* Flag to indicate disable/enable irq sequence */
> +	bool irq_received; /* Flag to indicate that irq is received */
> +	spinlock_t irq_enabled_lock; /* Spin lock for read irq */
> +	unsigned char *tx_buffer; /* Transmit buffer */
> +	unsigned char *rx_buffer; /* Receive buffer */
> +	unsigned int write_count; /* Holds nubers of byte written */
> +	unsigned int read_count; /* Hold nubers of byte read */
> +	struct mutex
> +		sr1xx_access_lock; /* Lock used to synchronize read and write */
> +	size_t total_bytes_to_read; /* Total bytes read from the device */
> +	bool is_extended_len_bit_set; /* Variable to check ext payload Len */
> +	bool read_abort_requested; /* Used to indicate read abort request */
> +	bool is_fw_dwnld_enabled; /* Used to indicate fw download mode */
> +	int mode; /* Indicate write or read mode */
> +	long timeout_in_ms; /* Wait event interrupt timeout in ms */

If you want to document a structure (which is a good thing), please do
so in a way we can understand it (i.e. with kernel doc format like we do
everywhere else in the kernel), not like this which is almost impossible
to follow.

> +};
> +
> +enum spi_status_codes {
> +	TRANSCEIVE_SUCCESS,
> +	TRANSCEIVE_FAIL,
> +	IRQ_WAIT_REQUEST,
> +	IRQ_WAIT_TIMEOUT
> +};
> +
> +/* Spi write/read operation mode */
> +enum spi_operation_modes { SR1XX_WRITE_MODE, SR1XX_READ_MODE };

Why is this a global symbol?


> +static int sr1xx_dev_open(struct inode *inode, struct file *filp)
> +{
> +	struct sr1xx_dev *sr1xx_dev = container_of(
> +		filp->private_data, struct sr1xx_dev, sr1xx_device);
> +
> +	filp->private_data = sr1xx_dev;
> +	return 0;
> +}
> +
> +static void sr1xx_disable_irq(struct sr1xx_dev *sr1xx_dev)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sr1xx_dev->irq_enabled_lock, flags);
> +	if ((sr1xx_dev->irq_enabled)) {
> +		disable_irq_nosync(sr1xx_dev->spi->irq);
> +		sr1xx_dev->irq_received = true;
> +		sr1xx_dev->irq_enabled = false;
> +	}
> +	spin_unlock_irqrestore(&sr1xx_dev->irq_enabled_lock, flags);
> +}
> +
> +static void sr1xx_enable_irq(struct sr1xx_dev *sr1xx_dev)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&sr1xx_dev->irq_enabled_lock, flags);
> +	if (!sr1xx_dev->irq_enabled) {
> +		enable_irq(sr1xx_dev->spi->irq);
> +		sr1xx_dev->irq_enabled = true;
> +		sr1xx_dev->irq_received = false;
> +	}
> +	spin_unlock_irqrestore(&sr1xx_dev->irq_enabled_lock, flags);
> +}
> +
> +static irqreturn_t sr1xx_dev_irq_handler(int irq, void *dev_id)
> +{
> +	struct sr1xx_dev *sr1xx_dev = dev_id;
> +
> +	sr1xx_disable_irq(sr1xx_dev);
> +	/* Wake up waiting readers */
> +	wake_up(&sr1xx_dev->read_wq);
> +	if (device_may_wakeup(&sr1xx_dev->spi->dev))
> +		pm_wakeup_event(&sr1xx_dev->spi->dev, WAKEUP_SRC_TIMEOUT);
> +	return IRQ_HANDLED;
> +}
> +
> +static long sr1xx_dev_ioctl(struct file *filp, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	long ret = 0;
> +	struct sr1xx_dev *sr1xx_dev = NULL;
> +
> +	sr1xx_dev = filp->private_data;
> +	if (sr1xx_dev == NULL) {
> +		ret = -EINVAL;
> +		pr_err("%s sr1xx_dev is NULL\n", __func__);
> +		return ret;
> +	}
> +	switch (cmd) {
> +	case SR1XX_SET_PWR:
> +		if (arg == PWR_ENABLE) {
> +			gpio_set_value(sr1xx_dev->ce_gpio, 1);
> +			usleep_range(10000, 12000);
> +		} else if (arg == PWR_DISABLE) {
> +			gpio_set_value(sr1xx_dev->ce_gpio, 0);
> +			sr1xx_disable_irq(sr1xx_dev);
> +			usleep_range(10000, 12000);
> +		} else if (arg == ABORT_READ_PENDING) {
> +			sr1xx_dev->read_abort_requested = true;
> +			sr1xx_disable_irq(sr1xx_dev);
> +			/* Wake up waiting readers */
> +			wake_up(&sr1xx_dev->read_wq);
> +		}
> +		break;
> +	case SR1XX_SET_FWD:
> +		if (arg == 1) {
> +			sr1xx_dev->is_fw_dwnld_enabled = true;
> +			sr1xx_dev->read_abort_requested = false;
> +		} else if (arg == 0) {
> +			sr1xx_dev->is_fw_dwnld_enabled = false;
> +		}
> +		break;
> +	default:
> +		dev_err(&sr1xx_dev->spi->dev, " Error case");

So userspace can spam the kernel log by sending your driver invalid
ioctls?  Please never do that.

> +		ret = -EINVAL;

Isn't this the wrong error value for an incorrect ioctl command?

> +	}
> +	return ret;
> +}
> +
> +/**
> + * sr1xx_wait_for_irq_gpio_low
> + *
> + * Function to wait till irq gpio goes low state
> + *
> + */

Odd commenting style, please either use the correct kerneldoc format, or
a simpler one, or nothing at all.  Please do not make up your own format
style just for a single driver as that is unmaintainable, right?

Also, I see no justification here for why this has to be a kernel
driver, OR where the userspace code is that controls this.

I've stopped here :(

greg k-h
