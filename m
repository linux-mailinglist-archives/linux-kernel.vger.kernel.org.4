Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC33B64350B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiLET5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiLET50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:57:26 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E366C5A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:56:37 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h16so12248861qtu.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 11:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DQ4Qfz2NsvvDu1hC1Lq6rd0VF7bwPnzZEhEgZystJUs=;
        b=T/w+OLH7dQlwgIsmtrkXWteURv1lZWy6YxgLc4j/6J/qJTzIv7XnJML1hIew5AjC34
         /gpLdwRKpAr3aje1av5lTv9Fua++f4ROFdIlEDXgZ9P8RdBZ63PfNUUoFfi592fgPx76
         XVNvbmrzjyh+dTEuZS0pURB1Dpmgyp/fmuN0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQ4Qfz2NsvvDu1hC1Lq6rd0VF7bwPnzZEhEgZystJUs=;
        b=Xg25T5TA5UUWCPMRM0pZmfljxsAfiFsFuwggLT8gGxyAhCDYOQcdQf24QEL0kd6SzX
         QSDsZbdh44gsKIQTObm3pp7EK2xURZvOVtYxzlbILRvfj498tNAbxmKZsDAbpeyVFi6C
         vbxp89ul7jy2NrIPIoeHBE9DVU4E6rGP8aCI5iY46uABL+3hAKZZaAEFE4rLHsOca7fp
         B+HXL5W/hXrtd652RLlEBgxa8R0hNK004lzxVJXFcqb0VQeBxzolpGSJWnO14yf0ZHmB
         r1VAHE024vYa2IKHnXvpHnqv6P7AatIFm2MDelcAmV/KkzeQ4qHybE5sKurM2EP0cRVq
         JwBQ==
X-Gm-Message-State: ANoB5pnBUHoyuTz+/yrr0jimJq7KJDsJOVRbRQVZOTRTVWmIsmGMDeeD
        K9oL02+dX3TgK2cdk1c85WUCwAv+NmfYoAWed4eL2Q==
X-Google-Smtp-Source: AA0mqf51dRL5Um5ksGkVKI6eAGjDU2MyYa+M4fIDqCz/Cji2Sc91YnP4wF0l1ej8xLR0Km849jZNOBTgvXVpwNOi/kw=
X-Received: by 2002:a05:622a:1c1b:b0:39c:d5cd:848e with SMTP id
 bq27-20020a05622a1c1b00b0039cd5cd848emr64192988qtb.294.1670270196477; Mon, 05
 Dec 2022 11:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20221205001932.v9.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
In-Reply-To: <20221205001932.v9.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 5 Dec 2022 11:56:24 -0800
Message-ID: <CACeCKaerjLdGR_h_H=7+55mN31PUGJHAujfWXG2A3ELJTcnBMw@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] platform/chrome: cros_ec_uart: Add cros-ec-uart
 transport layer
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark and Bhanu,

On Dec 05 00:19, Mark Hasemeyer wrote:
> From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
>
>  obj-$(CONFIG_CROS_EC_TYPEC)          += cros_ec_typec.o
>  obj-$(CONFIG_CROS_EC_LPC)            += cros_ec_lpcs.o
> diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
> new file mode 100644
> index 0000000000000..4b416441f973c
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_uart.c
> @@ -0,0 +1,373 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UART interface for ChromeOS Embedded Controller
> + *
> + * Copyright 2020-2022 Google LLC.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/cros_ec_commands.h>
cros_ec_proto.h includes cros_ec_commmands.h [1], so explicitly
including it shouldn't be needed.

