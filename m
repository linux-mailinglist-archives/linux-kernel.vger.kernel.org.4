Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F87614ECE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 17:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiKAQGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 12:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:06:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371EE1571D;
        Tue,  1 Nov 2022 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667318809; x=1698854809;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MayWlSqqoHM0+wU0rV8BWk4tRrFd6ej2gtNp75/u7+4=;
  b=I8I/girk6cKqgnvjHfcZfIE6DEfTK4qX3Lv2KSvFIcnyawa0uqdxmNqi
   eBLyblNJzj101uHA0L1PupsJHBwcEimUon+XewA/8WJFumt30M0CK2z76
   DhtHcCRSjg4Tx06itMFreTXwc//wseED0G4zIEQJOIFt9EEqStoAZ3GLe
   gFtowvcAZWkU0LJYz33QrcMVgkXgYUxhJlpTBaPvW+IjZf5xmLPzUDd+6
   S7k3EdOC6mkMB3ObJqQS8ic5UQjE6dPbWQymyUwnUvsdukoiQRA3KqR8X
   kzJOPqvd0OzlZONOLOn7ahuCtEefF7cooNGRXbucHMuxBpsCXA6RmU2pb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="307896805"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="307896805"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 09:06:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="636445570"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="636445570"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 09:06:42 -0700
Date:   Tue, 1 Nov 2022 09:04:39 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Xu Yilun <yilun.xu@intel.com>
cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v4 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <Y2B6kAnd+m3ftWRf@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2211010843110.2746019@rhweight-WRK1>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com> <20221020212610.697729-5-matthew.gerlach@linux.intel.com> <Y11FmiDeVhGir+7z@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2210311719460.2680729@rhweight-WRK1>
 <Y2B6kAnd+m3ftWRf@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Nov 2022, Xu Yilun wrote:

> On 2022-10-31 at 17:34:39 -0700, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Sat, 29 Oct 2022, Xu Yilun wrote:
>>
>>> On 2022-10-20 at 14:26:10 -0700, matthew.gerlach@linux.intel.com wrote:
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>
>>>> Add a Device Feature List (DFL) bus driver for the Altera
>>>> 16550 implementation of UART.
>>>>
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> ---
>>>> v4: use dev_err_probe() everywhere that is appropriate
>>>>     clean up noise
>>>>     change error messages to use the word, unsupported
>>>>     tried again to sort Makefile and KConfig better
>>>>     reorder probe function for easier error handling
>>>>     use new dfh_find_param API
>>>>
>>>> v3: use passed in location of registers
>>>>     use cleaned up functions for parsing parameters
>>>>
>>>> v2: clean up error messages
>>>>     alphabetize header files
>>>>     fix 'missing prototype' error by making function static
>>>>     tried to sort Makefile and Kconfig better
>>>> ---
>>>>  drivers/tty/serial/8250/8250_dfl.c | 149 +++++++++++++++++++++++++++++
>>>>  drivers/tty/serial/8250/Kconfig    |  12 +++
>>>>  drivers/tty/serial/8250/Makefile   |   1 +
>>>>  3 files changed, 162 insertions(+)
>>>>  create mode 100644 drivers/tty/serial/8250/8250_dfl.c
>>>>
>>>> diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
>>>> new file mode 100644
>>>> index 000000000000..f02f0ba2a565
>>>> --- /dev/null
>>>> +++ b/drivers/tty/serial/8250/8250_dfl.c
>>>> @@ -0,0 +1,149 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Driver for FPGA UART
>>>> + *
>>>> + * Copyright (C) 2022 Intel Corporation, Inc.
>>>> + *
>>>> + * Authors:
>>>> + *   Ananda Ravuri <ananda.ravuri@intel.com>
>>>> + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> + */
>>>> +
>>>> +#include <linux/bitfield.h>
>>>> +#include <linux/dfl.h>
>>>> +#include <linux/io-64-nonatomic-lo-hi.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/serial.h>
>>>> +#include <linux/serial_8250.h>
>>>> +
>>>> +struct dfl_uart {
>>>> +	int line;
>>>> +};
>>>> +
>>>> +static int dfl_uart_get_params(struct dfl_device *dfl_dev, struct uart_8250_port *uart)
>>>> +{
>>>> +	struct device *dev = &dfl_dev->dev;
>>>> +	u64 v, fifo_len, reg_width;
>>>> +	u64 *p;
>>>> +
>>>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ);
>>>> +	if (!p)
>>>> +		return dev_err_probe(dev, -EINVAL, "missing CLK_FRQ param\n");
>>>> +
>>>> +	uart->port.uartclk = *p;
>>>> +	dev_dbg(dev, "UART_CLK_ID %u Hz\n", uart->port.uartclk);
>>>> +
>>>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_FIFO_LEN);
>>>> +	if (!p)
>>>> +		return dev_err_probe(dev, -EINVAL, "missing FIFO_LEN param\n");
>>>> +
>>>> +	fifo_len = *p;
>>>> +	dev_dbg(dev, "UART_FIFO_ID fifo_len %llu\n", fifo_len);
>>>> +
>>>> +	switch (fifo_len) {
>>>> +	case 32:
>>>> +		uart->port.type = PORT_ALTR_16550_F32;
>>>> +		break;
>>>> +
>>>> +	case 64:
>>>> +		uart->port.type = PORT_ALTR_16550_F64;
>>>> +		break;
>>>> +
>>>> +	case 128:
>>>> +		uart->port.type = PORT_ALTR_16550_F128;
>>>> +		break;
>>>> +
>>>> +	default:
>>>> +		return dev_err_probe(dev, -EINVAL, "unsupported fifo_len %llu\n", fifo_len);
>>>> +	}
>>>> +
>>>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_REG_LAYOUT);
>>>> +	if (!p)
>>>> +		return dev_err_probe(dev, -EINVAL, "missing REG_LAYOUT param\n");
>>>> +
>>>> +	v = *p;
>>>> +	uart->port.regshift = FIELD_GET(DFHv1_PARAM_ID_REG_SHIFT, v);
>>>> +	reg_width = FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v);
>>>
>>> I have concern that the raw layout inside the parameter block is
>>> still exposed to drivers and need to be parsed by each driver.
>>
>> Raw parameter block will always have to be passed to the driver because HW
>> specific properties can be defined that will need to be parsed by the
>> specific driver.
>
> So there is a question about the scope of the definitions of these parameter
> blocks. MSIX seems globally used across all dfl devices. REG_LAYOUT
> seems specific to uart?

