Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D596E3F93
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjDQGSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjDQGSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2663594;
        Sun, 16 Apr 2023 23:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F9B061E55;
        Mon, 17 Apr 2023 06:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD6BC433D2;
        Mon, 17 Apr 2023 06:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681712275;
        bh=Y8TxkwBypVbfJfqk9Zx8zrG1eLvILNU8x7E3DpCb4nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WG5vVYDnZacNXITU37Ny/Se1syqBe8WxtL5YEOC2+vtM3aMQ9hxA1U3wiOCLiS9a7
         PMsd+YFj2CLbJD6vErPCqveZP0d5Plui3DKftHcoVEqNvTKRcQrhGouX8UmJq1l8zA
         NuOq5s6qDWOaUNOZ4oxtDiAoXIodEYgffF+EPGuo=
Date:   Mon, 17 Apr 2023 08:17:52 +0200
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
Message-ID: <ZDzkkNQP5eO2vcxA@kroah.com>
References: <cover.1681480351.git.quic_schowdhu@quicinc.com>
 <b1a9cbbcfefe133cc9047a71a2acdaa74239df29.1681480351.git.quic_schowdhu@quicinc.com>
 <ZDo4jIIV7cfPD2qW@kroah.com>
 <f3196d7a-50f0-9bfb-71a6-47ddb9686039@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3196d7a-50f0-9bfb-71a6-47ddb9686039@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:31:46AM +0530, Souradeep Chowdhury wrote:
> 
> 
> On 4/15/2023 11:09 AM, Greg Kroah-Hartman wrote:
> > On Fri, Apr 14, 2023 at 07:29:12PM +0530, Souradeep Chowdhury wrote:
> > > The DCC is a DMA Engine designed to capture and store data
> > > during system crash or software triggers. The DCC operates
> > > based on user inputs via the debugfs interface. The user gives
> > > addresses as inputs and these addresses are stored in the
> > > dcc sram. In case of a system crash or a manual software
> > > trigger by the user through the debugfs interface,
> > > the dcc captures and stores the values at these addresses.
> > > This patch contains the driver which has all the methods
> > > pertaining to the debugfs interface, auxiliary functions to
> > > support all the four fundamental operations of dcc namely
> > > read, write, read/modify/write and loop. The probe method
> > > here instantiates all the resources necessary for dcc to
> > > operate mainly the dedicated dcc sram where it stores the
> > > values. The DCC driver can be used for debugging purposes
> > > without going for a reboot since it can perform software
> > > triggers as well based on user inputs.
> > 
> > You have 72 columns, why not use them all please?
> > 
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2015-2021, The Linux Foundation. All rights reserved.
> > > + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> > 
> > It is now 2023 :)
> 
> Ack
> 
> > 
> > 
> > 
> > 
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bitops.h>
> > > +#include <linux/debugfs.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/io.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/miscdevice.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/uaccess.h>
> > > +
> > > +#define STATUS_READY_TIMEOUT		5000  /* microseconds */
> > > +
> > > +#define DCC_SRAM_NODE "dcc_sram"
> > 
> > You only use this once, why is a #define needed?
> 
> This is as per the comment on version 1 of the patch series on DCC
> 
> https://lore.kernel.org/linux-arm-kernel/YElUCaBUOx7hEuIh@builder.lan/
> 
> "kzalloc + strlcpy can be replaced by kstrdup(), but that said...all this
> does seems to be to copy a const string to the heap and lugging it
> around. Use a define instead."

But as you are not doing any of that here, just using the string in the
one place it is needed is the same thing :)

> > > +static void dcc_create_debug_dir(struct dcc_drvdata *drvdata)
> > > +{
> > > +	int i;
> > > +	char list_num[10];
> > > +	struct dentry *list;
> > > +	struct device *dev = drvdata->dev;
> > > +
> > > +	drvdata->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);
> > 
> > You are creating a directory at the root of debugfs with just your
> > device name?  While that will work, that feels very odd.  Please use a
> > subdirectory.
> 
> This is as per the comment on v17 of the patch series on DCC
> 
> https://lore.kernel.org/linux-arm-kernel/6693993c-bd81-c974-a903-52a62bfec606@ieee.org/
> 
> "You never remove this dcc_dbg directory.  Why not?
> 
> And since you don't, dcc_dbg could just be a local
> variable here rather than being a global.  But it
> seems to me this is the root directory you want to
> remove when you're done."

But that's not the issue.  The issue is that you are putting into
/sys/kernel/debug/ a flat namespace of all of your devices.  Is that
really what you want?  If so, why do you think this will never conflict
with any other device in the system?

> > > +	if (IS_ERR(drvdata->dbg_dir)) {
> > > +		pr_err("can't create debugfs dir\n");
> > 
> > There is no need to ever check the return value of a debugfs call.
> > 
> > Nor do you really ever even need to save off the dentry here, just look
> > it up when you need to remove it.
> 
> Ack
> 
> > 
> > > +		return;
> > > +	}
> > > +
> > > +	for (i = 0; i <= drvdata->nr_link_list; i++) {
> > > +		sprintf(list_num, "%d", i);
> > > +		list = debugfs_create_dir(list_num, drvdata->dbg_dir);
> > > +		debugfs_create_file("enable", 0600, list, drvdata, &enable_fops);
> > > +		debugfs_create_file("config", 0600, list, drvdata, &config_fops);
> > > +	}
> > > +
> > > +	debugfs_create_file("trigger", 0200, drvdata->dbg_dir, drvdata, &trigger_fops);
> > > +	debugfs_create_file("ready", 0400, drvdata->dbg_dir, drvdata, &ready_fops);
> > > +	debugfs_create_file("config_reset", 0200, drvdata->dbg_dir,
> > > +			    drvdata, &config_reset_fops);
> > 
> > This really looks like you are using debugfs to control the device, not
> > just for debugging information.  How are you going to be able to use the
> > device in a system that has debugfs disabled?
> 
> As per upstream discussions it was decided that debugfs will be a suitable
> interface for DCC. More on this in the following link:-
> 
> https://lore.kernel.org/linux-arm-kernel/20221228172825.r32vpphbdulaldvv@builder.lan/

debugfs is not a suitable interface for anything that is "real" as
that's not what it is there for.  Most systems disable debugfs entirely
(i.e. Android), or prevent any normal user from accessing it, so this
api you are creating will not be able to be used by anyone.

debugfs is for debugging, not for anything that the system functionality
relies on to work properly.

Also, that was a v21 of the patch series, why did the numbering start
over here at v1?

thanks,

greg k-h
