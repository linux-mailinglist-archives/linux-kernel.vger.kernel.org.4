Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7453363F99A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiLAVMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiLAVMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:12:30 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0F2BEE1D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:12:27 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id a27so2600221qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YboyJNTl6gVEyA49/Km8DHcaras/4eEp/QyH+Q8nh7o=;
        b=L/hHvzdNc1juw9OW7ZjpgJ2k7uUzlQ3xDNVj+0AMzvzMAKraP4EvcjnCHseD4IFA0p
         rYsh9Gu1KLHF+CkLg5ZGLzzSW4WTqwvqkv2aLEIvkG+/sgP/k/f5FlrGbh3lJ2vEW8Px
         LPw7Ykt24QJUGiKNFTd87p+raULJRBiBJ59pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YboyJNTl6gVEyA49/Km8DHcaras/4eEp/QyH+Q8nh7o=;
        b=h16iQt3TbdavYMroeWoFPkFWIYYeW+h1xkVkKCohgcGi0e3gPHKuNUwfplq+woJ5yC
         P5gF12Fi86whr7W1hrLXhhUXES+hjrQE4Rhv56lsdaok7wbvT2RJssnREDpthAu/aN5J
         JMrZcDzabTonyHCdRgjsSj5pItdYG7pij4AjG+vAII9cr+5PKXTYeD0UQOop60qmUsTZ
         MBQtZoA6VN3Kq0yUrPO5aY7fnXjgdiHyxpYvWkEpUqOlqqr4EDa+0onrflBgxCMiswOI
         okg5Q4iLElky2fg6DdZ266SWf5JTIvL+621t6k9bGPuF7nlr15NOuz49Sa5oYNtH+pl0
         Luwg==
X-Gm-Message-State: ANoB5pljoSjt2b5QMCMA7TgNF1ccFz2rKZ7hREoipRBLVV0TmLADOLAS
        BdTjJ20k1T6UlmC5VDMMCjl8WxE274DBfpyeWNhj0w==
X-Google-Smtp-Source: AA0mqf5/ysn5rPAgH6DKMK09B0BfpS9iV7B7NFtcHptryDKmRcnGiSncOtAQow0jLYkgFSNHPVMRJrGOQfhKpGjNL1U=
X-Received: by 2002:a05:620a:c09:b0:6fc:6954:f63d with SMTP id
 l9-20020a05620a0c0900b006fc6954f63dmr23621401qki.691.1669929146350; Thu, 01
 Dec 2022 13:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20221130131245.v8.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
In-Reply-To: <20221130131245.v8.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 1 Dec 2022 13:12:15 -0800
Message-ID: <CACeCKacHWPVv=sDo5-VjpckvvFw6YmqvXCyLqzgbXBmG080mmw@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] platform/chrome: cros_ec_uart: Add cros-ec-uart
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

Hi,

