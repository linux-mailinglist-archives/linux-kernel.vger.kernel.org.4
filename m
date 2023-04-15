Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDDA6E2F30
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 07:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDOFjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 01:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDOFja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 01:39:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B0F55B4;
        Fri, 14 Apr 2023 22:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD85461DA2;
        Sat, 15 Apr 2023 05:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC8BC433D2;
        Sat, 15 Apr 2023 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681537168;
        bh=sgqkra4Gl7AEFkkAJD6KZbCVVWw5Ls3bOzVoxaPUYvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmk1QDXOKGjBY0T2+F1Q0RNrD2CkZhgopDBDxA+5qOo6Tkeg6L7xcJMjZBPE0Fg5Q
         PecKJFwxwhVKxdk0DkkXG0Nj19rX7tI0Nu4hV7lQfT7z2dg+wASQpAuS4LW69Oqe1E
         ku5O4zQlD2JFGgMvATYQRbgLf0T7KA0octmvdJ2c=
Date:   Sat, 15 Apr 2023 07:39:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V1 2/3] drivers: misc: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Message-ID: <ZDo4jIIV7cfPD2qW@kroah.com>
References: <cover.1681480351.git.quic_schowdhu@quicinc.com>
 <b1a9cbbcfefe133cc9047a71a2acdaa74239df29.1681480351.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a9cbbcfefe133cc9047a71a2acdaa74239df29.1681480351.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 07:29:12PM +0530, Souradeep Chowdhury wrote:
> The DCC is a DMA Engine designed to capture and store data
> during system crash or software triggers. The DCC operates
> based on user inputs via the debugfs interface. The user gives
> addresses as inputs and these addresses are stored in the
> dcc sram. In case of a system crash or a manual software
> trigger by the user through the debugfs interface,
> the dcc captures and stores the values at these addresses.
> This patch contains the driver which has all the methods
> pertaining to the debugfs interface, auxiliary functions to
> support all the four fundamental operations of dcc namely
> read, write, read/modify/write and loop. The probe method
> here instantiates all the resources necessary for dcc to
> operate mainly the dedicated dcc sram where it stores the
> values. The DCC driver can be used for debugging purposes
> without going for a reboot since it can perform software
> triggers as well based on user inputs.

You have 72 columns, why not use them all please?

> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.

It is now 2023 :)




> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#define STATUS_READY_TIMEOUT		5000  /* microseconds */
> +
> +#define DCC_SRAM_NODE "dcc_sram"

You only use this once, why is a #define needed?

> +static void dcc_create_debug_dir(struct dcc_drvdata *drvdata)
> +{
> +	int i;
> +	char list_num[10];
> +	struct dentry *list;
> +	struct device *dev = drvdata->dev;
> +
> +	drvdata->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);

You are creating a directory at the root of debugfs with just your
device name?  While that will work, that feels very odd.  Please use a
subdirectory.

> +	if (IS_ERR(drvdata->dbg_dir)) {
> +		pr_err("can't create debugfs dir\n");

There is no need to ever check the return value of a debugfs call.

Nor do you really ever even need to save off the dentry here, just look
it up when you need to remove it.

> +		return;
> +	}
> +
> +	for (i = 0; i <= drvdata->nr_link_list; i++) {
> +		sprintf(list_num, "%d", i);
> +		list = debugfs_create_dir(list_num, drvdata->dbg_dir);
> +		debugfs_create_file("enable", 0600, list, drvdata, &enable_fops);
> +		debugfs_create_file("config", 0600, list, drvdata, &config_fops);
> +	}
> +
> +	debugfs_create_file("trigger", 0200, drvdata->dbg_dir, drvdata, &trigger_fops);
> +	debugfs_create_file("ready", 0400, drvdata->dbg_dir, drvdata, &ready_fops);
> +	debugfs_create_file("config_reset", 0200, drvdata->dbg_dir,
> +			    drvdata, &config_reset_fops);

This really looks like you are using debugfs to control the device, not
just for debugging information.  How are you going to be able to use the
device in a system that has debugfs disabled?

thanks,

greg k-h
