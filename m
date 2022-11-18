Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E98A62ED44
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbiKRFoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiKRFn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:43:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC9E205F9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:43:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B61BB82288
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246CCC433C1;
        Fri, 18 Nov 2022 05:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668750231;
        bh=+srVP62Qc6AZlmM+x1U/pSak2JmtBcYvBY53cvSr4DI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTKF5p2UKumH0WtQ8gRFtAiobdRyFm0hOiRoj3bjkSB0sORYmLerqhVBNJjLyevLr
         2bhaqmfhPdWGnPbiTNLNsFkEN8wMiFA2N1vkqbeGAVa/Uogmeubp1wPpWcjtgG6+h2
         ccM1J80Og1L3brJZsXtu079RaE6NWoLBFpD/fTLMf1JDZysVxfXt0jodWi3DaMdVcy
         QS1G8qYlgKPIhniyolQzomc0mpqo8OAJpxXieY/GGCiTNVAcZmHE5AMTYiBbG3nWnG
         xCCmfmKS97jK93HT0qBu2+SzJXI7k+TzHMAKaWXM3MAN//b81SLV4z1gti9mHC4bsO
         G8UW3vEN8I+yg==
Date:   Fri, 18 Nov 2022 13:43:47 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v7 1/3] platform/chrome: cros_ec_uart: Add cros-ec-uart
 transport layer
Message-ID: <Y3cbk3dEuRWyJh40@google.com>
References: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:48:46AM -0700, Mark Hasemeyer wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
[...]
> +CHROMEOS EC UART DRIVER
> +M:	Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> +R:	Enric Balletbo i Serra <enric.balletbo@collabora.com>

I think the address is no longer reachable.

> diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
[...]
> + * Copyright 2020 Google LLC.

Any concerns if it uses 2022?

> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/serdev.h>
> +#include <linux/slab.h>
> +#include <uapi/linux/sched/types.h>

To be neat, please sort them.

> +/**
> + * struct response_info - Encapsulate EC response related
> + *			information for passing between function
> + *			cros_ec_uart_pkt_xfer() and cros_ec_uart_rx_bytes()
> + *			callback.
> + * @data:		Copy the data received from EC here.
> + * @max_size:		Max size allocated for the @data buffer. If the
> + *			received data exceeds this value, we log an error.
> + * @size:		Actual size of data received from EC. This is also
> + *			used to accumulate byte count with response is received
> + *			in dma chunks.
> + * @exp_len:		Expected bytes of response from EC including header.
> + * @error:		0 for success, negative error code for a failure.
> + * @received:		Set to true on receiving a valid EC response.
> + * @wait_queue:		Wait queue EC response where the cros_ec sends request
> + *			to EC and waits
> + */
> +struct response_info {
> +	void *data;
> +	size_t max_size;
> +	size_t size;
> +	int error;
> +	size_t exp_len;
> +	bool received;
> +	wait_queue_head_t wait_queue;
> +};

To be neat, please swap `error` and `exp_len` to maintain the order with
the kernel-doc.

> +struct cros_ec_uart {
> +	struct serdev_device *serdev;
> +	u32 baudrate;
> +	u8  flowcontrol;

To be neat, please remove the extra space.

> +static int cros_ec_uart_pkt_xfer(struct cros_ec_device *ec_dev,
> +				 struct cros_ec_command *ec_msg)
> +{
[...]
> +	/* Prepare an outgoing message in the output buffer */
> +	len = cros_ec_prepare_tx(ec_dev, ec_msg);
> +	dev_dbg(ec_dev->dev, "Prepared len=%d\n", len);
> +
[...]
> +	/* Write serial device buffer */
> +	ret = serdev_device_write_buf(serdev, ec_dev->dout, len);
> +	if (ret < len) {
> +		dev_err(&serdev->dev,

To be neat, please use `ec_dev->dev`.

> +			"Unable to write data to serial device %s",
> +			dev_name(&serdev->dev));

To be neat, please use `ec_dev->dev`.  Also, I guess the info can be
dropped as it is already an dev_err().

> +	/* Check if wait_queue was interrupted due to an error */
> +	if (ec_uart->response.error < 0) {
> +		dev_warn(&serdev->dev, "Response error detected.\n");

To be neat, please use `ec_dev->dev`.

> +	/* Check if valid response was received or there was a timeout */
> +	if (!ec_uart->response.received) {
> +		dev_warn(&serdev->dev, "EC failed to respond in time.\n");

To be neat, please use `ec_dev->dev`.

> +	/* Copy response packet to ec_msg data buffer */
> +	memcpy(ec_msg->data,
> +	       ec_dev->din + sizeof(*response),
> +	       response->data_len);
> +
> +	/* Add all response header bytes for checksum calculation */
> +	for (i = 0; i < sizeof(*response); i++)
> +		sum += ec_dev->din[i];
> +
> +	/* Copy response packet payload and compute checksum */
> +	for (i = 0; i < response->data_len; i++)
> +		sum += ec_msg->data[i];

The 2 loops can be combined, e.g.:
for (i = 0; i < sizeof(*response) + response->data_len; i++)

> +static int cros_ec_uart_probe(struct serdev_device *serdev)
> +{
> +	struct device *dev = &serdev->dev;
[...]
> +	/* Open the serial device */
> +	ret = devm_serdev_device_open(dev, ec_uart->serdev);
> +	if (ret) {
> +		dev_err(dev, "Unable to open UART device %s",
> +			dev_name(&serdev->dev));

To be concise, please use `dev`.  Also I think the info can be
dropped as it is already an dev_err().

> +	/* Initialize ec_dev for cros_ec  */
> +	ec_dev->phys_name = dev_name(&ec_uart->serdev->dev);

To be concise, please use `dev`.