On Wed, Nov 30, 2022 at 12:13 PM Mark Hasemeyer <markhas@chromium.org> wrote:
>
> This patch does following:
> 1. Adds a new cros-ec-uart driver. This driver can send EC requests on
>    UART and process response packets received on UART transport.
> 2. Once probed, this driver will initialize the serdev device based on
>    the underlying information in the ACPI resource. After serdev device
>    properties are set, this driver will register itself cros-ec.
> 3. High level driver can use this implementation to talk to ChromeOS
>    Embedded Controller device in case it supports UART as transport.
> 4. When cros-ec driver initiates a request packet, outgoing message is
>    processed in buffer and sent via serdev. Once bytes are sent, driver
>    enables a wait_queue.
> 5. Since ChromeOS EC device sends response asynchronously, AP's TTY
>    driver accumulates response bytes and calls the registered callback.
>    TTY driver can send multiple callback for bytes ranging from 1 to MAX
>    bytes supported by EC device.
> 6. Driver waits for EC_MSG_DEADLINE_MS to collect and process received
>    bytes. It wakes wait_queue if expected bytes are received or else
>    wait_queue timeout. Based on the error condition, driver returns
>    data_len or error to cros_ec.
>
> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
>
> Changes in v8:
> - Combine for loops used for xsum calculation
> - Use ec_dev->dev instead of serdev->dev
> - Sort includes
> - Swap struct var order to match doc order
> - fix whitespace
> - Update contact information in MAINTAINERS
> - Update copyright date
>
> Changes in v7:
> - Use ACPI ID matching
> - Change MODULE_LICENSE from GPL v2 to GPL
>
> Changes in v6:
> - Tuning EC_MSG_DEADLINE_MS from 1 sec to 500 msec. Since the EC's UART
>   response buffer was tuned and redeuced to 256 byte, 500 msec timeout
>   should give enough time for 256 bytes to be recieved from SoC  UART
>   buffer.
>
> Changes in v5:
> - Fixed checkpatch.pl warnings.
>
> Changes in v4:
> - Change EC_MSG_DEADLINE_MS from 3 secs to 1 sec. 3 secs timeout prevents
>   driver from intercepting EC in RO stage. In case of request failure, 1
>   sec allows driver to retry and send HC when EC is in RO.
> - Add more information in commit message.
>
> Changes in v3:
> - checkpatch.pl script warns about char len 80 even though we have
>   relaxed view guideline for line below 100 chars. Currently sticking
>   with 80 chars in v3.
> - Fixed style issues
>
> Changes in v2:
> - Fixed build error on v1.
> - Changed EC timeout for response packet to 3 Sec and added comments.
> - Fixed cros_ec_uart_rx_bytes function to handle rx buffer < size of response header.
>
> ---
>  MAINTAINERS                            |   7 +
>  drivers/platform/chrome/Kconfig        |  10 +
>  drivers/platform/chrome/Makefile       |   1 +
>  drivers/platform/chrome/cros_ec_uart.c | 411 +++++++++++++++++++++++++
>  4 files changed, 429 insertions(+)
>  create mode 100644 drivers/platform/chrome/cros_ec_uart.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2585e7edc3358..8ed08316fd11e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4918,6 +4918,13 @@ S:       Maintained
>  F:     Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
>  F:     sound/soc/codecs/cros_ec_codec.*
>
> +CHROMEOS EC UART DRIVER
> +M:     Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> +R:     Benson Leung <bleung@google.com>
> +R:     Tzung-Bi Shih <tzungbi@kernel.org>
> +S:     Maintained
> +F:     drivers/platform/chrome/cros_ec_uart.c
> +
>  CHROMEOS EC SUBDRIVERS
>  M:     Benson Leung <bleung@chromium.org>
>  R:     Guenter Roeck <groeck@chromium.org>
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 6b954c5acadb1..d4a95ec261ed3 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -119,6 +119,16 @@ config CROS_EC_SPI
>           response time cannot be guaranteed, we support ignoring
>           'pre-amble' bytes before the response actually starts.
>
> +config CROS_EC_UART
> +       tristate "ChromeOS Embedded Controller (UART)"
> +       depends on CROS_EC && ACPI && SERIAL_DEV_BUS
> +       help
> +         If you say Y here, you get support for talking to the ChromeOS EC
> +         through a UART, using a byte-level protocol.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called cros_ec_uart.
> +
>  config CROS_EC_LPC
>         tristate "ChromeOS Embedded Controller (LPC)"
>         depends on CROS_EC && ACPI && (X86 || COMPILE_TEST)
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 2950610101f15..6f5b6f01940db 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_CROS_EC_ISHTP)           += cros_ec_ishtp.o
>  obj-$(CONFIG_CROS_TYPEC_SWITCH)                += cros_typec_switch.o
>  obj-$(CONFIG_CROS_EC_RPMSG)            += cros_ec_rpmsg.o
>  obj-$(CONFIG_CROS_EC_SPI)              += cros_ec_spi.o
> +obj-$(CONFIG_CROS_EC_UART)             += cros_ec_uart.o
>  cros_ec_lpcs-objs                      := cros_ec_lpc.o cros_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_TYPEC)            += cros_ec_typec.o
>  obj-$(CONFIG_CROS_EC_LPC)              += cros_ec_lpcs.o
> diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
> new file mode 100644
> index 0000000000000..ef9ac7ace04b6
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_uart.c
> @@ -0,0 +1,411 @@
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
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/serdev.h>
> +#include <linux/slab.h>
> +#include <uapi/linux/sched/types.h>
> +
> +#include "cros_ec.h"
> +
> +/*
> + * EC sends contiguous bytes of response packet on UART AP RX.
> + * TTY driver in AP accumulates incoming bytes and calls the registered callback
> + * function. Byte count can range from 1 to MAX bytes supported by EC.
> + * This driver should wait for long time for all callbacks to be processed.
> + * Considering the worst case scenario, wait for 500 msec. This timeout should
> + * account for max latency and some additional guard time.
> + * Best case: Entire packet is received in ~200 ms, wait queue will be released
> + * and packet will be processed.
> + * Worst case: TTY driver sends bytes in multiple callbacks. In this case this
> + * driver will wait for ~1 sec beyond which it will timeout.
> + * This timeout value should not exceed ~500 msec because in case if
> + * EC_CMD_REBOOT_EC sent, high level driver should be able to intercept EC
> + * in RO.
> + */
> +#define EC_MSG_DEADLINE_MS             500
> +
> +/**
> + * struct response_info - Encapsulate EC response related
> + *                     information for passing between function
> + *                     cros_ec_uart_pkt_xfer() and cros_ec_uart_rx_bytes()
> + *                     callback.
> + * @data:              Copy the data received from EC here.
> + * @max_size:          Max size allocated for the @data buffer. If the
> + *                     received data exceeds this value, we log an error.
> + * @size:              Actual size of data received from EC. This is also
> + *                     used to accumulate byte count with response is received
> + *                     in dma chunks.
> + * @exp_len:           Expected bytes of response from EC including header.
> + * @error:             0 for success, negative error code for a failure.
> + * @received:          Set to true on receiving a valid EC response.
> + * @wait_queue:                Wait queue EC response where the cros_ec sends request
> + *                     to EC and waits
> + */
> +struct response_info {
> +       void *data;
> +       size_t max_size;
> +       size_t size;
> +       size_t exp_len;
> +       int error;
> +       bool received;
> +       wait_queue_head_t wait_queue;
> +};
> +
> +/**
> + * struct cros_ec_uart - information about a uart-connected EC
> + *
> + * @serdev_device:     serdev uart device we are connected to.
> + * @baudrate:          UART baudrate of attached EC device.
> + * @flowcontrol:       UART flowcontrol of attached device.
> + * @irq:               Linux IRQ number of associated serial device.
> + * @response:          Response info passing between cros_ec_uart_pkt_xfer()
> + *                     and cros_ec_uart_rx_bytes()
> + */
> +struct cros_ec_uart {
> +       struct serdev_device *serdev;
> +       u32 baudrate;
> +       u8 flowcontrol;
> +       u32 irq;
> +       struct response_info response;
> +};
> +
> +static int cros_ec_uart_rx_bytes(struct serdev_device *serdev,
> +                                const u8 *data,
> +                                size_t count)
> +{
> +       struct ec_host_response *response;
> +       struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
> +       struct cros_ec_uart *ec_uart = ec_dev->priv;
> +
> +       /* Check if bytes were sent out of band */
> +       if (!ec_uart->response.data)
> +               /* Discard all bytes */
> +               return count;
> +
> +       /*
> +        * Check if incoming bytes + response.size are less than allocated
> +        * buffer in din by cros_ec. This will ensure that if EC sends more
> +        * bytes than max_size, waiting process will be notified with an error.
> +        */

Please try to avoid over-commenting (here and elsewhere in the file)
[1]; it shouldn't
be necessary to comment every block of code, where the intention can be surmised
purely by looking at the code.

> +       if (ec_uart->response.size + count <= ec_uart->response.max_size) {
> +               /* Copy bytes in data in buffer */
This comment seems unnecessary.
> +               memcpy((void *)ec_uart->response.data + ec_uart->response.size,
> +                      (void *)data, count);
> +
> +               /* Add incoming bytes in size */
> +               ec_uart->response.size += count;
> +
> +               /*
> +                * Read data_len if we received response header and if exp_len
> +                * was not read before.
> +                */
> +               if (ec_uart->response.size >= sizeof(*response) &&
> +                   ec_uart->response.exp_len == 0) {
> +                       /* Get expected response length from response header */
> +                       response = (struct ec_host_response *)
> +                                                       ec_uart->response.data;
> +
> +                       ec_uart->response.exp_len = response->data_len +
> +                               sizeof(*response);
> +               }
> +
> +               /*
> +                * If driver received response header and payload from EC,
> +                * Wake up the wait queue.
> +                */
> +               if (ec_uart->response.size >= sizeof(*response) &&
> +                   ec_uart->response.size == ec_uart->response.exp_len) {
> +                       /* Set flag before waking up the caller */
> +                       ec_uart->response.received = true;
> +
> +                       /* Wake the calling thread */
> +                       wake_up_interruptible(&ec_uart->response.wait_queue);
> +               }

You can save 1 level of indentation by inverting the if block and making it a
guard clause:
           if (ec_uart->response_size + count > ec_uart->response_max_size) {
                   ec_uart->response.error = -EMSGSIZE;
                   wake_up_interruptible(...);
                   return;
           }
           memcpy(...);
           ec_uart->response.size += count;

> +       } else {
> +               /* Received bytes are more the allocated buffer*/
> +               ec_uart->response.error = -EMSGSIZE;
> +
> +               /* Wake the calling thread */

Same issue as earlier. There is no need to add a comment for single lines
like these where what is happening is obvious.

> +               wake_up_interruptible(&ec_uart->response.wait_queue);
> +       }
> +
> +       return count;
> +}
> +
> +static int cros_ec_uart_pkt_xfer(struct cros_ec_device *ec_dev,
> +                                struct cros_ec_command *ec_msg)
> +{
> +       struct cros_ec_uart *ec_uart = ec_dev->priv;
> +       struct serdev_device *serdev = ec_uart->serdev;
> +       struct ec_host_response *response;
> +       unsigned int len;
> +       int ret, i;
> +       u8 sum = 0;
> +
> +       /* Prepare an outgoing message in the output buffer */

Superfluous comment.

> +       len = cros_ec_prepare_tx(ec_dev, ec_msg);
> +       dev_dbg(ec_dev->dev, "Prepared len=%d\n", len);
> +
> +       /* Setup for incoming response */
> +       ec_uart->response.data = ec_dev->din;
> +       ec_uart->response.max_size = ec_dev->din_size;
> +       ec_uart->response.size = 0;
> +       ec_uart->response.error = 0;
> +       ec_uart->response.exp_len = 0;
> +       ec_uart->response.received = false;
> +
> +       /* Write serial device buffer */
Superfluous comment.
> +       ret = serdev_device_write_buf(serdev, ec_dev->dout, len);
> +       if (ret < len) {
> +               dev_err(ec_dev->dev, "Unable to write data");
> +
> +               /* Return EIO as controller had issues writing buffer */
> +               ret = -EIO;
> +               goto exit;
> +       }
> +
> +       /* Once request is successfully sent to EC, wait to wait_queue */
> +       wait_event_interruptible_timeout(ec_uart->response.wait_queue,
> +                                        ec_uart->response.received,
> +                                        msecs_to_jiffies(EC_MSG_DEADLINE_MS));
wait_event_interruptible_timeout() returns a value indicating if a
timeout occurred
and/or if the condition evaluated to true[3]. Can that not be used here, instead
of re-writing the timeout/error check mechanism?

> +
> +       /* Check if wait_queue was interrupted due to an error */
> +       if (ec_uart->response.error < 0) {
> +               dev_warn(ec_dev->dev, "Response error detected.\n");
> +
> +               ret = ec_uart->response.error;
> +               goto exit;
> +       }
> +
> +       /* Check if valid response was received or there was a timeout */
> +       if (!ec_uart->response.received) {
> +               dev_warn(ec_dev->dev, "EC failed to respond in time.\n");
> +
> +               ret = -ETIMEDOUT;
> +               goto exit;
> +       }
> +
> +       /* Check response error code */
> +       response = (struct ec_host_response *)ec_dev->din;
> +       ec_msg->result = response->result;
> +
> +       /* Check if received response is longer than expected */
> +       if (response->data_len > ec_msg->insize) {
> +               dev_err(ec_dev->dev, "Resp too long (%d bytes, expected %d)",
> +                       response->data_len,
> +                       ec_msg->insize);
> +               ret = -ENOSPC;
> +               goto exit;
> +       }
> +
> +       /* Validate checksum */
> +       for (i = 0; i < sizeof(*response) + response->data_len; i++)
> +               sum += ec_dev->din[i];
> +
> +       if (sum) {
> +               dev_err(ec_dev->dev,
> +                       "Bad packet checksum calculated %x\n",
> +                       sum);
Line length allowances are 100 chars now [2]. I think this should fit on 1 line.
> +               ret = -EBADMSG;
> +               goto exit;
> +       }
> +
> +       /* Copy response packet to ec_msg data buffer */
Superfluous comment.
> +       memcpy(ec_msg->data,
> +              ec_dev->din + sizeof(*response),
> +              response->data_len);
> +
> +       /* Return data_len to cros_ec */
> +       ret = response->data_len;
> +
> +exit:
> +       /* Reset ec_uart */
> +       ec_uart->response.data = NULL;
> +       ec_uart->response.max_size = 0;
> +       ec_uart->response.size = 0;
> +       ec_uart->response.error = 0;
> +       ec_uart->response.exp_len = 0;
> +       ec_uart->response.received = false;
Sorry if I'm missing something, but are you expecting some other access to these
variables (before the next call to cros_ec_uart_pkt_xfer()) ?

If not, we shouldn't need to reset everything here (re-initializing it
on the next
call to cros_ec_uart_pkt_xfer() should be sufficient)