There are definitely two classes of parameter blocks.  One class is HW 
agnostic parameters where the parameters are relevant to many different 
kinds of HW components.  MSI-X, and input clock-frequency are certainly HW 
agnostic, and it turns out that REG_LAYOUT is not specific to uart.  You 
can see reg_bits and reg_stride in struct regmap_config.  There are also 
device tree bindings for reg-shift and reg-io-width.  The second class of 
parameters would be specific to HW component.  In the case of this uart 
driver, all parameters would be considered HW agnostic parameters.

>
> If a parameter block is widely used in dfl drivers, duplicate the parsing
> from HW layout in each driver may not be a good idea. While for device
> specific parameter block, it's OK.

It sounds like we are in agreement.

>
> Another concern is the indexing of the parameter IDs. If some parameter
> blocks should be device specific, then no need to have globally indexed
> parameter IDs. Index them locally in device is OK. So put the definitions
> of ID values, HW layout and their parsing operation in each driver.

It may be confusing for two drivers to use the same parameter id that have 
different meanings and data layout.  Since all the parameters for this 
driver would be considered HW agnostic, we'd don't need to address this 
issue with this patchset.

>
> Thanks,
> Yilun
>
>>
>>>
>>> How about we define HW agnostic IDs for parameter specific fields like:
>>>
>>> PARAM_ID		FIELD_ID
>>> ================================
>>> MSIX			STARTV
>>> 			NUMV
>>> --------------------------------
>>> CLK			FREQ
>>> --------------------------------
>>> FIFO			LEN
>>> --------------------------------
>>> REG_LAYOUT		WIDTH
>>> 			SHIFT
>>>
>>> And define like u64 dfl_find_param(struct dfl_device *, int param_id, int field_id)
>>
>> I don't think dfl_find_param as defined above adds much value.
>>
>>>
>>> Think further, if we have to define HW agnostic property - value pairs,
>>> why don't we just use "Software nodes for the firmware node", see
>>> drivers/base/swnode.c. I think this may be a better choice.
>>
>> I am looking into "Software nodes for the firmware node", and it can be used
>> for HW agnostic properties.  Each dfl driver will still have to make a
>> function call to fetch each HW agnostice property value as well as a
>> function call to find the HW specific parameters and then parse those
>> parameters.
>>
>>>
>>> Thanks,
>>> Yilun
>>>
>