> + * @wait_queue:              Wait queue EC response where the cros_ec sends request
> + *                   to EC and waits
> + */
> +struct response_info {
> +     void *data;
> +     size_t max_size;
> +     size_t size;
> +     size_t exp_len;
> +     int error;
> +     bool received;
I suspect "received" and "error" can be combined into a single
variable. (The condition
in wait_event_*() can be a compound statement, not just a boolean variable).

> +static int cros_ec_uart_rx_bytes(struct serdev_device *serdev,
> +                              const u8 *data,
> +                              size_t count)
> +{
> +     struct ec_host_response *response;
> +     struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
> +     struct cros_ec_uart *ec_uart = ec_dev->priv;
> +
> +     /* Check if bytes were sent out of band */
This sounds like something that should generate a warning message...

> +     if (!ec_uart->response.data)
> +             /* Discard all bytes */
> +             return count;
> +
> +     /*
> +      * Check if incoming bytes + response.size is greater than allocated
> +      * buffer in din by cros_ec. This will ensure that if EC sends more
> +      * bytes than max_size, waiting process will be notified with an error.
> +      */
> +     if (ec_uart->response.size + count > ec_uart->response.max_size) {
> +             ec_uart->response.error = -EMSGSIZE;
> +             ec_uart->response.received = true;
> +             wake_up_interruptible(&ec_uart->response.wait_queue);
> +             return count;
> +     }
> +
> +     memcpy((void *)ec_uart->response.data + ec_uart->response.size,
> +                (void *)data, count);
Should be able to fit on 1 line (100 chars). Also, I don't believe the casts are
necessary.

> +
> +     ec_uart->response.size += count;
> +
> +     /*
> +      * Read data_len if we received response header and if exp_len
> +      * was not read before.
> +      */
> +     if (ec_uart->response.size >= sizeof(*response) &&
> +             ec_uart->response.exp_len == 0) {
Please align clauses within the if condition parentheses.

> +             response = (struct ec_host_response *)
> +                                             ec_uart->response.data;
Should be able to fit on 1 line (100 chars).

> +
> +             ec_uart->response.exp_len = response->data_len +
> +                     sizeof(*response);
Should be able to fit on 1 line (100 chars).

> +     }
> +
> +     /*
> +      * If driver received response header and payload from EC,
> +      * Wake up the wait queue.
> +      */
> +     if (ec_uart->response.size >= sizeof(*response) &&
> +             ec_uart->response.size == ec_uart->response.exp_len) {
Please align clauses within the if condition parentheses.

> +             ec_uart->response.received = true;
> +             wake_up_interruptible(&ec_uart->response.wait_queue);
> +     }
> +
> +     return count;
> +}
> +
> +static int cros_ec_uart_pkt_xfer(struct cros_ec_device *ec_dev,
> +                              struct cros_ec_command *ec_msg)
> +{
> +     struct cros_ec_uart *ec_uart = ec_dev->priv;
> +     struct serdev_device *serdev = ec_uart->serdev;
> +     struct ec_host_response *response;
> +     unsigned int len;
> +     int ret, i;
> +     u8 sum = 0;
> +
> +     len = cros_ec_prepare_tx(ec_dev, ec_msg);
> +     dev_dbg(ec_dev->dev, "Prepared len=%d\n", len);
> +
> +     /* Setup for incoming response */
> +     ec_uart->response.data = ec_dev->din;
> +     ec_uart->response.max_size = ec_dev->din_size;
> +     ec_uart->response.size = 0;
> +     ec_uart->response.error = 0;
> +     ec_uart->response.exp_len = 0;
> +     ec_uart->response.received = false;
> +
> +     ret = serdev_device_write_buf(serdev, ec_dev->dout, len);
> +     if (ret < len) {
> +             dev_err(ec_dev->dev, "Unable to write data");
> +             ret = -EIO;
> +             goto exit;
> +     }
> +
> +     /* Once request is successfully sent to EC, wait to wait_queue */
Superfluous comment.

> +     ret = wait_event_interruptible_timeout(ec_uart->response.wait_queue,
> +                                      ec_uart->response.received,
> +                                      msecs_to_jiffies(EC_MSG_DEADLINE_MS));
Is there any reason wait_event_timeout() is not sufficient? Which
signals/interrupt are you
expecting to receive that isn't handled by the rest of the code?

> +     if (ret < 0) {
> +             dev_warn(ec_dev->dev, "Interrupted waiting for response.\n");
> +             goto exit;
> +     } else if (ret == 0) {
> +             dev_warn(ec_dev->dev, "Timed out waiting for response.\n");
> +             ret = -ETIMEDOUT;
> +             goto exit;
> +     }
> +
> +     if (ec_uart->response.error < 0) {
> +             dev_warn(ec_dev->dev, "Response error detected.\n");
> +             ret = ec_uart->response.error;
> +             goto exit;
> +     }
> +
> +     response = (struct ec_host_response *)ec_dev->din;
> +     ec_msg->result = response->result;
> +
> +     if (response->data_len > ec_msg->insize) {
> +             dev_err(ec_dev->dev, "Resp too long (%d bytes, expected %d)",
> +                     response->data_len,
> +                     ec_msg->insize);
> +             ret = -ENOSPC;
> +             goto exit;
> +     }
> +
> +     /* Validate checksum */
> +     for (i = 0; i < sizeof(*response) + response->data_len; i++)
> +             sum += ec_dev->din[i];
> +
> +     if (sum) {
> +             dev_err(ec_dev->dev, "Bad packet checksum calculated %x\n", sum);
> +             ret = -EBADMSG;
> +             goto exit;
> +     }
> +
> +     memcpy(ec_msg->data,
> +            ec_dev->din + sizeof(*response),
> +            response->data_len);
Should be able to fit on 1 line (100 chars).

> +
> +     ret = response->data_len;
> +
> +exit:
> +     /* Invalidate response buffer to guard against out of band rx data */
> +     ec_uart->response.data = NULL;
> +
> +     if (ec_msg->command == EC_CMD_REBOOT_EC)
> +             msleep(EC_REBOOT_DELAY_MS);
> +
> +     return ret;
> +}
> +
> +static int cros_ec_uart_resource(struct acpi_resource *ares, void *data)
> +{
> +     struct cros_ec_uart *ec_uart = data;
> +     struct acpi_resource_uart_serialbus *sb = &ares->data.uart_serial_bus;
> +
> +     if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS &&
> +                     sb->type == ACPI_RESOURCE_SERIAL_TYPE_UART) {
> +             ec_uart->baudrate = sb->default_baud_rate;
> +             dev_dbg(&ec_uart->serdev->dev, "Baudrate %d\n",
> +                     ec_uart->baudrate);
Should be able to fit on 1 line (100 chars).

> +
> +             ec_uart->flowcontrol = sb->flow_control;
> +             dev_dbg(&ec_uart->serdev->dev, "Flow control %d\n",
> +                     ec_uart->flowcontrol);
Should be able to fit on 1 line (100 chars).

> +     }
> +
> +     return 0;
> +}
> +
> +static int cros_ec_uart_acpi_probe(struct cros_ec_uart *ec_uart)
> +{
> +     int ret;
> +     LIST_HEAD(resources);
> +     struct acpi_device *adev = ACPI_COMPANION(&ec_uart->serdev->dev);
> +
> +     ret = acpi_dev_get_resources(adev, &resources,
> +                                  cros_ec_uart_resource, ec_uart);
Should be able to fit on 1 line (100 chars).

> +     if (ret < 0)
> +             return ret;
> +
> +     acpi_dev_free_resource_list(&resources);
> +
> +     /* Retrieve GpioInt and translate it to Linux IRQ number */
> +     ret = acpi_dev_gpio_irq_get(adev, 0);
> +     if (ret < 0)
> +             return ret;
> +
> +     ec_uart->irq = ret;
> +     dev_dbg(&ec_uart->serdev->dev, "IRQ number %d\n", ec_uart->irq);
> +
> +     return 0;
> +}
> +
> +static const struct serdev_device_ops cros_ec_uart_client_ops = {
> +     .receive_buf = cros_ec_uart_rx_bytes,
> +};
> +
> +static int cros_ec_uart_probe(struct serdev_device *serdev)
> +{
> +     struct device *dev = &serdev->dev;
> +     struct cros_ec_device *ec_dev;
> +     struct cros_ec_uart *ec_uart;
> +     int ret;
> +
> +     ec_uart = devm_kzalloc(dev, sizeof(*ec_uart), GFP_KERNEL);
> +     if (!ec_uart)
> +             return -ENOMEM;
> +
> +     ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
> +     if (!ec_dev)
> +             return -ENOMEM;
> +
> +     ec_uart->serdev = serdev;
> +
> +     ret = devm_serdev_device_open(dev, ec_uart->serdev);
> +     if (ret) {
> +             dev_err(dev, "Unable to open UART device");
> +             return ret;
> +     }
> +
> +     serdev_device_set_drvdata(serdev, ec_dev);
> +     serdev_device_set_client_ops(serdev, &cros_ec_uart_client_ops);
> +     init_waitqueue_head(&ec_uart->response.wait_queue);
> +
> +     ret = cros_ec_uart_acpi_probe(ec_uart);
> +     if (ret < 0) {
> +             dev_err(dev, "Failed to get ACPI info (%d)", ret);
> +             return ret;
> +     }
> +
> +     ret = serdev_device_set_baudrate(serdev, ec_uart->baudrate);
> +     if (ret < 0) {
> +             dev_err(dev, "Failed to set up host baud rate (%d)", ret);
> +             return ret;
> +     }
> +
> +     serdev_device_set_flow_control(serdev, ec_uart->flowcontrol);
> +
> +     /* Initialize ec_dev for cros_ec  */
> +     ec_dev->phys_name = dev_name(dev);
> +     ec_dev->dev = dev;
> +     ec_dev->priv = ec_uart;
> +     ec_dev->irq = ec_uart->irq;
> +     ec_dev->cmd_xfer = NULL;
> +     ec_dev->pkt_xfer = cros_ec_uart_pkt_xfer;
> +     ec_dev->din_size = sizeof(struct ec_host_response) +
> +                        sizeof(struct ec_response_get_protocol_info);
> +     ec_dev->dout_size = sizeof(struct ec_host_request);
> +
> +     return cros_ec_register(ec_dev);
> +}
> +
> +static void cros_ec_uart_remove(struct serdev_device *serdev)
> +{
> +     struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
> +
> +     cros_ec_unregister(ec_dev);
> +};
> +
> +static int __maybe_unused cros_ec_uart_suspend(struct device *dev)
> +{
> +     struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> +
> +     return cros_ec_suspend(ec_dev);
> +}
> +
> +static int __maybe_unused cros_ec_uart_resume(struct device *dev)
> +{
> +     struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> +
> +     return cros_ec_resume(ec_dev);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(cros_ec_uart_pm_ops, cros_ec_uart_suspend,
> +                      cros_ec_uart_resume);
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id cros_ec_uart_acpi_id[] = {
> +     { "GOOG0019", 0 },
> +     { /* sentinel */ }
nit: Other ACPI drivers in this directory don't use the word "sentinel",
so it seems like just "{}" should be sufficient.

Best regards,

-Prashant

[1] https://elixir.bootlin.com/linux/v6.1-rc8/source/include/linux/platform_data/cros_ec_proto.h#L15