> +
> +       if (ec_msg->command == EC_CMD_REBOOT_EC)
> +               msleep(EC_REBOOT_DELAY_MS);
> +
> +       return ret;
> +}
> +
> +static int cros_ec_uart_resource(struct acpi_resource *ares, void *data)
> +{
> +       struct cros_ec_uart *ec_uart = data;
> +       struct acpi_resource_uart_serialbus *sb;
> +
> +       switch (ares->type) {
> +       case ACPI_RESOURCE_TYPE_SERIAL_BUS:
> +               sb = &ares->data.uart_serial_bus;
> +               if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_UART) {
> +                       ec_uart->baudrate = sb->default_baud_rate;
> +                       dev_dbg(&ec_uart->serdev->dev, "Baudrate %d\n",
> +                               ec_uart->baudrate);
> +
> +                       ec_uart->flowcontrol = sb->flow_control;
> +                       dev_dbg(&ec_uart->serdev->dev, "Flow control %d\n",
> +                               ec_uart->flowcontrol);
> +               }
> +               break;
> +       default:
> +               break;
> +       }
Is a switch necessary here? An if statement could accomplish the same thing
        struct cros_ec_uart *ec_uart = data;
        struct acpi_resource_uart_serialbus *sb = &ares->data.uart_serial_bus;
        if (ares->type == ACPI_RESOURCE_TYPEC_SERIAL_BUS &&
           sb->type == ACPI_RESOURCE_SERIAL_TYPE_UART) {
               ec_uart->baudrate = sb->default_baud_rate;
               ....
       }
