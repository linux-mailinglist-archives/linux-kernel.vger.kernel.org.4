Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D826B8E90
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjCNJXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCNJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:23:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C25350F9D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06208B816DA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A20C4339C;
        Tue, 14 Mar 2023 09:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678785770;
        bh=dlm/nxuSKTp43OoyQoRKTCpUnmzgoQkE2Ux5U5sBaTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5fUznEVs34JDctK6qUKPKEL53HEAsq/y0mZvGNuE4QDJmAg1kGc4RvKrFXTj6AxF
         n+BE/RvSwq34y23QwpUUPjyjdIjdIY9bTNj3RpvgJc9yOW+IlcUyvmF5/KwV8s3f4G
         2kHqq7fvxxEzCGtd9MbWTcV+e0GEeF1XzxiEgmvY=
Date:   Tue, 14 Mar 2023 10:22:48 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Noah (Wensheng) Wang" <Noah.Wang@monolithicpower.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luke (Lijie) Jiang" <Luke.Jiang@monolithicpower.com>,
        pebble liang <pebble.liang@monolithicpower.com>,
        "Eva (Ting) Ma" <Eva.Ma@monolithicpower.com>
Subject: Re: [PATCH] char: add driver for mps VR controller mp2891
Message-ID: <ZBA86BAVMWGiS39s@kroah.com>
References: <08e7bd6ed16f4bde95b674db940783ec@monolithicpower.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08e7bd6ed16f4bde95b674db940783ec@monolithicpower.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 09:18:50AM +0000, Noah (Wensheng) Wang wrote:
> Hi Arnd, Grey:
> Thanks for the review.
> 
> This driver will be used by facebook. This driver provide a device node for userspace to get output voltage, input voltage, input current, input power, output power and temperature of mp2891 controller through I2C. This driver determine what kind of value the userspace wants through the mp2891_write interface and return the corresponding value when the interface mp2891_read is called.

Note, can you please take a look at the kernel documentation for how to
write a good changelog text when you resubmit this?

> 
> Signed-off-by: Noah Wang <Noah.Wang@monolithicpower.com>
> ---
>  drivers/char/mp2891.c | 403 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 403 insertions(+)
>  create mode 100644 drivers/char/mp2891.c

You didn't add the driver to the build, so it can not actually be used
at all.  How did you test this?

> 
> diff --git a/drivers/char/mp2891.c b/drivers/char/mp2891.c new file mode 100644 index 000000000000..84529b73f065
> --- /dev/null
> +++ b/drivers/char/mp2891.c
> @@ -0,0 +1,403 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Are you _sure_ you mean "or later"?  (I have to ask)

> +/*
> + * Driver for MPS Multi-phase Digital VR Controllers(MP2891)
> + *
> + * Copyright (C) 2023 MPS
> + */
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/ide.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/gpio.h>
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/semaphore.h>
> +#include <linux/timer.h>
> +#include <linux/i2c.h>
> +#include <linux/uaccess.h>
> +#include <linux/io.h>
> +#include <asm/mach/map.h>
> +
> +#define PMBUS_PAGE              0x00
> +#define MFR_VOUT_LOOP_CTRL_R1   0xBD
> +#define MFR_VOUT_LOOP_CTRL_R2   0xBD
> +
> +#define VID_STEP_POS            14
> +#define VID_STEP_MSK            (0x3 << VID_STEP_POS)
> +
> +#define READ_VIN                0x88
> +#define READ_VOUT               0x8B
> +#define READ_IOUT               0x8C
> +#define READ_TEMPERATURE        0x8D
> +#define READ_PIN_EST_PMBUS_R1   0x94
> +#define READ_PIN_EST_PMBUS_R2   0x94
> +#define READ_POUT_PMBUS_R1      0x96
> +#define READ_POUT_PMBUS_R2      0x96
> +
> +#define MP2891_PAGE_NUM			2
> +
> +#define MP2891_CNT 1
> +#define MP2891_NAME "mp2891"
> +
> +#define IOUT_PAGE0          "IOUT-0"
> +#define IOUT_PAGE1          "IOUT-1"
> +#define VOUT_PAGE0          "VOUT-0"
> +#define VOUT_PAGE1          "VOUT-1"
> +#define TEMPERATURE_PAGE0   "TEMPERATURE-0"
> +#define TEMPERATURE_PAGE1   "TEMPERATURE-1"
> +#define VIN_PAGE0           "VIN-0"
> +#define PIN_EST_PAGE0		"PIN_EST-0"
> +#define PIN_EST_PAGE1		"PIN_EST-1"
> +#define POUT_PAGE0          "POUT-0"
> +#define POUT_PAGE1          "POUT-1"
> +
> +struct mp2891_data {
> +	int vid_step[MP2891_PAGE_NUM];
> +};
> +
> +struct mp2891_dev {
> +	dev_t devid;
> +	struct cdev cdev;
> +	struct class *class;
> +	struct device *device;
> +	int major;
> +	char read_flag[20];
> +	struct i2c_client *client;
> +	struct mp2891_data *data;
> +};
> +
> +struct mp2891_dev mp2891cdev;

You really do not want to do this, the driver should be able to handle
any number of devices in the system, not just one.  Also, this is a
dynamic structure that you just made static, which is going to be
interesting when it comes to properly memory lifetime rules, right?

> +
> +static int read_word_data(struct i2c_client *client, int page, int reg) 

Always run scripts/checkpatch.pl on your code before submitting it so
you don't get grumpy reviewers asking why you didn't run
scripts/checkpatch.pl on your code before submitting it.

thanks,

greg k-h
