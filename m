Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9697442D4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjF3TnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3TnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:43:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE6BA7;
        Fri, 30 Jun 2023 12:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6D43617F1;
        Fri, 30 Jun 2023 19:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE50C433C0;
        Fri, 30 Jun 2023 19:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688154199;
        bh=b0y+8nFzSPDkanVO/OW8i7+MJRn/8oHgRiArrnt1vpM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=IOCxhD1wkEAF0rXK5hmAEIOkoxz7RysWGgwjQMXXdUaLQcWXHr2LhUXFkZr4peWvf
         OgzrMi9Bq95swkvDc02K+CDXOl0wXx5MXAfSivD9C4/jIti7v8gGfKUucbQiNAr1AI
         qGL4EUP9YBm4hM7/4wzzITtmfa4qXKcUfeuQrfuzr3lZ9dgpan2k56CvUvJsE5pyZh
         rZEpH/Hgfdzagg7aJOXsfs30HyEoCtlMc4cwTlgtanEDLPJKcS3cj1CF/KOlQEmj1H
         DZpWyCx3sMpyH7d3jSnEj+iyJBXIj4E/hpdS/Odtqhi5AX9eVyJK0akfUNJQk6c23G
         V+e71QCdJqWtg==
Message-ID: <158f9975-afff-25b8-130c-2a8381ce21ee@kernel.org>
Date:   Fri, 30 Jun 2023 22:43:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXT] Re: [PATCH 1/1] usb: gadget: call usb_gadget_check_config()
 to verify UDC capability
Content-Language: en-US
To:     Frank Li <frank.li@nxp.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Jun Li <jun.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Prashanth K <quic_prashk@quicinc.com>,
        Peter Chen <peter.chen@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230628222437.3188441-1-Frank.Li@nxp.com>
 <42940cae-ce4f-577a-474b-f06b3b481e4e@kernel.org>
 <AM6PR04MB4838E7A9B41AB382DAAA35038825A@AM6PR04MB4838.eurprd04.prod.outlook.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <AM6PR04MB4838E7A9B41AB382DAAA35038825A@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/06/2023 06:40, Frank Li wrote:
> 
> 
>> -----Original Message-----
>> From: Roger Quadros <rogerq@kernel.org>
>> Sent: Wednesday, June 28, 2023 10:23 PM
>> To: Frank Li <frank.li@nxp.com>; r-gunasekaran@ti.com; imx@lists.linux.dev;
>> Jun Li <jun.li@nxp.com>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>; Elson Roy Serrao
>> <quic_eserrao@quicinc.com>; Thinh Nguyen
>> <Thinh.Nguyen@synopsys.com>; Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com>; Jó Ágila Bitsch <jgilab@gmail.com>;
>> Prashanth K <quic_prashk@quicinc.com>; Peter Chen
>> <peter.chen@kernel.org>; open list:USB SUBSYSTEM <linux-
>> usb@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
>> Subject: [EXT] Re: [PATCH 1/1] usb: gadget: call usb_gadget_check_config()
>> to verify UDC capability
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 29/06/2023 03:54, Frank Li wrote:
>>> The legacy gadget driver omitted calling usb_gadget_check_config()
>>> to ensure that the USB device controller (UDC) has adequate resources,
>>> including sufficient endpoint numbers and types, to support the given
>>> configuration.
>>>
>>> Previously, usb_add_config() was solely invoked by the legacy gadget
>>> driver. Adds the necessary usb_gadget_check_config() after the bind()
>>> operation to fix the issue.
>>
>> You have only fixed composite.c. Not all gadget drivers use composite.c
>> so it will be still broken for them.
>>
>> Please also add default sane configuration in CDNS3 so it works even
>> if usb_gadget_check_config() is not invoked.
> 
> Which one was not call usb_add_config()?
> DWC3 also use
>  .check_config		= dwc3_gadget_check_config, 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/gadget.c 

I meant gadget drivers not UDC drivers.

e.g.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/gadget/legacy/dbgp.c

> 
> I think it is not correct by assume UDC can support specific config
> at gadget function driver. 
> Add default value of CDNS3 actually hidden potential problem. 
> 
> I don't suggest it before fixed hidden potential problem. 
> 
> Frank  
> 
>>
>>>
>>> Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to
>> composite EP number")
>>> Reported-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>  drivers/usb/gadget/composite.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/usb/gadget/composite.c
>> b/drivers/usb/gadget/composite.c
>>> index 1b3489149e5e..dd9b90481b4c 100644
>>> --- a/drivers/usb/gadget/composite.c
>>> +++ b/drivers/usb/gadget/composite.c
>>> @@ -1125,6 +1125,10 @@ int usb_add_config(struct usb_composite_dev
>> *cdev,
>>>               goto done;
>>>
>>>       status = bind(config);
>>> +
>>> +     if (status == 0)
>>> +             status = usb_gadget_check_config(cdev->gadget);
>>> +
>>>       if (status < 0) {
>>>               while (!list_empty(&config->functions)) {
>>>                       struct usb_function             *f;
>>
>> --
>> cheers,
>> -roger

-- 
cheers,
-roger