> +
> +       return 0;
> +}
> +
> +static int cros_ec_uart_acpi_probe(struct cros_ec_uart *ec_uart)
> +{
> +       LIST_HEAD(resources);
> +       struct acpi_device *adev = ACPI_COMPANION(&ec_uart->serdev->dev);
> +       int ret;
It's not a strict requirement, but it's always nice to list the
initializer list in decreasing  (or
increasing) order of line length;
> +
> +       /* Retrieve UART ACPI info */
Unnecessary comment.
> +       ret = acpi_dev_get_resources(adev, &resources,
> +                                    cros_ec_uart_resource, ec_uart);
> +       if (ret < 0)
> +               return ret;
> +
> +       acpi_dev_free_resource_list(&resources);
> +
> +       /* Retrieve GpioInt and translate it to Linux IRQ number */
> +       ret = acpi_dev_gpio_irq_get(adev, 0);
> +       if (ret < 0)
> +               return ret;
> +
> +       ec_uart->irq = ret;
> +       dev_dbg(&ec_uart->serdev->dev, "IRQ number %d\n", ec_uart->irq);
> +
> +       return 0;
> +}
> +
> +static const struct serdev_device_ops cros_ec_uart_client_ops = {
> +       .receive_buf = cros_ec_uart_rx_bytes,
> +};
> +
> +static int cros_ec_uart_probe(struct serdev_device *serdev)
> +{
> +       struct device *dev = &serdev->dev;
> +       struct cros_ec_device *ec_dev;
> +       struct cros_ec_uart *ec_uart;
> +       int ret;
> +
> +       ec_uart = devm_kzalloc(dev, sizeof(*ec_uart), GFP_KERNEL);
> +       if (!ec_uart)
> +               return -ENOMEM;
> +
> +       ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
> +       if (!ec_dev)
> +               return -ENOMEM;
> +
> +       ec_uart->serdev = serdev;
> +
> +       /* Open the serial device */
> +       ret = devm_serdev_device_open(dev, ec_uart->serdev);
> +       if (ret) {
> +               dev_err(dev, "Unable to open UART device");
> +               return ret;
> +       }
> +
> +       serdev_device_set_drvdata(serdev, ec_dev);
> +
Unnecessary newline.
> +       serdev_device_set_client_ops(serdev, &cros_ec_uart_client_ops);
> +
> +       /* Initialize wait queue */
> +       init_waitqueue_head(&ec_uart->response.wait_queue);
> +
> +       ret = cros_ec_uart_acpi_probe(ec_uart);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to get ACPI info (%d)", ret);
> +               return ret;
> +       }
> +
> +       /* Set baud rate of serial device */
> +       ret = serdev_device_set_baudrate(serdev, ec_uart->baudrate);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to set up host baud rate (%d)", ret);
> +               return ret;
> +       }
> +
> +       /* Set flow control of serial device */
> +       serdev_device_set_flow_control(serdev, ec_uart->flowcontrol);
> +
> +       /* Initialize ec_dev for cros_ec  */
> +       ec_dev->phys_name = dev_name(dev);
> +       ec_dev->dev = dev;
> +       ec_dev->priv = ec_uart;
> +       ec_dev->irq = ec_uart->irq;
> +       ec_dev->cmd_xfer = NULL;
> +       ec_dev->pkt_xfer = cros_ec_uart_pkt_xfer;
> +       ec_dev->din_size = sizeof(struct ec_host_response) +
> +                          sizeof(struct ec_response_get_protocol_info);
> +       ec_dev->dout_size = sizeof(struct ec_host_request);
> +
> +       /* Register a new cros_ec device */
> +       return cros_ec_register(ec_dev);
> +}
> +
> +static void cros_ec_uart_remove(struct serdev_device *serdev)
> +{
> +       struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
> +
> +       cros_ec_unregister(ec_dev);
> +};
> +
> +static int __maybe_unused cros_ec_uart_suspend(struct device *dev)
> +{
> +       struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> +
> +       return cros_ec_suspend(ec_dev);
> +}
> +
> +static int __maybe_unused cros_ec_uart_resume(struct device *dev)
> +{
> +       struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> +
> +       return cros_ec_resume(ec_dev);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(cros_ec_uart_pm_ops, cros_ec_uart_suspend,
> +                        cros_ec_uart_resume);
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id cros_ec_uart_acpi_id[] = {
> +       { "GOOG0019", 0 },
> +       { /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, cros_ec_uart_acpi_id);
> +#endif
> +
> +static struct serdev_device_driver cros_ec_uart_driver = {
> +       .driver = {
> +               .name   = "cros-ec-uart",
> +               .acpi_match_table = ACPI_PTR(cros_ec_uart_acpi_id),
> +               .pm     = &cros_ec_uart_pm_ops,
> +       },
> +       .probe          = cros_ec_uart_probe,
> +       .remove         = cros_ec_uart_remove,
> +};
> +
> +module_serdev_device_driver(cros_ec_uart_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("UART interface for ChromeOS Embedded Controller");
> +MODULE_AUTHOR("Bhanu Prakash Maiya <bhanumaiya@chromium.org>");
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
>

Best regards,

[1] https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
[2]  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bdc48fa11e46f867ea4d75fa59ee87a7f48be144
[3] https://elixir.bootlin.com/linux/v6.1-rc7/source/include/linux/wait.h#L510
